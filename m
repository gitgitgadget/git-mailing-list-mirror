Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE63C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 22:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiGVWqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 18:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiGVWqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 18:46:34 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA6AD
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 15:46:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31e7055a61dso61349927b3.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2a4AYwLij4bP7qSPKJzeDcCLxAJ7NBx2ZnmNl5bS6tI=;
        b=q47zrm68TJRAkk8cM/7dH4W/xn1v7FYfHB3AK/1kcjkhH/rFbifD9+xyr9UBRM78G7
         sRF497pSgTjbx8EzVLJ497EXAqllY7+UrA+doVG5jQTrepqBDX4DY1kAFmc6zGvIY4pL
         64Ke0GxWmoWt8FcWPVUK37eKEfQTPSLSYgSylPVYI/K1mIKcs4HEZ3Fscm6I5yIHqn7s
         ggt35fjxBuFuTu13TGOSlN4keuu2nKQ6LkrxxQ4/EomI4IBIYbFUtFXetrkUZkxAvBDf
         Rj7feHGAn2Pprgi1L61tXC5r4XhOIQEEry7hxVEecALr2Hy9RYyDZE+VMJITtj8FkebA
         6TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2a4AYwLij4bP7qSPKJzeDcCLxAJ7NBx2ZnmNl5bS6tI=;
        b=I9XIiMPadHdFHBUMZf4RUXIoRJITSYeuhEpwnXqgIM41aOFMSkfMo9ur1pBrCjOQVK
         yN2IGMJIzeys28+nATuHzV8ntflFbwKExfH9t68y9ifz+LpLYNf78zNOzW2w6OWv8TpF
         Nc9Ex1z1h5bdW1BMNqK8VlGjTvG80frSqDbHCY8gXXfWm9jn3H14AqLgQmg0KUepwMnW
         m4dYQgaM9UWj8D2C5vkF0yHWzvaY6212ues4DasOWni4jhaKuDVOP9lNXGLrqB4SsJj9
         9xJkitvr4yP00wh/si0b3EKArOC9wBpS+G3OZoN8ryWdaQYx3tbBRkN4BZ2AklRkxr2u
         f21A==
X-Gm-Message-State: AJIora9ieBJXJ/EZXV/Ta8C2z0M2lt4oe98beuLhYJZwujN2Iz4UpBhq
        sRSBE+SIKY6BiifTCUFftpbc8AL5wJa5Wki9vnQ=
X-Google-Smtp-Source: AGRyM1v5bPfrg9djkClkBqZp32gCkZoKNetvehxb44XLY4tHyEKAbEi5pDj4N15CwUtHSqGGyat5+2shqejiuDMdTj4=
X-Received: by 2002:a81:7d55:0:b0:31e:6f02:30d4 with SMTP id
 y82-20020a817d55000000b0031e6f0230d4mr1854579ywc.375.1658529992875; Fri, 22
 Jul 2022 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email> <20220722203642.GD17705@kitsune.suse.cz>
In-Reply-To: <20220722203642.GD17705@kitsune.suse.cz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 22 Jul 2022 15:46:22 -0700
Message-ID: <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
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
>
> Thanks
>
> Michal

Rebase is typically reserved only to modify commits which are not yet
"permanent". Once a commit starts being referenced by many others it
becomes more and more difficult to rebase it. Any rebase effectively
creates a new commit.

There are multiple threads discussing renames and handling them in git
in the past which are worth re-reading, including at least

https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.o=
rg/

A fuller analysis here too:
https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osdl.org/

As mentioned above in this thread, depending on what context you are
using, a change to a commit could be many to many: i.e. a commit which
splits into 2, or 3 commits merging into one, or 3 commits splitting
apart and then becoming 2 commits. When that happens, what "change id"
do you use for each commit?
