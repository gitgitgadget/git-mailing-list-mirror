Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83246C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4343020752
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyuu626w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQMke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:40:34 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:46360 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgCQMke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 08:40:34 -0400
Received: by mail-pl1-f177.google.com with SMTP id r3so1529805pls.13
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R2hLeFnNcUs1ifz0nJXPew8c8vSPRn07jmNrAzXWLm8=;
        b=Pyuu626w+lENizsljg5Er/Nh3vnAPsVlP5GH6BWQFHzty+yUqP4mgCVgC8YPkEV2z5
         Ow9moxWJQujoMpKRv6QChL4pVwPENdRl24JE3X7o8pzPkQeq3ha1W3LHHXUHNtczLla1
         dhYgQhDqsXtLbEq0lP6DCkA2jTE6pBP9/aPY92pxQLVaKlKhPXjixMTGTfw5C0PhUAIL
         Zp4o1y99buyCXsH3LkIepCNT1h1fgQtRTo17xLFxygE2Y/TkZQVGuCtB02BFWL4eB/Je
         wUJZPKLhExvkE9NoUuH6U2yRCFatLdjrgnlNxnaJL7r4YDsGZjbQpPkchGAJNiGxkQUg
         bURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2hLeFnNcUs1ifz0nJXPew8c8vSPRn07jmNrAzXWLm8=;
        b=nGRs3BCi6EJY6rit9jjaHnUREyS2p6flWkZ5XNAOpWLd4HizqzyzVolbDvJ4RBmQTo
         xaUkhRtDMBaedDNpulFe8N5gOYplRW5XLX8qAcetoSRjReS8NNehrFaj8btk5UrHc2av
         tXuUji34aq1U8MO5bR0Fj2LZFX5DtOGx2CkLlyLBlss4oywmzl5vNJxW/XwV1MTy3Gtl
         mieWcFTCsZfDRIzPJqeev4Bexk24BTGme+WmDXfydM62EiIptoRxBTgVPo+ics0K+WM+
         2zbSh4rtDAV0Wwb8BWlc5TTg1lC2mJt4vYyO8sNxgjQgdjXb56sVaImcHzoRQ68VwUmP
         uqDA==
X-Gm-Message-State: ANhLgQ10UGZDxc3mWl9KREHFiFTvb18z45q3EtJe/k0npAtZs7iuDQTx
        pTnlC4bkv7mNrDOwrwGWRQg=
X-Google-Smtp-Source: ADFU+vss2BDGQC1ZBzod2Buv2tutJNgJ5DSySXB/TCkhR6fKqVFkVyaZv14kKdMFi8RMlJbZfUE8tw==
X-Received: by 2002:a17:902:778c:: with SMTP id o12mr4307149pll.324.1584448832598;
        Tue, 17 Mar 2020 05:40:32 -0700 (PDT)
Received: from [192.168.43.191] ([223.181.211.23])
        by smtp.gmail.com with ESMTPSA id e3sm2738898pgm.15.2020.03.17.05.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 05:40:31 -0700 (PDT)
Subject: Re: [RFC] Possible idea for GSoC 2020
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
 <xmqqo8t2hfxj.fsf@gitster.c.googlers.com> <86tv2s34lo.fsf@gmail.com>
 <86zhch7kyz.fsf@gmail.com> <d1a4998d-039f-65da-f18b-12ec714ec532@gmail.com>
Message-ID: <6158e62f-ad7a-c3cc-5e5d-9fde5d9ba34c@gmail.com>
Date:   Tue, 17 Mar 2020 18:09:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d1a4998d-039f-65da-f18b-12ec714ec532@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-03-2020 17:54, Kaartic Sivaraam wrote:
>> I will be extending those slides with more information about interval
>> labeling, and then I will update the file, and I can post it also on
>> SlideShare (or other site, if one can recommend it).
>>
> 
> Just wanted to note that Speaker deck[1] is a nice alternative to 
> SlideShare. I've not uploaded slides to it but have seen people sharing 
> slides using Speaker deck. I find the user interface to be more neat and 
> minimalistic than SlideShare. FWIW, their mobile interface a lot better 
> than the SlideShare's interface.
> 

Oh, and forgot to mention that you can also share links to a specific 
slide like this:

https://speakerdeck.com/lemire/parsing-json-really-quickly-lessons-learned?slide=13

I'm really surprised to realize that SlideShare doesn't have an option 
to do this.

-- 
Sivaraam
