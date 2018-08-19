Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723FD1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeHSVDD (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:03:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40363 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeHSVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 17:03:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so7159128edq.7
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWUgajFjd6lZ4po2dr3EAowyalvkszATMs5hyk2GOrI=;
        b=FA1CYxbf6QkIWhmN9R4a++tY0Dp2Koc66AaAStJ68nWtox7HelXkOl+4HxdDq8LDla
         ucOkDxVWGbK3WcG6JqhHsHNcMwTZ0l3fAQn3Jm7QvYYSDavWMLCHIMJD0Gg9jip/z3dO
         FZyzSeL7lwXHqbBaqPY6nhxhDRZnBxkJw2e+7h6TieIaYP99ofv/d2qTn9wJJ9y/ETzj
         UKzJJlKoimi5NFyQDTVxCK6S3aXyrgYesOb1W51wjPSbB6o/JGd1DMNeD4xoI7ABJrmt
         ZkNiSppUTFPDa2PJbOKy2muMsFo+8xYYaKQslFLPThWU4gV2gWbY9tzOiUH/KzZqzoTv
         NsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWUgajFjd6lZ4po2dr3EAowyalvkszATMs5hyk2GOrI=;
        b=OXCYwYeuOwC8fr4HKkoKnHpJToam3p2IeefsXMeXBPZe+dxt9EkfI5qHtM8M5yzhlJ
         pXnc4EvcvVB5xrAJ7MS/zY4GZX/J4OEQxfmZaVWRZ9cCQpvptHSBY1Ujrl/ma201DXSB
         Z+htEn5VfsO8Lxyxj1pOvtOoP8eHzqHDzvVsa3zQV48rznHg6eqNwvi1isy5Cm3+s/5q
         iFoXM8dszYdk4mETZwFxDGlwG4M2IDN61/9h6jPaBKnWRrBmaXxWK5Wl8HDsTGgwevej
         UfXeNbOyJPLeJEcqlEQpZgkIR70Cc9CMOKdFxvLkmMNgVt1XHww33EKmJOI4GH/eYXS+
         /IlA==
X-Gm-Message-State: AOUpUlHjO6l8Bq1QB9bkSa8HrpzPza4qZYCnrz7u/qOJhp5MW0XMXqyX
        PnqpjKjW6JkT4emzeoatZ6o=
X-Google-Smtp-Source: AA+uWPwb0KZmwf4gBVKDzocWLNFlzIWCaZW7wLPvvFK1w0vRFaI3bACHe5KUYMWh9hmR24EWb7QZOQ==
X-Received: by 2002:a50:81a4:: with SMTP id 33-v6mr50688925ede.200.1534701045771;
        Sun, 19 Aug 2018 10:50:45 -0700 (PDT)
Received: from [10.9.11.6] ([46.246.123.46])
        by smtp.gmail.com with ESMTPSA id w3-v6sm7618872edb.16.2018.08.19.10.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 10:50:45 -0700 (PDT)
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>, Jeff King <peff@peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
 <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
 <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
 <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <73346b91-6d19-651a-c361-1666a39681f0@gmail.com>
Date:   Sun, 19 Aug 2018 19:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/18 22:09, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>>
>> I'll try something like the following on the weekend:
>>
>> 	test_cmp () {
>> 		if test "$1" != - && ! test -s "$1"
>> 		then
>> 			echo >&4 "error: trying to compare empty file '$1'"
>> 			return 1
>> 		fi
>> 		if test "$2" != - && ! test -s "$2"
>> 		then
>> 			echo >&4 "error: trying to compare empty file '$2'"
>> 			return 1
>> 		fi
>> 		test_cmp_allow_empty "$@"
>> 	}
> 
> I actually think the above gives way too confusing output, when the
> actual output is empty and we are expecting some output.
> 
> The tester wants to hear from test_cmp "your 'git cmd' produced some
> output when we are expecting none" as the primary message.  We are
> trying to find bugs in "git" under development, and diagnosing iffy
> tests is secondary.  But with your change, the first thing that is
> checked is if 'expect' is an empty file and that is what we get
> complaints about, without even looking at what is in 'actual'.

I came up with two solutions for this issue:

  1. Check both files at the same time (combination with Gábor's
     function):

	test_cmp () {
		if test "$1" != - &&
		   test "$2" != - &&
		   ! test -s "$1" && 
		   ! test -s "$2"
		then
			error "bug in test script: using test_cmp to check empty file; use test_must_be_empty instead"
		fi
		test_cmp_allow_empty "$@"
	}

     This will still be reporting to the developer clearly, but
     will only catch cases exactly like the bogus test in t5310.

  2. Enable this check via variable, smth like EMPTY_CMP_LINT=1
