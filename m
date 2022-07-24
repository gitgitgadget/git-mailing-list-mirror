Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A206CC43334
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 05:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiGXFK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 01:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXFKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 01:10:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78DBC15
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:10:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o1so6400569qkg.9
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 22:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ktSwPSQ3GzHzNf36ccPT3FdKJCrz6HYftae6os0BBms=;
        b=h5HuH3ge0UAu/NzcC999QuYrXw4U9kceJ3g+xsx1Rt8chDZS41WtvrZ6WLVKIFriBu
         f5sK82wXgOXrLVq4D457L7sE65AJl6PMh2Fk9eqmLv/RCJ4lIjmHQrKTlQhqPv/KDIpD
         E44YXJN5g6xrucICAyHgzSfo7ukWoAISb5y2es440nTLG+67gy0ebz0iEyahAuebEjG8
         qenU37bo0dTQ/VpUjkF8dcDhb1aR1kPbGJfGh/kj7PIAdfAHpg50FQw9vfcxV+Z0PV59
         ZFAdXHeRDa+LpOzLOFpDHgnHGUAxr7ES4RRAQx5F8oNdG/QAhcNkbLZUWYwC/eucNiHL
         CnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ktSwPSQ3GzHzNf36ccPT3FdKJCrz6HYftae6os0BBms=;
        b=sF1fFR9iAFXrjvvTwSXh/C8qDDwVJHMWUqkR6iNtuQo8Sfo8PNxEE3W+I1+mB7poZD
         Y7Dp2vMins2IP48xjQ3megG4c6o9oI4tfOcpL6E5jKkzasLFCVfvzTeDZM232e7nEWzg
         CV/i90B+qhSxsCVY3i7lCzmayecUj1YO0fbgCI1sMW0TzBnev6LNfNGVnkReQdto8ttS
         Z2MOMIXiDdqNmNdQyqUw8eGnZ12JreTuHruwvkI6o4OKr0TDUa7pLCCreuIA6nCrzXUh
         ITweWejXwgkhD3NKfJz2d3EG8HGNdcLc67HTBdvOYkbojJDBt6mnSgu0khFD9Fxs+jO+
         4OVA==
X-Gm-Message-State: AJIora//GrPv01Hqgtp9qJugd9OGefY2gZlaaeM/RF4QJCbcUZLYdiK7
        MbfLDgIbXf/uxp6m66oOCPfqOuQ5MRwfeY0YEWg=
X-Google-Smtp-Source: AGRyM1sa1T9VuRKZa+U6fZrrF2VAh10EletacPkD6heFiFI6+aYeW+GJbdYCQ6FiDkKJ5u1F3hLtHbDW9BpiIBoi9bc=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr5200419qki.183.1658639422041; Sat, 23
 Jul 2022 22:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email> <20220722203642.GD17705@kitsune.suse.cz>
In-Reply-To: <20220722203642.GD17705@kitsune.suse.cz>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jul 2022 22:10:11 -0700
Message-ID: <CABPp-BFGLXRvwZGdF543me2qBXq3HB-TuzW6j7GVb6ATw3qNeQ@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 1:42 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> > On 21/07/2022 19:58, Hilco Wijbenga wrote:
> > > On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wro=
te:
> > >> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
> > >>
> > >>> This has come up a bunch of times. I think that the thing git itsel=
f
> > >>> should be doing is to lean into the same notion that we use for tra=
cking
> > >>> renames. I.e. we don't, we analyze history after-the-fact and spot =
the
> > >>> renames for you.
> > >> I've never been a big fan of that quality of git because it is
> > >> inherently unreliable.
> > > Indeed, which would be fine ... if there were a way to tell Git, "no
> > > this is not a rename" or "hey, you missed this rename" but there
> > > isn't.
> > >
> > > Reading previous messages, it seems like the
> > > after-the-fact-rename-heuristic makes the Git code simpler. That is a
> > > perfectly valid argument for not supporting "explicit" renames but I
> > > have seen several messages from which I inferred that rename handling
> > > was deemed a "solved problem". And _that_, at least in my experience,
> > > is definitely not the case.
> >
> > Part of the rename problem is that there can be many different routes t=
o
> > the same result, and often the route used isn't the one 'specified' by
> > those who wish a complicated rename process to have happened 'their
> > way', plus people forget to record what they actually did. Attempting t=
o
> > capture what happened still results major gaps in the record.
>
> Doesn't git have rebase?
>
> It is not required that the rename is captured perfectly every time so
> long as it can be amended later.

"so long as".  Therefore, since it can't be amended after the commit
is accepted/merged, it is required that this auxiliary data be
captured perfectly before that time if it's going to be captured at
all.

Did I read that right?
