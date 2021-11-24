Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECCC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhKXLU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbhKXLU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 06:20:26 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7CC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:17:16 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id p37so4241131uae.8
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 03:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/MHQ0615yvq8V4wVF4bUMqeliM7YfAPD0nNBcOm8qWA=;
        b=bffVMHMfi3y4q0OqzoQO+PhmIaljWFHpnSWQv3jTiDFKRBNqc7Ww/vA6GHok0IoLAa
         Cmf8FYMPtUvTBrsZU6Ol7Mn9iamiSkwXUg1v82rmVALG3yPjEDIL211tGTVJ55uGaFz1
         2F/G4wvQGkxUJ8gL4KrKq2tpIDfkz6l/h+9sMETLo6mZl/FVuj7WXiZZ0uovR/5Z4z+0
         SHvbqM/BKLIqYoEqYprWDtj5aVAiFPEdK8XyDpVzuvPzCNAqJQSPyd13HTb81Q6IHDT1
         4PLmjdXupSnTLyIoQG6uz/6U7048226lBPD6d40ArxtzGlpfkbxWI5MDMRDR0RBEg1gN
         wHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/MHQ0615yvq8V4wVF4bUMqeliM7YfAPD0nNBcOm8qWA=;
        b=IArcCi7t437MsmLjDx7koxbkLm8Wg/QyejwvM3JrB3sCydNGNGVYRP56m/sNoqjiYS
         yclGaBW1bvS1U2BM8e8q8FaVqYEWyHpujVGlFVJ4ZC1hD4YCI6ty/WoNTZ551v5qwWo2
         y2WftKLlsrz94Z1+yHcvRE2N8A+bqQhURNBiujuRnAIqbfC6cFg5bnBDogxA3DmEuAbn
         08AUEUaR1oyMp02VTPlprvDB1KsJjEgA7N2QaMuNB83ROUuGWrVVNXY5PxKzYNdtBbHs
         wNFqY1yaEzzcw3b8v+zGn2BeW0NecSaraHB4VnVcU2O1udZXGo1tVRfDAr95jAvIYp0m
         tvBA==
X-Gm-Message-State: AOAM531gIaZ84w1heHskRdITN35VimXo6Gh7/O74J4rQKl4fzndA07Uy
        hPK8k9R2k4EAyjGzChEY9jgdsqI/ybJUiWLnLCqCIw==
X-Google-Smtp-Source: ABdhPJxLfyds1T9OruYr8WUaeyaBAkS6PrfeFkPZuizHOIEsdJouKVLnem5Xm2N1GB+Wyy44ENjc3jgTsgD81piQ8IY=
X-Received: by 2002:a05:6102:160f:: with SMTP id cu15mr21200453vsb.11.1637752635698;
 Wed, 24 Nov 2021 03:17:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g> <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g> <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
 <xmqqzgpu7grv.fsf@gitster.g>
In-Reply-To: <xmqqzgpu7grv.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 24 Nov 2021 12:17:04 +0100
Message-ID: <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > I'm talking about refs/refs-internal.h. It seems you want to add someth=
ing like
> >
> > /* The ref backend should add a '\n' relative to the message supplied
> > to the delete/symref/update functions. */
> > typedef int for_each_reflog_ent_fn(struct ref_store *ref_store,
> >                                    const char *refname,
> >                                    each_reflog_ent_fn fn,
> >                                    void *cb_data);
> >
> > ?
>
> Sorry, I do not follow.  Doesn't the ref backend already ensure that
> the message is not an incomplete line?  If you feed a single
> complete line when updating, I do not think the backend should add
> any extra LF relative to the given message:

But it does, currently. As of

  commit 523fa69c36744ae6779e38614cb9bfb2be552923
  Author: Junio C Hamano <gitster@pobox.com>
  ..
  - We expect that a reflog message consists of a single line.  The
       file format used by the files backend may add a LF after the

it is the job of the files ref backend to add a LF, and the input to
the ref backend is a string without trailing LF. But the files backend
then produces that message with a LF, when reading back the data, eg.

$ git --version
git version 2.34.0.rc2.393.gf8c9666880-goog

$ GIT_TRACE_REFS=3D"1" git branch -m bla blub
..
12:03:59.408705 refs/debug.c:162        rename_ref: refs/heads/bla ->
refs/heads/blub "Branch: renamed refs/heads/bla to refs/heads/blub": 0

$ GIT_TRACE_REFS=3D1 git reflog show refs/heads/blub
12:04:23.277805 refs/debug.c:294        reflog_ent refs/heads/blub
(ret 0): cd3e606211bb1cf8bc57f7d76bab98cc17a150bc ->
cd3e606211bb1cf8bc57f7d76bab98cc17a150bc, Han-Wen Nienhuys
<hanwen@google.com> 1637751839 "Branch: renamed refs/heads/bla to
refs/heads/blub
"

> I think the rule for "msg" is that:
>
>    a multi-line message, or a message on a single incomplete-line,
>    are normalized into a single complete line, and callback gets a
>    single complete line.
>

That is not how it works today. The files backend verbatimly dumps the
message supplied to it. (Maybe it should crash if there is a '\n' in
the message).

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
