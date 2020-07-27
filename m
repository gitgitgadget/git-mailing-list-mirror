Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BBAC433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E00020719
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6LKMTel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgG0Ivn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0Ivm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 04:51:42 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3AC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 01:51:41 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 4so1729243vsf.11
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2FMKF5u1PVeWTjCuJ4vTpisTSdGuNfbSlwsXyDF7hSo=;
        b=m6LKMTelYK44Od7s41Vv3bSWfYEUDaJxG7A+R937/z7dX36szijM13RcAI/59lnHIF
         yucijY6xcCVD7gun11mY32RWCGvFqi+tdJKvc1ZqKEgKP6C7dtePSmnJWxhnl7h0/VO2
         yArcwJfAlIQjMfSjmq3TEuYjtxOz/ruMtOx50KAN8LOr33jcBrydjDhJs8+JoCIuuaWp
         fE0TgyVnME4cbJBVph/686hHRRXnTw4BRvK0hMqhLp/Aj8LiCOpr2yxN9E+9xaw3/WsZ
         RIrMSoDJtzeRRepciHR9rvRHzIGOvzmPMjGrrWVGgpduZo77GkkgwixJKcfS6gGyM3FO
         A4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2FMKF5u1PVeWTjCuJ4vTpisTSdGuNfbSlwsXyDF7hSo=;
        b=DW8KsFyKo37af1K6QkqWQ/InMwMk+1B9qJt8602JnZh91fnoBm+lYgsrmGkD+sC2aD
         d1DKpUu769VcbwJab0Gfg30D8XcTVvxBIKLqJxZHRvPd2LEY3onuO3JLbX1FkJCx/dFC
         FducwWvx34g+zzt+1tGYRZJ54oXXmX9Ah/Y5u+y0maEiVnGUCXZGxypa97PJqR3wsY0h
         5iL7OU3YnRiHTms8RMLNCttiOv4LNhtKkAFAZr5/al2hryDe3sM1qDYuUUAMB91jx8Ob
         tLRerJfCDjayNuurNzgi+WMLLNysvRVNoYtlKgKIbbscgxeIutznM/MyCiJmJJ5ktIxk
         LlzQ==
X-Gm-Message-State: AOAM533sFnLMGUKed3piqOIhNe5a9S8YfryQ/PwRBacXgukFEadahhXP
        WzAT7QyjJSCjndZ/jqzuIOHyrT9RDszPUbeBA5x2uA==
X-Google-Smtp-Source: ABdhPJybpWpD1Ke5IN5lgR+EGSz0rBEhdOOfuPCI/YbIlpEf5VnywP+krGM0CTumjwJiCtLuKW7BmKcpLdMD+ennwM8=
X-Received: by 2002:a67:bc1:: with SMTP id 184mr14325447vsl.104.1595839900383;
 Mon, 27 Jul 2020 01:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <20200724160045.GA10590@syl.lan> <20200724200042.GC4013174@coredump.intra.peff.net>
In-Reply-To: <20200724200042.GC4013174@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 27 Jul 2020 10:51:28 +0200
Message-ID: <CAFQ2z_O7D_9ToECfMhh3mbRproktM+gTR_-byajatH3+7-ziLg@mail.gmail.com>
Subject: Re: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Tommaso Ercole <Tommaso.Ercole@qlik.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 10:00 PM Jeff King <peff@peff.net> wrote:
> [1] I didn't actually check what the current reftable patches do, but
>     that's my recollection from discussions long ago.

struct reftable_write_options has a skip_name_check setting. If set,
it doesn't check for directory/file conflicts. If unset, any attempt
to create such conflicts will API_ERROR from the transaction commit
function.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
