Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBF31F453
	for <e@80x24.org>; Thu,  1 Nov 2018 03:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeKAMC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 08:02:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37893 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAMC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 08:02:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so147589wmh.3
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 20:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2eKdBgB3x3/6IciBHhqjS+e/Z7nmGaDKvZJglT2y4NE=;
        b=OEnd2NEEckhBqM0DPMEJfajogZrof/l628XlsLYqBKvxjdja6NVR5iyptff1Cy73RT
         h9GRqe7EWQvFbxD3rg5Nsur8nQYER+VcnkZeISnCOaPh6nLR75i5SVYWVDobonJ5pulW
         L9D9eha6EnjzTmyESp230uLG6R1CViBXYQVB6iFXJ4hByWZn6CLu6ryOwW6AdF2624bw
         dmLoRaG3LogZRBo5M41cdIO466bpVAF/WnehNGkTA5p84e3iASvmchfcbvCu9CZxDXV/
         D90D5pHf34zPprXsy6FvVi4LC4vxV2cAlaWiM6TGuVoMF6tysiJ1Wb69N4p09RKiOKay
         d0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2eKdBgB3x3/6IciBHhqjS+e/Z7nmGaDKvZJglT2y4NE=;
        b=eCA31g2MsqhJ4riT/oj3AhgNrRT3VpdLpvbRTdiThtr88fbEwUva58p2EYE03IgzxM
         jnqrfTOKCMEc0GAdLm2WJKjg+ys+ed6xhRz+kVonHRVzgarBRbWgbycxRraPnETZEEFz
         urCwfcRhbxPcvC1pwAmaS/OBIBbeccR+Uh0Lyx49+aKCIsUFVftGD1nHvgBmrii7oYyH
         lEddHHJoeQpFjWRp8wpbBkyMnJvPqW47+BBhZe86BXXxNbQvTre0TGSmOV+TlMspP05/
         jmTv5bluLOlZyN99q8h4o8CCdJEJwFS2mQOOb9WDpQyH7m7dXR00MX6D2nkDuFgnQYEu
         Gbiw==
X-Gm-Message-State: AGRZ1gJu5gB9f2OfwT/BFMsEHqCrK5eFQwlGsEmdsw+DVXpyjJE7HCHz
        XmTKZ4KNrinte8GaVCrLRgs=
X-Google-Smtp-Source: AJdET5cyWG13m4/e86CuN9XMK5XesyfoyoYlWdsH0Xt8PwabjhxfEstwrI15bTpA4Gr7g6jH0ZWM5Q==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr4314747wmf.143.1541041285357;
        Wed, 31 Oct 2018 20:01:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e5-v6sm19397434wru.88.2018.10.31.20.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 20:01:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/5] am/rebase: share read_author_script()
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181031101556.27169-1-phillip.wood@talktalk.net>
Date:   Thu, 01 Nov 2018 12:01:23 +0900
In-Reply-To: <20181031101556.27169-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 31 Oct 2018 10:15:51 +0000")
Message-ID: <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
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
> Sorry for the confusion with v3, here are the updated patches.
>
> Thanks to Junio for the feedback on v2. I've updated patch 4 based on
> those comments, the rest are unchanged.

The mistake of overwriting -1 (i.e. earlier we detected dup) with
the third instance of the same originates at [2/5], so updating
[4/5] without fixing it at its source would mean [4/5] is not a pure
code movement to make it available to libgit users---it instead hides
a (not so important) bugfix in it.

>
> v1 cover letter:
>
> This is a follow up to pw/rebase-i-author-script-fix, it reduces code
> duplication and improves rebase's parsing of the author script. After
> this I'll do another series to share the code to write the author
> script.
>
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
