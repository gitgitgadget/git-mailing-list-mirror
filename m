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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B559FC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CF265231
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 06:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhCPGvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhCPGvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 02:51:08 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AAFC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:51:08 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so3873075oor.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sRYGLavn3+aENRh11x/wpBpFQAuoM3t2eBztCzDAPC0=;
        b=Yrmo7ywTvmsvN7EjlRTDEqCRNKjFMkQC7SHqaVctyy7wn8EzjzWMTPUdUJI7umrhDR
         zWZYSBvK8ocaIyShV7R6Bo9yGcycxBOgyEfcYCbEqOc0jccnIkgMgFWLha6wJaMncbs7
         q8T/5jiORcmrdLDlmYyQSWIqjVTHFnNEMw0ui3M5OF5DdtFe8w4wE06RsZQ2WbIZOTE5
         R3HCF/yDgfqpOM3HEfd24No+vxZwOJvmM1Yj9BFh3uHt1BubMGPo8fstalRKqUEvm2Uj
         btt7MkUmMV/7UTiRqroISAkNV3ZEv/1jSviEdYz+LRPgOATF58hUw1unTjNbkNswzVC4
         z30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sRYGLavn3+aENRh11x/wpBpFQAuoM3t2eBztCzDAPC0=;
        b=b3k3eLpizJpVPlQ55I9QqTx/3R+dbROsX3YOWTbJJdpmnMnpWgEVJQ0trFxBxUtccb
         XFPqAlfb0CeFX/aZfaoI164W3trmTyYufxOx2qlGTKZ9MGJuBxb+cfhDUP9nLzTkkrX0
         Cb8yb80ep+6WA0wpMKbVeeFoluHwFx/Kwcu11n4M2W8k9fSMmJa68S93bGgonmZcGHjz
         igC2QRm4G+9nsAu7gCknwQyNMb8rp8JuB5ca/jvhdwRMAsUHRpk2GIRR/jOQTZpOoeRy
         0sjtEeVk6WOxbE7us/Ov6JFq2SfrAyF95B+hyAqNCktTuSNNnkiwVjXZNDLgC1/GblEl
         jjvA==
X-Gm-Message-State: AOAM532zNouD6c79Ur9hsx9wQ6eh2vomwAUaWw/yecZGQtu8MxRNj9H8
        mT8M+FcpiyoSFOAB5uYv1bG3gnoN0Md7ST3GelQ8jVCRp6B1vA==
X-Google-Smtp-Source: ABdhPJyNTD149bmXjI/hsUcvdqwf7nBjuaXbyZ0l6Otxj+lyOoTlLK2oOuli8Zi8NRDUyA0WM9CQGz99kbvSemOrqMY=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr2438495oog.7.1615877467252;
 Mon, 15 Mar 2021 23:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210308150650.18626-1-avarab@gmail.com> <20210316021312.13927-28-avarab@gmail.com>
In-Reply-To: <20210316021312.13927-28-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 23:50:56 -0700
Message-ID: <CABPp-BF3SOzz+C1YW73kYgz2P8h2pSgYSmc8FJMOygAHVdoeFw@mail.gmail.com>
Subject: Re: [PATCH v2 27/29] tree-walk.h API: add a get_tree_entry_path() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 7:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add a get_tree_entry_path() variant in addition to
> get_tree_entry_path_{mode,type,all}(). This is for those callers that
> need neither the mode nor "enum object_type" parameters filled for
> them.
>
> There's callers here which doesn't need the "struct object_id" filled
> either, and provides a throwaway variable for us.

As with the previous round, this paragraph does not parse well.  My
suggestion on the last round was:

There are callers here which don't need the "struct object_id" filled;
forcing callers to pass one just requires they create a throwaway
variable.

you don't have to take it, but the paragraph needs rewording one way or ano=
ther.

>
> See the following commits for the introduction of such code that's
> being modified here:
>
>  - shift_tree(): 68faf68938e (A new merge stragety 'subtree'.,
>     2007-02-15) for the shift_tree()
>
>  - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for directory
>    level conflicts, 2018-04-19)
>
>  - init_notes(): fd53c9eb445 (Speed up git notes lookup, 2009-10-09)
>
>  - diagnose_invalid_oid_path(): 009fee4774d (Detailed diagnosis when
>    parsing an object name fails., 2009-12-07)
>
> Those could potentially be refactored too, but I've got to stop at
> some point, and right now I'm focusing downstream code that depends on
> "mode" (or "enum object_type").
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  match-trees.c     |  4 +---
>  merge-recursive.c |  6 ++----
>  notes.c           |  3 +--
>  object-name.c     |  3 +--
>  tree-walk.c       | 11 +++++++++++
>  tree-walk.h       |  3 +++
>  6 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index 2afa4968109..25bfb46fb02 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -288,12 +288,10 @@ void shift_tree(struct repository *r,
>
>         if (add_score < del_score) {
>                 /* We need to pick a subtree of two */
> -               unsigned short mode;
> -
>                 if (!*del_prefix)
>                         return;
>
> -               if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &m=
ode))
> +               if (get_tree_entry_path(r, hash2, del_prefix, shifted))
>                         die("cannot find path %s in tree %s",
>                             del_prefix, oid_to_hex(hash2));
>                 return;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index bbbb68e15bc..83d2b8b8440 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1884,11 +1884,9 @@ static int tree_has_path(struct repository *r, str=
uct tree *tree,
>                          const char *path)
>  {
>         struct object_id hashy;
> -       unsigned short mode_o;
> -
> -       return !get_tree_entry_mode(r,
> +       return !get_tree_entry_path(r,
>                                     &tree->object.oid, path,
> -                                   &hashy, &mode_o);
> +                                   &hashy);
>  }
>
>  /*
> diff --git a/notes.c b/notes.c
> index ef138606146..aa46cb2b09e 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -994,7 +994,6 @@ void init_notes(struct notes_tree *t, const char *not=
es_ref,
>                 combine_notes_fn combine_notes, int flags)
>  {
>         struct object_id oid, object_oid;
> -       unsigned short mode;
>         struct leaf_node root_tree;
>
>         if (!t)
> @@ -1021,7 +1020,7 @@ void init_notes(struct notes_tree *t, const char *n=
otes_ref,
>                 return;
>         if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oi=
d))
>                 die("Cannot use notes ref %s", notes_ref);
> -       if (get_tree_entry_mode(the_repository, &object_oid, "", &oid, &m=
ode))
> +       if (get_tree_entry_path(the_repository, &object_oid, "", &oid))
>                 die("Failed to read notes tree referenced by %s (%s)",
>                     notes_ref, oid_to_hex(&object_oid));
>
> diff --git a/object-name.c b/object-name.c
> index 7e3b2d6d739..9ff5f83c1ff 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1693,7 +1693,6 @@ static void diagnose_invalid_oid_path(struct reposi=
tory *r,
>                                       int object_name_len)
>  {
>         struct object_id oid;
> -       unsigned short mode;
>
>         if (!prefix)
>                 prefix =3D "";
> @@ -1704,7 +1703,7 @@ static void diagnose_invalid_oid_path(struct reposi=
tory *r,
>         if (is_missing_file_error(errno)) {
>                 char *fullname =3D xstrfmt("%s%s", prefix, filename);
>
> -               if (!get_tree_entry_mode(r, tree_oid, fullname, &oid, &mo=
de)) {
> +               if (!get_tree_entry_path(r, tree_oid, fullname, &oid)) {
>                         die(_("path '%s' exists, but not '%s'\n"
>                             "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'=
?"),
>                             fullname,
> diff --git a/tree-walk.c b/tree-walk.c
> index a90dbf87af4..fa846535dfb 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -632,6 +632,17 @@ int get_tree_entry_all(struct repository *r,
>         return retval;
>  }
>
> +int get_tree_entry_path(struct repository *r,
> +                       const struct object_id *tree_oid,
> +                       const char *name,
> +                       struct object_id *oid)
> +{
> +       unsigned short mode;
> +       enum object_type object_type;
> +       return get_tree_entry_all(r, tree_oid, name, oid,
> +                                 &mode, &object_type);
> +}
> +
>  int get_tree_entry_mode(struct repository *r,
>                         const struct object_id *tree_oid,
>                         const char *name,
> diff --git a/tree-walk.h b/tree-walk.h
> index 55ef88ef2e5..efcd7ccd10e 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -193,10 +193,13 @@ struct traverse_info {
>   * "struct name_entry" you'd like. You always need a pointer to an
>   * appropriate variable to fill in (NULL won't do!):
>   *
> + * get_tree_entry_path(): <no extra argument, just get the common 'path'=
>
>   * get_tree_entry_mode(): unsigned int mode
>   * get_tree_entry_type(): enum object_type
>   * get_tree_entry_all(): unsigned int mode, enum object_type
>   */
> +int get_tree_entry_path(struct repository *, const struct object_id *, c=
onst char *,
> +                       struct object_id *);
>  int get_tree_entry_mode(struct repository *, const struct object_id *, c=
onst char *,
>                         struct object_id *,
>                         unsigned short *);
> --
> 2.31.0.rc2.211.g1d0b8788b3
>
