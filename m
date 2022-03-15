Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE25C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351458AbiCOTpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiCOTpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:45:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA0329BB
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:44:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e22so132462edc.13
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XBO9vv4DV6GKIguAuToPbpD6LTeeOe/KArF1Eg/T3vk=;
        b=DqpJ1zW50PhmarayV4elFebM0taqLTR+vK4c4NGaHzNDh3DnA5Ky4UK/2v1xPDq4sm
         oaliNmEq9juiZkI3wRi6bQA2+p19Y6UD3ylvSbmvqmtkv00G5Mt3iKcSHTZVL7CT04Ja
         A3FN33ClQKtDnVP9udn5jxhpoiq2WTjrft0jGOBaYJn/KGnTnkJtRgrlykvkvChVanRw
         AqSkin0fq+1iJ/M9dKzeX3df0rUfH8XNPZnvwrI2dab3fkMqoEch0eFWz+UzE6amyZOH
         er/BgsyXhxxAA/g3NL9t8nhx2gF08I2hBcxevXtPPWd5ORWPeIpzuhEZphRFCmXAX9BZ
         LQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XBO9vv4DV6GKIguAuToPbpD6LTeeOe/KArF1Eg/T3vk=;
        b=xG7MkiQAmBFwiMcQjH56cKouwC9MNKApuzEO2H2AIqkjOZchySL1MKG36175Ih0Mka
         IoKjvdGv3UyIX4Hl7t0mWOFTbpItk6bNAHGs9hZdX7UiAixoGzclBogRNa3WNBFs7l3p
         3Wh3rTu19e2vRqG4Oh5UcPusFZjA8Mo45o6OnSQoYTBJz+fKcUFgBYw8KEqIa+S0pqtK
         QV+q7WWs12qCrWApBOm99za5by8O2c4/xDM/OHUoj//Yp6TtWmfCdj2SnbMyRrPymsxo
         l86uxYwq56URB7eY3DZ/QeIFDgp4nD+tt4/qOVSDb/hp+fdUNu7eMfhl791TZIFa0Mmk
         X6TA==
X-Gm-Message-State: AOAM533s870TEBhB7ZQQ+Z+c8GiewEnES6punH8jqhUf6oK4NkjNO7t5
        Te9RasitOKHiIIkIY/+bBZc+l8+eNyk=
X-Google-Smtp-Source: ABdhPJxfCk1TavO26Xc6FjOse66YyWo75WEKZGriu6bkqQ97HCCMS22nutoQbWkn5jBmPSXU7ZE6KA==
X-Received: by 2002:a50:fd0f:0:b0:416:e62:ccec with SMTP id i15-20020a50fd0f000000b004160e62ccecmr26835329eds.300.1647373446930;
        Tue, 15 Mar 2022 12:44:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006db088ca6d0sm8332649ejc.126.2022.03.15.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:44:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUD5R-0014g8-V5;
        Tue, 15 Mar 2022 20:44:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-curl-compat.h: addition of all symbols defined by curl
Date:   Tue, 15 Mar 2022 20:30:21 +0100
References: <20220315131638.924669-1-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220315131638.924669-1-gitter.spiros@gmail.com>
Message-ID: <220315.86pmmndmre.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 15 2022, Elia Pinto wrote:

> This file was produced from a modified version of symbols.pl
> (https://github.com/curl/curl/blob/master/docs/libcurl/symbols.pl) and
> by manually adding the previous comments describing the dates of release
> of some curl versions not currently reported in the symbols-in-versions.
>
> To do this the symbols are listed in the order defined in the file
> symbols-in-versions rather than as they were previously inserted based
> on release dates.
>
> Most of these symbols are not used by git today. However, inserting
> them all starting from an automatic tool makes it largely unnecessary
> to update this file and therefore reduces the possibility
> of introducing possible errors in the future.
> [...]
>  1 file changed, 2875 insertions(+), 69 deletions(-)

*gulp* :)

> +#define LIBCURL_HAS(x) \
> +  (defined(x ## _FIRST) && (x ## _FIRST <= LIBCURL_VERSION_NUM) && \
> +   (!defined(x ## _LAST) || ( x ## _LAST >= LIBCURL_VERSION_NUM)))

As the recent author of this file I think there's certainly space to
improve it, e.g. perhaps this macro & the change Junio suggests
downthread, but...

> +#define CURLALTSVC_H1_FIRST 0x074001 /* Added in 7.64.1 */
> +#define GIT_CURL_HAVE_CURLALTSVC_H1 \

[snip ~3k lines lines]

I'd really prefer for us not to go down this route. If you look at the
patches I did where I removed the version comparisons in favor of these
GIT_* constants the improvement was in readability & discovery. I.e. to
see at a glance where this project was on curl compatibility &
compatibility shims.

If we add a new version-dependant curl feature the time saving is really
not going to be in adding a trivial GIT_CURL_* line to the file. It's
always going to be the compatibility shim itself that takes *much*
longer.

Right now you can easily discover where we need those shims with "git
grep GIT_?CURL" (the "?" needing fixing, as noted downthread), after
this...

