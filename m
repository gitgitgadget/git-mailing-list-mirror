Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A8C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiBCVsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiBCVsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:48:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB8C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:48:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h12so3641284pjq.3
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vt1wEHivH4hRVdHLLKsYnAdAn1Gi7Os4/qYD7ojJ+Lk=;
        b=M3wfG223xYrwLkaZamgWRqxoGUpyIrZSxM4bVF8/GBKkr0LpVO1EkAcBLstmzjMXFK
         lJDI6I5zWhFOOxYNnRXV7LpDqTDyW7TAENefAOXTs+temMMudxouc/QNhwQkHwkl83bH
         yHixjPg3jwm0awOfh5te7cxbz9rrwuUChL/20LGgH0GLad/HzL4lm640Gb2v5G2/POv3
         G+y7GxmAMZq5iEThgG0LGWuF4OQAzRhp9Ln0oyV8kaAAFR/kUHxoTrUNaCvgUyNUamt2
         blfJ/W2jz/DfNfQzxCMc/2qryMGUges1ikT0AogiGmQ4txx78PPx2hB+sgSNus3zIRTG
         KiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vt1wEHivH4hRVdHLLKsYnAdAn1Gi7Os4/qYD7ojJ+Lk=;
        b=lgpuTd0wag5bq6jJcZWQJGLOeKKNhiwi1xHCvkY+tZChR3yEFXqFvcLNZnlZ4MlD6A
         OAtyTvl7sx5DMNGctSBrq6rSA/yOZdKMKuBJmJw/jRzTWvWp2xynTtwQU1kji20bv7I6
         NNmpDPlBwrIVtw/CCGCtlIDcL/g8FQsO0/EnLPq5LmJFWIU0DGOYobDc5KLzsq5icoFI
         sSZ7ZHjxPbU9JT7vkC01OyYkBdc9ptrZCuBfHa2OWoSyPV7pggxHlCmyiIc8HfMdVNM9
         3+nlSn+2k63hhXQWZDpG287xaPVNm54K7V3aC614HajUg4MRmoyKEPRZco8rbAj/pFfW
         Z+Lg==
X-Gm-Message-State: AOAM533kJ/MrJOlheUHqWHu/Lui4H28D4QWUmhjRrZlISprPKBPymJ77
        J2owFQXvQPqv2IPjBAElxOg=
X-Google-Smtp-Source: ABdhPJzFkb3V7ZTiiU9CRhzrABsoj7YoAaSEET3K1o9Ocp+rKDfM5bcd4pvQXSQ8jVK5fL3dyaOytA==
X-Received: by 2002:a17:90a:c084:: with SMTP id o4mr8002649pjs.28.1643924890641;
        Thu, 03 Feb 2022 13:48:10 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id a125sm21819161pfa.205.2022.02.03.13.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:48:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 13:48:09 -0800
In-Reply-To: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com> (Lessley
        Dennington via GitGitGadget's message of "Thu, 03 Feb 2022 20:44:48
        +0000")
Message-ID: <xmqqo83nr59i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This series is based on en/sparse-checkout-set.

This has been a very helpful note, but after the topic was merged to
'master' on Jan 3rd, it has become a tad stale.  Let me apply the
topic directly on v2.35.0 instead.

Thanks.
