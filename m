Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6421F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfADSjD (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:39:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45724 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfADSjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:39:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so37384431wrr.12
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=qC7i83VIZBpKwhfwyS5GlCgr/GctVM14jTmxmw8lUQ0=;
        b=nCoMbDX9qu91WgcBgdJYQ99+r0RnKb+UDvD2VfseXOVb3YZ2MuerjRMGJatdz3WwJD
         bbBtLIOMf5xh1F/TbVevBiW9OhaYemWwgk0IIralsSpf8g212h4rxOIQ035ECW5TsWpY
         Rw2czqumcF2QMdjXT6y3wXVHshdzgjIMvqrW7jAgYrLyiYpomm0HionRw7GaTqtmANf+
         4s1pluu1GuH7aJZ0MemesyNH0COXAHqbROcby6WNN/TPW4SYz0CoAN20gu7ShIcKdyUd
         E2Ei21wptr2DFmR8v+N/dQW16C5O3VDhOjJtHEAKMXIH6lyM/7n3grN2n4wgLT9P0CcB
         NYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=qC7i83VIZBpKwhfwyS5GlCgr/GctVM14jTmxmw8lUQ0=;
        b=bf5AzmV3qPTeeZSi7LyhfZXkVebNL++wErvpmnDVYBAz5kkBp4n/9IR0fwRDV1vsbU
         Aoj9TDjMJfho9H6P5hU6FSQjaDp+Z8pefWJYCapLOvVIaWUUJbo1K1HodncjfqTuCwJk
         EaPhWMFGrCuv6hI5S2FAfilAp1b6x4Li4IgK/nseRrAumDDl4/NssNFbxbbYpRHSjUGp
         6UETHgGtW9kSTGHbx9Sp7phZtog6dfFNmulN6TqrXfcnTaQGWm38Xgsql3sB4LcyCkwa
         A2Swt9Ln6Q4wA+MMHh6z6YbNhbJGO6CyiJsnHU5NSC/fmgfmPns97y1mw9MJSuku30XR
         q6wg==
X-Gm-Message-State: AJcUukewdeHjHbeHpSnKBy3MAB0k/Px/pyxcMi6gP1T6LqWPULTV6jOy
        Q+81Tih6RtUZElM/kyS2Wr8=
X-Google-Smtp-Source: ALg8bN7p/DwonaYZnnwxcuMOfXNcQwwJBs+1/PQ+8hCgcgXcevzk3ERwZMvH9/mI5KUQ3ZCPYcv/bg==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr47869478wrt.141.1546627141308;
        Fri, 04 Jan 2019 10:39:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18sm37139585wrs.92.2019.01.04.10.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 10:39:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase: move `reset_head()` into a better spot
References: <pull.24.git.gitgitgadget@gmail.com>
        <175dc7d29a02d4ebf6b964f7821738f4ed2bbe0b.1545398254.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Jan 2019 10:39:00 -0800
Message-ID: <xmqqbm4wclob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Over the next commits, we want to make use of it in `run_am()` (i.e.
> running the `--am` backend directly, without detouring to Unix shell
> script code) which in turn will be called from `run_specific_rebase()`.
>
> So let's move it before that latter function.

OK.
