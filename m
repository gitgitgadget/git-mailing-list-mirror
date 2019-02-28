Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0102320248
	for <e@80x24.org>; Thu, 28 Feb 2019 07:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfB1HVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 02:21:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38108 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbfB1HVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 02:21:54 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so14230048itg.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 23:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRp0gFF0xLRHm/O0XK3U/ztyANWBxlITJZtNaiJYDK4=;
        b=ksBGQAL2mIT3slKcgIAZirH3BR84S8sHHP4P8c1Nk3J6Pq5TfVxxpm8V5CtrvwJPYj
         6Jmsg14bvk8NIvH0rw10czSGCAobqPoItJF+2a24YiACrTHYDb7mUM/BIQ3FhBCrL1G2
         UroNFFzNIptaA86tydA+HztPsXbCU2m9NuuOvyItvfBshkm3+XpH3hgYEcLs1u04gF8B
         pGxETuRFobskYYSu4PTKUC1SatwDeUWZO0Vd0ZniiaQdxSnRBsDgtrxWKdhu/ojTufQs
         8wi0qFHRPaVOqYq8KEnNAhfcD9ukay1lVFM+qtCnJQgZ+Ht7KM7JTvMuvEnxJcwMutod
         uq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRp0gFF0xLRHm/O0XK3U/ztyANWBxlITJZtNaiJYDK4=;
        b=f10aBEiXj+BnRUFYpUwXjo18sz6eNJg145MFeIXKMMMnzwolCFxKjULVp2b7T+gPTD
         ulHkZzs4iDRn53OIa0ixy5u+Pso1A9NyUuuiL3o1n8Y6IY8BrxRROUBnkhS0CSyhcvYi
         vBerlkYsd6BOoCu2+KNeV5VKJ/zdFvjHilwI9oLUXT5u4jaJmuqDaHr+nKfxTjr8XVjB
         8/ltEuM1ONqz+wUOlNyoSfMmEjpQi0kTF+9Nr1hZsZmQgK7PtNrpU76GbqjDJcQBxjX+
         GFJ6jhx06BAwhyGkSNFXhNmRYoPnsh4+hbbtmxzAowk8ZE2lvFVdNtt5YeTfHBoE/hco
         dBAw==
X-Gm-Message-State: APjAAAVic9qQ0DoZjby56NrELed34U8w23kB0fB8AbHH2c2iUQQavxWn
        wcSfFolbZxZvt46BeUUmleOw7grdRAENx4kklOE=
X-Google-Smtp-Source: AHgI3Ia5fuv4Bpv+D77ZmsGaeTWTfpIrx+6+ghy11X+RCpr6Wn9Y6zoDGoFwQ1rb9lm+cucpUYnSWoM5PKX3iu++qSU=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2037526itf.123.1551338513488;
 Wed, 27 Feb 2019 23:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
 <20190227113711.GF19739@szeder.dev> <CACsJy8AcrRBtEUFtFVDUbDZDodDDMAHxnwsf55zH+TzKCoyVMw@mail.gmail.com>
 <20190227123650.GG19739@szeder.dev>
In-Reply-To: <20190227123650.GG19739@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 28 Feb 2019 14:21:27 +0700
Message-ID: <CACsJy8DEqbZMW+vgZJ=FizP2agUmONrQBe9MrhRefc3qFsh0iw@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Brandon <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 7:36 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Feb 27, 2019 at 06:49:53PM +0700, Duy Nguyen wrote:
> > On Wed, Feb 27, 2019 at 6:37 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
> > >
> > > On Wed, Feb 27, 2019 at 06:07:42PM +0700, Duy Nguyen wrote:
> > > > > It was discovered that the --no-gpg-sign option was documented
> > > > > but not implemented in 55ca3f99, and the existing implementation
> > > >
> > > > Most people refer to a commit with this format
> > > >
> > > > 55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-1=
3)
> > >
> > > No, most often we use
> > >
> > >   55ca3f99ae (commit-tree: add and document --no-gpg-sign, 2013-12-13=
)
> > >
> > > i.e. with a comma instead of a dash between subject and short date;
> > > and without quotes around the subject.
> > >
> > > Truly sorry for nitpicking :)
> >
> > Naah it's about time I update my ~/.gitconfig to be "conformant" :D I
> > think we both failed to mention where to find the command for Brandon
> > though: search commit-reference in SubmittingPatches.
>
> Well, yes...  but I didn't mention that on purpose: SubmittingPatches
> advocates for quotes around the subject, which is still the less often
> used format of the two, and there is no good reason for those quotes
> (that 'deadbeef (' before and ', 2019-12-34)' after the subject
> provide plenty of separation and indicate quite clearly what's going
> on).

Perhaps a patch to strip those quotes from the command in SubmittingPatches=
?

> However, looking at the length of the suggested command in
> SubmittingPatches made me remember that I've been using a couple of
> patches implementing 'git log --format=3Dreference' for a couple of
> years now...  I wonder whether it would be worth having something like
> that in git.git, and thus making it conveniently available for other
> projects as well.

It does sound nice to have something like this built in. But I'm not
sure if "git log" would be the right place. For handling single
revisions (most often the case), git-show or git-rev-parse might be
the better interface. Even for referencing multiple hashes at the same
time (e.g. you prepare a text with bare hashes first, then run some
program to insert the "(..)" part) then name-rev might be a better
candidate.

A softer route to avoid any of that is simply adding default config
"pretty.reference", then let the user define their own alias that uses
--pretty=3Dreference. Or perhaps just put it in EXAMPLES section of
git-log.
--=20
Duy
