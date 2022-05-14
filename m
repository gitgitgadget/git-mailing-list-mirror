Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B801C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 21:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiENVSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiENVSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 17:18:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324B36317;
        Sat, 14 May 2022 14:18:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so15730155wrv.10;
        Sat, 14 May 2022 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xz8M/g9Zq/f5gutiLmOIYKicxnP4dy22Nv9/bTXZfwI=;
        b=Kp4EgbssYe/DHbaxBt3wQi4G6ajHHWdIMvZ9UhNMWLcW4TUBFlAZjM8XvJJDOK0QPE
         iDPQeb/3A79nMLOH2NN8zps43H8pS4ztj+EpUhdl+a2FPqmM4kRjmWLXIb4kRHq11YO/
         nEH43y4JZn+Fb/mmno82t+NrEtmmVpQYOzbd8VwSsdR1LNrK+TgngHUm10SaDfccVjxC
         omFNSkRHjGIONlbgkhIec0nQMI6FAJM3+N7tfD59BXwqxgvGEqeNh9sOOZR93pboC0xC
         NpIN8PyiUegoZeMibdwdPEYwfnTWqe56TtB4Ax6BshZ5vW/ZEv4hbXGFiL6JtlKe7q8Q
         HHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xz8M/g9Zq/f5gutiLmOIYKicxnP4dy22Nv9/bTXZfwI=;
        b=rzixSwgVp+Lg+a4d6PLeykMWuY5XCF9vi6fAGcgjs83czBWPnbjbb591uAh6edBKpQ
         p4hB8mqPsjtlfGUaVEsjjLaxbDfzIOvHZS9+b3FaWCEQ+ec04uBHs43VUfkjaHtPShYH
         A7BG0TphIIqUcGhNhthhMudR6Y3nlWz9f9KFGOSIhYdFVY96nUd6TRZ3QyZ86vyy0Ukd
         +r0dBODjgB7pRhUmX3WBeikv35EkUDJ9OVBcEiqqcOWOPhBRF3sCOYggoryQFk3mbijA
         ams8eskgQfOoUpqfg1PRFf1Rozi/hpPRD/4FNnehGcxe3dw3DM3gWv2aLLIJQCWJXNFK
         Xz4w==
X-Gm-Message-State: AOAM532dSveHw9meqG7JcVbaSH830FjLWsl7rJx8k0EBFh0iV1CnTPN5
        N8mquAMgJZUFkTxPPxoJ+08=
X-Google-Smtp-Source: ABdhPJyb5C7FhZbR5jiW6Cdych8bvBSS7+RZcbSLxcM+Hfb8IolgR8fKweS3eC6Un3EOofBwWcqTfQ==
X-Received: by 2002:a5d:4561:0:b0:20d:3a3:c111 with SMTP id a1-20020a5d4561000000b0020d03a3c111mr1294772wrc.609.1652563087713;
        Sat, 14 May 2022 14:18:07 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id f2-20020adfb602000000b0020c5253d906sm5414129wre.82.2022.05.14.14.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 14:18:07 -0700 (PDT)
Message-ID: <385751ee-416e-c2d4-849a-270092a06010@gmail.com>
Date:   Sat, 14 May 2022 23:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] getpriority: Only getpriority translation the priority
 values
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Theodore Dubois <tbodt@google.com>, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, Git Mailing List <git@vger.kernel.org>
References: <20220510220821.1481801-1-tbodt@google.com>
 <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
 <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On 5/14/22 20:43, Martin Ågren wrote:
> That said, something like
> 
>    git am -p0 ...
> 
> should help on the receiving side, by way of skipping fewer path
> components when applying the patch.

That works for me.
Thanks!

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
