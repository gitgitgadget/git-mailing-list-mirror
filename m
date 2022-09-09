Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715DECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 17:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIIRlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIIRlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 13:41:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638B697537
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 10:41:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so2298549pfb.12
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Esn3uQtZWaiIj44lF1tPtureBqnfV9v4YB0CEL27Aws=;
        b=IeIvuZycQT8ux4jw+4UJ7xVKYK+bg9bdh+sCvTslAVXUQ7FGJCdhDd3Tl6YTOf/Gng
         v9U6AADkxEmdpP2OuQAHCUY8J4L1FZp12dtt2AkcQ0Lgc6bTp+WpyHG1Hw/76eZ7ncmm
         UKh+/HudplSNBbwCnmd1+m6SMdnb0LGUAMgd1vXqeC07aUsIl36W74O7HRs39c59ybmw
         p9h8RJ7orw5aSPMlwVHInkNx6D6eB+bPAmbgGc8ab5y8sQm6yhwilhsH6ZxVpNLdIj+q
         /RJoQ7PUPojJMiVRMsi9A4LrPqTekGSNxcAryZ9WbnEAWbHLSHuFYvNUetf8EKvpEL0i
         EgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Esn3uQtZWaiIj44lF1tPtureBqnfV9v4YB0CEL27Aws=;
        b=6Aiwf/IjMBuZknlbItju1xs/IZ3mdXwsbw+h5VN2JbTb5K4D+BKB1COYwZVZyfa/8/
         QwKuFIQstX0M0S27KtG0krXixIqL+Zh3SnL8cYMVB4laHMxA/RTtPrtBYboMm+bSFj3J
         +RWL2jGkrXQKlBLvS/z6ItudaFeby0PgKxYgQAZPco72z5KRcqToHLPzHsnAZ2NxT8Mk
         ROB9W74Mx0eLAg8uKFtei6lMtRgqkg1obKcDwFEc63rPJR9ZHmf49BnIekGWxASGEYmb
         ed6ZPF3lwgqEshl76wJeon0Eku9AQqsv+N4VZnUq5VlGRCSKOZta7HuS0qMdllZXZFVn
         W80A==
X-Gm-Message-State: ACgBeo2x/AeWfvboBGLC7UpHT4YQXRozTB9KGz3THmglWZMdSLvUeerY
        uuBEv4kzGWMw/MbXtN+nuHQ=
X-Google-Smtp-Source: AA6agR4lfg8fUrG/WU77dULnC1rXgKnRgnkUNiJE/bEoEXxCTVNcgMkI3utPhYzTlmBdP9Nk0AMbPA==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c67 with SMTP id d22-20020a056a00199600b0052eb0f78c67mr15344839pfl.20.1662745296823;
        Fri, 09 Sep 2022 10:41:36 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p129-20020a625b87000000b0053e0d6f353esm17103pfb.27.2022.09.09.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:41:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo <chooglen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
        <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
        <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
        <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com>
        <xmqqbkromsfx.fsf@gitster.g>
        <d0d0836c-9d2f-53fe-dda1-a8c61e3acd9f@github.com>
Date:   Fri, 09 Sep 2022 10:41:36 -0700
In-Reply-To: <d0d0836c-9d2f-53fe-dda1-a8c61e3acd9f@github.com> (Derrick
        Stolee's message of "Fri, 9 Sep 2022 12:40:37 -0400")
Message-ID: <xmqqh71gla27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The object names should be visible as part of the "git log" output
> (perhaps abbreviated) and that provides a way to get that information
> without needing an unabbreviated hash showing up in a decoration slot.

OK.
