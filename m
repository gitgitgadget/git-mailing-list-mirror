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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A5C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 06:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF05C6141E
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 06:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhD1GQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1GQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 02:16:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D44C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 23:15:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr7so14057064pjb.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=srkZA1oeu2tqJGzamVKhzVEFPNSfmWtzD1HLtLUdpdc=;
        b=TH3eRIUeYtEhBIPyH3QOAgCGc7p1YTHc6yrp2RYuxmEdZ31ucqpbmONB91Q/9gPWIh
         Iyam8lXqUyqhb0awUUrJx/RAWtQF586v8oujX4yluxPlv2w/at+QRHH9Vp88GqaYzCEd
         HuiSfFyB0q3VdnBkH6OvgPaeV09eJQ/e8NRt37FyuIK8qY50v7oWmf2l/icn2H0I5W8k
         oj9Rg+AMeqk+iW+HqNUHhK1mhYyEK/boP2fZw+C/kIkIXFoEhQNtlcBh+qVAf4TJtqUM
         0w1MOJsl2TziX1q95y8lC3liifJuw6QxQI5VxB4YpdciqZevFirZb2fldraPAFYjBfor
         Ne3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srkZA1oeu2tqJGzamVKhzVEFPNSfmWtzD1HLtLUdpdc=;
        b=RN4UaBacueRJ7qm78R8L03cxtVhzyIeJeG1Qtq0Cko/dvYRkDXcDeS2S7isAzI/D/i
         Gyxw6Aeqbd+xSn/6iaRip3SanAu8UmpaxwMY5zL2Eb2HxQYkx+ttxnUbodmZBEeLlXCE
         zbl8j8e1OQRFSIhRLtiXh+fu9iE533ncf2p0LMSwpilS2qCjS8Hr+YFjJDY8v5G8tiab
         953HSLSdC8kqlUrQvneHDmzMhgSqOGKwuO52QwfW2AHV0V2o+TCsJWTWFfH5x3jGhAa7
         DZ/7ydYYTJfcUdRbpYA1VPXM0cepzueeB6aorCCkxmtcaq8DHzgw7Xn/Cnt+FSMA+7uT
         7R6A==
X-Gm-Message-State: AOAM532qTV4kp0fKj/TqUwbFpGAl9ujWYQwv9QVz3U60zjtQq1I49pgo
        M+pv7Abed9PUCqN3KWjhwECCI9aw/RB+Cg==
X-Google-Smtp-Source: ABdhPJy3L3gjjPsar8gpxn51Ge6F4lSPt2yChV6dUCncpRO7Y9lojYuCoEi/s6bZeq22lGDv4s69kg==
X-Received: by 2002:a17:90a:4e81:: with SMTP id o1mr2146538pjh.7.1619590535836;
        Tue, 27 Apr 2021 23:15:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id w7sm4110441pff.208.2021.04.27.23.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 23:15:35 -0700 (PDT)
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
To:     Jeremy Faith <jeremy.faith@jci.com>
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Cc:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3ea4e4c8-9723-4af6-5f07-9141c3001986@gmail.com>
Date:   Wed, 28 Apr 2021 13:15:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/21 23.30, Jeremy Faith wrote:
> Hi,
> 
> git version 2.31.1.362.g311531c9de
> git-check-ignore
> When a negative pattern is the last .gitignore match the -v option causes the exit status to be 0 rather than the expected 1.
> e.g say .gitignore contains  one line: !hello
> git check-ignore hello #outputs nothing
> echo $?  #shows correct exit status=1 i.e None of the provided paths are ignored.
> but
> git check-ignore -v hello #output is next line
> .gitignore:4:!hello	hello
> echo $?  #shows wrong exit status=0 i.e. One or more of the provided paths is ignored
> 
> Following change seems to fix it for me
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -114,7 +114,7 @@ static int check_ignore(struct dir_struct *dir,
>                  }
>                  if (!quiet && (pattern || show_non_matching))
>                          output_pattern(pathspec.items[i].original, pattern);
> -               if (pattern)
> +               if (pattern && !(pattern->flags & PATTERN_FLAG_NEGATIVE))
>                          num_ignored++;
>          }
>          free(seen);
> 
I tried to apply this patch from the mbox, but it was corrupted, so I had to
manually write the changes above. I tested that with your reproduction case and
it worked as expected.

But anyway, please send the proper patch and (preferentially) with the test
consisting of the reproduction case.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
