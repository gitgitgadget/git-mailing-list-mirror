Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DC21F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 09:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfH1JEC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 05:04:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfH1JEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 05:04:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so1661106wra.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ncGOKpiW2yjdnZrFnTgQ8vlzmhHMLJpSowJ25mlCkDM=;
        b=JlcbG21puSVScawBF+E2cOA/qSdjlkPuw/4YsIt/CxUotcpYIKTZgljPUCNQ7TbUwa
         F1qbcapoqXOBS08EzZ6oM/YA8lu0MgG0OIlGyQym/ahi3FRt9fgadtDKMH1R/264KBZr
         8OvyHIKFzDn2Zi5Z4iVZa7V+SywLx7KDuwVUYh2D5HzlaBhuyzXQb/BOC7h8bEVFMgoU
         eR52Mp1bNJYUal6lZL2IgnKTpQYuNupLsvtGlRT9K1kC+aZFm4v8XotatctjRIyOYwQ5
         L5d4Ka/vBWKg0oi2pLo8O7n1TjoxEWNFt91PUGXrX2v/TpRQkgNE7BWAHs7EA2byvjrf
         SAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ncGOKpiW2yjdnZrFnTgQ8vlzmhHMLJpSowJ25mlCkDM=;
        b=ajnWFkqzBMpk3oca3cy7V/kRwdF7u38qWFMOLUA/7EtO58yGZL+xUNtRJ4U3Jzd21W
         /8qZQMrtjNyGKxylI/sMnhY+Hiv6/cI+RU8VpquJQEAew9bzX/KrgupXJP5Me1eXYGbE
         QTyH9nGlBRwdBfw6b4AFxdR/F3TNqNBlINTA2/x+zqwyneiUEmizhJOhPwBM+l1HD+w6
         fNy1IbVPz59RLqvlQewK00usikBUYzBz7el4MCPfLHbgcheBtznxexL8Htv9Aq7//X1M
         mH9WMsaB38yAWx5+042ZAJVvUJQTmwUzk2LQT9wfzaoHdBCjUdmtY8eqLVhge/PNV+sy
         mMhg==
X-Gm-Message-State: APjAAAVfCHQbWGRJ1eiis4Dy4RJiluCerAuCmUqIaniTwKiZUj8iGX5b
        yVRW7xT5T2jUhbeLpAfYNVmQFiaV
X-Google-Smtp-Source: APXvYqxb2rE555pwJDGWZu33U0C1GcEYv/1kUsdrGjlPIPAg+/2RqrHvG3hkmFE083zY2HTzeqD08A==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr1955908wru.1.1566983040112;
        Wed, 28 Aug 2019 02:04:00 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id u8sm1748160wmj.3.2019.08.28.02.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 02:03:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
To:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-5-e@80x24.org>
 <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
 <20190827094923.6qhwqosiucsi43td@whir>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8beefab6-b7ef-28d3-41d6-c5a5c042ae9a@gmail.com>
Date:   Wed, 28 Aug 2019 10:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827094923.6qhwqosiucsi43td@whir>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 27/08/2019 10:49, Eric Wong wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi Eric,
>>
>> On Mon, 26 Aug 2019, Eric Wong wrote:
>>
>>> By renaming the "hash" field to "_hash", it's easy to spot
>>> improper initialization of hashmap_entry structs which
>>> can leave "hashmap_entry.next" uninitialized.
>>
>> Would you mind elaborating a bit? This explanation does not enlighten
>> me, sadly, all I see is that it makes it (slightly) harder for me to
>> maintain Git for Windows' patches on top of `pu`, as the FSCache patches
>> access that field directly (so even if they rebase cleanly, the build
>> breaks).
> 
> I renamed it to intentionally break my build.
> 
> That way I could easily spot if there were any other improper
> initializations of the .hash field.  It's fine to revert,
> actually, it could be more of a "showing my work" patch.

I'm still a bit confused as the changed initializations already used 
hashmap_entry_init() and so presumably were already initializing 
hashmap_entry.next correctly. Is there a way to get 'make coccicheck' 
detect incorrect initializations, this renaming wont prevent bad code 
being added in the future.

Best Wishes

Phillip

> (AFAIK, it's a pretty common practice, but maybe not here :x)
> 
> I've also pondered adding a
> "hashmap_entry_hash(const struct hashmap_entry *)"
> accessor method for reading the field value (but not setting
> it), but it's a bit verbose...
> 
> I'm also wondering where/if hashmap offers a real benefit over
> khash nowadays; the latter ought to have better locality.
> Would like benchmark at some point in the future;
> but safety fixes first :)
> 
