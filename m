Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BCC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 15:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbiCUPWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbiCUPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 11:22:12 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D53EA96
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:20:14 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so4067703ooi.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xdGUZCzNwYIGYDK7HV24x7CFX2BUC/hq9y8t29DbJ0M=;
        b=RMTOku7yvf0k8wrnVYNaOhY1obiXCwL5UU3G2aEpK3KBAYYLNVA6FigqN3G1+us6Jz
         IgRCPQFMHP8LU/KnsBhqj13gPOj7Ut18Ai5Mpf3r81zTXhPXI4QHgTzGY1f6Nnmovopx
         aN6Fj72Uh9SvSuSycYH4HzhWox+VI3SXF6HoEpvCqh98mdIwG2KJKaJQtDjXDvlSZUWI
         208BWaAv52KkCQaSF9IjtvdUM+hIaQpBIggmXqtWph6Sq51wXVlr3gLOi8bTkGWsqmI7
         zbHhMkael8W/opSvEMnPb21SUrXgCx6Bic3K37DWGsCdJex9bTOtm4x8YzafveX6A+qd
         aS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xdGUZCzNwYIGYDK7HV24x7CFX2BUC/hq9y8t29DbJ0M=;
        b=bVggEnsHUG4HYo08bP+sqNA3VHe5X4TeVGHBpK21qn3F13jKspwNnfd65zBq+Au5IP
         ct6oo5QQef3geRo1heZOTo0VLfexG8qUoI9iKRqeep6XlpelqIEMFlTemCjGqOMp4w8L
         2ZFFqhlarXLPJXnXMai3c6WrDl3FNc4CtXG26YeVv1wbIuISljiqfVzWIQesJgQrMV+p
         ezc+zrI/v6BFf4jgntUnsVIfDVhO0l/DJQAZZaEcUWK/pNsXFSNzaolQiTTcAd8+Y4tQ
         q2bb4QTn1baaXphJ4V5pKjlpWly0AAHlzuUwvCZTcu5QkraZplSywze+8AYtpu3sImO5
         QIDg==
X-Gm-Message-State: AOAM530cZDytRLIz23mhR7t378lLE10XCHy05bM3vIdeqZk7kxRmkzIs
        as37jYyPYDdxpP2kD3k1iuSbVCT5etFx
X-Google-Smtp-Source: ABdhPJwMDDuZLqUnMzIonVeRqfpFtKKxgNRg4A1m4g6NTEAbOisqBAzQNfY3lzOnSKx+GCSv8SoiSQ==
X-Received: by 2002:a05:6870:41c7:b0:da:df9:2039 with SMTP id z7-20020a05687041c700b000da0df92039mr7944899oac.75.1647876012717;
        Mon, 21 Mar 2022 08:20:12 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d2-20020a05683025c200b005c93d78e1f6sm7834169otu.29.2022.03.21.08.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:20:12 -0700 (PDT)
Message-ID: <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com>
Date:   Mon, 21 Mar 2022 11:20:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
 <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com>
 <xmqqo824cbxl.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo824cbxl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2022 9:00 PM, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>>> I tested this and it fails as expected with:
>>> "fatal: bad source, source=folder2/a, destination=deep/new"
>>
>> Great! This should then probably be turned into a "test_expect_fail" test in
>> 't1092' - that'll make sure we get both the right behavior and right error
>> message with sparse index after it's enabled.
>>
>> However, I also get the same result when I add the '--sparse' option. I
>> would expect the behavior to be "move 'folder2/a' to 'deep/new' and check it
>> out in the worktree" - this may be a good candidate for improving the
>> existing integration with sparse *checkout* before enabling sparse *index*
>> (e.g., like when 'git add' was updated to not add sparse files by default
>> [1]).
>> ...
>> I think you're right that this is a bug. This appears to come from the fact
>> that 'mv' decides whether a directory is sparse only *after* it sees that it
>> doesn't exist on-disk. 
>> ...
>> So I think there are three potential things to fix here: 
>>
>> 1. When empty folder2/ is on-disk, 'git mv' (without '--sparse') doesn't
>>    fail with "bad source", even though it should.
>> 2. When you try to move a sparse file with 'git mv --sparse', it still
>>    fails.
>> 3. SKIP_WORKTREE is not removed from out-of-cone files moved into the sparse
>>    cone.
>>
>> On a related note, there is precedent for needing to make fixes like this
>> before integrating with sparse index. For example: in addition to the
>> earlier examples in 'add' and 'reset', 'checkout-index' was changed to no
>> longer checkout SKIP_WORKTREE files by default [3]. It's a somewhat expected
>> part of this process ...
>> ...
>> Another tool that may help you here is 'git ls-files --sparse -t'. It lists
>> the files in the index and their "tags" ('H' is "normal" tracked files, 'S'
>> is SKIP_WORKTREE, etc. [4]), which can help identify when a file you'd
>> expect to be SKIP_WORKTREE is not and vice versa.
> 
> Wonderful.
> 
> Quite honestly, because the code will most likely compile correctly
> if you just remove the unconditional "we first expand the in-core
> index fully" code, and because the "sparse index" makes the existing
> index walking code fail in unexpected and surprising ways, I
> consider it unsuitably harder for people who are not yet familiar
> with the system.  Without a good test coverage (which is hard to
> give unless you are familiar with the code being tested X-<), one
> can easily get confused and lost.

Certainly, 'git mv' is looking to be harder than expected, but there
is a lot of interesting exploration happening in the process.

Thanks for persisting on this one, Shaoxuan!

Thanks,
-Stolee

