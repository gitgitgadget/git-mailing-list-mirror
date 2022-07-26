Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8FC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiGZS5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbiGZS5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:57:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33B33A23
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:56:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy29so27688789ejc.12
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GFdLCRqWrURS1gt89kXF2TQUhnyOVjTFNg4xpyZVbE=;
        b=dCQVptfs9sfTGogNJrJCYPVNemwXt6gkYIiRXfd1ia7LDgPTEv7aXUEp0CY586dfqU
         fmLfAmne57T1F3nikTt+iRdJQLeWGy5RJsPGCHFp4bKWqRT/T5TsW8oGoU4ZHLB4w8U0
         /Htrw6FqO8QkKkRjSNvEc4dA/6wVTo6pd+vl9z3dZO/ttsvlGirGz8zPs/pJC+LJpmPV
         gpSEkZ6FA1BGA4jxQtnWY3su2gXn2o5slgITUdTA59Rjp4WXmKSH979EhHE1pDYcaYcM
         DvbiQSaHm1XF52U89T0K8k9c6eVdRDvspX8JzEiOKNF8NBwGbRK9icc6IfGEuYNvAU7r
         O5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GFdLCRqWrURS1gt89kXF2TQUhnyOVjTFNg4xpyZVbE=;
        b=GOw+xCgA1X130lmHNY7GPH6VPUW91NXCNiysAIhhWIKpxW9073AWl8PeQaUBsTNu6O
         0WMLS1OLlgLicShTwnauCWZJCsn+dEQA3HpvNztCTJuYMSIpla7cugLgmgtFfwvjCZqu
         89jopQil7GDsgl29Slp+ifDpek3z6Z9raQahKqAda7JGrrLdz37CS2F5IJOLHxmR3OAD
         vRUgUPl0u+ukbPc5+WTjkDXx9fmmcbHvsOvV1SpbJ5/I+/LTlVtX1yNxWbZAZHjDigX5
         Qr2i7N9JWvfrpe1RSuJvGSSWpVEI3a/uj5R5ybV0aaFaZQL4cw8p1ABih4+6anBBoYPR
         is2w==
X-Gm-Message-State: AJIora+0neJ3ShHc4pXvTPgJQhbgWmhkvp2zJTVTfjFjRH0Bsb7uJ190
        rpJARlZF1uYH1YwxccGBxfnCrWx5xnt1y2r7Mgc=
X-Google-Smtp-Source: AGRyM1uUrXtPKPDzU2U+Cndey/t0Eccl2xVxrNbK28J2fIwMIaNbTwqbr7e5R6eMhYr4Quvcrzr3/Pq68r2NGEzhXR0=
X-Received: by 2002:a17:907:28c9:b0:72b:7165:20c2 with SMTP id
 en9-20020a17090728c900b0072b716520c2mr15375761ejc.120.1658861817230; Tue, 26
 Jul 2022 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <6918f0860adbea1156fb7a9f1a5aedd211872481.1658342304.git.gitgitgadget@gmail.com>
 <Yt8/zl/uOLRBRS4h@nand.local>
In-Reply-To: <Yt8/zl/uOLRBRS4h@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Wed, 27 Jul 2022 00:26:44 +0530
Message-ID: <CAPOJW5y74tj89OxJg0zSY90J2K5TG57ztGQq_8_LQ_DDxMQBGA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] pack-bitmap: prepare to read lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 6:43 AM Taylor Blau <me@ttaylorr.com> wrote:
> Just noticing this now, but I wonder if we could avoid incrementing `p`
> here and instead write something like:
>
>     triplet->commit_pos = get_be32(p);
>     triplet->offset = get_be64(p + sizeof(uint32_t));
>     triplet->xor_row = get_be64(p + sizeof(uint64_t) + sizeof(uint32_t));
>
> I don't have a strong feeling about it, though, it just seems to read a
> little more directly to me and avoid modifying a variable that is only
> going to live as long as the function executes (p).

Ok, will update.

> > +/*
> > + * This function gets the raw triplet from `row`'th row in the
> > + * lookup table and fills that data to the `triplet`.
> > + */
> > +static int lookup_table_get_triplet(struct bitmap_index *bitmap_git,
> > +                                 uint32_t pos,
> > +                                 struct bitmap_lookup_table_triplet *triplet)
> > +{
> > +     unsigned char *p = NULL;
> > +     if (pos >= bitmap_git->entry_count)
> > +             return error(_("corrupt bitmap lookup table: triplet position out of index"));
> > +
> > +     p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
> > +
> > +     return lookup_table_get_triplet_by_pointer(triplet, p);
> > +}
>
> Very nice. This cleans things up nicely by being able to call
> lookup_table_get_triplet_by_pointer().
>
> Since these are static functions, it doesn't really matter whether or
> not they are prefixed with 'bitmap_', since they won't be visible
> outside of pack-bitmap.c's compilation unit. But it may be nice to
> prefix them with 'bitmap_' just to make it extra clear that these are
> internal functions meant to be used within the bitmap machinery only.

Yeah, sure!

> > +     static int is_corrupt = 0;
> > +
> > +     if (is_corrupt)
> > +             return NULL;
>
> What is the purpose of this conditional? We don't modify `is_corrupt`
> before reading it here, so this should be dead code, unless I'm missing
> something.

My intention behind this code was -
Initially `is_corrupt` is 0, so the above code will not execute for
the first `lazy_bitmap...()` call. Now, for some reason, if we get to
know that the `.bitmap` file is corrupted, the function will `goto
corrupt` and `is_corrupt` will be set to 1.
As `is_corrupt` is a static variable, its value will be preserved. So,
whenr we call `lazy_bitmap...()` function for the second time (or
third time etc.; i.e. `bitmap_for_commit` under a for loop), we
instantly know that `.bitmap` file is corrupt (by seeing `is_corrupt`)
and we will not do all the computations any more.

>
> > +     offset = triplet.offset;
> > +     xor_row = triplet.xor_row;
> > +
> > +     if (xor_row != 0xffffffff) {
>
> Is this outer conditional needed? I don't think it is. If xor_row is
> 0xffffffff, then the while loop below won't be entered, and
> xor_items_nr will be zero, meaning that the second while loop will also
> be skipped.

Yes, you're right - it is not needed. But it guarantees that all the
code inside its braces will be run only if has a `xor offset` causing
the allocation of `xor_items` array as lazy as possible.

Should I remove it?

> > +                     bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
>
> Could we write:
>
>     bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t)

Sure!

Thanks :)
