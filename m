Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103BC1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCWRYi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:24:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53723 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeCWRYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:24:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id e194so4905034wmd.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eZ1N1QTs/3IYXV70IfCrd8sHrQlmBlMMs1BubWbySpQ=;
        b=rAxQLQsfuQhBxEsw8JXIAVfSts2v5Jj616m2FvPqlOpFXbzOrNjCfA4c56dXC7vZ8+
         C8/1d05orXkbEl3Yv1XIIFP1ThX3qNQ8fYrWU7Fa4zpOlEn2b+rA/ta4+X8qWGzV1T7h
         /HN3WQP0CcjQaTk9tEe8EVMUOoGDRxVJXy0oIWS/ABNoOKD8GxYEFEQNd6IF90E5BRCZ
         CsqknveZ3qB24/w1kbYVws3O6YU2FbuFZUfw0fuWPgDtEXiw3KnsMNdcucyeiZ2LEg/6
         bwcjewi9PzOePIFmsFS4Gb5Gp+/CugGmMRBRiK75Nj10xC1UqXDHb4xjsUGIU+nFnTy3
         qthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eZ1N1QTs/3IYXV70IfCrd8sHrQlmBlMMs1BubWbySpQ=;
        b=hOhubPJ0VS/JHzXoWOH/emTAWTJjXf59zSOz3xu6NSgg6pcFg4XWq+FO+4QqERnSNk
         kU6gutUCjdDYSahrWZerpvzcez9+AxAwiefPbQD6NAP8dqSIqceKhlSsKKehwTeUj9e3
         8eZXBY3mdQPY/zxC9niGuUJow6Ikir1vMDkLYb1e0N/Jfv8vNb3rJR6dbApYki/7uV5/
         wC7DUL5tB+JB7fsfuMo5qG8IKNMZrSJEzXNqmuKdqXNzWr9m/uMDa1aENngHwCcOZNhf
         yaW2e3Y/gR8wX+bFXT8obWix8aqLDbYp1X4zBaX5pLRjKXDC53uH27HVdcyErXfRqBlV
         nMRw==
X-Gm-Message-State: AElRT7FsNAkUg0Ybz/SCk43kVOpBAP8nbEee2dxDvUYfHZJTbJEpKSHa
        C/VqJzn8B6MlXN+yxT/aKow=
X-Google-Smtp-Source: AG47ELtuxPN2roIvcxnbJ1iLlJwQcWL5vg8X9+46F5W10k76c/RY0mwV+r3mEogEtiGKx/TYycSGTQ==
X-Received: by 10.28.91.79 with SMTP id p76mr9208856wmb.3.1521825875378;
        Fri, 23 Mar 2018 10:24:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137sm2440142wms.18.2018.03.23.10.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:24:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: clear cached --options when sourcing the completion script
References: <20180322141604.15957-1-szeder.dev@gmail.com>
        <CAM0VKjm3WKkxjEN09Dv1wUnuBf8CSsUvmLjmSVb1fbHTyAdXEQ@mail.gmail.com>
Date:   Fri, 23 Mar 2018 10:24:34 -0700
In-Reply-To: <CAM0VKjm3WKkxjEN09Dv1wUnuBf8CSsUvmLjmSVb1fbHTyAdXEQ@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 23 Mar 2018 16:14:45
 +0100")
Message-ID: <xmqqbmfek8ml.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Hang on, this test fails in the GETTEXT_POISON build.

Thanks.

> The thing is, we get the merge strategies with this piece of code in
> __git_list_merge_strategies() in master:
>
>     LANG=C LC_ALL=C git merge -s help 2>&1 |
>     sed -n -e '/[Aa]vailable strategies are: /,/^$/{
>         # a couple of s/// commands
>     }'
>
>
> and that '/[Aa]vailable strategies are: /' won't match in a
> GETTEXT_POISON-ed output, because that string is translated.
>
> I think for now (-rc phase) we should just drop this test, and in the
> future we should consider adding a 'git merge --list-strategies' option.

I'd say we should just add !GETTEXT_POISON prereq to the problematic
tests.  

"git merge -s help" output under forced C locale is dependable in
the real world.  It is GETTEXT_POISON that does not get this fact
right.  There is no need for '--list-strat' option to make this test
pass.






