Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D4C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F2E6195C
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 05:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC2FdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 01:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhC2Fcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 01:32:55 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1DC061574
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:32:50 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id u29so2679855vsi.12
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1DY0nHHPB8G4E3g4NT9l4OhYjxgYauDX4HSuSI9iZc=;
        b=LFEGKibOtYqMdMv3DCDO61n/l4Y0Vifq3I6ctEo36MfXGfWml1jdt1x2myZkOdNou9
         zjiItmyIw5sObamG7Gf2RfHSludXig3zGAaoagnr7QDwF6sPNEE2F7h2SsD0yBKxM2xb
         sGLsbIcWAmFQyODfv0muiAgcDqgC9+cUJcsCYWBi99DiLbfnnDI3sdR00lu8HQMpNDqh
         GKj+w5AoaEBJhH2Gb87XC7YAXDrALLorO+1vhR6UBNNVmys+WntiLKmOlmknj5WrL3+s
         0+5QGVuMFDN8JI/kLL5uxytUP1AXA7w14ARVd5LEAToKv0byoem9HEDAbz+qZlBfe5mA
         eA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1DY0nHHPB8G4E3g4NT9l4OhYjxgYauDX4HSuSI9iZc=;
        b=Zw2micCJVksjvGjAkkZVSe1q9hOrUWlDQFaOCHys/mSf1z4SA4xf9ZuUNA+UI10EGF
         v6KTOCky5y1vB5m6Zxm0j8beigZ6OPDrW6U/ep/mVGmF9rHZyuebgdG3KMv1Dg3HTvvI
         MFEB7mmRB+We3K/d7i42DyN+p2lQcOtPPaxbH6/WQ9lSHECkTg2OsSW2C/VA82hlx/p7
         aAZ0sdo7hFKD5P6maEMt+wZHuSiBDgHTKGmOA9c9QlQtE/8FbUr/ny6O5RSjt+/1Fd4Y
         KctPltE8347XN1EyaZUyBeT1o9T7Tr/TACeWAtrD5rkcGN+CxJ60N5LqPVYU3L7enVlm
         EblA==
X-Gm-Message-State: AOAM532t9mqiR6uTFDD/8L52NTL9xZyCSRk+tHgwih2yyOKaYRV0fEDO
        ZQucoaExnWZWGa8KIsI7HyEMMgMp5OX10Q==
X-Google-Smtp-Source: ABdhPJxLWsAFPFjQsXeBMf+lvikD16Gm0ojPOHjdCUgHUkdqN4Ua0q2hYDZSWwuHhFmZAfzcYxdxDQ==
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id q186-20020a625cc30000b029020354bee4c9mr23737751pfb.80.1616995534347;
        Sun, 28 Mar 2021 22:25:34 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id fh19sm13813209pjb.33.2021.03.28.22.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 22:25:34 -0700 (PDT)
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
 <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6a9d24a9-6942-97fc-550f-6b9b61264a78@gmail.com>
Date:   Mon, 29 Mar 2021 12:25:31 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/21 19.54, Chinmoy via GitGitGadget wrote:
> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> 
> This commit lists the special strings used with `--date`
> in `git-commit.txt` and also a brief explanation about
> the strings in `date-formats.txt`.
> 
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---
Is date format parsing specific to git commit? If so, then
why not date-formats.txt be merged to `DATE FORMATS` section
of git-commit documentation? Also, what commit this `--date`
option first appeared before you write this documentation?

> +`tea`::
> +	Change commit time to 17:00(tea time). If the current
> +	time is less than 17:00, the time will be set to 17:00
> +	on the previous day, else it will be set to 17:00 on
> +	the same day.
How useful is this argument?

-- 
An old man doll... just what I always wanted! - Clara
