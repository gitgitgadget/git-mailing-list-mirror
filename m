Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4CC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B038820838
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2zgCzXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgG3Piz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgG3Piy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 11:38:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8EC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 08:38:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so6615131qth.5
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JQjMahhOoOEUZGsVWuV6mLAzvLycrqcnQjLus1re74g=;
        b=K2zgCzXsTyqhY1VkA6N4sIwAgJX7TH4scAWtYbsl6hcYxiJ+BFYpg8nci63Vgk+Jri
         t5HrGPTu2+hr5EwjSuy1fI7rhr+q2u66uCQzczfgGXHflTnvfrkS5D4gfxtlYPZDzQft
         0ahmhpd3E2QyuXOkEOHTCLvDVKolGHCRFkgONwUimhtATR7HbPY70vlOLhXaQbiA4Yao
         hMrFFqIFqDja9HP7CWkdG2zkl2+822KELveeHFcwSOfbX+Zpu2E6KgeEbDV2JRfq/d5s
         up5OLY5jd3PsRUlAATH1CiWqipkkssYSWmnj8Sonr4z3LEXSpKP6gZaWNyzQJG0JWnWc
         2Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JQjMahhOoOEUZGsVWuV6mLAzvLycrqcnQjLus1re74g=;
        b=WYMt0O1w6vQe75vNDuhAsJzq5gMbql8PBxtqpk4lMiy3OvXSYN5L4QAgZtUD66QzsX
         QoqZ9c4f5nl4vbMG22g2+8yGOUnmeqcOexAbijvL9/tjUCyCfGbzw/RmF4yj612oSj1h
         gg5MJobIG2qLqL85TcPREO0s+p4cx8djyjNQbP42QmQfo591i87X702DTC6af/MZItpO
         83SvGas6Cns2+s2zTXkMM5GPTWdCgqk65FnrDGh/Vb26jPaRQMpN9eqoqm1LmT9xrGv5
         w8+iczighULhRJSi4xkm5XQrscu811qIUtNwE6xBFwH58P1YEGAkyv0oJ2TxTH/zQH3X
         oQaA==
X-Gm-Message-State: AOAM530Nn3ZBztydgaQBe49OY/Q2f5HTvN1sxaZZIRJhrVy7lRHLcnpw
        dN57dVA6VfRuRUZGwjlt6LE=
X-Google-Smtp-Source: ABdhPJyTrHjmI5SQdhbjGaoYrZ7IatPEkOyyFTAo5zpPTc6PuTNYkMe/xWYgxDuCg/T2Ff4lywqsXQ==
X-Received: by 2002:ac8:47c8:: with SMTP id d8mr3361500qtr.32.1596123533626;
        Thu, 30 Jul 2020 08:38:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id g4sm4403680qtp.89.2020.07.30.08.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 08:38:52 -0700 (PDT)
Subject: Re: [PATCH v2 09/18] maintenance: add loose-objects task
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
 <20200729222126.GC2965447@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <906b84c9-5182-97f9-2d13-b61cc31a4bc4@gmail.com>
Date:   Thu, 30 Jul 2020 11:38:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200729222126.GC2965447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2020 6:21 PM, Emily Shaffer wrote:
> On Thu, Jul 23, 2020 at 05:56:31PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +loose-objects::
>> +	The `loose-objects` job cleans up loose objects and places them into
>> +	pack-files. In order to prevent race conditions with concurrent Git
>> +	commands, it follows a two-step process. First, it deletes any loose
>> +	objects that already exist in a pack-file; concurrent Git processes
>> +	will examine the pack-file for the object data instead of the loose
>> +	object. Second, it creates a new pack-file (starting with "loose-")
> 
> [jonathan tan + jonathan nieder] If you are going to document this,
> probably it should also be tested, so the documentation does not become
> stale. Or, just don't document it.

Adding a condition to the test is a good idea.

>> +static int pack_loose(void)
>> +{
>> +	struct repository *r = the_repository;
>> +	int result = 0;
>> +	struct write_loose_object_data data;
>> +	struct strbuf prefix = STRBUF_INIT;
>> +	struct child_process *pack_proc;
>> +
>> +	/*
>> +	 * Do not start pack-objects process
>> +	 * if there are no loose objects.
>> +	 */
>> +	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
>> +					   loose_object_exists,
>> +					   NULL, NULL, NULL))
> 
> [emily] To me, this is unintuitive - but upon inspection, it's exiting
> the foreach early if any loose object is found, so this is cheaper than
> actually counting. Maybe a comment would help to understand? Or we could
> name the function differently, like "bail_if_loose()" or something?

Sure. "bail_on_loose()" makes more sense to me.

>> +test_expect_success 'loose-objects task' '
>> +	# Repack everything so we know the state of the object dir
>> +	git repack -adk &&
>> +
>> +	# Hack to stop maintenance from running during "git commit"
>> +	echo in use >.git/objects/maintenance.lock &&
>> +	test_commit create-loose-object &&
> 
> [jonathan nieder] Does it make sense to use a different git command
> which is guaranteed to make a loose object? Is 'git commit' futureproof,
> if we decide commits should directly create packs in the future? 'git
> unpack-objects' is guaranteed to make a loose object, although it is
> clumsy because it needs a packfile to begin with...

"unpack-objects" also has the problem that it won't write the loose
object if it exists as a packed object, so it requires moving the
pack-file out of the object directory first. (That's also required
for testing that the loose objects get packed by the maintenance
task, but I'd rather not need to remove the multi-pack-index, too.)

> [jonathan tan] But, using 'git commit' is easier to understand in this
> context. Maybe commenting to say that we assume 'git commit' makes 1 or
> more loose objects will be enough to futureproof - then we have a signal
> to whoever made a change to make this fail, and that person knows how to
> fix this test.

I'll add the comment for now. Thanks.

-Stolee
