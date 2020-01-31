Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8DCC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A4321734
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMj0sVnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaTTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:19:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38540 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaTTY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 14:19:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so3111978plj.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GUNF9HDDWf3tjE1e79M0yz3ZDQgRwYEsQKpGPK7lFZ0=;
        b=QMj0sVnh0OB6NQtCkQl38jDNGFfYY/ZDHWuZUryRNdaZCOvRn4roE3mVA2Vh/c8vy7
         K15L8ZZ8nNxlhTOiLzBWcwzEIc875Sl5NC19l3zeE+mk21OQnArB7RUf+n765eo4dlr8
         PSqlTkXvv2pjkMAgDB/zBqipRmmKGZTFU4ptQQ5htwDrYElQWhT0L6bFiA5nLAiZNNhw
         aPoJYEjA9dyS717+TMgpi5Zwvxx6MvjWceCBfEEy8FFDLHqrDsJ2M1g2VKtkPhzS3Ym7
         RIo/TMyIHPxQfP4Cm/g5fsJZRPySI6a+GE4UP5f14zvyHUFw/8U/XuqkM7amy2OWU18O
         W2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GUNF9HDDWf3tjE1e79M0yz3ZDQgRwYEsQKpGPK7lFZ0=;
        b=JfJ5wCWlDll7mo9/h5qlwIMURDn6x3PIRL/AS6Bn/wb4Vl3MNLfwIdELYJIpC+TdKf
         bCbZ/Ls7O+4v0mjexG3VjW5jdoSJQ/6Z0Yx4OjCRJbcdL97fhtjM3ojU9AbMlCIDDZ6E
         iZTWXs20/UHYnfUUSQ3jqxwLdqi7+jfpaJpSEVAFEVFwMpjythtK+ltjxdRjD0jqt/FA
         w+KkxyIPyNTrXBl/vInT2uamYCcy6vcY5NLZ/Km+IlRJM0j5JMV2uSA/Voha4mjR/ZFl
         6bhs5IcJPNkFuEvWXhIUAUhmAxB2jWZYQyzMLzB7puUrwpms90p3Pm6qVAfBjX95q23A
         bISQ==
X-Gm-Message-State: APjAAAVqeRk5ZmRORW11Hz9PwHM7WzCKC+Lr58OwZaZ7M4+Ooy4pweqp
        jdnwYvrrhrZQgci3tSs3pRfDTSIm7+ZL8UCYc3o=
X-Google-Smtp-Source: APXvYqzUVSaTbSIhCICIbXkYGcgT0rQxHmohOWq2q2f4SCPewlvhymD3mQ0IvMER3QqIxmcgd4t1AGsBuwvgwP95qpU=
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr14670672pjv.73.1580498364053;
 Fri, 31 Jan 2020 11:19:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580424766.git.me@ttaylorr.com> <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
 <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com> <20200131102049.GC2916051@coredump.intra.peff.net>
In-Reply-To: <20200131102049.GC2916051@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 20:19:12 +0100
Message-ID: <CAN0heSo1a3s5chz=FD-XnLncLwH_N59BPZzqtEUC_nJ8sLJtdA@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct commit_graph'
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 11:20, Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 31, 2020 at 07:52:02AM +0100, Martin =C3=85gren wrote:
>
> > > --- a/commit-graph.c
> > > +++ b/commit-graph.c
> >
> > > +struct object_directory *find_odb(struct repository *r, const char *=
obj_dir)
> >
> > This doesn't look commit-graph related -- could/should it go somewhere
> > else?
>
> I think the right place is actually as a static inside
> builtin/commit-graph.c, as this is really about handling its weird
> --object-dir options.
>
> But it can't go there in this patch, because there's a caller in
> commit-graph.c. In patch 4, we convert write_commit_graph() to take an
> odb, too, and that call goes away. At that point, we could move it into
> the builtin as a static.

Thanks for explaining the issue.

> Ideally we could flip the order of this patch and patch 4, but that
> doesn't work either: by switching to an odb we lose our path
> normalization, but if the other side hasn't switched either, then we
> can't just compare odb pointers. It would be a temporary regression.
>
> So there's a circular dependency between the two patches. I think we
> ought to do done of:
>
>   - move find_odb() to a static as a cleanup on top
>
>   - squash those two patches together into a single
>
>   - swap the patch order, but have write_commit_graph_ctx store both the
>     "odb" _and_ the normalized copy of the path we do now. That leaves
>     it correct, and then it can be cleaned up in favor of an odb pointer
>     comparison in patch 5, along with the rest of the normalized bits.
>
> I'm OK with any of those. The second two have the added bonus that we
> could introduce the die() behavior into find_odb() immediately, and
> explain it (there's another temporary weirdness in this patch where
> specifying an --object-dir outside of the repository becomes a silent
> noop, and then the next patch turns it into an error, but that could all
> be done in a single step when we introduce find_odb()).

... and these ways of addressing it.

Martin
