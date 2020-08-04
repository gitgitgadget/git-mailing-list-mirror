Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89AC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C042177B
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc4JPcMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgHDQdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDQc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 12:32:59 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD86C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 09:32:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o22so31125188qtt.13
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kD0S4WP9gGnw7HdR/rhVY2MML6Edrp+iUuQdMWiEZLM=;
        b=Lc4JPcMbhwOeAUT9nF2nxnm6tBvP7XAEyQpyO0KuPA/JhDuonGG56NPU9YuKq+MGLF
         G4JNi7c1JPll5nsll44LLaVUIswcIPqnGyx82N/73377RxUqrCYqULP8CxnG9Ic74ADq
         oGZZogoX8dQXuPipZ2jKQizvFxenjgBak8PwljEJ6mKZ7Y0sv6+nuFM5v27QxSxERYGR
         EaxsX7Sj30WfWq7W+9CPv++cETb5NtVvV4SPMsS8lUgSKLmLES4IQW4HFQ+Ky1Rm26kQ
         8WrrC9Klq3Wgaz1br58mBkbw8+HIS9VxejgLcRJWJHT3QVr1fCy984ryZu7DS43xejLi
         GxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kD0S4WP9gGnw7HdR/rhVY2MML6Edrp+iUuQdMWiEZLM=;
        b=rivTqagISLabtL7RPVy8kr8WBUBs6ys/MSQEc7Bx86Oy0RlxSFOjJ/24oz80LfIRgM
         sFH4ZpjCdorL1YdEOFucHwViYhYF16AklA7aiekMBosCWa2x0FRGH4i0+t+3RTJkCH0D
         sL6uja2XjvjWn636seeYbBPZ1aOhXNWEJsk5fwg76tNYo1U38HCh+BeZvnIJ+g+FKZrx
         Q0Nn+nCmsv3hbbVttBRcyYUXCO4FV0Jm2BO2riMWwzKgDrp+Reai+AZOYL6QlrLs+NYH
         RXYod7M8uzbRWZOPsHfuw952rpe5LPrLhyG7YZaJFGWKUwG5SjZX6zyHtzCfg5RDjDse
         UW+w==
X-Gm-Message-State: AOAM531QCiALfYtxYKOvarh5ShfYcNSEFwXgopp26Ina0+PfK4IIuXbL
        W6r7JkFzXtLNFk6Y9Zvd4SA=
X-Google-Smtp-Source: ABdhPJz1Wxapw6B4BjjBGVXBIugVgV2U92yxnuitaXEuFrbvEYOQr2agmZvymT4SYXD2RMPytAPFMQ==
X-Received: by 2002:ac8:6901:: with SMTP id e1mr22499177qtr.352.1596558778197;
        Tue, 04 Aug 2020 09:32:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id f189sm21222564qke.15.2020.08.04.09.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:32:57 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com> <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com> <20200803230814.GA73765@syl.lan>
 <20200803231745.GB58587@google.com>
 <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
 <20200804144208.GA227292@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2b6da345-d004-1d83-78cd-3f1ceaf278d9@gmail.com>
Date:   Tue, 4 Aug 2020 12:32:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804144208.GA227292@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 10:42 AM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
> 
>> What is seems like you are asking instead is for me to create a tool
>> in the test suite that parses each JSON line, extracts a specific
>> member from that JSON object, reconstructs a command-line invocation
>> from the JSON array, and reports whether that process worked for any
>> line in the event output.
> 
> No, that isn't what I'm asking.
> 
> I'm asking for this patch series to take the existing "grep" lines
> and put them in a function in test-lib-functions.sh, so that we can
> change them in one place when the trace emitter changes.

Thanks for clarifying, clearing up my misinterpretation of your
request. I'm coming around to this idea.

> [...]
>> If this is to truly be a hard requirement for these tests to move
>> forward,
> 
> Yes, from my point of view it really is.
> 
> But that "is this truly a hard requirement?" comes up tells me I have
> not done a good job of communicating in this review.  A review is
> about participants in the project working together to improve a patch,
> not people making demands at each other.

It's also about a balance. A patch author and a reviewer can have
disagreements, and it is important to discover exactly how hard each
is holding to their opinion.

> [...]
>> If I'm to spend time engineering something more complicated just to
>> check "did this subcommand run with these arguments?" then
> 
> I don't see why this is more complicated than what is in patch 1.  In
> fact, I think it would be a little more simple.

My interpretation (parsing JSON) _was_ more complicated, hence my
reservations. The helper still requires non-trivial script-fu (for
someone like me who is bad at scripting languages) but centralizing
the grep has value.

Here is my attempt so far:

trace2_subcommand_data () {
	command="$1" &&
	commas=$(echo $command | sed s/\ /\",\"/g) &&
	printf "[\"$commas\"]"
}

test_subcommand_called () {
	data=$(trace2_subcommand_data $1) &&
	grep $data $2
}

test_subcommand_not_called () {
	! test_subcommand_called $1 $2
}

with callers looking like

	test_subcommand_called "gc" run-no-auto.txt &&
	test_subcommand_not_called "gc --auto" run-auto.txt &&
	test_subcommand_called "gc --quiet" run-quiet.txt

Thanks,
-Stolee
