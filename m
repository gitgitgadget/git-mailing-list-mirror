From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] t7406: Just-cloned checkouts update to the gitlinked hash with 'reset'
Date: Thu, 16 Jan 2014 11:22:52 -0800
Message-ID: <xmqqmwivzq7n.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<09008c79ecc7d4fd92131b4049a25e65db92a30d.1389837412.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sWr-0001PN-CG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbaAPTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:22:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaAPTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 14:22:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3638362A03;
	Thu, 16 Jan 2014 14:22:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TqUgxwEdBQibk7mPJWY9MquDlqI=; b=g3/YhL
	IFT5fCk2bkkxggHtidj5HZP8Uu0jomUYQGwzdUYsN3OyGxD1w9obrgzF2HAk6Ns5
	2YfVbUfoB1NlzLFvpzvUxAEcCbZid+M7aQDxAAaVcaE5m/XwBcHTuUrWVM1u6YS/
	sSQx5X1sV9HD99MUgo9YMnSItZR9afY7Zlr1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dgUiNOgi8UyV5/NOFY5WUWzDILIccfLc
	U+0+7rhtjgMr6kZUNl5Y+LQ7lPso4mZIEQnWfrCJ9UizwttuxtDJVzOf5UByDx+8
	VQllzhfM4F80QsksQcaLY+b6BasqtxqDHV/dczNCx4HfkUqKS/HkAMCvG1AKaekU
	kZ6G0d0fXyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 207AF62A01;
	Thu, 16 Jan 2014 14:22:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36870629FA;
	Thu, 16 Jan 2014 14:22:54 -0500 (EST)
In-Reply-To: <09008c79ecc7d4fd92131b4049a25e65db92a30d.1389837412.git.wking@tremily.us>
	(W. Trevor King's message of "Wed, 15 Jan 2014 20:10:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 992201E2-7EE3-11E3-A539-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240521>

"W. Trevor King" <wking@tremily.us> writes:

> To preserve the local branch, for situations where we're not on a
> detached HEAD.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---

This should be a part of some other change that actually changes how
this "git submodule update" checks out the submodule, no?

>  t/t7406-submodule-update.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 0825a92..5aa9591 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -703,7 +703,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
>  	git clone super_update_r super_update_r2 &&
>  	(cd super_update_r2 &&
>  	 git submodule update --init --recursive >actual &&
> -	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
> +	 test_i18ngrep "Submodule path .submodule/subsubmodule.: .git reset --hard -q" actual &&
>  	 (cd submodule/subsubmodule &&
>  	  git log > ../../expected
>  	 ) &&
