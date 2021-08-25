Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019AFC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71B161100
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhHYFoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhHYFoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 01:44:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857BC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 22:43:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so13641922plh.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ov9CiyWCQ1S/X8G9eU8fIYXjDOPoD+rg7wTGlKKog8g=;
        b=T7x3I1F6ldEInM6ZnI1Qi3tU84pqwE4VNAen4fXdd1MGCOZXysmHSe3mgFRfQ3WIF5
         2ga+ji2ZRPCVPgf3gskMhhWeEHmGEtjaHn0zorDixI0ZNVkvqzHBVoC6yR1gV/iTp8Se
         WkPaMw9mydzmJVroGJpyRXHPX+QDlEevsoXfQG9tR+Io1jnfMsCyaKRkXjVpBUPD9j1O
         Fb3N0wWcxbBAPVaEEitxlz1JtZuLS+ObcdCXd/OokKWKsSH7qWkz/zfWe9G0rO4a6aAV
         kJLB3/8i9j63BprRXI8wQCvvXSi9jszVkLgjfwba5mnWczj4kYYp9DQ9vwbotQfKk3e1
         Bb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ov9CiyWCQ1S/X8G9eU8fIYXjDOPoD+rg7wTGlKKog8g=;
        b=dNGAJhlr8MWj3/vO3Eg7+UpR7NvejpnYB/yTo1/wQxZc2c38F6fiq9xDsCRbUSpZ4L
         fxDHDc+4JHKTfmvI9idL2KOzwBFUWnN/c7AsYxmQeLQxDcO6ztGiO6VFsD8iCiqtvm/6
         ZbJlvcA5PW4+5h1Gmrj5wFdQfH9beUmpn7vwlHD6yc11MXbCL3K0KiJiKBjrcIQqbKni
         CCoPkcrsjYiyIFpSKCAsXhVf8qs4PRl3ugNNBaOgiY72bTFH1Oua8cJM78/OWUmNa2o7
         meFgirs8EPwMe0mNBHvF4UA8230Xevb+nZ4eRSE5MKz7Y5cF+4VBkUX9I8nW9s+7qh39
         DT3w==
X-Gm-Message-State: AOAM5333bh5xm/3lKQyRgPaiG0PK5azE/5qHqOh9oQuYMfF/qt2HtSHc
        9nOYSWnDRgU9zawz4o1YRuELWIRlknY=
X-Google-Smtp-Source: ABdhPJypIOoIQ5mb+eOiRWvQDA7ZPEP/jwCKdbLFl9iio6aQIRXGlHCZd0wCJqDYAwRjpPNpjAGAUQ==
X-Received: by 2002:a17:902:7401:b0:131:2333:1a34 with SMTP id g1-20020a170902740100b0013123331a34mr22303138pll.58.1629870195518;
        Tue, 24 Aug 2021 22:43:15 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id p3sm4139858pjt.0.2021.08.24.22.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 22:43:15 -0700 (PDT)
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
To:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2fe5e6c2-3887-6d7d-7240-2aa9f0e70873@gmail.com>
Date:   Wed, 25 Aug 2021 12:43:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/21 23.41, Yuri wrote:
> In the FreeBSD ports repository I resurrected the directory (that was 
> removed a long time ago) with the command:
> 
>  > $ git checkout {hash}~1 -- math/polymake
> 
> 
> I made local changes to this directory and called 'git add math/polymake'.
> 
> Then 'git pull' complained:
> 
>  > $ git pull
>  > error: Your local changes to the following files would be overwritten 
> by merge:
>  >   math/polymake/Makefile math/polymake/distinfo 
> math/polymake/files/patch-Makefile 
> math/polymake/files/patch-support_install.pl math/polymake/pkg-descr 
> math/polymake/pkg-plist
> 
> 
> No incoming changes affect math/polymake. Nobody has created this 
> directory simultaneously with me. There is no intersection with incoming 
> changes.

Have you committed or stashed such changes?

-- 
An old man doll... just what I always wanted! - Clara
