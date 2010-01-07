From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-merge: reword references to
 "remote" and "pull"
Date: Thu, 07 Jan 2010 10:01:36 -0800
Message-ID: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
References: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:03:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwgZ-00050X-5q
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab0AGSBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855Ab0AGSBp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:01:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab0AGSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 13:01:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FAC8EE77;
	Thu,  7 Jan 2010 13:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7ZKwTdcIFbdVzo5s1nQEGZxXr0Q=; b=uhnPxrX5c6lpyT42eNmNxgY
	Z5ZmLKsCW3ca7eA2nhxbM76xSUKD3oLA9DezDB6+0wB+GQsX3wtBXCNlNNzdGc4f
	fN/rFqesoyD7SjXMW6XIAx2aKP1PV8e9jphu36FzvDN4Uw7Yj6SS2VlTOIC5Aukn
	PaGuCh7dLcYCqB4ZVkac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yLQrARN3CbRTgKItuok/yYW1spXK5Yas5DRUViasscrWBZPf1
	1ZJK3spqRzxluDM5wT2vjfrB2frZlA9RR+yC550+78SVQGpmAktlJmn00LHZxK5q
	FUfb+nEJkZ/SCf4hvcq4DZsCNr7QZuJc22grWCqNxqXL0KRGamHIym1bdU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5C298EE76;
	Thu,  7 Jan 2010 13:01:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E53C8EE74; Thu,  7 Jan
 2010 13:01:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5147376-FBB6-11DE-ADB0-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136372>

Thomas Rast <trast@student.ethz.ch> writes:

> The git-merge manpage was written in terms of merging a "remote",
> which is no longer the case: you merge local or remote-tracking
> branches; pull is for actual remotes.
>
> Adjust the manpage accordingly.  We refer to the arguments as
> "commits", and change instances of "remote" to "other" (where branches
> are concerned) or "theirs" (where conflict sides are concerned).
> Remove the single reference to "pulling".
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Looks sensible, modulo a few "'theirs' version" that I think should simply
be "their version".

> Out of sheer curiosity:
>
>   The git-merge manpage was written in terms of merging a "remote",
>   which is no longer the case
>
> Was this ever the case?  Or is it just stale terminology?

Somewhere in between stale and lax.  Originally we didn't even have
refs/remotes hierarchy and the distinction between what's local and what's
remote was only in the user's head, and "one branch per repository"
(i.e. you do local clone to work on multiple things, and pull between
them), where even a topic-branch merge is to merge a commit from a remote
(= neighbouring repository of your own), was a more widely practiced
workflow.

Saying <commit> is much more correct than <remote> (technically it can
even be a <committish>, i.e. a tag that peels to a commit).

However...

> @@ -33,10 +33,10 @@ include::merge-options.txt[]
>  	used to give a good default for automated 'git merge'
>  	invocations.
>  
> -<remote>...::
> -	Other branch heads to merge into our branch.  You need at
> -	least one <remote>.  Specifying more than one <remote>
> -	obviously means you are trying an Octopus.
> +<commit>...::
> +	Commits, usually other branch heads, to merge into our branch.
> +	You need at least one <commit>.  Specifying more than one
> +	<commit> obviously means you are trying an Octopus.

I am tempted to suggest describing the command in terms of more common use
pattern, describing the flexible and more general form as "an aside" for
more advanced users, perhaps like this.

        <branch>...:
                Other branch to merge into the current branch...trying an
                Octopus merge.
        +
        Strictly speaking, these can name arbitrary commits, not necessarily
        at the tip of branches.  e.g. "git merge topic{tilde}4" lets you merge
        the topic except for the last 4 commits.

I don't know if such an arrangement really makes the document more
approachable to new people, or it is making the description longer and
more complicated without helping new people, though (that is why this is
just "I am tempted to").
