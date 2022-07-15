Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4EC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 15:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiGOP6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiGOP6j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 11:58:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C24CF7
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 08:58:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so9734925ejr.5
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XmWPfO4PwW9r8esRxNjKL6BJrL7hiT6DZ07GA7z6Dw=;
        b=iDj5++xc/9RttDM5/PbVIs6LDWs2DFzGjEEeQQj9He43qujAmQQx0c9Y/UoGw6kMjc
         hkakdQRiwzsCYDbyhFkZzqo/0M9pEtyirbDf8Z+KGddFLggCZta7/MiBwvV90s45sZW0
         oXpmfqnXyl0kH6Ygz5hs1zzW8TDKj/POoLkSUrffEs14t5eHEilAroW3dvR2IDcO8cdD
         p31g9mN0kew91ze9Fs52IOOD/UXjoTBKu6JFEE6JhqmGuKPslLPKdERSAvb1DT8MDhKW
         kOpys6v5IiH83RRE7NCMrv6vROMBrQRQhbneKO2Ect+WiN7IS4PEHqarc8nGtcC0uWwS
         aGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XmWPfO4PwW9r8esRxNjKL6BJrL7hiT6DZ07GA7z6Dw=;
        b=wTIlEFb+0yH6Cqh3ORQ7hMM+HMek/oEg9zymFlbIRrjnKCs0lC1eBoAnZjK51XXW9S
         joZaUNmtsXx/F/chkdn3qasVV0m7C/MNegAXq853AUauDDqebvgocU6W1tj2GE48IA9h
         QEJ0srHSWmL0OPGdcTF6iAhLufreezf8USwzZZJA+mPNe4xeUVWIDYqXpQNDZqYhtqij
         e3eCf3WprR/3xtPzPRD7RG3AFmwRwwyFwPyWIEvkY3WnQEnkP4mBqccGM5ZzTdGOeVI9
         4tcbKg2VjbL3XTO7u1+sWCPwH3o1YB0nXWlVp6twgfSHhKFKcsSM+D1bR9+yU911gylG
         4Kvg==
X-Gm-Message-State: AJIora+0KTg7irurI5Ro5wqcpFO3ozIVQjT4HVxUB18y9gDIIeroScOZ
        cVmfX8mo+XtTf3rYf9x8XOzfT0nnEbhatfCDZBM=
X-Google-Smtp-Source: AGRyM1uWfgiB5Q+l0W7EjmI8K0Bz1ktxzo1D+RbivGWq3vypY9pxkpsMlJlGmGTe35KmoAI4cnxKqqVas4+yfDjKW3E=
X-Received: by 2002:a17:907:6890:b0:72e:e404:46d2 with SMTP id
 qy16-20020a170907689000b0072ee40446d2mr7024827ejc.578.1657900716990; Fri, 15
 Jul 2022 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
 <YtDPePTo52A+Uo0p@nand.local>
In-Reply-To: <YtDPePTo52A+Uo0p@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Fri, 15 Jul 2022 21:28:25 +0530
Message-ID: <CAPOJW5x8Vf2qJ-109UH=gvy2i7HdfbFH84hb6fD+YUBN4-GkRg@mail.gmail.com>
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

On Fri, Jul 15, 2022 at 7:52 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> By the end of this loop, we have an array `commit_positions` which maps
> the ith selected commit to its lexical position among all objects in the
> bitmap. IOW, `commit_positions[i] = j` means the `i`th selected commit
> can be found at index `j` among all objects in the pack/MIDX in their
> lexical order.

Right.

> > +     /*
> > +      * At the end of this sort table[j] = i means that the i'th
> > +      * bitmap corresponds to j'th bitmapped commit in lex order of
> > +      * OIDs.
> > +      */
> > +     QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
>
> And then we sort table by treating its values as indexes into
> `commit_positions`. Here's where I'm not sure that I follow what's going
> on. You say above that `table[j] = i`, where `i` corresponds to the
> order of selected commits, and `j` is in lexical order.

Correct.

> If that's the case, then I'd expect that printing `index[table[j]]` for
> increasing `j` would output OIDs in increasing lexical order. But that
> doesn't quite seem to be the case. From a debugger session that has a
> breakpoint after computing and sorting table, along with building
> `table_inv`:
>
>     (gdb) p oid_to_hex(&index[table[0]]->oid)
>     $17 = 0x555555983ea0 <hexbuffer> "0006763074748d43b539c1c8e8882c08034ab178"
>     (gdb) p oid_to_hex(&index[table[1]]->oid)
>     $18 = 0x555555983ee1 <hexbuffer+65> "001ce83dd43f03dcfc67f29d38922e4a9682aab0"
>     (gdb) p oid_to_hex(&index[table[2]]->oid)
>     $19 = 0x555555983f22 <hexbuffer+130> "002db882ece2ab6a240e495a169c6e06422289c8"
>     (gdb) p oid_to_hex(&index[table[3]]->oid)
>     $20 = 0x555555983f63 <hexbuffer+195> "0007a5feb040e1ff704f3ad636619ddca3e7382b"
>
> that doesn't look like the OIDs are increasing in lexical order.
>
> I'm not quite sure if I'm even looking at the right thing, or if this is
> to be expected, or if the comment isn't quite accurate. If you could
> help clarify what's going on here, that would be great.

I think you're not looking at the right thing. you should look at
`writer.selected[table[i]].commit->object.oid` instead. I think the
order of `index[]`
is not the same as the pack index (or midx).

I am saying this because if we use the `pos` variable (that we get
from `commit_bitmap_writer_pos(&writer.selected[table[i]].commit->object.oid,
index, index_nr)`) in `fprintf(stderr, "commit hex: %s\n",
&index[pos]->oid);`, you'll see that `&index[pos]->oid` and
`&writer.selected[table[i]].commit->object.oid` are not same. So, If
you do -

  int spos = commit_bitmap_writer_pos(&index[pos]->oid, index, index_nr);

you'll see `spos` is not equal to `pos`.

> > +     /* table_inv helps us discover that relationship (i'th bitmap
> > +      * to j'th commit by j = table_inv[i])
> > +      */
> > +     for (i = 0; i < writer.selected_nr; i++)
> > +             table_inv[table[i]] = i;
>
> This part makes sense, as does the rest of the implementation.
>
> Thanks,
> Taylor
