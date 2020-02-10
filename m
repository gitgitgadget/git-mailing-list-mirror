Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B43C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98C32070A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A37rqK2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgBJNQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:16:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgBJNQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 08:16:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so7617827wrx.11
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2uHXKNft0Swwv1acL5r2mq5qXXHRGxHuUBw9ZsjnTDA=;
        b=A37rqK2MdLQXFbShkuBijAgCuHQCwkcGxTeGOC1UuZjqkHYwHSMNKwnPmFT5NeXHut
         fmTedNKdvkOXCbYcHk64WBpwYsjUGRyPKGbbhl87hMSDp64MomHIAWeelmOJIVSHZX7u
         zD2mJhGVgcuD+nnk5VfemnJbOmcjI8tuP19izYZOAziRuFBnGk25D15/bw663Ta8sUUU
         0jdnw6TmvdpmAJjAeALfSW8BOqcWRfC8CfEuKISZWNb5uMoSwU0OYSyVUF4VH8sJAFjC
         I0zEyQfl0g4oP13PDO+Kqu06ERwrQM25sYED4Y4xkjLEcnUO9kI5qE8kGjAFWpIbnMTU
         Wtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2uHXKNft0Swwv1acL5r2mq5qXXHRGxHuUBw9ZsjnTDA=;
        b=QXXjcv2G5jI3rqU7blAgLpPl3bPl/W2dtWD+JrYldF2oMFAQ9XYFmnUrOtb+1BmWlz
         fDNhXG1so8jN3v6rEyiCuXuRvA5+sITxIavCOBgTgAbeP0I/GTsigoYH3+Z/Bn0rmSlV
         u8heaCIyFoMDJcSPfAO9EB4Fuy2cVPfAZky1C4oUHGACuornaPypMddK7QJHBc79waUb
         EjsCO4hA0buvdCL3/N3qoUPnPEsONjaRpEDKE0hvLMVxeAiYnCOsDKw3e+0aPRtRDu1m
         BaScWpSKhVQZpTzRXfJQISnHawkjId1upOEAF9pBpK05YBkj6CozvPWFO9E4ZMd924Nf
         hn6A==
X-Gm-Message-State: APjAAAUYb+0TvvqWQL3nVCmMIAIhZAmnPBBsGx0P/nIOIv6hgx7y7mGb
        QUS0MLTqU7auHE4FL4iL9NQrugjUAld7W+e7vkeUog==
X-Google-Smtp-Source: APXvYqwDNjgLCSyXQXd5eNXlTvUhFjyV2EdfD7vgHj3n1OTk8MHRiXF6UovqGFPeNCJvbMw/gn8OgMyXQn2Rd6biREA=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr1964371wro.310.1581340599251;
 Mon, 10 Feb 2020 05:16:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net>
In-Reply-To: <20200207001612.GF6573@camp.crustytoothpaste.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Feb 2020 14:16:26 +0100
Message-ID: <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 1:16 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > +
> > +Bugfixes should be accompanied by a test and applied to upstream proje=
ct at
> > +https://github.com/google/reftable.
>
> I think this particular statement may be problematic.  The upstream
> project requires a CLA, which is a non-starter for many folks.  I don't
> think we can expect folks who are working on Git to necessarily send
> patches upstream with that condition.
>
> For example, if I end up needing to patch this series to work with
> SHA-256, I'm happy for Google to have my changes under the BSD License,
> but I won't be signing a CLA.

The CLA requirement is something our Open Source lawyers insist on,
and it's not for me to renege on. AFAIU, the CLA is essentially a
legally sound formulation of "I'm happy for Google to have my changes
under the BSD License"

> > +#define SHA1_SIZE 20
> > +#define SHA256_SIZE 32
>
> I'd rather we didn't hard-code these values here.  If you need a size
> suitable for allocation, we have GIT_MAX_RAWSZ and GIT_MAX_HEXSZ.  Those
> are guaranteed to be the right size for any future hash.

this code is structured as a standalone library so the same code can
be integrated into libgit2 unchanged, and can be unit-tested without
needing complex scaffolding.

As a result some data (eg. SHA1_SIZE) is duplicate. It also comes with
its own strbuf library.

> > +     {
> > +             struct merged_table m =3D {
> > +                     .stack =3D stack,
> > +                     .stack_len =3D n,
> > +                     .min =3D first_min,
> > +                     .max =3D last_max,
> > +                     .hash_size =3D SHA1_SIZE,
>
> This is going to cause problems with SHA-256.  We'd want to write this
> as the_hash_algo->rawsz, since it can change at runtime.

As this is within the library, the hash size should be injected
somewhere. I don't see huge problems here (the hash size could be part
of the 'struct write_options'), but until we have properly defined how
reftable will mark the on-disk files as SHA-256, it will only supports
SHA1. I intend to work set the file format in motion, once this SHA1
version is accepted into git-core.

There was one question you might be able to answer, though. Can
repositories exist in dual hash configuration, i.e. where the ref
database must store both SHA1 and SHA256 hashes?

> > +static byte zero[SHA256_SIZE] =3D {};
>
> It would be better to refer to null_oid here.

See above.

>
> > +#ifndef REFTABLE_H
> > +#define REFTABLE_H
> > +
> > +#include "system.h"
> > +
> > +typedef uint8_t byte;
>
> I think we typically prefer writing "unsigned char" or "uint8_t" instead
> of "byte".
>
> > +typedef byte bool;
>
> I suspect this is going to cause a whole host of sadness if somebody
> ever includes stdbool.h, or if that header ever gets included by an
> OS-specific header, since bool is a #define constant for the built-in
> type _Bool.
>
> We typically use int for booleans, but I'm not opposed to using
> stdbool.h for it on those systems that we know have it (which, in 2020,
> is probably all of them).

fixed in https://github.com/google/reftable/commit/a0c794609f2ce8114f014f72=
60093d4ffdde0d5d

> > +struct writer *new_writer(int (*writer_func)(void *, byte *, int),
> > +                       void *writer_arg, struct write_options *opts)
> > +{
> > +     struct writer *wp =3D calloc(sizeof(struct writer), 1);
> > +     options_set_defaults(opts);
> > +     if (opts->block_size >=3D (1 << 24)) {
> > +             /* TODO - error return? */
> > +             abort();
> > +     }
> > +     wp->hash_size =3D SHA1_SIZE;
>
> Another SHA-256 problem.
>
> Once this series has good test coverage, I'm happy to send a patch that
> squashes in SHA-256 support if you don't want to implement it yourself

There is really nothing to implement. The C library will accept hashes
of arbitrary size (hence the hash_size field you commented on before),
but it just needs a tiny bit of plumbing for the library user to
specify the wanted hash size, and a change to the documented format to
store it in the file format header.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
