Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591DF1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbdLOPnk (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:43:40 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34208 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbdLOPni (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:43:38 -0500
Received: by mail-qk0-f172.google.com with SMTP id d66so10841310qkg.1
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FLepbOwZFT/Hh+Ecm1pn8w3aWa/IDJGv/yz5sB+7DRg=;
        b=HXyHufQ9TqrtRiFpalh5W/lZn/DDUuJ0XECntOsTiZDIg2Z03WwlIdolrIPnJ1wFA+
         E00fR3IC/piteQq/HxQjvFOURWvqnGpRGd3Eb49WKnERdG2zzIvePR6fz0kQ5qwCyQdm
         /QLzWlcLSRkEROnmGxQJXfbWJrYZyMW3TStTFk1p24cD1j4S2/fVqOWJZcP8MbT3Sa9Z
         /F3eDAAvcCPs4v4pbdcWIHmw02/Dr3B4vuXObHm0S2AUeQqpY71H+IbpW17DNMEDpPEg
         QsM7/ep28NmSi8cju92DutMHPtOblmVC5+6+5AVkx95Q8QGwlE2hdaBk/g2U0s4idZOm
         ljrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FLepbOwZFT/Hh+Ecm1pn8w3aWa/IDJGv/yz5sB+7DRg=;
        b=r3RhQZKHf+cVEvBTgAAihtJC+BsfM3SxTiRAQVpct4ezMSxcznDGiD2iGgVaKuhz3b
         BpNsFhKpTd1Md7XBlFHiKg7gcIkGrOQlCBTfDw/4N/h0femJboOB9fNjwZN6jGxjxpv5
         0UpEXkrAECnR5uhbNnLlCWdL0vWSyfjAci7kDQk7E1BcuvKR6vtTI59k8TKJ3+bkLLFK
         umvrZ4GZC6um6NtCxzl864GsuxClCVsmWXOREsSOs6cBrYg2myUvqVe9ZWgHG50sEuEr
         GbQn40yrey6bxa/vex8abXWS1lKOVWOGZFRaAvSEC4c+CxyM5Wn/SJVlK5o2ih6R6dJy
         6r3w==
X-Gm-Message-State: AKGB3mKgWsvfZVdBJOdiI+BdcAVvoXbus99AdFwwY/Fa/+0XsVu1bd+p
        fxNM+f952zn+P2oTXUcYQW0=
X-Google-Smtp-Source: ACJfBouKcHxmHnhZNbCl86t8ke/aFOWJeuYl/zV/bNulMa/Pl3EDpw2/CCNNKO9YTgp4UoLbpzQtCQ==
X-Received: by 10.55.207.216 with SMTP id v85mr21503895qkl.331.1513352618056;
        Fri, 15 Dec 2017 07:43:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b47sm4320979qtb.89.2017.12.15.07.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Dec 2017 07:43:37 -0800 (PST)
Subject: Re: Question about the ahead-behind computation and status
To:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>
References: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
 <20171215100835.GC3567@sigill.intra.peff.net>
 <88175f57-082d-ad61-c2dd-53ae50540460@jeffhostetler.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d16339e0-54bd-073b-fa4a-7c3a84a025e9@gmail.com>
Date:   Fri, 15 Dec 2017 10:43:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <88175f57-082d-ad61-c2dd-53ae50540460@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2017 10:08 AM, Jeff Hostetler wrote:
> On 12/15/2017 5:08 AM, Jeff King wrote:
>> On Thu, Dec 14, 2017 at 04:49:31PM -0500, Jeff Hostetler wrote:
>>> [*] Sadly, the local repo was only about 20 days out of
>>>      date (including the Thanksgiving holidays)....
>>
>> Taking 20 seconds to traverse 20 days worth of history sounds pretty
>> awful. How many commits is it?
>
> 150,000 commits, give or take.  The graph is many thousands of lanes
> wide because of the merges and that isn't helping.
>
> (But I should give you folks lots of credit -- it *only* took 20
> seconds to find, unzip and decode 150,000 commit objects and walk
> the commit graph.)

To give a few more data points, I created similar situation by checking 
out a big repo I hadn't updated in three months and it was 16,000 
commits behind. That took 1.5s to calculate the ahead/behind. Moving it 
100,000 commits behind it took 5s. This repo has about 300,000 total 
commits versus the 1.5 million commits in the Windows repo.

The biggest reason for the 20 seconds is not just the number of commits 
in the ahead/behind but how many commits are walked (including common to 
both branches) before paint_down_to_common() breaks its while loop due 
to queue_has_nonstale().

Thanks,
-Stolee

