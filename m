Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE3E211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeK3B0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:26:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44166 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731368AbeK3B0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:26:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so1107680qkh.11
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+89KOEPJTLuhsKBGxYyznslPn6LmDCAxgByfMNzVZig=;
        b=CXC4nz7xJETELFrSXFzzf8gf7zgA+/thAAh1t+HePUui5abqjULTZriiUBaDc5qzZ1
         xJqu/qe5Axx3sCFRMjs+iWkNVBheF4UJiZy2HhSnzf1F8w1aNtVLGZ5nyHo+SzxtPldw
         De4sXtxfztjqANeHPUS/LhC88PLcXTQLKg4VeQCX6/83s0/2OHlXtt8XOgATsqbTM2Ig
         blei/EAS4MsVRx+MxFLbrb0PrlxogHQTdNikpl7HupjBBzJKnrobImWxpDHpVMCx9DVb
         EZHJaj6hb3TIDs0FyzIegkt/PocZ2C6WTH/5yG9vKXLrDTHZhOQZTEZjf115pqi1vu3m
         iEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+89KOEPJTLuhsKBGxYyznslPn6LmDCAxgByfMNzVZig=;
        b=ufIW8YBAMSskW/pVfFTfdDf9A466OIuiFoJBZ9i8OS+NPPw7qADpPFQ53BGmGOL32O
         zEGn642gbGnNfTAK/LgBKXOT4HShRGTXG95S6E9CVmnpivAAGLBXMSexyNYvscqMzZGD
         b6w8fzu/jFt1Kqk7b6v8Ldm3ApATB8jlvFyTjce2T9WXkl/XW1wNAZAgjPlKxu8KYjFn
         OgRscHhn4XIygdSd+S7vR1ElM9KaxttFy9BI8RhimsNCn3Vp+edesr8TsGn3djsGuuwp
         RfwgqkMmPHfeou0GLSkKmeuCiIBiNSjhfIFg4WIKu2A/gzS0UQJhYg7osTBDxOhWd2y5
         HGuA==
X-Gm-Message-State: AA+aEWblCi94rNAI0p306EviXjMpTVyRopRkl6ydyPW8UQ55DS0ri1la
        SetKK2oaRETJV8kAPOf8QSM=
X-Google-Smtp-Source: AFSGD/UATLCmB7xjULomFCHQA5jMcmdJSEwsbPTJa2p+VMuhTmhjAsTX8MHKqi1m0BMBNE9p6iSRMA==
X-Received: by 2002:a37:cc4c:: with SMTP id r73mr1453122qki.120.1543501231542;
        Thu, 29 Nov 2018 06:20:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:cce3:7926:9a9:2f0a? ([2001:4898:8010:0:b619:7926:9a9:2f0a])
        by smtp.gmail.com with ESMTPSA id r1sm1256399qte.28.2018.11.29.06.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:20:31 -0800 (PST)
Subject: Re: [PATCH 3/5] pack-objects: add --sparse option
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.git.gitgitgadget@gmail.com>
 <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
 <CAGZ79kbVGyX=Ky9HvmUGWPoHdLJYqnPTNda2kT3aC8XuHnH3+A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e9d4d2d-561e-fcbc-48cf-374dcb9ce009@gmail.com>
Date:   Thu, 29 Nov 2018 09:20:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbVGyX=Ky9HvmUGWPoHdLJYqnPTNda2kT3aC8XuHnH3+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2018 5:11 PM, Stefan Beller wrote:
>> +--sparse::
>> +       Use the "sparse" algorithm to determine which objects to include in
>> +       the pack. This can have significant performance benefits when computing
>> +       a pack to send a small change. However, it is possible that extra
>> +       objects are added to the pack-file if the included commits contain
>> +       certain types of direct renames.
> As a user, where do I find a discussion of these walking algorithms?
> (i.e. how can I tell if I can really expect to gain performance benefits,
> what are the tradeoffs? "If it were strictly better than the original,
> it would be on by default" might be a thought of a user)

You're right that having this hidden as an opt-in config variable makes 
it hard to discover as a typical user.

I would argue that we should actually make the config setting true by 
default, and recommend that servers opt-out. Here are my reasons:

1. The vast majority of users are clients.

2. Client users are not likely to know about and tweak these settings.

3. Server users are more likely to keep an eye on the different knobs 
they can tweak.

4. Servers should use the reachability bitmaps, which don't use this 
logic anyway.

While _eventually_ we should make this opt-out, we shouldn't do that 
until it has cooked a while.

Thanks,
-Stolee
