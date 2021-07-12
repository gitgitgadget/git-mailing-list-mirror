Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D94C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A9E61006
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGLNUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhGLNUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:20:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF35C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:17:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o5so34558394ejy.7
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ifs6OI+Ru2O3SmLrzRT2Z5x5Ja1lAcezFSbLkQBRIUg=;
        b=G8v1dhDRvThuHxR1GfXckg0yqmd/hNxrEHCoXIPtN6NRcF8RAiEMUJB8cIPWTmBGMb
         ggr4wEJFfC3FXwNY93ODWnD27B6UxM9xUW54iaFWt0nDw1YlEebwFrI8Skx3vIwsOxyz
         x69bCjYRhR2hk1cBxuQpjxbapwaNxa+tkJ5l0OhA13Z4EWLeB1EAejjIewGu99FWo9dG
         NEuMr9j8pUkob6O67whk5tRt4HuCNfpjdbTnizVjgAicwoQXmnu/CAYCFXlOQXzw+XV9
         6ujGFpDtYzYa4S7Yf6Pvs5Bkta34yqoDI/zZ5KM80MHG26rYuMWGPKPjVjwO70C79ZED
         piog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ifs6OI+Ru2O3SmLrzRT2Z5x5Ja1lAcezFSbLkQBRIUg=;
        b=L+Le962/eB1mowePy6I7F5FEiHbvjTlbSVtm8wjDGw+i9ejK9Fe7W8s3HGFZMbWPEF
         Vu9/a8l03UKqVmcyHaANIUgVG6E9HWThI+tMzKqocXduTLkKEt7qZFv/GaG1tq7b6XZG
         q4VXgm8zBtZMgSXslF3s9PTiv4SsVUHZE/Zd9qfEiNo/Ap7fULgS9tMPGiY4NtJ+yqrQ
         elZOLoKma4QvravfFxULF83iNv38RDBRPf9PXznaMtrKngR+MXbe7RVfeCa9s6rCCFK6
         sm1puqCAAYTL9FAIR77JI07pCLR1/JSTzmv1IL2s/IhIr+HW6Xo517Q1yxYPGjD4+kTA
         Cnmw==
X-Gm-Message-State: AOAM5327oJZUEP+h6CxGCZzLONL7D6/oDzo95RdUmSN/Zfh/dWRH6Q8y
        KJX1IKpcr2paKA3abORNhmEdIQCe0hOSFEPE5v0=
X-Google-Smtp-Source: ABdhPJzdQ2kVL9D/WxP/JoR216srjooSCOLb8mG28z9tdlr031BpkPpT78FFLrWv0OmGnCg1ssSpY4gHkWhioq/KEck=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr48873842ejs.197.1626095864781;
 Mon, 12 Jul 2021 06:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com> <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Jul 2021 15:17:33 +0200
Message-ID: <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 1:47 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let cat-file use ref-filter logic, let's do the
> following:
>
> 1. Change the type of member `format` in struct `batch_options`
> to `ref_format`, we will pass it to ref-filter later.
> 2. Let `batch_objects()` add atoms to format, and use
> `verify_ref_format()` to check atoms.
> 3. Use `format_ref_array_item()` in `batch_object_write()` to
> get the formatted data corresponding to the object. If the
> return value of `format_ref_array_item()` is equals to zero,
> use `batch_write()` to print object data; else if the return
> value is less than zero, use `die()` to print the error message
> and exit; else if return value is greater than zero, only print
> the error message, but don't exit.
> 4. Use free_ref_array_item_value() to free ref_array_item's
> value.
>
> Most of the atoms in `for-each-ref --format` are now supported,
> such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> `%(flag)`, `%(HEAD)`, because these atoms are unique to those objects
> that pointed to by a ref, "for-each-ref"'s family can naturally use
> these atoms, but not all objects are pointed to be a ref, so "cat-file"
> will not be able to use them.
>
> The performance for `git cat-file --batch-all-objects
> --batch-check` on the Git repository itself with performance
> testing tool `hyperfine` changes from 669.4 ms =C2=B1  31.1 ms to
> 1.134 s =C2=B1  0.063 s.
>
> The performance for `git cat-file --batch-all-objects --batch
> >/dev/null` on the Git repository itself with performance testing
> tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
> total" to "33.69s user 1.54s system 87% cpu 40.258 total".

Saying that a later patch will add a fast path which will mitigate the
performance regression introduced by this patch might help reassure
reviewers.

By the way it is not clear if adding the fast path fully mitigates
this performance regression or not. You might want to discuss that in
the cover letter, or maybe in the patch adding the fast path.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-cat-file.txt |   6 +
>  builtin/cat-file.c             | 242 ++++++-------------------------
>  t/t1006-cat-file.sh            | 251 +++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+), 195 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.=
txt
> index 4eb0421b3fd..ef8ab952b2f 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -226,6 +226,12 @@ newline. The available atoms are:
>         after that first run of whitespace (i.e., the "rest" of the
>         line) are output in place of the `%(rest)` atom.
>
> +Note that most of the atoms in `for-each-ref --format` are now supported=
,
> +such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> +`%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> +`%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> +`%(flag)`, `%(HEAD)`. See linkgit:git-for-each-ref[1].
> +
>  If no format is specified, the default format is `%(objectname)
>  %(objecttype) %(objectsize)`.
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 41d407638d5..5b163551fc6 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -16,6 +16,7 @@
>  #include "packfile.h"
>  #include "object-store.h"
>  #include "promisor-remote.h"
> +#include "ref-filter.h"
>
>  struct batch_options {
>         int enabled;
> @@ -25,7 +26,7 @@ struct batch_options {
>         int all_objects;
>         int unordered;
>         int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> -       const char *format;
> +       struct ref_format format;
>  };
>
>  static const char *force_path;
> @@ -195,99 +196,10 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name,
>
>  struct expand_data {
>         struct object_id oid;
> -       enum object_type type;
> -       unsigned long size;
> -       off_t disk_size;
>         const char *rest;
> -       struct object_id delta_base_oid;
> -
> -       /*
> -        * If mark_query is true, we do not expand anything, but rather
> -        * just mark the object_info with items we wish to query.
> -        */
> -       int mark_query;
> -
> -       /*
> -        * Whether to split the input on whitespace before feeding it to
> -        * get_sha1; this is decided during the mark_query phase based on
> -        * whether we have a %(rest) token in our format.
> -        */
>         int split_on_whitespace;
> -
> -       /*
> -        * After a mark_query run, this object_info is set up to be
> -        * passed to oid_object_info_extended. It will point to the data
> -        * elements above, so you can retrieve the response from there.
> -        */
> -       struct object_info info;
> -
> -       /*
> -        * This flag will be true if the requested batch format and optio=
ns
> -        * don't require us to call oid_object_info, which can then be
> -        * optimized out.
> -        */
> -       unsigned skip_object_info : 1;
>  };
>
> -static int is_atom(const char *atom, const char *s, int slen)
> -{
> -       int alen =3D strlen(atom);
> -       return alen =3D=3D slen && !memcmp(atom, s, alen);
> -}
> -
> -static void expand_atom(struct strbuf *sb, const char *atom, int len,
> -                       void *vdata)
> -{
> -       struct expand_data *data =3D vdata;
> -
> -       if (is_atom("objectname", atom, len)) {
> -               if (!data->mark_query)
> -                       strbuf_addstr(sb, oid_to_hex(&data->oid));
> -       } else if (is_atom("objecttype", atom, len)) {
> -               if (data->mark_query)
> -                       data->info.typep =3D &data->type;
> -               else
> -                       strbuf_addstr(sb, type_name(data->type));
> -       } else if (is_atom("objectsize", atom, len)) {
> -               if (data->mark_query)
> -                       data->info.sizep =3D &data->size;
> -               else
> -                       strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->siz=
e);
> -       } else if (is_atom("objectsize:disk", atom, len)) {
> -               if (data->mark_query)
> -                       data->info.disk_sizep =3D &data->disk_size;
> -               else
> -                       strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk=
_size);
> -       } else if (is_atom("rest", atom, len)) {
> -               if (data->mark_query)
> -                       data->split_on_whitespace =3D 1;
> -               else if (data->rest)
> -                       strbuf_addstr(sb, data->rest);
> -       } else if (is_atom("deltabase", atom, len)) {
> -               if (data->mark_query)
> -                       data->info.delta_base_oid =3D &data->delta_base_o=
id;
> -               else
> -                       strbuf_addstr(sb,
> -                                     oid_to_hex(&data->delta_base_oid));
> -       } else
> -               die("unknown format element: %.*s", len, atom);
> -}
> -
> -static size_t expand_format(struct strbuf *sb, const char *start, void *=
data)
> -{
> -       const char *end;
> -
> -       if (*start !=3D '(')
> -               return 0;
> -       end =3D strchr(start + 1, ')');
> -       if (!end)
> -               die("format element '%s' does not end in ')'", start);
> -
> -       expand_atom(sb, start + 1, end - start - 1, data);
> -
> -       return end - start + 1;
> -}
> -
>  static void batch_write(struct batch_options *opt, const void *data, int=
 len)
>  {
>         if (opt->buffer_output) {
> @@ -297,87 +209,34 @@ static void batch_write(struct batch_options *opt, =
const void *data, int len)
>                 write_or_die(1, data, len);
>  }
>
> -static void print_object_or_die(struct batch_options *opt, struct expand=
_data *data)
> -{
> -       const struct object_id *oid =3D &data->oid;
> -
> -       assert(data->info.typep);
> -
> -       if (data->type =3D=3D OBJ_BLOB) {
> -               if (opt->buffer_output)
> -                       fflush(stdout);
> -               if (opt->cmdmode) {
> -                       char *contents;
> -                       unsigned long size;
> -
> -                       if (!data->rest)
> -                               die("missing path for '%s'", oid_to_hex(o=
id));
> -
> -                       if (opt->cmdmode =3D=3D 'w') {
> -                               if (filter_object(data->rest, 0100644, oi=
d,
> -                                                 &contents, &size))
> -                                       die("could not convert '%s' %s",
> -                                           oid_to_hex(oid), data->rest);
> -                       } else if (opt->cmdmode =3D=3D 'c') {
> -                               enum object_type type;
> -                               if (!textconv_object(the_repository,
> -                                                    data->rest, 0100644,=
 oid,
> -                                                    1, &contents, &size)=
)
> -                                       contents =3D read_object_file(oid=
,
> -                                                                   &type=
,
> -                                                                   &size=
);
> -                               if (!contents)
> -                                       die("could not convert '%s' %s",
> -                                           oid_to_hex(oid), data->rest);
> -                       } else
> -                               BUG("invalid cmdmode: %c", opt->cmdmode);
> -                       batch_write(opt, contents, size);
> -                       free(contents);
> -               } else {
> -                       stream_blob(oid);
> -               }
> -       }
> -       else {
> -               enum object_type type;
> -               unsigned long size;
> -               void *contents;
> -
> -               contents =3D read_object_file(oid, &type, &size);
> -               if (!contents)
> -                       die("object %s disappeared", oid_to_hex(oid));
> -               if (type !=3D data->type)
> -                       die("object %s changed type!?", oid_to_hex(oid));
> -               if (data->info.sizep && size !=3D data->size)
> -                       die("object %s changed size!?", oid_to_hex(oid));
> -
> -               batch_write(opt, contents, size);
> -               free(contents);
> -       }
> -}
>
>  static void batch_object_write(const char *obj_name,
>                                struct strbuf *scratch,
>                                struct batch_options *opt,
>                                struct expand_data *data)
>  {
> -       if (!data->skip_object_info &&
> -           oid_object_info_extended(the_repository, &data->oid, &data->i=
nfo,
> -                                    OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> -               printf("%s missing\n",
> -                      obj_name ? obj_name : oid_to_hex(&data->oid));
> -               fflush(stdout);
> -               return;
> -       }
> +       int ret;
> +       struct strbuf err =3D STRBUF_INIT;
> +       struct ref_array_item item =3D { data->oid, data->rest };
>
>         strbuf_reset(scratch);
> -       strbuf_expand(scratch, opt->format, expand_format, data);
> -       strbuf_addch(scratch, '\n');
> -       batch_write(opt, scratch->buf, scratch->len);
>
> -       if (opt->print_contents) {
> -               print_object_or_die(opt, data);
> -               batch_write(opt, "\n", 1);
> +       ret =3D format_ref_array_item(&item, &opt->format, scratch, &err)=
;
> +       if (ret < 0)
> +               die("%s\n", err.buf);
> +       if (ret) {
> +               /* ret > 0 means when the object corresponding to oid
> +                * cannot be found in format_ref_array_item(), we only pr=
int
> +                * the error message.
> +                */
> +               printf("%s\n", err.buf);
> +               fflush(stdout);
> +       } else {
> +               strbuf_addch(scratch, '\n');
> +               batch_write(opt, scratch->buf, scratch->len);
>         }
> +       free_ref_array_item_value(&item);
> +       strbuf_release(&err);
>  }
>
>  static void batch_one_object(const char *obj_name,
> @@ -495,43 +354,37 @@ static int batch_unordered_packed(const struct obje=
ct_id *oid,
>         return batch_unordered_object(oid, data);
>  }
>
> -static int batch_objects(struct batch_options *batch)
> +static const char * const cat_file_usage[] =3D {
> +       N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown=
-type] | -e | -p | <type> | --textconv | --filters) [--path=3D<path>] <obje=
ct>"),
> +       N_("git cat-file (--batch[=3D<format>] | --batch-check[=3D<format=
>]) [--follow-symlinks] [--textconv | --filters]"),
> +       NULL
> +};
> +
> +static int batch_objects(struct batch_options *batch, const struct optio=
n *options)
>  {
>         struct strbuf input =3D STRBUF_INIT;
>         struct strbuf output =3D STRBUF_INIT;
> +       struct strbuf format =3D STRBUF_INIT;
>         struct expand_data data;
>         int save_warning;
>         int retval =3D 0;
>
> -       if (!batch->format)
> -               batch->format =3D "%(objectname) %(objecttype) %(objectsi=
ze)";
> -
> -       /*
> -        * Expand once with our special mark_query flag, which will prime=
 the
> -        * object_info to be handed to oid_object_info_extended for each
> -        * object.
> -        */
>         memset(&data, 0, sizeof(data));
> -       data.mark_query =3D 1;
> -       strbuf_expand(&output, batch->format, expand_format, &data);
> -       data.mark_query =3D 0;
> -       strbuf_release(&output);
> -       if (batch->cmdmode)
> -               data.split_on_whitespace =3D 1;
> -
> -       /*
> -        * If we are printing out the object, then always fill in the typ=
e,
> -        * since we will want to decide whether or not to stream.
> -        */
> +       if (batch->format.format)
> +               strbuf_addstr(&format, batch->format.format);
> +       else
> +               strbuf_addstr(&format, "%(objectname) %(objecttype) %(obj=
ectsize)");
>         if (batch->print_contents)
> -               data.info.typep =3D &data.type;
> +               strbuf_addstr(&format, "\n%(raw)");
> +       batch->format.format =3D format.buf;
> +       if (verify_ref_format(&batch->format))
> +               usage_with_options(cat_file_usage, options);
> +
> +       if (batch->cmdmode || batch->format.use_rest)
> +               data.split_on_whitespace =3D 1;
>
>         if (batch->all_objects) {
>                 struct object_cb_data cb;
> -               struct object_info empty =3D OBJECT_INFO_INIT;
> -
> -               if (!memcmp(&data.info, &empty, sizeof(empty)))
> -                       data.skip_object_info =3D 1;
>
>                 if (has_promisor_remote())
>                         warning("This repository uses promisor remotes. S=
ome objects may not be loaded.");
> @@ -561,6 +414,7 @@ static int batch_objects(struct batch_options *batch)
>                         oid_array_clear(&sa);
>                 }
>
> +               strbuf_release(&format);
>                 strbuf_release(&output);
>                 return 0;
>         }
> @@ -593,18 +447,13 @@ static int batch_objects(struct batch_options *batc=
h)
>                 batch_one_object(input.buf, &output, batch, &data);
>         }
>
> +       strbuf_release(&format);
>         strbuf_release(&input);
>         strbuf_release(&output);
>         warn_on_object_refname_ambiguity =3D save_warning;
>         return retval;
>  }
>
> -static const char * const cat_file_usage[] =3D {
> -       N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown=
-type] | -e | -p | <type> | --textconv | --filters) [--path=3D<path>] <obje=
ct>"),
> -       N_("git cat-file (--batch[=3D<format>] | --batch-check[=3D<format=
>]) [--follow-symlinks] [--textconv | --filters]"),
> -       NULL
> -};
> -
>  static int git_cat_file_config(const char *var, const char *value, void =
*cb)
>  {
>         if (userdiff_config(var, value) < 0)
> @@ -627,7 +476,7 @@ static int batch_option_callback(const struct option =
*opt,
>
>         bo->enabled =3D 1;
>         bo->print_contents =3D !strcmp(opt->long_name, "batch");
> -       bo->format =3D arg;
> +       bo->format.format =3D arg;
>
>         return 0;
>  }
> @@ -636,7 +485,9 @@ int cmd_cat_file(int argc, const char **argv, const c=
har *prefix)
>  {
>         int opt =3D 0;
>         const char *exp_type =3D NULL, *obj_name =3D NULL;
> -       struct batch_options batch =3D {0};
> +       struct batch_options batch =3D {
> +               .format =3D REF_FORMAT_INIT
> +       };
>         int unknown_type =3D 0;
>
>         const struct option options[] =3D {
> @@ -675,6 +526,7 @@ int cmd_cat_file(int argc, const char **argv, const c=
har *prefix)
>         git_config(git_cat_file_config, NULL);
>
>         batch.buffer_output =3D -1;
> +       batch.format.cat_file_mode =3D 1;
>         argc =3D parse_options(argc, argv, prefix, options, cat_file_usag=
e, 0);
>
>         if (opt) {
> @@ -718,7 +570,7 @@ int cmd_cat_file(int argc, const char **argv, const c=
har *prefix)
>                 batch.buffer_output =3D batch.all_objects;
>
>         if (batch.enabled)
> -               return batch_objects(&batch);
> +               return batch_objects(&batch, options);
>
>         if (unknown_type && opt !=3D 't' && opt !=3D 's')
>                 die("git cat-file --allow-unknown-type: use with -s or -t=
");
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 18b3779ccb6..7452404f24a 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -607,5 +607,256 @@ test_expect_success 'cat-file --batch=3D"batman" wi=
th --batch-all-objects will wor
>         git -C all-two cat-file --batch-all-objects --batch=3D"batman" >a=
ctual &&
>         cmp expect actual
>  '
> +. "$TEST_DIRECTORY"/lib-gpg.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
> +
> +test_expect_success 'cat-file --batch|--batch-check setup' '
> +       echo 1>blob1 &&
> +       printf "a\0b\0\c" >blob2 &&
> +       git add blob1 blob2 &&
> +       git commit -m "Commit Message" &&
> +       git branch -M main &&
> +       git tag -a -m "v0.0.0" testtag &&
> +       git update-ref refs/myblobs/blob1 HEAD:blob1 &&
> +       git update-ref refs/myblobs/blob2 HEAD:blob2 &&
> +       git update-ref refs/mytrees/tree1 HEAD^{tree}
> +'
> +
> +batch_test_atom() {
> +       if test "$3" =3D "fail"
> +       then
> +               test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must=
 fail" "
> +                       test_must_fail git cat-file --batch-check=3D'$2' =
>bad <<-EOF
> +                       $1
> +                       EOF
> +               "
> +       else
> +               test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
> +                       git for-each-ref --format=3D'$2' $1 >expected &&
> +                       git cat-file --batch-check=3D'$2' >actual <<-EOF =
&&
> +                       $1
> +                       EOF
> +                       sanitize_pgp <actual >actual.clean &&
> +                       cmp expected actual.clean
> +               "
> +       fi
> +}

I wonder if the above function and some of the tests below could be
introduced in a preparatory patch before this one. It could help check
that reusing ref-filter doesn't change the behavior with some atoms
that were previously supported or rejected. Of course if some atoms
are now failing or are now supported, then it's ok to add new tests
for these atoms in this patch.

> +batch_test_atom refs/heads/main '%(refname)' fail
> +batch_test_atom refs/heads/main '%(refname:)' fail

[...]

> +batch_test_atom refs/heads/main 'VALID'
> +batch_test_atom refs/heads/main '%(INVALID)' fail
> +batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
> +
> +test_expect_success '%(rest) works with both a branch and a tag' '
> +       cat >expected <<-EOF &&
> +       123 commit 123
> +       456 tag 456
> +       EOF
> +       git cat-file --batch-check=3D"%(rest) %(objecttype) %(rest)" >act=
ual <<-EOF &&
> +       refs/heads/main 123
> +       refs/tags/testtag 456
> +       EOF
> +       test_cmp expected actual
> +'

It's a bit strange that this test is added in this patch while the
commit message doesn't talk about %(rest). So I wonder if this new
test could move to another previous commit.

> +batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsiz=
e)
> +%(raw)'
> +batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objects=
ize)
> +%(raw)'
> +batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(object=
size)
> +%(raw)'
> +batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(object=
size)
> +%(raw)'
> +
> +

It looks like there are two empty lines instead of one above.

> +test_expect_success 'cat-file --batch equals to --batch-check with atoms=
' '
> +       git cat-file --batch-check=3D"%(objectname) %(objecttype) %(objec=
tsize)
> +%(raw)" >expected <<-EOF &&
> +       refs/heads/main
> +       refs/tags/testtag
> +       EOF
> +       git cat-file --batch >actual <<-EOF &&
> +       refs/heads/main
> +       refs/tags/testtag
> +       EOF
> +       cmp expected actual
> +'

I also wonder if the above new test belong to this commit or if it
could be moved to a previous commit.
