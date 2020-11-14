Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5B1C4742C
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D83A2225D
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuMKrWoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKNAZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNAZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:25:44 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF2C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:25:44 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so12058933wrc.11
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4Rj4rseHNHkeHaLRW4sErEFZTvVWLtAsfI1VdmQXZU=;
        b=CuMKrWohdar/xCazsfYuu5mQg7yfSryQfS5EVbUmGZwXpS+2AAJ+ZP0Sn7v7bdijmd
         WFXiDAq1BaHvzMkzRj5q6NhjM+mW0Lp+wNOxDDGIfrd9DHtVF+eAOf0KF21jlnmotIle
         Dhv6+IodwQGp2ysQXnZSGKi1eXq21gStC8aRgE+dS2X6Vm6DRFf8e8VAxAT+aPEh/dxE
         lmkz9/3QsSvp6G8S+ICx2iN7O/rNnMGcYRKMwiiTtrO0EBR4quU30m9LM6qA44CReOnk
         Lo8ZPe3Zv9vP9CTsyl/ka6P3oweswoHxnqr5tPG/J3JuBaXOEWo4fkexESMGehY5UpPw
         lzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4Rj4rseHNHkeHaLRW4sErEFZTvVWLtAsfI1VdmQXZU=;
        b=J+0lj1XqpUivMr9kcLKGx9S4089V2kchJMEmCa67QYGQFSkSBZ9k6RkEuGvJN6IER3
         NXXc38PSb/WCZzo/mcGolTRF3DheFooYbqE3l8xzrRYp30kUUOVgkzvPC978RjmkQHyK
         1Y3g1SxwSELzdaUyM/aDuKH6YqNHmMFZXnawY/DDF9DcwBSN0rxmQfF8DZkZm6+Kuat2
         NfiQy3pNDAbcsjZ/dVP8CKpbeVpw/uZJn7RievZQdULANaZ3reTBacux8QwxtIKnH24M
         a43kFMS5TILLnNj+dPzG0x0e/qDPvltPw7p8caoEncI5kYhturK6I3AvjoH9uzL2wTn7
         67Lw==
X-Gm-Message-State: AOAM530DxURRq/R68e2YauveDrOb/Pr4NcfkpZ6iiz1h51TWOH6XBz56
        6magFIpBJdwy2JVSwYSnR9NEshqzrt1UBvH8nLw=
X-Google-Smtp-Source: ABdhPJwZFQ4q88Xj+SYG4aSj6ELLs9ViNN5eUAOT1y1U7FPRaXV4uDIQ9e+PfOI3J7bicFHaga1QxzSguwOERvix48U=
X-Received: by 2002:adf:de91:: with SMTP id w17mr6361700wrl.84.1605313543292;
 Fri, 13 Nov 2020 16:25:43 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
 <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 18:25:32 -0600
Message-ID: <CAMP44s0EqK2rbUzqUH0iAAMmQACDd4oLYZrM10vH4xgh4AHNew@mail.gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 4:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 13 Nov 2020, Jeff King wrote:

> > I'm on the fence whether there should be a deprecation period or major
> > version bump for the final patch, but making the tests flexible enough
> > to handle the before and after state seems like it can be done uncouple=
d
> > from the actual default-flip.
>
> Hmm. On that matter, I wonder what the big fuss is all about. It's not
> like Git is forcing anybody to change their default branch.

Except you are, and you will be doing it without the user consent, and
without warning. This is the opposite of what any software project
that cares about its users should do.

The consequences are predictable.

Exactly the same argument was used in 2008, and it was wrong for
exactly the same reasons.

Yes, people could add the exec-path to their PATH, so "nobody was
being forced" ultimately, but that's missing the point entirely,
because that happened *after* they were forced initially, and being
caught completely off guard.

> There have been plenty of articles about this in the meantime, too, and
> I could imagine that most developers are at least aware that the shift
> away from `master` is happening, in many quite visible projects.

I have used Git since 2005, contributed since 2009, follow the git
subreddit, and I was not aware of the change, and presumably neither
was =C3=86var.

What you imagine most developers know is irrelevant, what is relevant
is what they actually know.

This is the bias known as the curse of knowledge: since you have a lot
of specific knowledge you fail to see how other people could not see
the same thing you are seeing, but they don't, and the reason is that
they don't have the same knowledge as you.

But just because you can't see it happen, doesn't mean it can't.

It did in 2008, and people back then used the same argument you are using n=
ow.

Developers back then could not imagine how it was possible that users
were not aware of the upcoming change that had been cooking for years,
but alas they did not.

Do not assume what your users know. Deprecation periods exist for a
reason, and so do warnings.

--=20
Felipe Contreras
