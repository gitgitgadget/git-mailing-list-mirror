Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02216C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiC1NeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiC1NeX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 09:34:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4D260B
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 06:32:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t7so12260215qta.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kM9xSXRGJ0sMgyTeykEG0tDVHWSdz61Sh2P3Oe00zQc=;
        b=TVFnYHrrwJLR8Jb++1S6e07s61iqy0eU8SIoMMsLUR9etw5AjJNm8qLxAgSl8OJXZE
         ONiFXOWfb+YAGl24cPIJQXn43n2WmDu+1Dl0M5ufD6MbYJRMxteHkC1ilatAMkBBcqMr
         Nh/zo/RiWp8N4rfJfDXWNRj1migIu5Vx3R2bYvR5D/xPqE+ogiz7UFXlbUx37FjLK8e8
         z7AEqrtsjrONXp1gIcRpoUSa5QAmxuTbDxbuwpLPYx9Ejtl7Vtr2bmCNzL4QbMGYErRf
         kZs7Ks0djH28qPb+ReXLNWZ7/r9WNG8IlvuTYFisti4vIi6dIaQfMyUogFPTIQQ24/NB
         qOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kM9xSXRGJ0sMgyTeykEG0tDVHWSdz61Sh2P3Oe00zQc=;
        b=4v9uJw+NaGkU/nVVhbhuqWTcfHSQOgbzzIMf/7cWjVLjUmbl/fwPXNipuJzFpIL1XU
         WPdppLhb41VJWz5YKtbaa16UqVDY70HtV7USlk7RQmC4DRBJ4prJUI3YHFFnhKxyOunE
         7IKTCgIJANjQ0Z4I1gxnlxJADifzc5LOMl7A/Ha6aY7LdfgN0m8ozji2VUAerSuz+TT6
         +VCA/nBpRbcU98EdKzksrp93z9AM4ziiYQ2K4o1qkbe5Hs9gd1rapIrS/68QG2hemFBp
         SRGlHpvcCHzzxQllzkKvSvK3hT1PC0PJG5LShB5xrCfe1h3WHp0anMWlFFPpm5KQ0/LI
         qcPQ==
X-Gm-Message-State: AOAM533yEuZREBUqbnouqFKsRz8PyMq9DO43rcTYvqXtEfAvkB5KFtcQ
        gGQGwkHYHjqbPtQir4x9qKeL/+TgG9PY
X-Google-Smtp-Source: ABdhPJzRN7nFMZa3hgcSaQE/La4tkQN+sAP5gt/hkFoNLw3epT01qU8PrgVrFs9RmYP2/1buX78HYw==
X-Received: by 2002:a05:622a:5c6:b0:2e0:68ec:3bb3 with SMTP id d6-20020a05622a05c600b002e068ec3bb3mr21878188qtb.207.1648474361515;
        Mon, 28 Mar 2022 06:32:41 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v12-20020a05622a130c00b002e1b3ccd9adsm12430442qtk.79.2022.03.28.06.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:32:41 -0700 (PDT)
Message-ID: <b709435b-d5f7-d7f8-a22a-0fc78e106928@github.com>
Date:   Mon, 28 Mar 2022 09:32:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
 <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
 <CAJyCBOQT1TwkNX_be9B3uKsv4Buf_ojfZoqfTAUqQ22Na7dY=g@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBOQT1TwkNX_be9B3uKsv4Buf_ojfZoqfTAUqQ22Na7dY=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/26/2022 11:48 PM, Shaoxuan Yuan wrote:
> On Fri, Mar 18, 2022 at 5:57 AM Victoria Dye <vdye@github.com> wrote:
> 
> Hi all,
> 
> It's been a busy week, I'm sorry that did not have much time to respond.
> 
> =================================
> A brief summary of my latest investigations:
> 
> I think the 'git mv' command still has some questionable aspects, especially
> with the 'git sparse-checkout' command. And I feel we have to sort things out
> between 'git mv' and sparse-checkout first, then proceed to the issues with
> sparse-index.
> ===========
> 
> I'm trying to fix the first 2 of the 3 potential things mentioned earlier.
> 
>> 1. When empty folder2/ is on-disk, 'git mv' (without '--sparse') doesn't
>>    fail with "bad source", even though it should.

>> 2. When you try to move a sparse file with 'git mv --sparse', it still
>>    fails.

I think that these conditions are all related to the perspective as
described in the documentation of 'git mv':

  In the first form, it renames <source>, which **must exist** and be
  either a file, symlink or directory, to <destination>. In the second
  form, the last argument has to be **an existing** directory; the given
  sources will be moved into this directory.

  The index is updated after successful completion, but the change must
  still be committed.

(**emphasis mine**)

So, this documents the perspective that files must exist in the worktree
(and destination directories must exist in the worktree), and after all
of those checks, then the move is staged.

I think part of our issues here is that in the case of a sparse-checkout,
we can have index entries that don't exist in the worktree. The expected
behavior we are considering is that 'git mv' should stage the movement
of the file in the index, ignoring the worktree for paths outside of the
sparse-checkout definition.

One way to do this would be to flip the implementation's direction:
perform the index operation of moving the cache entry, then update the
worktree to reflect that change (if necessary).

The case that I can think about being a bit strange is if the user has
an unstaged deletion of the source file, then runs 'git mv'. Since the
worktree is missing the file, then we cannot do the equivalent 'mv'
operation in the worktree.

One other thing to keep in mind is that 'git mv <source> <destination>'
can act like 'mv <source> <destination> && git add <destination>' if
<source> is an untracked path. So, 'git mv' can succeed even if the
source is not in the index!

So the change here is to ignore a non-existing path when the same path
exists as a cache entry with the SKIP_WORKTREE bit. That bit does say
"ignore the worktree" so 'git mv' isn't doing the right thing already.

---

In conclusion, there might be multiple ways forward here:

 1. Keep the expectation that <source> is in the worktree as given,
    and let a tracked <source> outside of the sparse-checkout cone
    result in a failure (as it currently does). Consider adding an
    advice message if <source> is a tracked, sparse path.

 2. Change the expectation to be that <source> must either be a
    file in the worktree _or_ a tracked, sparse path (or both).

The nice thing here is that we can do (1) and then (2) later. The
key things to investigate for the sparse index, then are what
happens when <destination> is outside of the sparse-checkout cone?
I imagine it would be fine if the moved file still appears in the
worktree and is cleaned up by a later 'git sparse-checkout reapply'.

I'm eager to here alternate opinions and options on this topic.

Thanks,
-Stolee
