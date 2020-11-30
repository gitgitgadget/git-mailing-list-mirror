Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CAC64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CCD2084C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiPuhlSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgK3OQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgK3OQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 09:16:19 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F022C08E9AA
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:15:16 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id f48so2871877otf.8
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rXYLOBWut/gF+vFGrQw0XaAftj854VPEMJmBPl2q5LE=;
        b=kiPuhlSGR3HtKU5vwWYNDnXSXGiWX5E3gJ4j9xHahhSF1GM4NDExe5MmJ2+RGVr5Rn
         hm72Vq8Jx3fXlBL4nPWR1C3PhdacW0J77/QuY3wpG1AzA88RFA/FLtN3Og/Zbt2qdiQ8
         sQBeu1+O9TDtFe6oxbiH4ygr90icPzy7iMhKUWx+qCrGfvEMMSRm8lmXz43oYhOrLzdY
         iZ81qvwfvEIJONBC9GJja1fEdWyQt/xsjqfkyNBywnmRnsjTROnZgPSpre2/7oVoFioi
         FvhUK1WoNwy5Uw8DxMI6u1j9UZyKpOqJ2m/L3nw0H5/KeLOPUCGkDmcLnvV1R16F6agI
         dimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXYLOBWut/gF+vFGrQw0XaAftj854VPEMJmBPl2q5LE=;
        b=rbyLcjvEi/eEGhR5QuzunCDkec/Egpsg2+ImQG2w5l3KR6609sBSc0P527nWZDaUN6
         YSCF4tZwZ/MaZ5hZNQplPYG8o0x+SKZw8kqYVp96DBsqRMRrBrAvAOtQG4JdtO4wxZSk
         O5Anw06fqQlBPwgVLj0wnOI8bNah/JWD/3/lJmw1fjGIsA07J9zeNTo66iYNxaX3M2s2
         XK0JDK+RUrXPmKc65h0r90EDgEgLmDjujv2roRJQVMMgZ8qotfapAzX10CNF3bseFQRp
         QS0Xm7O10txv9FQ4/qU0ZnocmiMRXBHE9vPGa+qf0QBMoRTD/kONlJF7aqhlAhKDU6Ui
         DR9A==
X-Gm-Message-State: AOAM531KZEOqvS0ti1KMSKkfZscOaht9HOk2wGn16NPg6iZE+e1mWbRR
        7TwDFIGklM2paJcEj59va0E=
X-Google-Smtp-Source: ABdhPJxHdPwc4HegkLNOf4yvHWDQcxcaENWAUiuYWoT1uR1skvJtdlG536zqxa8/zuQsRsX/T2zfQg==
X-Received: by 2002:a9d:7c98:: with SMTP id q24mr15997151otn.147.1606745714379;
        Mon, 30 Nov 2020 06:15:14 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l1sm8860675otj.17.2020.11.30.06.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:15:13 -0800 (PST)
Subject: Re: [PATCH] perf/fsmonitor: use test_must_be_empty helper
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
References: <pull.799.git.1606342297403.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e82aa6f3-af88-246e-6cf8-5d2320133a59@gmail.com>
Date:   Mon, 30 Nov 2020 09:15:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <pull.799.git.1606342297403.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2020 5:11 PM, Nipunn Koorapati via GitGitGadget wrote:
> From: Nipunn Koorapati <nipunn@dropbox.com>
> 
> Simplify test and make error messages more clear here.
> Per feedback from Junio in
> 33226af42b (t/perf/fsmonitor: improve error message if typoing hook
> name, 2020-10-26)

Thanks, Nipunn. This patch looks good to me.

-Stolee
