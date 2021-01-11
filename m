Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDAC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99045224B8
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbhAKMoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 07:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbhAKMoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 07:44:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509BEC061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 04:43:33 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so19975294oih.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xlGJVwMwVraA3FoCzYL1UVxhMZZvwWVaIDOlO11U9rE=;
        b=XZ/GGb4Oj2pzfbpo+aUIoJzzpVnM4v5Qco2A1LmTcA4+oFZXj+KC6qJNpiRlIm5k3G
         YravMD89hbKFj+6dPs6gytgoDfwEOwSPnnOBh3BskrFzzvoWhgwTyxz7XM/G73N/B1Uk
         vPdgbwMzEODgIYK3FlmfzNlEyH42KweS6PNdCOzN4dO6ec8jtuGEEWo//761QBwmMLWE
         zvFwAN66ELKvUTPhjRr/pvjnlOBX1DOcs4SyFbEBZIwTx6cFYFdeVOCwwXR62aMBhzOw
         DwWCuokI5ofqCMzsO6dIZ21AMqYUrvqXOxDmVKI74kvr9XAlZtm6/RI1XLk4uEj8f5V+
         JlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xlGJVwMwVraA3FoCzYL1UVxhMZZvwWVaIDOlO11U9rE=;
        b=gf6zOoisymo53ASXes5V3G9w9PK1FyTwVzOT5zg49HtTW5Pjt57DsSs7A9Z+3oW6ua
         yiLa8L1wSdoHXs36uWKm0nZEV22l/+TCDLdUZTb2GsgAdrlRAAJqd4sJcMJDXI1J4fs7
         yv2D+7QC8dzoxIEmUOCzCYleKchc7yWls/BnUnhJSJ00lnVsbX9M8ETjQ7k7BnvnxUJY
         fxa2+JzH5xhu6i9m5FGlKcnpoU6heZ2XYG8BLrUadZEutsmlKntA37y5XVlrPqArT5le
         BmAGBXuHgGk59pk+UdIX8tDLj61E+2YcIzatlEIXcvwdbOxe0FqyrYqNE63v/+y0qebR
         etNg==
X-Gm-Message-State: AOAM5303ymtnqVMb3TkF3D0TRCMJWSVxwP9ILPvRMOEftdvxLvb1Rjzk
        /YJqyZBi6/MvNRy7jFmL+9rQUMHM3Zo=
X-Google-Smtp-Source: ABdhPJwKCa8IdBd3NnqGsneDsKLYimYNfY3AUi2QFlx/AwSYDzvTJpJPn+N7gTeth/FWMlWlsvtUXg==
X-Received: by 2002:aca:aa50:: with SMTP id t77mr10093091oie.28.1610369012585;
        Mon, 11 Jan 2021 04:43:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id n22sm3935112oig.32.2021.01.11.04.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 04:43:32 -0800 (PST)
Subject: Re: [PATCH v5 09/11] commit-graph: use generation v2 only if entire
 chain does
To:     2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylorr.com
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <a3a70a1edd0949ff3088fae625afa68fc61975df.1609154169.git.gitgitgadget@gmail.com>
 <2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com>
 <X/r9i0HJFEGxuyW/@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <003c1892-cbfe-7437-f8ce-fbae58f0cb83@gmail.com>
Date:   Mon, 11 Jan 2021 07:43:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <X/r9i0HJFEGxuyW/@Abhishek-Arch>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2021 8:13 AM, Abhishek Kumar wrote:
> On Tue, Dec 29, 2020 at 10:23:54PM -0500, Derrick Stolee wrote:
>> Your tests in this patch seem very thorough, covering all the cases
>> I could think to create this strange situation. I even tried creating
>> cases where the overflow would be necessary. The following test actually
>> fails on the "graph_read_expect 6" due to the extra chunk, not the 'write'
>> process I was trying to trick into failure.
>>
>> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>> index 8e90f3423b..cfef8e52b9 100755
>> --- a/t/t5324-split-commit-graph.sh
>> +++ b/t/t5324-split-commit-graph.sh
>> @@ -453,6 +453,20 @@ test_expect_success 'prevent regression for duplicate commits across layers' '
>>         git -C dup commit-graph verify
>>  '
>>  
>> +test_expect_success 'upgrade to generation data succeeds when there was none' '
>> +	(
>> +		cd dup &&
>> +		rm -rf .git/objects/info/commit-graph* &&
>> +		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph \
>> +			write --reachable &&
>> +		GIT_COMMITTER_DATE="1980-01-01 00:00" git commit --allow-empty -m one &&
>> +		GIT_COMMITTER_DATE="2090-01-01 00:00" git commit --allow-empty -m two &&
>> +		GIT_COMMITTER_DATE="2000-01-01 00:00" git commit --allow-empty -m three &&
>> +		git commit-graph write --reachable &&
>> +		graph_read_expect 6
>> +	)
>> +'
> 
> I am not sure what this test adds over the existing generation data
> overflow related tests added in t5318-commit-graph.sh

Good point.

-Stolee
