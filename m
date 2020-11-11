Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5A2C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820D62072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX+PZLtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKKRKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKRKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:10:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DFC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:10:06 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so2338501qke.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/sZZInUgKzAl0AJhjHxVyb+TzylnWxsdUVMzjLfdrOU=;
        b=aX+PZLtTfO/OvwfhFvMHT79Wct35goBYYKO4Hl0AtHbj7YtdPGiIMoU4Tmp1qdJkx2
         /ToQzCmKtZGwYSoLQ5ZkTA4L9/ba2vbIzGNw3uljjD3zN7UB2/MsLPlHavZN4+0wDzny
         B2LtLxzbmkuLcuq1Q+tUo7X7xu7x0E7yYrj3QlzElBSb2rdYudaiDc0EJ29FmOAUnlEN
         12JAGTWkwNB04l5qWe3feL6phvdrmxcltk54uQhYk6dl3BvYPVaSz3d/+TqQwrKn6+27
         Fjx7ov2kulCwUukAU5N5GX7nKTRTXVT+g4uh4tbtciecq7iatSdMREdJS9k5isoL2wUt
         10zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/sZZInUgKzAl0AJhjHxVyb+TzylnWxsdUVMzjLfdrOU=;
        b=JbWOI16aeWl148zWOCqIqYfSgwzziBXOQIxM3c77DETjtsHnkno1LUIXurg/V38uOV
         3yt1vYfC4FtFoWP/uoNPVgudUmR2T+GQo1NSZtZNsw1XCGpCyz2AQdiaca7w6gQ2uxZH
         t7AOqN3vH65NcuV7ugT/CEgdULfm5ctoR6Izd/cGpf0pIEcXqsiudaUT8FykuDMLqVK1
         W1+kOQtM5/n5rHibGodDMycX5b8c2PNohV4/SJ6p1GmnL8S7Sez5hBBp1ECnNZh4hyfb
         XZ+uvh3IMS/DqVTjf6UyBKANO+W2qLj63lFOzKWLfDLmxWTwEdHIt/nIws/polMU55eJ
         v+xg==
X-Gm-Message-State: AOAM5324TRESbFo0+TyRWmi2tJofRPkMmMXOlGcBJ/fCoZX3XZhb4utw
        gPa+U6TZPDtbXo79H2LlxbCQBgViaLWwoQ==
X-Google-Smtp-Source: ABdhPJwlZ53nL69AbvNo5aTNzuSPZKZSqeSC+OCRaJP+BXHxyHvYpyB2yuousvmq40Tk9pO/2syF5g==
X-Received: by 2002:a37:4e0a:: with SMTP id c10mr25663973qkb.492.1605114605642;
        Wed, 11 Nov 2020 09:10:05 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id g66sm2623677qkb.91.2020.11.11.09.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:10:05 -0800 (PST)
Subject: Re: [PATCH v2 05/20] merge-ort: add an err() function similar to one
 from merge-recursive
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-6-newren@gmail.com>
 <267dbe58-e319-0904-3552-bf56530181c3@gmail.com>
 <CABPp-BER+nzGb42fB2__tF=a8Y-JQ-Fzi8PZ9T6nWG-5RZfzhA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <acb6291f-a9a4-6c74-61ab-77aa6e7bfc77@gmail.com>
Date:   Wed, 11 Nov 2020 12:10:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BER+nzGb42fB2__tF=a8Y-JQ-Fzi8PZ9T6nWG-5RZfzhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 12:07 PM, Elijah Newren wrote:
> On Wed, Nov 11, 2020 at 5:58 AM Derrick Stolee <stolee@gmail.com> wrote:
>> This seems simple enough to have a duplicate copy lying
>> around. Do you anticipate that all common code will live
>> in the same file eventually? Or will these two static err()
>> method always be duplicated?
> 
> I anticipate that merge-recursive.[ch] will be deleted.
> 
> merge-ort was what I wanted to modify merge-recursive.[ch] to be, but
> Junio suggested doing it as a different merge backend since it had
> invasive changes, so that we could have an easy way to try it out and
> fallback to the known good algorithm until we had sufficient comfort
> with the new algorithm to switch over to it.

OK, I missed that context. Your approach is fine as long as these
are not going to both exist forever.

Thanks,
-Stolee
