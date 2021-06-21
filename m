Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155AC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04665606A5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 05:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUF6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFUF6J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 01:58:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042CC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 22:55:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dm5so14330326ejc.9
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 22:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kzZe+GUtgKvW8Fd2ej5szVWFhLCtA0wdQtX9I9i5cIg=;
        b=YlFa/WgsS/7+xwIPzI40TgM8iO1TA+tBFLfAXEe9l9iv5l06SJf2yMKT4ehPj363x+
         KADJsi2cb2Umb4WPGMSXu07l9PmNKcjNxicgWOIrv4LpP2SrU1YAVzDmXOXgzjZAhZlh
         gzuaWjJcOwZtVod6yp08RbwPciTxmwC4SA5hLljbTWP+SIb2OcqdrwEM4nDc+p7MnwwZ
         vtoT5TzXUSda+TWMlFQ0cJ3p63sgvVK61qKeLlSzyxuRObOmp05ikuByXcBgvEXgaw+r
         gFir+RAUgg+vt5NU21h3kJU6AG04ia1NYVECCGabTFyYSrILmVrdSeQhQqAiG/fTWfju
         D3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kzZe+GUtgKvW8Fd2ej5szVWFhLCtA0wdQtX9I9i5cIg=;
        b=We4trfigxFvRlDHeY5W04qOQ49JAuJ+3Sp+WCuGu2prtyhQN5jJwB1NIU7BnetFxrl
         GVVDXuXmZAW3xx6MY30XSky/vRUEOKsjxayExoi3JXKHmnoqHc3CsgAjChooFItcG0KT
         EazeF0ScEuDBGmIyLU7yuqAMbfJFfmX24rfA0/Y3ncPpPT1Vi3CuA9JWKk+v10D9Akdr
         cVoYQFdqjtbv4yXQyoBIrqbDXwo9cFFYeA+nwhFxHEa44dd8tXaFBEFr0ybkaUJ7FcAg
         N3IV0gHDTZNKnNbSLnAornQTQOeneVfNqy4Lz9N7kcNDsj7oPMOVTbeAm/6f3byMBScg
         BSkg==
X-Gm-Message-State: AOAM532+2TqX8VQb7Vnzp+ynIQcXYo++391yDHvlQxHwAXjY1wZe8eYP
        OhHUBtwdUleLgzH/foxLn3ewGZWNw+EGiWyXhWk=
X-Google-Smtp-Source: ABdhPJzb/FhPzTDR6b6v4Pm7UMoILTuWC0ob2GW6EELPK6sE8b3pHLEBZXGyKsVrqV7THu1iNpXKz3W1rG2bQO/LmGo=
X-Received: by 2002:a17:906:dc6:: with SMTP id p6mr14953854eji.283.1624254953420;
 Sun, 20 Jun 2021 22:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
 <pull.980.v3.git.1624086181.gitgitgadget@gmail.com> <bd534a266a401a8edbf8c4d12a2d9e44fcc79d70.1624086181.git.gitgitgadget@gmail.com>
In-Reply-To: <bd534a266a401a8edbf8c4d12a2d9e44fcc79d70.1624086181.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Jun 2021 07:55:42 +0200
Message-ID: <CAP8UFD18iumUEgayGxL612MmbK9_2uDpHz3i7aqJ5zYSh7skqg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 19, 2021 at 9:03 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to let cat-file use ref-filter logic, the following
> methods are used:

Maybe: s/the following methods are used/let's do the following/

> 1. Add `cat_file_mode` member in struct `ref_format`, this can
> help us reject atoms in verify_ref_format() which cat-file
> cannot use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...
> 2. Change the type of member `format` in struct `batch_options`
> to `ref_format`, We can add format data in it.

Not sure what "We can add format data in it." means.

> 3. Let `batch_objects()` add atoms to format, and use
> `verify_ref_format()` to check atoms.
> 4. Use `has_object_file()` in `batch_one_object()` to check
> whether the input object exists.
> 5. Let get_object() return 1 and print "<oid> missing" instead
> of returning -1 and printing "missing object <oid> for <refname>",
> this can help `format_ref_array_item()` just report that the
> object is missing without letting Git exit.
> 6. Use `format_ref_array_item()` in `batch_object_write()` to
> get the formatted data corresponding to the object. If the
> return value of `format_ref_array_item()` is equals to zero,
> use `batch_write()` to print object data; else if the return
> value less than zero, use `die()` to print the error message
> and exit; else return value greater than zero, only print the

s/else return value greater/else if the return value is greater/

> error message, but not exit.

s/not exit/don't exit/

> 7. Use free_ref_array_item_value() to free ref_array_item's
> value.

That looks like a lot of changes in a single commit. I wonder if this
commit could be split.

> Most of the atoms in `for-each-ref --format` are now supported,
> such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> `%(flag)`, `%(HEAD)`, because our objects don't have refname.

s/refname/a refname/

It might be worth talking a bit about possible performance changes.

[...]

> +       ret =3D format_ref_array_item(&item, &opt->format, scratch, &err)=
;
> +       if (!ret) {
> +               strbuf_addch(scratch, '\n');
> +               batch_write(opt, scratch->buf, scratch->len);
> +       } else if (ret < 0) {
> +               die("%s\n", err.buf);

This if (ret < 0) could be checked first.

> +       } else {
> +               /* when ret > 0 , don't call die and print the err to std=
out*/

I think it would be more helpful to tell what ret > 0 means, rather
than what we do below (which can easily be seen).

> +               printf("%s\n", err.buf);
> +               fflush(stdout);
>         }

For example:

       if (ret < 0) {
               die("%s\n", err.buf);
       if (ret) {
               /* ret > 0 means ... */
               printf("%s\n", err.buf);
               fflush(stdout);
       } else {
               strbuf_addch(scratch, '\n');
               batch_write(opt, scratch->buf, scratch->len);
       }

> +       free_ref_array_item_value(&item);
> +       strbuf_release(&err);
>  }

[...]

> +static int batch_objects(struct batch_options *opt, const struct option =
*options)

It's unfortunate that one argument is called "opt" and the other one
"options". I wonder if the first one could be called "batch" as it
seems to be called this way somewhere else.

> +       if (!opt->format.format)
> +               strbuf_addstr(&format, "%(objectname) %(objecttype) %(obj=
ectsize)");
> +       else
> +               strbuf_addstr(&format, opt->format.format);

If there is no reason for the condition to be (!X) over just (X), I
think the latter is a bit better.

>         if (opt->print_contents)
> -               data.info.typep =3D &data.type;
> +               strbuf_addstr(&format, "\n%(raw)");
> +       opt->format.format =3D format.buf;

I wonder if this should be:

      opt->format.format =3D strbuf_detach(&format, NULL);

> +       if (verify_ref_format(&opt->format))
> +               usage_with_options(cat_file_usage, options);

[...]

> @@ -86,7 +87,7 @@ struct ref_format {
>         int need_color_reset_at_eol;
>  };
>
> -#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
> +#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }

Maybe this can already be changed to a designated initializer, like
=C3=86var suggested recently.

[...]

> +test_expect_success 'cat-file refs/heads/main refs/tags/testtag %(rest)'=
 '

If this test is about checking that %(rest) works with both a branch
and a tag, it might be better to say it more explicitly.

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
