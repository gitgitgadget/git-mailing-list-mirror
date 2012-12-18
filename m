From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 08:09:35 -0800
Message-ID: <7vehinibpc.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkzjz-0001dH-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207Ab2LRQJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 11:09:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932149Ab2LRQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:09:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1483692EE;
	Tue, 18 Dec 2012 11:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+xxMTYi8zOfc20gdjYPsLIMeWg=; b=NO00J/
	xWx+zL9X55NVlKZUQqbm1Jti7YMhTYnjUcEVNWH25L/aw+9qdcEAg+mFCxPvK+9/
	VyiLbgI9VPzjEkVk0ZXTJJx/iltqQIbmDH7DHBB+PC2Jm9Pi+D8NI8eq6gdQgz4d
	1sbfJuFEOIRR/t34+QlNu1J8S5S/InOGbuRqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hc7AtJ9GfQqeR/HOU44475tB9cStDsI2
	4vrZPOYQm+BGvjfIeJWh38h17C1gvc/DxBF/0IKxhAbEV+tDf1jKDg6Fnx6ilnm0
	Io8HDfjpyUpmTT+ZJsMK/i587qaBL3VqroT6zF3HtBGIRu75K73aV7omUyzBtXWh
	1hAD2QqNenk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED55692ED;
	Tue, 18 Dec 2012 11:09:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAD7692E7; Tue, 18 Dec 2012
 11:09:37 -0500 (EST)
In-Reply-To: <20121218120058.0c558ba5@chalon.bertin.fr> (Yann Dirson's
 message of "Tue, 18 Dec 2012 12:00:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 526E6624-492D-11E2-95D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211756>

Yann Dirson <dirson@bertin.fr> writes:

> On Mon, 17 Dec 2012 13:14:56 -0800
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>> 
>> > Christian Couder <christian.couder@gmail.com> writes:
>> >
>> >> Yeah, at one point I wanted to have a command that created to craft a
>> >> new commit based on an existing one.
>> >
>> > This isn't hard to do, you only have to resort to plumbing:
>> >
>> > $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
>> > bb45cc6356eac6c7fa432965090045306dab7026
>> 
>> Good.  I do not think an extra special-purpose command is welcome
>> here.
>
> Well, I'm not sure this is intuitive enough to be useful to the average user :)

I do not understand why you even want to go in the harder route in
the first place, only to complicate things?

All you want to do is to craft a commit object that records a
specific tree shape, has a set of parents you want, and has the log
information you want.  Once you have the commit, you can replace an
unwanted commit with it.

    ----A----B----o---- ....

           X----Y----Z---- ....

Suppose you want to pretend that X is a child of A, even though it
is not in the real life.  So you want to create a commit that 

    - has the same tree as X;
    - has A as its parent; and
    - records log and authorship of X.

and then use "git replace" to replace X, right?  How about doing it
this way?

    $ git checkout X^0 ;# detach
    $ git reset --soft A
    $ git commit -C X

The first gives you the index and the working tree that is the same
as X, the second moves HEAD while keeping the index and the working
tree so that the commit you create will be a child of A, and the
last makes that commit with the metainformation from X [*1*].  If
you want, you can even tweak the contents of the tree before making
the commit in the final step, or tweak the log message during the
final step.

Then you can take the resulting commit and replace X with it, no?

Alternatively, you can do:

    $ git checkout X^0 ;# detach
    $ git reset --soft B
    $ git commit --amend -C X

that is, find an existing commit B that has the desired set of
parents, and amend it with the same tree and the metainformation as
X.  This would even work when you want to come up with a commit that
replaces a merge.  For example, if you want to pretend that B were a
merge between A and X in the above topology, you could

    $ git checkout -b temp A
    $ git merge -s ours X ;# the recorded tree does not matter
    $ git checkout B^0 ;# detach
    $ git reset --soft temp
    $ git commit --amend -c B

which would create one merge that has the desired set of parents
(i.e. A and X) in the first two steps on temp branch, prepares the
index and the working tree to match the tree of B, and with that
tree and the metainformation from B, amends that merge.  The
resulting commit will be a merge between A and X that has the tree
of B and metainformation of B (with a chance to edit it further, as
I used -c there).

Is this not intuitive enough?


[Footnote]

*1* If you are not tweaking the tree contents, you can do this
all in the index without affecting the working tree, e.g.

    $ git checkout HEAD^0 ;# totally random state unrelated to X nor A
    $ git read-tree X ;# just update the index to match tree of X
    $ git reset --soft A ;# next commit will be child of A
    $ git commit -C X ;# and with metainformation from X

After you are done, you can "read-tree $branch" followed by
"checkout $branch" to come back to where you were.
