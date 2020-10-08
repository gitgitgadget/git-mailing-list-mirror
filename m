Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DEC4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C47C21D41
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/HyNr8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgJHO3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgJHO3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 10:29:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8DC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 07:29:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c23so5255147qtp.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IHTM4JrMCFR1G1a1EAwpkZtU8eXO3KcHUZS3NtTD62M=;
        b=n/HyNr8xsfquocmMzKTW9FWc9O7ULAb7lYhZULI+/sIuJ4ebJ6Q/JWWszs/vlHbnWF
         NELmZvLRMbfKCU2vTMK8SKPrx82R/rDRvqi5uwCezbGgP0J/PfO6Evo6dkdwkaKfL5lV
         dCr3QOZD7dxv5Y/oC5VjYvonJKQABCUH3QSn9m+1rI1SujvW7k71PrQxR93yoFsfz38n
         sCv5rkEH+ga8u2VX4T13u8EBn1P+R90fsZLxekZvQGs2vW+mwgcvnECRXqyhXr34dOeC
         u6RGoCjAERdtwCxqe35NiFme0g8UuUTPNPvbUF6A6S67lBHoz1cj9bhe8vbG0AiTMzOT
         KdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHTM4JrMCFR1G1a1EAwpkZtU8eXO3KcHUZS3NtTD62M=;
        b=NqQYXgG9IfwynuGAZaTYVMu02orl/SNJNohntRXnuNoLGtvAfPQZl+iuPswCo4V2XT
         6EMHP0BqlcH1Yas6sRmhMF5XiyewGoggR+q4Tm31+e4nFkBBaz7n5k5o75/GVYgEp3TS
         fa5NhDEyBxhIs7nnsOuz9NT/dNW8M7GfBLphR1MRxLDIyB9CMrPz6QIauwYV2B8FGiyG
         JTw5ZZCqiH+GJZ/fiXZbiWjySb6r9zvBtcBJB6RvCs2emyv7ffoYvdIsZG/dKDEvF1uO
         FzLX7y/xkSxZrZwFH1lMGmL4/6eMSVxt7avnuyeucB6Zm3qr3wXBNU9XDto9G0+HJV+J
         IgQg==
X-Gm-Message-State: AOAM532GWZ63FuMGVCgTbe7pFH6v/WtY5tC0+nRQlOreMnNHTs1A2NP4
        eL78i1SWCH0hJ6vhMaY0nTs=
X-Google-Smtp-Source: ABdhPJy+aibeoZwm76W7Z8VDq2y93DuhYx10aVlGx/g8HhYDw3oe6mfWydAXDxXGhSiEhzCIKaQh6w==
X-Received: by 2002:ac8:1a6f:: with SMTP id q44mr7898460qtk.136.1602167354738;
        Thu, 08 Oct 2020 07:29:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:56e:1bd4:bf96:36ec? ([2600:1700:e72:80a0:56e:1bd4:bf96:36ec])
        by smtp.gmail.com with UTF8SMTPSA id h47sm4126947qtc.80.2020.10.08.07.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:29:13 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: ignore duplicates when merging layers
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.747.git.1602165413035.gitgitgadget@gmail.com>
 <20201008141527.GA351725@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3571945a-5cac-15fa-773f-2eeb06dc0f6a@gmail.com>
Date:   Thu, 8 Oct 2020 10:29:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201008141527.GA351725@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 10:15 AM, Taylor Blau wrote:
> On Thu, Oct 08, 2020 at 01:56:52PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Thus, this die() is too aggignoring the duplicates.
> 
> s/aggignoring/aggressively ignoring ?
> 
>>
>> This leads to some additional complication that we did no have before:
> 
> s/no/not, but I am more wondering about what "This" is. I think what
> you're saying is: "Suppose we didn't die on duplicates, what would
> happen? Well, there'd be some additional problems, but here's a way that
> we can fix them (storing the de-duplicated OIDs separately)".

Thanks. The message will be edited to fix these brain farts.

>>     I still don't have a grasp on how this happened in the first place, but
>>     will keep looking.
> 
> I'm looking as well, but I haven't found any smoking guns yet. I could
> imagine that this is a problem that existed before 0bd52e27e3
> (commit-graph.h: store an odb in 'struct write_commit_graph_context',
> 2020-02-03), and simply couldn't be tickled because of how brittle
> comparing ODB paths is. I could equally imagine that 0bd52e27e3 did
> introduce this problem.

Thanks.

>> +	ALLOC_ARRAY(deduped_commits.list, deduped_commits.alloc);
> 
> I'm not sure that this deduped_commits list is actually necessary.
> 
> It would be nice for this caller if ctx->commits were a linked list
> since it would make deleting duplicates easy, but I think that it would
> be a burden for other callers. So, that's a dead end.
> 
> But what about marking the duplicate positions by NULL-ing them out, and
> then taking another pass over the list to (1) compact it (i.e., push
> everything down so that all of the NULLs occur at the end), and then (2)
> truncate the length to the number of unique commits.
> 
> I could imagine that something like that is a little trickier, but it
> seems worth it to avoid doubling the memory cost of this function.

You are correct that we can just re-use the commits.list by "collapsing"
the list on top of duplicate entries. I'll send a new version that does
exactly that.

Thanks,
-Stolee
