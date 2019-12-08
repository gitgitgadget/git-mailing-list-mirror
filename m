Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6A5C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957DB20663
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6CX0w42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLHK05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:26:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfLHK05 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 05:26:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so9805045edp.3
        for <git@vger.kernel.org>; Sun, 08 Dec 2019 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbAnnQEeRrE1HgGjbuUsL1aLXBk2ROrdiG4CLHzYiAk=;
        b=g6CX0w42rr9+ZLtn43/C9cGkZlgJH+dTCsyKQcXcVJnPMw/Jrqxd+3/I6P7Yq0AP6L
         hD+ZM93HON94mq4t3wN0wY8qBJT7jxwwiOc8xg+0EltaHe+abo6mMK9lhg821PoKVcld
         Jz2VTXPm8XXqtHg+pMh8rCh61pjA0wqlmz0EXqu4+NsjVFbHtKkCoEPU6JJNwASUiSwg
         V688nlARFqyt8umBzl/tN5jNDi6t9gmSILr7v5Fu98zqqvDNtDIioKYk3m8oGJAjWJ4q
         ZGdxzU8Iy/JZtd24heMTRvIW5jV6zzEWnWPfbOuKEQmo6zVs65ffJA5CghtAia7Tb3IB
         t4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbAnnQEeRrE1HgGjbuUsL1aLXBk2ROrdiG4CLHzYiAk=;
        b=KXShjrBpXLUpUwX8rMCZwXiuuVB07WNIqVgBGrJquNckEDj0KBlmRSXKaKnhc0TMWr
         Xu7aCxUZuWavp6M/lQmi1Cr4agxckEzS80nStS2rKp/NbngOKlpKytYwvrLecn/DB3v0
         QfcILK0s2p+2tJSSnJo2qNKiRs2IuKl9//e3GA0I5wvWeIaQpuDGEydcfthJJsIJgrMm
         hBnUUS4p22zN5bhBP0yk+35NQaspz6nK/zOhME5nIsrji1aF9jx3RVRPo9qLvK26vYWf
         0WUTkYtIkIpr3QNJQAhdd+T2oOJPybGlrub/+ngkeijin6MgNesAJ+08aQfzJ/k04vcZ
         4YGA==
X-Gm-Message-State: APjAAAUsMjaYRsrHQW6Et9jcDHZJrvcmND4PYFdR/I0Z1OxMLKxUQSwC
        +sMAABwzFHrBIrj9lVLlOAFv91b16CLwCfHxZCo=
X-Google-Smtp-Source: APXvYqwaNwJdUbxuOic0pe9kptuIxqDrbL8d+ZATlfgzqr4LSMKyG6GldJQjLmQZkjv1nPE50VOtHXUhtYi6dPqfo+k=
X-Received: by 2002:a17:906:681:: with SMTP id u1mr24540713ejb.81.1575800815210;
 Sun, 08 Dec 2019 02:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
 <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet> <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 8 Dec 2019 11:26:43 +0100
Message-ID: <CAP8UFD1fp_uaR5+=Hp24y4zq+rVuwfgiFntDtr8i3B7Bx4k-_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sun, Dec 8, 2019 at 9:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sun, 8 Dec 2019, Christian Couder wrote:
>
> > Peff wrote:
> >
> > > It's been on my todo list to upstream for a while, but I've dragged my
> > > feet on it because there's a lot of cleanup/polishing from the original
> > > patches (they were never very clean in the first place, and we've merged
> > > a dozen or more times with upstream since then, so the updates are
> > > spread across a bunch of merge commits).
> >
> > and then:
> >
> > > Yeah, I think we should work on getting our changes (including those
> > > stats) into upstream.
> >
> > So actually I thought that I was helping Peff on this, though I know
> > of course that it's also helping GitLab and everyone else.
>
> In my experience, sending the initial set of patches is the easiest part
> of contributing patches, by far. The most involved part of the process is
> to react to reviewer comments and to prepare new iterations.
>
> You can see this challenge in action in all the Git for Windows
> patches/patch series I am "upstreaming".
>
> So actually I think that you are doing a disservice to Peff: if he had
> time for that tedious part of the patch contribution, I am sure it would
> have been no burden at all to send the initial set of patches.

I think Peff can say by himself what he thinks about my work when I
rework the raw patches he sends to help get them upstreamed.

It's not the first time that I have done that and every time I have
done it, I think he has found it useful. Even this time he also wrote
that my work has been useful.

> > That's why I put Peff as the author of the patches.
>
> No, that is not the reason. You might think that that is the reason, but
> the real reason why Peff is marked as the author of those patches is that
> he really authored those patches.

That doesn't contradict at all what I am saying. I am saying that I
kept Peff as the author because I am just helping him, which means
that I actually acknowledge that he really authored those patches, no?

> In light of what you said, I don't think that it is a good idea to go
> forward by leaning even further on Peff. From his activity on the Git
> mailing list, I deduce that he is not exactly in need of even more work.

I think it's ok to ping people, even many times, when they have said
that they want to work on something but for some reason don't do it.
That's what Junio did by the way too. Junio just pinged everyone
involved, and then I pinged Peff specifically as I think the part of
the work left is more his than mine.

If Peff had said that he doesn't want to work on this any more then I
wouldn't ping him, and I would perhaps try something else, like just
ask for only the first patch (1/9) to be merged.

> Instead, I think that if you truly want to push these patches forward, you
> will have to dig deeper yourself, and answer Jonathan Tan's questions, and
> possibly adjust the patches accordingly and send a new iteration.

I think that it's ok to ping Peff until he says that he doesn't or
cannot for some reason work on this anymore. This shouldn't be a big
burden for him to say that, no?

> I perceive it as very unfair toward Peff that this has not yet happened.

I perceive it as unfair to me that you think that I have to do a lot
of work on this when Peff hasn't even said that he doesn't want to, or
cannot, answer Jonathan's question.

Best,
Christian.
