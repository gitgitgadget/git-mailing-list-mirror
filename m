Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FEFC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiGOWQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiGOWQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:16:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87FD5A2E0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:15:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r17so4805151qtx.6
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wo0lA+0vms1wyLmcseeRYmnE0dtVi9R1oofH3tMH2D0=;
        b=7m8skZzQedLmalmf9ZFXOGTwa/DoJhhiY9gRa+ZlpAKFmK6jcEY0WAJz2dNTEVGp3M
         jAkFwFDiPBzAaT2fOERt6hg0OxR7YKTkxC3fbHJa90Rg58yVvMBMN4JWCuNwJCgtslvv
         O4GhrBOXL7mBxoVBTGsfVBtWHXqBAg8RvRsdjd4yNMMfZKw4Nm+0AKHejmttxAJSUCiQ
         J29kKc+kpNLl4q63wfTwSHrUNpkOKX8B63glYDt9lQgqZSPPfQuCj5Bze6pDM1jH/cSc
         XQ3oZxLCQBI6Z2DZLJkoALMxjCi6hy7vxybPCEk+daikwrUaZHv2+Vp2ut8P3zD/Tpjf
         rVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wo0lA+0vms1wyLmcseeRYmnE0dtVi9R1oofH3tMH2D0=;
        b=x4k5bRWIPk6jUFdKqJ8Qg4JzN9IG0FH2lvohO2Y/9AvEUedmw7P54A4z8KpqFz/B1S
         Ek2N04ySwNaVpsuWnMVsD6XNIW7lGMtVjm+ydUb3ASoyycG/mVaL00Ehfgi6u2+H4OjI
         DhF8Fvj6lwIty+s0sdErqvkmX93lbeoV1D570ar4TSnJljYZxuT0w06RQ21zpQ+Ob6pd
         ys+PtbUXjHo2Uhazj+dEFwU3CGraEIroy97TTGbb6rK9737X+hkcR1NBlvRJTKRXimGI
         15PaUxHeBkQ4I5/n76I8trvypR3j5XNT1knJtN9L+EZjs5HJKHf/SpYoXdoYXB6ip9WE
         xK4g==
X-Gm-Message-State: AJIora8MmsvpaRz3vExbkShPMnDJKVq5Z8WIbFuO9DK/h+CchIPYEPas
        t5uQVjyVDyt039MZE7t1lg/0iA==
X-Google-Smtp-Source: AGRyM1tZJSRfLpeyouONP/sFq6SYTecu+yZbD5IAIq3wEhON7nC2YkJ8iD9znLdxt6P4z4VpQJiU9g==
X-Received: by 2002:ac8:594b:0:b0:31e:c570:d2b5 with SMTP id 11-20020ac8594b000000b0031ec570d2b5mr14157277qtz.96.1657923321400;
        Fri, 15 Jul 2022 15:15:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id br40-20020a05620a462800b006b59cf38b12sm4957180qkb.126.2022.07.15.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:15:20 -0700 (PDT)
Date:   Fri, 15 Jul 2022 18:15:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YtHm+Dv0lN3Ktibx@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
 <YtDPePTo52A+Uo0p@nand.local>
 <CAPOJW5x8Vf2qJ-109UH=gvy2i7HdfbFH84hb6fD+YUBN4-GkRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5x8Vf2qJ-109UH=gvy2i7HdfbFH84hb6fD+YUBN4-GkRg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 09:28:25PM +0530, Abhradeep Chakraborty wrote:
> > If that's the case, then I'd expect that printing `index[table[j]]` for
> > increasing `j` would output OIDs in increasing lexical order. But that
> > doesn't quite seem to be the case. From a debugger session that has a
> > breakpoint after computing and sorting table, along with building
> > `table_inv`:
> >
> >     (gdb) p oid_to_hex(&index[table[0]]->oid)
> >     $17 = 0x555555983ea0 <hexbuffer> "0006763074748d43b539c1c8e8882c08034ab178"
> >     (gdb) p oid_to_hex(&index[table[1]]->oid)
> >     $18 = 0x555555983ee1 <hexbuffer+65> "001ce83dd43f03dcfc67f29d38922e4a9682aab0"
> >     (gdb) p oid_to_hex(&index[table[2]]->oid)
> >     $19 = 0x555555983f22 <hexbuffer+130> "002db882ece2ab6a240e495a169c6e06422289c8"
> >     (gdb) p oid_to_hex(&index[table[3]]->oid)
> >     $20 = 0x555555983f63 <hexbuffer+195> "0007a5feb040e1ff704f3ad636619ddca3e7382b"
> >
> > that doesn't look like the OIDs are increasing in lexical order.
> >
> > I'm not quite sure if I'm even looking at the right thing, or if this is
> > to be expected, or if the comment isn't quite accurate. If you could
> > help clarify what's going on here, that would be great.
>
> I think you're not looking at the right thing. you should look at
> `writer.selected[table[i]].commit->object.oid` instead. I think the
> order of `index[]`
> is not the same as the pack index (or midx).
>
> I am saying this because if we use the `pos` variable (that we get
> from `commit_bitmap_writer_pos(&writer.selected[table[i]].commit->object.oid,
> index, index_nr)`) in `fprintf(stderr, "commit hex: %s\n",
> &index[pos]->oid);`, you'll see that `&index[pos]->oid` and
> `&writer.selected[table[i]].commit->object.oid` are not same. So, If
> you do -
>
>   int spos = commit_bitmap_writer_pos(&index[pos]->oid, index, index_nr);
>
> you'll see `spos` is not equal to `pos`.

`index` there comes from the list of objects that `pack-objects` or the
MIDX told us about, and it's sorted in lexical order (via
`write_pack_file()` -> `stage_tmp_packfiles()` -> `write_idx_file()`).

So I think this implementation is indexing the commits by the order they
appearn in the `writer.selected` array, *not* by the order they appear
in the index.

For what it's worth, I think the latter ordering makes more sense to use
to refer to individual objects. But we should be consistent with our
choice here and what's in the documentation. And right now I think we're
not, since the documentation change in the first patch says we write the
`commit_pos` field in order of the index:

    * {empty}
    commit_pos (4 byte integer, network byte order): ::
    It stores the object position of a commit (in the midx or pack
    index).

Thanks,
Taylor
