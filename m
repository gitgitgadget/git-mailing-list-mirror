Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B1C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBIUxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIUxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 15:53:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC76EAD
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 12:53:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso2561752wms.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tR95oFsTE4mbuGme/qkqUw2cvoV0pD0IhGRs3DPOLkQ=;
        b=n9qoYaW9JYIOnsriv8grqz/sm7/FXKUz5WITUg6qYsRox1BLVaCO61XQw767DKnf0b
         bFdnZZ2RTUkC+PtjdFXZr+JhVgcaiw0RHNYgFnMEUwduvQpqtrrdUy/YK3nLQUNfHPqf
         WM76zwTUgOOa6CcFfgauF/2beiz9VldUTikbTvHAB7TcFCybJHr7O9paqWG3ykQvx1wN
         VDtcOD2HAzQ08qCHOUoMDarXBkybHpApLSP93wzIRF7OH2jn1TNGc5bqkPpUT1KAA/nE
         XnOss2tQiy1bAJbLTr+pwrdvMkdo+WwiFOQxL701DJ004rlgGHj5wn4mDisbQYuBT3wY
         Cmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR95oFsTE4mbuGme/qkqUw2cvoV0pD0IhGRs3DPOLkQ=;
        b=Id1h4CUVvmbf9g6tJZq7I+rhTKkAWa4GSrKPZbbaaXsspQZe8sfM6oOC0Qfw0WzOjF
         n4dIve6izPiLxosGuVCtTJDGReabHqBTyovlGlHPM93OuBmHBBnemvWRAlhMO7+1jhoJ
         /bJ920UJ9cpsWignMeUiSQK6q2DMW385V+1J41SNvMGkRGkyAJSTIwE1QjBDJhrH99oD
         zKKe2WyHu1RmQzTZ0d6qdRzB35mmoJtlRgk5KP/xJtx6O7qTb5Sg6xDL+4Yaq+6jpwBa
         NldelAduCLQLJCcN5U7NR0Hvm03mWFrA5xXblvYkY11m8Qs3C5qCN8sgj8u8urHGI7s8
         q2xg==
X-Gm-Message-State: AO0yUKVU3+WWbl726+xL4kB8wUqFXGoSIbc8sB8bjlsfx7pLd2VIOQda
        tJjWMGjt/VsT3wcTS6zTZGw=
X-Google-Smtp-Source: AK7set9eQ1gsUdCi4NsEstvfzfjduiRX9aOQC9VBdRZZENgeij3BiASiPlP/83jiY3XUnmeETHcOFA==
X-Received: by 2002:a05:600c:1c9b:b0:3df:9858:c037 with SMTP id k27-20020a05600c1c9b00b003df9858c037mr7580507wms.12.1675975997725;
        Thu, 09 Feb 2023 12:53:17 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c2cd000b003daffc2ecdesm6363275wmc.13.2023.02.09.12.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 12:53:17 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4a09db46-5c45-c953-d3ff-383499ab0e21@dunelm.org.uk>
Date:   Thu, 9 Feb 2023 20:53:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 5/7] diff-lib: refactor out diff_change logic
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-6-calvinwan@google.com>
 <4ae106ed-bfa8-2824-c0c7-6cde32dbe369@dunelm.org.uk>
 <CAFySSZC31aT4zu=-y1vBBd_Z=KWWYn3-7yziLfVbeK9Foc9c3w@mail.gmail.com>
In-Reply-To: <CAFySSZC31aT4zu=-y1vBBd_Z=KWWYn3-7yziLfVbeK9Foc9c3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 08/02/2023 23:12, Calvin Wan wrote:
>> I worry that having three integer parameters next to each other makes it
>> very easy to mix them up with out getting any errors from the compiler
>> because the types are all compatible. Could the last two be combined
>> into a flags argument? A similar issues occurs in
>> match_stat_with_submodule() in patch 7
> 
> I'm not sure how much more I want to engineer a static helper function
> that is only being called in one other place. I also don't understand what
> you mean by combining the last two into paramters a flags argument.

Are `dirty_submodule` and `changed` booleans? If so then you can have a 
single bit flags argument made up of

#define SUBMODULE_DIRTY 1
#define SUBMODULE_CHANGED 2

Best Wishes

Phillip
