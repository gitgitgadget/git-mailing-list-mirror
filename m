Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F5C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F6A600EF
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhEaRGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhEaREK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:04:10 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89754C068FB2
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:16:15 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id z15so1148446vsn.13
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0iZPdn+m32dalPH6tuEQ1pePydHoMBmcSrnYoSGMUcY=;
        b=p8O5KV37ThCl4jc1ke6EDCeDB8p7pH6JH7esTk4Fk3sORdOXay7doP+j1DUBOtiJBu
         KAjqsGF/Vgo2ghSGnFa+MsP3kwcadTkgzORQi1mCyJdLUOIQpl7BprpkvPMtza9voR3A
         ER6Tb4FEOxW8f/qY7US5lNefzTtPaiRVgE+2PwCA79hOdz7sHBYG1veLhdthFiQR+oYy
         S/nvl7LWA5OWmK/6QNusL23qgab0vhKaeu/NO5PL7qzipjqAH2pW9OekvOxwvui0lU3Y
         KcsTd9BQZyyVxI3HFmhSneTMudAhDNI1gKSHiPoZDALI/9tvk10dzJVjCUgfpDILIgSs
         eMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0iZPdn+m32dalPH6tuEQ1pePydHoMBmcSrnYoSGMUcY=;
        b=YryvugkJY5UCv8nDi0T/OMIZnu6aiLLKqUTV44wLycvDhFdG7SenTC6v7qrswTfZWh
         XfSUcBtSwAl9dxFEpVCJbojeBzjKynNBScr6rVrVe19s26p90N/tqSUBhTASdY1vWJmG
         yhyew6UKY73nyt3HZUEQFErmhlKfZuYgBAwEb+po9Vw8yeu7Cm7V/XYHYg6PAXpgjAKf
         uGvZwk1ZPt3j0qipn0UWqC0lzWCv3Ht+oG6pCgYDWWZHpdpBCB9MwxKOGsqpjmc1QCup
         UbmWfLNh7xNtG+f7jBjXVBydWDnSdgv1+NiO9w5Qls02Ql+Usb88vNjgQsy1c0i6XAwq
         8MLQ==
X-Gm-Message-State: AOAM5309HNXjNXV0iWnmwt6Kl1L8WHmckpQfPbWq3mTRNV2Vz9PNDW/U
        UL2y0z6993Ab/voi4cbq/LODerbDYNS5ACsiR2ShkA==
X-Google-Smtp-Source: ABdhPJzEbSJkbVhUYWH9kNSXLN64nPdVhaswxguLGWdcUwNSr52E20EKQAJ2DWToElCiorvcDpuSs7ZTbYNxcAHgSOA=
X-Received: by 2002:a05:6102:9c9:: with SMTP id g9mr13575289vsi.50.1622474174531;
 Mon, 31 May 2021 08:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <e4e8fc1d4b4f450d46dd320ffc2398515044b28a.1619519903.git.gitgitgadget@gmail.com>
 <87y2c9pgym.fsf@evledraar.gmail.com>
In-Reply-To: <87y2c9pgym.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 17:16:03 +0200
Message-ID: <CAFQ2z_NzRiM6u4sqLHeN9+KwzWum0PVUpcRiS0grEKGD0UqsiA@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] t1413: use tar to save and restore entire .git directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> >  test_expect_success baseline '
>
> So what I said in 05, but also didn't the commit messages of 05 and 06
> get mixed up / bad fixup in a WIP version? I.e. the first commit says
> "use symbolic ref", but it's mostly about introducing the use of this
> tar/untar pattern.
>
> Whereas this continues the tarring pattern, and doesn't start using it,
> and (presumably) is the mis-squashed commit that should have added this
> whole tar thing after the first commit does the isolated
> s/echo/symbolic-ref/ fix.

I've split the commits by test file. I added a separate commit for the
tar use here.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
