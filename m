Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4013C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BF320719
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 05:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe24Ak60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKWFqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 00:46:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42505 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWFqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 00:46:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id i3so8250487qkk.9
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 21:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTMmB4Hee9m/kctCOWxcF/ZccgNvMpKgkj9ZHJY40Ks=;
        b=Pe24Ak60Yk25gVBisIA8u24sfPSi9LVP2eimJGPHBvhthepqtpcIAgKeG73Upl1cz8
         6WyX+Ss0NCX4+a+54aPusb3jxcFbZCtVC8wgS/ipn7QkfFzN6b456oxNXjaVpDvHaKsN
         MVHdBNi0UeYoCa9J0bB9JiOEeUmkhwdaHYgyVUv7haqf+D4KWr2QQt6XY0YLT7P/uX51
         N35E2FA5PMTl7tkYtxu+6edpG4Ra3EdzYuqAy64ryQ93pCffB0Vkx2AHnO0ExwdG4E8H
         DoFdp96yJTKpCmpQCg5RIfBVLhZL05YsyuryHIXRJB40MnTy3AnCG8ti4lLFVD9vrXLI
         t12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTMmB4Hee9m/kctCOWxcF/ZccgNvMpKgkj9ZHJY40Ks=;
        b=hRONMm/43PNAuuL3cmtE3GwgQMPfv9dXdluw3d1j6cL38lPto7UK54oWcIFtcUWOMY
         Ea7IzG2n2UVCMXia+x0ETn0P6OeyBtFjmoxXK7cktX4id8wfEe30y1cfTcszKGIS0iyd
         mPkVM+5DyZyu3c+od1JTqdaqpwL7XPe7gtsdy+vOlK1uE8Ynu7kZxoflehfXpHdZdbhb
         eyVOrTtgLWADFfKRlRGOuveCYfC0V1HvXNtEwvwZIcDwKp/FscPbINBiIxVckB747ZVZ
         eW8o2b2BHldhvgS8syxyR9e7fI/g3QNM18zkXtE8ZMRu8b9Ln0tlCrp37MTfo/Oys2ZB
         hCHw==
X-Gm-Message-State: APjAAAVPr2QTS3u+iT2wSq3VzP7XOWCQMSYbc6KkdLEWxWcUiBtQr9+e
        HQAm7ztjmeqp2zaBNCI+NnK/Gj5pv4ju11b/sSk=
X-Google-Smtp-Source: APXvYqy6dSCb3KRfI+b6FTBgLt9RwvrDUb6ZRwK6m0zcuQs8m9I6urZ/OZkO7aSiVt8nrZG5BZPDyKYcS7liNFPvKD8=
X-Received: by 2002:a37:67c5:: with SMTP id b188mr16401706qkc.199.1574488002198;
 Fri, 22 Nov 2019 21:46:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.470.git.1574464285.gitgitgadget@gmail.com>
 <0eabb27ba0c7a07bbf24f13f1766c0ff63995348.1574464285.git.gitgitgadget@gmail.com>
 <xmqqo8x32xqv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8x32xqv.fsf@gitster-ct.c.googlers.com>
From:   Manish Goregaokar <manishsmail@gmail.com>
Date:   Fri, 22 Nov 2019 21:46:25 -0800
Message-ID: <CACpkpxmtuunTXPc6=3bvPqGL=T7i4-LB0sKDmzLPxcNcv1ZH6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: Correct man page for the SHAs reported
 by 'submodule status'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manish Goregaokar via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out that I've found a bug! I was getting this behavior because
it wasn't detecting that submodules were modified. I'll submit a patch
shortly, but first fix this one since the documentation should be
fixed regardless.

Thanks,
-Manish Goregaokar

-Manish Goregaokar


On Fri, Nov 22, 2019 at 5:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Manish Goregaokar <manishsmail@gmail.com>
> >
> > 'git submodule status' reports the SHAs expected by the parent project,
> > not the SHAs that are actually checked out in the submodule. Checking
> > out a new SHA in a submodule will not change the output of 'git
> > submodule status' until you 'git add' the submodule.
> >
> > Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
> > ---
> >  Documentation/git-submodule.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > index 0ed5c24dc1..31e089454a 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -72,8 +72,8 @@ git-submodule will correctly locate the submodule using the relative
> >  URL in `.gitmodules`.
> >
> >  status [--cached] [--recursive] [--] [<path>...]::
> > -     Show the status of the submodules. This will print the SHA-1 of the
> > -     currently checked out commit for each submodule, along with the
> > +     Show the status of the submodules. This will print the SHA-1
> > +     recorded in the superproject for each submodule, along with the
> >       submodule path and the output of 'git describe' for the
>
> Am I mistaken to say that neither the old or the new description is
> correct, depending on the use (or non-use) of the --cached option?
>
>         ... print the object name of the commit that is currently
>         checked out, or the commit that is recorded in the
>         superproject if `--cached` option is given, for each
>         submodule, ...
>
> perhaps?
