From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add "--set-upstream" option to bash completion
Date: Fri, 29 Apr 2011 09:31:14 -0700
Message-ID: <7vbozpxbn1.fsf@alter.siamese.dyndns.org>
References: <1304092621-554-1-git-send-email-dmedvinsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Medvinsky <dmedvinsky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqbJ-0007sL-QE
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167Ab1D2Qb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:31:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158Ab1D2Qb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:31:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1C1B51C5;
	Fri, 29 Apr 2011 12:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Cld8995jChcpbU0LgjjqjfFAE9c=; b=wVw7/wzWRuA3fSVoBxIJ
	ewEFq3Oi1MEJ/Ox5KxXQWpZnYMAYpu9oRnO8xVuugn26a6f1OtA8ymys0bvhHxJr
	x0Xq7Lrwm7eHVm1xKexEuaAyyRhw9EkFRgt7JI3oUQ5j2NXYWuf+MVUsKO67uz8S
	UOdXnCEe0z14zLvip0CMLbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Hgk6ip0YuNdJayVmFIdlvc1PFt/wTrCMRAJfFDqsWvM3Ot
	idSFswUS902M6RnuPwlL8ce/KjAOnnnb5L7PI5PMnfKXUDPIVZH0oc9uWGjHZZC6
	4+JmjjqNK3uVbGPeKCAWbp76EacbUbLgU3nWJlaQKFkR7vFx2fgTuCPWvoW40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0BC251C4;
	Fri, 29 Apr 2011 12:33:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C778451C3; Fri, 29 Apr 2011
 12:33:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65990556-727E-11E0-8EBB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172468>

Dmitry Medvinsky <dmedvinsky@gmail.com> writes:

> Since version 1.7.5 there is a new help message when pushing a branch with no
> upstream telling about the ability to use "--set-upstream" option. That option
> should be tab-completed for git push command.

Unless you are on a branch that does not have "upstream" defined for, the
option is useless, isn't it?  If that is the case, it should not be shown.

Can you make this conditional without too much overhead?  Is it worth
doing?

I suspect that offering this completion unconditionally hurts more than it
helps users, as it would be much less common for users to be using this
option than this option being no-op (or it could error out---I didn't
check).  After all, you give this option just once and then after that
keep running "git push" without it.

>
> Signed-off-by: Dmitry Medvinsky <dmedvinsky@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9150ea6..cc90e43 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1796,7 +1796,7 @@ _git_push ()
>  	--*)
>  		__gitcomp "
>  			--all --mirror --tags --dry-run --force --verbose
> -			--receive-pack= --repo=
> +			--receive-pack= --repo= --set-upstream
>  		"
>  		return
>  		;;
