Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E3C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 22:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiGHW3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiGHW3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 18:29:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E18F13B455
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 15:29:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so39855018ejc.11
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UZaaBLGxIxMqh3qwzL2wFOOQqwmwImsfh598c9m2Ka0=;
        b=eCHlvhXkZZtmd/cDc8P74tQ75JwpWJYv2/iiTahpHDu080yMZpBtooOfFm2lXGbZ3k
         em0acw+kqGyIOc8ucjm814Gg66Tbkg+2uU8rPjSXgVBEeshFcxrlvnrUmdFJGK1E07JJ
         GoM2jRG6z91akFrE8FYO4PG4shudsYbaCLwvp2C8H3zqoaOzXnIvQcGbOcDMGy23+ZxN
         VxfVA0glyA7ymv1f/jENyXcwFdWRaqspefM7UFgLrp1crzN1k0LcRKFQiTayyLjvza/Z
         tXQCbUMu8JvEKbcQpg9VtUJsBtKIKS8Tn4gOYDop8bg6U6HMWiwoo49ayW2zvzEFzm/y
         68xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UZaaBLGxIxMqh3qwzL2wFOOQqwmwImsfh598c9m2Ka0=;
        b=KiCF6k796LbA+adsyReSeKYkYDvWhm/KZQD2dT+QybFqL36cUABcCmDDYzQEzNm6n3
         kYOxtH+6ScSHIuDNFGpbGMyFV1j1v6bYwD88G8P9afLZ4XOHY66jZOQPA4ZIHnvnoYsk
         5/HAGWKgDzr4wjqESGnXarM7gp2Kop1UAEk66KFLAplaQDuiH1Es9Seqf2/q6PaLZa6d
         Vf2UUdOAn/dHfxorGjp1aDvjPvMg1QPCH+N470RmAwgM/c+GabpcOlxvxEtVgY4lh+ti
         clyD/re9bJzYcU47IucYIQnELHQkUgmmx+9IZhHA/wKN4RZO43Crqay7xj8Z5XUeh/z+
         StRw==
X-Gm-Message-State: AJIora8GjjqV7qCfwM1hiQcSdvCqv9oJiLDMu1FtUwlqwYtgPhtBBR7V
        5zzF/EZTjIwx4+oxLGKWhDxQOdhzX/DHAQ==
X-Google-Smtp-Source: AGRyM1sAgS/6O2Q6SIG+ehmhpeit1SN5cwASBcLq3gooB0T05peNnQBYM6KRzHxoKXajx4gQcRH3Xw==
X-Received: by 2002:a17:907:1dc6:b0:72a:5e9a:91be with SMTP id og6-20020a1709071dc600b0072a5e9a91bemr5889472ejc.730.1657319369613;
        Fri, 08 Jul 2022 15:29:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c12-20020a170906d18c00b00727c6da69besm14012519ejz.38.2022.07.08.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:29:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9wTY-0003y9-1l;
        Sat, 09 Jul 2022 00:29:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/4] xdiff: introduce XDL_ALLOC_GROW()
Date:   Sat, 09 Jul 2022 00:17:42 +0200
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
 <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
Message-ID: <220709.86v8s78chj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 08 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
> the rest of the codebase but returns =E2=88=921 on allocation failure to
> accommodate other users of libxdiff such as libgit2.=20
> [...]
> +		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
> +void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
> +{
> +	void *tmp =3D NULL;
> +	size_t n =3D ((LONG_MAX - 16) / 2 >=3D *alloc) ? 2 * *alloc + 16 : LONG=
_MAX;
> +	if (nr > n)
> +		n =3D nr;
> +	if (SIZE_MAX / size >=3D n)
> +		tmp =3D xdl_realloc(p, n * size);
> +	if (tmp) {
> +		*alloc =3D n;
> +	} else {
> +		xdl_free(p);
> +		*alloc =3D 0;
> +	}
> +	return tmp;
> +}

Whether you agree with the entire approach in my series-on-top[1] or not
(and it looks like not), this way of doing it seems needlessly complex.

I.e. the whole "pass the size" business is here because you're wanting
to use this as an expression, which ALLOC_GROW() isn't able to do.

But you've also changed every single callsite anyway.

So why not just change:

    if (XDL_ALLOC_GROW(recs, ...))

To:

    XDL_ALLOC_GROW(recs, ...);
    if (!recs)

And do away with needing to pass this through a function where we get
the size, and thus losing the type information before we can call
sizeof().

Then, as that series shows the implementation here could be pretty much
an exact line-for-line copy of what we have in cache.h, including the
same alloc_nr(), all without casts etc.

All of which seems much simpler than trying to maintain the constraint
that this must be usable in an expression.

Your commit message sort-of addresses this by mentioning that this
"returns =E2=88=921 on allocation failure to accommodate other users of lib=
xdiff
such as libgit2".

But since libgit2 won't use this, but only a copy of this xdiff code in
libgit2 I don't see how that makes sense. We're only talking about using
this in the xdiff code we maintain, and even if libgit2 wanted to use it
it could deal with not being able to use it in an expression, no?
=20=20=20=20=09
1. https://lore.kernel.org/git/patch-5.7-3665576576f-20220708T140354Z-avara=
b@gmail.com/
