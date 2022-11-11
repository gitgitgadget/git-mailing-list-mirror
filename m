Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370EC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiKKXbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiKKXbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:31:16 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D9CE04
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:31:15 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id be13so10449411lfb.4
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbhMTaoo1UA+AG60yJUPmn+xsQO4hT8v9CB0NpA1si8=;
        b=hP2PofmY3Q9pyhTSjLTQbXm4SihN8g6GDUVrqdHgLRxBG+SjRNGe+Fp92Bb+9OB15T
         KIBaKKBqcrx80FPKBs1HoNvPowfgQQRAdMhmAq+ft4e8oPC2jujAJhpSmoXQCLVpm7HJ
         CGuPtr5KlkcjtWEaJXQQX1TXpjJWJw9GTlOFWDnyOkqBRRAyzzdXMP0yQCs5ZH9w2zbZ
         lvBxCZ0LmwO32/qmxtovkzzQ/IEJbcaRAQLk7ZkwE40Fwl6GTM0arkxhrTRQH3S0mYjc
         ThIbH3+pwjav0vUHezubYBItIIJzzh4Y2IM0MuL9t6AGG/dOnzJQLoZus9Lh6rinCz3p
         35ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbhMTaoo1UA+AG60yJUPmn+xsQO4hT8v9CB0NpA1si8=;
        b=FhceqVtGun7izvmHzwrG4lkDr56erSplq17Mkf6/T3IEamztPJLyqmrjJxZyUI+gRB
         KpFpvc6BWGtlrh6SadifaW1PZjWxbnhBii1AWQpnjwc9ShIxV9qmllyt6rP3D04qquFj
         vc7Gk6VpV8FtNnz/SuoO4lo2ByfQG3SFXmzBM4dvUN9fmxirD0MaoMC/l5jOOS9vswcX
         tgqhM+Va0pHm//7Uxkgp7grcTq9H7yLEEG8QVocPN16lAG2+Id6mye9jIzjCKc750FM+
         busGkPXe5z66H+ZncUpjGiBaQsxdXAkv7aGwP2s0vt3qeoiOdFr3ju0q6EeTfcnAHkom
         towA==
X-Gm-Message-State: ANoB5pkduxmljujijxZMuezrZz+/nI0tzYta5uBwHJPIQ2FxK1EYWO8t
        3OnXANn2Szll2CpDDap/WD63EX19K4Uxr4Q/uhnF/esH
X-Google-Smtp-Source: AA0mqf5F7JDeSrjH/EV3JtFNJlOMeNUkOP1Cs/Ds7ImN5irP0MHT5JSKhLG5DnlchNQDPx1wBqN1FjGJddw49XXHlPI=
X-Received: by 2002:a19:f703:0:b0:4aa:a6f8:f042 with SMTP id
 z3-20020a19f703000000b004aaa6f8f042mr1295681lfe.405.1668209473347; Fri, 11
 Nov 2022 15:31:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com> <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Nov 2022 15:31:01 -0800
Message-ID: <CABPp-BEvF3XF+udzTkEtgrtXqYuYEeYi0R65EY5gCespwZgOeg@mail.gmail.com>
Subject: Re: [PATCH 02/30] read-cache: add index.computeHash config option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 10:48 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change allowed skipping the hashing portion of the
> hashwrite API, using it instead as a buffered write API. Disabling the
> hashwrite can be particularly helpful when the write operation is in a
> critical path.
>
> One such critical path is the writing of the index. This operation is so
> critical that the sparse index was created specifically to reduce the
> size of the index to make these writes (and reads) faster.
>
> Following a similar approach to one used in the microsoft/git fork [1],
> add a new config option that allows disabling this hashing during the
> index write. The cost is that we can no longer validate the contents for
> corruption-at-rest using the trailing hash.
>
> [1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d7=
17a2db45201
>
> While older Git versions will not recognize the null hash as a special
> case, the file format itself is still being met in terms of its
> structure. Using this null hash will still allow Git operations to
> function across older versions.
>
> The one exception is 'git fsck' which checks the hash of the index file.
> Here, we disable this check if the trailing hash is all zeroes. We add a
> warning to the config option that this may cause undesirable behavior
> with older Git versions.
>
> As a quick comparison, I tested 'git update-index --force-write' with
> and without index.computHash=3Dfalse on a copy of the Linux kernel
> repository.
>
> Benchmark 1: with hash
>   Time (mean =C2=B1 =CF=83):      46.3 ms =C2=B1  13.8 ms    [User: 34.3 =
ms, System: 11.9 ms]
>   Range (min =E2=80=A6 max):    34.3 ms =E2=80=A6  79.1 ms    82 runs
>
> Benchmark 2: without hash
>   Time (mean =C2=B1 =CF=83):      26.0 ms =C2=B1   7.9 ms    [User: 11.8 =
ms, System: 14.2 ms]
>   Range (min =E2=80=A6 max):    16.3 ms =E2=80=A6  42.0 ms    69 runs
>
> Summary
>   'without hash' ran
>     1.78 =C2=B1 0.76 times faster than 'with hash'
>
> These performance benefits are substantial enough to allow users the
> ability to opt-in to this feature, even with the potential confusion
> with older 'git fsck' versions.

This is impressive and interesting...but an improvement unrelated to
this series other than the fact that it builds on some of it.  Perhaps
pull this patch out?

Also, would it make sense to integrate index.computeHash with feature.manyF=
iles?

>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/config/index.txt |  8 ++++++++
>  read-cache.c                   | 22 +++++++++++++++++++++-
>  t/t1600-index.sh               |  8 ++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/index.txt b/Documentation/config/index.=
txt
> index 75f3a2d1054..709ba72f622 100644
> --- a/Documentation/config/index.txt
> +++ b/Documentation/config/index.txt
> @@ -30,3 +30,11 @@ index.version::
>         Specify the version with which new index files should be
>         initialized.  This does not affect existing repositories.
>         If `feature.manyFiles` is enabled, then the default is 4.
> +
> +index.computeHash::
> +       When enabled, compute the hash of the index file as it is written
> +       and store the hash at the end of the content. This is enabled by
> +       default.
> ++
> +If you disable `index.computHash`, then older Git clients may report tha=
t
> +your index is corrupt during `git fsck`.
> diff --git a/read-cache.c b/read-cache.c
> index 32024029274..f24d96de4d3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1817,6 +1817,8 @@ static int verify_hdr(const struct cache_header *hd=
r, unsigned long size)
>         git_hash_ctx c;
>         unsigned char hash[GIT_MAX_RAWSZ];
>         int hdr_version;
> +       int all_zeroes =3D 1;
> +       unsigned char *start, *end;
>
>         if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
>                 return error(_("bad signature 0x%08x"), hdr->hdr_signatur=
e);
> @@ -1827,10 +1829,23 @@ static int verify_hdr(const struct cache_header *=
hdr, unsigned long size)
>         if (!verify_index_checksum)
>                 return 0;
>
> +       end =3D (unsigned char *)hdr + size;
> +       start =3D end - the_hash_algo->rawsz;
> +       while (start < end) {
> +               if (*start !=3D 0) {
> +                       all_zeroes =3D 0;
> +                       break;
> +               }
> +               start++;
> +       }
> +
> +       if (all_zeroes)
> +               return 0;
> +
>         the_hash_algo->init_fn(&c);
>         the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
>         the_hash_algo->final_fn(hash, &c);
> -       if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->ra=
wsz))
> +       if (!hasheq(hash, end - the_hash_algo->rawsz))
>                 return error(_("bad index file sha1 signature"));
>         return 0;
>  }
> @@ -2917,9 +2932,14 @@ static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>         int ieot_entries =3D 1;
>         struct index_entry_offset_table *ieot =3D NULL;
>         int nr, nr_threads;
> +       int compute_hash;
>
>         f =3D hashfd(tempfile->fd, tempfile->filename.buf);
>
> +       if (!git_config_get_maybe_bool("index.computehash", &compute_hash=
) &&
> +           !compute_hash)
> +               f->skip_hash =3D 1;
> +
>         for (i =3D removed =3D extended =3D 0; i < entries; i++) {
>                 if (cache[i]->ce_flags & CE_REMOVE)
>                         removed++;
> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> index 010989f90e6..24ab90ca047 100755
> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh
> @@ -103,4 +103,12 @@ test_expect_success 'index version config precedence=
' '
>         test_index_version 0 true 2 2
>  '
>
> +test_expect_success 'index.computeHash config option' '
> +       (
> +               rm -f .git/index &&
> +               git -c index.computeHash=3Dfalse add a &&
> +               git fsck
> +       )
> +'
> +
>  test_done
> --
> gitgitgadget

Pretty simple change, though.  Very nice.  :-)
