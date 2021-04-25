Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1853C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F730613C4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhDYIR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 04:17:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5CC061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:16:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h20so27336715plr.4
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xWmV39bsy1LBdRXYFOm3x8QFyO4AoNp1YTuSC/z4IbE=;
        b=AiMFn+SGTJ8K0KNjqk1LFrtXHZYE9a5s8LcCeGY57vPYu+QXrtnLXg7oAOjnqcVfy9
         W+tMZnG3m8K61bZ2fB6p4a6C/KWDFqlXgH5ueaxWr90gxZA9r4qPVqNocyrbB80ehEGy
         pgEy/0E9nkQLXeGFkukG4ZAX2iA915yNbAF933rY+7NMh4bIokYy0B8iRsujEWkyuoY3
         uckEhQibyY/X8UhYBCZY8GH2TZDkPDqh1TFOGVTrv1HGTkp1Xez1eWmsUix+E82Sub1w
         eYO5aAcIupM0M391yGto5AFoB3LPnxzvajatvT0vXL81+rLCnpAhKtzRSiP8uoULKpkc
         GS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xWmV39bsy1LBdRXYFOm3x8QFyO4AoNp1YTuSC/z4IbE=;
        b=OYw6tpnO47DxKgNrORSEIQtObpjCHpXyna1z1/HCR9x6rTs+seVinGD579Uyza4qTA
         DUC25M9mq2hFUnWwqmy7tXu3gauyeV54cIaRG3aQORpkGUiH6YH4IAi5qVo7z9DOL7Re
         73ujvrSGajgOcpwktcbOqZ49led6ymbCPgUs/foiXgRSyXtU0++xQlokb27Y/3ZEBKPV
         ZtG7uAAfqYFY+ensniwGAngfV5scTIhGDPGQwwY+rXeJG/VE9SFmfR3+YM1GBM7GduA7
         c2TMRYO8Q+OJq35hPpVADK27dpOJG+0TaMT4eEorWtcDvN1r+OYeIjDjYWdJzPXjXqdL
         EL1w==
X-Gm-Message-State: AOAM530bZiuTPRKDkgK0Pp5AePLtWKFH/zH6Lm6a/mdM2hFnBl1FSzZ+
        3mzk6sGDxJ4E0VFQ8YrEkcRIeSmoDmPKwg==
X-Google-Smtp-Source: ABdhPJy5d2JHCjyWgmi3HT2kobz78RAv9fupgqCd9N0ypUWh9Rs902UUd0z91t7CqxEPJ68U7JAtBQ==
X-Received: by 2002:a17:903:304b:b029:eb:4cf:8321 with SMTP id u11-20020a170903304bb02900eb04cf8321mr12395609pla.40.1619338607317;
        Sun, 25 Apr 2021 01:16:47 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id jx20sm11357273pjb.41.2021.04.25.01.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 01:16:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] bisect--helper: use BISECT_TERMS in 'bisect skip' command
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Trygve Aaberge <trygveaa@gmail.com>
References: <fd40e12f-9649-1327-4bdb-dce5b5eed619@ramsayjones.plus.com>
Message-ID: <473a11db-cbb5-58b9-b05d-cab2072d5d2f@gmail.com>
Date:   Sun, 25 Apr 2021 15:16:44 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <fd40e12f-9649-1327-4bdb-dce5b5eed619@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/21 07.18, Ramsay Jones wrote:
> 
> This patch was created directly on top of commit e4c7b33747 and tested
> with the test from Bagas Sanjaya [1] (ie the second version of the
> stand-alone test file t6031-*.sh, rather than the newer patch that
> adds the test to t6030-*.sh). I applied this patch to the current
> master branch (@311531c9de55) and it also passed the test in [1].

I have just sent v2 of t6030 version of my test [1]. Please test
this patch against that v2 test. And if the test passes (breakage vanished),
please update the test by do instructions in the FIXME comment lines of [1].

> @@ -1129,6 +1129,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>   		break;
>   	case BISECT_SKIP:
>   		set_terms(&terms, "bad", "good");
> +		get_terms(&terms);

I'm not fluent in C, but I read these lines above as "ok, we set terms from
&terms, bad and good as fallback in case the reference is empty; then we get these
terms from the reference". Wouldn't it makes sense if we can say "get the terms
from &terms" first, then "set the terms from the reference, if empty use bad
and good as fallback"?

[1]: https://lore.kernel.org/git/20210425080508.154159-1-bagasdotme@gmail.com/
-- 
An old man doll... just what I always wanted! - Clara
