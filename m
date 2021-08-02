Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F151C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7606E60232
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhHBNii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhHBNii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:38:38 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BDC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:38:27 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j19so9541576vso.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yf3oEsgXjjzO/f63eYESW9hXUrpg7b4vRD2r5EgiFBE=;
        b=Sn7Uq8Kt2BLl9EaSC47SsWwf/kSAgCehl3v8KAVbZGd9AGerd59fO5btgC0S+nkX8V
         Ng53RlqfaMEwrCBQ4558JF+91UL1QwZia/TX7xJF5GEQjw5OIfgx88qDf2MQmtDBXEYk
         b+QSge00qZHDBmwJE7oUfJidgmHTDo/pRp6/v5yQB8spm0Z7wcSCsrTzq2pEuQuq1qol
         D7YXqSfWSLwBpXvYEkEO4DD26melCMUgUM+/94mA3v9a6VhhieUY6Nl9iGnPpDKFkKRK
         Ccmhg58AFJ3lGaAzbvqNT/RCMjo/QEqrrgM1OUqTKAyei6VFldZmjEdNQKnEpKZR2lou
         etEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yf3oEsgXjjzO/f63eYESW9hXUrpg7b4vRD2r5EgiFBE=;
        b=qAIBwjrprBDwSntLYiQWjvkZwTwjiWsm2n+dVFDqjNcjG+1Zr2lSq3HB4NIwuP8TbI
         7X0Mbbdo6XOZYZQ5ZqvyK4RutgpBF3bQW/pLsD/OgRWEXqHddrksUcq1qNJ9RRcWPPNc
         j2fYke7XXL0BEUWP8LnWldzImOinU45mASNAx6dfdS8t+PdbHNzQEWSXZgS+SC7X78H8
         QsHotTxPIIpibzd3xxYq2O9sRxXM/Y56+yh8UiqVNLj4pi30xRRq38rwtbZQuJSQCx8G
         X55L4bjgYy2xbqrO0FlryMWPThCQxLPc+I6HTYQGoimVva+kYirGrff4BzrBb5ZIEB4a
         IceA==
X-Gm-Message-State: AOAM53362ecMitGGfWWQ0U0TGSWuH/ufuuv/R7xoEuj3O6PcFxj7WSlQ
        WuM11EEgGljiFyLHmNUF/GS+RgtkCUo3IH7Dk4AI7A==
X-Google-Smtp-Source: ABdhPJz9co/ZqjwW7OtEyt0baKoIrreXfuKb8ruGnIYROewPzg+igrbtw5wIjA0+Lr50nb3fsW31Y3Udlj0e/lwCvbE=
X-Received: by 2002:a67:5e42:: with SMTP id s63mr9603806vsb.21.1627911506789;
 Mon, 02 Aug 2021 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
 <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com> <xmqqbl6tncw7.fsf@gitster.g>
In-Reply-To: <xmqqbl6tncw7.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 2 Aug 2021 15:38:15 +0200
Message-ID: <CAFQ2z_PjEuy2Ngr_i7c8rT6xb4w2HBEUARqwR7azZO4zor-w7g@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Fix direct filesystem access in various test files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 7:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This fixes a few test failures in the reftable series.
>
> The early part is already in 'next', and the new ones looked mostly
> good.
>
> I didn't quite understand what was going on with "ls -1" though
> (what does it even mean to "ls -1" enumerate only the filenames in
> .git/reftable directory)?


By listing the files before and after, we can make sure that the ref
storage wasn't changed.

(perhaps "find -type f" is a better way to do this, though).

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
