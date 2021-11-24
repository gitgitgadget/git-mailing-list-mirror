Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0466DC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhKXTm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhKXTm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:42:58 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD64C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 11:39:48 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id ay21so7369298uab.12
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IBSKJlO4a4rgQ3+jDkbR/c/NdgTS25ynCIdT4Y3neh4=;
        b=o3yr7xQvDXcFG4nG6hRWDOCjUmdiF0fcxJRBPP9YycXY/swCarVmIS74LgZclnM/ii
         Rc9Yt/EeRG1aV8Rnnf3U2C/lKALtYEmyTazDOgsSOnWaZZCkzyTvxbmVjy463amy/DTC
         f1DhE/Jj7ZmFDGCm39cWal3hJmTpIBqbRSi+k9oIqs/EMkLs+1mJp80drBoxrSmjH/IG
         Ipp+sw5RR95TJqNIoM+ys8Vg4a8bOOZkrrm6CGLs1GOK2B+F+ZYf2R4Gj3TAsZV0+Aqs
         69qY6piVZYhLVz9caaDof8zCS7wr6QyoxG17hY5ppgBwE71bvS+RyZUZrnnJAZ5NIXx2
         ihew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IBSKJlO4a4rgQ3+jDkbR/c/NdgTS25ynCIdT4Y3neh4=;
        b=cwTxWlZSOUDnO5A7z4PfP6Bs+IzdYsenMW2vxYPc/4aTkeoeyhqXOEvBqtFbJHLpwy
         N52jQjJ9d2vVX4HR0bn5qLX97WqfNDA7OI+gu8hJ/Zoce/sdbAtyabuxEpYf3Id/d7E2
         UEzJGv7VawOTGeu4UOqGPzLnCfFmFAjQspU0mAJHUTEmYJEThPdT2qWyiD+8HMFst651
         Hy6XibNUwrsELrjEgnlf8PHHsi33ossVIgBH+lIinXZa59qEtlq11iJKMZTB5OCZzjUd
         TbUtl0NeRYIoyFFtW+fgyVhZWei+uFSvGTFDvZvLpmOZNEwFoV6/aeD3pd3ACjRxH3lZ
         Inqg==
X-Gm-Message-State: AOAM530zdCnhMEPyWaL9aXUJhJ9GaVAjQIvI0kUUPsbZawztGfjNHfl5
        ynzANr7E4HRDZq+60TecDtPKkB5jAqcc7roMCn9q6G5KZyc=
X-Google-Smtp-Source: ABdhPJytK0IQ+VTEbz+SbZz7WaUC15/60HT+DbSes0g/9tTqHpdm8FQipuw/q4cOiqQrvHuwlSE3g1PLYpHKO+LOPK8=
X-Received: by 2002:a67:c40c:: with SMTP id c12mr28097594vsk.16.1637782787829;
 Wed, 24 Nov 2021 11:39:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g> <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g> <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
 <xmqqzgpu7grv.fsf@gitster.g> <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
 <xmqq1r352w3g.fsf@gitster.g>
In-Reply-To: <xmqq1r352w3g.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 24 Nov 2021 20:39:35 +0100
Message-ID: <CAFQ2z_P9XkXruBeEPd77cMF7BanzgmMF5CocxNj_JMmXVMeqaw@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 8:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > $ GIT_TRACE_REFS=3D"1" git branch -m bla blub
> > ..
> > 12:03:59.408705 refs/debug.c:162        rename_ref: refs/heads/bla ->
> > refs/heads/blub "Branch: renamed refs/heads/bla to refs/heads/blub": 0
> >
> > $ GIT_TRACE_REFS=3D1 git reflog show refs/heads/blub
> > 12:04:23.277805 refs/debug.c:294        reflog_ent refs/heads/blub
> > (ret 0): cd3e606211bb1cf8bc57f7d76bab98cc17a150bc ->
> > cd3e606211bb1cf8bc57f7d76bab98cc17a150bc, Han-Wen Nienhuys
> > <hanwen@google.com> 1637751839 "Branch: renamed refs/heads/bla to
> > refs/heads/blub
> > "
> >
> >> I think the rule for "msg" is that:
> >>
> >>    a multi-line message, or a message on a single incomplete-line,
> >>    are normalized into a single complete line, and callback gets a
> >>    single complete line.
> >>
> >
> > That is not how it works today. The files backend verbatimly dumps the
> > message supplied to it. (Maybe it should crash if there is a '\n' in
> > the message).
>
> I still am puzzled what you wanted to illustrate with the "git
> branch -m bla" trace.

I'm trying to illustrate that (from the perspective of the ref backend
API) one call inserts something without a '\n', but the call that
reads the info back, gets the same data back with a '\n'. It looks
confusing and inconsistent to me.

It seems fine to decide that the message should always end in a LF,
but then why not do that in the normalization routine, so it is shared
across all backends?

For the purpose of the debug support (GIT_TRACE_REFS=3D1), I would
rather prefer if the message was always without LF, because the LF
ruins the visual of the debug output, but that is a minor concern.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
