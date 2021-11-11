Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F22C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C75861268
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhKKLtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKLtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 06:49:15 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1EFC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 03:46:26 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id p37so9523517uae.8
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3trxHdIGxJ5nTGSBKblyD7361GOErFxqthHX0lyQf68=;
        b=gtaszDErh7UphLfUNsLOwYzrGYbaZcPmrMj6ghdb03St7uaEj3cvyYVvwkxM1j1lqo
         HvipMG9kNf9t22BYXkbcsd5EJe1cNdxz50OytTYqPWVZkyErw4hTIVCy0oEQtlZMSj6C
         Y7ADA0Z1plUxkm2EH5EyJBYAGgwvCYapqrZ0P2JQjjGFETep+dFFlQbs8gFAjv72RD/f
         yWljoyMlDPsOKc4dObTebyQw8iccYoYMLWO+EHW722AsfO27g5Na8pNVdg7MPMh2l2Mf
         bUF6rS+MsWqZI4TUHosgImwHfdSRyTrUjk/9HYUtCwYYl68bPA8pwceAixDRH4O0rWtQ
         2gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3trxHdIGxJ5nTGSBKblyD7361GOErFxqthHX0lyQf68=;
        b=LC+zptfPWykzvlUSg/M9evWOItGkLe2OEF93qiRzc6cTb7Thgv6UltF5bl9FP6nlOc
         xvXJYyo9sN/ojI6UB/PAqRgZbdtuWdu9q6Jf7yI15QqPGtg0qIu5W2bEShFVfI78jdN5
         OWd09DeudaD3E4WqaiTs35Tj4vu29PvG4f3YPAm3I71DO+kh9X36pdvQo/FcKWNVroA8
         BBJSk9LJreWsXBdS7KrrNEzBsKNFblDebu5hW5Iv1k19JhRFGT7+N5HaYsO5VQfFC1/l
         LzvFhaIqTwxWDti69k9CsiRi0sd6cj/Csz5f/vU68nKpqUKvHPoMHrLnbsX+0Fcvonu8
         uQsw==
X-Gm-Message-State: AOAM530FzT5ikxtXA6DE2Qn66gDz/tOVXumqjq8y7gTGHwFEJ7qSM+Fm
        sQ2Za72rcwxQbuz9t9IFcENq4fC7Zsf32dVDNzkg1w==
X-Google-Smtp-Source: ABdhPJxwRby5UnFTrDl5h1w0LXEsJwbNWdTwkFtFxhTqfM+tC8uQjoNPk09KyWXqigLq6+wzYf1dqBCEnOJBzju+u70=
X-Received: by 2002:a9f:21d7:: with SMTP id 81mr9567384uac.39.1636631184334;
 Thu, 11 Nov 2021 03:46:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com> <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
 <xmqqk0iqrp4q.fsf@gitster.g> <xmqqfsterotr.fsf@gitster.g> <xmqqbl40razw.fsf@gitster.g>
In-Reply-To: <xmqqbl40razw.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 11 Nov 2021 12:46:12 +0100
Message-ID: <CAFQ2z_NASfhdHdZrY3gK29LRK_8Guj0LZ=GgCr84k7XX2L+Dow@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 7, 2021 at 7:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Not really.  I think the comment on the RFC still stands, and I do
> > not recall seeing a response to the point.
> >
> >     One potential harm this change will bring to us is what happens to
> >     people who disable core.logAllRefUpdates manually after using the
> >     repository for a while.  Their @{4} will point at the same commit n=
o
> >     matter how many operations are done on the current branch after the=
y
> >     do so.  I wouldn't mind if "git reflog disable" command is given to
> >     the users prominently and core.logAllRefUpdates becomes a mere
> >     implementation detail nobody has to care about---in such a world, w=
e
> >     could set the configuration and drop the existing reflog records at
> >     the same time and nobody will be hurt.

A git 'reflog disable' command would address your concerns, but it is
a destructive operation, so the cure might be worse than the solution.

> IIRC, the only reason why reftable implementation may want to change
> the behaviour we have to avoid getting blamed for breaking is
> because it cannot implement "a reflog exists, and we need to record
> further ref movements by appending to it, no matter what the
> configuration says" when the existing reflog is empty, because its
> data structure lacks support for expressing "exists but empty".
>
> I think the behaviour change described in the title of this message
> can be limited in the scope to hurt users a lot less, and can still
> satisfy the goal of helping reftable not getting blamed for
> breakage, perhaps by making the behaviour for an empty but existing
> reflog unspecified or implementation defined per backend.

If we accept implementation-dependent features, we could just leave
the whole feature as is. I had expected more breakage, but there is
only one test case in t1400 that needs addressing. If the test
coverage reflects the popularity of the feature, it should be fine to
leave this divergence in, and mark the test with REFFILES.

The commits prior to the RFC should be OK for committing. In
particular, there is a bugfix for the show-branch command. Should I
resend those separately?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
