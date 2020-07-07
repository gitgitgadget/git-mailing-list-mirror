Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A069C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 09:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C5B20702
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 09:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yms8XDwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGJYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGJYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 05:24:22 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BEC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 02:24:21 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id n137so9238968vkf.7
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guwnMlkfMECnSLHZ9tCZzd5REoUuxhai2zrHjZRwq+Y=;
        b=Yms8XDwXVtd4UzoCdFczSn/o2smNr+CrZU2zgdsy4GO+VeFuju0mwGKjh8k+LwnEcp
         y/X+BcC2W6hAurzd5fvGPdpFlld2kOmHqFnu9WNltOtaMhZ3o+3HbntAVyFTF6DbaBG4
         6Cv3oXI+DRTS7VK4GJ6EoOwhhC7hllQ1Cc3Nxu7gcD+MXw2QTo90kqj6AnuRhvQwjCER
         jN5i4cee0lnZP48EbdIon+dXe2K3KQKGKtorUQDIvPG4bp1BGJImEKpPgQP9bJHQuh9b
         17NShvjguXT7jfdJB2xqCgtbwGoRKg/DH4FOG0f7JtU/isR/op6pCjWhnuH1qa17+cR2
         nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guwnMlkfMECnSLHZ9tCZzd5REoUuxhai2zrHjZRwq+Y=;
        b=ZMvoDdoYKgl0mrPOt1jh7ygvSJ2mo059i4AGHR6WO7T7HXXFBacOcJktyoQOq5BonX
         W9oCC6OC0G/0PxSd/ErC+2j1ZpPkOz+60CeKqXC/GOFhDKUxviaxLOaK7TORZBz0f/pB
         dOq7KV4T7n7NmikbbfXb7yV6z5nnHIPEIJ+KhaBuxKlT7oEy6C0vVJKO465lZaTCUkI+
         Q0UEcGkAzouRD0uGymmINaX/2VdHXSX1evdTV35WZKjvvPyvx1StMvurVr/gL0DMko6X
         HAGvUSIrkFdIMlGHY4R81Q4onuVU45Ar6+h3KP31UWXK2oVMzIp0PM+Mc8IfgFc1pGZP
         Q8IQ==
X-Gm-Message-State: AOAM533p7ys/1Nv6ThZVK2D9Btg31KzG4D8LyaCHpTaD2iHmLVAZn2In
        YxDpq/kVb8wcem/y0S8Etnkb28h0KRxIFZWdC8AsKg==
X-Google-Smtp-Source: ABdhPJwJgC7MaGPAKqw9sxBxCo5QUb60SsTIXOXVPT/J0WQGeSjPuP4fU9HQ1/PqAtcUExrbNrJreQIzGnHcipWKzRU=
X-Received: by 2002:a1f:3d47:: with SMTP id k68mr37454967vka.68.1594113860640;
 Tue, 07 Jul 2020 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
 <470821dc6d4b72c6414b3458883277ad36952892.1594056572.git.gitgitgadget@gmail.com>
 <xmqqeepo9yjb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeepo9yjb.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 7 Jul 2020 11:24:08 +0200
Message-ID: <CAFQ2z_Nvieyfy4AWz8=sRjsbuXgv1HLVosH78p4Axj5vce5yNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 6, 2020 at 10:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> > This is consistent with the definition of REF_TYPE_PSEUDOREF
> > (uppercase in the root ref namespace).
>
> I wonder if some special casing we saw for "HEAD" in 1/2 (e.g. we no
> longer do this to pseudorefs in this codepath but HEAD is different
> and will continue to be dealt with in the codepath) needs adjustment
> after this change?  HEAD still needs to be able to have a different
> value (either detached or pointing to another ref) per worktree, but
> it is unclear where that knowledge now resides in the new code.  Are
> we declaring that all pseudorefs are per worktree (which I think is
> not wrong)?

the source code already says

enum ref_type {
 REF_TYPE_PER_WORKTREE, /* refs inside refs/ but not shared */
 REF_TYPE_PSEUDOREF, /* refs outside refs/ in current worktree */

but considers HEAD a REF_TYPE_PER_WORKTREE, counter to the comment.

IIRC, this change actually has almost no effect, because most code
treats both enum values as equivalent. (see eg. builtin/reflog.c),
except for the code that the preceding commit changes.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
