From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 16:21:01 -0800
Message-ID: <7v4om0pjwy.fsf@alter.siamese.dyndns.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org> <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6WA-0007al-7l
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab0BBAVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:21:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0BBAVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:21:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4765796677;
	Mon,  1 Feb 2010 19:21:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hl09KjyfHZU5y7Oca+r8ZLka4Tc=; b=NFsArU
	HsMsBCxJGOmWzdm7G+BLhIygC/EaF9u0bObBulDzwfL2tR6e34qYK0bD94kWKQF1
	K/C7hdlxWzEf9PcydVFfb7jgo5KWjEJB7vS1PObzGDNtwowuf/na6lUlNP34gVSW
	ShpxfSr67z+SkH1dQPBt/JmlM2BNZM4N8vVto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROswKNv2DsKaacNCq7nIkVvLijk/N9gZ
	TP0Dm7UvoM26K4Mmr3cNK6WsBUGj63/3TawdSwv7ACz/M6kR+EE3CMHQ1sA/sI1h
	9jrHNuX0iF6TVtjFWB3CoVodwZ7cUmLpdIDNryh2I4k2d0RaXva+fv24B90l4b68
	DrTOveGPVfY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 221EA96676;
	Mon,  1 Feb 2010 19:21:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86AA396675; Mon,  1 Feb
 2010 19:21:07 -0500 (EST)
In-Reply-To: <ron1-6F8B85.14520801022010@news.gmane.org> (Ron Garret's
 message of "Mon\, 01 Feb 2010 14\:52\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE253A6E-0F90-11DF-A0B9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138663>

Ron Garret <ron1@flownet.com> writes:

>> For my rather fresh eye it looks more like unnamed (anonymous?) branch
>> than a temporary one. Doesn't detached HEAD behave exactly like a
>> regular HEAD but pointing to the tip of an unnamed branch?
>
> I strongly concur with this.
>
> And as long as I'm weighing in, it would also help to prevent confusion 
> if it were made clear that this unnamed branch doesn't actually come 
> into existence unless and until you do a commit.

After re-reading this three times, I actually cannot tell which one you
think is the confused misconception: (1) unnamed branch does not exist
until you commit, or (2) unnamed branch does exist immediately you
detach.

Let's say you have this history:

    ---A---B HEAD == master

When drawing commit ancestry in ASCII art, uppercase letters in the
drawing denote commits.  Time flows from left to right and we don't write
arrows to show B is a child of A.  On the right, above or below commit, we
also write refs (i.e. tags, branches and HEAD).  When we say "HEAD ==
master", we mean HEAD is a symref to master ref (if we really want to be
anal, 'refs/heads/master' might be more technically correct but most often
it is clear from the context).

So by the above picture, we mean "There is a history that ends with B,
whose parent is A and it came from somewhere.  'master' branch points at B
and HEAD symref points at 'master' so that is the current branch".

Here is what happens when you make changes and "git commit" it.

(0) Normal case.

    ---A---B---C HEAD == master

    The new state is recorded as a tree, a new commit C is created to wrap
    that tree, C is made a child of B (because HEAD pointed at it), and
    finally, master is moved to point at that commit C (because HEAD
    pointed at 'master').

Notice that two "HEAD pointed at" mean slightly different things in the
above sentence.  In the former context of determining the commit to become
the parent of a new commit, we want commit, and "evaluating HEAD by
checking at what it points at" wants to return commit, so even though
technically HEAD at this point would be:

    $ cat .git/HEAD
    ref: refs/heads/master"

IOW, it points at 'master' branch, we look beyond it and talk about the
commit that is pointed at refs/heads/master.

In the latter, we want to determine if there is a branch we would
want to update to point at the newly created commit, so we look at
HEAD and notice it points at refs/heads/master.  We update it,
instead of storing the value of C directly in HEAD.

Now, "git checkout master^0" would do this:

    ---A---B---C HEAD (detached)
                 master

There are two pointers.

    $ cat .git/HEAD
    562d53fa69933b3ade2691b99cbe67722313f43c
    $ cat .git/refs/heads/master
    562d53fa69933b3ade2691b99cbe67722313f43c

They point at the same commit C (let's pretend 562d53... is C).

You make changes and create a commit.  What happens?

(1) A new tree is created and wrapped in a new commit D, whose parent is
    C.

                 D    we have not updated
                /     any ref yet
    ---A---B---C

    We used the fact that HEAD points at C (in the first "what commit is
    pointed?" sense) to determine the parent of D.

(2) We decide what pointer to move to point at this commit.  HEAD does not
    point at any branch (it directly pointed at commit C), so we do not
    move any named branch, but move only HEAD.  The end result is:

                 D HEAD (detached)
                /
    ---A---B---C master

    Now you then do "git checkout -b side".  What happens?

(3) We create a new branch "side" at the commit HEAD points at (we could
    have said "git checkout -b side HEAD"), and make HEAD point at that
    branch.

                 D HEAD == side
                /
    ---A---B---C master


Now, when we say "branch", we do not mean the "line" between C and D.
"master" branch is not a line before A, between A and B and between B and
C concatenated together.  "master branch" in git simply points at C in the
above graph.

Especailly, there is no special "master"-ness to the line between B and C.
B can be reached from both 'master' and 'side' branches.  A corollary is
that a line between C and D does not have any special 'side'-ness either,
as later you can fork other branches from D.

Similarly, in picture (2) where HEAD is still detached, there is no
special 'HEAD'-ness to the line between C and D.

Similarly in the picture where you had HEAD that was detached that pointed
at C:

    ---A---B---C HEAD (detached)

there is no HEAD-ness in any of the line segment depicted.  The same goes
for all the lines depicted in picture (2); between these two pictures, the
only change made was a commit on the detached HEAD.  From the perspective
of "branches", there is no change.

Calling detached HEAD as "temporary" or "anonymous" branch is fine, but
then we should consider the state immediately after detaching the HEAD
equally valid "anonymous" branch as in picture (2).

Putting it in another way, a branch in git is _not_ the name given to line
segments that _led_ to the point the branch points at (i.e. past history).
Think of a branch as the point where your next commit advances from
(i.e. future history).
