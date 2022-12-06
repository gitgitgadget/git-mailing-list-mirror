Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE703C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 20:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLFUuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 15:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLFUuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 15:50:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66742199
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 12:50:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s7so15115934plk.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puQjAwa/cbOHU+TYPuFBAkjPO8vErxw/3jzzzVjvEZw=;
        b=A5E14JO9rxKg/MbzZ+QS2YMrlklAqPkt8TJfGUzscc1GQgC11MvAzgA9EwFd82gZiv
         vRDdVvP+FI4Q8yWMLnHpJSjSsPPwyBYys2kFV2bl/HnJLhtICoxFcyBIZFbjWMIR+vZz
         KiXwqlLur9Li3Wn7NTCSemEdO7qjZSCSjoxGPEoGCXMGXwwmjmtmCZPkLKFi8b6GoHM6
         RtVjK6M8ghYzeklbwrNau8nMfQDlwCUsZd3RLlLBBkpJa1sUCzPY9Uux7S0gayIA1aDr
         x595tlRN+AGnSdvHz0sE3q6zqCvhIquThzqhP6sMJ4Tf2QGxUV22nX2sOAU38MR9abZB
         ORSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puQjAwa/cbOHU+TYPuFBAkjPO8vErxw/3jzzzVjvEZw=;
        b=zRzZ+rf5EhrDWwsVVQbfkjhW/b+KkAOoB8XVOuImYZX+YoXIeilRb9Vl/UtZAihtXM
         bPKoljy/44NOBREivk/OGxyOuehADvnq41+UweyxU4ayo3Bo+CQntFXaBlHg0hedqyT+
         CMwopCHk2Ifzg9MUt8AZF1Ugin62ZhvrbOLHAK1W+nTYwtLtEZlfra+c1P+PTvVVVkFt
         0gqmV4hUTx5ely9sNd+oZuVN7xSruEakbNiIsD8an7+1ZZ8dl1x3B2V9EbSTf55E4IKo
         KPsjVtgaEAguxlnYv4xkXU16M360DB0htDycMzuHKLVfpCE2yLfuqaYQq1Lj3P1B6kxO
         Jbnw==
X-Gm-Message-State: ANoB5pn3N2FwREHsqPLLrzltnsimzODi6ERvI5Nuspo3HrBpzoARaGGh
        kRh3G23QWVYLQml8WP25eO4h
X-Google-Smtp-Source: AA0mqf5l6ZNa7pdCICP1xIuVPR1qgC13Vr9ZQE7NigjUvIFq82JIThs1uJMquPBoAgpVAYew7ezPxg==
X-Received: by 2002:a17:902:e751:b0:189:80fe:b483 with SMTP id p17-20020a170902e75100b0018980feb483mr45981280plf.20.1670359834192;
        Tue, 06 Dec 2022 12:50:34 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902f64600b00186a2444a43sm13049389plg.27.2022.12.06.12.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 12:50:33 -0800 (PST)
Message-ID: <3859f3a7-ade8-4778-be15-b393694435e3@github.com>
Date:   Tue, 6 Dec 2022 12:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] CI: migrate away from deprecated "set-output" syntax
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> As noted in [1] and the warnings the CI itself is spewing echoing
> outputs to stdout is deprecated, and they should be written to
> "$GITHUB_OUTPUT" instead.
> 
> 1. https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Interesting, I didn't realize this changed! The new syntax is certainly much
nicer to read.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Along with my just-sent
> https://lore.kernel.org/git/patch-1.1-4c1dcc89e7a-20221206T195552Z-avarab@gmail.com/
> and Junio's https://lore.kernel.org/git/xmqq1qpd9bys.fsf@gitster.g/
> this should make our CI warning free.
> 
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Should this also be updated for 'l10n.yml'? There are two usages of
'::set-output' there as well.

> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 9afacfa0b33..d1e16009b11 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -34,7 +34,7 @@ jobs:
>            then
>              enabled=no
>            fi
> -          echo "::set-output name=enabled::$enabled"
> +          echo "enabled=$enabled" >>$GITHUB_OUTPUT

Looks good!

>        - name: skip if the commit or tree was already tested
>          id: skip-if-redundant
>          uses: actions/github-script@v6

