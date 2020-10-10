Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E49C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28D920760
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBPaYjfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgJJW4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgJJS7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 14:59:23 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3DC08EA72
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:03:58 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y194so6753489vsc.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vSQN81NCMMsiv3qaqxRK3doxlaJBGuJdMyFT3PclUiU=;
        b=IBPaYjfiMa196iqUuPUuyJ1UX0H2rP7kDsWnBZQA3w9ZtUFVkvpSnVppLHBXkPQds0
         f+CQpc00YLzAaA5Yyx24ugaeTGd1h0pa1xQe+DUshevwZkVoFb0JhMOdV0Ci71s84gao
         MQCM7w3CsHAEXsQ+cXMNzBbX7v4VMcBHvsW5qePkM4r1zFjNup9ZCJ8dEhiTrdjfo1uf
         GB/v/hGpfgri0/CyiEjBxZNCU0wrYfHy4R/ZcIgTOcy6nPYWWXVGHXZI+qC8qPp0RdYE
         4DPCZCm6RVYVUQxRa0LS33tS1KpqDPIJGEVJrZ4Eeqf77bzm8ZOuzFgRottGfRDKggHE
         vGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vSQN81NCMMsiv3qaqxRK3doxlaJBGuJdMyFT3PclUiU=;
        b=LDTmOVDsmJKddDU0lWBPCX8VEQ001h7dtFf2SHmDAaKeUrewc4LCre1NWNJN07smoH
         Cm1Cr8ODguU5iGkmkTI1RC2jH0FEi4VXbUGaYEL/fdgR8Earl6IxYUnKsa9gHMsieqit
         Wv9AmAoQWLa06BIWe3lj/HN7EVsP6eI2RBY0yZO7o/PspfSNf+ZXOf5TljKFSL821Is3
         8g6qmWcuTI0IrZ2qx9cLoPABTSAHanKArQKGbxd57cTsAFVOHodVBKZD9yzUHK2qurXX
         97seYQQ/jv/LPG/dS9me1NHwKHyMC1YVXUFnbWyHFwasP1ZHrJoSWDatpWkkpcLRcQ+C
         zoLA==
X-Gm-Message-State: AOAM530Y5xICxbXMTqz9bgHMyt+OG5IhTY/GsLwM/5NAKvfO5xZXO2hn
        qqchWU/lQXxPyYd7PUawEo4p1KhIzTFiikX2CUWjMQ==
X-Google-Smtp-Source: ABdhPJweyxaQTlBmImmvcdAmOJvPsOQYc9k3/5yuW9WqRCwlfcujaeMOR89+ja+WrjQG1WQIfXg2h2iesDGCK1etpco=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr6295285vso.54.1602349437116;
 Sat, 10 Oct 2020 10:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com> <20201009211300.GA2774782@google.com>
In-Reply-To: <20201009211300.GA2774782@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Sat, 10 Oct 2020 19:03:45 +0200
Message-ID: <CAFQ2z_PVVGHi_N1uw7A4xUczm9WPkpXkQ9Yte9gCNO9ExAupyw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 9, 2020 at 11:13 PM Emily Shaffer <emilyshaffer@google.com> wro=
te:
> Of course, taking a completed project - like your initial reftable
> submission - and then chopping it up into a cute story of commits is a
> pain in the ***. Doing it twice - or more - is just aggravating. So I
> wonder whether we can bikeshed what story would look nice before you
> even pick up your 'git rebase -i'? Doing that bikeshedding here on list
> means that we also have a chance for someone to interrupt and say, "no,
> that organization doesn't make sense" - or even for someone to say

It would be great if you could bikeshed about this while I'm on holiday :)

That said, I think it's worthwhile to first look at the commit that
uses the library to implement a ref backend, because that will show
better how the reftable library fits with the way that Git likes to
consume its data.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
