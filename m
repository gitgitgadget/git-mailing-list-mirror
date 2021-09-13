Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A58C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0326261151
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbhIMQBR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Sep 2021 12:01:17 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43871 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245748AbhIMQBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 12:01:16 -0400
Received: by mail-ed1-f49.google.com with SMTP id n10so15097748eda.10
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4+bJJkUXWzXXfX8GKrWDMSaadCwQAoxVLV0Nh3I5xw8=;
        b=wyxfHdbJCWTZHsa1Wg5QaH4FZV1Qi0xfWpP3xnOV1ZL2nDim8PuQkskTyQRK7U3KUO
         4yRcj07UQnoA4mIcsU0h0d8HMXnM4o2pkE/2ed9Tt/kA1h3Cq3t7KYikEAhnuomdZyST
         vdZxBfHH5ZW+66gSawHbjJ9i1Sv4sijqeVhitSHS8qIhjemj4K8SIv+jL5jINT+dyt/p
         bp8UhYwuSWYWrfaLiuBtJJTzn3OKntwCZdsrsbrE9f285WSb+IdlfB/dLOEYswZIgVbN
         2+gKMiG6/wnBtiMg2oR9fMUQkVgRM2S6T5G3pQaq+ZnzJHAJ+MbNXV5RrwLUzkB36LP0
         hc1Q==
X-Gm-Message-State: AOAM533Htcpakz3aQaERwgr9hEJ8h7KOsM5RoE57qnHJoyDlY03X8F4I
        WyWtMH1NH9MVrMGf8aanel+75zQaZftQGGTFuV4=
X-Google-Smtp-Source: ABdhPJwR4Z46i3iznCKOaemuNvKrh1+aWZcu4RXP5RzlFX9gTHX9I+IFz7B1ELpsp+hByyA/5HSxuQeSjP2IDnT0MxA=
X-Received: by 2002:aa7:cc97:: with SMTP id p23mr3043172edt.231.1631548799591;
 Mon, 13 Sep 2021 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com> <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com>
In-Reply-To: <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 11:59:48 -0400
Message-ID: <CAPig+cS=fhE1Dm1ESps8SME9XO2+RPJ7LGtquuZQ5XPFB1uk3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] help: make sure local html page exists before calling
 external processes
To:     =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 7:07 AM Matthias Aßhauer via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We already check that git.html exists, regardless of the page the user wants
> to open. Additionally checking wether the requested page exists gives us a

s/wether/whether/

> smoother user experience when it doesn't.

> When calling a git command and there is an error, most users reasonably expect
> git to produce an error message on the standard error stream, but in this case
> we pass the filepath to git web--browse wich passes it on to a browser (or a

s/wich/which/

> helper programm like xdg-open or start that should in turn open a browser)

s/programm/program/

> without any error and many GUI based browsers or helpers won't output such a
> message onto the standard error stream.
>
> Especialy the helper programs tend to show the corresponding error message in

s/Especialy/Especially/

> a message box and wait for user input before exiting. This leaves users in
> interactive console sessions without an error message in their console,
> without a console prompt and without the help page they expected.
>
> The performance cost of the additional stat should be negliggible compared to

s/negliggible/negligible/

> the two or more pocesses that we spawn after the checks.

s/pocesses/processes/

> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
