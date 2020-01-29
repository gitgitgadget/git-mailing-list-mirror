Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B2C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528A20661
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bntg9mtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgA2SlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:41:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35963 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgA2SlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:41:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so1123437wma.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mK/uxdgn6o7UY1f/sHimGKbk9LyOZOPs5M51f4PsdWw=;
        b=bntg9mtQq8O26dCCvBiybgLEC5vYbVlgLDbpV8tFlFVfwJe8MDNwofhcCBhTjJu3zT
         WppmAQTOrRCbHSHPwRxNPo0Bk6aNJvc+eKm1KYi/Nrv9uv7kPuolm+l6dic6qdEAdIPK
         /BDxH53UyybeKKedclFP4tUDv8k+cwDOt4Dad7RSQ3h/BhMD63DO7HRDr8QA+cNcAeeV
         Pal4AufkckGYaABR5zTnIdUCZqIZ4xIja+6IYYuOlDVIkP41FXFoMJS2KWme5csIBddN
         kIBjlHyIayEMsGphxnkx7qriQrjT9gsivTakWKJ7+arV/fgX9yg1SmZTd6+TVV633lan
         3ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mK/uxdgn6o7UY1f/sHimGKbk9LyOZOPs5M51f4PsdWw=;
        b=hD58l5sx/9hzxhfgew2CyYqy//vXWuaODDisikGR37t+N+haWzyYi1eeDjb6N+IEOO
         CEXVaZQO6vUkJoDXsES0SpPhlmSsejZPQJB2ZDsxJdpcZmHxiGBtbh6Y0DTURhy72Vcj
         3LCYhizyLlPMWmk3gxOVU4UmBa0PsnYbw59B3uNBG5hfthYmxnMwOmTkZr5umty1pyR2
         fNQRCaqBA5K7TAodbB2ar0+nzIJWMuVw9Egx3RuC4jdkymdtt0G5njOp3z50WMtkF1r6
         2kQORLEWoxH8GWO/owxo92K/8rmYu01njlk5PClkfrGDmGxMdAYLmW0aK3gWOlWuBYs/
         Yb/w==
X-Gm-Message-State: APjAAAXPCHqUrEduGnUM5+3SCMlev3VTZpV5evKaj2H+eU3vBAp49kjf
        sICdAEibNpn6LkxKNF7Ml/z5cPEqElLwn9RZ+IPEzg==
X-Google-Smtp-Source: APXvYqy8hTRsnIC8XntCMUpmmygxQi5ScsHvUt9xA5Z6ykyUg/UhEsUW2qAif1ayP2PgZv5szBHFzktCq2azXuuq6dE=
X-Received: by 2002:a1c:660a:: with SMTP id a10mr610089wmc.122.1580323262429;
 Wed, 29 Jan 2020 10:41:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <2215899.n3y15ba4yI@mfick-lnx> <20200129081259.GB601903@coredump.intra.peff.net>
 <9138554.c73hJVQVja@mfick-lnx>
In-Reply-To: <9138554.c73hJVQVja@mfick-lnx>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 29 Jan 2020 19:40:50 +0100
Message-ID: <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 5:49 PM Martin Fick <mfick@codeaurora.org> wrote:
> > If you're actually doing the correct locking and packed-refs read (whic=
h
> > "real" implementations like libgit2 do) then no, I don't think that's
> > dangerous. And I think libgit2 properly complains when it sees a
> > repositoryformatversion above 0. I don't know offhand about JGit, or an=
y
> > of the lesser-used ones like dulwich or go-git.
>
> Today, some of these sound like shortcuts that are very likely taken quit=
e a
> bit by cleanup and other maintenance scripts (not necessarily formal git
> tools), and the impact of these shortcuts is likely low with the current
> model. However, I suspect these tools/scripts could be seriously disrupti=
ve if
> we leave the refs dir around when using reftable,

Maybe we can leave the refs dir, but have no heads/ directory inside,
and make the whole thing read-only?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
