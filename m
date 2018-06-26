Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB931F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932486AbeFZTbp (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:31:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33862 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbeFZTbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:31:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so18386676wro.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hm2JWtW0XVlG28QnpcWnewpV3Q+CZOvmkXcuc7iSVfc=;
        b=gGfWu2gaYvezcaOdgbxPqspPk3C0zzQvSD/e3YqTSBzyKbvsr9D4wLvd9rGoHCCyl2
         xoXY1hf+VCgM2YHV//h6ILIA3weF4gbXZ9a5X9ikrpefBOcxBb4+JiMOKhj4e5nYunzp
         bT2PAqBIz1F7LT1iff9vMlE4ACQe17iMSW5HMHRIdZAwqHh/ViApbINL6HG1hk93uDlS
         fNzugWcFBwp8D4EqYpoIST+eJqK7vgxULmbvLKGuwXQ4aSIRmvFZBZ4X438fbl2j0cMh
         hBTYw99PtGBsvZ3I20JQwbbBioUu2RM6C/fKt69tQ0mxlWPHQyaXCGTj5q7XwicC3Wqm
         sQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hm2JWtW0XVlG28QnpcWnewpV3Q+CZOvmkXcuc7iSVfc=;
        b=Rqh+jqHjQTmjyCdFdnzWZEkBBhD66UJ9M5cPmIfjcWy8BNR9AU80IAVyep61piSxiJ
         RmM9EeAILNGnh2tlKbT4iHhSD8ZKHTvWRpSvXX2JwOv4dw67GE6QhxJeWh3ZacR9pwK4
         Q//VfUFyok+1Dlrhy8x3WV0l351kBJcbfMd6NR4BN69Rfq/oAUzc5OiHbiVEYZ2xLquT
         K8eOYTyM2uxDnbx0LzTkklAKZ7XGyEsnLgrmYswmoteLElY7SeesVxtR2maInINAsdvb
         hk1ygmCWeJKMCKNL65o1kDK9ofqB5cYOVg/DnresJLgbShPW5m4qbkYkA7F3dQGx1BwZ
         e2WQ==
X-Gm-Message-State: APt69E3K8Jlctrqc047fv4Kqo5/BSeKJtKHsGuomqURFS5uHyNMA18zH
        iAoXck3vyfCrWEZzSsJ5bUibqVt7
X-Google-Smtp-Source: AAOMgpc4mforQrfSLQzPGRO+cKUsPbS5WeiLwbE9HLrDtszfAGqfTgEfdhY7/ZCdwb1V1GC74IbAPA==
X-Received: by 2002:adf:d149:: with SMTP id b9-v6mr2551161wri.17.1530041502601;
        Tue, 26 Jun 2018 12:31:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p4-v6sm2217357wrj.71.2018.06.26.12.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:31:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 14/29] t: drop subshell with missing &&-chain in favor of simpler construct
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <20180626073001.6555-15-sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 12:31:41 -0700
In-Reply-To: <20180626073001.6555-15-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Tue, 26 Jun 2018 03:29:46 -0400")
Message-ID: <xmqqsh59jqea.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> These tests employ a noisy subshell (with missing &&-chain) to feed
> input into Git commands:
>
>     (echo a; echo b; echo c) | git some-command ...
>
> Drop the subshell in favor of a simple 'printf':
>
>     printf "%s\n" a b c | git some-command ...

That's called test_write_lines, I think.
