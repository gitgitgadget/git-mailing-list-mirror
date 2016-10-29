Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFE62022A
	for <e@80x24.org>; Sat, 29 Oct 2016 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756313AbcJ2MXU (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 08:23:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34080 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755209AbcJ2MXS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 08:23:18 -0400
Received: by mail-it0-f68.google.com with SMTP id q124so1360134itd.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FL0b11PE3dPuv8nQBhXo1CzgTJl+BxAfc9cYDHGUmew=;
        b=UprgtiqE1QCQuSuRgkEvlv6ZIaLiNfiJwR9Wc6+R0Oa4Tx+jCHToZerlnNOnNwCXyj
         +9jfaHnEe65gfIfSh3QVtr98eXDnpDX86UcsqOFkHaBCIsK25N1Xo7P3ZpoxHK1m0I89
         k7Fq7Jm29wxA/96gT3mYPTpb8pI+gmseQagXXEwvsz/9Td1fuClmmgypcIovLgm6t1cc
         +GP4tHIrnxEfSN5aoww1gVcrNn2A/Ni+Z2w4qDWYFCVaK4RTyd3KjKFTmKKq07dvSllo
         H7CXeTbTySsNUSyTvHB2BqmdYNmtJRiU07yThiy2mIskXAAMSEzapPSmg8LLL8yQK6DG
         bmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FL0b11PE3dPuv8nQBhXo1CzgTJl+BxAfc9cYDHGUmew=;
        b=Kpj9A5mrplYmt3G2HpsuxX1ZM4JCrpJPsHiwxI1dWC53YKyHd+fUA/zwVbmGeRUEFp
         9hUpTN3QWEBJlO5ZHcYG/pjqaFJJzsAKU8bLgtLCww/PqjH7u6uFerTmi6X7gUMn16Rg
         VjVkS2ZwYev4izeE2JOA5YSwZ/7s9qQJ3LE3AgkDFCsSl34PnhFi6OaEH5nLD/LR13Z+
         8dKAzJO/CelzFlPMvc1dqQ0VsVtq8Er1IfoZxvbqvBMUCIe6iylWJs+XAXE7IxLiBzNk
         gQDfMUSLrccWVyt6BAxjyX9DLwkcWVM089bj4hSjGZUQsAe2ymbeiU1Ah71KuIjgWo5W
         1M3Q==
X-Gm-Message-State: ABUngvevr+KyHAfroVc3fC6ncK2cUUbfQtTeh/1Bq45LTY8O34nQ85DhzaQLGij6W8gebfMsdENkPb7gRJRuMw==
X-Received: by 10.36.54.69 with SMTP id l66mr2276053itl.3.1477743797272; Sat,
 29 Oct 2016 05:23:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sat, 29 Oct 2016 05:22:46 -0700 (PDT)
In-Reply-To: <20161012134726.28326-1-tboegi@web.de>
References: <20161009095649.1886-1-tboegi@web.de> <20161012134726.28326-1-tboegi@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Oct 2016 19:22:46 +0700
Message-ID: <CACsJy8An5rkqhowvJL5u6Aqf6NLXaGCcpqv5aob_cADmn8QO_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] read-cache: factor out get_sha1_from_index() helper
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 8:47 PM,  <tboegi@web.de> wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Factor out the retrieval of the sha1 for a given path in
> read_blob_data_from_index() into the function get_sha1_from_index().
>
> This will be used in the next commit, when convert.c can do the
> analyze for "text=3Dauto" without slurping the whole blob into memory
> at once.
>
> Add a wrapper definition get_sha1_from_cache().
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  cache.h      |  3 +++
>  read-cache.c | 29 ++++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 1604e29..04de209 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -380,6 +380,7 @@ extern void free_name_hash(struct index_state *istate=
);
>  #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at=
)
>  #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
>  #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&t=
he_index, (path), (sz))
> +#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (pat=
h))
>  #endif
>
>  enum object_type {
> @@ -1089,6 +1090,8 @@ static inline void *read_sha1_file(const unsigned c=
har *sha1, enum object_type *
>         return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_O=
BJECT);
>  }
>
> +const unsigned char *get_sha1_from_index(struct index_state *istate, con=
st char *path);
> +
>  /*
>   * This internal function is only declared here for the benefit of
>   * lookup_replace_object().  Please do not call it directly.
> diff --git a/read-cache.c b/read-cache.c
> index 38d67fa..5a1df14 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2290,13 +2290,27 @@ int index_name_is_other(const struct index_state =
*istate, const char *name,
>
>  void *read_blob_data_from_index(struct index_state *istate, const char *=
path, unsigned long *size)
>  {
> -       int pos, len;
> +       const unsigned char *sha1;
>         unsigned long sz;
>         enum object_type type;
>         void *data;
>
> -       len =3D strlen(path);
> -       pos =3D index_name_pos(istate, path, len);
> +       sha1 =3D get_sha1_from_index(istate, path);
> +       if (!sha1)
> +               return NULL;
> +       data =3D read_sha1_file(sha1, &type, &sz);
> +       if (!data || type !=3D OBJ_BLOB) {
> +               free(data);
> +               return NULL;
> +       }
> +       if (size)
> +               *size =3D sz;
> +       return data;
> +}
> +
> +const unsigned char *get_sha1_from_index(struct index_state *istate, con=
st char *path)

Let's try to embrace struct object_id to make our lives easier when
the time comes to convert to a new hash algorithm by returning struct
object_id * here instead of the internal hash.

> +{
> +       int pos =3D index_name_pos(istate, path, strlen(path));
>         if (pos < 0) {
>                 /*
>                  * We might be in the middle of a merge, in which
> @@ -2312,14 +2326,7 @@ void *read_blob_data_from_index(struct index_state=
 *istate, const char *path, un
>         }
>         if (pos < 0)
>                 return NULL;
> -       data =3D read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz)=
;
> -       if (!data || type !=3D OBJ_BLOB) {
> -               free(data);
> -               return NULL;
> -       }
> -       if (size)
> -               *size =3D sz;
> -       return data;
> +       return istate->cache[pos]->oid.hash;
>  }
>
>  void stat_validity_clear(struct stat_validity *sv)
--=20
Duy
