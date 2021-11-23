Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39017C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhKWVQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKWVQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 16:16:50 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4CC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 13:13:42 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id w4so378648ilv.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rx8TEGcY3/a/440EUttyd0cD0qCXax5kRxLRw4Dwf28=;
        b=K9jnNjcAzPOuhN6vSJKstxRC98cmVhkq14EXMnNE7o2tIsfg613jZPlUaj/bD0P1AC
         ZJLGCHPbYCY15lbHCBro3vjLmHX1q9slqedTkcUrpDONeQORdHcTwCKso+NOy3pWisos
         k12OHXaJOfnbz5yFPDOGur+qcWFATjiO9C1x9iUmjMD403qkJpfVTaYLFHW/JlkUPwTa
         BUsnyu6uUuGPfOkr4tnLrk4sMZRaCwvDUPRxE4a7W0WnpF3uKKmzZD4HvO8VFSm6rPkZ
         +QtA3fWSKxTkBs0DApmXJGfAwDesdMicYYIjSzcMNhH+Ic0AQDpA3dnY+uSonVNiBpIJ
         gfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rx8TEGcY3/a/440EUttyd0cD0qCXax5kRxLRw4Dwf28=;
        b=zJlDZgi+Niy1MoJOHs+Oa710Bb9Gs6/1/gclBoTaxkK5/x86crqcQBfWBjPg7bTuke
         0OjYGLnAoYLiGGhV8+A0yIWw7TyKDSPA/b1DwhaU1I1mXIrxItG53EBEOsiMb9EM91pA
         sq6iUe/cGxA2BBc6hUDtxc+xjRfoWWxywrdkcPdVu51uLCCFRDt+axg5YkIvqPzQD7YY
         Y/raq66lC5EMK5ZjRyXzC5qQ8ucVtjxWwBeKmZjhyzynydjO4wRBx04JmD0hgeP451k/
         IxQKBKoFG3apnSZXNoWb4DWs178vA5Huc6t0LnXAvJES4DYdOo2GVLdTEVzwp0OZQd8z
         Nvhw==
X-Gm-Message-State: AOAM533PjCpkRF7BQNuBKb6K8NQaVFX1UFKtV1S4agURNwILGuNXGKj4
        WjEqE3W9ah3V9v9RbWIoCPgS8cClfwWpHuDK+wA=
X-Google-Smtp-Source: ABdhPJxNknnA50Y8O4yFM+ZHimGeXQlobjTCUMis/c8jmnsQDKZeIncDq7f7CK/lTROQs0o25IMFWWGDLwXQ2hAFv4I=
X-Received: by 2002:a05:6e02:168c:: with SMTP id f12mr7624521ila.277.1637702021184;
 Tue, 23 Nov 2021 13:13:41 -0800 (PST)
MIME-Version: 1.0
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net> <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
 <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com> <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
 <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com> <CAPx1GveHusi8n8n03hUwBu6B3=_j0ZY6FWXWKDs8mLGwHEN-Qg@mail.gmail.com>
 <xmqq5ysmnxnx.fsf@gitster.g> <09cbc27d-8fdf-ed84-716f-23fd8dbb11de@iee.email>
In-Reply-To: <09cbc27d-8fdf-ed84-716f-23fd8dbb11de@iee.email>
From:   Danial Alihosseini <danial.alihosseini@gmail.com>
Date:   Wed, 24 Nov 2021 00:43:29 +0330
Message-ID: <CACLOEFYoqDsAhhHEMGXvtrkJLSpKdj8Rp1WtoBrPtJZbZN-s7Q@mail.gmail.com>
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
To:     philipoakley@iee.email
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  * Git opens and reads the working tree directory.  For each file
>
>    or directory that is actually present here, Git checks it
>
>    against the ignore rules.  Some rules match only directories
>
>    and others match both directories and files.  Some rules say
>    "do ignore" and some say "do not ignore".
>  * The *last* applicable rule wins.
>  * If this is a file and the file is ignored, it's ignored.
>    Unless, that is, it's in the index already, because then it's
>    tracked and can't be ignored.
>  * If this is a directory and the directory is ignored, it's
>    not even opened and read.  It's not in the index because
>    directories are never in the index (at least nominally).
>    If it is opened and read, the entire set of rules here
>    apply recursively.

> I do think it would be sensible for Git to read a `.gitignore`
>
> that says:
>
>     *
>
>     !a/b/c
>
> as meaning:
>     *
>     !a/
>     !a/b/
>     !a/b/c
> That is, declaring an un-ignored file within some ignored
> directory should automatically imply that we *must* un-ignore the
> parents.

Thanks, Chris. Yes, it mostly makes sense to me too.
I think this will better describe the gitignore behavior.
However, checking the indexed files at first may enhance it.

In addition to that, there should be an exception about negating patterns.
For example, for the "!**/file.txt" pattern, it might be tricky to
re-include all possible parents of "file.txt" files. You have to
traverse directories to reach files and find out which parents to
un-ignore. Any negating pattern with "**" at the beginning or in the
middle of the pattern can make trouble.
The existing rule which states the file cannot be re-included in case
of ignored parents may help to prevent this.

Thanks
Danial
