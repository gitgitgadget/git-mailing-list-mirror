Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A7C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 21:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjC2VyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2VyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 17:54:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8EBD
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 14:54:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z83so21270820ybb.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680126853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKGi05IuWo+1ZF/iR446PibAzJM1eiko4TGCUQdEevk=;
        b=LPrVIwdqXQJDT0iiryKHpR78n3pUMEqQPq4k/+mfq7bYR6UgcAiEBH3yXIz7LrygBR
         X7xpWDUazCHdjkPa2rNDRdaNdLvL6UzkANzuQ3NWqzQCBxTktZ7XZ5IISLndGfuOfMCA
         Hhbaa3VCxGcZZr9FsaQFMazUDpIomIDwIiEhFnopr6I1xuSfAECVTUyzRT2Crzr5jPJg
         Wr0sM8Eiz30cZE7vzcqLC1a/A/bsRY8eSB24L4QnsiRF+IthD3oEWeOrVyKcWT0zFlH4
         hwFfek+9W4OLlEup7+HLrnDGw3SUL4BGIvsK3R0RSHypctJGs4CGBvXS1NqKcVc4k1tj
         FsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKGi05IuWo+1ZF/iR446PibAzJM1eiko4TGCUQdEevk=;
        b=qN/rVDPeGLqtdW75Narx2rqYFFBcUFqJM3Q46IgBjbJTPVRFgCuFh1O5FPeTOIfoKj
         a6oKEF4bJr9efhNnYvhiZ5OX6HqHHlWG+ZcSP5x7cy/WdrBFzj2evZ29uPRNpr30elCh
         b50TqD4L1TgexW4RJRV25iO8SlR+rENddtBE8NiladD7Rt8vB5obm8O1ONmjMX9bD7z8
         HN7kH74KWMK4DrcIfn5yjpOgsWuO9wMUS7ym3/4zSU0PZEzujsdTx3A4U8aq/WWayZGE
         jAtb8vjSF6Xtkj9tHxs0fXRQ1iedRvFm+unaphdLECAyWhDmuMaKIyr0wp+W0l07RqSZ
         j9vg==
X-Gm-Message-State: AAQBX9fTW3xT13TfKByjmOvkYFM6h4IsF/ORHZ4cvIgm3mcDot65o06r
        OWK7Rznuz8ip8K2hKyMrfmu7g94w32LIFGweeDw=
X-Google-Smtp-Source: AKy350YOC1d255IfvNnAWLT7566391/BAb24vGGsoBX1QLmXz8QjBgV4lGxr/VgxNgdjo1DvPNV7PX8HDqxXSYTKB1E=
X-Received: by 2002:a25:abee:0:b0:b4a:3896:bc17 with SMTP id
 v101-20020a25abee000000b00b4a3896bc17mr10814243ybi.0.1680126852867; Wed, 29
 Mar 2023 14:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <xmqqh6u3d119.fsf@gitster.g>
In-Reply-To: <xmqqh6u3d119.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 29 Mar 2023 15:54:01 -0600
Message-ID: <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 9:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I don't care a lot of other folks want to make zsh run the
> > testsuite in zsh mode, but I'd think that using sh mode would be
> > simpler and less likely to break in general, and would avoid us
> > needing to carry a lot of patches to work around various variables
> > that are special in zsh mode.  It would also be easier to
> > potentially test in the testsuite as well.
>
> While these patches may make it "work" with zsh in its native mode,
> because zsh that is running in its native mode is sufficiently
> distant from the more POSIXy portable variants of Bourne shells like
> dash and bash, I find it hard to justify the cost of maintaining the
> resulting codebase to "work" that way.

Why do we follow POSIX anyway?

Is it a) because following POSIX is just good? Or b) because POSIX is
a standard that many shells attempt to follow and thus by following
POSIX we maximize the amount of code that works on most shells?

A quick non-exhaustive search of the history of Git, shows these:

74ec8cf674 Conform to POSIX (works in mksh/lksh)
c5c39f4e34 Fix for dash
7d661e5ed1 Conform with POSIX (works with dash and mksh)
ddf3a1152d Remove a warning in bash
9b67c9942e Workaround for ksh
5c63920190 Consideration for some shells (e.g. ksh93)
e9980419cb Fails in ksh88
268ef4d3d0 Aligns with POSIX
8e98b35f87 ksh88 on AIX considers it a syntax error
8f92c7755e Code would break under mksh
b082687cba Not allowed in mksh
661bfd13b4 Fails in xpdg4/sh and ksh
f5799e05c0 Public domain ksh and ksh on IRIX 6.5 have a problem
365c2aaafc Doesn't work in pdksh, POSIX unclear
482ce70e14 Doesn't work in dash and ash
77e572653b Doesn't work in dash
0e418e568f Workaround for ksh
49a43f5468 ksh doesn't like this
c289c315c2 Doesn't work in xpg4/sh
933e4f090d Workaround possible dash bug
c7053aa88f Doesn't seem to be supported by dash

It does seem like in only around 15% of these patches the
consideration was "this aligns with POSIX", in most cases the patch
was to make the code work for a particular shell.

In most cases the mention of POSIX is used as a justification for the
proposed code, but it was clear the intention was to make it work for
a specific shell (usually ksh).

In the few cases where POSIX was the main rationale, the shells in
which the current code doesn't work are mentioned. Not a single patch
says "this aligns with POSIX" without mentioning any shell.

> We need to force our developers to pay attention to rules set by
> zsh, like "$0 is not the way to spell the name of the script",
> "$status is not usable by end-users", etc.  Making the problem
> worse, the rules are enforced only by zsh.

No, we don't. $0 is not something a test script needs. In fact, there
doesn't seem to be a single instance in which $0 is used except test
infrastructure (e.g. test-lib.sh)

This sounds like a rationalization post-decision rather than a reason
for the decision.

Looking at the history it seems the test code has been more than happy
to make accommodations for xpg4/sh, pdksh, ash, and even mksh, even
when the code was already POSIX-compliant.

In truth all the patches regarding shell portability have been along
the lines of: "this code makes $x shell work, doesn't break other
shells, and isn't against POSIX". In some cases even when the Austin
group disagreed on what POSIX actually said, we did whatever worked in
most shells.

Is there some sort of predisposition against zsh?

Cheers.

--=20
Felipe Contreras
