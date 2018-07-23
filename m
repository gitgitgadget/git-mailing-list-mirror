Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14A01F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbeGWWe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:34:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54280 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbeGWWe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:34:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so494375wmb.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xQzT+cZsL8+XZzH0xgqNckJY6TEWPs4TmJpckVUInpM=;
        b=WjdZavs1tuLmr+GldvTBnllIWxIFz6Ki00TMBhEJCcyj+kqYeUBAox8mf3C8qlnOmP
         Zyv6gE2Zyk140Dwt+r1qieih19nK8QoocrN71heKBKoIFze9tu+ncdxU28JGDSn5lFei
         yYhPvQM8KtAbt+dpLWBxgXp/3qVqpSxLhvH/dOiqFLm7l+VADhpDYUSHK2QrL77oQhxI
         t5EH9hwb7esADC9ZBqOzKMkG3883n0sRsA9HuxkRWag1Z/r8FJ83CHWDrGTHH5GorPGW
         q3TxFAHKPKYsSIbPkTLeO5+R9opj3yGXj5j6sWwJ9UwQjvEkVP1HHIM215jC0w45l88b
         i/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xQzT+cZsL8+XZzH0xgqNckJY6TEWPs4TmJpckVUInpM=;
        b=Sr8PnsC7zPIpblBINmDvav+M9AehkJXGVi8FYbSnSxUwQqASO9SsihTFe762z03OS3
         4JM+QcurFw3IhilfYj8HbAc/aAPWFqNy0t0Yynxdw4reut5s5VLekPI3TbxkCoQobGt+
         bGhFUaDBhf1UGe5cIttyAS5CihLTQ/6fy55Rjhe+5myqx+pWRpV4fUUkbFO5yagJ4dD9
         Q1hH46Q5VNzRIPPKraRwmyvAIlnSQ2WaA9vbG79rTbs5Sgxf8nckPw1aYKLMCeYHcU4S
         hEUWN6JZLYaDGKamewjPZgVVwGr/VBKpCUmxckR3p1IVfzJNEn9QbOnIgImEmeHSayuh
         ShxA==
X-Gm-Message-State: AOUpUlEngKBCDJ10BYIbLFAyur8VpSS1AAiAPUkpsgY4l9Uj8CDfRLlw
        +yPlJN/b6Wrc1r2n6PmjgRM=
X-Google-Smtp-Source: AAOMgpeg/geWxTsrPPHQHX6f+StvH5iLRDpmoRMTPvpIVEziwG9Nn/r350JG06YxTtatFIikBOyUFA==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr347121wmb.133.1532381510507;
        Mon, 23 Jul 2018 14:31:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f20-v6sm14258402wmd.3.2018.07.23.14.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:31:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t7406: avoid failures solely due to timing issues
References: <pull.12.git.gitgitgadget@gmail.com>
        <78f7a5e4baae162d1dff18701a25903b304adf9e.1532353179.git.gitgitgadget@gmail.com>
        <xmqqmuuh69xx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kag=YC6PxOnBbVAqY92dNd5yuqfvash-oPVrEktowNbVA@mail.gmail.com>
Date:   Mon, 23 Jul 2018 14:31:49 -0700
In-Reply-To: <CAGZ79kag=YC6PxOnBbVAqY92dNd5yuqfvash-oPVrEktowNbVA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 23 Jul 2018 13:53:10 -0700")
Message-ID: <xmqqlga14p16.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This test was last touched in c66410ed32a (submodule init:
> redirect stdout to stderr, 2016-05-02), merged as f2c96ceb57a
> (Merge branch 'sb/submodule-init', 2016-05-17)
>
> The parallelizing effort was made before that
> (2335b870fa7 (submodule update: expose parallelism to the
> user, 2016-02-29) via bdebbeb3346 (Merge branch
> 'sb/submodule-parallel-update', 2016-04-06)), but did not
> review existing tests for the newly introduced raciness.

Ah, that explains what I was scratching my head about.  I somehow
thought that the parallel update broke an otherwise working test
written back in the serial days, but it seems it was the other way
around.  The test was simply careless.

Nice to have the two-year old issue fixed.  Thanks, all.
