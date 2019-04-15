Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FD420248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfDONeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:34:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45144 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfDONeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:34:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so19009501qtv.12
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EpEhte6VJWBXibqQCQbf4j3K2OsbfdfxIL0U3QctgYI=;
        b=YnYhuRzFLH66VbKA9mN345a4v9P1LaEbPwr9t4xMCBExbQq6mDLVlxZWaXTFrbhn0F
         wL4OIP0w8sjOWGDEoPjQl8uxHXVqnOrrMtnTHtqToDLPGl8wVUDFtO8I0QFs5QnhMRbo
         XU4StBum+IN/aKki1/UQ3OYUhYfUnGvbM3ZQPyE6yYEunUn85WhyDhmJKwqDKTgokO/L
         2wHCaKtNpuDkFs3I0yUi0IRSsIg3xYk+eIw38CQPI24lGtPlpoYz/DhljQV4UxJgtdK9
         zBYetYRKIamibH9Q5UItQmRCCIrS5elVeDweukBgVO8iCq3mrHJsRtRrLZB9Aqfejq4c
         ApHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpEhte6VJWBXibqQCQbf4j3K2OsbfdfxIL0U3QctgYI=;
        b=kRJ6kobYHL8aDbr/EiH6lp861DA5wc/abfuc9engbG926Z2DRwfEXPkdrCSXQ1bW20
         zfKT0PfI1UZxJJDJeaowkDeKB377vy1/wdeDvb+AsPUoWnEOZlZj5k6szsw+Pphljwc9
         7TOEMR05Wm5q1tkwQ1KwUo05Ai3Ev9nYl0KH1xzIOy24MBp3N8rr14QUd5W3ad0hxf7d
         WOwoNfLG5rUaIVdRkvi0PG33i9aEGXOiKr5WBrmXw4MFGiSQQ4n3a0N4r/gZdwd6qhX6
         JzNkxb1Z9uZWmUA/WomL2VxhboLwUvF/8dKhuVfRrWgAunHmVo52sIzuqiWqpqQs5rfP
         NExg==
X-Gm-Message-State: APjAAAVUy2W5AA4akn6P6HH9qCh9+vOndXHmK70PtwmY5S+/mLvh2ECP
        p2bm7xq1HOL67m4zPGkVjhRulA==
X-Google-Smtp-Source: APXvYqy8wI9rS6AOEvwPRJx3WCaEjXRRwsDEUeNkl9u8cbx48Q1Rzh1b3l4ixg/wH2/ZKSGkffWoOQ==
X-Received: by 2002:ac8:168c:: with SMTP id r12mr57953408qtj.300.1555335253782;
        Mon, 15 Apr 2019 06:34:13 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id x13sm26292550qts.93.2019.04.15.06.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:34:12 -0700 (PDT)
Subject: Re: [PATCH v6 3/6] blame: add the ability to ignore commits and their
 changes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
References: <20190410162409.117264-1-brho@google.com>
 <20190410162409.117264-4-brho@google.com>
 <878swhfzxb.fsf@evledraar.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <3db6bad3-e7a5-af1d-3fe2-321bd17db2c6@google.com>
Date:   Mon, 15 Apr 2019 09:34:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <878swhfzxb.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/19 3:00 PM, Ævar Arnfjörð Bjarmason wrote:
[snip]

>> +	split[0].unblamable = e->unblamable;
>> +	split[1].unblamable = e->unblamable;
>> +	split[2].unblamable = e->unblamable;
> 
> I wonder what the comfort level for people in general is before turning
> this sort of thing into a for-loop, 4? :)

4 sounds good to me.  =)

>> +	nr_lines = e->num_lines;	// e changes in the loop
> 
> A C++-like trailing comment.
> 
>> +	grep "^[0-9a-f]\+ [0-9]\+ 1" blame_raw | sed -e "s/ .*//" >actual &&
>> +	git rev-parse X >expect &&
>> +	test_cmp expect actual &&
>> +
>> +	grep "^[0-9a-f]\+ [0-9]\+ 2" blame_raw | sed -e "s/ .*//" >actual &&
>> +	git rev-parse X >expect &&
>> +	test_cmp expect actual
> 
> The grep here is a bug. See my 4abf20f004 ("tests: fix unportable "\?"
> and "\+" regex syntax", 2019-02-21).

Thanks - will fix up this stuff in the next round.

