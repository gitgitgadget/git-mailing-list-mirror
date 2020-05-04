Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABECC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1010020757
	for <git@archiver.kernel.org>; Mon,  4 May 2020 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8fnC2se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEDOeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEDOeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 10:34:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A280C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 07:34:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so16812192qkf.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ud7yv6IA24SO/yLRLe3hHFWwmucXL1c+JCCJ6azXtJo=;
        b=G8fnC2seDB+b2MRjLYPIdmq3LvvbT1FLPgvIYoZ7gyhr0i0Yw7IS7FV9E2vH0taux3
         Kpk48R47IUF/11dSXYM3iMWXXgYfCeL8Mbu6PTcmc0YmS86koITfQ4Hnhi0qPAWckOW2
         ZxSI/xmF6soxGoKZwRkvPKV+UTTB0XYrZL0HYB3fzftRI98AMVPL6FBIR8mBtHMFkiGI
         ZJY3mqh6a9QFn8z3IXdsPQ5Gz8qNZNVfI82N0qvysbYn1go+RpXsYUiAc/Brp6sT1Q1G
         tFPOurFkrzMlDWN/jNW3Gj8ui8E1Nz8+XzCnxxAypz4uYkYRASvlwIkaAUAuVy9Q7/Cb
         +vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ud7yv6IA24SO/yLRLe3hHFWwmucXL1c+JCCJ6azXtJo=;
        b=N6k0PQWLTiimNtQi9I7lE11u3qQUwNL5RHlWOCu+dtDEByH9zqgawsM+IvkTKXmDfX
         WLQGtwWNEAxgO7B8kI76w7TjUrkEEWu47EVlU88XtQlOBBX0rH/n6QRQDje0/BI0L0oh
         L1TeSVPMcN8OHNWT2x2U35Fb7FI/2VnolsrExLwzFcZtuwyvMOkbA1FOpsTo3VCi/bB6
         5jdt0UbeOAGh1YCMduV10uU3oTzKZjk4WABpKU8X0h9PEtH12pByE8Oe+qRUJKlMUnTO
         R5PTVULINaPq47pCfjItzwzy12ab/3BzKJYRItlVwK27p5knQCnUzFTXLAIYRitpFTDt
         ffqA==
X-Gm-Message-State: AGi0PuZ1fPQlf/h4sBQM1zv4EtgIkoheRxoji8Hqali8nOjqIqOuSMRQ
        t/64RqdCFjT5rC+0L5wuffU=
X-Google-Smtp-Source: APiQypLp1aVYKgBM863j581jUHxTZly4btibwojcDETAN6WxhhHiLaJK6UQDihdSjmFHjABm1N9IPg==
X-Received: by 2002:a37:9bcb:: with SMTP id d194mr3057433qke.16.1588602860419;
        Mon, 04 May 2020 07:34:20 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p10sm10746757qtu.14.2020.05.04.07.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 07:34:19 -0700 (PDT)
Subject: Re: [PATCH 05/15] run-job: implement pack-files job
To:     Son Luong Ngoc <sluongng@gmail.com>, gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, jrnieder@google.com,
        peff@peff.net
References: <CAL3xRKfcKh=XxGso4DTRfJMAVMtwqyQkO0VUhqVuZUr_aQ5f+A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db35867f-bb33-1155-170f-30a895948733@gmail.com>
Date:   Mon, 4 May 2020 10:34:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CAL3xRKfcKh=XxGso4DTRfJMAVMtwqyQkO0VUhqVuZUr_aQ5f+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2020 3:56 AM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
> Sorry for another late reply on this RFC.
> This time is a question on the multi-pack-index repack process.
> 
> Why expire *before* repack and not after?
> 
> I thought `core.multiPackIndex=true` would prevent old pack files from
> being used thus expiring immediately after repack is safe? (on that
> note, are users
> required to set this config prior to running the job?)
> 
> If expiring immediately after repack()+verify() is not safe, then should
> we have a minimum allowed interval set? (although I would preferred to
> make expire() safe)

Suppose we run "repack" and then "expire".

Suppose that there is a concurrent Git process that has a read handle
on the multi-pack-index from before the repack. This multi-pack-index
has a pack-file that was repacked by the "repack" command, and hence
was expired and deleted by the "expire" command (because all of its
objects are in the _new_ pack). However, when the Git process with the
old multi-pack-index reads an object pointing to that pack-file, it
finds that the pack does not exist when it tries to load it.

Git is usually pretty resilient to these kinds of things, but it seemed
prudent to be extra careful here. By spacing out these jobs across a
time where we don't expect concurrent Git processes to hold a read handle
on that old multi-pack-index (say, 24 hours) then this method is safe.

In fact, Scalar ensures that no concurrent Git process is running at the
start of the job [1], which means that no Git processes are _still_ running
since the last job (but this does not stop concurrent processes from starting
after that point and before the 'expire' command).

[1] https://github.com/microsoft/scalar/blob/489764b815dfea32bec5cd4228f2157766012784/Scalar.Common/Maintenance/PackfileMaintenanceStep.cs#L106-L111

>> +
>> + if (multi_pack_index_verify()) {
>> + warning(_("multi-pack-index verify failed after expire"));
>> + return rewrite_multi_pack_index();
>> + }
>> +
>> + if (multi_pack_index_repack()) {
>> + error(_("multi-pack-index repack failed"));
>> + return 1;
>> + }
> 
> Again, I just think the decision to include verify() inside repack()
> made this part a bit inconsistent.

You're right. It is a bit inconsistent. That should be fixed in the
next version.

Thanks,
-Stolee
