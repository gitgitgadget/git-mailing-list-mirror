Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF28BC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF03B208C7
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuXqnRdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHDNcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHDNci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:32:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA2C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:32:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so6034502qkm.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gAwHIUTrDfFaEVmLKGo9YgFQ3yeEO4DyFegb0qiPFM0=;
        b=UuXqnRdA4JIO+fHhUPUhFZysmEQOBZwBPf9Ug3A8NALxKj7ygBcxan8+ZwVMowNNIx
         A2wpgHrFq5u+B8Y9s0QBnQbtFXF02Us3dm6DnetnYLzmWU+JWhhT65LwkMt8mtSREpms
         z67/RvoLd/JunywmPr0NuHAQUfosPIvmUqBQEMNpPM6JPGxJOaZz4gbS2SvT5Gdeja5Y
         nZOxM6rsE2/ZF+sxbgW8coVUvUDmQb/J9t/aEwuWrcJbLRkL/FWpn2kzlU2JXDgE2Uls
         ALroKtn4eEiEpksWC8oqn46NzzA4nQubqAQAgcBI1BMhYjXXQNKsmoZ4fX6c0K+8pYKJ
         TMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gAwHIUTrDfFaEVmLKGo9YgFQ3yeEO4DyFegb0qiPFM0=;
        b=h/wc23CLXJXgv6borm6E0RFODaCyaFsPJF2aCYLo4P0/A4oLQDkqlfmgdB41SDdpBA
         cm/IlCiuLeeX9RrihE7LOlRNShdbvxbs6JR9tLkWpk7rkGJMuDTZ5Gd5gLJrtZifSBGw
         mqSF03t/qGRQHFRnjjU1L2IxfVoJgrQqOz3vJdeJEV5FXQxpad/nlwnPoVGGh3Gpzf+g
         8rtKzRFEEg1q4WmfCMO7a5qn2K8oQHKkU+NiNZCmnv/VNKisB6YYc0xI5Iu+EF2Yfr5q
         wCEh3XLVefzGBbjBRhW0YUsw3MuYElU+tswad0jxZPFNYYW/oMjt0sBo5hYNNqoUnGI2
         LopQ==
X-Gm-Message-State: AOAM530gGoOxHGAi97RZmidA5Zj9fNz+Ruh2JxJI3CNfv3Jb7OS8jURr
        rwOYe2FihxdKlK6ymFTKoxw=
X-Google-Smtp-Source: ABdhPJxut5chtAcr0gx3DMwCM4DIqATBvzqgahXa/rqo4tGRMdHsAbEqSrLFzXwklumzzLXtIPkPfQ==
X-Received: by 2002:a37:6783:: with SMTP id b125mr20266062qkc.465.1596547954860;
        Tue, 04 Aug 2020 06:32:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id c21sm21311569qka.9.2020.08.04.06.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:32:33 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com> <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com> <20200803230814.GA73765@syl.lan>
 <20200803231745.GB58587@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
Date:   Tue, 4 Aug 2020 09:32:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200803231745.GB58587@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 7:17 PM, Jonathan Nieder wrote:
> Taylor Blau wrote:
> 
>> I still only partially buy into this, though. I had to deal with some
>> rather fragile grepping through trace2 JSON in t4216 (? or something,
>> the log-bloom tests) recently, and found it a little fragile, but not
>> overly so.
>>
>> I'd rather just move forward,
> 
> This means we're promising to never change the JSON serialization, or
> that we're willing to pay with time in the future to update all tests
> that assume the current JSON serialization.
> 
> I do not want to make that promise.  I've lived through the same work
> of updating tests that assumed particular sha1s and having to change
> them to be more generic and do not want to have to do that again.
> 
> If you're saying that you are willing to do that work when the time
> comes, then that counts for a lot.  If you're saying that we should
> not change the JSON serialization, then it makes me worry that we made
> a mistake in choosing JSON as a format, since using a well defined
> format with an ecosystem of serialization + deserialization libraries
> was the whole point.

The benefit of JSON is that it is simple to be _additive_. We can
always jam more data into the format.

What I'm doing is making the following assumptions:

1. There will always be an event line corresponding to launching a
   subcommand.

2. This line will contain the list of arguments used for that
   subcommand in a JSON array.

3. We don't add extra whitespace in that JSON array.

The first two items are important promises made by the trace2 event
output. By depending on them, I'm only adding more places where we
expect the JSON *schema* to remain consistent. Rather, I only require
that the JSON schema does not _remove_ that data which is expected
by tools that are reading and reporting that data.

Only the third item is something that adds an additional restriction
on the JSON format. But also: why would we ever add extraneous
whitespace characters to the output intended for computer parsing?
This concern raises a giant "YAGNI" warning in my head.

What is seems like you are asking instead is for me to create a tool
in the test suite that parses each JSON line, extracts a specific
member from that JSON object, reconstructs a command-line invocation
from the JSON array, and reports whether that process worked for any
line in the event output.

That seems overly complicated and puts even more requirements on the
JSON schema than I have placed in my current implementation.

If this is to truly be a hard requirement for these tests to move
forward, then I would rather do an alternate approach that would be
a better test mechanism than scraping trace data: mock the subcommands.

I would create a new directory, "t/mock", and create a new 'git'
executable there. By setting --exec-path in our test commands, we
would launch this mocked version of Git instead of our built version.
The mock could report each set of command-line arguments to a known
file. With some care, we could even provide an instructions file to
tell it which error code to return or whether it should write data
to stdout. This would allow testing things like the "rewrite after
verify fails" behavior already in the maintenance builtin.

If I'm to spend time engineering something more complicated just to
check "did this subcommand run with these arguments?" then I'd
rather do it this way.

Thanks,
-Stolee
