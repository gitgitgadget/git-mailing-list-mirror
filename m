Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D89C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48556138C
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhFBHva (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhFBHv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 03:51:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638FC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 00:49:45 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z15so602877vsn.13
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJZ8WSKWgfEv/+mgYpKkIpFCqzSAQ7O4gzX3AguEae4=;
        b=iyCeSb+S1wVEcWlzo5JKEuRw1qmidnSecTnhjNqu3ke889pXKtddYhdRiTYjnW5B/w
         j91D4wYdVh/xofCmD3G0T5xbEn28+jb+wPxKY/CaD1urfrX1T8mNi7f9pWvRB2V6x0hR
         kUNOktt2sxZJ4gZ8GA3vZbY7vXC/U4dggS+l7mqv3uBExWjLXs19jzGxj8AwDZKnFiDM
         cLgzBd9lIg8JJOw6AR8Vre/xTQPDjHLaXhHNjSBtTtacVkOUne+8ipOhx5gIPC5sg05i
         mA+WHuD1DdAWz75huHr8/F5jW6XwCwNEhDC/EuNT6EKxYe6oIlfy2yHthmOUUz+NcsOs
         x16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJZ8WSKWgfEv/+mgYpKkIpFCqzSAQ7O4gzX3AguEae4=;
        b=uFjwl1maYRNp922o4X2E0LvOFJlyuyeSranO/komgYmt0l7b8s2bNxtS1IPCpV0uRS
         T2Ltxp1ehCXuDxG3Z9/M+MkICyW9Jz9Co4IzDpaTCAqCQkAqVct8zZN5NVA8ME79H/4W
         G/16Cnah+MHV6CRtyioizqlI7frHA13evK7YpSIEd196TM1+CaPeHhp5gXqiwoWGvjq2
         FUOzqrJ6Q5Q/PukuO8B0s/TZ+nQRq+gztOhBF/Jz2FBTZjrwK6auOwA7CQtPQZWJY3Fz
         xnrLR0ck8p4vxFF9FBbZcwA5n3Z7/Z+1PH92Amjcz9SQUiX0DFe711uz0Eczb+KTXc/r
         NOQw==
X-Gm-Message-State: AOAM533AvUnkXsmkDcG1RGPJoC7QIXSQLvqTtAuowRH7aHZMTdSI1M6y
        bRhli5Lb+3IpfwVmh6TbmTiEREZr22y3llrVMb2zV/WktJo1Qg==
X-Google-Smtp-Source: ABdhPJwJaWtH5mdOaNgLOykNb7WXFlkyrSNJE2ElX4a5FHn1p4EuIVQzTBK8o25IixubJ9YJRN+AcDM6kkMpnqVrnqc=
X-Received: by 2002:a67:b24e:: with SMTP id s14mr1462082vsh.28.1622620183908;
 Wed, 02 Jun 2021 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com> <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
 <51a802ff-0789-4051-6d45-5b9c6e55ba8a@gmail.com> <CAFQ2z_O2t2cDvTs0aNqB+9FVSy51CKrJxxdvu9WGg1s6gZziHw@mail.gmail.com>
 <xmqqeedls4ak.fsf@gitster.g>
In-Reply-To: <xmqqeedls4ak.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 2 Jun 2021 09:49:32 +0200
Message-ID: <CAFQ2z_N8L43KeWTr76Noschxi6jPdjWt_k_0EJthE51+vhb4Mg@mail.gmail.com>
Subject: Re: [PATCH v3 07/22] t1413: use tar to save and restore entire .git directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 10:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > On Tue, Jun 1, 2021 at 6:55 AM Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
> >>
> >> On 31/05/21 23.56, Han-Wen Nienhuys via GitGitGadget wrote:
> >> > diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
> >> > index bde05208ae6a..934688a1ee82 100755
> >> > --- a/t/t1413-reflog-detach.sh
> >> > +++ b/t/t1413-reflog-detach.sh
> >> > @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >> >   . ./test-lib.sh
> >> >
> >> >   reset_state () {
> >> > -     git checkout main &&
> >> > -     cp saved_reflog .git/logs/HEAD
> >> > +     rm -rf .git && "$TAR" xf .git-saved.tar
> >> >   }
> >> >
> >>
> >> Why do you do rm -rf git directory then extract tar archive to reset?
> >
> > I'm not sure I understand your question. Are you asking why we have to
> > do a reset, or why we'd use rm + tar? The rm + tar restores the former
> > state reliably, so we can be sure it is correct. It's also independent
> > of the storage format details.
>
> I think a short answer is "without rm -rf .git, a stale file in that
> directory will stay there when .git-saved.tar gets extracted", but
> the whole arrangement makes me worried what would happen if somebody
> manages to interrupt "rm -rf" without killing the whole test
> framework (or letting the when-finished handlers run).  The test
> framework thinks it is working in a throw-away repository but the
> $TRASH_DIRECTORY that was supposed to be removed and extracted but
> failed to do so due to interruption in the middle may not look like
> a git repository, in which case it may try to do the usual repository
> discovery and trash the git project repository instead.

Similar problems could occur if a developer is trying out a change to
the Git source code and makes an error. It's also easy to mess up the
check-out by doing a "cd .." too many in a shell test under
development.

I don't understand why the temp directories for tests are inside the
source tree. Every other project that I've worked on uses mktemp -d
for temporary directories instead.

For the problem you describe here, using atomic rename won't work,
because we want to swap out a complete directory. So we'd need a
command that replicates a source into a destination tree, using atomic
rename. Maybe rsync --delete might do the trick, but I don't think
we'd want that as a dependency?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
