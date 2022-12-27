Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D1C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiL0XQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0XQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:16:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB7E5F
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:16:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n4so14533023plp.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gsmBn9ArkL26+HaMwAsMEu+UGuUqcP29G5xBQHx+gU=;
        b=KdDxxtKcJdG+Q/aqZYebnVFyNHDshWJiZxkHt/iX7xEyiOSy0oL7iDUjtuKVBiiENN
         JVTzJ5eXFzNitkbYtgaPtMMd0+/GBqsXygjkoOcvy5ytKNZOP8/7sUMJTpFsmBv7imQt
         ZF8rT22rvE3GOTun3SJUsPx1gjBub+R6LRVgtR4If9uWxB1O49aMXH1i670nlXQ7h/Wt
         q4DtikAHmKlwvXiKMeKTvHA0nSXDsd6WcVjz0cpokRCYXv3UWecVBjO/vxrwvjN/N1CS
         bDnMC7s/lsqpuVD8Psb4Afk5tYT/8QR5KLvC2sy9/MkTPI3AxwhYrv2QHma+3jUZ4kGP
         5+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0gsmBn9ArkL26+HaMwAsMEu+UGuUqcP29G5xBQHx+gU=;
        b=f2cBLicnOx38ilSoZAv3j/1RSU3WyLqGWFf3N9tUZFv5KMYdldStjbQYcqh61t7d1T
         50AZ0GiLfd/gLbM+zxHZhi+Ag9+Pi49sHEfj5tSlEBUCxvujEPg2TI+nyv5oekosr8cH
         mQU2wP+gw+/BRgYcJXlkeZDsb08PcZGkp1I83KvY6w/FSz3zJ1Id3Svn77YoEtapSuPm
         aCIJx6CuT6Q6gNd33wLWim6hbsU/Ek/C8dds1uOc1V4RKN157TbFTiPmgjpkCChyyAUM
         m33K+LEGIhOaW9hnZ5N5/dy81I+cPYbp60Ri9f96DW+k/VS80KzPqqfUabc+Awgt4lkb
         EVxg==
X-Gm-Message-State: AFqh2kqLhJS6ZZVHbRwZtQPhOybydf0EN6y8aTZracb0s420EpBSJdb6
        p9yRpEsnRqK+dvZhy5i26wA=
X-Google-Smtp-Source: AMrXdXv56k0s+mTXdk/qr+swxO35U4g1GVp8ZtnAoZF2Fgjn5OTnpc9HZEapXfaMX7b8OrEsBUmwIg==
X-Received: by 2002:a05:6a20:47c8:b0:9d:efbe:204b with SMTP id ey8-20020a056a2047c800b0009defbe204bmr29912998pzb.1.1672182979094;
        Tue, 27 Dec 2022 15:16:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u16-20020a63f650000000b0045ff216a0casm8427162pgj.3.2022.12.27.15.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:16:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 5/6] tests: don't lose "git" exit codes in "! ( git
 ... | grep )"
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
        <0825da46-b659-d18c-6e65-ced6ce85bd29@dunelm.org.uk>
Date:   Wed, 28 Dec 2022 08:16:18 +0900
In-Reply-To: <0825da46-b659-d18c-6e65-ced6ce85bd29@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 27 Dec 2022 16:44:23 +0000")
Message-ID: <xmqqsfh0qvy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> It seems strange to use sed here, you could just keep using grep and
> check the output is empty if you don't want to use
> test_expect_code.

I am not sure what you mean by test_expect_code, but we can do the
"! grep -e pattern file" to ensure that the unwanted pattern does
not exist.  Unlike our command, we do not worry about system "grep"
being buggy, so if it yields non-zero, it is because no line in the
file matches the pattern.  After all, that is what the original code
fixed by this patch wanted to check.

The "do not lose exit code of the git command" part of the goal is
achieved by breaking the pipeline already, and we can keep the test
that uses grep.

Having said that, switching to "sed" is not too bad.  If we wanted
to expect N lines that matches the pattern in the file, with grep,
we need to do "! grep" dance when (and only when) N is zero.  With
sed, we do not have to worry about it.

> There is also no need to redirect the input of the
> sed commands.

That's true.
