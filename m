Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF8DC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D0261431
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbhD2IxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbhD2IxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:53:01 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1FC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:52:14 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a12so16839826uak.6
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3QJOV0FfyDGHJXAUtBjuc4iG927t+/Ow+IbLOcIezc8=;
        b=JR2d4BjPkSu+u9twyKrrHSrkvOkUP5x+n6Rn+u/Mf6/N6zoTbzN7OLWEt1bu+6ImCN
         FNLc99LD98zJUtrVVYS+A7t/CkccN8bbSBTYb5E9I1S/krHXHojWd1U02fsfudXG4i12
         FhlUSxjHSkm8R6lmBypbrq2SdmLJSBHsP7w78GQ8jbaM7xZCXv4KWFyfh2twPeOUbrtY
         FrCF3omgETVvdzYnG+r7ZePFAv16rxSaOFfPIBfwMox/1ynFy8pVHlWalIFUXSph/3LZ
         toU1h6CBvZkyjCe/FIuVZK6oOw+RVDT6mSj12PBTquEo2OlapWJq5XnfeTKqj0I4vgPe
         gktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3QJOV0FfyDGHJXAUtBjuc4iG927t+/Ow+IbLOcIezc8=;
        b=Qc7/VSFaujZYSOtU3n4WsAnGPHyRpnoCvOY0qhXxEZJqHAT+baI5JHOZLuNmkb8dZW
         qeOYVa5p84tpQT2u84XSneBJDzD+9xpBG4nvGKzDVxEJmbPUVM/ZAPY5IlcrQassPvTI
         MQC0Bd9Atv/0eeEpzFq0x7DNxaT7zKVy2l5GotGA2gplEf6a1gpEDHbErX2EeVisVR49
         gZFiTab6BJWd1Ae39ULNLdf+riwz9rejFmGeN2Mhj5OayGIA8HNPi1pQDXds4KOiiKAk
         f8vNmnIwxM+05AlP9Pa2qF4JhK8uzs4nFmr0urP+233i+XNqFTIvss+YeFRYi2aDKkAa
         cQtQ==
X-Gm-Message-State: AOAM533LKuzkrhOSD8be334RytoDtY6pSbBoYh/YIFh+FJ0lThxqfBwp
        Eo395JSTfcK3M/24dCPm2ERUuc6k/FEEfOEbXq53YGExtW0=
X-Google-Smtp-Source: ABdhPJwp1CgiTJOuC+pPoeIAD1MdVdZpY1Y9g4/z8UNH4KPIN07OHvLE9LIGtb9/ttHgPi+CexXxS0dKqYV2MrIsixk=
X-Received: by 2002:ab0:4757:: with SMTP id i23mr6622937uac.87.1619686333222;
 Thu, 29 Apr 2021 01:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
 <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com> <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
 <xmqqzgxjavks.fsf@gitster.g> <CAFQ2z_O=4sUjh1wk6nRijp9Gz2eeqX4=EY+Q-OTi9ppb9ikg3g@mail.gmail.com>
 <xmqqa6pham83.fsf@gitster.g>
In-Reply-To: <xmqqa6pham83.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 29 Apr 2021 10:52:01 +0200
Message-ID: <CAFQ2z_OXicspXXicWAAGUv4TPXnZVBusueminRLH2+EUTjpzxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 3:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > On Wed, Apr 28, 2021 at 6:20 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> > These calls do I/O and therefore clobber errno. They are not inspect=
ing the
> >> > incoming errno.
> >>
> >> Hmph, are you saying that these calls do I/O and always the I/O
> >> would fail?  A system call that is successfull don't touch errno;
> >> only the calls that resulted in failure do.
> >
> > I'm saying that callers cannot reliably observe the errno result of
> > lock_ref_oid_basic, because it might be clobbered by a failing
> > follow-up call.
>
> Sorry, I still do not quite get it.  For example, you cite that a
> call to lock_ref_oid_basic() in files_create_symref() is followed by
> create_symref_locked() that may clobber errno when the latter fails.
>
> But a failing lock_ref_oid_basic() would yield NULL and causes the
> caller to leave, before calling create_symref_locked() and letting
> it clobber errno, and the caller of files_create_symref() can
> observe, when it returns -1 to signal an error, the errno left by
> lock_ref_oid_basic(), no?  I would understand it if no caller of
> files_create_symref() cares what is in errno when it receives
> negative return to signal a failure, though.

You're right; I didn't look carefully enough.  I did a grep over the
source code for create_symref() now, and couldn't find callers that
inspect errno; the same for reflog_expire().

I'll update the commit message to reflect this.

> And when lock_ref_oid_basic() did not fail, create_symref_locked()
> calls helpers that can fail (e.g. fdopen_lock_file()) and result in
> errno getting updated to record how it failed (this is also reported
> to the user via "error(... strerror(errno))").
>
> So a caller of files_create_symref() may not be able to tell between
> lock_ref_oid_basic() and create_symref_locked() which one caused the
> files_create_symref() call to fail, but in either case it should be
> able to inspect errno to learn what kind of error we got from the
> underlying system, no?

I disagree.  create_symref in the refs API gets an error strbuf_t. If
the function wants to say something to the user, it should use that
mechanism. If other operations are meant to provide reasonable error
messages, they should also get an error strbuf.

The files backend touches many files as part of its operation. If the
error is something like EPERM, errno reporting leaves no channel to
describe which file and which syscall is the offending one (is it
packed-refs.lock, refs/heads/branch.lock, refs/heads/ ; is it the
creat/rename/unlink syscall?). It's not a realistic mechanism to use
for errors that are meant to be understandable for users.

The errno mechanism is also poorly adjusted for alternate backends. If
there is corrupted data in a reftable file, the library returns
REFTABLE_FORMAT_ERROR, but what errno would correspond to that?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
