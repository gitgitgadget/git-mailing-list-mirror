Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3327FC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 10:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiBGKEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbiBGJtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 04:49:01 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD17C043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 01:48:59 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id r8so21941194uaj.0
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cqM4EWP5BhhJIOYtw9GJXAfeniQv024FBgWkmunX6TQ=;
        b=oegbQ8PxEtv9n2+a2RtamQ2mDX5Ad4J//CseZpWgkV7DjmChG6FK9LeNtxmzglbyTe
         S/sBeoL6r7UJRtMx+AxT+tcIzQautpCV5aKmqTiXkanDxaI2pKLWmZGN/sK4Ldi8I7+C
         GVGv2VtvgwQCfCKzOXz7ETR9i7sauG+vLblx0reYcfvsb3C32eRuxKFbN83SB7sqZA1n
         rhqx6Rhh5/v6GwMinaV1a204hWZbeu1SkyXCdOHhy+8UGdODGMDoloj2g9isE+swA7m3
         iESIP6gZb4f8W+dUZF67bqZ+8uGUpOVoKCDhPkoNvcLmGfSMr8fG2te/SRNzmLvZiXAg
         aywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cqM4EWP5BhhJIOYtw9GJXAfeniQv024FBgWkmunX6TQ=;
        b=bO0JIt62R27/UffkcS7YE1JRfP/KMasEUTcN0jvVcnUsKxQSS3tpJYfgTbknJIMKU0
         h/TQQ71n8vCH7aV5AuoGax4gI6HmrXFYbXrtT2nTMk4aJ1U11kOFL0RXK5+e/141smVV
         QbxAr/2GndB1lzcdeBHjyKNwe2fnCSKqOnx/D/w1Yx2rgtT7THshLOFryzETO05v0TX3
         eTHR8eJpWDmzn8nhFBoWLQSaLK8u6NYkHHJlicsdpIR4+MawqvWHYjqTwqR64grKVDT8
         NQIZ+wra1DOPaJC6tlnjmYMbowfy8SkBN4h230khdXqscbRD9uJB2m+mL1yF/D3irw5N
         KCbg==
X-Gm-Message-State: AOAM532G+miHcbCrW5bg8ZGiM9z4t+q0xkUQ5D2dco3A4BqH2+Rwaz4h
        aujAtXztLkUPODpYJsot2HcqEJqHMps9Lx3+50RHDw==
X-Google-Smtp-Source: ABdhPJwvvrxLof+PTVALXK4dw2ipsknqMIwozCyT6NM/HX9PUxHC/hOVNi3jFGyET6FhMRdTIj/pJFTpnxhN2rFFIl8=
X-Received: by 2002:a05:6102:909:: with SMTP id x9mr3477073vsh.8.1644227338326;
 Mon, 07 Feb 2022 01:48:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
 <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
 <xmqqa6facn9i.fsf@gitster.g> <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
 <xmqqsft2b5jl.fsf@gitster.g> <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
 <xmqq4k5fr1mh.fsf@gitster.g>
In-Reply-To: <xmqq4k5fr1mh.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 7 Feb 2022 10:48:47 +0100
Message-ID: <CAFQ2z_Nb=wY_+B1ub0XDgZnvgCHGmFu1rjMuKgbFFir0=1PHtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 12:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > Technically, the only obstacle I see is that we'd need to treat an
> > existence entry especially for the purpose of compaction/gc: we can
> > discard older entries, but we shouldn't discard the existence bit, no
> > matter how old it is.
>
> I was hoping that we already have a type of block that can be used
> to record an attribute on the ref (other than its value) and it
> would be just the matter of stealing one unused bit from such a
> record per ref to say "when answering 'does this ref have reflog?'
> say yes even when there is no log record for that refname".  Or the
> table format is extensible enough that we can add such a block
> without breaking existing clients.

That place doesn't exist, unfortunately, but even if it did, having a
special reflog entry indicating existence is a better solution all
around, I think. A separate per-ref bit allows for data
inconsistencies: what if the bit says "there is no reflog", but we
actually do have reflog entries in the 'g' section?

It also has less chances of creating complicated control flows
(especially in JGit which wasn't designed for this bit from the
start): the tables have to be written in lexicographic order, so you
only can write this bit after you know if reflog entries were written
for a certain ref.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
