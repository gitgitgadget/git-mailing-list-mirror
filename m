Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1854C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E23C20678
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnYonmww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgA3POZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:14:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45492 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgA3POZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:14:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3393542otp.12
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3xXpu1bicVH+lXr6hwLwkNZdbKo3ECFauPiQ+VxW5VE=;
        b=MnYonmwws/cNiZRY9Eo01KxpHBhAy5tI8wpPw3zo8NAbxybGjw9y66mhfwJc7X8bYS
         e59ji9Wd3SwtLCNthI4b00uJ7bNu81PxsBJOT0hQhooDiBLSeOkeiRUJK1f+9+EgP0Cl
         40XFWCQ0Zt9zi3fCrhgY1pAC0vflH+p+vpTkTDDJ35EQcTNYB4MlLYw9qmYYC2RH4cZZ
         6DA/qeIT2qXH6CjjakYWWzpK4lKt6Pk9rdfy2Z37hbA3OElfFIfFx2LCiqhEF6RHfI+z
         SMZkKNW93IKvRASm76ds/BVaEIHvZ3mZiOjxNEscWEuW4MAa7zpxvvvYMRZ78Fv15lng
         jzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3xXpu1bicVH+lXr6hwLwkNZdbKo3ECFauPiQ+VxW5VE=;
        b=rXso0FMFZJ7YMM1T+LPMs3oY/68IlRZ+jIpvVdaQaM/qJnR5gDT8YAX498g6NXLb9Y
         kH6zWVaKPnNm9SYiUlBm0SxfiUEdPlTG1zt1Ivib2E5fazHHFyB6Lh18AF2k24RAJALd
         FGTDlKrweplasbjXUp3Su/lDw+4DtWvY/jOHOb8ueFCeZv4ZnavSDyzReFtaRvhUOuOR
         WTWnxlRS/IM1ftXilvbAUu4q+2Zk19eQDP5NUNAeJja6W6zXO2zrQ+ABjkn9GS35UhlI
         QgRBHpUkMQSQtHYDseSYtnbpjg6Qg9N8PqZfvaSpefVnb+x+V5SDl48Y4kdj7KTVHdMI
         ncuQ==
X-Gm-Message-State: APjAAAWAXWYS2iVPi5L+ygH1npBqxGLRDKow/ccm2jlcQhjYkRn+l6Yg
        0xZaq0iMG9j2eBLbkhjnJhg=
X-Google-Smtp-Source: APXvYqxVZwihYQcbVrA8rkfscHL9ZqHBdLCC7UCUg5xJlN9fB/FVbkP732RNCwU/4wcK68/KGBDnzw==
X-Received: by 2002:a9d:6b12:: with SMTP id g18mr3776762otp.211.1580397264706;
        Thu, 30 Jan 2020 07:14:24 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x22sm1937255otk.23.2020.01.30.07.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:14:24 -0800 (PST)
Subject: Re: Converting scripted commands to built-ins, was Re: [GSoC]
 Exploring Previous year Projects
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub Narebski <jnareb@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com
References: <20200129171248.6217-1-shouryashukla.oo@gmail.com>
 <86k15ars55.fsf@gmail.com>
 <nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gmail.com>
Date:   Thu, 30 Jan 2020 10:14:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 6:10 AM, Johannes Schindelin wrote:
> Large parts of `git submodule` are already implemented in `git
> submodule--helper`, so that's a head start (thanks Stephan Beller!).

As I recall, a bit part of what prevented more going into submodule--helper
was isolating the_repository and allowing multiple repositories in-memory
at once. That effort has stalled since Stephan has moved to other things.
(I will also admit that perhaps I am wrong: is it complete, rather than
stalled?)

I would be happy to see more progress in this area, and it could be a good
way to get familiar with the codebase and submitting patches.

> Realistically, I think that it would be possible for a GSoC student who is
> already very familiar with the code base and with submodules to finish the
> conversion of `git submodule` in one season.

Even assuming the most generous definition of "very familiar" I'm not sure
this is the case. But I also don't meet the bar of "very familiar" when it
comes to the submodule code.
 
So, I'm sending this message just to say "DRAGONS BE HERE" and recommend
taking on a smaller project.

Thanks,
-Stolee
