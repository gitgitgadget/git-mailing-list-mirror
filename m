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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B8C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 06:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B761001
	for <git@archiver.kernel.org>; Sun,  9 May 2021 06:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhEIGW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIGW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 02:22:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920BC061573
        for <git@vger.kernel.org>; Sat,  8 May 2021 23:21:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so19730180ejo.13
        for <git@vger.kernel.org>; Sat, 08 May 2021 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoAc1wZkc+Za8AgMJhk59RtUZML999hp1kapTAugDxE=;
        b=Ic/8mbX/pb0IUiRVMebuTtmHGhCU/nHg7Yy3rhpT9CAbX5xPbjz+ymUoqGlkHz+QVW
         b5Ye5SQkDGIBbnUqrwTBo0szwGYPEQrUt4bPf6soTruyoNgWqV2Ml2c/PgYgGvbadmix
         zszrsrFfRt0E9f8BSvX6HWUHhMVeU3r2J6YcTy/BxLX9AJWA3SMSSaf9kIYbrThvdmvp
         e3VHxKyCx9mOtHyyCpeeCnM2ARe2dWTDXiJL6cmaS7cIIpmSu8PTPVxVnALdnHaEwaIE
         UGLl1svngvwFjEep+GyJsoxtxkGSj/UcuSmPh0rDxg3BCjDIJ8enFF0FZ3Ht57tpeTuH
         fZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoAc1wZkc+Za8AgMJhk59RtUZML999hp1kapTAugDxE=;
        b=VECbu6Jj0jwjv6oseMWDNNU6SLd9j/fwEouEBeLmgAhi0bID+vgLltFtz7LwjfqT2+
         /KCUy65GjDYffsX/lYrzCz6HjXairVrlWE/vNFk5RoNK/JtCK5bthJLv8LzJdk1u0DIQ
         NXV8QoXtjCPEIaLb2pxybfEBrVH9jq8DkzTuzCnGR0a3zix1oOZcigg9JmvGISQi+cHU
         UW6qEhoxFfg7h4LNcCjxWXX8ZUE/Y69Ad9IZSv80PXctn06VQyxQr/14pP8LFMzavP8E
         tfUkj87EAjtlnt2WOMby5cCcM4VYqhRxk++SVEJR8NVjzE9KrLeH19eWrE9aeYEn2nbW
         KA+Q==
X-Gm-Message-State: AOAM5302FbVWjlNf44xToJ+a4mN1dSafsLrKxjvHyMRNMNRrT33FKCji
        J6HmNFNUhyiUrgB+Yiko8M/zJ21eQT9bW7lE96p18oGkfhE=
X-Google-Smtp-Source: ABdhPJzITyKZxlzJ7EL7+Ps8+geYD7NUzdY1OudRwQ+rrSPbQKAFPFArESyOMVAX4o8M8dN0yNXrocHmgfAynbJnG/Y=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr2246692ejh.341.1620541312549;
 Sat, 08 May 2021 23:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com> <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
In-Reply-To: <3770df1829830229e768607b699730d2a7c21c5e.1620487353.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 9 May 2021 08:21:41 +0200
Message-ID: <CAP8UFD0mOmqWUS49wywDVoWOyAkCRSUY5+i7Gqq-ZZSNCr-jvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC][RFC] ref-filter: introduce enum atom_type
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 8, 2021 at 5:22 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> In the original ref-filter design, it will copy the parsed
> atom's name and attributes to `used_atom[i].name` in the
> atom's parsing step, and use it again for string matching
> in the later specific ref attributes filling step. It use
> a lot of string matching to determine which atom we need.
>
> Introduce the enum member `valid_atom.atom_type` which
> record type of each valid_atom, in the first step of the
> atom parsing, `used_atom.atom_type` will record corresponding
> enum value from `valid_atom.atom_type`, and then in specific
> reference attribute filling step, only need to compare the
> value of the `used_atom.atom_type` to judge the atom type.
>
> At the same time, The value of an atom_type is the coordinate
> of its corresponding valid_atom entry, we can quickly index
> to the corresponding valid_atom entry by the atom_type value.

I am not sure it's worth having an atom_type field for each valid_atom
element if the value of that field is already the index of the
element, because then one would always be able to replace
`valid_atom[i].atom_type` with just `i`. Or is it for some kind of
type safety issue?

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  ref-filter.c | 192 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 123 insertions(+), 69 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index f420bae6e5ba..4ce46e70dc99 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -108,6 +108,50 @@ static struct ref_to_worktree_map {
>         struct worktree **worktrees;
>  } ref_to_worktree_map;
>
> +enum atom_type {
> +ATOM_REFNAME,
...
+ATOM_ELSE,
+};

I wonder if the enum should be instead defined like this:

enum atom_type {
ATOM_UNKNOWN = 0,
ATOM_REFNAME,
...
ATOM_ELSE,
ATOM_INVALID, /* should be last */
};

As a struct containing an atom_type would typically be initialized
with 0 after being allocated, `ATOM_UNKNOWN = 0` could ensure that we
can easily distinguish such a struct where the atom_type is known from
such a struct where it is unknown yet.

Having ATOM_INVALID as always the last enum value (even if some new
ones are added later) could help us iterate over the valid atoms using
something like:

for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++)
        /* do something with valid_atom[i] */;

> +
>  /*
>   * An atom is a valid field atom listed below, possibly prefixed with
>   * a "*" to denote deref_tag().
> @@ -122,6 +166,7 @@ static struct used_atom {
>         const char *name;
>         cmp_type type;
>         info_source source;
> +       enum atom_type atom_type;
>         union {
>                 char color[COLOR_MAXLEN];
>                 struct align align;
> @@ -500,53 +545,54 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
>  }
>
>  static struct {
> +       enum atom_type atom_type;
>         const char *name;
>         info_source source;
>         cmp_type cmp_type;

I can see that the fields are already not in the same order as in
struct used_atom, but my opinion is that it would be better if they
would we as much as possible in the same order. Maybe one day we could
even unify these structs in some way.

Also as discussed above we might not even need to add an atom_type to
valid_atom[].

>         int (*parser)(const struct ref_format *format, struct used_atom *atom,
>                       const char *arg, struct strbuf *err);
>  } valid_atom[] = {

> @@ -628,6 +674,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>         at = used_atom_cnt;
>         used_atom_cnt++;
>         REALLOC_ARRAY(used_atom, used_atom_cnt);
> +       used_atom[at].atom_type = valid_atom[i].atom_type;

As discussed above, if the value of an atom_type is the coordinate of
its corresponding valid_atom entry, then here the following would be
simpler:

       used_atom[at].atom_type = i;

>         used_atom[at].name = xmemdupz(atom, ep - atom);
>         used_atom[at].type = valid_atom[i].cmp_type;
>         used_atom[at].source = valid_atom[i].source;
> @@ -652,7 +699,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>                 return -1;
>         if (*atom == '*')
>                 need_tagged = 1;
> -       if (!strcmp(valid_atom[i].name, "symref"))
> +       if (valid_atom[i].atom_type == ATOM_SYMREF)

In the same way as above, the above line might be replaced with the simpler:

       if (i == ATOM_SYMREF)

>                 need_symref = 1;
>         return at;
>  }
