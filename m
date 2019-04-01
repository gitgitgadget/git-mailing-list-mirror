Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8CC20248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDAKrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:47:39 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33877 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:47:38 -0400
Received: by mail-wm1-f50.google.com with SMTP id r186so1273466wmf.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=1qwRBz1Kf4MCDMJD/9p9FPYgRGbDIxv6LAfVnuMxEfY=;
        b=K7iPfoWiZN+MSgUyhBecRsjLHB9AjFphVQJtkaUClqlO2QPK+wgv2sIZayMq8gKvcf
         OfLeJTeQmR7GKtFbCTptYWGkgGxkmFOA045dHRXrqFhOe+B+o5Ska5cHLrjeeZODkwSO
         m+Rg2evFXUm6yWL+Suwu+fpkfHVqd5UobSSuzcfG/DqOG75g87ENF9E7xf/bfHJ80Pp1
         ta2Vlaq7EhbWhHtfKoJspsWbAlQruS+qDtnGqDmDZViS28nPcBGcJcIlXxXCVOy+N7Rd
         70XJ3G/z+Y0xjBmG/zg3Z/ecreFwd5WPUFMOK7AxhFbTIy0bIK9rtvB461D1JzimXreo
         iEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1qwRBz1Kf4MCDMJD/9p9FPYgRGbDIxv6LAfVnuMxEfY=;
        b=nZyKeRc7rpQVL+24J4U9YjH3BGdaUJVkhVpYfTqdbN224+Syw6Clb843IEdS5oh8p4
         nS0kumNrkhbfXlM4dizc3PigKtBnw9eva/y/NrfYTnQYDMQKZyS7mr7QeQF06zF90trJ
         4Hjggl33FTMw48nXGqO+8FxwYOOvl0u+KG3WE1PaoIdRJ260WTseXGWYRoKrl30ss04I
         m0vRo5DvjLbUA9Vkp3tYRm1ukLD5dxx/2YNBpXq0lnkn7JzYaRDjTAZyGSR1KnhlUPAM
         1rd9KNtgBeEnldff0D1sRxLmOFEsKTLrLWX2hbjIignbkfic1QKyjBkfU6IcsBQEcdMM
         Taog==
X-Gm-Message-State: APjAAAVd5ONgWut6D3FvG1cMyJsjfGBRkZmv1PIB/bg1OfTnLOeS6sdi
        Cxyg7fjQwFjVe1MJqID2Lr0=
X-Google-Smtp-Source: APXvYqxzr+Lpx5ac+K55SHxwZmnrv6p/zNQZRYo7Cw93RWszZ2sef6yvjkLAuZLslAev20WRpgETQg==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr12233395wmi.144.1554115656669;
        Mon, 01 Apr 2019 03:47:36 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t81sm18966453wmb.5.2019.04.01.03.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:47:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: test suite: why does git add large_file create a pack, rather than an object?
References: <f0c838f0-2f75-2b05-1aeb-3db4743ce89a@iee.org>
Date:   Mon, 01 Apr 2019 19:47:35 +0900
Message-ID: <xmqqftr2uhmg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> At the moment I'm using an extended _test_ case that starts by adding
> a ~5.1Gb file and then using verify-pack, which aborts with an error.
>
>         dd if=/dev/zero of=file bs=1M count=5100 &&
>         git config core.compression 0 &&
>         git config core.looseCompression 0 &&
>         git add file &&
>         git verify-pack -s .git/objects/pack/*.pack &&
>         git fsck --verbose --strict --full &&
>         ...
>
> If however I simple execute the commands from the GfW bash, the added
> file is stored as a blob object, rather than a pack.
>
> I'm at a loss to understand the reason for the change in behaviour
> [store file as pack, vs store as object] between running the code as a
> test script and at the terminal. What am I missing?

To which test are you adding the above piece?  Perhaps one of those
that configures core.bigfilethreashold?
