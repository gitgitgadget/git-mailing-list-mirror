Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20101C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D842F20870
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwPxqZKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgJLSkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbgJLSkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:40:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F9C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:40:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u17so19729772oie.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Bx09qmd+2brIA0yTYUICNM5kkrp1XNKQXTTqErBXfY=;
        b=ZwPxqZKhWAwMa4QkmUOyggEjQOHaiTDJccrK9FIs9/DkIjeRbdgkcJZWur4fNY9Hoy
         VePeSrLCteoolkuOHsiG7fttM3f+Kwh/b4Ym2XZHxdwpJeQOkpy9/wcoqrq0r8OYHh+E
         XNcJ7xjWqkMjYASDk1CVv5V81O1E3bal5bc+L3F/vbWzEy3aQdopp0Czkz/sd0kXw81r
         jk6sSX9DhzGkyPhWM8BbiFUa7p57MNYXn48nWC0TygUmcLZ3AoWs4SdUAlK/IpYz24Lo
         Pha2vh8X97rUT66rCjx86eQlapFsRih0fOCbx4vWk+Y35zo1NgwRt/CuGksYhVbbpWYr
         Oe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Bx09qmd+2brIA0yTYUICNM5kkrp1XNKQXTTqErBXfY=;
        b=PH9UMOsdG6bIn7YlgCEKJePo1BJDWdxI5pkEtVK1nXJYXOM6Tp/FWe0q3RR/x7OVcb
         xuUaR2EIg4BEXj/5LAW95iArehzS75Ra4AsmM5Z03Ei8FXy2g98m4l43EqyGMz67dXHQ
         PfqsRZdk1TJaMHvCtfPfsYf/NwHjGd9HcCzEUcsWW8ORmWNIXHQ8d0sFyeMvOTf023rT
         XayyN6/NkCNAyKxCP7rSuKfx1rPQIFETN/QiZohIk3B3Yw+wbEfsr92N2H6T6n9jfP8s
         +t+wXI4Xg/sKMnMNBoBeY8akPvPDufL5k3shh2DHYm4eTwNOLwV/+zsEYKTo7+90dIoz
         isFg==
X-Gm-Message-State: AOAM532i2UU0z8BjQA9qJ2ReG3sQEM8S7ILm5KU0tdkqwc0CF0rtUutM
        bD8pBQA3e0alJyUKfbEg+T/FZJP2D6uE+w==
X-Google-Smtp-Source: ABdhPJyKP4D10SAYLO58iAP4wbOw27KlgUijKaOo62FIEXff+wZojvYAD8l+KO4mAfm2At3ztRUyyw==
X-Received: by 2002:aca:c341:: with SMTP id t62mr6529870oif.73.1602528015694;
        Mon, 12 Oct 2020 11:40:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c39:e464:ba46:aa5a? ([2600:1700:e72:80a0:3c39:e464:ba46:aa5a])
        by smtp.gmail.com with UTF8SMTPSA id 2sm9395318oty.59.2020.10.12.11.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 11:40:15 -0700 (PDT)
Subject: Re: [PATCH] maintenance: core.commitGraph=false prevents writes
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.749.git.1602509314545.gitgitgadget@gmail.com>
 <xmqqwnzvpd1i.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e2b2da5-526e-efa6-a127-7aa7a8c07c88@gmail.com>
Date:   Mon, 12 Oct 2020 14:40:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnzvpd1i.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2020 1:30 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Recently, a user had an issue due to combining
>> fetch.writeCommitGraph=true with core.commitGraph=false. The root bug
>> has been resolved by preventing commit-graph writes when
>> core.commitGraph is disabled. This happens inside the 'git commit-graph
>> write' command, but we can be more aware of this situation and prevent
>> that process from ever starting in the 'commit-graph' maintenance task.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>     maintenance: core.commitGraph=false prevents writes
>>     
>>     As requested [1], this prevents the extra process when core.commitGraph
>>     is disabled.
> 
> That's not a request.  I was just wondering aloud.
> 
> If you took inspiration from my thinking aloud, that is wonderful,
> but the actual work to ensure it is not an idea that horribly breaks
> some underlying assumption I didn't know about in the code and
> deciding it is a good idea to do so is all done by you, so please
> take the credit due.

Ok, I saw your comment and I thought "no harm in dropping an extra
process." The patch to no-op the write does more work than this one,
and the commit-graph maintenance task would automatically stop
writing the file but will output a warning.

> There is a call to prepare_repo_settings() in cmd_gc().
>
> I have to wonder if it should be done much earlier and in a more
> central place, perhaps in cmd_maintenance() before anything else
> happens.  Even though commit-graph may feel somewhat special only
> because it is relatively new, it is not hard to imagine that other
> maintenance tasks (both older ones and future ones) would eventually
> want to have similar access to the feature settings.

This "prepare_" pattern is like using "prepare_packed_git()" before
iterating on the packed_git list. We use prepare_repo_settings() to
ensure they are loaded before we use the settings. If the settings are
already loaded, then prepare_repo_settings() exits quickly.

Perhaps it is worth claiming a region of code requiring that the
settings are initialized before calling, but that may lead to issues
in the future that I'd like to avoid. Having a few extra calls to
prepare_repo_settings() is the right trade-off in my opinion.

> It is OK to keep "the maintenance command works only in the single
> repository", and not passing a "repo" that cmd_maintenance() would
> prepare by calling prepare_repo_settings() down in the callchain, at
> least right now, but we might want to consider doing so in the
> future.

Removing the use of the_repository is a worthwhile discussion to
save for another day.

Thanks,
-Stolee
