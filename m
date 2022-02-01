Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08497C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 11:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiBALrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiBALrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 06:47:24 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF53C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 03:47:23 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id a7so15695834vsc.6
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 03:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fpcK8FjssHic9+Rn9paB7x8VucqB6LgCNNyjSoIFwP8=;
        b=tVnnUgFOwyx37Ye8dnrjgfsCIJtAeBxxui9DdahVcFtp/IeJcYkgYZB3zKHtXsygI6
         H1oO7j267z/G0JEDZAs40AgyBzOB44ayYx1uxBbJPJViIoAxbXY6sQyPiz9PaTGkv2Zd
         FWTt+qrftVdxYqlX3rq1Jbq2a73QbQtpCI4D/7LvlepiSXePTtrlLQXkboDBxpWODdEI
         BmB9zyhgkfODwnUravjdircQgeaQYvXv8ywMgtrf3JBNqVoJYS+wdvahSNFMkPX9LwVu
         3uXpK2n0vn+70JPH8DVmnI8xj14LpkTfu7CxxcBQ40aat9/V+8aBFTvti55Pq5+KyFJV
         047Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fpcK8FjssHic9+Rn9paB7x8VucqB6LgCNNyjSoIFwP8=;
        b=lcBICBbduFeo2bKDXypnqqLis18gp/07hgwsSGv11Cls9yseWLTuJyVJdF+S50A2j7
         cvOlmEhYSs4SX4hX3bh4ET73UkVK+UWynGOlPtg01r1NlZ3WWXKfqV22nACxgnGwfBRf
         QDTe0TphPKL9rJufydiVQAjt6TEhnDCAwmxNLmn5C5K05/xbwPdT5m5k0AZzkhth/EaQ
         +tXaMyX60o9fEnOMsH5i5JdPjQsfv96WVXrySkG3PqFRFBhVpBNMzwtpRas57pbr83+j
         l4Gw2Fsn3Vxz0FAXuvC83kk02lqBZ9i9kMTxiViIZNF+i/cHpK7FRh2rOQsxPD+lcf6E
         m1PA==
X-Gm-Message-State: AOAM533hLQgxvB7aSbYI8cKjokdnnxamiMmWR+/VxRZ3qSgZ3wr36hgj
        Ggm3u7TkCgLLkfS60l9RWFk83HjezJG+8RJPGtzFWuGguDo=
X-Google-Smtp-Source: ABdhPJw1wJQ3st83yElAoNHHQUuNTmi6v6xCggWJQ0gBUMfJQZ4yCfCj/28pYx4B9chPLzoXPG+ACCzMDZ0z/Vd6wC8=
X-Received: by 2002:a67:d796:: with SMTP id q22mr9437187vsj.10.1643716042899;
 Tue, 01 Feb 2022 03:47:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com> <xmqqa6fbgx85.fsf@gitster.g>
In-Reply-To: <xmqqa6fbgx85.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Feb 2022 12:47:11 +0100
Message-ID: <CAFQ2z_PtNsrSXdCG_5vr99Fz63GDMpC6j7rzLqOn+cZufi+xfQ@mail.gmail.com>
Subject: Re: [PATCH] refs.h: make all flags arguments unsigned
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 3:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > As discussed in
> > https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
> > want to treat the sign bit specially, so make all flags in refs.h
> > unsigned.
>
> It may be true that we do not want to, but are we sure there is no
> code that already uses some cleverness to make the topmost bit
> special by e.g. doing ugly things like "if (flags < 0)" ;-)?

In refs.h, we don't have any bitmasks that accept 32 different bit
values, so it's hard to see how we would stumble into a case like
that.

> I haven't had energy to vet the entire codebase for all flag words
> and that is why I've never produced a patch like this one myself.
>
> Thanks for carefully vetting after creating this (presumably
> mechanically prepared) patch---producing is the easy part, but
> making sure it does not break unexpectedly is much harder.

I went over the changes once more, uniformizing the naming. I didn't
see any shenanigans.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
