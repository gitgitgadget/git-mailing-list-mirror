Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726041F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHUXJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 19:09:08 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:40430 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 19:09:08 -0400
Received: by mail-qt0-f176.google.com with SMTP id h4-v6so21682442qtj.7
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=O6ILkxCoc/LUM3IsmjLJBRypcFUFq+Ru2wPwh0jX1SU=;
        b=ctmaDvA09LgvCZ52+egwRQPS1/T8LX9zj8hqI6L8MoV9X2wV/cxBBxx2U+YG9p8cW+
         f9lK2XaFm+UwzFH8d9/7lC8EdDyW4YwJBLY2sfiAjiJclP22yLJBGOpxWLzUhn/ZotfY
         6jDz9vYOTMEJRQMoA56L+9UrsO2d3AY/r2GR26fLq5mgbWKSiyuoiDDk5gtLcR+1TyJ0
         0C3sM9CHxO1ySgk/13RkmhXa6XPvLj68K2wSxNaJBEaP/qK0s7qX7v0OXSM1dMOgF+21
         1aDAsS7a6A8rDsJeDAkapeKaugCPq3/U78k7Hj+LVWAS5UBhXOanIK1fiB07F5r1l26x
         fUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O6ILkxCoc/LUM3IsmjLJBRypcFUFq+Ru2wPwh0jX1SU=;
        b=SYYEwjczvKtNFB18oWnqOYjlqPGB0MY0fIdJVAPXhifHUMXCiTgwL4xitHP7y+NZ5l
         D2Dqi7Yn7J2iSm/OoG/Ay0Xle8VXv448z7L/LHmsxsLS/AqnTnnfxSIikbofwF4vd4PH
         xxUKOGE+PWKw6LI+D66SkDkqIoDVCB5K10On1iNXoKF+wW8NL7YjeNlUaHoPjOPwkRw2
         hxwY2fd6fUG3xGnv5t+UpDl7xspz4+SJ/b3H2vBy/Cb1PN1gaKpjNlW9cRUKeKsrEf2r
         w82PuHN5+XttLrys0OvAWjjXvvbvT3bn0gxtTNStXYqwQPM8LtGI0IPTFechpv9kwycB
         5nhg==
X-Gm-Message-State: AOUpUlFDUowT8qP2r/38jCxzoyfpOSQAyWsrRfzOj6/u0c5LNQ7LzeqB
        ILzPHpu557AJRzioy+fDQq/O81it
X-Google-Smtp-Source: AA+uWPxo1AvneIuAs/HV+2tYX5AHkM0hgziVQGEkfUD/19LCKZ1tWgnS6Ak7T83aUCSI1TqG4vxNxg==
X-Received: by 2002:a0c:b131:: with SMTP id q46-v6mr47965859qvc.168.1534880856439;
        Tue, 21 Aug 2018 12:47:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id e29-v6sm10015870qte.47.2018.08.21.12.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:47:35 -0700 (PDT)
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7dadd117-e7f4-4d15-b907-043718022494@gmail.com>
Date:   Tue, 21 Aug 2018 15:47:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180821190701.GE30764@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 3:07 PM, Jeff King wrote:
> When we do a bitmap walk, we save the result, which
> represents (WANTs & ~HAVEs); i.e., every object we care
> about visiting in our walk. However, we throw away the
> haves bitmap, which can sometimes be useful, too. Save it
> and provide an access function so code which has performed a
> walk can query it.

This makes a lot of sense. Based on the amount of time the "Counting 
Objects" blog post [1] spent talking about delta bases, I would have 
assumed this "haves" bitmap was already part of it. But, I can also see 
how it could be dropped if you are focusing on performance for 'git clone'.


> A few notes on the accessor interface:
>
>   - the bitmap code calls these "haves" because it grew out
>     of the want/have negotiation for fetches. But really,
>     these are simply the objects that would be flagged
>     UNINTERESTING in a regular traversal. Let's use that
>     more universal nomenclature for the external module
>     interface. We may want to change the internal naming
>     inside the bitmap code, but that's outside the scope of
>     this patch.

I saw the uninteresting-vs-haves name confusion in the patch below, but 
I agree with your logic here.

Sorry that I'm late to the party, but I was interested in the topic.

Thanks,

-Stolee

[1] https://githubengineering.com/counting-objects/

     "Counting Objects" by Vincent Martí

