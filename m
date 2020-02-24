Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A04C38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66D20656
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdj7maGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBXUYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:24:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35949 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:24:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so5720063pgu.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o9lqeJvdAq3ilXr2pnVfV6qayi7R2Kmac7emC9r8evg=;
        b=Kdj7maGnJK2CEKSjjtm7Nxx3G/VE9ogxuY2/6TMoipj+5nxxxwhtwB5rcVkCTSBMRq
         uEh4/hwr+QMmI7rqNl1q1AaX3hLryg8vWnzJHGCHNMpmGHkxd3gG3niK9q3DQwCRZbrC
         Fv1Zek7GBdWzB7OmcXU7RiSQINk1asRjJH+zJds3c1ByatcctLtfpe1HGC++RhauuFvY
         RW4/cbmmwASXTURnMw0VveOMDY1r1niNcQ3TQtq/6+IjDTXOD0pB71F/KCaHjBRIqklb
         PPynCH+zEX41YNKWHPwPPD9gV6mb3a1UefagIxGf00bwRS/VgQJnWlnyH7AiDxmVUVsj
         YkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o9lqeJvdAq3ilXr2pnVfV6qayi7R2Kmac7emC9r8evg=;
        b=m586EvgfyBlN+DD+8aYmudggYIc03/qC1cbK44iQ2G4zxcJeyRDSuOuQP9YmYWsr4Z
         O7FQ9TbKncw8d5WtuLbaoW7d/jubvj9dgkaFb6cYxbrJy04zII21ohSZaVGiUXrjFb3a
         3qeLI2zZzNU3jvNemrrZ8RMF0AymdOXXmeMhF66dlU+GuuDj/MWl2aUtAWnCdqBxyhjL
         5dVbYN4V1nJ1DhwOvlimUP/dY3IBkdC7gNNtCnMqNtUOJeE5EBfxujjcaBmRxHrLfxTx
         JFDBc1yr7cNuTpMjmiIg2NN+RKzA7l2k7rKGyo8e9VDMSNGKa48KD9bR4lLHxpy7paqP
         Etqg==
X-Gm-Message-State: APjAAAX5LfcVh4r/xHdH2DZ/1pviQry9EIfeZ4ilB5fL8TLVxGjyx23R
        sUxYKxRKPKmiX8o4QkAuizeuHFDds6zwGn7PYK3mRQV0
X-Google-Smtp-Source: APXvYqw/WDMhBXTaZib3Fmy9byGMCF5RThLLzAg3fraUIEbO0gHKxWLFDEtKIZpgMCQCG8SEZWVnwAUmtJZRr7xulos=
X-Received: by 2002:a63:1510:: with SMTP id v16mr52280252pgl.155.1582575883958;
 Mon, 24 Feb 2020 12:24:43 -0800 (PST)
MIME-Version: 1.0
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
 <179c67caec0f8123d09455cb78532419166e1b9e.1582447606.git.martin.agren@gmail.com>
 <xmqqlforpyqe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlforpyqe.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 24 Feb 2020 21:24:32 +0100
Message-ID: <CAN0heSo8RSyvTqTtDLcnBsvMJ-DLL_B-sKRZDNUZBhZ1yX=bmQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] t: drop debug `cat` calls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 24 Feb 2020 at 20:33, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> >       git fsck 2>out &&
> > -     cat out &&
> >       ! grep "commit $new" out
> >  '
>
> This one on the other hand *DOES* rely on 'out' being created; we do
> not want to take the failing 'grep' as a sign of success if it is
> because 'out' is missing.
>
> >       test_must_fail git update-index --nonsense 2>msg &&
> > -     cat msg &&
> >       test -s msg
> >  '
>
> This one does not.  "test -s msg" on non-existent msg will fail, so
> this is closer to category 2/3.
>
> So, I am OK to have two patches that catch two classes, but the
> division between 2/3 and 3/3 in this series does not look the right
> one.

Heh. You don't want to know how long I waffled on whether to split the
one hunk out to 2/3 and make the rest 3/3 vs. having a slightly larger
2/2.

For the first patch 1/3, if we lose the cat entirely, we risk bugs in
*git* being hidden. For the hunk in patch 2/3, I first thought it was in
the same category, before I realized that kwdelfile.c disappearing would
be a bug in *p4* as opposed to *git p4*. Since we're not in the business
of testing/verifying other people's software, we can afford to drop that
call entirely. At one point, I had this in the commit message, but in
the end I figured one reason for the removal was enough and just kept
the "we'll soon grep" argument.

I realize now that the line between 2/3 and 3/3 is blurry.

FWIW, for patch 3/3 my reasoning was that for the similar concern about
the file not existing, we'd depend on the shell messing up the
redirection quite badly and not creating a file at all, yet continuing
with the && cascade. Which seemed like a pretty crazy bug. And again,
that shouldn't be our worry. (I see now that there's a case in 3/3 where
a buggy test_cmp could delete "actual" and we'd fail to notice after
this commit. That probably also sorts under pathological bugs...)

> I am also OK to have a single patch with updated log message, saying
> "removal of 'cat <file>' may miss a failure mode that <file> did not
> get created, which would have been caught as a test failure in the
> original, but the <file>s used by cats removed in this patch are
> either impossible to be missing (because a preceding step in the
> test created it, or the &&-cascade would have failed if it failed to
> create the file), or followed by another step in the test that would
> fail if the file is missing (e.g. running grep on the file), so it is
> safe to drop these cats", or something like that.

Let me re-roll with 1/2 (=3D1/3) and 2/2 (=3D1/3+2/3).

Thanks for a review.

Martin
