Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FCC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 18:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjEIS1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEIS1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 14:27:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15DB4
        for <git@vger.kernel.org>; Tue,  9 May 2023 11:27:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1aae2223aaeso35032745ad.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683656857; x=1686248857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKIz4JMR0mKH3bJ9qZdb/O9aWWZJAoOT9JAEH94gmQc=;
        b=avOTcK7i6HCm1izWd9Nm5P1jDarWGF/lhNduXzG/kOUjHOS6jzaMfRlSzVoekVxEYS
         E87LkQt/PzClh4Lc/0TKkgXsBWh9TFGNk0rewoU7H/WArzecZ4rZ3KY48APdHDi4Ys+d
         Jdxvp5JPCS8H02PuxoLhc80z1RLF+WceZZZhIwHj07jlnrkBBcgYRhnrQ89n/Rhr+B72
         Nj9YvfKCvpYeEip9Qhu1RwsEAoPniurqG9uxx+qo3Wxc8ShoXt7a4qxT4vu2jA87kMgq
         QAT/ah7BzJpX20vq5auOUAlOwgWFcotpK36cN0ERQj0A4KhDypZPtdhjxFvXTMmnt7GE
         q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656857; x=1686248857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKIz4JMR0mKH3bJ9qZdb/O9aWWZJAoOT9JAEH94gmQc=;
        b=RXoLXjTZ89FPpXYu83dMij7Yst7AGVBCxMXigICJtRNoL82WIKqXK27tF7sxpkF735
         k0F55wYQSez/xsZaiq8k4bEgqOmjXUohOdoqREGos3xNZ3UYSSkIWF1mIKLZCPKpfx5D
         bpNh/jNpJRKKHNckFI4/2Pp6TeNpTx6MIfMgTiBKfRoxyyZql+eDxB4+XRxVm1U0ajq2
         mHj1boRqpPcwJETn4VvnXLqzX/Nc18vIIayY6MxkwBmI16MJHpcuXfczKqHJbP9idh+k
         O5YI8Wlc7cxkPVYwbJvDL0DfNE1NUiCtGfLZyVdF3zNbQ8G4lq0EqflEccRS0toraCkt
         VvvQ==
X-Gm-Message-State: AC+VfDwjTSUAH26hJxUCDNw/R/MhxhkA9Gx/BHGU57v9tYFS9zmCnj4m
        UI/hBFgGsl/BqTEXDstA/oaZwSmmt6KoWg==
X-Google-Smtp-Source: ACHHUZ5gdTfZjFVBesBYOrDvB2HZyAYsk/zpGo393Ew2d9MFyo0YG3AuA0Cn6om0yiJLDAA52lEtwnUsMN1P5w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:3281:b0:1a5:32f3:ca95 with SMTP
 id jh1-20020a170903328100b001a532f3ca95mr5168813plb.8.1683656857017; Tue, 09
 May 2023 11:27:37 -0700 (PDT)
Date:   Tue, 09 May 2023 11:27:35 -0700
In-Reply-To: <xmqq1qjpz96s.fsf@gitster.g>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
 <d82b42ed345ac7b482bf5dd96456f131ecb8c746.1683636885.git.ps@pks.im> <xmqq1qjpz96s.fsf@gitster.g>
Message-ID: <kl6l5y911ht4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 1/8] fetch: fix `--no-recurse-submodules` with
 multi-remote fetches
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +		git config fetch.parallel 0 &&
>
> Is this necessary for the purpose of the test, though?  It should
> not hurt, but we do not require the end-users to set it in real life
> for the parallel fetching to work, either, right?

IIUC it would make the test output deterministic if we fetched from both
remotes. That doesn't happen here though, so I guess it's not doing
anything right now.

>> +		git fetch --all --no-recurse-submodules 2>../actual
>> +	) &&
>> +
>> +	cat >expect <<-EOF &&
>> +	From ../src
>> +	 * [new branch]      master     -> secondary/master
>> +	EOF
>> +	test_cmp expect actual
>> +'
>
> In the context of a series that attempts to introduce a new stable
> output format for machine consumption, which implies the traditional
> output can change to match human users' preference, this test feels
> a bit brittle, but let's wait until the end of the series to judge
> that.

I also find it a bit brittle to assert on the whole output when this
test is about checking that we do not fetch the superproject.

Is there a reason you didn't go with the "grep for submodule lines"
approach in the previous tests? If it's about catching regressions, IMO
your PATCH 2/8 does a good enough job of doing that.

Wondering out loud, I wonder if it makes sense for us to make a bigger
distinction between "tests whose purpose is to guard against unexpected
changes in output" (i.e. snapshot tests) vs "tests that happen to use
output as a way to assert behavior" (i.e. 'regular' behavioral tests).
Many GUI app codebases have such a distinction and have different best
practices around them.
