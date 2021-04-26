Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53263C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C6361075
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 11:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhDZLJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhDZLJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 07:09:58 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D011C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 04:09:17 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id m2so1215286vst.2
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X4LF5E77e7lm3sJZErnCjLwmGcm5GbwkhfQ8E/soKxY=;
        b=tlq6AlCaoStBnLxe8Vqj+OTllqPSXB0ffNOwIyi3RD5V/BFXkTbb6T5x0/n7vcD4Pr
         tSOsCh4iz8KNA/vEs9ecGj6bLmb9qqWxBMlpew18zXuzcVlPgE0UEqrs3+DmQZjoVo1e
         pD0EAM1/+AlRP6g2liFqL8IDmUt6JarMipoSEezAVdzNMymSYBs0XX95ORc90CNvz63s
         1HniFBNi3e8aE5gA6n24GspbJJ90t6GFI9xZ3rd4O13mqpGgEDzrE4RieZVl6y5cUuVA
         kjlmAZLbQy8jsSfFyYk/2EsovfMdb/dwTd9uwhlFRZbvf5ZDuBn6aimFSltmf8DhL6yb
         FkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X4LF5E77e7lm3sJZErnCjLwmGcm5GbwkhfQ8E/soKxY=;
        b=jou08L53iwwo+f/8Cz1UpO0zyBlaNBXn+rfkPrMsgcU27GHSK3JoSmFniYypd3zFwR
         Tuw37Wt2w0DyiO92sOGqt2lAwhKB7WYxn8fGzi44kN8QvwaVPFi7YDaaox0L810GfMDl
         MgfAVanbxt0gkvYlJRg2aMtBVmmVmS9HEozgOYoKuozaUqSdEEyuDlxMUmQ+UOJ/vwV+
         8oKAoQaPhHLgJ9oXbTp+v4GyBidj1YfjSOXNYiusb12DiW0wIK90Klv6F/A4bn8/D3pP
         V33X5p1aILkmbUdTKfInVSP1nx8sidnNl6povatZDIs0MxH8Oqg2NaPw5R+jZxdCjXwq
         Bg+w==
X-Gm-Message-State: AOAM5303b/fFieDxopaTySPaO7UdwF01KVz7liquSohhhGEF/x4p9Q6i
        DTelP/tOurVQ83q0A7jwnyaCFgAF+2DwQb1wTM8ZZQ==
X-Google-Smtp-Source: ABdhPJws5Rfi8bUQuDyi9DZgccXD4J6+qtB+hQyNF6ajWm1GJsgJ4B5H1OWOrptxaIVy19dwFNQ1d2rszurHz+yC48s=
X-Received: by 2002:a67:7d42:: with SMTP id y63mr11829380vsc.5.1619435356056;
 Mon, 26 Apr 2021 04:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <3d3b733c31273a004e80d5cbab8f746a2010e9ea.1618829583.git.gitgitgadget@gmail.com>
 <xmqqa6ps36ow.fsf@gitster.g> <xmqqo8e81q9p.fsf@gitster.g>
In-Reply-To: <xmqqo8e81q9p.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 13:09:04 +0200
Message-ID: <CAFQ2z_MMiFgo3jCAgRUcuaaHphHYXgNCJiq8-y+aY874FF-9dg@mail.gmail.com>
Subject: Re: [PATCH 10/18] test-lib: provide test prereq REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 1:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: Han-Wen Nienhuys <hanwen@google.com>
> >>
> >> REFFILES can be used to mark tests that are specific to the packed/loo=
se ref
> >> storage format and its limitations. Marking such tests is a preparatio=
n for
> >> introducing the reftable storage backend.
> >
> > We'd want a bit of documentation either here or in t/README to
> > explain things like how these two interact with each other, if both
> > can be active at the same time, etc.
>
> By "here", I meant the place in the code where the test_set_prereq
> was added, not in the proposed log message that will become hard to
> see when test writers need to work with the sources.

But this doc would be part of the reftable series, not this series, right?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
