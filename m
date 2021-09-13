Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C4C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9B5603E8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbhIMTay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbhIMTax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:30:53 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1135FC061760
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:29:37 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f18so4494898vsp.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsiVlXGgbcn3BkXrV9IA9WWxzh+gS4xcdcByJwK1VFU=;
        b=KeffpHLORBf1linnsaiDQnQArAFTxlnbRwI1GUGIyRjDOeBc+HqukEUZYV23wA2/OP
         RT9b+VXWifHZMz/2JSaX597ZDnB9X+Vx/00D8KE1orlyJI0teDI3drpJ7l+cw9x6NPdw
         zoJT1zGufZ75iFgu9PY8umEosxzkeR75IJEHJJzwExZ4Wm/oEiZI5GYgAwKd+8z41wS/
         qAjIUTiyr5tC6+EyIPZQaV+9+ZG6ssqNZVUlo5OxPx44s80iVo+ae9HZquUuE/1/mnY6
         hmYJt7F+f4ILda9gmSW4iwnCz496iswDwj+xcDH9oJ7AdCq0nWheynnuy62J4V9+E4Fl
         ew+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsiVlXGgbcn3BkXrV9IA9WWxzh+gS4xcdcByJwK1VFU=;
        b=YJigvpbvyCIcldQzlC2xRV+Wyk0kT1pd78i7KmmQAPuUC0Eiz4iGf95oh6KsAW1QCn
         X9gVH7VlkidC/G1jN84XhMbxzSsw+M6QSBVgKQ9A0lAoz6jc67HGg2rQcY4ffYbU1j1U
         fUeK+bEfszeSjw9wGIrkkJYcY+3K0jPWY6WAxDmTeK/vxI2+Y6OxZI3CEAyYk0IUxkv4
         8g6EQtUsXF2E9ntpft+BgAI/1ahjdKmKsip6fLrT1/3+ndiVI53uJVvU/RzA0T/GBBQG
         YqGsKK38Quo2Baaa/csu3+VzcRI4lXXLfcj0NQYJpQn5Y4RFN67VHhbX814lt3L+k9dd
         VChg==
X-Gm-Message-State: AOAM532SajLt0FrM8KZg9oZUbZr0Pw7KCMr8Iasdl6St4vnC764QORjL
        /Krr2DiK7Yexz2wCin+mfHA/wa+uMITB9ScTc0I=
X-Google-Smtp-Source: ABdhPJxnHmJc6XXb1kurEc3RFXMzRJlZIEVOwbiyII+29Po4+jAQv+PQdhVDj7Ls+RC2evuPxcQ7VHeOYFYzT8H4J+w=
X-Received: by 2002:a05:6102:1d4:: with SMTP id s20mr3044902vsq.3.1631561376050;
 Mon, 13 Sep 2021 12:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com> <xmqq7dfpxzfw.fsf@gitster.g>
 <CAFQ2z_Pa+KmCYV224XwMXO1iFCNA=PXj5iKaQU3LYGYTK_+qsw@mail.gmail.com> <xmqqee9sfhuu.fsf@gitster.g>
In-Reply-To: <xmqqee9sfhuu.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 13 Sep 2021 12:29:25 -0700
Message-ID: <CAPUEsphPvtXymQWExXqJqn6U1TiWx=u483oNODPZuL5pRubveg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:30 AM Junio C Hamano <gitster@pobox.com> wrote:
> Han-Wen Nienhuys <hanwen@google.com> writes:
> > The code has a different style because I wrote it separately from Git.
> > I'm not wedded to its current style, and most styling can easily be
> > changed. If you have specific things that should be addressed, let me
> > know.
>
> The question was for other reviewers to help us come up with what
> the "specific things" ought to be.  I saw style differences around
> comments and code formatting (everything I listed in the footnote,
> plus, // comment which I forgot to mention) which may or may not
> turn out to be part of that "specific things", because they do not
> break compilation.

they will be flagged by the compiler in pedantic mode when in gnu89 mode though

  reftable/stack_test.c:49:1: warning: C++ style comments are not
allowed in ISO C
90
     49 | // Work linenumber into the tempdir, so we can see which
tests forget to
        | ^
  reftable/stack_test.c:49:1: note: (this will be reported only once
per input file)

and are probably an easy thing to fix

Carlo
