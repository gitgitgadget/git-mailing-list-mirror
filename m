Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90492C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D424656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3yd+8Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgANV0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:26:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33981 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANV0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:26:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so14135904otf.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbbTI85lR2+y5eD+uvK6P7LYZBo3hbzBalAv8+uJRWk=;
        b=F3yd+8CdDAAWxYbbkEw3PGcsmea0gm1xEg7kz2PWtda0+QR9FchLadbuVfAnoWXjDX
         NuHadfMa/LKEV43rppTKda61NzECSpxBdSYmxP/NZOws7DPZR6AAIsVAGS+GNWSIiNeg
         /PDLDJ/0Q8PSPuJZVkQty+aFXP1BfGuSWbbs6J7TXyKU3MFRbL5fGiLCVaL4kySD7Mwt
         kBgNSbfJavuaJmwxmb4n2z2NJ8yH8ymbHdp3ETHpkcK609d38mna3eR5UAS+/iBlkCL0
         1zu89gnbNA/QlTNYI3Og8cj30CX0Oouk5TtaTL84AyO4nxgOHlUSmUM6/tURS3Krdb+v
         NqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbbTI85lR2+y5eD+uvK6P7LYZBo3hbzBalAv8+uJRWk=;
        b=GolAS16tBDONNu+WCfYMBCwjgjKBvtG4vmvdRVLignkL14jwS2UqbzcAucbRdkoJ2K
         Jrx0Wnc9uVKH0WaqiRNagA1sPnG1v/9DWxeJajDPDL+DMk3XkE3O2BHSXyvG5r4E607Q
         9CjgcOuDjk72JLwDU9r9zEMD47ISEc2akWroNAYJO5m1Vj9g7KXnA9X/u1XSDYpQY5Zg
         mqmGBOt0r/eEd3F2bz7hN/K3NWnNnkxAMpv1uuueAh88FPxa6J1BoMFAgFO2zd3Kv7sf
         Qyh0cBE4GUr4h8IneLTrrePYFk+/WN1Vdauy5n03yk9OhngsybkoP+qG4naLeF1U/zna
         IqQQ==
X-Gm-Message-State: APjAAAXmNIJ2U5DGEdimrp0+mbMku6NChUoBRrxMzjTSQBTlVfOSLCFT
        /sEvVpluvVvON+EnRvZw4RLiF3ikZwqdnNMUMxs=
X-Google-Smtp-Source: APXvYqwAEDDkPiZG/8nFSULJPXV5T7POQ0/OVRYU7pvJxtzK8UankqsrgwUNkwWp4024UfBdK1y2OU1gytn8C9WVZmI=
X-Received: by 2002:a9d:634e:: with SMTP id y14mr319822otk.162.1579037182003;
 Tue, 14 Jan 2020 13:26:22 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BG9eqbhnzU8gzJ_h+=XH4mSOj-Wb5SU7OjXz5ik6c+NnQ@mail.gmail.com>
 <20200114205651.GA74460@google.com>
In-Reply-To: <20200114205651.GA74460@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Jan 2020 13:26:10 -0800
Message-ID: <CABPp-BECzff3tWNSJU2YNmNxSW1f=SDnoPQpRHKtQ-Moba+mRQ@mail.gmail.com>
Subject: Re: en/rebase-backend (was Re: "rebase -ri" (was Re: Problems with
 ra/rebase-i-more-options - should we revert it?))
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, Jan 14, 2020 at 12:59 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Jan 14, 2020 at 08:52:57AM -0800, Elijah Newren wrote:
> > Hi Junio,
> >
> > On Mon, Jan 13, 2020 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > > > Junio C Hamano <gitster@pobox.com> writes:
> > > >
> > > >> I will push out what I wish to be able to tag as the final [*1*]
> > > >> shortly but without actually tagging, so that it can get a bit wider
> > > >> exposure than just the usual "Gitster tested locally and then did
> > > >> let Travis try them" testing.
> > > >
> > > > I haven't heard from any failure report so (taking no news as good
> > > > news) I'll cut the final today based on what is already on the
> > > > public repositories everywhere.
> > >
> > > By the way, as one of the methods to double check that my result of
> > > reverting the merge made sense, I ran "git rebase -ri v2.24.0 pu"
> > > and excised the merge and the problematic topic out of the todo
> > > list.  With the rerere database populated beforehand, it was more or
> > > less a painless exercise (except for one topic, en/rebase-backend,
> > > which is one of the topics that was queued forking 'master' after
> > > the topic got merged *and* actually depended on what the topic did)
> > > and after about 1700+ steps (which did not take more than 20
> > > minutes, including the time spent for the manual rebasing of
> > > en/rebase-backend topic) I got the same tree for 'pu' I pushed out
> > > last night.
> >
> > I wonder if I should have been the one fixing up the en/rebase-backend topic...
> >
> > Also, with the new release and the review comments Phillip posted on
> > the en/rebase-backend series, would you rather see me address those as
> > additional patches on top of en/rebase-backend, or should we kick that
> > topic out of next and have me send a full re-roll?  I'm not sure
> > what'd be better and I don't mind going either direction...
>
>
> For what it's worth, I had started to look into one of the bugs Jonathan
> Nieder reported[1] as a patch on top of en/rebase-backend topic. I'll
> keep an eye on this thread; if you're interested in rerolling the whole
> topic then it might be less time for you to identify the right place to
> call "post-commit" than it would be for me, plus less conflict
> resolution time.
>
> [1]: https://lore.kernel.org/git/20200110231436.GA24315@google.com/
> (bullet point 1)

Ooh, that'd be great if you could fix the post-commit piece,
especially since you're more familiar with the hooks in general and
probably have access to the actual usecases where people are using
post-commit hooks.

I am planning on rerolling the topic, but I'd be happy to insert a
patch authored by you into the series.  Or maybe it'd be even better
to just merge them as totally independent series -- I strongly doubt
there would be any conflicts.  I didn't touch the am codepaths in
en/rebase-backend (any am codepaths I touched were submitted
separately and already made it into v2.25.0), and since the resolution
of the post-commit hook sounded like it should be modifying 'am' to
behave like the merge/interactive backends (as per Junio's
comments[2]), the fix should be orthogonal to the rest of
en/rebase-backend.

[2] https://lore.kernel.org/git/xmqqa76sl67u.fsf@gitster-ct.c.googlers.com/
