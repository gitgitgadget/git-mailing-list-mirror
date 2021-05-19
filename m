Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D420C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6250D6108B
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353411AbhESMfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353387AbhESMfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 08:35:32 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D5C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:34:11 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x9so4377929uao.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeHZywIMTpnaVFzXqZ3uE2nnYzSdHjX/m7wLVOulCA0=;
        b=b1bAfZnVUioMW8f51UD3LUPjPAIgQTdsN+ty7yU+ScbFL6tOkbzTBQjOxvLVdKdBj/
         lfPdUKtgyCTZ7XbGFoZaCGvlGyptk/WNtU/YJqqVGEXTknFYBfCmZI+1mkkrAEo0Ey7z
         7WXMFpFelT+0AOsay9A/ZslkEj7WkoFOmlVtEVGP3x/qxKOv7WCBjks1pHnNIwggnZ20
         lbS/bdbpZf9Yr4oikSlbHH7i0rcnNuXt9oNNGx2PEfEPSB8DVoQgdVdKMIjmg5liLx5C
         TTHGFFbpr6kyhTerzpNq4kQ28NseCI+aoc69tRXApaZ87hEW0OEKltbbp9PoX5pkyh1j
         e8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeHZywIMTpnaVFzXqZ3uE2nnYzSdHjX/m7wLVOulCA0=;
        b=tO5C5NAEECrMv3IczSsnTaIprEkjWFl71iBZ0h8RtQvyqScAjFb4RNwhgr07iNWuts
         AaQGoL0FU0LD8G7Dg+opuLNcgMzhn69n6/TolwUunpKWtGrrctweRI6fnmvFX2om+vbi
         YEt/ZzRtg+y+8qVbswMif7TDoeahJP/G2UE6o5kCXi+dHjgPKlCzfO7mGdAHG0GhwNtC
         nPpyds1mfMtIi/3lEJk8tliwlU/IEExTCtu8N1z9FOCEpp404EWO7cajsG6BJxpaosd+
         Gt2Boli655DDk+UBDL6kOeM8OZwFrD8quBouBnHZtnswQVaZt89XS4gqQ8X0V2qZ5NLf
         /U7g==
X-Gm-Message-State: AOAM530c++lpWE+3pyetFtP690MW8L91C97PnSu66mNkm11De9d5IFQo
        6t/BZCtAKOrkbiBrwC2lZ/w+h9QJNCqCmGsp6ES2XQ==
X-Google-Smtp-Source: ABdhPJxVdxlJTmmcW6QOTy7eqLddkGBXlbdm1KFGY/04pu7ja+qtxrRkeTGyI50WglyOnE5GoSTr2MMHsgM3yIh6Ocw=
X-Received: by 2002:ab0:3b8b:: with SMTP id p11mr15005417uaw.112.1621427650890;
 Wed, 19 May 2021 05:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
 <xmqq35v8e982.fsf@gitster.g> <xmqqeeescntb.fsf@gitster.g>
In-Reply-To: <xmqqeeescntb.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 May 2021 14:33:59 +0200
Message-ID: <CAFQ2z_PcxOmtg2ZvvhS6TTv+UOw1H+pzAxSd_-JMGQ-GYgWHgQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 8:02 AM Junio C Hamano <gitster@pobox.com> wrote:
> > I like the general direction to move away from errno, which may make
> > sense only in the context of files backend (e.g. ENOENT would be
> > left in errno, only because the original "loose ref" implementation
> > used one file per ref, when a ref we wanted to see did not exist)
> > and having other backends use the same errno would not make much
> > sense, as it is not the goal to make other backends like reftable
> > emulate files backend.
> >
> > I wonder if in the ideal world, we'd rather want to define our own
> > enum, not <errno.h>, that is specific to failure modes of ref API
> > functions and signal failures by returning these values (and the
> > enum includes 0 as a value to signal success, all other errors are
> > negative values).

I think it would be healthy to have a set of canonical error codes in
general,  but I don't know if this will help here. The files and
packed backend want to communicate about very specific conditions
(ENOENT, EISDIR, ENOTDIR), which seem too low-level to put in a
generic error code.

> In any case, the change in the function signature helped me catch
> that this series invalidates what has been queued on hn/reftable
> without updating that topic to align with the new way to handle the
> errno (it would have become a silent semantic failure if we instead
> encoded the "failure" in the return value).
>
> The following is what I am tentatively using for tonight's
> integration when merging this and hn/reftable together to the 'seen'
> branch.

That sounds right. How should I post the next update to hn/reftable ?
(based on which branch?)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
