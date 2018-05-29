Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B991F42D
	for <e@80x24.org>; Tue, 29 May 2018 12:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeE2Mnv (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 08:43:51 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36008 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbeE2Mnu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 08:43:50 -0400
Received: by mail-qt0-f177.google.com with SMTP id q6-v6so18388608qtn.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EGnFZ0extfvPAIC6oRseWd7GN9rWSZ97BiGZcdYjvck=;
        b=DsN9vaBHRQi+7pxlrrkJ1B8cZ5n3n4kOTx5MJS11Ov7It+d6etKwqR0TQVh2yOXIix
         bgtTSGvLpRxaD7JpGUpxHbUaBl/sUJmWFBg2ZYS1uB4uAXShKgFGKplrV8WigZXypfbc
         OU+ONYghGsExEJpMAGfR5nfpx0duYVz6ELXJuUtTbg+nE51rf78R92G5VWMq5Vkiw2yj
         MkFyg36H9518kkMKrBclSnc8815lR8iUAuieeCLB7/s7xu8mwEskbNaoXgwZ314TzL+1
         NWsmLzryfTFKOsEJmDI0ct1RGszr+PevHoB0OdRHLNkKDkJq3JzDAb+maY6+GGvVlkJQ
         qYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EGnFZ0extfvPAIC6oRseWd7GN9rWSZ97BiGZcdYjvck=;
        b=NEPR8Odk6PkyX+HnGTvR0G06eLALcAxSj7EMH6svion6tsnCtTeVkXYquQ+XF88hje
         Ik/wbgFFwS5G00uHdmSLenwwyn0/5cb70RX2k1mX/7zbolt2Md3dYIXeMoo76D6GtPEn
         yxaB8PECuvqLyofk/2uzAKeD5aORPq4V5yaGIoQo7FT0rUh3T31spdjAKfO5l9f7UDLX
         L5QSSost8/9LmeTDcRpt/bkzpgCpxgHB5xtuheSNiHK/0xjtpWqLPgoa7rPa5GGUl6Ax
         ywevbgOZkoPeL0AjyOQhFmmbFlJrFzPOIhbWPYSZR22LHSlCj8TDJEgdxzmv1DksNOPq
         MPpA==
X-Gm-Message-State: ALKqPweHkbv9gZDZ9YZaBHpsEownSfV3u9P33G9csAXD5if1LQdLlqH4
        qf/CxW+R6VMOx3rkQ0Zgv+Y=
X-Google-Smtp-Source: ADUXVKLpsRX/lt/FYwLZ46Zw/opZsDhfhw7LsgkaS5N8hVgednnQFrKSPpqqj/BpXCc1GO6kWKn+Hg==
X-Received: by 2002:a0c:cd13:: with SMTP id b19-v6mr8210180qvm.83.1527597829705;
        Tue, 29 May 2018 05:43:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:85b8:1327:9ae7:c654? ([2001:4898:8010:0:6eee:1327:9ae7:c654])
        by smtp.gmail.com with ESMTPSA id h48-v6sm26310896qta.43.2018.05.29.05.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 05:43:49 -0700 (PDT)
Subject: Re: [PATCH v3 07/20] commit-graph: verify catches corrupt signature
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-8-dstolee@microsoft.com> <86muwjyixo.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d9d346c-b178-26f2-fdeb-bb0ffb070774@gmail.com>
Date:   Tue, 29 May 2018 08:43:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86muwjyixo.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2018 10:05 AM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> This is the first of several commits that add a test to check that
>> 'git commit-graph verify' catches corruption in the commit-graph
>> file. The first test checks that the command catches an error in
>> the file signature. This is a check that exists in the existing
>> commit-graph reading code.
> Good start.
>
> This handles 3 out of 5 checks in load_commit_graph_one().  The
> remaining are:
> * too short file (length smaller than minimal commit-graph size)
> * more than one chunk of one of 4 defined types
>
>> Add a helper method 'corrupt_graph_and_verify' to the test script
>> t5318-commit-graph.sh. This helper corrupts the commit-graph file
>> at a certain location, runs 'git commit-graph verify', and reports
>> the output to the 'err' file. This data is filtered to remove the
>> lines added by 'test_must_fail' when the test is run verbosely.
>> Then, the output is checked to contain a specific error message.
> Thanks for an explanation.
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 6ca451dfd2..bd64481c7a 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -235,9 +235,52 @@ test_expect_success 'perform fast-forward merge in full repo' '
>>   	test_cmp expect output
>>   '
>>   
>> +# the verify tests below expect the commit-graph to contain
>> +# exactly the commits reachable from the commits/8 branch.
>> +# If the file changes the set of commits in the list, then the
>> +# offsets into the binary file will result in different edits
>> +# and the tests will likely break.
>> +
>>   test_expect_success 'git commit-graph verify' '
>>   	cd "$TRASH_DIRECTORY/full" &&
>> +	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
>>   	git commit-graph verify >output
>>   '
> I don't quite understand what the change is meant to do.

This gives us a constant commit-graph file to work with in the later tests.

To get the "independent test" structure you want for the tests that are 
coming, we need to do one of the following:

1. Write a new commit-graph file for every test (slows things down).
2. Do all corruption/verify checks in a single test (reduces the 
information from a failed test, as it only reports the first failure).

I don't like either of these options, so I went with this "prepare" step.

> Also, as I said earlier, I'd prefer if tests were as indpendent of each
> other as possible, to make running individual tests (e.g. only
> previously falling tests) easier.
>
> I especially do not like mixing running actual test with setting up the
> repository for future tests, as here.
>
>>   
>> +GRAPH_BYTE_VERSION=4
>> +GRAPH_BYTE_HASH=5
>> +
>> +# usage: corrupt_graph_and_verify <position> <data> <string>
>> +# Manipulates the commit-graph file at the position
>> +# by inserting the data, then runs 'git commit-graph verify'
>> +# and places the output in the file 'err'. Test 'err' for
>> +# the given string.
> Very nice to have this description.
>
>> +corrupt_graph_and_verify() {
>> +	pos=$1
>> +	data="${2:-\0}"
>> +	grepstr=$3
>> +	cd "$TRASH_DIRECTORY/full" &&
>> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>> +	cp $objdir/info/commit-graph commit-graph-backup &&
>> +	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> Using 'printf' with octal is much more portable than relying on 'echo'
> supporting octal escape sequences (or supporting escape sequences at
> all).
>
>> +	test_must_fail git commit-graph verify 2>test_err &&
>> +	grep -v "^+" test_err >err
>> +	grep "$grepstr" err
> Shouldn't this last 'grep' be 'test_i18ngrep' instead, to allow for
> translated messages from 'git commit-graph verify' / 'git fsck'?
>
>> +}
> This function makes actual tests short and simple, without duplicated
> code.  Very good.
>
>> +
>> +test_expect_success 'detect bad signature' '
>> +	corrupt_graph_and_verify 0 "\0" \
>> +		"graph signature"
>> +'
>> +
>> +test_expect_success 'detect bad version' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
>> +		"graph version"
>> +'
>> +
>> +test_expect_success 'detect bad hash version' '
>> +	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
> When we move from SHA-1 (hash version 1) to NewHash (hash version 2),
> this test would start failing... which is actually not a bad idea.
>
>> +		"hash version"
>> +'
>> +
>>   test_done

