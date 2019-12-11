Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AFDC00454
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC752173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrU0okVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLKTLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:11:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46488 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTLe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:11:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so7213026qtb.13
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZfJuwaYXTC0QxDURn/v7T7gn40Qq/sGl5HNzhQuR5s=;
        b=RrU0okVPWVbKTwXqa6jw/aw3o6ONnaE9VVIuwKeIS9VCnzDm1IYZxafdgvESkxK4gA
         yehFIjA50s2jx8ToXKG382dZvWkCjfpTtL8mUP0FCdLvMZc76c+taPfN/1lIIi+t/5FN
         cthtL6yWSSbDnrcggRCJYoOSJhn75L9VDjkms9/5yNOEgWwGX8cQ32shJmuIwu8YXd3v
         Kqa2kR3CxilfKcXAM7JiD5qaHFhiswj6yptsNCF9MYoc7wnB3naN4d6vb9MmdFTrrKy9
         70yPzWcOnJErcCW6MYH7qMvqDLssTEt+vBUyj7dyTi4zNAkNSoQzxS3WFbtboIZQ78HC
         m2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZfJuwaYXTC0QxDURn/v7T7gn40Qq/sGl5HNzhQuR5s=;
        b=XAEPi5CMGixP8K/BR3EcXb3GnzkZnBbS0751uu2FIo24sXXGlMawAgT7ZUCfY20etf
         l26Y50LTOVZKMbVbOXG51cAE3qMTUBrYhwbh/c5pnj1r5xgXgwD6HtzEHQ0xzNSMKwON
         jHRjzHnigdA3UOJUoZx+wuU3WymdCpcOCnN7wczwoiuN6aeHTbH/XlO1LFYDi2ZaiKy7
         dLvLJgoGIoLnQDPspisDvz8Bf9cEhiexsePt6oQva1EjqCWtF60u6GfvAmEUj1TYORGP
         4QlViJ8kCTFIX9LQ8L9eJZALjMPTPM1ZsK22WGK02U6iKOcA5fRfIwlfFk2/848upU+/
         t4IQ==
X-Gm-Message-State: APjAAAVQ/lvRNY+HY93AUxP2kuvpPU/yd/bQWWPRxBF5WIhcEl2pyhd5
        mAZDcyoDX9HOiqkSuWyUWDA=
X-Google-Smtp-Source: APXvYqz92apcKZ258YfkiOwc37eEmPendnJ5hMq/om09F+rn32mqz2FXwb+gyjWwiNMSaxoAKtYc3A==
X-Received: by 2002:ac8:5350:: with SMTP id d16mr255332qto.60.1576091493660;
        Wed, 11 Dec 2019 11:11:33 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3126:c1d8:6135:a84d? ([2001:4898:a800:1012:e259:c1d8:6135:a84d])
        by smtp.gmail.com with ESMTPSA id l62sm955452qke.12.2019.12.11.11.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:11:33 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
 <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
 <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9dbf6d43-ac1e-4790-84e5-4829d21f5fdb@gmail.com>
Date:   Wed, 11 Dec 2019 14:11:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 1:44 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Another option would be to do case-insensitive checks while
>> updating the skip-worktree bits during unpack_trees(). Outside of
>> the potential performance loss on a more expensive code path, that
>> also breaks compatibility with older versions of Git as using the
>> same sparse-checkout file would change the paths that are included.
> 
> I haven't thought things through, but that sounds as if saying that
> we cannot fix old bugs.  We use the entries in the index as a hint
> for "correcting" a path to the right case on a case-insensitive
> filesystem to avoid corrupting the case in the index, which is case
> sensitive and is a way to convey the intended case (by writing them
> out to a tree object) to those who use systems that can reliably
> reproduce cases in pathnames.  But that still does not mean on a
> case-insensitive filesystem, "hello.c" in the "right" case recorded
> in the index will always be spelled like so---somebody can make
> readdir() or equivalent to yield "Hello.c" for it, and if the user
> tells us to say they want to do X (e.g. ignore, skip checkout, etc.)
> to "hello.c", we should do the same to "Hello.c" on such a system, I
> would think.
> 
> If the runtime needs to deal with the case insensitive filesystems
> anyway (and I suspect it does), there isn't much point matching and
> forcing the case to the paths in the index like this patch does, I
> think.  So...

I'm trying to find a way around these two ideas:

1. The index is case-sensitive, and the sparse-checkout patterns are
   case-sensitive.

2. If a filesystem is case-insensitive, most index-change operations
   already succeed with incorrect case, especially with core.ignoreCase
   enabled.

The approach I have is to allow a user to provide a case that does not
match the index, and then we store the pattern in the sparse-checkout
that matches the case in the index.

Another approach would be to make the sparse-checkout patterns be
case-insensitive when core.ignoreCase is enabled. I chose against
this due to the compatibility and the performance cost. We would
likely pay that performance penalty even if all the patterns have
the correct case. It violates the existing "contract" with the
sparse-checkout file, and that is probably what you are talking about
with "we cannot fix old bugs".

It sounds like you are preferring this second option, despite the
performance costs. It is possible to use a case-insensitive hashing
algorithm when in the cone mode, but I'm not sure about how to do
a similar concept for the normal mode.

Thanks,
-Stolee
