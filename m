Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA98C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B493720838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5qY6wTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGPJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:09:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGPJL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:09:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so2476151qkl.7
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0WuNGMWsZzHatvIQpcRt+WxecI1KQuxRd3007SmT53k=;
        b=d5qY6wTNA2S0nP352WK8bNN6LaIMMG0z7njUvSAT4zYp8mUghS5jChgcI9UYppSuVE
         wMsPkE38Og5dwf03pj8EN14SZdcJ+WM7OXQsvJU4o2XuyRN1xGRyElh8yE6vkmNsMI4u
         s+NCaTuC6HIYiMA0qAU5AJKC778dZpBbKnVzwV/4yJGQeb0bAN8FndNBVZr6gKh7jJ0a
         h13seMoUlflazaoXYXjFBz2qJm4/xU+kYZbk1mJIhXeEgkWey74xTc+uneqL5qcLK3nq
         0AllO1111TMU1R47YkruYQedktwnW9gGyRx2jyiO74MJbXYE7sbtFMyM+U7D+aWsiKCr
         z0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WuNGMWsZzHatvIQpcRt+WxecI1KQuxRd3007SmT53k=;
        b=bipL+HY414M9Z4Ga1Z32UgRlbcO/pyivjtkt3ULr14HYaO3xYIewhAYfh6WULIGGjr
         qEqpQxI1V1T/TXwIipVf9tNF3RdBxt4SGGn3m6DMLUhvjwERounVE1rH4hFNyTIAmRfF
         tC8IetIgJ108QSyZ76yI4W3L8Uq2UGFTElLQ/L1Gd2zTHmwVyaMX720wnN97diwJDw4S
         CJqIQ37f9sPAbB7CvII/8qzZbUhCpM2fCukTCnsEvi1EcS+BUXH5ngqyr2pPDNeuYVCF
         prTqFG9yJjJAfKvgzolt7l+yga8PXV0yEnxKzB2Fax6mCQAp8UuIE82fs+APA6Denjnk
         zjbA==
X-Gm-Message-State: APjAAAVAkxkm3QnetgNjY1ZXAkXYwVs86VOGTrkre00MVJoT3fEHRDbM
        9hyOVF6xT/254dClaZCUAA0=
X-Google-Smtp-Source: APXvYqxkl68ipyHi+7i8iLKlkt+Xxv2pNW2/YXnXl3AoSA5geLZy3OyjpqrYsWBetj20qUOcgP4vqg==
X-Received: by 2002:a37:4f51:: with SMTP id d78mr7611715qkb.28.1581088150843;
        Fri, 07 Feb 2020 07:09:10 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:18c0:79da:271a:172b? ([2001:4898:a800:1010:c9f6:79da:271a:172b])
        by smtp.gmail.com with ESMTPSA id v78sm1418476qkb.48.2020.02.07.07.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:09:10 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        jnareb@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <20200207135249.GD2868@szeder.dev>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
Date:   Fri, 7 Feb 2020 10:09:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207135249.GD2868@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/7/2020 8:52 AM, SZEDER Gábor wrote:
>>  * Added unit tests for the bloom filter computation layer
> 
> This fails on big endian, e.g. in Travis CI's s390x build:
> 
>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210
> 
> (The link highlights the failure, but I'm afraid your browser won't
> jump there right away; you'll have to click on the print-test-failures
> fold at the bottom, and scroll down a bit...)
> 

Thank you so much for running this pipeline and pointing out the error!

We will carefully review our interactions with the binary data and 
hopefully solve this in the next version. 

Cheers!
Garima Singh
