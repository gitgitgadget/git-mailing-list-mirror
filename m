Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B1C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E19020658
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAcosyLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCSIED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:04:03 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:41141 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgCSIED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 04:04:03 -0400
Received: by mail-pg1-f182.google.com with SMTP id b1so839889pgm.8
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OZLa/cBOHLZS7dc7eRoA2WVNBHLM4pM0wiPdrqr8Hg=;
        b=dAcosyLBL/LKrNrecr67PhAet2/CgU0CvVQlPCPnMgkrUUC8jCl0ENMmxRARc8x/nl
         eWh3WRZYerGfs/CJ409vOZg+N2i76rA68zDSaYfYNWezZXz/kZ6I21E0xRIbl6D5Hh8w
         M/NbB3MmC/rHXBMMsO22Gxko5GeVpzwLz5MgAF0eymyYNf85RNBlH9s+EszSmczCCQ5T
         073KCtYXaG2DQtxIyC4jBeoma/6wnLNJAq8aED2EG1ebS6Gv11pu5BA0bESY2DdIQRTB
         0cOcxe2zU4NYnoBehom9MsdMi/iS3WkWZsSvjzDAzBM3XxH+BetszACrWWzCHBXJH0sw
         O0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OZLa/cBOHLZS7dc7eRoA2WVNBHLM4pM0wiPdrqr8Hg=;
        b=H5i/WwZUCsGwnBmG0phvURCmLBMrw9hJ+SJFCkf32bX3qLnRhvabvqGCKGWNutv9df
         ah+AOi3BIcTRG35yTYiamk/VwqWmpMmGi+3EUppM4vQayABvfZMdf1YlFyjXQYxSXjAL
         //SiY0BYCSgaqsPpTqJ5RlPC+JUa9y67A8XGCtp1rSQmWfIiLJdYCe0cfKDd46TbJ0mU
         ZWlyz4RjzKOJBG6DudxDEkUVZ+5OUd0ydHuq3bRQ746qt94OzZkADs3MhUGPcbOtVJbS
         CS3kjYAXOzqWxCsnDyrQnscii/At6rjgdRusqQDYcTs+3JQx7sajsYITnsf4oENtpoEY
         CEQw==
X-Gm-Message-State: ANhLgQ2bcV5C20PLVCrEk/oL0dmEBhNIXbEbgmh1vIphHVBqflD0goK0
        5J+N91kNOqjAXGlDhmY55XZCDm/7
X-Google-Smtp-Source: ADFU+vvd31unkKeZK1cBavsbgsjna+T+hWkQynSspC/2ZeNGXPro7c48Hx8HwP0JCZzamLESR/MkuQ==
X-Received: by 2002:a62:a119:: with SMTP id b25mr2677298pff.158.1584605041753;
        Thu, 19 Mar 2020 01:04:01 -0700 (PDT)
Received: from [192.168.43.191] ([106.198.9.151])
        by smtp.gmail.com with ESMTPSA id f127sm1405189pfa.9.2020.03.19.01.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:04:00 -0700 (PDT)
Subject: Re: [GSoC] Microproject for git
To:     harshitjain1371999@gmail.com
Cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>,
        shouryashukla.oo@gmail.com
References: <CACuU+s9BsWVCMXpp6KgJ-NaDuadcegZ2kVSMmuAYO9YquTK8LA@mail.gmail.com>
 <20200318192719.1127-1-shouryashukla.oo@gmail.com>
 <CA+CkUQ-gRMR2Q2ZCB=oa0mUV9fxtPKAfnpeG+mPZU_PqPKXVbg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b7173e2a-a1d1-8354-4b9b-cbef45c6093d@gmail.com>
Date:   Thu, 19 Mar 2020 13:33:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+CkUQ-gRMR2Q2ZCB=oa0mUV9fxtPKAfnpeG+mPZU_PqPKXVbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harshit,

On 19-03-2020 01:35, Hariom verma wrote:
> Hi Harshit,
> 
> On Thu, Mar 19, 2020 at 12:58 AM Shourya Shukla
>> I think you must know by now that we submit patches here
>> via the mailing list and not pull requests.
> 
> I addition to what Shourya said, you can also make it easier on
> yourself by using GitGitGadget, which takes out the pain of sending
> patches in the required format via email, see
> https://gitgitgadget.github.io/ for details.
> 

There's also a MyFirstContribution[1] document which could help you. 
Particularly, there's a section[2] which contains step-by-step 
information about how to send patches using GitGitGadget.

Good luck with your contribution :)

[1]: https://git-scm.com/docs/MyFirstContribution
[2]: https://git-scm.com/docs/MyFirstContribution#howto-ggg

-- 
Sivaraam
