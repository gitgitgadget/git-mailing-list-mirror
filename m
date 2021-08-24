Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B9C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D611761357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhHXSb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhHXSb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:31:28 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F3C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:30:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y144so24258605qkb.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l5kJqwPwSPC7Gc++QrAGy1q4IKHkbidXOMqAzlwUo5I=;
        b=r65tZbKnaMuBODiN8t760nBbJVAlnlGfU3HtT0mJtvDQ+TEXWM6kqNMWNoeje808jq
         0CsJ46ldEVRtU2DCbMhaLUOvWlZgO2EASDHHaE2le4E0sr3Q1OBh3+J9L11CVHAHz8QH
         LE5sI4US9ZF5BClwJICHXT2uazVpoPpPIrzxZhX7fBvZnQ1aZqC2Qj6X6Tx04SvvRdy7
         a1TDJVYPKnZKDJtzz3NFGwtIoBO6XOZOXXth4z+0BQa4VC74+ZEEo14qkN2CfNv6CuBi
         hjzSkO2iHxyDTtloRwFboSoD86IE6Ug+zJ0WWGmxPZTH8KlTfFIjQgZ8PbR0Kf+WF/Xx
         adAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5kJqwPwSPC7Gc++QrAGy1q4IKHkbidXOMqAzlwUo5I=;
        b=FT5QQENR+/po2kIk1jLJ3BEUoaPLPfaa7suBwn1JY8PRBn7wFARrtf6mkQs8pLdmTK
         Hpfq6vS0LWwBqOwfSjLEf7sm3NpR9UL2MNdw09C/bbxgnhvZcYFG3EPelUFMUe44GujT
         oMML6wF7aQ1UBzG61d7zQAUkrFm4q87NXVwkRHk6I7RzSf+yWk79lof566yjeI4NGv7h
         oJzKJb36qybT8FZ1JbErCUMwaiX12a4iZrJIwlXRiO0Vgfm19fjTCdQU3/rX8urE/hLS
         Xdp4/vsJ43Ck6WI29zBd5J0Xhva0oI0kUEFcJX8HeauwVWaDq2nOtioagKy1RA9/ZpR+
         cmxg==
X-Gm-Message-State: AOAM530F9nKRZ0WgHWcsoX8L/6/A3yaLvvfAYlIy4Iy3TGuBjhJBWJWl
        qoRPBUNptCGsymesuMOxSdY=
X-Google-Smtp-Source: ABdhPJxMYQtcmJs1KE3D7k5TVUyv7PL3UX8fyGxaH32Itkx3YluUppsS5SyMrCMaQfHS9P2QpFZUYA==
X-Received: by 2002:a37:a643:: with SMTP id p64mr28150277qke.314.1629829843101;
        Tue, 24 Aug 2021 11:30:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id 37sm8998315qtf.33.2021.08.24.11.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:30:42 -0700 (PDT)
Subject: Re: [PATCH 2/6] diff: ignore sparse paths in diffstat
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <9f50f11d394e46ffbe348a579792c2b683096452.1629220124.git.gitgitgadget@gmail.com>
 <CABPp-BFu29JHkoBERcVnV_NooSaVDrFEiR-NQRu-ehTC4iRHiQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d77ae8ce-977a-82d9-f28c-f57271fbf923@gmail.com>
Date:   Tue, 24 Aug 2021 14:30:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFu29JHkoBERcVnV_NooSaVDrFEiR-NQRu-ehTC4iRHiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 5:32 PM, Elijah Newren wrote:
> On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The diff_populate_filespec() method is used to describe the diff after a
>> merge operation is complete, especially when a conflict appears. In
>> order to avoid expanding a sparse index, the reuse_worktree_file() needs
>> to be adapted to ignore files that are outside of the sparse-checkout
>> cone. The file names and OIDs used for this check come from the merged
>> tree in the case of the ORT strategy, not the index, hence the ability
>> to look into these paths without having already expanded the index.
> 
> I'm confused; I thought the diffstat was only shown if the merge was
> successful, in which case there would be no conflicts appearing.

That's my mistake. I'll edit the message accordingly.
 
> Also, I'm not that familiar with the general diff machinery (just the
> rename detection parts), but...if the diffstat only shows when the
> merge is successful, wouldn't we be comparing two REVS (ORIG_HEAD to
> HEAD)?  Why would we make use of the working tree at all in such a
> case?  And, wouldn't using the working tree be dangerous...what if
> there was a merge performed with a dirty working tree?
> 
> On a bit of a tangent, I know diffcore-rename.c calls into
> diff_populate_filespec() as well, and I have some code doing merges in
> a bare repository (where there obviously is no index).  It seemed to
> be working, but given this commit message, now I'm wondering if I've
> missed something fundamental either in that implementation or there's
> something amiss in this patch.  Or both.  Maybe I need to dig into
> diff_populate_filespec() more, but it seems you already have.  Any
> pointers to orient me on why your changes are right here (and, if you
> know, why diffcore-rename.c should or shouldn't be using
> diff_populate_filespec() in a bare repo)?

I think the cases you are thinking about are covered by this
condition before the one I'm inserting:

	/* We want to avoid the working directory if our caller
	 * doesn't need the data in a normal file, this system
	 * is rather slow with its stat/open/mmap/close syscalls,
	 * and the object is contained in a pack file.  The pack
	 * is probably already open and will be faster to obtain
	 * the data through than the working directory.  Loose
	 * objects however would tend to be slower as they need
	 * to be individually opened and inflated.
	 */
	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
		return 0;

or after:

	/*
	 * Similarly, if we'd have to convert the file contents anyway, that
	 * makes the optimization not worthwhile.
	 */
	if (!want_file && would_convert_to_git(istate, name))
		return 0;

(This makes me think that I should move my new condition further down
so these two can be linked by context.)

Sounds like this is just an optimization, so it is fine to opt out of it
if we think the optimization isn't necessary. Outside of the sparse-checkout
cone qualifies.

Thanks,
-Stolee
