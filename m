Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627FC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 08:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92FB60F13
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhGYHlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhGYHlo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 03:41:44 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFEC061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 01:22:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id f28so3493749vsh.12
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZcxuaRmTbsOh7ZET9N94NHfeDHKMPtLmPgI85z/Tp0=;
        b=KSLkNZypsMs17OBkTWRi7SxI1/LEjEQunYU9la8jwgHmIjtQ25gWnFjJ3X0tPen4mu
         9494JEoRgxR0oElBZVD+Qg3VekwnPipwGDsO3aBcmbk0+yohQitiBRFdYx0Phjg94NcE
         HDESL4ImceDf8js/YTS5074/weNejDZIQLYyMBiqzQZ/t6uaAEuccFwjTGTh22q7kgDA
         s4+KhMKW90uNzBUD5hv5iXqi1Hze0CwjIGgyYh8m2Ztv0/NPi/ZSWRMUXunXPH0jeXLs
         hQx+Igu9ds3uFDrKgcv/fGV+VrIFcjAopj62WiAQ9wD7gX2PetZipb98QBY3Y2U8/t6D
         OmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZcxuaRmTbsOh7ZET9N94NHfeDHKMPtLmPgI85z/Tp0=;
        b=MyoaO4oNCW/q1yUvgtcCA2tn1M4FiuWfrwvnbbT+BOHEgwXBoIzi7Dbb5JywsHtYdv
         7uXamuUOxx1QBr2r3c+5bZ6YC+jwonFIojrVLvbUmVUwTXO+O3annv7em5LQZib6ZTiz
         jnDflz/S1f/HwvQ+8MzVlROmQbIpxkDmKdzzfdLF3Kjcpd6hycGgBiKX0XyuXo3KNN5p
         TzrL5lTRSGf2S2at5/T2ORKsnMUaxSOoacjg6NE12DWPyyoW1NgpeRoUVBHOZ4QU785f
         ozT5uKk1Ye43Cph8Z/cu5IXWSY6XFDDBWO/i9H8VZpSpKkeTGevqgwiMgLFUhzVeKrYl
         Xz5A==
X-Gm-Message-State: AOAM533CG+HTSNJmfQ4DbdbXGtVwj3NN2/RpCjgUULWo60torE0sYH2g
        9yRQxJVXzdcfbSeV/ti6MCtX/+ZlCT6pkun86vA=
X-Google-Smtp-Source: ABdhPJyQLkWUDTYfhe7eaRGSV4ZrxZbUQAUDCU7k2rHGzhhkPhRj4QGVHMMDLZeFSDBY7EUh74QX0VYQeJ1ivXPQC8I=
X-Received: by 2002:a67:e214:: with SMTP id g20mr9113121vsa.5.1627201332975;
 Sun, 25 Jul 2021 01:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
 <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com> <d77268bb1882a6cfbea740053baac5546ca5c5f1.1627136062.git.gitgitgadget@gmail.com>
In-Reply-To: <d77268bb1882a6cfbea740053baac5546ca5c5f1.1627136062.git.gitgitgadget@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Jul 2021 01:22:02 -0700
Message-ID: <CA+P7+xrasxoSnbxNBVhwoOjejFw8UFH_Xufpts7-fGByknynHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] [GSOC] ref-filter: add obj-type check in grab contents
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 24, 2021 at 7:14 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Only tag and commit objects use `grab_sub_body_contents()` to grab
> object contents in the current codebase.  We want to teach the
> function to also handle blobs and trees to get their raw data,
> without parsing a blob (whose contents looks like a commit or a tag)
> incorrectly as a commit or a tag. So it's needed to pass a
> `struct expand_data *data` instread of only `void *buf` to both
> `grab_sub_body_contents()` and `grab_values()` to be able to check
> the object type.
>
> Skip the block of code that is specific to handling commits and tags
> early when the given object is of a wrong type to help later
> addition to handle other types of objects in this function.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

Nice. The addition of changing the type made sense and is spelled out nicely.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

>  ref-filter.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 4db0e40ff4c..5cee6512fba 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  }
>
>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
> +static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
>  {
>         int i;
>         const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
>         size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
> +       void *buf = data->content;
>
>         for (i = 0; i < used_atom_cnt; i++) {
>                 struct used_atom *atom = &used_atom[i];
> @@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>                         continue;
>                 if (deref)
>                         name++;
> -               if (strcmp(name, "body") &&
> -                   !starts_with(name, "subject") &&
> -                   !starts_with(name, "trailers") &&
> -                   !starts_with(name, "contents"))
> +
> +               if ((data->type != OBJ_TAG &&
> +                    data->type != OBJ_COMMIT) ||
> +                   (strcmp(name, "body") &&
> +                    !starts_with(name, "subject") &&
> +                    !starts_with(name, "trailers") &&
> +                    !starts_with(name, "contents")))
>                         continue;
>                 if (!subpos)
>                         find_subpos(buf,
> @@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
>   * pointed at by the ref itself; otherwise it is the object the
>   * ref (which is a tag) refers to.
>   */
> -static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
> +static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
>  {
> +       void *buf = data->content;
> +
>         switch (obj->type) {
>         case OBJ_TAG:
>                 grab_tag_values(val, deref, obj);
> -               grab_sub_body_contents(val, deref, buf);
> +               grab_sub_body_contents(val, deref, data);
>                 grab_person("tagger", val, deref, buf);
>                 break;
>         case OBJ_COMMIT:
>                 grab_commit_values(val, deref, obj);
> -               grab_sub_body_contents(val, deref, buf);
> +               grab_sub_body_contents(val, deref, data);
>                 grab_person("author", val, deref, buf);
>                 grab_person("committer", val, deref, buf);
>                 break;
> @@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>                         return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
>                                                oid_to_hex(&oi->oid), ref->refname);
>                 }
> -               grab_values(ref->value, deref, *obj, oi->content);
> +               grab_values(ref->value, deref, *obj, oi);
>         }
>
>         grab_common_values(ref->value, deref, oi);
> --
> gitgitgadget
>
