Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029DC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjAWPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAWPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:18:42 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C0298CB
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:17:43 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b1so9931508ybn.11
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L166ppyOy//H1uXU1+vkx3IKu55DyMw3hxRJ8xkK6JA=;
        b=EJSOXIBs/TGb9lU+gYVFhfW5VoaDkL8GnkuNDrleZhqoDnApQGnsng/v1Klk235m8O
         hxG4TdAoDyxd+2P+mD9FdZwMNJ1BGzM941nWne1tim5DFj/Ns6/qUEDUDVCINgg8Xtqj
         L9wslMQJw+dH5BTVzHAVdDZSWJqGZMuqA9x0Ql0zo5m/aTiH0KHK5VZAnv8IVBOXjy4L
         CGB2k2wdcXcJY1oqc+wJuepCBAFSg6IeS8GQWeFZ57pkeyJoCXqtmnKJLfAMxZihFZwb
         UhhwtRpb3p+XtFdw7Keyp4gjJFGwkyduI6g+ro8PDf2ZRAxZ8/4xxumHp9MpuFPIG68W
         tEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L166ppyOy//H1uXU1+vkx3IKu55DyMw3hxRJ8xkK6JA=;
        b=04v5KxLYxkQyBc8YfspWZIFXUx2G1YMiGLa2Y8JiOZTK5OxRYdiIJnczFMiiek5dhv
         ez/YnluSQRUkUhQ+VjFJCp9ijQ9lRk+pdubeU4gcGbSUgle7aaP4juSZTBvqB4eDUMhD
         srzFDFhviGMzVtjk70Oe7kSLBxkxQccMJVVDv8CK6KwHoRmHUn6gZyW5B7W/gf/5RlFk
         j35e4FSz2hY1gocjk15A+uJETruiImGuqTDedAkrhvqVltiwasWDNFsUtE1EYsdcNiBk
         eCICbWJPU2kL4qnm6GUN7t8oWUt2tuAbLvdp1mC09Wwmv1d/vCXv9ixHOaP8s4RPISww
         g4rA==
X-Gm-Message-State: AFqh2koBNvmbK35fxWqbB+64dzbq4d+XvcdcdlZrRXa2h6WnmoAQNeyT
        63rGamwNtdo51XAIGo5PZAcRtwJeQzvwkoY7nu0=
X-Google-Smtp-Source: AMrXdXuoKCwO1imsqS27CUfIfj3qHj3pG0uRXM2YyuQx4yh49hZG0y5NHX+dWIvQixza6yAguUcvpFVKN7zzP47s5Ug=
X-Received: by 2002:a25:bd14:0:b0:73f:fb7d:400 with SMTP id
 f20-20020a25bd14000000b0073ffb7d0400mr3421042ybk.352.1674487018491; Mon, 23
 Jan 2023 07:16:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
 <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com> <CAN0heSoVguXpGC4PMsvh8CedwSvxu8A=iG2hT8Szxdq2ivh9rw@mail.gmail.com>
In-Reply-To: <CAN0heSoVguXpGC4PMsvh8CedwSvxu8A=iG2hT8Szxdq2ivh9rw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 23 Jan 2023 23:16:47 +0800
Message-ID: <CAOLTT8T5XaTH0APobqLo8+nUuBwmMkGKGOc7GdRx81kdxb6NGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: fix sparse-checkout docs link
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=88=
20=E6=97=A5=E5=91=A8=E4=BA=94 17:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 20 Jan 2023 at 06:29, Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: ZheNing Hu <adlternative@gmail.com>
> > > So fix the format of sparse-checkout.txt, and link it in the
> > > Makefile to correct that.
>
> > > -0. Behavior A is not well supported in Git.  (Behavior B didn't used=
 to
> > > -   be either, but was the easier of the two to implement.)
> > > +Behavior A is not well supported in Git.  (Behavior B didn't used to
> > > +be either, but was the easier of the two to implement.)
> >
> > Why did you remove the numbering on this, though?  If asciidoc doesn't
> > like starting with 0 (the only guess I can think of for why you'd
> > change this), shouldn't the series be renumbered starting at 1 rather
> > than removing this from the list?
>
> It looks like the zero causes both asciidoc and Asciidoctor to emit
> warnings (one per item, since each item's number is off by one). They
> also helpfully relabel everything starting at 1.
>
> I agree that there's a better fix here than dropping the 0. Either
> renumber everything or, probably better, just use "." for each item
> rather than "1.", "2." and so on. The right numbers will be inserted
> automatically. This also means that if an item is ever added earlier in
> the list, we won't need to update all the numbers below that point.
>

Good idea.

> (The numbers being generated automatically means we can't refer to them
> ("see item 2") without potentially getting out of sync, but that is true
> regardless if the numbers are corrected for us, as now, or if we just
> use ".".)
>

That shouldn't matter, there are no references to any of these items.

> The contents of these list items could be prettified in various ways,
> but I'm not sure what the status and goal is for these technical/
> documents. Avoiding warnings in the build process, as ZheNing aimed for,
> seems like a good idea regardless.
>
> Martin

Thanks,
--
ZheNing Hu
