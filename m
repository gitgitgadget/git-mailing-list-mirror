From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 11:06:23 -0700
Message-ID: <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
 <20100717093006.GA11452@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jul 19 20:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaujm-000102-5f
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 20:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760814Ab0GSSGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 14:06:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760784Ab0GSSGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 14:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17C48C6E13;
	Mon, 19 Jul 2010 14:06:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NEeYAYAjubG1Emh4bo5LMAfEDos=; b=TDJM+A
	v3BEGun9bAIh9Au6fg8GBjgiDfxQ7YtbKx7Ei92/KuDUjIO7sut8WdaRsXy+tROb
	Uy74Xkb3vRSzltIjh7nPHUx4Oh5uuYzst92P57Sa3eCPEEXRYvAfC8yPM5HnF1SM
	Xa9roj5Q0iwa+1yerch7BXAIdnbLOTMEPNZss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLn4yBUE1V5khC6m0p4SqmiBULMup8XJ
	Jmt7VFzGnvFecbCUii9sKRXv5n+oYjvqlTQD4Tg4OV3vGszIpxNdAoQ11nK4oNAf
	50t7vRT4QdceWGuTRvF6yBHyfYEREQQNBBtksc3+FeBQEB8krO0Bdt76N44513O+
	P4J8UA8qxFk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A160BC6E11;
	Mon, 19 Jul 2010 14:06:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52753C6E0E; Mon, 19 Jul
 2010 14:06:25 -0400 (EDT)
In-Reply-To: <20100717093006.GA11452@localhost> (Clemens Buchacher's message
 of "Sat\, 17 Jul 2010 11\:30\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CBB76BA-9360-11DF-9819-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151264>

Clemens Buchacher <drizzd@aon.at> writes:

> Pros and cons for "undeleting branches":
>
> + safety net
> It should not be easy to lose information with git.

I am personally not very convinced by this argument when it comes to the
cases where the user actively asks us to remove something.

> + less dependant on git branch -d
>
> Since git branch -d deletes branches which have been merged to a
> remote tracking branch, it does no longer guarantee that the branch
> is still available in history locally, and if the branch is also
> deleted remotely, running git remote prune removes it entirely.

Sorry, I have no idea what you are talking about in this paragraph.  I
cannot read "Who depends on git branch -d to achieve what" from your
description.  All I read in the above description is that what the command
does is a good thing.  If you want to keep the remote tracking branches
around, don't run "branch -d".  If you do want to remove the history of a
branch, run "branch -d".  Isn't it that simple?

Perhaps the missing "achieve what" may be that "output from 'git branch'
is too cluttered if I don't remove already merged branches as early as
possible, and forces me to run 'git branch -d' to clean things up too
often"?  If that is the issue you are trying to address, perhaps we can
solve that in a more direct way, e.g. "git branch --no-merged" easier to
access?

> - user interface complexity
>
> How to prune deleted branches? Currently, it is enough to do "git
> branch -D branch; git gc --prune" in order to get rid of the branch
> objects, at least if the HEAD reflog does not contain it or has
> expired. Consider for example adding a remote, and removing it
> again. This operation would leave a bunch of deleted branches,
> which potentially occupy a lot of disk space.
>
> How to find and restore deleted branches? If the reflog is used to
> record deleted branches, and a new branch of the same name is
> created, the reflog contains entries from unrelated branches. [1]
> If the deleted reflogs are stored in an attic, how do we reference
> those?

This is the area I am most concerned about.

If you take an analogy in say a file server implementation, yes, it should
not be easy to lose information there.  But it is and should be easy to
say "rm junk".  How would people recover from a mistake if they typed a
wrong filename, "rm junio" to lose a precious file "junio", when they
meant to lose "junk"?  They go to backups.  Can't git users do the same?
After all, .git directory is stored on a filesystem of some sort, and
taking a backup (you do take backups, don't you?) and picking the stuff
you lost from there should be a standard procedure that can be learned
outside of the context of git.

This is pretty-much a tangent, but I recall from time to time people
wonder why the branch namespace is not flat.  If that is a common wish,
your "tilde-suffix all the intermediate path components" trick could be
used in later versions of git (perhaps 1.8.X series) to improve the system
to allow "maint-1.7.0" branch and topic branches that forked from it
e.g. "maint-1.7.0/fix-frotz" and "maint-1.7.0/fix-nitfol" peacefully
co-exist.
