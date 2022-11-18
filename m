Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0CC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiKSAGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 19:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiKSAFp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 19:05:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C355D06EF
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:31:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v17so5879013plo.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDT1XGpYfhkfkD4ZfuMwKY2cnuJCaKKrT3bCaghHiGU=;
        b=qzwgFebLWaQjc2ECIRwlCh/GuCjnUfRlQQe4cLqoVhLFjfMKz5XJGvHthqFg9iuHqr
         6zLcfRCJrVHFlzemFFQaj50kiLGJEdXx2vPps+DD0IOwOfaJosYNN1ByZEaDhQJ9g/hZ
         iIgK0GvwtbGk6VHaormhFOQj6QVkwGjbud1fwBUJ6dkohmF20pmeHUVTJMl1oPhlNceg
         GYVFLUa6UBbv4HqnU+D7DNKfp0xAzkDoX2qt25juKHQMVIet4NvSBoYTyqYwZpmzql5h
         7vW/qdPtePemNCH02UqSV53DVce0Bvar3HMiuIMzSoumxKysRAStwjjZl5i8nH9+u8eN
         KtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uDT1XGpYfhkfkD4ZfuMwKY2cnuJCaKKrT3bCaghHiGU=;
        b=eHwbj4U0dOuYpgZU0IfOhAaaRutjnfsj943kNm6I4vx7cxupGbqB9K66+6CmCu+kI1
         LCYDKx9zuFaL+ISGIeu3HrXFMDtVadMNInWvY5lVlb2yzVNegdeItTLKGzSNS11vvpxA
         OXpG1s+BHIscYUdnDNTBHhcqbqltWf+P4FIaI9n9DnfBChJNrGTNJuAlSZpjUF+iLUpA
         cf9U+ebgBeyP4V6ytgmrIB+CXey6YbGt5xp8zht6dH0YvCHz/LadagCQ9bQ40mblhDW+
         P+5PYak2AL+ICte4CiKwvb8ZpcFXKa0SA1/qBQQj0+gnflBqOmRTKSW103V6uIy/wwZ7
         qOIA==
X-Gm-Message-State: ANoB5pmIEXpHbj9FLRqzXl/7Pfea9Ihv7657IHaEURDSlVW5n0kG99RA
        AB+/Gs+kv6AjTghaoJQp9WY=
X-Google-Smtp-Source: AA0mqf5jXFDupdobcWC28IhuJKrCf/iHEspXc9qBisclkUFurcVm9iMHagBc8O9+USv4yjo9uJDB9g==
X-Received: by 2002:a17:90a:307:b0:213:ff80:b37f with SMTP id 7-20020a17090a030700b00213ff80b37fmr16110890pje.118.1668814279377;
        Fri, 18 Nov 2022 15:31:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n17-20020aa79851000000b00562677968aesm3752937pfq.72.2022.11.18.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:31:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2
 file format
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
        <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
        <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
Date:   Fri, 18 Nov 2022 15:31:18 -0800
In-Reply-To: <0e156172-0670-2832-78cb-c7dfe2599192@github.com> (Derrick
        Stolee's message of "Sun, 13 Nov 2022 19:07:21 -0500")
Message-ID: <xmqqiljbkfg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 11/11/22 6:28 PM, Elijah Newren wrote:
>> On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> Introduction
>>> ============
>>>
>>> I became interested in our packed-ref format based on the asymmetry between
>>> ref updates and ref deletions: if we delete a packed ref, then the
>>> packed-refs file needs to be rewritten. Compared to writing a loose ref,
>>> this is an O(N) cost instead of O(1).
>>>
>>> In this way, I set out with some goals:
>>>
>>>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
>>>    updates.
>> 
>> Performance is always nice.  :-)
>> 
>>>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
>>>    refs and creating a clear way to snapshot all refs at a given point in
>>>    time.
>> 
>> Is this secondary goal the actual goal you have, or just the
>> implementation by which you get the real underlying goal?
>
> To me, the primary goal takes precedence. It turns out that the best
> way to solve for that goal happens to also make it possible to store
> all refs in a packed form, because we can update the packed form
> much faster than our current setup. There are alternatives that I
> considered (and prototyped) that were more specific to the deletions
> case, but they were not actually as fast as the stacked method. Those
> alternatives also would never help reach the secondary goal, but I
> probably would have considered them anyway if they were faster, if
> only for their simplicity.

I have been and am still offline and haven't examined this proposal
in detail, but would it be a better longer-term approach to improve
reftable backend, instead of piling more effort on loose+packed
filesystem based backend?
