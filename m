Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B163C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiCWUZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiCWUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:25:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B32D1CC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:23:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w7so4612120lfd.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yMUi3g0GmSMzLXJ047IJefYO8lZKd1jpdBwHb8zzKXM=;
        b=jBlEjYb7stOpNGDtygjx/6rkGW9uQ5FvDXX3G8U7JEJzS7hj9ctVh4/n/aAFUoircQ
         08bKAhjOBncJf/EkxNQ0OxA0UiTaQ83GOePT8S7NSFRNHpfILXxzkBRs3fpOsLTOxDQ9
         VeAj01s9re9dPVX/UwNAOnCwVE71euGErgP12rCMMNq2uufxVjh8JGxEo29K+fdL0duI
         qgUziDoi1O8d1831VdUDWikob0tmyddh6wkhgqB7On2zTXDdKkY7MCFbymWyF5TOxqNT
         HIdHz1M+jnh/H8938S+OvVjs3WJxaS5iWg4rg9ljyFbrqRCmqmI0135TOmdGkbXXbRQv
         ukHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yMUi3g0GmSMzLXJ047IJefYO8lZKd1jpdBwHb8zzKXM=;
        b=n3LG4TSKf4o8GdL/+C1s7nSeP6+Zo6+NahyHtVwUyoMfXUbq83TqQiIMRSVCuRTFOl
         Ogq8Tf6wx6sJUVipgnxioDIFDepdTOesOxi3zk2244BqgRJ/2fvCdH5T7YEh83dG5nwm
         UuxUf6P+VhLF3CuMtQreLgaIacbcuHWV8Z7lTA90hhqQbOJJ1RzZRBMUL2b5a0CI17R9
         xcIwdLbN6326IuC/SYAwnL4fONWxYMrE1ph5/mvd6/C78pr9Cba20OCQoRYLhz/YtUcC
         eDxBmQ78xVmgdt4jlxFyYVNtga9wJIMVbiW8HsxpM/wUd9hlbLMA913X3fobufOqLqNg
         duvw==
X-Gm-Message-State: AOAM530FPQ7m8/aLCfWAMHTMqyRaUmdooL7Lky0dM29fNeS+/LKeJoT+
        0yh8xgGJE/ZJwaKySJ7sTxP0AJg+k/7NwHyvR6c=
X-Google-Smtp-Source: ABdhPJzowpa2lAz8FaxmRqy64+98g15NNGkulV0OBgokjAPQ3fcy7wih1O/wFb0XS9DcG9ibDJCKnRxM+VDnYchiURM=
X-Received: by 2002:a05:6512:3909:b0:44a:2428:3ecb with SMTP id
 a9-20020a056512390900b0044a24283ecbmr1179186lfu.522.1648067016144; Wed, 23
 Mar 2022 13:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
 <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com> <RFC-patch-v2-1.7-98921aa2052-20220323T140753Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-v2-1.7-98921aa2052-20220323T140753Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 23 Mar 2022 13:23:25 -0700
Message-ID: <CANQDOdfoMztNW6o8=zM43um5+uQFnzvh-0gz85srZgr+4Bev2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] unpack-objects: add skeleton
 HASH_N_OBJECTS{,_{FIRST,LAST}} flags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 7:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> In preparation for making the bulk-checkin.c logic operate from
> object-file.c itself in some common cases let's add
> HASH_N_OBJECTS{,_{FIRST,LAST}} flags.
>
> This will allow us to adjust for-loops that add N objects to just pass
> down whether they have >1 objects (HASH_N_OBJECTS), as well as passing
> down flags for whether we have the first or last object.
>
> We'll thus be able to drive any sort of batch-object mechanism from
> write_object_file_flags() directly, which until now didn't know if it
> was doing one object, or some arbitrary N.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/unpack-objects.c | 60 +++++++++++++++++++++++-----------------
>  cache.h                  |  3 ++
>  2 files changed, 37 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index c55b6616aed..ec40c6fd966 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -233,7 +233,8 @@ static void write_rest(void)
>  }
>
>  static void added_object(unsigned nr, enum object_type type,
> -                        void *data, unsigned long size);
> +                        void *data, unsigned long size,
> +                        unsigned oflags);
>
>  /*
>   * Write out nr-th object from the list, now we know the contents
> @@ -241,21 +242,21 @@ static void added_object(unsigned nr, enum object_t=
ype type,
>   * to be checked at the end.
>   */
>  static void write_object(unsigned nr, enum object_type type,
> -                        void *buf, unsigned long size)
> +                        void *buf, unsigned long size, unsigned oflags)
>  {
>         if (!strict) {
> -               if (write_object_file(buf, size, type,
> -                                     &obj_list[nr].oid) < 0)
> +               if (write_object_file_flags(buf, size, type,
> +                                     &obj_list[nr].oid, oflags) < 0)
>                         die("failed to write object");
> -               added_object(nr, type, buf, size);
> +               added_object(nr, type, buf, size, oflags);
>                 free(buf);
>                 obj_list[nr].obj =3D NULL;
>         } else if (type =3D=3D OBJ_BLOB) {
>                 struct blob *blob;
> -               if (write_object_file(buf, size, type,
> -                                     &obj_list[nr].oid) < 0)
> +               if (write_object_file_flags(buf, size, type,
> +                                           &obj_list[nr].oid, oflags) < =
0)
>                         die("failed to write object");
> -               added_object(nr, type, buf, size);
> +               added_object(nr, type, buf, size, oflags);
>                 free(buf);
>
>                 blob =3D lookup_blob(the_repository, &obj_list[nr].oid);
> @@ -269,7 +270,7 @@ static void write_object(unsigned nr, enum object_typ=
e type,
>                 int eaten;
>                 hash_object_file(the_hash_algo, buf, size, type,
>                                  &obj_list[nr].oid);
> -               added_object(nr, type, buf, size);
> +               added_object(nr, type, buf, size, oflags);
>                 obj =3D parse_object_buffer(the_repository, &obj_list[nr]=
.oid,
>                                           type, size, buf,
>                                           &eaten);
> @@ -283,7 +284,7 @@ static void write_object(unsigned nr, enum object_typ=
e type,
>
>  static void resolve_delta(unsigned nr, enum object_type type,
>                           void *base, unsigned long base_size,
> -                         void *delta, unsigned long delta_size)
> +                         void *delta, unsigned long delta_size, unsigned=
 oflags)
>  {
>         void *result;
>         unsigned long result_size;
> @@ -294,7 +295,7 @@ static void resolve_delta(unsigned nr, enum object_ty=
pe type,
>         if (!result)
>                 die("failed to apply delta");
>         free(delta);
> -       write_object(nr, type, result, result_size);
> +       write_object(nr, type, result, result_size, oflags);
>  }
>
>  /*
> @@ -302,7 +303,7 @@ static void resolve_delta(unsigned nr, enum object_ty=
pe type,
>   * resolve all the deltified objects that are based on it.
>   */
>  static void added_object(unsigned nr, enum object_type type,
> -                        void *data, unsigned long size)
> +                        void *data, unsigned long size, unsigned oflags)
>  {
>         struct delta_info **p =3D &delta_list;
>         struct delta_info *info;
> @@ -313,7 +314,7 @@ static void added_object(unsigned nr, enum object_typ=
e type,
>                         *p =3D info->next;
>                         p =3D &delta_list;
>                         resolve_delta(info->nr, type, data, size,
> -                                     info->delta, info->size);
> +                                     info->delta, info->size, oflags);
>                         free(info);
>                         continue;
>                 }
> @@ -322,18 +323,19 @@ static void added_object(unsigned nr, enum object_t=
ype type,
>  }
>
>  static void unpack_non_delta_entry(enum object_type type, unsigned long =
size,
> -                                  unsigned nr)
> +                                  unsigned nr, unsigned oflags)
>  {
>         void *buf =3D get_data(size);
>
>         if (!dry_run && buf)
> -               write_object(nr, type, buf, size);
> +               write_object(nr, type, buf, size, oflags);
>         else
>                 free(buf);
>  }
>
>  static int resolve_against_held(unsigned nr, const struct object_id *bas=
e,
> -                               void *delta_data, unsigned long delta_siz=
e)
> +                               void *delta_data, unsigned long delta_siz=
e,
> +                               unsigned oflags)
>  {
>         struct object *obj;
>         struct obj_buffer *obj_buffer;
> @@ -344,12 +346,12 @@ static int resolve_against_held(unsigned nr, const =
struct object_id *base,
>         if (!obj_buffer)
>                 return 0;
>         resolve_delta(nr, obj->type, obj_buffer->buffer,
> -                     obj_buffer->size, delta_data, delta_size);
> +                     obj_buffer->size, delta_data, delta_size, oflags);
>         return 1;
>  }
>
>  static void unpack_delta_entry(enum object_type type, unsigned long delt=
a_size,
> -                              unsigned nr)
> +                              unsigned nr, unsigned oflags)
>  {
>         void *delta_data, *base;
>         unsigned long base_size;
> @@ -366,7 +368,7 @@ static void unpack_delta_entry(enum object_type type,=
 unsigned long delta_size,
>                 if (has_object_file(&base_oid))
>                         ; /* Ok we have this one */
>                 else if (resolve_against_held(nr, &base_oid,
> -                                             delta_data, delta_size))
> +                                             delta_data, delta_size, ofl=
ags))
>                         return; /* we are done */
>                 else {
>                         /* cannot resolve yet --- queue it */
> @@ -428,7 +430,7 @@ static void unpack_delta_entry(enum object_type type,=
 unsigned long delta_size,
>                 }
>         }
>
> -       if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
> +       if (resolve_against_held(nr, &base_oid, delta_data, delta_size, o=
flags))
>                 return;
>
>         base =3D read_object_file(&base_oid, &type, &base_size);
> @@ -440,11 +442,11 @@ static void unpack_delta_entry(enum object_type typ=
e, unsigned long delta_size,
>                 has_errors =3D 1;
>                 return;
>         }
> -       resolve_delta(nr, type, base, base_size, delta_data, delta_size);
> +       resolve_delta(nr, type, base, base_size, delta_data, delta_size, =
oflags);
>         free(base);
>  }
>
> -static void unpack_one(unsigned nr)
> +static void unpack_one(unsigned nr, unsigned oflags)
>  {
>         unsigned shift;
>         unsigned char *pack;
> @@ -472,11 +474,11 @@ static void unpack_one(unsigned nr)
>         case OBJ_TREE:
>         case OBJ_BLOB:
>         case OBJ_TAG:
> -               unpack_non_delta_entry(type, size, nr);
> +               unpack_non_delta_entry(type, size, nr, oflags);
>                 return;
>         case OBJ_REF_DELTA:
>         case OBJ_OFS_DELTA:
> -               unpack_delta_entry(type, size, nr);
> +               unpack_delta_entry(type, size, nr, oflags);
>                 return;
>         default:
>                 error("bad object type %d", type);
> @@ -491,6 +493,7 @@ static void unpack_all(void)
>  {
>         int i;
>         struct pack_header *hdr =3D fill(sizeof(struct pack_header));
> +       unsigned oflags;
>
>         nr_objects =3D ntohl(hdr->hdr_entries);
>
> @@ -505,9 +508,14 @@ static void unpack_all(void)
>                 progress =3D start_progress(_("Unpacking objects"), nr_ob=
jects);
>         CALLOC_ARRAY(obj_list, nr_objects);
>         plug_bulk_checkin();
> +       oflags =3D nr_objects > 1 ? HASH_N_OBJECTS : 0;
>         for (i =3D 0; i < nr_objects; i++) {
> -               unpack_one(i);
> -               display_progress(progress, i + 1);
> +               int nth =3D i + 1;
> +               unsigned f =3D i =3D=3D 0 ? HASH_N_OBJECTS_FIRST :
> +                       nr_objects =3D=3D nth ? HASH_N_OBJECTS_LAST : 0;
> +
> +               unpack_one(i, oflags | f);
> +               display_progress(progress, nth);
>         }
>         unplug_bulk_checkin();
>         stop_progress(&progress);
> diff --git a/cache.h b/cache.h
> index 84fafe2ed71..72c91c91286 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -896,6 +896,9 @@ int ie_modified(struct index_state *, const struct ca=
che_entry *, struct stat *,
>  #define HASH_FORMAT_CHECK 2
>  #define HASH_RENORMALIZE  4
>  #define HASH_SILENT 8
> +#define HASH_N_OBJECTS 1<<4
> +#define HASH_N_OBJECTS_FIRST 1<<5
> +#define HASH_N_OBJECTS_LAST 1<<6
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd, =
struct stat *st, enum object_type type, const char *path, unsigned flags);
>  int index_path(struct index_state *istate, struct object_id *oid, const =
char *path, struct stat *st, unsigned flags);
>
> --
> 2.35.1.1428.g1c1a0152d61
>

This patch works out okay because unpack-objects is the easy case.
You have a well defined number of objects.  I'd be fine with your
design if all cases were like this.
