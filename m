Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72123C61D9D
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 18:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjAWSYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjAWSYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 13:24:33 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AC01708
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:24:32 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15b9c93848dso14996250fac.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vT1L1NKDWz0fFbrL1Rl/LUyiZzhaBJ0h7PD1L1gtL1g=;
        b=M0Tc4jWpCEJ4j+QYjSFTQdLpR0tennbrhrfLy9sItbu5mI2pL4gJiYuljBmlSgX7sM
         70fKivb5QJpdksT8V3hx3GG/FsywIsfivILBEADucCfYk8cbVsuy7Z6bRoEv+K8K3t4N
         pl6C1O2EUdz1SFoybZwpNTHDR2MMGaFWNgUBoGrGo4N9MHBf3w7quCZFdXjdNJ2+Z5kp
         uu9NDBvTvmhBgLuxfKe0qphk+cqVxt/IKHjQ7x5zdT0/6oqCgy9r68oQpzP4x4h4tSdq
         dNjfIe2wQWOcz/BVheGX43MKw9sD8IHxrK19gsSiXoflZEWhdGctscKxKjAl6xgpxndD
         wbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT1L1NKDWz0fFbrL1Rl/LUyiZzhaBJ0h7PD1L1gtL1g=;
        b=fIaIXEcO97PLyregMUL/kRwixKUyJc8/hMT/VvkeVZipMeifHKkYrIhSJA9ZyRApwi
         +ofK8jYf00t48Y2KCW77DwjlDH+lm2VFb1qC92QB5L8+uBtrP6Mqm2wsmCDsDOM3cR/w
         OZ6oUK2M/or5iV1akjvQalKs3TCKHlBmjJti3xVqr/0hvSW1Bc1BWQDLzzI3t09YD3Tt
         qIANwFpiERdI+36Y3q7nEhUxHgpMjGSi9NZChbVtBKI/nlxGZMsy66s1yL3t9Wu93R3j
         USk/M51lePG+omMB/K2DhbnfKKRbjXPxgfDIMJwNz1ouI16Qf9Y7Zw0o6hPL6gncQ9MM
         eJAw==
X-Gm-Message-State: AFqh2kqL17++WERviUXJG0GVpXmFu9bvMJSoukTr56j7Npc5OGiaOU2C
        pjf6i3dNTVB4d1i+M9ctJJ7e
X-Google-Smtp-Source: AMrXdXvW1sMWU30YlGiy7pzK8mb2+/rpv4e/pdNzBqBTyb1OjyQb4Zmfv4SrXlXZQquNCrklpks5Bg==
X-Received: by 2002:a05:6870:2a4e:b0:15b:a3dc:d626 with SMTP id jd14-20020a0568702a4e00b0015ba3dcd626mr13245351oab.58.1674498272234;
        Mon, 23 Jan 2023 10:24:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6108:485d:39de:831b? ([2600:1700:e72:80a0:6108:485d:39de:831b])
        by smtp.gmail.com with ESMTPSA id t13-20020a056871020d00b0014435b51ef7sm25596880oad.30.2023.01.23.10.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:24:31 -0800 (PST)
Message-ID: <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
Date:   Mon, 23 Jan 2023 13:24:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
 <xmqqsfg1m8l6.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfg1m8l6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2023 1:03 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When unbundling a bundle, the verify_bundle() method checks two things
>> with regards to the prerequisite commits:
>>
>>  1. Those commits are in the object store, and
>>  2. Those commits are reachable from refs.
>>
>> During testing of the bundle URI feature, where multiple bundles are
>> unbundled in the same process, the ref store did not appear to be
>> refreshing with the new refs/bundles/* references added within that
>> process. This caused the second half -- the reachability walk -- report
>> that some commits were not present, despite actually being present.
>>
>> One way to attempt to fix this would be to create a way to force-refresh
>> the ref state. That would correct this for these cases where the
>> refs/bundles/* references have been updated. However, this still is an
>> expensive operation in a repository with many references.
>>
>> Instead, optionally allow callers to skip this portion by instead just
>> checking for presence within the object store. Use this when unbundling
>> in bundle-uri.c.
> 
> This step is new in this round.
> 
> I am assuming that this approach is to avoid repeated "now we
> unbundled one, let's spend enormous cycles to update the in-core
> view of the ref store before processing the next bundle"---instead
> we unbundle all, assuming the prerequisites for each and every
> bundle are satisfied.

We are specifically removing the requirement that the objects are
reachable from refs, we still check that the objects are in the
object store. Thus, we can only be in a bad state afterwards if
the required objects for a bundle were in the object store,
previously unreachable, and one of these two things happened:

1. Some objects reachable from those required commits were already
   missing in the repository (so the repo's object store was broken
   but only for some unreachable objects).

2. A GC pruned those objects between verifying the bundle and
   writing the refs/bundles/* refs after unbundling.

I think we should trust the repository to not be in the first state,
but the race condition in the second option will create a state
where we have missing objects that are now reachable from refs.
 
> I am OK as long as we check the assumption holds true at the end;
> this looks like a good optimization.
 
So are you recommending that we verify all objects reachable from
the new refs/bundles/* are present after unbundling? That would
prevent the possibility of a GC race, but at some significant run-
time performance costs. Do we do the same as we unpack from a
fetch? Do we apply the same scrutiny to the objects during
unbundling as we do from a fetched pack? They both use 'git
index-pack --stdin --fix-thin', so my guess is that we do the same
amount of checks for both cases.

Since this is only one of multiple ways to add objects that depend
on possibly-unreachable objects, my preferred way to avoid the
GC race is by using care in the GC process itself (such as the new
--expire-to option to recover from these races).

Thanks,
-Stolee
