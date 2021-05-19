Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC5C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755B761353
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhESMaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhESMay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 08:30:54 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08EC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:29:33 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 20so4362265uaf.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r+qDlsKPSCKQY/zG9BINTYKjdoSZTdUbFRMuErF1lYU=;
        b=KorEBLLAIKHoT14rGeUfgzX+C1jEkDG0+LiDOOUH1UMpTKx1I2zPfDUWB67mJU7IDL
         1LY+IqqkXbHDZftPGepSlEs4Uonvuzoy7AZysAF6hYtqLBQ4KXi9bMcBjhqXuWCCxxxO
         0kCXibRg37PB/AnwkwQfZkWZC7UQThBEt5Ix4XVIf2yl4tC8gJDKzwTIYcf1TXyIvakN
         67AvgHR342KzADfMUhmVz8AAJK03zFGPtuYiNJ5BkfyacyhhSYqvwmm4Z6nwrhHtPKHb
         fgo2FYpVlAPSw3Q38uTIeagcHwrqTx0iWXluq/JFr431wSiMScy7YHPTbGw44QgRtLW2
         KYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r+qDlsKPSCKQY/zG9BINTYKjdoSZTdUbFRMuErF1lYU=;
        b=XuLu6f7ZzPMfFDpa4Ec9MqqQMU2i9eIPePwRIbW8xgD5CMHy5r97oxOYGIyLMhVk8F
         LntMPNNbSkaYJsmQzi2HgxnY1v5O8QadOcAouZi2DBDf5/yrf+3S94cEaJZMPF5owMbR
         JV3zrZ6tFAaUY5DV31ARfWiLgR5REVS3rWHRc4yZD3JiBASiXYTfQg67clXRAZNTBAi1
         BXYdOCBviCpfVL9cM7oUlJHqz3B+Jb9RZwRwigAGPt6Ps8zpNw/4Vol6/S+J2uOP6kgs
         /SIw4+rgBVTOsZ/7PZeKmATuyqsWSIQZ5cRQ4cgKGU+RWA2xDdgp4Cd1ajtBIucoz4kh
         IYOA==
X-Gm-Message-State: AOAM533E+XG8o2gW9tfk7Au3Cy5p6A0GCimp5dE7QaBKbxU+fXE832J2
        JhnnmME3RX4sApe158cTJDDY70qZTb9kSxSbsOo4hw==
X-Google-Smtp-Source: ABdhPJzrRYgBtAhZvltYy3xjy5DHraJ/qE2XjUnFxBdjlTNa12vaXGlXBm3D8pD2CSBBMNgvrKhfS9P+iewWHMQhtIU=
X-Received: by 2002:ab0:2b01:: with SMTP id e1mr14759059uar.85.1621427372596;
 Wed, 19 May 2021 05:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
 <xmqqbl9weabw.fsf@gitster.g>
In-Reply-To: <xmqqbl9weabw.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 May 2021 14:29:21 +0200
Message-ID: <CAFQ2z_MVEFpq5qJx_BwbborFmUeaGhRN4N4cN-yiS1xToEw1LA@mail.gmail.com>
Subject: Re: [PATCH 2/8] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 5:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> I 100% agree with you that errno is cumbersome to use and carries
> far less information than we want (we do not learn what operation
> failed on what path) over a long distance.  It only is useful when
> the callchain still knows what path was operated on.
>
> But...
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > For the copy/rename support, calls to lock_ref_oid_basic() in this file=
 are
> > followed by:
> >
> > * lock_ref_oid_basic (copy/rename rollback error path)
> >
> > * write_ref_to_lockfile (both in the rollback path and the success path=
 of
> >   copy/rename)
> >
> > These calls do not inspect the incoming errno. As they perform I/O, the=
y can
> > clobber errno. For this reason, callers cannot reliably observe the err=
no that
> > lock_ref_oid_basic() generated, so it is unsound for programmatic use.
>
> In the latter part of the above, "callers" refers to the callers of
> "the copy/rename support" (aka files_copy_or_rename_ref())?
>
> Then I am not sure why "callers cannot reliably observe the errno
> that lock_ref_oid_basic() generated" is a problem.  They will see
> the errno from the last system call that failed, if they care.  So
> their performing I/O is perfectly acceptable, too.
>
> Hence, I am not sure what change the above justifies, if any.
>
> If we can show that no caller of files_copy_or_rename_ref() uses
> errno, it is a clear indication that lock_ref_oid_basic() is saving
> and restoring errno for no good reason.  I think that is what was
> done for the other two callers below.
>
> So I traced what happens after the copy-rename thing gets called.
>
> refs_rename_ref(), rename_ref(), refs_copy_existing_ref() and
> copy_existing_ref() (all in refs.c) should be the only callers of
> the function.  All callers in builtin/branch.c and builtin/remote.c
> of these functions (by the way, refs_X() variants do not seem to be
> called from anywhere---are they over-engineered?) just die() when
> they signal a failure by returning non-zero, so I think it is safe
> and much easier to understand to justify this change like so:
>
>     refs/files-backend.c::lock_ref_oid_basic() tries hard to signal
>     how it failed to its callers using errno.  The three callers of
>     this file-scope static function are
>
>     * files_copy_or_rename_ref()
>     * files_create_symref()
>     * files_reflog_expire()
>
>     None of them looks at errno after seeing a negative return from
>     lock_ref_oid_basic() to make any decision, and no caller of
>     these three functions looks at errno after they signal a failure
>     by returning a negative value.

I stole your message here; hope that's OK. My original message tries
to convey that if you do

/* should return errno */
int a() { .. }

int b() {
   result =3D a();
   maybe_do_IO();
   return result;
}

then callers of b() can't reason about the errno result of a(),
because they can't know if an error code was generated by
maybe_do_IO() or a(). This means that the errno result of a() is
useless.  (This is assuming that b() doesn't inspect errno, which I
failed to mention.)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
