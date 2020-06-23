Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC2C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 23:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138D22078E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 23:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GseDGNbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgFWXVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbgFWXVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 19:21:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54685C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 16:21:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g21so487619wmg.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ddX98SztcOGQGaSlRWY2T1dnSpCazezuLq4gkI8Om7U=;
        b=GseDGNbRAzDEM4TZqCpR3B4NHH7/9xWpAWYlFs5VFxGTaf9v0q4pR274oj23I/P6xs
         kFoLuOLT8yBMCAud0cTCO8xDNxrvZWaheFiavRd9n8K/HxahVsK07nRXwWJynOQKyq8j
         W34jzlYL8k413FzA/Z9PTdL6+AFyxso/uq335c5Ors6PSxDHK4vS1zivNSlAuwuMR+g7
         KQksKH6qtvXbCHn76MalFl3LtG6bIEfKXUD/H8LbLs688mF5+z6fzC8QXTpDRilQNZpw
         q+DhdeKaD+4QHcLlKXn6yDlKW3sko94CJj0f4n8v3BKKaktsXSM8DH2ECz046OCbg09Q
         8j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ddX98SztcOGQGaSlRWY2T1dnSpCazezuLq4gkI8Om7U=;
        b=plHKKzg7q4myhMoDoDyexedCQ8pyAE/RmIAfOmCIE/8yljCXch2xCMhwsA0k8jDcMk
         oW67++qAcMlVOM3OFAuHolZtBdWmX3qDsLzGYy5yf3q2NKNHP6dNhDd+lwpmvMKSONGf
         ++XkSQy2zEfSEYfUBMve7PjHxc8ZJTmsP1GCdAiR1/VCuHgvyc3PtiVISmMvkCgxDmAW
         0q8dRvSbAHWwEeNEct3tvdvW9eDphuZO3093WbPL7aCn7tyeDIrl3WChVav0I+DGud+k
         bmgNIQ+l7cDiZc8NM8y++Np/k/nx9tM4jtjSW9Qch7/yTzmIw9CbNfv8MOL/HQiAR8nL
         6ooQ==
X-Gm-Message-State: AOAM531aUeP78mAobXbIG7EFEZTbim7AScdKHS4FS7srRmyNhtpkE5za
        wWWaOP2qNUovMO8Lkm/7WnGKBBsLnK4Omx0hn1BRMtDO
X-Google-Smtp-Source: ABdhPJwyb/rgLylSEKttAxAWq7Mowrizp8dUm16Yl4HlIF74ThMlyf+seqPIW9YfNU+RAYgTeoAPK/S2PqlAcLMn0NA=
X-Received: by 2002:a1c:2157:: with SMTP id h84mr25176165wmh.35.1592954503918;
 Tue, 23 Jun 2020 16:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
From:   Gunnar Liljas <gunnar.liljas@gmail.com>
Date:   Wed, 24 Jun 2020 01:21:32 +0200
Message-ID: <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Simon Pieters <simon@bocoup.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, I offer my excuses for inserting myself into this
discussion as an outsider. It will probably seem a little laughable or
sad that someone would feel the need to do that just to vent their
frustrations outside the public social media platforms.
However, I want to add mainly one thing, that has been completely
absent from discussions elsewhere (it has been hinted here, recently).

First, I will state my position, so that the actual argument can be
put into the context of where I'm coming from (or maybe just because I
wanted to vent some more...)

- Giving users an option is a good thing.
- Solid conventions that are rarely overridden is also a good thing.
- Moving away from "master" may be the right thing to do, but there
are certain ramifications (also optical) to such things, so the
reasoning should be informed.
- "Tagging" certain words as offensive or non-inclusive can be a
disservice to a working, sensible, constructive, emotional,
informational and nuanced language. At least when said word, in its
context, is used completely without its possible negative
connotations. It creates an emotion and a problem where there was
none.
- The actual origin of the word in git is irrelevant. How it's used is
what matters.
- The "perpetually offended" may be a moniker that's a bit too lazy.
But I would argue that there is at least a large group that could be
called the "eager to be offended, by proxy"

So, my argument.

Why is no-one talking or listening (!) to those who are assumed to be
offended or hurt? That may be a false assumption, but it's certainly
how it seems. I can only speak from my limited viewpoint, and for the
sake of argument, let's say that we're talking about black people, or
to narrow it down, black software developers.
Is that too exclusive? Well, maybe, but it's the scope I'm using now,
and I think my argument would remain unless we include the
not-assumed-to-be-affected-but-still-uncomfortable.

I tried to get an idea of how the GitHub move was actually received by
black developers (I'm white, by the way), by googling and searching on
Facebook and Twitter. And I really didn=E2=80=99t taint my searches with my
bias (e.g =E2=80=9Cblack developer github master=E2=80=9D). The impression =
I came away
with was that 100% would rank the move somewhere between unnecessary,
via laughable, to downright offensive. The move. Not the word.
The voices I found are not necessarily representative, but they should
at least give some pause. A common reaction seems to be something like
what @SpeedKicks (a software engineer in the "target group") tweeted:

"Reading a thread of white people, including the CEO of GitHub,
advocating changing the name of the =E2=80=98Master=E2=80=99 branch to make=
 black devs
more comfortable...

is the most racially uncomfortable I've ever felt about GitHub."

Acting on the uninformed assumption about someone else's feelings can
be very counter-productive, belittling and even racist.

This leads to my last bullet points.

- Staying with the word "master" can if motivated properly (or not at
all, since it seems to be a reaction to an ambient issue), be an
action that is even more grown-up, respectful and therefore inclusive,
than moving away from it.
- Can someone still be offended? Sure, but I think the solution to
educate, rather than eradicate, should be used more often.

Best regards
Gunnar



Den m=C3=A5n 4 maj 2020 kl 19:20 skrev Simon Pieters <simon@bocoup.com>:
>
> "master" is an offensive term, as it can be interpreted as being
> slavery-origin terminology. See
> https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_conce=
rns
>
> The Python programming language, and various other projects, have
> taken a stance and moved away from offensive terminology including
> "master". See https://bugs.python.org/issue34605
>
> When different projects using git decide to move away from "master" as
> the name of their main branch, inconsistency ensues between projects.
> See https://github.com/desktop/desktop/issues/6478 (and "Related
> Issues and Projects").
>
> To avoid offensive terminology and to avoid further inconsistency, I
> think git should use a different branch name than "master" when
> initiating a repo. I don't have a strong opinion, but I like "main"
> since it shares the first two characters and it's shorter.
>
> --
> Simon Pieters
> Bocoup https://bocoup.com/
>
>
