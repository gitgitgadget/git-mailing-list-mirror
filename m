From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-push.txt: fix typo in remote tracking
 branch path
Date: Mon, 26 Nov 2012 17:30:02 -0800
Message-ID: <7vy5hnomsl.fsf@alter.siamese.dyndns.org>
References: <1353977748-17110-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdA0J-0004kM-6l
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 02:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757746Ab2K0BaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 20:30:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab2K0BaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 20:30:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76AC1A2A6;
	Mon, 26 Nov 2012 20:30:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ax5/aW/y44Xafi5sw7ZDyzdW8Uo=; b=C8wgQe
	0ujxZCsB1N6ghkx/Hhnta4yxgXAwnhbUnWHYlnYYABVzdL/ROzakNjyYVb0cyhyh
	eG3Dus8CrEj/FvEnfgMsDD2uB3gXT64EkgDnUB2BKEuTJX5iI3G+qRAdQ88P3XKp
	bkadZXhOHtJh6Do5cT+JObwuIU/y8ySESBLuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=th9Uum8LkkfEY9kmZNOSnTVc9ZJQs927
	Q5l85uR6Azk5qFPR1H1lhGrpWZbDRQQUjq2TaDwwBzRFXcvw6iwiWFHsjykqgYGi
	obQGPVcfW69MWB3dS8kj2yGz9E+PEoufmnpSY7XimhZL47imnSOXHO6+aoPuafJJ
	9nIxgHLvKeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ECD0A2A5;
	Mon, 26 Nov 2012 20:30:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83B54A2A3; Mon, 26 Nov 2012
 20:30:04 -0500 (EST)
In-Reply-To: <1353977748-17110-1-git-send-email-bcasey@nvidia.com> (Brandon
 Casey's message of "Mon, 26 Nov 2012 16:55:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F856AC52-3831-11E2-A6B3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210523>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> This example in the documentation seems to be trying to describe the likely
> remote tracking branch that will be updated by a push to the "origin" remote
> with the destination branch 'satellite/master', but it forgot to specify
> the remote name in the path specification.
>
> So,
>
>    refs/remotes/satellite/master
>
> should be spelled like
>
>    refs/remotes/origin/satellite/master

I might make sense to rename 'origin' to 'mothership' in that
example and explain that this is emulating 'git fetch' run on the
mothership to integrate the work done on 'satellite' using 'git
push' in the opposite direction, which is often necessary when you
can only make connection in one way (i.e. satellite can ssh into
mothership but mothership cannot initiate connection to satellite
because the latter is behind a firewall or does not run sshd).

If you were to run 'git fetch' on the mothership to intgrate the
work on the 'satellite', it would have a remote called 'satellite',
and would keep remote-tracking branches for the branches local to
'satellite' in the 'refs/remotes/satellite/' hierarchy.  You would
push your local 'master' to their 'refs/remotes/satellite/master',
to emulate 'git fetch' done on the mothership in the reverse
direction.

So refs are correct. The context is not sufficiently explained.

>
> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
> ---
>  Documentation/git-push.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index fe46c42..a18f929 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -387,8 +387,8 @@ the ones in the examples below) can be configured as the default for
>  `git push origin master:satellite/master dev:satellite/dev`::
>  	Use the source ref that matches `master` (e.g. `refs/heads/master`)
>  	to update the ref that matches `satellite/master` (most probably
> -	`refs/remotes/satellite/master`) in the `origin` repository, then
> -	do the same for `dev` and `satellite/dev`.
> +	`refs/remotes/origin/satellite/master`) in the `origin` repository,
> +	then do the same for `dev` and `satellite/dev`.
>  
>  `git push origin HEAD:master`::
>  	Push the current branch to the remote ref matching `master` in the
