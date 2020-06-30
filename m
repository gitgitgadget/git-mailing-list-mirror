Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF319C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FA0206A1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYaQuvdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgF3Iai (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgF3Iag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 04:30:36 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008EEC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 01:30:35 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f24so10742529vsg.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efyz/4iVxfCSlZc4+f4m7dighS1IdoBOmfahHFuimOM=;
        b=HYaQuvdngfzlrstf7otrtz9Ub4bE8mS/uwlzDQGMHK3ughfRFuQyEg7oQXZQaUWMe2
         JycCmkOsKvKfOvDCJtYq6ckzBXAviONKfGL5YoDh6qp0uZZiFrMa2OEs6tXS8un0X18x
         jGQ5S/ZwMbbUuSGCmQ8szpRG1M0G4dhn0HK9Psy3h5rXE2yEZh92ODk3+U7mpEQWU31J
         BNY7BYktiRaNDaVc+vx2s0T2bV0fDauEirSpgQ0MOh0jpd5UOc7uJmYpBE5I4Nk1TkTT
         sjFRVTmWUgbUb8EFFHdPvInp94O5DpoS9mFfmUQgH1BzV9CFjNNTAZq4OftejxEUvH9h
         5kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efyz/4iVxfCSlZc4+f4m7dighS1IdoBOmfahHFuimOM=;
        b=SJTwhgGnGfiCT4E9wLOfXrFgid2gv42pAGwJUaCCw7IUiNms6k6Ak46dYTPTtJtEVZ
         U+v6h479jFSINeEW+4w+lDJ1kLBVf3yhR3ck80t7cjGy2YN/ooCoeTPrIGFeJLUXMTct
         U9h8ocu8LJZxOw9bh0zu9Ir1BaxOzCzhAeT37LNCtMoaSR+BkyNc1tqty2HeJ9siTUTN
         DIAy/sB3eMhRLoASMmYb0J3CTSXKU5vAaAipd2mvHDmWwoArkzfaU2US/viV1b9eEiD0
         nyNOv0OPnuPwqM7EjyIzWlELpwkot49KJbewSb0FMUd+7tkug5Mekc8jsskyq79fHkIB
         TfuQ==
X-Gm-Message-State: AOAM531KdsXPzRZ16kzyV3W48Pr+fhmFMdTCi5CyaxOWxzpdNBnDxShb
        XHF1tCtG3dlz19sqbUZlg3NwccjzcvTs/PJFH0/JDW9DW+w=
X-Google-Smtp-Source: ABdhPJyUyoLT8VfYY4lnI5uoGZPD0Vhk7BMJmRVy6qLClAhtZppUvV3dGyyXQ7qaUAb4rq4ysfFyG+ZKA6OnRhkJN8Y=
X-Received: by 2002:a67:701:: with SMTP id 1mr8696851vsh.134.1593505834905;
 Tue, 30 Jun 2020 01:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
 <xmqqmu4lfxet.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu4lfxet.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 30 Jun 2020 10:30:23 +0200
Message-ID: <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
Subject: Re: [PATCH v19 03/20] checkout: add '\n' to reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Reftable precisely reproduces the given message. This leads to differen=
ces,
> > because the files backend implicitly adds a trailing '\n' to all messag=
es.
>
> What does this mean?  With the files backend we'll now see a
> redundant two LFs in a row?  I think you are careful enough not to
> introduce unnecessary compatibility breakage like that, so perhaps
> "implicitly adds" is a wrong way to characterize what happens in the
> files backend, and it only adds LF when the message does not end
> with one, but does not add an extra one if not necessary?
>
> If so, then the change in the patch does not break compatibility,
> but the above description does not give readers confidence that it
> is indeed the case.  IOW it is unclear how this change manages to
> avoid breaking existing code.
>
> Sorry, but I am left puzzled.

Most places that write a reflog message use a message that ends with '\n'.

Some places (the one mentioned here) do not append a '\n'. When it is
read back, the message does have a '\n', leading to discrepancies with
reftable (which faithfully reproduced the message without '\n')

I initially thought we could or should fix this across git-core, but I
think it will be a lot of work to find all occurrences, so I
implemented

  https://github.com/google/reftable/commit/785f745daf567aeabe47cb01024ea87=
9b9e15c2f

which does extra validation on reflog messages, and normalizes the
'\n' at the end. Maybe this is also worth discussing in the reftable
spec: in reftable, you can use multi-line reflog messages, but that
seems fundamentally impossible in the traditional file storage.

I can drop this commit from the series, but I think it would be a
useful cleanup anyways.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
