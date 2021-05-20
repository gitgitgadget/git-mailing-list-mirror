Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C72C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2AF611AE
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhETQWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhETQWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:22:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71323C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:20:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g7so7933311edm.4
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjPgJwnShQcWhQXCzFFJByBmQRHdlbofCc/kMnb16wU=;
        b=qzOFGOE/m3QLE2HnCYf3G3uCPBGHEvt19dxIToyULJv705UHSJu0FmZmXKEE0lMV9N
         TwprtZSDqIRV4o4ZJf6RfOX7gR80e4KKMvB5oUNKNBKrny4reXzTB9uJZreSesom6qh6
         kxAWzkBizQfRqZVVG7aBjc1dbCwWdcKGvfYWWd7kJp+Fg4Ez8rRH3C/K7ZAc2GtO7P73
         krkXZpqKmG7jZQOO5ypyKe5LZSbG6TlAMNQxHDKNudz8UMLF3pAtx9tTu5ei9xKnNyjg
         Qo4yPVas4kZAY3VGsEu5GCp/L3/syCZbKCbwUDf/bMYhmfKdf4wdhIZudVuWDnY5HQaF
         11dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjPgJwnShQcWhQXCzFFJByBmQRHdlbofCc/kMnb16wU=;
        b=q3pBv7+C0tjNLVU7sN5wU94+wggQ9n1b2fOkHNGU+e88B3+xeF64EHI9I2v8hkkfk0
         SER3apzeqZ5axZdlSee3b4SdD6qZ7Iw/2jkdIkUhDiKAapodQ0z2RMh61C5gAmRD5csr
         V3JJhyCyymJlYK5wkBT3tp3W53p16qm+pCRCxlSla8HBMLYoJXKnDSM5n+tLxMQXWY+I
         +t1ZVYFCCcEV4egK5As9jRiczZ/hLwdUltIb+9gjnGeT2BrGlBmkCYV458Oqpm7NTN9V
         oMPzA265KCDCgpMfFpTgixL6YDFYgVLPXDoepMNT06WYBM3PBCNikHo+VQWVOgcMWDWy
         eUmA==
X-Gm-Message-State: AOAM533UzsWWGPnJZSEpRgjzuSsZDHvP8iV4z8ohUEIUPkVpgX5/386r
        6v8JbBZfJWP7bgbkNr+F5Df+ILNzQInxrwoHZPg=
X-Google-Smtp-Source: ABdhPJyQyhu0tDx87/sn6QjwpupWJ42AYqFDmMUcVDbxz7wKzVvTjOw3Pa6EulXmyykVsNWqmUNhv54xC+ZjT6mj8dk=
X-Received: by 2002:a05:6402:1d2c:: with SMTP id dh12mr2391623edb.237.1621527641898;
 Thu, 20 May 2021 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
In-Reply-To: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 May 2021 18:20:30 +0200
Message-ID: <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 10:49 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add new formatting option %(contents:raw), which will
> print all the object contents without any changes.

Maybe you could tell how it would be different from %(contents), or in
other words what are the changes that %(contents) makes.

Isn't %(contents) only printing the commit message or the tag message
of a commit or a tag respectively? If %(contents:raw) would print all
the object contents, it could feel strange that it is actually
printing more than %(contents).

Also is %(contents:raw) supposed to print something for a blob or a
tree, while I guess %(contents) is printing nothing for them?

> It will help further to migrate all cat-file formatting
> logic from cat-file to ref-filter.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

It looks like you rewrote the patch nearly completely, but if you
based your patch on, or got inspired by, Olga's work, it might be nice
to acknowledge this using a trailer (for example "Based-on-patch-by:
..." or "Helped-by:...").

> ---
>     [GSOC] ref-filter: add contents:raw atom
>
>     Learn from Olga's %(raw):
>     https://github.com/git/git/pull/568/commits/bf22dae7ca387dbc92c5586c92e60cd395099399
>
>     We can add a %(contents:raw) atom to ref-filter, which can output object
>     contents without any change.
>
>     %(contents:raw) can work on the refs which point to blob,tree,commit,tag
>     objects.
>
>     It also support %(*contents:raw) to dereference.
>
>     With %(cotent:raw), we can later provide support for printing the

s/cotent/contents/

>     content of the "raw" object for cat-file --batch.

> @@ -1292,7 +1294,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  }
>
>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
> +static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
> +                                  unsigned long buf_size, enum object_type object_type)
>  {
>         int i;
>         const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
> @@ -1312,6 +1315,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>                     !starts_with(name, "trailers") &&
>                     !starts_with(name, "contents"))
>                         continue;
> +               if (atom->u.contents.option == C_RAW) {
> +                       v->s = xmemdupz(buf, buf_size);
> +                       continue;
> +               }
> +               if (object_type != OBJ_TAG && object_type != OBJ_COMMIT)
> +                       continue;

When seeing the 2 lines above, I am guessing that, before this patch,
grab_sub_body_contents() couldn't actually be called when object_type
was OBJ_BLOB or OBJ_TREE, but you have made other changes elsewhere so
that now it can. As only the atom->u.contents.option == C_RAW case is
relevant in this case, you added this check. Let's see if I am
right...

>                 if (!subpos)
>                         find_subpos(buf,
>                                     &subpos, &sublen,
> @@ -1374,25 +1384,30 @@ static void fill_missing_values(struct atom_value *val)
>   * pointed at by the ref itself; otherwise it is the object the
>   * ref (which is a tag) refers to.
>   */
> -static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
> +static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
>  {
> +       void *buf = data->content;
> +       unsigned long buf_size = data->size;
> +
>         switch (obj->type) {
>         case OBJ_TAG:
>                 grab_tag_values(val, deref, obj);
> -               grab_sub_body_contents(val, deref, buf);
> +               grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
>                 grab_person("tagger", val, deref, buf);
>                 break;
>         case OBJ_COMMIT:
>                 grab_commit_values(val, deref, obj);
> -               grab_sub_body_contents(val, deref, buf);
> +               grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
>                 grab_person("author", val, deref, buf);
>                 grab_person("committer", val, deref, buf);
>                 break;
>         case OBJ_TREE:
>                 /* grab_tree_values(val, deref, obj, buf, sz); */
> +               grab_sub_body_contents(val, deref, buf, buf_size, obj->type);
>                 break;
>         case OBJ_BLOB:
>                 /* grab_blob_values(val, deref, obj, buf, sz); */
> +               grab_sub_body_contents(val, deref, buf, buf_size, obj->type);

...ok, I was right above. The issue now is that I wonder if
grab_sub_body_contents() is still a good name for a function that can
be called for a blob or a tree which does not really have a body.

>                 break;
>         default:
>                 die("Eh?  Object of type %d?", obj->type);
> @@ -1614,7 +1629,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>                         return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
>                                                oid_to_hex(&oi->oid), ref->refname);
>                 }
> -               grab_values(ref->value, deref, *obj, oi->content);
> +               grab_values(ref->value, deref, *obj, oi);
>         }
>
>         grab_common_values(ref->value, deref, oi);
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 9e0214076b4d..baa3a40a70b1 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -686,6 +686,17 @@ test_atom refs/tags/signed-empty contents:body ''
>  test_atom refs/tags/signed-empty contents:signature "$sig"
>  test_atom refs/tags/signed-empty contents "$sig"
>
> +test_expect_success 'basic atom: refs/tags/signed-empty contents:raw' '
> +       git cat-file tag refs/tags/signed-empty >expected &&
> +       git for-each-ref --format="%(contents:raw)" refs/tags/signed-empty >actual &&
> +       sanitize_pgp <expected >expected.clean &&
> +       sanitize_pgp <actual >actual.clean &&
> +       echo "" >>expected.clean &&
> +       test_cmp expected.clean actual.clean
> +'

For an empty tag %(contents:raw) should produce nothing, ok.

> +test_atom refs/tags/signed-empty *contents:raw $(git cat-file commit HEAD)

Maybe use single quotes around *contents:raw?

The rest looks good to me. Thanks!
