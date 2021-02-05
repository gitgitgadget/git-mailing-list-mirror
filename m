Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9EC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DB364FA7
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 02:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBEC1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBEC1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 21:27:47 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2FC061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 18:27:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i20so5510688otl.7
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 18:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JTyQBKuVg4rajf25tlBUdCoNZ5Lbc2gwVXbbioQZ3CA=;
        b=MKFHpP04zNO6exQKIvVLzBQYurBkkckra5l8N4TYq10bH2yFaXLAUIvrz0lPnhjGUm
         LkVp1iT+SxoaelE+8s8Pl0SYAezwfpHGljLYEVvKzMydVMq9Vgmx9JzIej4Ga3oeKIWv
         GCZdcaenZaroVoU90cIwl9dVP7Gm9H1ZvTWAcKFcqmQGYPRg8ITa3NxMMwmVocPQP3qv
         GjZpkscEyVg9FWDUeRz5AV/lVA8hHm/JL80fyBcJRl6eJyt2cfC0tK0CARzFvP2W4o8n
         xQs1oh+YnCd3kh8cPkXv5VUx3o+UEJ7eBA71dBwbje/5cXc7L1ERH9iWdlO0+xCEvBvY
         M16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JTyQBKuVg4rajf25tlBUdCoNZ5Lbc2gwVXbbioQZ3CA=;
        b=F2TZgMHC8kmzVnWTbCecOzrXb4CAF2oCR0BUdsrOKHWWQZ4b0I32XOJVXqgAhyvAS4
         +T4GlLoE2W9te2SvDA1e9QUwnc7jkKmhNa65Oph+CEpyN0u2b1/AnNCO5dKKVNic0aEX
         lLSb0jsknQgPqv+HXhLpzeEQ8bmsd9qXq2K2o5aVFGHkoS+3XnyF5WJSA+3cQT0W8d9e
         haKq6ZYJMLOsmOjGCP31KG5QtOT6mLhk8C9MtWVM/eGPxVLDpKrSOrXj0BYxRuPmyLgh
         5FI92jTN+G4cuJ1BPquu9EPLuhZy9WejA06K9eLt/wfL4pCNB8h6YAOHnHhMpRvLIuhK
         PvAw==
X-Gm-Message-State: AOAM530rVYyL8UDijjlzd6w84pJkj+CqJtwqGb+N8vzj4gCZ4K592eGZ
        KDmHgWf5qu5yH1pLvI7O+Ho=
X-Google-Smtp-Source: ABdhPJxWwJEM9j4LEYrJzHXEB/A/Ps9ZzxqgqKcs+lX+Ss4BRtLhCxQnNyBmaZjC/YBwA7/VTrneCQ==
X-Received: by 2002:a9d:22c9:: with SMTP id y67mr1720197ota.247.1612492025582;
        Thu, 04 Feb 2021 18:27:05 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id j100sm1517612otj.66.2021.02.04.18.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 18:27:04 -0800 (PST)
Message-ID: <6fec49f1-3ea6-f365-ed54-b1e7d44bcefe@gmail.com>
Date:   Thu, 4 Feb 2021 21:27:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 00/17] Refactor chunk-format into an API
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <xmqqa6sj2rm1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa6sj2rm1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 9:08 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This is a restart on the topic previously submitted [1] but dropped because
>> ak/corrected-commit-date was still in progress. This version is based on
>> that branch.
> 
> I've read the topic through, and found it a pleasant read.  There
> are some questionable use of integer types, some uneven application
> of casts, and the reading side API is somewhat underdocumented, but
> the overall direction looked quite sane.
> 
> I am undecided if I should expect a reroll, or declare what we have
> "already good enough" for 'next' and expect incremental refinements,
> though.  A reroll that catches all nits would certainly make the
> resulting topic's history nicer for future developers to work with,
> but its also a pain to re-read essentially the same patches again,
> so...

I appreciate the willingness to take the topic as-is, but I think
you've given me enough interesting comments to deserve a re-roll.
I will provide one tomorrow and hope that the range-diff is a
pleasant read ;).

Thanks,
-Stolee
