From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: bash completion with colour hints
Date: Wed, 26 Sep 2012 20:54:25 +0530
Message-ID: <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com>
References: <50631885.8090604@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Wed Sep 26 17:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGtTs-0003NM-SK
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 17:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab2IZPYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 11:24:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35261 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab2IZPYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 11:24:46 -0400
Received: by qchd3 with SMTP id d3so213907qch.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TdTQxVYNNu5lCEmacj3hmkwl/7yNjq+exZZH02FaZZs=;
        b=z1GIksExxol8RbX72rv9p2e+b3gqZtDQnRuBkDck+7nzqURHTxwIwDTx34xJYNjuzZ
         Pg8ypUYE5jg22aj47oI2CZoQxxXGMNgNUzTn4lZcHajfkyoW6CZ5URa+bZVTn7nyNm52
         3A+YalhWe0lhhSL3Vke1/h++GLE2t6CI85/+3cQV3wlteSVJopy/FWQBUh22cIsl1zLU
         /9NA31tiayynOvQumtO7PITYdmGqRl8e4/mD8YBu1qdvlhcPGIyZ5IOgOAODhWZbxIJe
         D88rpmyM29OEgYQUo/sT8tbLqfg0L9EcVu3D0kM6O0FwjMRL9kVt7/OeiSAa1wUj9cdD
         FhzQ==
Received: by 10.224.58.147 with SMTP id g19mr2722692qah.77.1348673086165; Wed,
 26 Sep 2012 08:24:46 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 26 Sep 2012 08:24:25 -0700 (PDT)
In-Reply-To: <50631885.8090604@nieuwland.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206420>

Hi Simon,

Could you follow the guidelines in Documentation/SubmittingPatches, so
that the patch can be considered for inclusion?

> --- git-orig-bak	2012-09-26 16:39:47.000000000 +0200
> +++ git-bashcompletion	2012-09-26 16:50:57.000000000 +0200
> @@ -59,6 +59,9 @@
>  #       per-repository basis by setting the bash.showUpstream config
>  #       variable.
>  #
> +#       If you would like an additional hint in colour in your prompt
> +#       set GIT_PS1_SHOWCOLORHINT to a nonempty value. Currently
> +#       the colours are hardcoded in the function...

Nit: I think it's spelt "color" everywhere else in git.

>  #
>  # To submit patches:
>  #
> @@ -302,9 +305,35 @@
>  				__git_ps1_show_upstream
>  			fi
>  		fi
> -
> +	

Whitespace damage.

> +		local c_red=' [31m'
> +		local c_yellow=' [33m'
> +		local c_lblue=' [1,34m'
> +		local c_green=' [32m'
> +		local c_purple=' [35m'
> +		local c_cyan=' [36m'
> +		local c_clear=' [0m'
> +		local printf_format="${1:- (%s)}"
> +
> +		if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
> +			if [ "$w" != "*" ]; then
> +				printf_format="$c_green$printf_format$c_clear"
> +			else
> +				printf_format="$c_red$printf_format$c_clear"
> +			fi
> +			if [ -n "$i" ]; then
> +				i="$c_yellow$i$c_clear"
> +			fi
> +			if [ -n "$s" ]; then
> +				s="$c_lblue$i$c_clear"
> +			fi
> +			if [ -n "$u" ]; then
> +				u="$c_purple$i$c_clear"
> +			fi
> +		fi
> +			
>  		local f="$w$i$s$u"
> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +		echo $(printf "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p")
>  	fi
>  }

Looks okay from a glance.

Ram
