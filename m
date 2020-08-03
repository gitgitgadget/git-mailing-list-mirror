Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1795C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8878E22BEB
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa8XczwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHCRhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCRhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:37:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D70C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 10:37:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so31783462qkf.10
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3K0hLImcHXPQ90Tekt9jbBzN2xqQKWX/a6exjsDx0Ss=;
        b=fa8XczwBe7ogDWW6rB1qcThE6HchLHhPtP3G3i1dBaWiyiOCLTuDd5sQtpyC5Sv5yZ
         pUQOmC1rYvzgcFrlERZKxNKFkVZea1IeEkS2/0eHJ6eqqMb6gm+pWbiU8dM0ejJJbOxF
         xVsXmhOUQcCJ3f5AW8EYWsrWdMadR6Z9y9q3IqRZDPqXglapbjs+rSBl9Nx2Is7JaRsd
         rLvrQFjcK2U31QcXmXlihdQ2FgNHT9vkBUtFsmc8vLyjLcQYAydt19ynVtb/2Yx142uW
         0ZhcIpr/fTC5J8JGq+Zns/zFMRVLMBdw518Nhl1OgFXxQgec0xB/oLAS2GDkSG21ukga
         15Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3K0hLImcHXPQ90Tekt9jbBzN2xqQKWX/a6exjsDx0Ss=;
        b=Sb+hhA6p6/+hatbx9NWVEubzHZ3Zm9TUb4o9kTkWUVPZqzppgOjEqlOR1RoEoVGk+O
         9/p9rL272y2PH43n/zod2AYWjY1nSIF/TG8JmyXjHrP4Xd1T2CSaPqDgWgcOgbBmpKQv
         7JimoqbMoeTMjXQKSnXvFLwfjgfMuCysZJQ9gvwYnpf2t47Cp7zVMd2LooRjOkzMEvq8
         qfL1OD+Blaaax5JizziuqeqPXx9+od1aCFSmWO495Z5owiiiI+GIZA8KXqv8ns+cICbS
         AX4p++756w9Exvede2FlLKaYL2Cab9HUDiOWce38BakhrUrSFgsz6+E7YLOOPxDl+hcA
         WCNQ==
X-Gm-Message-State: AOAM531UjPdh7D6X3vUkChTIFvJVb5H1fQOVT4WGGehl4ZPOwe9W2hD6
        P+PMBOtBRqfUcxUdHHKdMJk=
X-Google-Smtp-Source: ABdhPJyV72V1hA55qscSWav05PP26oxOslGL5BnYBEPLAOZLAufx1hwAGbADo4I8KWJQR3fgV6Dnww==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr17623173qkf.190.1596476236549;
        Mon, 03 Aug 2020 10:37:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdad:2336:408b:dfdf? ([2600:1700:e72:80a0:bdad:2336:408b:dfdf])
        by smtp.gmail.com with ESMTPSA id w58sm9760713qth.95.2020.08.03.10.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 10:37:15 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
Date:   Mon, 3 Aug 2020 13:37:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200731003022.GA1029866@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
>> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:
> 
>>> [jrnieder] How do I supply the tasks on the command line?  Are they
>>> parameters to this subcommand?  If so, it could make sense for this to
>>> say something like
>>>
>>> 	run <task>...::
>>
>> Hopefully this is documented to your satisfaction when the ability
>> to customize the tasks is implemented.
> 
> Hm, do you mean that this change is too difficult to squash into the
> first patch?

I mean that there is only one task right now. Until the commit-graph
task is implemented, there is no need to have a --task=<task> option.

Creating a --task=<task> option in this patch would unnecessarily bloat
the patch by implementing multiple tasks while filling in the boilerplate
of creating a new builtin.

>>> What is the exit code convention for "git maintenance run"?  (Many Git
>>> commands don't document this, but since we're making a new command
>>> it seems worth building the habit.)
>>
>> Is this worth doing? Do we really want every command to document
>> that "0 means success, everything else means failure, and some of
>> those exit codes mean a specific kind of failure that is global to
>> Git"?
> 
> I mean things like "what exit code does it run if there is no
> maintenance to do?"
> 
> [...]
>>>> +static struct maintenance_opts {
>>>> +	int auto_flag;
>>>> +} opts;
>>>
>>> Packing this in a struct feels a bit unusual.  Is the struct going to
>>> be passed somewhere, or could these be individual locals in
>>> cmd_maintenance?
>>
>> This will grow, and I'd rather have one global struct than many
>> individual global items. It makes it clearer when I use
>> "opts.auto_flag" that this corresponds to whether "--auto" was
>> provided as a command-line option.
> 
> That doesn't seem idiomatic within the Git codebase.
>
> Can they be locals instead?

Which part do you want to be idiomatic? The fact that the parse-options
library typically refers to static global values or the fact that the
data is not organized in a struct?

Turning these into locals is _even worse_ than the current model of
static globals because that then requires updating the prototypes of
all the (static) local methods that operate on the arguments. Every
time a new option is added, that would cascade in method prototypes
all over again.

The natural thing to do to "fix" that situation is to create a struct
that holds the information from the parsed command-line arguments. But
then why is it a local parameter that is passed through all of the
local methods instead of a global (as presented here in this patch)?

> [...]
>>> Perhaps this is suggesting that we need some central test helper for
>>> parsing traces so we can do this reliably in one place.  What do you
>>> think?
>>
>> I'm specifically using GIT_TRACE2_EVENT, which is intended for
>> consumption by computer, not humans. Adding whitespace or otherwise
>> changing the output format would be an unnecessary disruption that
>> is more likely to have downstream effects with external tools.
>>
>> In some way, adding extra dependencies like this in our own test
>> suite can help ensure the output format is more stable.
> 
> Hm, I thought the contract for GIT_TRACE2_EVENT is that it is JSON,
> which is a well defined format.  To that end, I would sincerely hope
> that external tools are not assuming anything beyond that the format
> is JSON.
> 
> If that wasn't the intent, I'd rather that we not use a JSON-like
> format at all.  That would make the expectations for evolving this
> interface clearer.
> 
>> If there is a better way to ask "Did my command call 'git gc' (with
>> no arguments|with these arguments)?" then I'm happy to consider it.
> 
> My proposal was just to factor this out into a function in
> test-lib-functions.sh so it's easy to evolve over time in one place.

This is a valuable suggestion, but this series is already too large
to make such a change in addition to the patches already here. I'd
consider this more if there were more tests that checked "did we
run this subcommand with these arguments?" Better to extract a helper
when this is actually used in multiple places.

Thanks,
-Stolee
