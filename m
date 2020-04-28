Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93AC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128282070B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1l5ApMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1UVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgD1UVf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 16:21:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C61C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:21:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so25489213wrt.5
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p0WwZ3KsALVautA+m8Kl6Wj7qBm85lAmpsj+3X/nQVE=;
        b=V1l5ApMfy5PhebGbhU8Q7NSJJWCRhiYuoeMGd9ew4b52U3IJ0/w6Kq/7F2p5VHzPNd
         9itfUA/jpOn2OjhtVdkCryVdQnRcetTxG2GyYr5rLPvCssRASMj+LZWKcsNq6NKPa1q8
         OCKWSA1VMGjoZCzu/wwjGDOykSV2nnyVLlTe0TFpgs+fsZcZE0j0GagGz68mY1kMqNei
         5/cJjvqm6mxhufaVdJqAXtUP+opJvt9RwvqlcUSyoT2aIDZwX0G7wIuPWNpjXDu3VMys
         7jABP4f5bRAq0IKLH/M6RPEe01S7um8pCRMg5655gnuZDGCJbRAeGYf/3X4Yd08QtVq3
         4hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p0WwZ3KsALVautA+m8Kl6Wj7qBm85lAmpsj+3X/nQVE=;
        b=f4oMmmgAJBJ2wpx6Bci3KlLZ7FLupaDXr4h3axMH4lp+a15MQtaMMOq3RoTRIMP46D
         Re2Pj4mrVHIAhFWHvSRuRJi+XMIYDdToe1stBoXp5bkT4Uyeb8qXtbsPHA8ZfDBcB9TN
         oD2ReQWwiojdWcsg9ic7I6AgXqqTDN4bqHzqrKcZfKwLtDaxllZqG8VC73lMQqnbgvDm
         5XGbmTgz3iOBLZFJFoYFsxdD5cVJyqrlpEl3oE/7BzqtR2Te78BmxyHgbJEFMgtGd/6R
         5gL8uQc2yiDMWhvLXlrXfIzbd3P701Rt9d/VBMpycWwneGUKO6ExB4vnJ2sZE9YM6oRQ
         WuWA==
X-Gm-Message-State: AGi0Pub4bXjfDsAuNLfJLpuZgdAWxTRL+SUh7E5dyONOI9jgAHJTqKQg
        mCcWavd+px4hWhcrw0tHfBjgsZ8HQcL2HZQU4+6MxWlamgg=
X-Google-Smtp-Source: APiQypJINBmtvnS2f8LtHcZhydQlxE63/eOgZo1xlTyLFDedO8McEUakAQil/MwH0WnnQN6s3criM3jMDDIb6ZI4vJ4=
X-Received: by 2002:adf:fecd:: with SMTP id q13mr37114360wrs.12.1588105292122;
 Tue, 28 Apr 2020 13:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com> <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
 <20200428145541.GC31366@danh.dev>
In-Reply-To: <20200428145541.GC31366@danh.dev>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Apr 2020 22:21:20 +0200
Message-ID: <CAFQ2z_NtsmyqqGPRr7YWfTWGRAjrgBv5NtV2k6oMfoSbwuAOEA@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] Add reftable library
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 4:55 PM Danh Doan <congdanhqx@gmail.com> wrote:
> > +#include "system.h"
> > +
> > +void put_be24(byte *out, uint32_t i)
>
> So, we introduce a new type `byte`?

The reftable is structured as a library. The declaration for 'byte',
as well as 'bool'  is private to the library.

> > +{
> > +     out[0] =3D (byte)((i >> 16) & 0xff);
> > +     out[1] =3D (byte)((i >> 8) & 0xff);
> > +     out[2] =3D (byte)((i)&0xff);
>
> At my first glance, I thought that code is:
>
>         out[2] =3D (byte)( (i)(&0xff) )
>
> It's totally un-parsable.

I removed the parens here, in
https://github.com/google/reftable/commit/6f883714588d2658122fefd85a2e2e764=
01ae2be

that also changes a number of 'int's to 'size_t's.

> > +     return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
> > +            (uint32_t)(in[2]);
>
> I don't think we need this much cast. One cast can rule them all.

would you have a concrete suggestion to rewrite this? The rules for
undefined behavior and integer casts are subtle, and I know they are a
cause of concern in crypto code, and I'd rather be correct than rely
on deep knowledge of the C standard.

> > +int binsearch(int sz, int (*f)(int k, void *args), void *args)
>
> binary search?
>
> I think we want all size to be `size_t`

fixed this.

>
> > +{
> > +     int lo =3D 0;
> > +     int hi =3D sz;
> > +
> > +     /* invariant: (hi =3D=3D sz) || f(hi) =3D=3D true
> > +        (lo =3D=3D 0 && f(0) =3D=3D true) || fi(lo) =3D=3D false
> > +      */
>
> Comment style

Review style

> > diff --git a/reftable/basics.h b/reftable/basics.h
> > new file mode 100644
> > index 00000000000..6d89eb5d931
> > --- /dev/null
> > +++ b/reftable/basics.h
> > @@ -0,0 +1,53 @@
> [..snip..]
> > +  find smallest index i in [0, sz) at which f(i) is true, assuming
> > +  that f is ascending. Return sz if f(i) is false for all indices.
> > +*/
>
> So, this is about partitioning, not searching

there is precedent for this to be called binary search. See for
example, https://golang.org/pkg/sort/#Search

> > +int block_writer_add(struct block_writer *w, struct record rec)
>
> So, we're gonna pass a large structure into a function now?

The record structure contains two pointers.

> > +     if (block_writer_register_restart(w, start.len - out.len, restart=
,
> > +                                       key) < 0) {
>
> Eh, naming is hard, and so does this function.

I can't parse this sentence.

> It's overly verbose,
> and long. I haven't go though all of this patch (because it's too
> long), but I guess some of them can be made static and their name can
> be shortened.

For uniformity all functions taking a struct Xyz* as the first
argument are called

  xyz_do_something

since this takes a block_writer, and it registers a restart, it is
called block_writer_register_restart. The naming of this is uniform
throughout the library.

> > +             block_source_return_block(block->source, block);
> > +             block->data =3D uncompressed.buf;
> > +             block->len =3D dst_len; /* XXX: 4 bytes missing? */
>
> Even this is a very lengthy patch, some bytes is missing but we
> couldn't figured out.

good point, I'll look into this again.

> > +     {
>
> This cute curly braces is new to me

Pleased to make your acquaintance!

> > +static int restart_key_less(int idx, void *args)
>
> idx? index? Shouldn't it be size_t?

fixed this.

>
> > +{
> > +     struct restart_find_args *a =3D (struct restart_find_args *)args;
> > +     uint32_t off =3D block_reader_restart_offset(a->r, idx);
> > +     struct slice in =3D {
> > +             .buf =3D a->r->block.data + off,
> > +             .len =3D a->r->block_len - off,
>
> C99 designated initialisation.
> We aren't ready, yet.

I'm sorry, gcc -std=3Dc89 said this was OK.

> > +void block_iter_copy_from(struct block_iter *dest, struct block_iter *=
src)
> > +{
> > +     dest->br =3D src->br;
> > +     dest->next_off =3D src->next_off;
> > +     slice_copy(&dest->last_key, src->last_key);
> > +}
> > +
> > +/* return < 0 for error, 0 for OK, > 0 for EOF. */
> > +int block_iter_next(struct block_iter *it, struct record rec)
>
> If this function is used only in this file, it should be static,
> otherwise, the comment should go to header file

moved comment to header file.

> > diff --git a/reftable/block.h b/reftable/block.h
> > new file mode 100644
> > index 00000000000..62b2e0fec6d
> > +/*
> > +  Writes reftable blocks. The block_writer is reused across blocks to =
minimize
> > +  allocation overhead.
> > +*/
> > +struct block_writer {
> > +     byte *buf;
> > +     uint32_t block_size;
>
> I suppose this means 2^32 block should be enough for everyone?

No. 2^24-1 is the maximum size, as detailed in the specification.

> > diff --git a/reftable/bytes.c b/reftable/bytes.c
> > new file mode 100644
> > index 00000000000..e69de29bb2d
>
> Empty?

thanks, I've removed these.

> > diff --git a/reftable/config.h b/reftable/config.h
> > new file mode 100644
> > index 00000000000..40a8c178f10
> > --- /dev/null
> > +++ b/reftable/config.h
> > @@ -0,0 +1 @@
> > +/* empty */
>
> Empty?

Removed

> > +++ b/reftable/dump.c

This was moved to a different directory in upstream; I've removed it now.

> > +bool iterator_is_null(struct reftable_iterator it)
> > +{
> > +     return it.ops =3D=3D NULL;
> > +}
>
> Do we want this verbose?
> Or it'll be use in some kind of vtable?

I've added a doc comment.

> > +
> > +static int filtering_ref_iterator_next(void *iter_arg, struct record r=
ec)
> > +{
> > +     struct filtering_ref_iterator *fri =3D
> > +             (struct filtering_ref_iterator *)iter_arg;
> > +     struct reftable_ref_record *ref =3D
> > +             (struct reftable_ref_record *)rec.data;
>
> We're passing a pointer, references a member of a variable in local
> scope around, this will ask for trouble if callee doesn't aware about
> it, and save that pointer somewhere for later access.

I don't understand your criticism; could you be more precise?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
