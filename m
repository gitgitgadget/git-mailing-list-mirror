Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB20C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiG1U4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 16:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiG1U4W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 16:56:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC656BD7D
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:56:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oy13so5169452ejb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=KTWOfgyWkLYwtEyc1fBKmOEYvGhKIXWyU7zHrIbvgB8=;
        b=hnATEjYLFMnbaqFMQf2rZQHRtzWXEcmihNxEmKP+Fm+5UKhrCndjBkOcVIfx0AqjuX
         fg9FeHUPfZ2/N4qCXhI+ja66rrJfIwubI/yYhZAEilybPysUD5HBI9LlUrruNn+8IhA4
         lneeg19/6WXr8iJwOywn276PDYpAejb5Cc+cP/eaDRZOwnnzw9qQFxG0QP1/0wnIqAYl
         xZP8mju3o4Nlwyfkqu0Yl3MTfEieOgXGQkzojsnxLSA7dWWIqtv0ljia8Fc2JPeoNTfu
         uMQHIBk/YPtzbqalvd9DUbK9QwKk/Dd9RPfqg4uoUi/hHqws2HxsmYLwaYD5lFqT8xLB
         GxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KTWOfgyWkLYwtEyc1fBKmOEYvGhKIXWyU7zHrIbvgB8=;
        b=2TIQqkm6hVU70bKSNb6NcbjGi1HfV1QeOU7OK8L99V7Y9CFeWRtjRprXwaM7cbvyhC
         GfegaqOXk4KFrTwsA7Bc2YGQTkEVmiXerM0aw4mTIjxDYyuY5hhzGltlZidR5aFtu2Oj
         kpIYPPc4ZlNDvnXu5ahJ6opKYnA9eQpvuVFnkU0RkOdN7lzhspJStMVtzc29yMMi4IGQ
         RWx3iWBBvrbKL7md2t0o97k+z2oKwfMxFC89XmvVl9nA4R4fLsCelgV+K/TcI20FjqAJ
         P8IrVk0UL7kJF02Zz5nVtF5Yj7vy40KGat+Bmc7QxQA8jTdlGnxEhagYPVG+pNBxgEEW
         StSw==
X-Gm-Message-State: AJIora9RUtGppLJEF6SSsFdo0e/e+w6EkNzzqg2tUTA7OdYScwMfNBna
        SgMqA/ak2wDqHOIqNXsUy/8CkvYr/r58Ig==
X-Google-Smtp-Source: AGRyM1txoFQHmGpMpd2RPCZu8LRfpYGV3YTEFryhVfP5HAU0BcP3YDsAJ3Svssg1FNFP3NAvQmzwCQ==
X-Received: by 2002:a17:907:734a:b0:72b:7c72:e6b3 with SMTP id dq10-20020a170907734a00b0072b7c72e6b3mr500436ejc.608.1659041778763;
        Thu, 28 Jul 2022 13:56:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7df8c000000b0043ba0cf5dbasm1310520edy.2.2022.07.28.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:56:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oHAYJ-007FXH-Ik;
        Thu, 28 Jul 2022 22:56:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>
Subject: Re: [PATCH] format-patch: clarify --creation-factor=<factor>
Date:   Thu, 28 Jul 2022 22:55:31 +0200
References: <xmqqo7x9ch7n.fsf_-_@gitster.g>
 <20220728174953.66964-1-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220728174953.66964-1-sunshine@sunshineco.com>
Message-ID: <220728.867d3xj6s0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Eric Sunshine wrote:

> The value is not a percentage that ranges from 0 to 100, so stop
> referring to it as `percent`; instead follow the lead of the `git
> range-diff` documentation and call it `factor`.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is a sibling to Junio's patch[1].
>
> [1]: https://lore.kernel.org/git/xmqqo7x9ch7n.fsf_-_@gitster.g/
>
>  Documentation/git-format-patch.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index be797d7a28..e06475abcd 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -27,7 +27,7 @@ SYNOPSIS
>  		   [--[no-]encode-email-headers]
>  		   [--no-notes | --notes[=<ref>]]
>  		   [--interdiff=<previous>]
> -		   [--range-diff=<previous> [--creation-factor=<percent>]]
> +		   [--range-diff=<previous> [--creation-factor=<factor>]]
>  		   [--filename-max-length=<n>]
>  		   [--progress]
>  		   [<common diff options>]
> @@ -321,7 +321,7 @@ product of `format-patch` is generated, and they are not passed to
>  the underlying `range-diff` machinery used to generate the cover-letter
>  material (this may change in the future).
>  
> ---creation-factor=<percent>::
> +--creation-factor=<factor>::
>  	Used with `--range-diff`, tweak the heuristic which matches up commits
>  	between the previous and current series of patches by adjusting the
>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])

Looks good as far as it goes, looks like both of your patches need to
also tweak this bit though:

	$ git -P grep 'percentage.*creation' -- '*.c'
	builtin/log.c:                      N_("percentage by which creation is weighted")),
	builtin/range-diff.c:                       N_("percentage by which creation is weighted")),

Probably just s/percentage/factor/ in for those -h strings?
