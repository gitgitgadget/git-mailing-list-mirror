Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20231C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 19:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAaTgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjAaTgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 14:36:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67E3B3DD
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:36:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c124so10984779pfb.8
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt9ZHqLLAzaGz1z6lypjrW3a/8hBvggzTVa5J44g/78=;
        b=jbcUW/6pvev7GORGfzYA8LDtsBLV/c30oaNU3lcOvNnGDP9J3qJTqgIjw6nNswOxri
         2ST0chw8ahHhpIeH4Hg+Cr0V5WUrlLW+5s9gEfCvvdai7n11xeRX+yem9wLKE3/8oOON
         ZOqB0Tp72BOxVKS6ZeC4g+EzTUWpyWGrzQ11MhQRzXBaE+O6q5j4nw5CB0tgQh9O7wEA
         dCE5t0UCzx6LyJjUDYwhcLU1TJqCQ/pvC5Pq8NSNLYD97BQrbuK2cEyiT+VSfjbWdyus
         k9+yygICgNlchdDBexDtu5yt2gvAEehVKJDSlVIX7OKboM2Hfdqzp7kTyORhGNa30gjn
         +v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jt9ZHqLLAzaGz1z6lypjrW3a/8hBvggzTVa5J44g/78=;
        b=t9B9oOTYk7DkEyP5I5lH/8AkTVMM1AZc+KLFP5zFbEQIDhba9ApnnAxMOSAnOEP1tb
         0ihFljUUY0LKVQIR7hzfeBPJO321dv0gnLR3Xbo/vpfG6GDF6aXgWjQAT848/HucT2hb
         iz69TgN0QGDQpN98XmQgxSACJrmV3N2lysSjfP1W5URjXW03UHTgZLqqRh2JHVkqqYaI
         70IpncpbrPe5jWKiQ3cjTS/nwnWYMxvrHgMPsWiV9qsY9ZPYspSb5Uep6q0uEHzAlRLf
         +xAzw9P2/3CutESiycBn1NWZiFieehYRBVm5zCnAQuPowqepywsbkKsCCCzo3BqP0+6J
         V5yQ==
X-Gm-Message-State: AO0yUKUTZKKg2LENkisKshVu5EJJu77BcY0R2FGAQnUJpoDM+r7loUhX
        fVJcRSuUTc8y0cUFefyu4nI=
X-Google-Smtp-Source: AK7set8NS25ql9FKAJPdFKubOCz7e+GvZ2SL6BCynVfSp6PjnS5jaPwanPvThuzQJ0aEu7UMiWE0ag==
X-Received: by 2002:a05:6a00:1d04:b0:592:7341:781f with SMTP id a4-20020a056a001d0400b005927341781fmr11124146pfx.31.1675193780983;
        Tue, 31 Jan 2023 11:36:20 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x28-20020aa7957c000000b0056bc5ad4862sm9168004pfq.28.2023.01.31.11.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:36:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v3 02/11] bundle: verify using check_connected()
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
        <20c29d37f9c1ba1367145331d25dd27f966312cd.1675171759.git.gitgitgadget@gmail.com>
        <xmqqr0vay5cz.fsf@gitster.g>
        <73c1d863-036b-81bb-50d3-2a084c2c2fb5@github.com>
Date:   Tue, 31 Jan 2023 11:36:20 -0800
In-Reply-To: <73c1d863-036b-81bb-50d3-2a084c2c2fb5@github.com> (Derrick
        Stolee's message of "Tue, 31 Jan 2023 14:31:08 -0500")
Message-ID: <xmqqilgmxzrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> ... but I expect the old algorithm to be
> slower than the new case, because check_connected() can terminate
> with success (due to seeing all the prerequisite commits) faster
> than the old walk can terminate with failure (due to walking all
> reachable commits).

That is good to hear.  As long as we are not making it worse than
before, I am happy as a clam ;-)

Thanks.
