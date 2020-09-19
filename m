Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DEC43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC30C2100A
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxWatDWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISIMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISIMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 04:12:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70873C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:12:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j2so8204598eds.9
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxdbkUsMwa0KeIsGrGxZyG/r7olMzkXxS9Ql6mErBPs=;
        b=mxWatDWM6qScuPXt5F1FbJbowNyoZf7Z6Hhq1SM1S+oviVVp/8KfOM65FzG5xDcyb6
         GkjrmtVssFNWaj95AY6TBUxWUlApCiaY9yfyucaX0pirmPPlhoDDFINrInQqntahfjNO
         f+4KNFUAMZ/rQ+GYnLwy2VUBhiVAByl6KljmtCDGIkbBTkBKUkLU5BSHbz+AaLkSFJg1
         RjAGpLYwAGuhy6q4D4S9qdLUgPKdjoO3UXgtGV9Z8XLMhVKbQZxnO2sW0gRDRwYCZ/5O
         75+AO/ruBqUEbpeJfN0zRtyqPwpVNKiCSWoBF+5Tg+XFy3v0dDDspPq3nicFxh3hF9QK
         qBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxdbkUsMwa0KeIsGrGxZyG/r7olMzkXxS9Ql6mErBPs=;
        b=gwGOf5BaOWVeaSvIVnT62o00SM6XxatauFXfYZAx3YsByUdFKYaoDtqHZg6GzekX1X
         FkLos1ZjC+R4Rm9TW17ee7FAKaATbfELR1bYSxMmXW5gBzersywlBvzZhKs4AciA0qNy
         BvP6YJaHXT+ksJB43eVZshH4o+7EoeG9YNhrnJFcBsbawi1+/9fYddWQeQjvfiYLv0yB
         m9EMQoicfuHjBBMq8wyJWPi95JJJ+dmUjKxyaoyGa8JPe+cSu4oRywzXIRkXmBPnyfBc
         Hdc/XadD0fv8AXuPvvQZ9/z0t+Hwpj5zOWXBPbcvAy9QuSJ2WRRUfHStehlEXLQ4zRDO
         14sw==
X-Gm-Message-State: AOAM533ZSgS1c76akI+y5yLVcNzdcIqQ1p5B2Q32XwSROr6CMlV5M62A
        NRp1hwwuq2S3hDOwYGwnTE6rNbSVhqqmKrQTH9k=
X-Google-Smtp-Source: ABdhPJweN7LwZfoql8qPKTQUZuat11Ou2mvex6fVkuyGNWyj0A9ESiysXPn2AA85RCJXoZIGfv7eDvNqSzvhoQvCjNY=
X-Received: by 2002:a50:c8cd:: with SMTP id k13mr43134020edh.387.1600503169882;
 Sat, 19 Sep 2020 01:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com> <20200901125119.GA3250129@coredump.intra.peff.net>
 <20200903054126.GA2053272@coredump.intra.peff.net> <20200915173529.GA2859918@coredump.intra.peff.net>
In-Reply-To: <20200915173529.GA2859918@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Sep 2020 10:12:38 +0200
Message-ID: <CAP8UFD3NxmBDDr4yqhOjmdUNVZYe6w4vW-TnqbkUO_zuFvKvpw@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 7:35 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 03, 2020 at 01:41:26AM -0400, Jeff King wrote:
>
> > I'm still working out funding details, but in the meantime we're signed
> > up. Potential mentors should propose projects here:
> >
> >   https://www.outreachy.org/communities/cfp/git/
> >
> > Sooner is better than later. We can technically submit projects up until
> > the 24th, but student applications are open now, and have to be in by
> > September 20th.
>
> [Adding everybody to the cc list who has been in the Outreachy
> thread this year...]
>
> AFAICT we still have no proposed projects nor signed-up mentors.

It seems that we now have only the 2 projects I proposed and only 1
signed-up mentor (me).

It looks like Jonathan and Emily are reaching out to the Wireshark
community to find a co-mentor which is great! So we might have another
project and the associated mentors soon.

Outreachy organizers have extended the mentor project submission
deadline though. The new deadline is Sept. 29, 2020 at 4pm UTC. They
also say that this deadline is a hard deadline, as the contribution
period opens October 1, and they cannot add new projects after that
date.

> Interns are actively applying _now_, so we are likely missing out on (or
> have already missed out on) applicants.
>
> If you're interested in mentoring, the time to propose is definitely
> ASAP.

Sure. By the way if you are interested in mentoring or co-mentoring,
then signing-up is not definitive, you can always decide not to mentor
at all later for any reason as long as an intern has not been selected
yet. (Intern selection deadline is Nov. 9, 2020.)
