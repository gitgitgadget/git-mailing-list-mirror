From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: suggest "reset --keep" to undo a commit
Date: Fri, 21 Jan 2011 09:34:26 -0800
Message-ID: <7voc7ap3dp.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <20110121073730.GA26276@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 18:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgKt6-0004JA-8T
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 18:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab1AURe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 12:34:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1AURe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 12:34:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1175C2B0C;
	Fri, 21 Jan 2011 12:35:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vR1pl3tUvtwFNRZxKwM9K5afA3g=; b=ooBj/D
	Zu2YVnxxm45P4D2Tv43GT4+8fk1tVIcePki45g+2GK+yvcRhKVA/t5YEOKacUI6X
	IBRVlqJ7nSeW1V7dIKV0o1SRMKQ4ROg8RhUB6e3A3VS8Aog2ecEtFbn00uLLjZtK
	FdwjxvC+Thk1dHMVifQZaaR4L6ZOkovpucYGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RHGPb8F+fwuhjCg5DOC/6mnF3TKMefJM
	j1QE4egvQm0eeirU1WflB/Mt6uLF0QFaNhf1spz7NOSAHQBQi+CBLFLAtLocuRNQ
	TAjJt9BqOdlPcG7jkKrkj85enBU/PXJEtWBFdRA4oxvnzdtwSDCzE26m96g/yi87
	1aYCIWU/D4U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CD4E2B04;
	Fri, 21 Jan 2011 12:35:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6D732AFC; Fri, 21 Jan 2011
 12:35:16 -0500 (EST)
In-Reply-To: <20110121073730.GA26276@burratino> (Jonathan Nieder's message of
 "Fri\, 21 Jan 2011 01\:37\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7799470-2584-11E0-B4D1-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165384>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When one's only goal is to move from one commit to another, reset
> --keep is simply better than reset --hard, since it preserves local
> changes in the index and worktree when easy and errors out without
> doing anything when not.  Update the two "how to remove commits"
> examples in this vein.  "reset --hard" is still explained in a later
> example about cleaning up during a merge.

I agree with the first sentence but I do not think its conclusion would
lead to changes to "how to _remove_ commits".  The examples were written
in contexts (explanatory text <$n>) where hard makes sense, and the
context needs tweaking to make keep makes more sense than hard does.

For example, the first one's original sequence is this:

    $ git branch topic/wip
    $ git reset --hard HEAD~3
    $ git checkout topic/wip

The text explains the motivation behind these series of commands in <1>
but it has one untold assumption behind it; the user did the review to
reach the conclusion that the recent changes are premature after fully
committing (i.e. the working tree is clean).  That is why "hard" worked
just fine.

But the user could do the reviewing and thinking with some local changes
still in the working tree (they are incredients for the fourth commit yet
to be made) and decide to branch at that point.  The description in <1>
needs to be updated to hint that there can be uncommitted changes, e.g.

	You have worked for some time, made a few commits, and may have
	uncommitted changes.  After reviewing the current state, you
	realized that ...

Using --keep may help the user do so, but only if the local changes do not
conflict with the changes in the recent commits to be discarded, right?

    Side note: Regardless of any of the above, the section header needs to
    be updated---it is not "Undo *A* commit", we are excluding three from
    the current branch.

By the way, a more natural way to do this would actually be:

    $ git checkout -b topic/wip
    $ git branch -f @{-1} HEAD~3

or using the stash:

    $ git stash ;# save local changes
    $ git branch topic/wip ;# and mark the tip before rewinding
    $ git reset --hard HEAD~3 ;# you could say --keep here too
    $ git checkout topic/wip ;# and then continue
    $ git stash pop ;# with the local changes

The branch/reset/checkout sequence itself, either with hard or keep, looks
more like a contrived example to show "reset" than the best way to solve
the problem in the scenario presented there.  Probably we would want to
drop this one altogether, or keep the scenario and explain the best
solution in somewhere else (e.g. tutorial).

> @@ -163,7 +163,7 @@ Undo commits permanently::
>  +
>  ------------
>  $ git commit ...
> -$ git reset --hard HEAD~3   <1>
> +$ git reset --keep HEAD~3   <1>
>  ------------
>  +
>  <1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad

Please tell a story where keep makes more sense than hard by enhancing the
explanatory text <1> associated with this section.  The current text says
that the three topmost commit representing what you have recently worked
so far are all unwanted, strongly hinting that hard is more appropriate
thing to do than keep, which is not what we want if we are changing the
example to use keep.

It would be sufficient to just hint that the uncommitted changes that you
have in your working tree are unrelated to what these three commits wanted
to do (e.g. you always keep small changes around, such as debugging
printf's and a change to the version string in Makefile---you do not
intend to commit them and they are unrelated to the commits you are
discarding), and you do want to keep them around if you can.
