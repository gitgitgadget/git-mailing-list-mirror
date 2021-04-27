Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65DC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65F260241
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhD0J2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhD0J2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:28:00 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DEC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:27:17 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j27so1521816vsm.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pGN4/cNVWjyi+p466K9EiQ5b+5SBh5JSZ0FstmwY9qE=;
        b=gqx5oU/bhgWirXhiT06AVNQQI14t5jSvg02n8ybkWL4xGokhTP6AAZr1hDwS/IR0LM
         lCnNgXGT0JKxgQBTXcxnjBb1WN/A4kgGiGuRorkAHMSG7m1lSPxTXLGuXmcq5zZ7Hsui
         DE/uO8304RGHb598RMofBA5WD61RxTNCg5VKM3lijX42alG+CPcAClZ/yRoDJFsl+DET
         W71zV7IvDsg//fp2fnEfgJoPgenzqfnJyRajYvGLznapEepFTMUhoGDpnRPuYbAMH+zG
         HeIpirvlp2QQqZrWpokl+71qbxozpqOdGzACqmjKNrvBWmILB+ILrWjbutNx7M5dkGp4
         DeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pGN4/cNVWjyi+p466K9EiQ5b+5SBh5JSZ0FstmwY9qE=;
        b=tJDA+HueUEjtqFsIQk3REFSD8LDWMKB935XKyh9BgsVXbg6rhpk2UEwhuvIM1oLI6y
         +65KfYRKir24h8aFPlgCNZYFCSKfDew3JIIHotMoXr3rfKzUdJrpSltG2hbrxWMQWACG
         p7iaD1VAN7EfiHsijb02vDLbmiBhz0ggQpHNS3JPfxblxZfLhQvm7n/0EqjHahnfp9CX
         zaiJpXNOdIqShwMfU0LCs8aWMowxwlZYf+wr6PHeNMAfDbkCs/oThcRrYCdghzrYvU/6
         QvZTXuyGPttFuyCtoexzGF3Nv2n5QVEVu/W65PiI8Ux+b4VxwaKeTxz8WDAnMz8sRS4F
         64mQ==
X-Gm-Message-State: AOAM5307U3VsPJR9H1tq0/qdXMX4PwHqgJlSQOKZD/J9Fdb5dCAzkSYq
        nK9FkMC43Yn4TVBkKiceKywn2RSxH8glKI0+Mfs3OA==
X-Google-Smtp-Source: ABdhPJxaO/4Ix9ZvnmQVWG0D+ht7AzhXaFsaWxEetMrQfkO4t5q9jgI27tm0Z6cWNO+v3kppmOn7gDFOiN0tsyrsqog=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr17082125vso.28.1619515636889;
 Tue, 27 Apr 2021 02:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <dd1f6969c28d95027d1ac9f7b6f6a43640babada.1618829583.git.gitgitgadget@gmail.com>
 <87sg3k40mc.fsf@evledraar.gmail.com>
In-Reply-To: <87sg3k40mc.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:27:05 +0200
Message-ID: <CAFQ2z_NxM=Bkjb1rVo0eBpMUHP7fYN6mjTh3U1A=qmkVa9eXQw@mail.gmail.com>
Subject: Re: [PATCH 11/18] t1407: require REFFILES for for_each_reflog test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:23 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -test_expect_success 'for_each_reflog()' '
> > +test_expect_success REFFILES 'for_each_reflog()' '
> >       echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
> >       mkdir -p     .git/logs/refs/bisect &&
> >       echo $ZERO_OID > .git/logs/refs/bisect/random &&
>
> Hrm, so already the first use of REFFILES has me questioning the need
> for it.
>
> I mean obviously this depends on ref-files in the strict sense.
>
> ..
>
>  * We have a PSEUDO-MAIN ref
>  * It's set to $ZERO_OID
>  * We have a $ZERO_OID in a refs/bisect/random

I've added some comments about what is happening here. The $ZERO_OID
is irrelevant here. The test tries to verify that a per-worktree ref
only appears in output of an invocation from that worktree. It's a
useful test, but this needs to be tested in an entirely different way.
(looks like setting logAllRefUpdates also doesn't trigger creating
reflogs for pseudorefs.)


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
