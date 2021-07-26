Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD04C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6514160F45
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhGZMbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGZMbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:31:05 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1619C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:11:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r5so8781662ilc.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yw6fvERMyiMu/DHU3NTHTkKCbPnDuC2GzYbMxyIfyrw=;
        b=StgMQ3sCBaSpYlSWzL6nufYdlzRp1QvWTHjU5qGGM3Kp9co164TKjHzaCxSDPpXmY4
         nDaOBwlMF06mCBDGxNcfBdpklWWuJ2ZCQwRJ8kT4jXT9LCqiMcaaX7PQUoeHiJKVxkUZ
         UphVHRaOkt44Ojtcr8SG2NEPwc3lL0TEDDZGVC+26o/+49DVeOI3fnUtfaeLr/jzfqh8
         QJu/dAgfHQxAYlW1Qq0GxalxjhUw1ZI9E/+b2SENv7VGB+ma374cxeohFA2y48MFBMjk
         leDZmZ5ztdRcugtxPrvnozJgNm9sV8ZKpOzT3JLaufejmHOE1Gn+UvOHButerokkuPAI
         GZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yw6fvERMyiMu/DHU3NTHTkKCbPnDuC2GzYbMxyIfyrw=;
        b=oAu4niyejpQuu4BK//VQL+KlhWJqlrREFKp8Fs9aN1JYxYDjfE2l6dzSEw0YkdYvu/
         aqKlf2EmEyQzpDmKw0HYikaci3L1JnMjvc494PMwZc+dJD37eBU9434VON5lXzZnuF4e
         e1bSBaveXXbZPrA/txgbGza8puVhIhwJehhYzDk0uTpI7yvjT/nwcBqjCN+1y02NgSa1
         Qw6Q6/dyAE1pdRVR+NvTOvLyvS+OYLAAeAFBbNfu9dxzSw/teC35ZPiP/LEi1BfKZ1SG
         kiwhYyfgstsiceU9QzBm+Okhi3rPPglfZ/nZzlIf6PyAkJ4iB8bFK+3EDOT+A5RLc/Dw
         6Dmw==
X-Gm-Message-State: AOAM531pE/fxK2wQ2f998COT0EJN7s7OsEp2bsJH0TNetLzRoLjCaxkU
        1czji7YyVV78O2mRDMUloFU=
X-Google-Smtp-Source: ABdhPJwCWGnY70nXTISRri3XDHYtwCVmsMdrTvS6/4T9y2d3ChOsMWgdvcEU2W1n6W2IBTS8igk3Rw==
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr12894093ilo.227.1627305092018;
        Mon, 26 Jul 2021 06:11:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id r12sm1566040iod.0.2021.07.26.06.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 06:11:31 -0700 (PDT)
Subject: Re: [PATCH 2/5] add: allow operating on a sparse-only index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
 <CABPp-BHQ52WpCKc8dxaV+u1QZCeT-YieQynTmK_w84r_Tc=VGQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a7f504a-99af-ce89-307e-5a662d69f5fa@gmail.com>
Date:   Mon, 26 Jul 2021 09:11:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHQ52WpCKc8dxaV+u1QZCeT-YieQynTmK_w84r_Tc=VGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 1:45 PM, Elijah Newren wrote:
> On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> Test                                  HEAD~1           HEAD
>> ------------------------------------------------------------------------------
>> 2000.6: git add -A (full-index-v3)    0.35(0.30+0.05)  0.37(0.29+0.06) +5.7%
>> 2000.7: git add -A (full-index-v4)    0.31(0.26+0.06)  0.33(0.27+0.06) +6.5%
>> 2000.8: git add -A (sparse-index-v3)  0.57(0.53+0.07)  0.05(0.04+0.08) -91.2%
>> 2000.9: git add -A (sparse-index-v4)  0.58(0.55+0.06)  0.05(0.05+0.06) -91.4%
>>
>> While the 91% improvement seems impressive, it's important to recognize
>> that previously we had significant overhead for expanding the
>> sparse-index. Comparing to the full index case, 'git add -A' goes from
>> 0.37s to 0.05s, which is "only" an 86% improvement.
> 
> Hehe.  Yep, it's so "disappointing" to "only" have the code be 7x faster.  :-)
> 
> Out of curiosity, IIRC any operation involving the index took ~10s on
> some of the Microsoft repos.  What does the speedup look like over
> there for these changes to git-add?

The latest numbers I have for a repo with ~2 million tracked files is that
 index reads take about half a second (because of the threaded reads) and
writes take at least one second. There was a lot of work by Ben Peart, Jeff
Hostetler, and Kevin Willford to reduce this cost as much as possible a few
years ago. VFS for Git is still limited by this bottleneck, but Scalar's
use of sparse-checkout enables the use of the sparse index.

We have an experimental release [1] out to users right now, and I will
report to the mailing list about how that went after we get sufficient
adoption that the data can be significant. When focusing on individual
users I can find things like one user seeing "git commit" going from 4.3s
to 0.35s and "git add" going from 6.1s to 0.13s. (The "git add" time
might also be conflated with a change from the FS Monitor hook to the
builtin FS Monitor.)

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Thanks,
-Stolee
