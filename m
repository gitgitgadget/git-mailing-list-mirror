Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C0DC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7061353
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbhERO6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbhERO6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:58:38 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB820C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:57:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so8860793oth.8
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1slN2gr68RfZTr3EYoTH4/wEI91UuaYwBYqA9FQDLVw=;
        b=aEt/rCVfp026oCR/tx8d8HExnwak0N3zugmPHkVSMZi60w4Ta+/tY1msKhPK6kj8FP
         gNc+A4VXbqraLaysOO3EfF/5DCJ1g+I1H5ZN8t1QpZHsz4p/rXSpl8Qe/nVn3n2SxBrO
         oX/1CHSS2xdzZ7mN6KZmswnUGg5bPVoh99YJv09eHa6kC37imGGr64e4cZKumZZLNgUe
         rqO2N5zHhSVqozqoHKeWCgu/Y4ZXNKCZaQnQxWJ74mqszqXwnx/Pzj5zNxZuEcg3JImN
         BU+E9kf7DOg87u1w/DVHrsWfdtFd3bauArJOZUNg361zRnqhynugpmkI0WgDDxe4Rd7C
         2ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1slN2gr68RfZTr3EYoTH4/wEI91UuaYwBYqA9FQDLVw=;
        b=bm0m+n0gUGuYOavzCaEfDqblkVDhwoTpuiL9GI5boagRTtBPt0Y6mB+5r2deEHkcWQ
         HvWyjRw7HS/vNMa1ioe8T8DlLYro/7qmgaESdhwEXadffmB8XHRbyZNl9y9fcmUy1iOO
         VDcBcEfhZV1pKqfpOvRPIz4Pqficlud2P8MS5OVsrmeefEx6TXxO9nCrEHAL3uH7xI4m
         wb2vJ1wGZzwvWw5MrMWUdQZ58EznSGGXOuDa3Ewp5yCZ9kT6YSNVMlsTYDeCD+JMjVO8
         8rGMD36LsoimSaYfWp3tjqGRiTknOqbTy37ZT9jiILltkFUZalMhJGBfPI+U1p5k/Or4
         YSHA==
X-Gm-Message-State: AOAM532Eubu/dcg2G+ndJ2Bvo411pjtCSjA/jclMFVNvIS2hUV6PfcIR
        3ckWNjQ0Vb00tUgWOn31SAc=
X-Google-Smtp-Source: ABdhPJzUn1Sk5x4HZpGbnrss9ShnV2zZjG0Sw+S7nmDFx6Wy91/h5EGPTMqmgirzTF082TCrgskX0g==
X-Received: by 2002:a9d:721e:: with SMTP id u30mr3034178otj.250.1621349840243;
        Tue, 18 May 2021 07:57:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id o15sm3768445ota.61.2021.05.18.07.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:57:18 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] sparse-index: include EXTENDED flag when
 expanding
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BFx9=7j5LrLnQwzxba+i7_cAEXngzyt9rfOJfBuqOPBsw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddeda8ec-bc21-1f62-5d0e-839be74f1ec8@gmail.com>
Date:   Tue, 18 May 2021 10:57:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BFx9=7j5LrLnQwzxba+i7_cAEXngzyt9rfOJfBuqOPBsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 9:33 PM, Elijah Newren wrote:
> On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When creating a full index from a sparse one, we create cache entries
>> for every blob within a given sparse directory entry. These are
>> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
>> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
>> correctly written to disk in the case that the index is not converted
>> back down to a sparse-index.
> 
> This seems odd to me.  When sparse-index is not involved and we are
> just doing simple sparse checkouts, do we mark CE_SKIP_WORKTREE
> entries with CE_EXTENDED?  I can't find any code that does so.
> 
> Is it possible that the setting of CE_EXTENDED is just a workaround
> that happens to force the index to be written in cases where the logic
> is otherwise thinking it can get away without one?  Or is there
> something I'm missing about why the CE_EXTENDED flag is actually
> needed here?

This is happening within the context of ensure_full_index(), so we
are creating new cache entries and want to mimic what they would
look like on-disk. Something within do_write_index() discovers that
since CE_SKIP_WORKTREE is set, then also CE_EXTENDED should be set
in order to ensure that the on-disk representation has enough room
for the CE_SKIP_WORKTREE bit.

I suppose this might not have a meaningful purpose other than when
I compare a full index against an expanded sparse-index and check
if their flags match.

Thanks,
-Stolee
