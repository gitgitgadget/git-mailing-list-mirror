Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A57C433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiBGRD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiBGQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 11:52:50 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E7C0401D3
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 08:52:49 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id t20so303874vsq.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GoNeemhWhs2JoTeFs4jstDPi4WZfJ8nYCt29hpJgQEI=;
        b=MCpOh2HAN1j7xJRuIL3blRgYOU2wxSG09S80oyLm0o57VIoJxiEaEEpz980X2oAUad
         M8PyQ67QMcWwmKJPoQ9MEioQJSRB9OdhJ0qypJnMwO7qIAzHjEcI6jDVbTjWpushvYO4
         gdlnvyloqh9BpcDRTC9pqaveFssmPHujaOnhHXtbXbMdqbZ0i5R5H5JyzpjomrzHX8jS
         1JaQOKvWPsHeU84nf4LhI5WKkDe41ApirwqrfVawXyl9jU+20VV7das15QgadIqH9tiD
         dhMpQynKLGuFbIsOlZYjkoH3u1rG8OixCVZT3bzC5cH73AmNvgj7YtOTmN1m9T6lga35
         3uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GoNeemhWhs2JoTeFs4jstDPi4WZfJ8nYCt29hpJgQEI=;
        b=A1/QzeO1qNm1aIEDaTzgGCygc7538Kpu9UeI3yuKOLWXOZ91dA7PZS7F5os7o/6H2G
         vN3WlQwEW1Rej9gn3Wxx+0sFqbcbNQ9AbXK2qoDvNa/DEtGjG7+MPHIiBVVKBABcM3LR
         AHLy7IcLegA9VCMLcAI0aNzUQfBxf8xulbNMeLEWFV39LFX7sMGHTdpCfPcGPz9yn+8g
         49j5j3j3yXz1ZeoKFqaSOAiEv30tkSonQqflHbWKqtjAtxFInEtQs9d3jwfUeFgsVm8d
         WP693RmPvEzj38BHMvkHnOd8ezjWpd10KnFKybQ/e6UGUthaVqUS0wQ63E97rtm37G18
         Ky7g==
X-Gm-Message-State: AOAM5305LL3tffv7CMOTqQGWyOFRuxwX/354Pl7hu9KbG4kW+DTMyQ0E
        wDcJt9aqmTGh7IKZMGjVfDMiHWuPAhXBAP2xhqVIbg==
X-Google-Smtp-Source: ABdhPJyjGhFs8umJegNIRyjq9POPE8YM3f81wzDYW3vBA+Y5X2AKhOvh24ekX9JysuILTVCgiA01Lv7ffyoddlqtFFM=
X-Received: by 2002:a67:e09e:: with SMTP id f30mr81363vsl.16.1644252768637;
 Mon, 07 Feb 2022 08:52:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
 <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
 <xmqqa6facn9i.fsf@gitster.g> <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
 <xmqqsft2b5jl.fsf@gitster.g> <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
 <xmqq4k5fr1mh.fsf@gitster.g> <CAFQ2z_Nb=wY_+B1ub0XDgZnvgCHGmFu1rjMuKgbFFir0=1PHtw@mail.gmail.com>
In-Reply-To: <CAFQ2z_Nb=wY_+B1ub0XDgZnvgCHGmFu1rjMuKgbFFir0=1PHtw@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 7 Feb 2022 17:52:36 +0100
Message-ID: <CAFQ2z_PE_ERoocVjUGCqcFxTDUy79PFbkCVh-y+At7KvXx8TtQ@mail.gmail.com>
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

On Mon, Feb 7, 2022 at 10:48 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Fri, Feb 4, 2022 at 12:06 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Han-Wen Nienhuys <hanwen@google.com> writes:
> >
> > > Technically, the only obstacle I see is that we'd need to treat an
> > > existence entry especially for the purpose of compaction/gc: we can
> > > discard older entries, but we shouldn't discard the existence bit, no
> > > matter how old it is.
> >
> > I was hoping that we already have a type of block that can be used
> > to record an attribute on the ref (other than its value) and it
> > would be just the matter of stealing one unused bit from such a
> > record per ref to say "when answering 'does this ref have reflog?'
> > say yes even when there is no log record for that refname".  Or the
> > table format is extensible enough that we can add such a block
> > without breaking existing clients.
>
> That place doesn't exist, unfortunately, but even if it did, having a
> special reflog entry indicating existence is a better solution all
> around, I think. A separate per-ref bit allows for data
> inconsistencies: what if the bit says "there is no reflog", but we
> actually do have reflog entries in the 'g' section?
>
> It also has less chances of creating complicated control flows
> (especially in JGit which wasn't designed for this bit from the
> start): the tables have to be written in lexicographic order, so you
> only can write this bit after you know if reflog entries were written
> for a certain ref.

Correction. I wish the table blocks were written in lexicographic
order, but they are written in order 'g', ['i',] 'o', ['i'], 'g',
['i']. Since the 'g' block is last within a table, we could add a new
section at the end.  My point that this is considerable work to think
through how to make this work with JGit still stands, though.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
