Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9211F453
	for <e@80x24.org>; Wed, 31 Oct 2018 02:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeJaLqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 07:46:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeJaLqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 07:46:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so14761750wrw.8
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f91VZ/pUvCOmaBtoDkA+Ot0g0DQkIlAlshVGW9quAVs=;
        b=Y9f+eIct+Aj0AOPcCeNX54pZvN+nF9+2hPk8SeLTsc7cDSFpr2dnsL5xeIJkgxJJc8
         1fr5pW6jjbY8coKzSFe9uzd6a/W9JhasuxreM91rk6XS/YDSPeVlODpuphhswVHnMYZF
         dFPtKu/4Bqj9iIZZL79fUEgBMncyHnHvvKItFG+4daT4udwSBrF/g23wKId1qeiOujZV
         fcD2t7j92pAWfZzoGKJfycJPc4aVesxxu1/Nc/8ZvFDGwKqVK+bRqW/UIAE/ZJlLpsST
         JcCAT5YlM9e/7oX3OBWKK8dS3pDRmmzDb4moAqpwDESMNvFrw9KKQfVToZ8s5wEgekCJ
         D+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f91VZ/pUvCOmaBtoDkA+Ot0g0DQkIlAlshVGW9quAVs=;
        b=nSt/6d5VASj9ZiJl7+lAvwTkqDmyp5NaLclvw2vVX9Vt58vQQM/cnviKI3YTkggwDh
         +P4dsp0eTkqHiqk4KkBszbGW+P51BjIpKeSc7GUCGl18LLXAw6YTzhx1aSBYdfLJIhvz
         tk4uNv4VTNJ2rDfmXo3n9OlLztn/fsgrOk7QJBTfgyZ7CeOHXEKSogPp+DnVM1KA4KRs
         cADf27EXSaUEZu0sMCVf7VDINqfbhnYOtmx3/RKamNdKMaSs4l4PIRzhMLeDCH1zIVys
         5L6CBU5crXk2ENG+UO8jUWB9khP6hSWe4W88kWsAl3zcybDYrcL0mY5PdPl70Gm1Y/Ee
         W3LQ==
X-Gm-Message-State: AGRZ1gKXIwmYxfTAwnBMJfeBrNZQeDAwL59/VoVQaTGONciKGHZd+wOw
        ZH3Uxn+X5afLr1RLMCx/1rA=
X-Google-Smtp-Source: AJdET5e5LdHPrpN9LulM5UFnaUFn+A9z3UhMB0oP5sOeCCnQtIzNWikWhTv5gPg/Ull4bLJH9SRmrg==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr896593wrp.311.1540954242170;
        Tue, 30 Oct 2018 19:50:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z15-v6sm5542080wrp.8.2018.10.30.19.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 19:50:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/5] am/rebase: share read_author_script()
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181030103916.6241-1-phillip.wood@talktalk.net>
Date:   Wed, 31 Oct 2018 11:50:40 +0900
In-Reply-To: <20181030103916.6241-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Tue, 30 Oct 2018 10:39:11 +0000")
Message-ID: <xmqqbm7azv5r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks to Junio for the feedback on v2. I've updated patch 4 based on
> those comments, the rest are unchanged.

Hmph, all these five patches seem to be identical to what I have in
'pu'.  Did you send the right version?

> v1 cover letter:
>
> This is a follow up to pw/rebase-i-author-script-fix, it reduces code
> duplication and improves rebase's parsing of the author script. After
> this I'll do another series to share the code to write the author
> script.
>
> Phillip Wood (5):
>   am: don't die in read_author_script()
>   am: improve author-script error reporting
>   am: rename read_author_script()
>   add read_author_script() to libgit
>   sequencer: use read_author_script()
>
>  builtin/am.c |  60 ++--------------
>  sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
>  sequencer.h  |   3 +
>  3 files changed, 128 insertions(+), 127 deletions(-)
