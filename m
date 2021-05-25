Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE42C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3209661413
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhEYGLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhEYGLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:11:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3BEC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:10:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso11918274pjq.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwMFRkd08hYGJNxL0YDwUBBfMFft4v30+uqSP5ULTzM=;
        b=fThZeSBApmFBMkwrlRxNTpcPQmpujz0y1j0QuR09C129upJPEvs6XwvsXgZSVdkAui
         DbgbUd8KehqGFOT202Rciuxxh+IIyzLfn8dENxDFFjm/8hwHwjnyHMCE8lC66D1tcc2A
         iEstjjg3TMeJjxph9A1X/Hw9YApn9sOMNGFIg2OwO6nnm3U9BY5gOipC0k7of9kptYe7
         GSafj7Q8NtTSFIcNHgncg9jijLUs9OuII2IqxOh0yq4SYQhlXlsFNZP72Hd9tw/EATf+
         pQ2K49p7mkaqmS5s+loYeExMKu38sYsdLvG6sbnr83ySiX9gp5C5PE3SX1Dia5Qhp3lU
         CIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwMFRkd08hYGJNxL0YDwUBBfMFft4v30+uqSP5ULTzM=;
        b=snDSYmV2FZT1gxBpKn/O9EbzmLkr3Z6uWy8MvaEuzkWAEEpu11GIuSVUrU8xL2f/4V
         Rm6j3SLbu944G4c0cEL9RKy5Mz+vSkr5RGDTcimuLfLPldOD7tocvgi7dQprChEwE8UM
         wVsG7vWxzyoilygvJpdISS0svG7vGHqmOcbIqB5L5heky5Echg/B6xUk5RSyRmcclzk9
         8uABe/s6gkvV1DYz4jpXRpNmw1JZBd/KCBh5Pf0eDsAe/LIYVjwCtV6VAF5MwmA0RI0D
         Uhpzc3EGizVNI8RvE3pqTIP640coD1OJ/ddxmQwO+HTsPrJNEht6zrqBEnf+pFKPNJd7
         24AA==
X-Gm-Message-State: AOAM531y3FNCvOnOKIlRgewjrEREZVw9FN9ErDp0eSPuykCiltrm0UdH
        zjfHmuBL4w0HSjmMkECEtPs4nhBzwDVtUhX35rJI1Q==
X-Google-Smtp-Source: ABdhPJzocYNUjv5+U5IzWFOsa0K16G1tZpACPIuG6sclcLu1tPoJZaGzzJ9kwKIuUGDivTkueQPlsbNKSNlwGY/QsrQ=
X-Received: by 2002:a17:90b:308:: with SMTP id ay8mr19729444pjb.19.1621923025369;
 Mon, 24 May 2021 23:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com> <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g>
In-Reply-To: <xmqqh7iripzg.fsf@gitster.g>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 25 May 2021 08:10:14 +0200
Message-ID: <CAG3jFyv716SC1wQUcQxCdU=J-W2hYo8=tA65VZ5jqmhpQ7G+=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the core.hooksPath
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey

On Tue, 25 May 2021 at 03:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > In c8243933c74 (git-send-email: Respect core.hooksPath setting,
> > 2021-03-23) we started supporting core.hooksPath in "send-email". It's
> > been reported that on Windows[1] doing this by calling abs_path()
> > results in different canonicalizations of the absolute path.
>
> I see the author of that patch CC'ed; the change in question
> explains why we switched from "the hooks directory immediately under
> $repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
> does not say why we call abs_path() on the result.  I guess that is
> because $repo->repo_path() has always been a result of applying the
> abs_path() function to something, so it was to safeguard the callers
> that expect an absolute path coming back from hooks_path?

I don't think I have a good reason why abs_path() was used, most
likely it was copied from some other snippet and kept for uniformity.

>
> And that makes this change dubious, especially as a band-aid for a
> breakage immediately before the final release, doesn't it?  Are we
> convinced that the callers are OK with seeing sometimes relative
> paths?  Certainly the cases the tests J6t fixed are not negatively
> affected, but is that sufficient?  To what directory is the
> configuration variable supposed to be relative to, and are we sure
> that the user will always invoke "git send-email" from that
> directory?

Previously this functionality was entirely not working, so I don't
think we'll have any regressions. With that being said I'm unable to
test that it works well on windows.

As far as what the expected norms for paths are within git, I really
don't have any answers.

>
> Puzzled.
>
