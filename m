Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA18C433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D2F619BF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 07:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWH6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWH5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 03:57:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BFC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 00:57:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w18so22379492edc.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXgI1O3I0tOJoY5lrN6mSxDPaQAdvgCK/P/Z+lYert4=;
        b=PArKUv3cIxA3K+gWD0RPb/mqz/UVLWPL3xcFg99TNOiqC/2JkAR4gcu3J2GQ1SzX51
         UutTd31h8N2e+fhmN4cTmZYwzNgHrpJ6UNe72zDLaURhKaIxnxgMQO1gtNMYAcMHNiHi
         DoRpgEybBzU1q+xFgz4roUnu+H4BowkVzMBNnlzMU6CtA3AsHMEHY4QFTJ1DvNTwFbL7
         pEKIbTNRSkkckeivGfZqfjfJpJwf0a+IOC3NfFpT58I73tK9onOUZGERJM8lO07o0lYg
         kfOPJgLTXjci3SeVF8eQi1X21MSrdoZo6L44Q7klE12imqgW8JCY5FP1h/pAsg+/X3mZ
         7Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXgI1O3I0tOJoY5lrN6mSxDPaQAdvgCK/P/Z+lYert4=;
        b=Z18c29PLY7muUm/YcktVybJNI7vBsZSRSkRxDmWOs8617uU11bdd2hyus5qtEjzS2n
         yu2TWw8AkUXSpzIh7jFAZu41rjMzzCpujGlMv9SVVs0/9UjwLg2RI+fvDUCbBfzAhl4U
         64s2ksn7c+6tL/y4lQC6/aPTpU2Fv6t3++B8aOiJ1PPRRjGQpwHLLS42ihhDc26RIpU9
         IvxMb2JUGTS4Sp90jp8/v9jkKMwia+4BRnDIGMQw0GJPT+ZM8MyHIV3j9a7Uh+/EyD3B
         E3GP51MAvizxAgowurMmVNkQxvSw2NtI0ITbDaXrI+meHZghgDHg3KpLKqxgMgIKgM8N
         m/iw==
X-Gm-Message-State: AOAM530fMmXpTIbSi6SgifMmSJffMMHtoyZsVeZDcikmCcUqDT3ai3m1
        LM0x+VoMegO57DjjUlLXtcunrxLg5u2fE/g/NdQ=
X-Google-Smtp-Source: ABdhPJzjaZi45XXi7nvkslDAaKlBurkCkL01hMfp8y04tWvgSdi2IhbLjgBzLjw5DdXxbOtunwSqfEp6xxPXFmaQ4nE=
X-Received: by 2002:a05:6402:170f:: with SMTP id y15mr3337788edu.127.1616486256926;
 Tue, 23 Mar 2021 00:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
 <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com> <xmqqv99i4ck2.fsf@gitster.g>
In-Reply-To: <xmqqv99i4ck2.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Mar 2021 08:57:25 +0100
Message-ID: <CAP8UFD0s4Gm3PgDPpsXC-8Gyrnn1JTMUBu60XGV7i8nRDCCJ2Q@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > If you want nothing to happen when $ARG isn't set, you can change the
> > config option to something like:
> >
> > $ git config trailer.sign.command "NAME='\$ARG'; test -n \"\$NAME\" &&
> > git log --author=\"\$NAME\" -1 --format='format:%aN <%aE>' || true"
> >
> > (This is because it looks like $ARG is replaced only once with the
> > actual value, which is perhaps a bug. Otherwise something like the
> > following might work:
>
> I do not know the origin of that code in trailers.c but it feels
> quite confused and error prone to use textual replacement with
> strbuf_replace().  Why doesn't the code, which knows it will use
> shell to execute the command line given by the end user in the
> configuration, to just export ARG as an environment variable and
> be done with it?  It would also avoid quoting problem etc.

Yeah, I agree that would be better.
