Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D0FC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 02:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDRCgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDRCgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 22:36:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD391FC2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:36:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a7ac8a2c8bso17417791fa.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681785380; x=1684377380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=662iPZH91rhu0JXYWYeYP/TxAb7rIFnrl9tt227U+VM=;
        b=SOLk4AdUH+uSrBzhKMlAa5ba1b3XRVLbjpTJ54bSEZAWs04STWtasFGKa+HT3jR5Ud
         nsj6lH4VTsnQkFX8MVYOubJ/gBGjiQr8iv4dSSbkI67Q6Co9E8f45bZjCw/aTjO8lyLj
         qEjRweEn29+nTS+rHiER9MOXxyQ09X7015Rx+smAu0nQJbIqMrOKoN/GtgH0Iazm3RVe
         rC5p/FS7OQQ0eKu2D5E2f2re/t1mPvi+mtKnHrmMmDZ5LPZxniLJNIDOJYX1CtX4o0Yf
         YuWkL/PXAPAanRJDvafVPhQwUEtI0TumicELhbySGN7bG2lGo9apMa7Llzn3ByTicTs1
         /PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681785380; x=1684377380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=662iPZH91rhu0JXYWYeYP/TxAb7rIFnrl9tt227U+VM=;
        b=ioM5xdpO7rMmY7EmcVH4Nez1F7z2cPKGCBX4vQPuXMbWTq50CM/wTeYzrHOZ1m5lT/
         QY8MMAmtLitt0oYsag7ofhLcU3AqxbBrCbzD2ZSsIbvH89Rc1/5qLCTNZfDr3IMAprzv
         ZL1SfdGd2Zu96EpS3PuP5BLgicEHCK2GiOcs/0X1JylJuo8/GdyBc4gPU32ETVKHz8gn
         R9hXeiQwyFDCjdgPaIjj9Zo+O1IK127MmgFeQ8DroLZM+B5bq0tZO+cQlV5zvrqxMP7P
         hzR3iwpyeXvyaFr8PDXabkbef3kIouiOIAJRykWOgaHih1xxsnsG7JBNhJRdCEuDQTnt
         W7ew==
X-Gm-Message-State: AAQBX9cMI2D/sbOA7dxW1nR6hZIVi+Hv/qW9ZE/+Q0110oqyXNYFm+KH
        vUvTxuVEtTonu4AhH57YJnR7UrxeZv1wBDVJPVo=
X-Google-Smtp-Source: AKy350ZmCNeKBtXHDD9cV1pWU9ht9cuO0wzhhjtMX1sWGN37/vQCrzdvKPe9Pr7tkgVMIMhd1Q+5E5vHlCDv/w4nH90=
X-Received: by 2002:a19:f80a:0:b0:4ea:fa15:5bce with SMTP id
 a10-20020a19f80a000000b004eafa155bcemr2841808lff.7.1681785379646; Mon, 17 Apr
 2023 19:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <1c6989ae456c86850761b079384f1505735e317a.1681614206.git.gitgitgadget@gmail.com>
 <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
In-Reply-To: <ad90e716-ba23-040f-66be-4c4faff02ea8@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 19:36:06 -0700
Message-ID: <CABPp-BFV2HByQ7=6TvsLgSxZTXcWFG4jbxATGWAd_UT_Nr=KVA@mail.gmail.com>
Subject: Re: [PATCH 14/23] hash.h, repository.h: reverse the order of these dependencies
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 1:59=E2=80=AFPM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/15/2023 11:03 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Previously, hash.h depended upon and included repository.h, due to
> > the definition and use of the_hash_algo (defined as
> > the_repository->hash_algo).  Move this #define, and the associated
> > inline functions that depend upon it, from hash.h to repository.h.
> > Due to that movement, reverse the dependencies so repository.h includes
> > hash.h.
> >
> > This allows hash.h and object.h to be fairly small, minimal headers.  I=
t
> > also exposes a lot of hidden dependencies on both path.h (which was
> > brought in by repository.h) and repository.h (which was previously
> > implicitly brought in by object.h).
>
> This is the first patch in the series where I don't immediately agree
> with the patch. This is a big list of methods that don't seem like
> they fit in repository.h:
>
> > diff --git a/repository.h b/repository.h
> > +static inline int hashcmp(const unsigned char *sha1, const unsigned ch=
ar *sha2)
> > +static inline int oidcmp(const struct object_id *oid1, const struct ob=
ject_id *oid2)
> > +static inline int hasheq(const unsigned char *sha1, const unsigned cha=
r *sha2)
> > +static inline int oideq(const struct object_id *oid1, const struct obj=
ect_id *oid2)
> > +static inline int is_null_oid(const struct object_id *oid)
> > +static inline void hashcpy(unsigned char *sha_dst, const unsigned char=
 *sha_src)
> > +static inline void oidcpy_with_padding(struct object_id *dst,
> > +                                    const struct object_id *src)
> > +static inline void hashclr(unsigned char *hash)
> > +static inline void oidclr(struct object_id *oid)
> > +static inline void oidread(struct object_id *oid, const unsigned char =
*hash)
> > +static inline int is_empty_blob_sha1(const unsigned char *sha1)
> > +static inline int is_empty_blob_oid(const struct object_id *oid)
> > +static inline int is_empty_tree_sha1(const unsigned char *sha1)
> > +static inline int is_empty_tree_oid(const struct object_id *oid)

Yeah, their names suggest they in no way depend upon internals of a
repository, but that's largely because they are misnamed, similar to
our old friends like get_oid() and repo_get_oid().

> The goal to remove repository.h from hash.h and object.h makes sense
> as a goal, but is there another way to do it? Can we redefine
> 'extern struct repository *the_repository;' in hash.h so we have
> access to that pointer?

Having access to the pointer is insufficient.  These functions all
make use of the_repository->hash_algo, and are inline, so the
definition and layout of struct repository is necessary.

An alternate solution might be to just wrap the #define of
the_hash_algo, as well as these functions, with
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, try to convince =C3=86var that we
put those #ifdefs in before he wrote his series[1] and that he thus
missed some uses of that macro, and then watch him transform all of
them with a series of cocci changes so these functions just go away.
;-)

But that sounds like a separate big series, and I'm dubious about my
ability to hoodwink =C3=86var.

Any other ideas?


[1] https://lore.kernel.org/git/cover-v2-00.17-00000000000-20230328T110946Z=
-avarab@gmail.com/
