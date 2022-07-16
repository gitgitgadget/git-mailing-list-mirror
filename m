Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA86C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiGPLvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiGPLvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 07:51:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC621E1F
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 04:51:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so9287436edb.9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrWizspTPdeYz11wnBXzjGjKLnNAM37KmNEI3k72DQw=;
        b=q0IFsDVvfQTbAJ6njYy0W99L737r4nAIiuatpqoag3ZvmrOJ8ej7rTD0RMAp5yLCow
         tIcGYgF3HCsBT9qA25I8yjMiKiG/N7brHx3LLw6oAsQLYV794oRUOz4mVJB8SQCs6KUM
         DBMBkgDJY03YXrZ2ewFntptxPMEbAh79XCT/Y80Q1EJBXA+GBjPX9GszsictapEALx9J
         7AfLcqJ3oh8NHR0fKRP/M3ovCVgLTThE3NB0D8dSB89+bBx5RGubxAAbFMinrRfVp+Sp
         NeJZjckXl6fvD7Yben207XBM5Xu4fNgMPnpFmQIBHSmEi7DbVSxInquXJMxtKSWpmBDM
         1rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrWizspTPdeYz11wnBXzjGjKLnNAM37KmNEI3k72DQw=;
        b=M2rQDSzEUyVc8Ge/MNjnUGnThk19cvGLUM5JjVsIME0y/sGbRNZfysUzmCOrJ7Ojl4
         BgveJa8yOJZ+3oSgrGRAHVk1hGnMPYAGMS/h8DOBVr/R9DWHHpe0K2dHtMnP6Nxp/KQH
         xrYOd7ugWTgjuz9QgG4Bxd0ilrXvDCFbni8dhsQ2govMGUkyK+8vdj5D4BzMUCtbdTPb
         LaSxupMnr4Vi0ozxtDBRVX6RjIxjwwvnCefgWwm/D9bwz835Gz/QoSL6fdGfdD01flyx
         9CYDOJEfR6mPuKK5byIWtSslVSL/w0723iySAlMjIePohCaer8ss6RReiyzf5t9b3Geg
         dx1Q==
X-Gm-Message-State: AJIora9yN1ne1PFTVWdzqT+7iPETVUY5VoOHAh1S1kcyP0bHqC7h6CC5
        UAcJ7E7u5AyW2XHPnjsbRPrUbK6sEBrmwJNgOHY=
X-Google-Smtp-Source: AGRyM1swJPlervBnTo5P3qy6G1f64dtifqcR2THoQxiVoM/3gzRfJDSd7l7I0iNPg4nnN/DIulDrbvCK2KatffsTifI=
X-Received: by 2002:aa7:db50:0:b0:43a:6319:e2bc with SMTP id
 n16-20020aa7db50000000b0043a6319e2bcmr25370296edt.237.1657972269002; Sat, 16
 Jul 2022 04:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
 <YtDPePTo52A+Uo0p@nand.local> <CAPOJW5x8Vf2qJ-109UH=gvy2i7HdfbFH84hb6fD+YUBN4-GkRg@mail.gmail.com>
 <YtHm+Dv0lN3Ktibx@nand.local>
In-Reply-To: <YtHm+Dv0lN3Ktibx@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 16 Jul 2022 17:20:57 +0530
Message-ID: <CAPOJW5yH=Xywqos2tPS4Cn7dAdDqymPVbb6tn_XoAz0ofsACAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 3:45 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Jul 15, 2022 at 09:28:25PM +0530, Abhradeep Chakraborty wrote:
> > > If that's the case, then I'd expect that printing `index[table[j]]` for
> > > increasing `j` would output OIDs in increasing lexical order. But that
> > > doesn't quite seem to be the case. From a debugger session that has a
> > > breakpoint after computing and sorting table, along with building
> > > `table_inv`:
> > >
> > >     (gdb) p oid_to_hex(&index[table[0]]->oid)
> > >     $17 = 0x555555983ea0 <hexbuffer> "0006763074748d43b539c1c8e8882c08034ab178"
> > >     (gdb) p oid_to_hex(&index[table[1]]->oid)
> > >     $18 = 0x555555983ee1 <hexbuffer+65> "001ce83dd43f03dcfc67f29d38922e4a9682aab0"
> > >     (gdb) p oid_to_hex(&index[table[2]]->oid)
> > >     $19 = 0x555555983f22 <hexbuffer+130> "002db882ece2ab6a240e495a169c6e06422289c8"
> > >     (gdb) p oid_to_hex(&index[table[3]]->oid)
> > >     $20 = 0x555555983f63 <hexbuffer+195> "0007a5feb040e1ff704f3ad636619ddca3e7382b"
> > >
> > > that doesn't look like the OIDs are increasing in lexical order.
> > >
> > > I'm not quite sure if I'm even looking at the right thing, or if this is
> > > to be expected, or if the comment isn't quite accurate. If you could
> > > help clarify what's going on here, that would be great.
> >
> > I think you're not looking at the right thing. you should look at
> > `writer.selected[table[i]].commit->object.oid` instead. I think the
> > order of `index[]`
> > is not the same as the pack index (or midx).
> >
> > I am saying this because if we use the `pos` variable (that we get
> > from `commit_bitmap_writer_pos(&writer.selected[table[i]].commit->object.oid,
> > index, index_nr)`) in `fprintf(stderr, "commit hex: %s\n",
> > &index[pos]->oid);`, you'll see that `&index[pos]->oid` and
> > `&writer.selected[table[i]].commit->object.oid` are not same. So, If
> > you do -
> >
> >   int spos = commit_bitmap_writer_pos(&index[pos]->oid, index, index_nr);
> >
> > you'll see `spos` is not equal to `pos`.
>
> `index` there comes from the list of objects that `pack-objects` or the
> MIDX told us about, and it's sorted in lexical order (via
> `write_pack_file()` -> `stage_tmp_packfiles()` -> `write_idx_file()`).

This was a bit strange for me because all the tests were passing. But
now I find the reason why your results were not in lexical order. you
were doing  `oid_to_hex(&index[table[i]]->oid)` which is not what you
intended to do. Let me explain it with a simple workflow -

Suppose 12 commits are selected for bitmaps and are sorted by their
date. I will now use their  index numbers to denote those commits
(i.e. `0` denotes the most recent commit, `1` denotes the second
commit in this order and so on..).
So, before that quick sort, `table` = {0,1, 2, 3, 4, ...,11}. Now
suppose, `11`th commit is lexically smallest among all the selected
commits, `5`th commit is the second smallest commit and so on. So,
after that quick sort, `table` array now contains the following - {11,
5, 9, 4,0, 3, ...}.

So, when you do `&index[table[0]]->oid`, it becomes `&index[11]->oid`.
Similarly, `&index[table[1]]->oid` becomes `&index[5]->oid` and so on.
That's why you're not getting the oids in lexical order -
`&index[11]->oid` gives the 11th oid in the pack-index and
`&index[5]->oid` gives the 5th oid in the pack-index.

So, the right thing would be to do
`&index[commit_positions[table[0]]]->oid`,
`&index[commit_positions[table[1]]]->oid` ...

Here `&index[commit_positions[table[0]]]->oid` becomes
`&index[commit_positions[11]]->oid` =>
`&index[pos_of_11_commit_with_respect_to_pack_index]->oid` which
ultimately prints the oid of 11th commit ( among the selected bitmap
commits IN THE SELECTED BITMAP COMMIT ORDER) .

I think the comment I added is not that good. The following might be better -

    At the end of this sort table[j] = i means that the i'th
    bitmap corresponds to j'th bitmapped commit (among the selected commits)
    in lex order of OIDs.

> Thanks,
> Taylor
