Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E68C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0781613B1
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhFALHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFALHw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 07:07:52 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8931C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 04:06:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b5so12470772ilc.12
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QM0WyjEbyqxm28EXQxRmvB1X+Sp14S8w+izDOO5SbXs=;
        b=dSG/+pWafCakRO1OVMuOjV5kyBwUegs1+ux9Djjl8Qdj3v5Lz7bWISTUus7U+m33JA
         i79NEXSaV1r14NUBv83TlhJup2J5yt6VdOHX7+ywmezJ9SJ1pVMUd716ZwPYptEQj8xx
         bYCARztIG+RYlyYDRe6s79v6fvCKJPAyBWimyN8xVA3NFUDW7cpODf+uUukBVCt9j/Gm
         H7uGmrOCuxbak1bs5bwjHmWq+vBuW8TJ+avYRCE/Nxj8cwG5zwwgeTEcR5X5BE+fEmdc
         zUrHlGbbLIsslGErZoEcgFnvT4n6lmaXmwux4gHqQrxwJtAmmq0KQSHbxV8gPZX+la8Q
         lcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QM0WyjEbyqxm28EXQxRmvB1X+Sp14S8w+izDOO5SbXs=;
        b=uCB7fRMPtHG4GV852GyqYASy/jilzMYkk5fDdo7GUnAHE0wz21guqpvvo8vYWocDPQ
         QENjBOyda8L19XjgtJpqSU1s6KlJceiSd/JjC5W0OT6Rq5mAvGORfwMRV0i21jJntuDD
         cqn/iaZRB+87ZOB/AjKxL78NQdgGMdPojFqK4Lsiw18diPrfTAO13hVeHMFKKXjFP8l/
         uT3Bw5qEWYl8hS+1BnyRYvlp5Rlo9KNB0v7G4MQDVkvxj6wBCB52SThpmCOc2w1B+jbw
         Gx5yaF2UHLmF3K8xZbwss7WW7N40qWJQ1dmmJLySUWUi68ACnTEpYU/KJXbPgdVbvEiE
         9Ifg==
X-Gm-Message-State: AOAM530xcD3Ob5Yv7Uk/gPkLukw7ALWZAMVM/P03vASrW4faGQvFgrTB
        gAD8+puG3sWWVWIoTlnVytDsWuoPiOk0GNg1VYk=
X-Google-Smtp-Source: ABdhPJzHwgIF7iq0JIc4khJvgmfiDaLXqa17m90YL7Yq2B9xI6fkyN8Wo3AKivOA252R9LFThOtqxtEjiHLSqAes+bE=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr16104070ilf.301.1622545570020;
 Tue, 01 Jun 2021 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
 <xmqqh7ij20l8.fsf@gitster.g> <CAOLTT8REM7tF6ojdmnsJt7-RE6a8oX4RFXVcL215YnYTx6b62w@mail.gmail.com>
 <xmqqa6o9ucyc.fsf@gitster.g>
In-Reply-To: <xmqqa6o9ucyc.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 1 Jun 2021 19:05:58 +0800
Message-ID: <CAOLTT8TP0kxp=MJw_kBifWjf9n69FWS8Mcxn0EZjsM69MdidHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:54=E5=86=99=E9=81=93=EF=BC=9A
>
> > Well, there seems to be no correction here. But is it true that memory
> > like "\0abc" is considered empty?
>
> That sample has 'a' or 'b' or 'c' that are clearly not part of an
> "empty" string and irrelevant.  After all, a string " abc" is not
> treated as empty in the original implementation, either.
>

In other words, we still need to look at each character of strbuf,
instead of stopping at NUL.

> You are treating a block of memory with e.g. " \000 " (SP NUL SP) as
> an "empty line" just like you do for "   " (SP SP SP), but I think we
> should treat it more like " \001 " or " \007 ", i.e. not an empty
> string at all.

OK. I understand it now: " \001 " is It=E2=80=99s like a block of space, bu=
t it=E2=80=99s
not truly "empty", "SP NUL SP" is same too, So the complete definition of
"empty" here should be: All characters are SP which do not contain NUL
or other characters.

Thanks.
--
ZheNing Hu
