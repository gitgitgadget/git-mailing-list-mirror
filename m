From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 20:28:56 -0700
Message-ID: <7vfx9modqf.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
 <20091013220640.GB12603@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
 <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 05:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxubL-0001Jr-L4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 05:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbZJNDaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 23:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbZJNDaE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 23:30:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZJNDaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 23:30:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D672576FB2;
	Tue, 13 Oct 2009 23:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzbojIa4gY6Z3yzkBwKbYmULsKE=; b=txrg1r
	8oAVoI679e1arKJpbqbgH3j7ZrMhshZgsvqyCnOIPLtkQyUyQZb7QeFdUqo8c/XU
	ngzvP/2EX9M00qikkpuwGY81L5f4CM3lbcgc/THQ58TCEyY0wHG6tTSspEhCkV2A
	lGxtrlyCfLDqiY76vqXzI2syY1wAe0sKXB/kY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHGoiqrJL5v8EoRTsaMlPqWQldOpzUHR
	DtqXTZSnaRmJB3HQjPRKgnh7qfRHxtCtO7IuazfSqo6MxImrzOF8MeRSxwtVd/U2
	H7RqGxzoeehk0d9xmM5hYVQhjSR4oIW6TpMGGhwYcEzH8qtqnowKfZJI78spx18m
	hHKQo0gVedA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EBB376FAD;
	Tue, 13 Oct 2009 23:29:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C176676FAC; Tue, 13 Oct 2009
 23:28:57 -0400 (EDT)
In-Reply-To: <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com>
 (Jay Soffian's message of "Tue\, 13 Oct 2009 21\:05\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCA3F072-B871-11DE-BFE2-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130238>

Jay Soffian <jaysoffian@gmail.com> writes:

> This doesn't help with the original problem, which was that a user
> attempted to checkout refs/remotes/origin/<name> by just saying 'git
> checkout <name>' which I happen to think should work. A lot of what I
> keep hearing in this thread seems to be in the vein of the perfect
> being the enemy of the good.

I do not think there is "perfect" nor "good" anywhere in this.  It is just
the proposals were either not well thought out, were not presented well,
or were misunderstood, or a bit of all.

When you do not have local "frotz" branch, and do have cloned/fetched from
the origin that has "frotz" branch, I am actually Ok with this

    $ git checkout frotz [--]

to do an equivalent of:

    $ git checkout -t -b frotz origin/frotz

I do not have problem with this _particular_ DWIMmery.  It will not break
people's expectations, other than "asking to check out non-existing ref
should fail".  That expectation might be logical, but I do not think it is
useful.

Another reason I won't have problem with this one is that perhaps after
creating a few more commits, the next day when the user does the same

    $ git checkout frotz

what will be shown is the _local_ frotz branch.  Nowhere in this sequence
there is any room to mistake that you somehow checked out a branch owned
by somebody else (namely, origin).  You started by auto-creating your
local branch, worked on it, and checked it out again the next day.  In
other words, this is really about a shorthand to create a new local branch
called "frotz" when the commit that the branch should start from is
clearly unambiguous.

I have trouble with yours, on the other hand, which is to make

    $ git checkout origin/frotz
    $ git checkout v1.5.5

into

    $ git checkout -b frotz-47 origin/frotz
    $ git checkout -b v1.5.5-47 v1.5.5

(replace -47 with whatever random string you would come up with to make it
unique), as it _will_ break people's expectations, and the expected
behaviour to detach without polluting the local branch namespace for
the purpose of sightseeing happens to be a useful one.

I also have issues with turning

    $ git checkout origin/frotz

into

    $ git checkout -b frotz origin/frotz

only when frotz does not exist locally.  This will cause the "next day"
problem, and also by naming the remote tracking branch, gives a wrong
impression that this is about a remote branch.  It should not be.

Perhaps without touching the "detached" case at all, if we limit the scope
of the change that comes out of this discussion to only one case, it might
result in a good trouble-free enhancement [*1*].

The new rule would be:

    "git checkout $name", when all of the following holds:

    - $name is a good name for a local branch (i.e. check-ref-format is
      happy);

    - No local branch of that name exists;

    - There is exactly one remote $remote that has $name branch; and

    - $name itself is not a good commit name (i.e. get_sha1() barfs)

    is a request to create a local branch $name, and the branch tracks the
    remote tracking branch found in the third condition [*2*].

The important point here is that this exception is _not_ about remote
tracking branch but is about a rule to allow omitting -b to create and
checkout a local branch when the user's intent is clear that (1) he wants
to create a new one named $name, and (2) he wants to create it starting at
the commit $remote/$name.

Such a change feels quite safe and I wouldn't be opposed to it.

We _could_ discuss extending the $name in the above rule to other kinds
(tags and even arbitrary committish that may not even have a direct ref
pointing at it), but I think they are much more problematic.

[Footnote]

*1* Yes, I know I won't try to come with a strawman.

*2* The fourth condition is to avoid taking "origin/frotz" when "origin"
remote has "frotz" branch _and_ "other" remote has "origin/frotz" branch.

The remote chosen by the third condition would be "other" (because
"origin" remote only has "frotz", and not "origin/frotz", the name is
unique in the sense of the third condition).  The fourth condition
prevents this from happening, and forbids an explicit request to detach
HEAD at one point (i.e. "origin/frotz") from triggering.
