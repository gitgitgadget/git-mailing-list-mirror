Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E211F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbeGJTKd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:10:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53497 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbeGJTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:10:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so113458wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ln1Oy5j3BrHZzNfxbeJZiMTgLNOugkEKnnjwMgxvwi8=;
        b=QPgqhTuB1r466i6fdni0lePu9w6rASW+cSZYsXiCksxAlJ1T31SfEivjKJ4AjkqXev
         4lmWKrR+P0QBKuBUnpbZzXWI+ZTTHAH1AlnfA4ljNHOvc2B0l0u35KaYHxGd8Qgva59P
         F9X3AiXlHBJs08gMubQgeNFF+CeYqwiwf4V7eJMjnSOZCXnuCoOnN06jSZo8oltuTsm3
         YovKKPzK+UK59CN+XqAVrQZZJ9vOarnlQ47PzA1LS8rGRUMxDoNqH106B49TfcdNxTjR
         RUmmqdAkxXLuhehapXkZVR/tmXNqn8mjDpcE1UEbUPDI1UYPF2BsR0XOveW6+9LOuOid
         z3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ln1Oy5j3BrHZzNfxbeJZiMTgLNOugkEKnnjwMgxvwi8=;
        b=qD7HrNtgc5by9J6PfUDJ0pFYHptaLGa0RwtHOjxDWE2NE6r6b0QgVMKBUIgfzi7tlE
         hlI88YDgCTUAJ8S7zyR8rOlh5ZNeaBSbmp2wqG+RjMklK0S2CONf9d2l7z/SP6++cVab
         AVj6ifwZVRS0Uv04rOdoZLy7dlzIdKfMjQoPEX25GqSlLp0414wtfe6NzcLYNNh2qN49
         8Xags2k/f/w8jgIE2rsQFqoQBFGHxFdI7bDipaHPfJDXJIueCV4dR873FMelsSfIAfR1
         iulQezPUdkkw1ZL8gdcihQWrk6IlOY3FSFia7Q/+OmaBQ+Tc/4LWrs9L6USe3o6z0+4c
         AIhA==
X-Gm-Message-State: APt69E3sfHsbdCpsB0w97f9Dw0ZxlfPpK0WzSBBuAkmIECAt4hgD0usV
        +VdDCjEwS5+lsmaCwWRwAwltC1LU
X-Google-Smtp-Source: AAOMgpdGv9W5na3A5vFkPN2omhUqDTjZ1f/b4LWizgItcVtQnBpDHD3PsOHbOvFimtjhyYdg/ZxvpA==
X-Received: by 2002:a1c:eb08:: with SMTP id j8-v6mr17375831wmh.160.1531243775557;
        Tue, 10 Jul 2018 10:29:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z18-v6sm15870721wrr.76.2018.07.10.10.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:29:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per gpg format program
References: <cover.1531208187.git.henning.schild@siemens.com>
        <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
        <20180710165412.GE23624@sigill.intra.peff.net>
Date:   Tue, 10 Jul 2018 10:29:34 -0700
In-Reply-To: <20180710165412.GE23624@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 10 Jul 2018 12:54:13 -0400")
Message-ID: <xmqqh8l780e9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Should we allow:
>
>   [gpg "OpenPGP"]
>   program = whatever
>
> given that we allow:
>
>   [gpg]
>   format = OpenPGP

If the latter is allowed then we should allow the former.  

But because allowing the former is cumbersome, we may be better off
not parsing the value case-insensitively like an earlier step in
this series did.
