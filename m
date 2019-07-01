Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4243E1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfGAMTC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:19:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38541 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfGAMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:19:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so10751327qkk.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CCR7UUJ075awiICvvKXS+e+dUZcS7OUtzCXf7fT2730=;
        b=tkyMhbTvYlnGBIy+VMlRBMAireYEIn30ghdRxQGwF0iomsP8SQJhwIyCpWGxIZqIWj
         sJf289IILseHfv3GTb2lzeGW/kaZkGWMh6Y/WsYJuWz5SaNpKGjItQEe+v0yHNz7vXHR
         34dXfakxsByxn+NI2tN5xA+Igke3sUnfOZlvoz4DNFYwjx/b3mIABbBKRrFWlAt08tu5
         7e1P5r6R+ewqj6kCjYaO+F4q9hdSyCeLPHkMDInWrn6ZCFiS+0DBNufEzARzx1Azyj+g
         dMae3+2RQet0ye7iEhMArfz14hBO1wV8C6SKfnnCxl1g0SZd996MOhBHrggr/ZGH/wnr
         wBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CCR7UUJ075awiICvvKXS+e+dUZcS7OUtzCXf7fT2730=;
        b=B89OXl+FxfBDoS53qXgs+ZeR1RVvG9g1O7Hx72v8kT9SeLs5edklhzFjG1j1nXB1Aq
         AVTzIGpEceZtMvhcFEYHM97061q6uVeQjwbnB44te30VxaLrPFLuAai7yswxtTw+PSDD
         TWgcn1WCfV3/TreVQEU7fy2KzJ8lUlZspoCl06Y2YS7kIc5HepKklpf7pzDrjcFz56vD
         qqZcBXpXvybtxxiicrYfrOwjSB1Mvd+tfyAMrsDBKi8PqAuD92yyzbCHbBXYuZSXGwYg
         /SzuFnOx2k6T87HN9Y+PjCgiH9FqaS74KuQMDj1JMsPen3nNlZ+xWsha/IHWtuMu680b
         jeiQ==
X-Gm-Message-State: APjAAAW8wGZGtdsOW5X99+ejdoLkKb2GmISOJBTWY1fWTT56qP7GfVVK
        XAVHrnWQBtm4V+V+YUXb8zU=
X-Google-Smtp-Source: APXvYqwY8JTwkNVo/NNAg8cEANUu9eGSxg7e55mc7uD0+gwl8vvpBOtP4M0yzCbkNXp0xRb9XMPEmw==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr20455640qke.222.1561983541249;
        Mon, 01 Jul 2019 05:19:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id s44sm6189951qtc.8.2019.07.01.05.19.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:19:00 -0700 (PDT)
Subject: Re: [PATCH v5 02/11] commit-graph: return with errors during write
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
 <pull.112.v5.git.gitgitgadget@gmail.com>
 <95f66e85b2fe93a218dad4c04c16718d053fb002.1560346173.git.gitgitgadget@gmail.com>
 <20190629172335.GH21574@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0e7f4844-69a1-b910-979b-64bd99c240ed@gmail.com>
Date:   Mon, 1 Jul 2019 08:19:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190629172335.GH21574@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2019 1:23 PM, SZEDER Gábor wrote:
> On Wed, Jun 12, 2019 at 06:29:37AM -0700, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index e80c1cac02..3b6fd0d728 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -23,6 +23,14 @@ test_expect_success 'write graph with no packs' '
>>  	test_path_is_file info/commit-graph
>>  '
>>  
>> +test_expect_success 'close with correct error on bad input' '
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	echo doesnotexist >in &&
>> +	{ git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
>> +	test "$ret" = 1 &&
> 
> This could be: 
> 
>   test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr
> 
> 
>> +	test_i18ngrep "error adding pack" stderr
>> +'

Thanks!, you are right! test_expect_code is what I should have used here
instead of finding the "ret=$?" trick in t0005-signals.sh, which needs to
do more interesting logic on the return code.

Here is your suggestion as a diff. Junio: could you squash this in, or
should I submit a full patch?

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 22cb9d66430..4391007f4c1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -26,8 +26,7 @@ test_expect_success 'write graph with no packs' '
 test_expect_success 'close with correct error on bad input' '
        cd "$TRASH_DIRECTORY/full" &&
        echo doesnotexist >in &&
-       { git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
-       test "$ret" = 1 &&
+       test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
        test_i18ngrep "error adding pack" stderr
 '

I took inventory of when we are using "=$?" in the test scripts and saw
this was the only one that could easily be removed. Every other place is
doing something that can't be replaced by test_expect_code.

Thanks,
-Stolee
