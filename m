Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37DC83F18
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjH2RpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjH2Rot (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:44:49 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A911AE
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:44:46 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a7781225b4so3192867b6e.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693331085; x=1693935885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5GbwGW0AuA4ti/BGrgE/KUXuSu6baveG3wnTh2QUis=;
        b=OH+aM1xYObZ4hTe/xOlqPm71EtqNamVGOBsPDDnA1j55i9zGanl5T85GsRDOMa5JTM
         D/qtQXK2L0nL9xeis/RdbmPnApZSmrCLnBBOhMpJsogcsSTZW7WIz5meMZUy16rO446l
         MxT4riwvaY1Gji0HahA8Gmj5fimec8tNG+DyhOkso2Jfp8hi2lHNqy7IX8tA3cDU0mmD
         j4B2FfQp68wug3EnqZtHkLwUGT8h1eaLcSB/D70CNsnyDYi+Iv4m/no2PkFukVObJvQT
         PoayfFTdq6zqwIok2e227ix66yM9KfwOofF4TPvLWZ3mJGCc0hn+euHz6WvVI2Um5EA4
         2H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331085; x=1693935885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5GbwGW0AuA4ti/BGrgE/KUXuSu6baveG3wnTh2QUis=;
        b=RQfmpPzvByR8Ibf9/7W/KFvXIe4ZoZbcffjDXZJ3bz+uPVgH2Ek2HZFXGl6OFNrueK
         CDyRa7wcY1awW++wroygiEvPzbEP5KMX1a07UNGsWReeAfz/6Zh+OzKk0CvWU7x10nej
         OfZS6U2m9N3xxlAVdcWZd0QGzvCtwEHzLDA7kFcVKxoxV9iYyUo88jP5CFpFCiWMil4b
         th/s6O4ntspRM634lWd7hZyGpdC81OVZyUToSZGIZ8zFalnnQ+UAC1HesEU/caiuGG06
         d5RqTjUqXB3H2vG40Kk3xy8B317GJkwQLsZnUIDTENaeyEPXDUuZ5tm+jhkhQnoL7fum
         OMyA==
X-Gm-Message-State: AOJu0Yyb6j8L1jUI4zM3jCIJ6tAPfkRyN7Pd80ddq8PDjdZSkoaMQ2PX
        tPqiCKEyyB3mWk+a8YtWFuc=
X-Google-Smtp-Source: AGHT+IEi4E7mXCQ3K/C1RPEpGLslnYBzkD/Xt9b4+NDJxXVu2qtq9wkbQ3Qnjctjgr1iRh/Lqotv7w==
X-Received: by 2002:a05:6808:199e:b0:3a7:208c:4406 with SMTP id bj30-20020a056808199e00b003a7208c4406mr16711960oib.1.1693331085506;
        Tue, 29 Aug 2023 10:44:45 -0700 (PDT)
Received: from [192.168.208.87] ([49.204.136.113])
        by smtp.gmail.com with ESMTPSA id w27-20020a63af1b000000b0056c24c2e23dsm9346738pge.25.2023.08.29.10.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:44:45 -0700 (PDT)
Message-ID: <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com>
Date:   Tue, 29 Aug 2023 23:14:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Git in Outreachy? (December, 2023)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
 <ZOZSo7vJztHcvb4W@nand.local>
Content-Language: en-US
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <ZOZSo7vJztHcvb4W@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/23 00:10, Taylor Blau wrote:
> On Tue, Aug 22, 2023 at 11:44:41AM +0530, Kaartic Sivaraam wrote:
>>>> If folks are interested, I'd be more than happy to answer any questions
>>>> about participating, and overall logistics of the program.
>>
>> I'm guessing the mentor sign up deadline aligns with the project submission
>> timeline. Could you kindly confirm the same, Taylor?
> 
> I couldn't find any specific mention of it on the schedule[1], but AFAIR
> we can add mentors at any time after the Git project confirms its
> participation.
>

Ok Taylor. Thanks for the information!

BTW, I think the deadline to sign up for Outreachy is approaching soon I 
believe. The community page [1] seems to indicate that we haven't signed 
up yet. Given that there was an interest in us participating in 
Outreachy, I just wanted to check whether we've signed up our community ?


[[ References ]]

[1]: https://www.outreachy.org/communities/cfp/git/

-- 
Sivaraam
