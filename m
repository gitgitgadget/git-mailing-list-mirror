Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF4C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DFF206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD6HqiUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDCTxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:53:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33216 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgDCTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:53:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id 22so8639934otf.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTrXgF2NxpT7lFgnSPTQXv9s/FutMCTv9r92CfY9oms=;
        b=iD6HqiUUuyi6FjQpsM+9BzlsICv9lVS7F7nT8ETUBSQTUMwkdMFYfrD5MrnDmLumuL
         jgQnsuT3D8HyXAORdafqfCp9Bxu4JlMCencf2dUn27wuyiUf9OvofMXiMy6AUo8qskJR
         GjyDUak21a66NPppId/ey6tq5WJ8CFFda7zgdbSesGLvd7KLZPqI7zeachoL2U57YcMK
         YDdiVRTtlDYfdZocXJWcldWNJMqYRL6wDh/jdCy5oLAAR5YxLhlKHYUXhUXPxIJhAsib
         2QjtTUCVBniuG6Q/DAKgSdBR/kP3phu1ejPuTYvdjmK7p2NiKAb9q1wOnfQOiWTkgasD
         C4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTrXgF2NxpT7lFgnSPTQXv9s/FutMCTv9r92CfY9oms=;
        b=JUUBC2/iD5pa6XrcI76GoPy/pvL6pqOnXMKmqBKd+mUPYH9asl4uI8TZ+hgTw79g0s
         fMA2mM5rSUyDwcIR2PySsCRH5rDtP+L1hE2zMEbsUJloaYd0eNPfvEtSdKlLdjWHeD18
         0IGmjB7Vz8DFOq98jFsLkQEt45ELpPhRCxF1v+Zj9cZg5wuQtpPLCHAfwunwezqhlHln
         82JQUlsA72EDzGr4WX09t9V/50XAfpqIglVBovq+r3OU/u3gEbz1MiGm1gpuGRQwdrM8
         YA7KDezgKlU1Xq1vRXR6rnqCR9jRgWYZCnNvVq0iVstZob2D4QOCIOY4OkWC7wi8W7JY
         lmhA==
X-Gm-Message-State: AGi0PuZFaeav/cLiWaR7DdkmQERlibFSFKzQzDnQ2pvnbg8p047wMGoH
        XGLSfnwyYT0ad2VzQrtwralYXolTSuwh91P4MGo=
X-Google-Smtp-Source: APiQypIi7cAPdCIyYsnvCgDZLYUEmS5MrVi2IpXu5e949IA+2tisT/i2AZGd+P1w4VseohscTXske0GoErqYcNFihS8=
X-Received: by 2002:a4a:a88a:: with SMTP id q10mr8176490oom.17.1585943589685;
 Fri, 03 Apr 2020 12:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com> <xmqqk12wz7jv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk12wz7jv.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Apr 2020 12:52:58 -0700
Message-ID: <CABPp-BHQ9NSaocWEC9GGN4xD7sqi6MrtF98gDgZ5O5fhYYgwbw@mail.gmail.com>
Subject: Re: [PATCH] git-rebase.txt: add another hook to the hooks section,
 and explain more
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 3, 2020 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  The apply backend has not traditionally called the post-commit hook,
> > +while the merge backend has.  In contrast, the apply backend has
> > +traditionally called the post-checkout hook while the merge backend
> > +has not.  However, the calling of these hooks in both cases was by
> > +accident of implementation rather than by design (both backends were
> > +originally implemented as shell scripts and happened to invoke other
> > +commands like 'git checkout' or 'git commit' that would call the
> > +hooks).  Both backends should have the same behavior, though it is not
> > +entirely clear which, if any, is correct.  We will likely remove both
> > +of these hooks in the future.
>
> I'd phrase, instead of "remove", "stop calling from 'git rebase'".
> These hooks will still be called from their intended context ;-)

Makes sense; I'll update it.
