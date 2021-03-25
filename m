Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D0C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CDD619FE
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCYL4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhCYLz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 07:55:58 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B7C06175F
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:55:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so1632834otb.7
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ds8jUcRhYHqoE06sHjGFxf2KdzypXyy+r1WTu0G6Ew=;
        b=gdA/hbCkUx+PRPU85X0gpnkGHCgWLfG4zEUSHvGCCCnQb+DhNU/YNG3cSl/lSAgc9j
         7c+zLSAcpanRag7BjqRWVc11v1KWGLN1scMz5uvDprVMUcLNDqnJw+cyxO5qWbxU0CWu
         klgH7ndBFa6Y3kiAvhwfECla2hsweyrFKXGLn2WT1wd8PPlO33Z1a4YfyANItUEFK+nw
         gq/RphoLHFcwVXbyph+edBT5X+ZxIfqUL8+wKc91JrNZbPjOf6Orj6nFNSibgKuPtr3n
         qQtCMDCeck0iVgCmwl/GwtV/LTFViMq6nruevljooqrJ+YbB3rF97hUj5Djdsq7Rt3XD
         Nszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ds8jUcRhYHqoE06sHjGFxf2KdzypXyy+r1WTu0G6Ew=;
        b=pOZGkWmpGaA8ackNleMaxObw2XxlUnEa0y3keNLDB2hK5YKos1x7lWyKAzG1eqyIhf
         Se68zVC5wxKYNBgxtMf7xaH6VGMv+X9/DQMAApaQiEdyEg6nAm5U2+wfVyknVE3ABsYv
         HHxGVgIgJQRDXHhsOO4ZAFZlGSdBAvqk9W2b0WB7KPXPuyRueRpX4NDYmpmkSmogQpDA
         8GFWr+LDbymZ3DWvLkixXr4jyn0WwfdaIcNQXmI2QIuZ8EHRpmHlyrZRcOUtc098yK1e
         ueJRcbBNmosxj0FKNkWxyQ6wfDatGgi+iIXVhhRcWHs/8mg2XTmOzdj4/Dyy3SwDb4t7
         Y86w==
X-Gm-Message-State: AOAM530fQVc9scfp48p1SsonRtZUsmn8rqwbqAMUdnvmXnlrvlcVW2VF
        r2MqivQ8wUiFIgJz4kaAVso=
X-Google-Smtp-Source: ABdhPJxVHxa3QiApflx/pY43vMuDxF0+RYLNILWsmivT6MPd7tqD0Yz2/BJhQlcawzvTL8NPtnSWrg==
X-Received: by 2002:a05:6830:22c3:: with SMTP id q3mr7198851otc.56.1616673357681;
        Thu, 25 Mar 2021 04:55:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d03a:8334:249:e6fd? ([2600:1700:e72:80a0:d03a:8334:249:e6fd])
        by smtp.gmail.com with ESMTPSA id g13sm1296778otq.3.2021.03.25.04.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 04:55:57 -0700 (PDT)
Subject: Re: [PATCH] csum-file: flush less often
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84ccabca-0bd3-d0cb-6b38-f96d75c0bbd6@gmail.com>
Date:   Thu, 25 Mar 2021 07:55:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2021 1:50 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>

Let me walk this back a bit.

> Next, I inspected the buffering code itself, and found an important
> difference. Specifically, every call to hashwrite() was causing a flush
> of the filestream, even if it was a very small write. With many callers
> using helpers like hashwrite_be32() to write integers in network-byte
> order, this was leading to many more file flushes than necessary.

This is incorrect. I misinterpreted the logic inside the loop, and I
later confirmed using trace2 that the number of flushes is the same
between versions.

So, what happened with my performance tests?

> As for performance, I focused on known commands that spend a significant
> amount of time writing through the hashfile API, especially if using
> small buffers as in hashwrite_be32(). 'git multi-pack-index write' was
> an excellent example (deleting the multi-pack-index file between runs)
> and demonstrated this performance change in the Linux kernal repo:
...
> Summary
>   'new' ran
>     1.03 ± 0.07 times faster than 'old'
> 
> Similarly, the same command on the Git repository gave these numbers:
...
> Summary
>   'new' ran
>     1.05 ± 0.04 times faster than 'old'
> 
> Finally, to demonstrate that performance holds when frequently using
> large buffers, the numbers below are for 'git pack-objects' packing all
> objects in the Git repository between v2.30.0 and v2.31.1:
...
> Summary
>   'new' ran
>     1.03 ± 0.06 times faster than 'old'
>
> With these consistent improvements of 3-5%, ...

These numbers seems consistent, across repos and test commands. They
seem to be the inverse of the slowdown I was seeing in the index
refactor. These caused me to use confirmation bias to assume I had
done something clever.

I was using hyperfine to run these numbers, with the hope that it
provides a consistent scenario worthy of testing. I used this command,
roughly (in a script):

hyperfine \
        -n "old" "$1 && $OLD_GIT $2 <input" \
        -n "new" "$1 && $NEW_GIT $2 <input" \
        --warmup=3 \
        --min-runs=20

where I would pass some preparatory step as "$1" and the Git commands
to run as "$2", and have an input file (necessary for the pack-objects
command).

The first thing I did when confronted with the flush problem was swap
the order of the "old" and "new" lines, and that caused the performance
difference to go away, hinting that the number of warmups needed to
increase. Changing to "--warmup=20" and "--min-runs=50", the change in
timing went away entirely.

I did the same with my draft changes to the index write code, and that
caused the 1-2% performance drop go away, too. So, this whole adventure
was based on a faulty performance test.

But...is there something we could still do here?

My confusion about flushing is mostly due to my error, but upon
reflection the loop is doing a lot of different things, but most of
the time we know which behavior we need at the start, in the middle,
and at the end:

     1. Fill the existing buffer with the beginning of 'buf'. If the
        hashfile's buffer is full, then flush.
    
     2. Flush sizeof(f->buffer) chunks directly out of 'buf' as long as
        possible.
    
     3. Copy the remaining byes out of 'buf' into the hashfile's buffer.

Here is a rewrite that more explicitly follows this flow:

void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
{
	const int full_buffer = sizeof(f->buffer);
	unsigned left = full_buffer - f->offset;
	unsigned nr = count > left ? left : count;

	/*
	 * Initially fill the buffer in a batch until it
	 * is full, then flush.
	 */
	if (f->do_crc)
		f->crc32 = crc32(f->crc32, buf, nr);

	memcpy(f->buffer + f->offset, buf, nr);
	f->offset += nr;
	count -= nr;
	buf = (char *) buf + nr;

	if (left == nr)
		hashflush(f);

	/*
	 * After filling the hashfile's buffer and flushing, take
	 * batches of full_buffer bytes directly from the input
	 * buffer.
	 */
	while (count >= full_buffer) {
		if (f->do_crc)
			f->crc32 = crc32(f->crc32, buf, full_buffer);

		the_hash_algo->update_fn(&f->ctx, buf, full_buffer);
		flush(f, buf, full_buffer);

		count -= full_buffer;
		buf = (char *) buf + full_buffer;
	}

	/*
	 * Capture any remaining bytes at the end of the input buffer
	 * into the hashfile's buffer. We do not need to flush because
	 * count is strictly less than full_buffer here.
	 */
	if (count) {
		if (f->do_crc)
			f->crc32 = crc32(f->crc32, buf, count);

		memcpy(f->buffer + f->offset, buf, count);
		f->offset = count;
	}
	
	if (f->base)
		hashwrite(f->base, buf, count);
}

With this implementation (and the more robust performance test), the
performance for pack-objects and index-pack remains constant, but
there is a slight improvement for 'git multi-pack-index write', which
is mostly translating data from the pack-indexes into a multi-pack-
index:

    Using the Git repository:
    
    Benchmark #1: old
      Time (mean ± σ):     270.4 ms ±   6.9 ms    [User: 184.6 ms, System: 38.6 ms]
      Range (min … max):   258.6 ms … 283.2 ms    50 runs
    
    Benchmark #2: new
      Time (mean ± σ):     265.3 ms ±   6.0 ms    [User: 180.9 ms, System: 37.8 ms]
      Range (min … max):   257.4 ms … 282.0 ms    50 runs
    
    Summary
      'new' ran
        1.02 ± 0.03 times faster than 'old'
    
    Using the Linux kernel repository:
    
    Benchmark #1: old
      Time (mean ± σ):      2.321 s ±  0.011 s    [User: 1.538 s, System: 0.335 s]
      Range (min … max):    2.301 s …  2.353 s    50 runs
    
    Benchmark #2: new
      Time (mean ± σ):      2.290 s ±  0.011 s    [User: 1.513 s, System: 0.329 s]
      Range (min … max):    2.273 s …  2.318 s    50 runs
    
    Summary
      'new' ran
        1.01 ± 0.01 times faster than 'old'

Again, variance might be at play here, but after running this
test multiple times, I was never able to see less than 1% reported
here.

So, I'm of two minds here:

 1. This is embarassing. I wasted everyone's time for nothing. I can retract
    this patch.

 2. This is embarassing. I overstated the problem here. But we might be able
    to eke out a tiny performance boost here.

I'm open to either. I think we should default to dropping this patch unless
someone thinks the rewrite above is a better organization of the logic. (I
can then send a v2 including that version and an updated commit message.)

Thanks,
-Stolee

P.S. Special thanks to Peff who pointed out my error in private.
