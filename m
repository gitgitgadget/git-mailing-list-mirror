Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E1C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 14:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379041AbiBHO6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354203AbiBHO6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 09:58:35 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019EC061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 06:58:34 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id l14so9889712vko.12
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=phbgsgT+ZUxIy6MxXIOY5Xo0NG6fipIGAztnF6dZwHI=;
        b=bWXsEyENU0lNqVh8ftJUMKRYX+XvDMOs70H8d8Bd9LERfR64r6YJ+JRHZah9KOi7Xv
         H3+3Vap2cznMr2w1eAzESauRR29s+LkuBojc0VxmWj5JnDYu+nQriRxEbqbVixANIGsg
         dkWGROuuFWe02xA2AvF6x9hA3k0zzAYYli7LrEE9VpuXM3dyxDOG2l4R5fcDlz63y8zB
         +MUy3TMm0sVEWHaXdoXh4SWbKNNYhBmQ51yjXuGR54Wq4xwdigWt0zYMMtwqVEaPtkjA
         c894habcgxPtQT6Z3P7UyDaMAElgTb+iRsn/NAqcii3B9BkyfpSVgcuylMDhdgDWMGT/
         mb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phbgsgT+ZUxIy6MxXIOY5Xo0NG6fipIGAztnF6dZwHI=;
        b=BvVfDywk+ZDIAKbq0AFD+ufjFcgIWrEbbS/eUaW9dWgOHtw7DFvjc4pWawAuU+KQEy
         hCo/AHLwatCD4qcHIE+YlJFlzc3zwgABqRv3RJPXUZkGgzzFeR0sVgRJzrU4jYcVDuDV
         jiwkEIsPF2NlLDmB+249eWZXnXcX6m64x2dV/fUcAOPbCDuCPPnQaP9tX4yPt/3q6mZF
         hx9rA4MvMTcot9rIkuuMPpw2m0MgmDpOvTfX2XEDAvDYuU1fF3yaOoz1neeUITzBT1xA
         TfrW2K6jD8d24HSLTMb+8oXIKHIpvjzPlpaK+NSYGgEdaXISQIB+rp3OVdQX/UcBDcdC
         //7w==
X-Gm-Message-State: AOAM5318QNXjvX8/r136iIWhfscqEvH/ByK4SgAPqYdaUiHeI+f/epf/
        IdtrhbNgbZ+9mSC9zAlIRF5YyX5WdM2hvorNb+sIVWZ5l4k=
X-Google-Smtp-Source: ABdhPJzAxigHBmey7D8XEO10/diGwaqxcQzppCManmHGJB0IYKM7QQeJ/AJXBHAcX/miJVAISnU1RGQ/bWCDiME6adA=
X-Received: by 2002:a1f:2d0e:: with SMTP id t14mr1889614vkt.37.1644332313425;
 Tue, 08 Feb 2022 06:58:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
 <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
 <xmqqa6facn9i.fsf@gitster.g> <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
 <xmqqsft2b5jl.fsf@gitster.g> <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
 <xmqq4k5fr1mh.fsf@gitster.g> <CAFQ2z_Nb=wY_+B1ub0XDgZnvgCHGmFu1rjMuKgbFFir0=1PHtw@mail.gmail.com>
 <CAFQ2z_PE_ERoocVjUGCqcFxTDUy79PFbkCVh-y+At7KvXx8TtQ@mail.gmail.com> <xmqq35kugs9j.fsf@gitster.g>
In-Reply-To: <xmqq35kugs9j.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 8 Feb 2022 15:58:21 +0100
Message-ID: <CAFQ2z_P3MNTSDwqjfCDNU8jStCFtqXsP5vpcJsxr25B0JLxP=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 12:40 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> It also has less chances of creating complicated control flows
> >> (especially in JGit which wasn't designed for this bit from the
> >> start): the tables have to be written in lexicographic order, so you
> >> only can write this bit after you know if reflog entries were written
> >> for a certain ref.
> >
> > Correction. I wish the table blocks were written in lexicographic
> > order, but they are written in order 'g', ['i',] 'o', ['i'], 'g',
> > ['i']. Since the 'g' block is last within a table, we could add a new
> > section at the end.  My point that this is considerable work to think
> > through how to make this work with JGit still stands, though.
>
> As long as a fake/NULL entry in the reflog is invisible to iterators
> and does not count as part of numbered entries when reflog@{23}
> notation is used, I think it is perfectly fine to take that
> approach, instead of "separate bit".  I brought it up only as a
> possible alternative (i.e. "if bit is on or any entry exists, we do
> have log for the ref") in case ignoring the fake entry is impossible.

I implemented this. It was very clean and easy; I didn't yet check if
JGit can handle it, but if it doesn't, it should be easy to fix.

You can drop patch 2/3 (ie. this subject line).


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
