Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD91C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 07:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJFHeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJFHdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 03:33:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A18E473
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 00:33:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so2534172ejb.13
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pLHstapuo48NbtzswAiVVXzbYLh/kHykVIsTEQh8XKM=;
        b=NGbD85gJQrzj/syuCk4Z6dnAhZB89wWepWveGNIBbguyy2+wCdg6WCum+dW2TToAw+
         oNKLEFxwzmedOTDuphYC65Lnvd3mg9pOebGe6ZuXETRIrHsRpG+sj82EqA64D4WOdakz
         +Bm0Q2i3PB8MSAPUUmIAB1FZcBWIpIJxwExQV7NZMojCcYg9tZuJqAkKDq5Ux5eLP97w
         RT8pq7jQwKjKs4jbXGVtLdu4oFoR5515B72Ok788iXdjkwIVwUFrJEfFdYMZQtyP9Sj+
         jmM08YwE5nzGSmuRfjFltOy0Z7ZUwKWPcJuYHCO/mm3DHOxAJ1sI2omvpZBVyVxzh55n
         7BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLHstapuo48NbtzswAiVVXzbYLh/kHykVIsTEQh8XKM=;
        b=oLwyoFc8hbWoPW6Y/hYB9CHwwFSGp64vr+7uf2MujDz2IEihDPiIfkx7HgCPswtw2K
         YusMyNzFonP7p23ldfgaasRKowOhA25Ay0nkH86m733ZQG7L2we4z7dgjezAOAE2gYPQ
         6G0QI10MazaI5kcujbTv8dw2rSLGVin3g9CxgtKF37dquM6kag1Lm4FOC5Ed2DWZm7hp
         qYC5wZ/gFx7No3Qqn3rFzhIWyRCAdaQpiWh6fG9qWOxKV6LGF66jxitx9qDNr0jPkN0h
         kiz0agSt6V8w2vqy8Wun56802f2+0rIMvQjB6fiorhJ3i24Tm2O0AOHf/Wy8WboYHOb3
         V+Aw==
X-Gm-Message-State: ACrzQf2nlo/ZaNuU4N8z6XgAylR6ajd/rf3p3OolMgjaOvTL+GG1jmca
        keuf+nYB7rQ1lhx5lNXFnYo=
X-Google-Smtp-Source: AMsMyM48Yytb+81E9vA22L0LxGAo8kKTrZVMz2DiO8HyxDAYabp4ky/NRWGG44LmSdRdi22N6gU90w==
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id x19-20020a1709064bd300b007313bdfb95cmr2883396ejv.677.1665041618352;
        Thu, 06 Oct 2022 00:33:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w23-20020a50fa97000000b00456d2721d93sm2644386edr.64.2022.10.06.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:33:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogLNx-002fuy-0H;
        Thu, 06 Oct 2022 09:33:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?Alejandro_R=2E_Sede?= =?utf-8?Q?=C3=B1o?= 
        <asedeno@mit.edu>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated message arg only in
 GCC 4.5+
Date:   Thu, 06 Oct 2022 09:31:45 +0200
References: <xmqqilkynd91.fsf@gitster.g>
 <20221005221928.703750-1-asedeno@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221005221928.703750-1-asedeno@google.com>
Message-ID: <221006.86h70hs8xb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 05 2022, Aleajndro R Sede=C3=B1o wrote:

> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> From: https://gcc.gnu.org/gcc-4.5/changes.html
>
>> The deprecated attribute now takes an optional string argument, for
>> example, __attribute__((deprecated("text string"))), that will be
>> printed together with the deprecation warning.
>
> While GCC 4.5 is already 12 years old, git checks for even older
> versions in places. Let's not needlessly break older compilers when
> a small and simple fix is readily available.
>
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
> ---
>  git-compat-util.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b90b64718e..045b47f83a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -189,9 +189,12 @@ struct strbuf;
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>=20=20
> -#if defined(__GNUC__)
> +#if GIT_GNUC_PREREQ(4, 5)
>  #define UNUSED __attribute__((unused)) \
>  	__attribute__((deprecated ("parameter declared as UNUSED")))
> +#elif defined(__GNUC__)
> +#define UNUSED __attribute__((unused)) \
> +	__attribute__((deprecated))
>  #else
>  #define UNUSED
>  #endif

This LGTM, thanks a lot for that fix & fixing this (minor) breakage of
mine.

I did test on an older GCC myself, and then (in lieu of logging into an
ancient system I have access to) scoured the release notes of gcc, and
discovered that "deprecated" was older than anything we cared about.

But I obviously missed that while the feature had been there for a
longer time, it didn't take this parameter until GCC 4.5, sorry!
