Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791EC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A982310B
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 18:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AatGnMl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHFS13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgHFSUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 14:20:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C04CC061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 11:13:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so20078037otr.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v2ZRUPxkAYqIX4+/5un4FDLN3dMwbf+B2qcr6OmUaAE=;
        b=AatGnMl0fUGdSqWKb0uA4YvHKMMu7y+SysIKwMjw7kIhhg3UcdDW3uX90ZeYuFo1Cm
         pJxWzLeir1oVHzed0OTFDqbXTydHnKMhIa8i6Y/ADsmBgp3X4M/zUfDJubIjkyZJgWsY
         tKhC4mKVzfxWb4C73rWLxOH0z/+z9iTvHxgWMmzLnRMK5w3jqWmQn9zu0XNaLyHTCasl
         nar5IsFXuu2N03PSuqIZuzt7Ug/K0zj8vXiQACfTl8expY+33h8vQzSSUWRcSapFOhgH
         9LvqwZ+WsH3H7P3kI018eQmu29af1Ry54oFoNgtzGK5GuVoksGRUiv+muCA3KZccmn8S
         pa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2ZRUPxkAYqIX4+/5un4FDLN3dMwbf+B2qcr6OmUaAE=;
        b=t4aICaOzknLHO6xlRlwT1WwV/C4RzK2PzbkStonuvKl/8Bsb6pk8TzOhv85EvtWvkw
         YIg9IEdIOet1GiOde5u01OgjDZY3jVcP1+8QuC+n+hN2iLygpw+J6YZdkQCY9kEHidF/
         tYz/im2ze6IIficKjq1viANLioqB1KQpmVGOGzUFlxvnwvXeauOeiczNwahPyvMH9U9h
         YJtLhrQPkLFgKqFi5P1gS6EPzMjsDIwzFgQJgDEnjXRkN0EwVWTmqFpVjADuEnseyxx/
         6Z63J4NoKeug+9qdEusTWOYVu/SutMslwDKqzCMz/fkxgSvywgc9m3jGJ+EQHjYCqFbP
         RUOQ==
X-Gm-Message-State: AOAM533kAgn4t/hXVJp4EkOroLc5beQ2t+JgfWfxInabFNaWLxRuXUdK
        d2mTZhqHZ9PB62uDqBCrFCu5JnwJVPvxuQ==
X-Google-Smtp-Source: ABdhPJyVW1sc9doQaXUQssgMU6QL9tOM9GWQanjqi2ExsywHxbwVgA++qQ/vOpMD0ToKBVy2O/o6pg==
X-Received: by 2002:a05:6830:1e26:: with SMTP id t6mr8180454otr.342.1596737608096;
        Thu, 06 Aug 2020 11:13:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:adee:5243:22a7:36c0? ([2600:1700:e72:80a0:adee:5243:22a7:36c0])
        by smtp.gmail.com with ESMTPSA id w11sm1269553oog.33.2020.08.06.11.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 11:13:27 -0700 (PDT)
Subject: Re: [PATCH 8/9] maintenance: auto-size incremental-repack batch
To:     Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, Jeff King <peff@peff.net>,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <c3487fb8e3e72949080f51f341655f37b5f2f03f.1596731425.git.gitgitgadget@gmail.com>
 <6FA8F54A-C92D-497B-895F-AC6E8287AACD@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb7fd1da-51fd-60a3-89ba-9d1f0a493698@gmail.com>
Date:   Thu, 6 Aug 2020 14:13:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <6FA8F54A-C92D-497B-895F-AC6E8287AACD@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/6/2020 1:02 PM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
>> On Aug 6, 2020, at 18:30, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When repacking during the 'incremental-repack' task, we use the
>> --batch-size option in 'git multi-pack-index repack'. The initial setting
>> used --batch-size=0 to repack everything into a single pack-file. This is
>> not sustainable for a large repository. The amount of work required is
>> also likely to use too many system resources for a background job.
>>
>> Update the 'incremental-repack' task by dynamically computing a
>> --batch-size option based on the current pack-file structure.
>>
>> The dynamic default size is computed with this idea in mind for a client
>> repository that was cloned from a very large remote: there is likely one
>> "big" pack-file that was created at clone time. Thus, do not try
>> repacking it as it is likely packed efficiently by the server.
>>
>> Instead, we select the second-largest pack-file, and create a batch size
>> that is one larger than that pack-file. If there are three or more
>> pack-files, then this guarantees that at least two will be combined into
>> a new pack-file.
> 
> I have been using this strategy with git-care.sh [1] with large success.
> However it worth to note that there are still edge case where I observed that
> pack count keep increasing because using '--batch-size=<second-biggest-pack>+1'
> did not resulted in any repacking.
> In one case, I have observed a local copy went up to 160+ packs without being able
> to repack.
> 
> I have been considering whether a strategy such as falling back to the '(3rd biggest
> pack size) + 1' and 4th and 5th and so on... when midx repack call resulted in no-op,
> as that was how I fixed my repo when the edge case happen.
> 
> Such strategy would require a way to detect midx repack to signal when no-op happen,
> so something like 'git multi-pack-index repack --batch-size=123456 --exit-code' would
> be much desirable.
> 
>>
>> Of course, this means that the second-largest pack-file size is likely
>> to grow over time and may eventually surpass the initially-cloned
>> pack-file. Recall that the pack-file batch is selected in a greedy
>> manner: the packs are considered from oldest to newest and are selected
>> if they have size smaller than the batch size until the total selected
>> size is larger than the batch size. Thus, that oldest "clone" pack will
>> be first to repack after the new data creates a pack larger than that.
>>
>> We also want to place some limits on how large these pack-files become,
>> in order to bound the amount of time spent repacking. A maximum
>> batch-size of two gigabytes means that large repositories will never be
>> packed into a single pack-file using this job, but also that repack is
>> rather expensive. This is a trade-off that is valuable to have if the
>> maintenance is being run automatically or in the background. Users who
>> truly want to optimize for space and performance (and are willing to pay
>> the upfront cost of a full repack) can use the 'gc' task to do so.
>>
>> Create a test for this two gigabyte limit by creating an EXPENSIVE test
>> that generates two pack-files of roughly 2.5 gigabytes in size, then
>> performs an incremental repack. Check that the --batch-size argument in
>> the subcommand uses the hard-coded maximum.
>>
>> Helped-by: Chris Torek <chris.torek@gmail.com>
>> Reported-by: Son Luong Ngoc <sluongng@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> Generally, I have found working with '--batch-size' to be a bit unpredictable.
> I wonder if we could tweak the behavior somewhat so that its more consistent
> to use and test?

Thanks for continuing to test with this model. My experience has been limited
to the --batch-size=2g option on repos that typically have >15gb of commit
and tree data in their pack directory.

One bit of unpredictability that we've seen is that the --batch-size uses
the "expected size" of a pack-file to select if it should be repacked. This
only tracks the objects that are referenced in that pack, so when we have
new packs that were "un-thinned" by duplicating delta-bases, those affect
the expected size of a repack.

Here is a great reason to have this series be split. While part I stabilizes,
we can take the time to re-evaluate this strategy. It might require updating
the multi-pack-index builtin itself.

One thing to think about is to focus on the different possible sizes of a
repository. If the entire pack-directory is small, then we might as well
repack everything. (What should the limit be? 2gb? configurable?) In the
case of a larger directory, should we just use the --batch-size logic with
that limit, or should we create a new option for which packs to repack?

For example, the recent simulation [1] of downloading fetch packs and
running this maintenance did see extra space that could be recovered with
the current logic. However, what if we could specify "repack everything
except the largest pack" exactly? That would do exactly what this task
is _intending_, as long as that resulting pack-file does not exceed the
2gb maximum by too much.

[1] https://lore.kernel.org/git/d50fbb33-9be3-1c48-2277-8bf894df734f@gmail.com/

I will think more on this. I'm open to alternate strategies.

Thanks,
-Stolee
