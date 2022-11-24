Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4708AC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKXLGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 06:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKXLGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 06:06:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E35FB86
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:06:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i12so2020132wrb.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 03:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xx/U69yKdS8/arbIOCq6cpwYpifk3WMu2nfeYgciOg=;
        b=bZS5lti+ACKdnmWulPyWmXLiyjtE5hrl0rGm/qCFrIWxKEeIXipa23wrX3+hAzgC68
         M8QO4HPM7pAofvW+sOAjQIgtD3YQd8/XYUU7z8eU1xBEXuPCdv9lrNMd7ja1ubm3HKug
         WcY+GG5F/J82UJz95jvpacJNKbVzl1AiT9acJ0nkh2Yo35OvVodBCWPK23ehdytjACZ/
         VTOeoSS76dXUbW7U2JB+witnOpfk4CoLIkXnq28nMSWEw07Erg2GZ27XyqhX4FquqAdJ
         P48SC8Sn8idupdfGUBy0wcUi8fIT9nI7RkxqVkQXPCl/KeAiG3zOK145KODPRd3YkdGE
         6rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xx/U69yKdS8/arbIOCq6cpwYpifk3WMu2nfeYgciOg=;
        b=kwt0igt+5rv13i3swH47rILU2S6z7zj4SIgkFYmzyMyxPcnbCihwGhn8JrNasnTeTX
         LDLZhXhAcFv4p90WQVB8v5DCcIA6KRWE4t7SmZIBLQ/F2yzEJHahLSs2Ic88hCYHcM8C
         f7aXb/w05Q56OXSmb/hAkTDGRrU51qh5+3TTD2WFjeUaTRs6NBSf8ZJ5spseVTB5tgMh
         WXIqMWcenqM8CA2UsXN5nOsL3IJSVln/QcpxKjf02FnRzZ1bmmAVVLziiuZjBKDWkAVA
         APLeONLCwXltaiMtAM7u9UOeaWc6BBf0KnNSAcTbqVPfDiW9hCfzYZAeop/pB7U0vZcV
         KTYQ==
X-Gm-Message-State: ANoB5pkTlBMrxbJepqIp1jJcPT1rey3qi729jFtOCQT/dsAStzFYp4MV
        BsGEo9O7NWORTUg+apLRn/4=
X-Google-Smtp-Source: AA0mqf6Bd8Fvt+WxFi6T3mU3bpa83WxETWrtM/iz2w/RcifdN4iRY/MIPfYeKE5bfRZQboO+ZMtOtg==
X-Received: by 2002:adf:e3cd:0:b0:241:bc27:f8b6 with SMTP id k13-20020adfe3cd000000b00241bc27f8b6mr19538638wrm.367.1669287968193;
        Thu, 24 Nov 2022 03:06:08 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm11187472wms.0.2022.11.24.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:06:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyA3T-0006WY-0q;
        Thu, 24 Nov 2022 12:06:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] ci: install python on ubuntu
Date:   Thu, 24 Nov 2022 12:02:17 +0100
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-4-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221124090545.4790-4-worldhello.net@gmail.com>
Message-ID: <221124.86edtspq74.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Python is missing from the default ubuntu-22.04 runner image, which
> prevent git-p4 from working. To install python on ubuntu, we need to
> provide correct package name:
>
>  * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
>    "python" package, and "/usr/bin/python3" is provided by the "python3"
>    package.
>
>  * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
>    the "python2" package which has a different name from bionic, and
>    "/usr/bin/python3" is provided by "python3".
>
> Since the "ubuntu-latest" runner image has a higher version, so its safe
> to use "python2" or "python3" package name.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  ci/lib.sh                  | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 291e49bdde..e28d93a154 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -15,7 +15,7 @@ case "$runs_on_os" in
>  ubuntu)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
> -		$UBUNTU_COMMON_PKGS $CC_PACKAGE
> +		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
>  	mkdir --parents "$P4_PATH"
>  	pushd "$P4_PATH"
>  		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a618d66b81..ebe702e0ea 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -235,8 +235,10 @@ ubuntu)
>  	if [ "$jobname" = linux-gcc ]
>  	then
>  		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
> +		PYTHON_PACKAGE=python3
>  	else
>  		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
> +		PYTHON_PACKAGE=python2
>  	fi

Let's not copy/paste and repeat ourselves here for no reason. Part of
this is pre-existing, but if you just re-arrange these variable decls
you can do this instead:

	PYTHON_PACKAGE=python2
	if test "$jobname" = linux-gcc
	then
		PYTHON_PACKAGE=python3
	fi
	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/${PYTHON_PACKAGE}"

Even if you don't factor out the "else" like that (which I think would
be OK to do while-we'er-at-it) this should be changed so that the
"PYTHON_PACKAGE" comes before "MAKEFLAGS" in the two if/else branches
here, so we can then use the variable.
