Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549AFC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F1760238
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGVILP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGVILO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:11:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC7C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:51:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ee25so5831165edb.5
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfBtsnB1a4PeTHKrKHio6VF0lGixCtkdh8IeZyqslE0=;
        b=SZ59m3MAFto9HRs/I5LzDRqqzHlako8NAmM2uisqb3w6L4tLUaA3O2LHUrQ+6Nyl2+
         jBe05go1HOfbF3sopHcgFD607hd30OflczXvM5Ce7kS0g4JSDK6JhqlaYzMnPvxqQQ1m
         ABAT1ScvHLjO2qe3mmlPzOO6VZJPeVMc0ssMCgYcR44qJUM5scPi3JKOVaY9QZN4OQDb
         15FhhF4RRPUEvLTQCFczFWmINC/vUOY4fHLbIvtiJu6ZIHRjG4+PHaCPTxE2WBDuCBlt
         C2ubNz6jAlo+Beq5y4aDlL848AE3tqTUpuLDzr+X/+NVhyVKmu6I0EtQ5AGs5BWOPLKm
         wt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfBtsnB1a4PeTHKrKHio6VF0lGixCtkdh8IeZyqslE0=;
        b=T5CX1hzx0mkmSRIYok1mF6N15FSXLcUxo5UQc01N/FNQX9Ihsc22V9joGNWE3w7CXk
         GU4W/zD2+Cb6qfyqjRwhgW7ihW2Ewe1WT0p7Cz75No0s5ufrpKlt8jypv8dR8rhIp+Sv
         an9QTtvsJJduDlVFYjXQ0SPtZv5hlMqsyx4cpNMmOucanh0X9fbLJra6dmN7JBQaWkn5
         yPcf4IJrpViFhzPrVDU8dIPUTeP7Kd+hbHIlOpL0UsBusGU/PqgOHPyJHNMoHreC3FAo
         HbeHzDeODYw913Wh/2Ryd3kIPO8nIjsY92gwA95HvEKH2pzNPlOB9GFw6VhhWHHWpt0o
         HIgA==
X-Gm-Message-State: AOAM530KTxUvUVOSyTQ2tuKOJlwYDVG8+C1iDzVTQDBjNuN6W8gp/rEc
        JC48UuZZpUa9kKk3gDU2ikmEMS4toAenjd6K414=
X-Google-Smtp-Source: ABdhPJzDQwbkZ6b3Jpe29ieN3v6qsgvMOGv3Jjsw6jj9UBXXdPxvfRKAEnifhubGDQ9VKCTE0sRVZ9L8a6oVZd18rvY=
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr40969641edy.362.1626943907219;
 Thu, 22 Jul 2021 01:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com> <a7b4e45f14a27bd67172e24660f448e4c9cce5d8.1626939557.git.gitgitgadget@gmail.com>
In-Reply-To: <a7b4e45f14a27bd67172e24660f448e4c9cce5d8.1626939557.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jul 2021 10:51:36 +0200
Message-ID: <CAP8UFD3nmnu7fEOG75O46qEKtFHppbeZy3Y-NkPTCgphM5MPqA@mail.gmail.com>
Subject: Re: [PATCH 1/5] [GSOC] ref-filter: add obj-type check in grab contents
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
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

On Thu, Jul 22, 2021 at 9:39 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Only tag and commit objects use `grab_sub_body_contents()` to grab
> object contents in the current codebase.  We want to teach the
> function to also handle blobs and trees to get their raw data,
> without parsing a blob (whose contents looks like a commit or a tag)
> incorrectly as a commit or a tag.
>
> Skip the block of code that is specific to handling commits and tags
> early when the given object is of a wrong type to help later
> addition to handle other types of objects in this function.

Small nit in case the series is rerolled: it looks like this commit
would change only `grab_sub_body_contents()`, but there are a few
changes to grab_values() too. Maybe you could add that it's needed to
pass a `struct expand_data *data` instead of only `void *buf` to both
`grab_sub_body_contents()` and `grab_values()` to be able to check the
object type.


> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
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
