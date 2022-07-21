Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4BFC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 07:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiGUHtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGUHtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 03:49:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F292C12A
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:49:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l3so733018qkl.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6XEGGYXaU/NGOrc/EPpwqwlJmxfyDRT0DkXZ17yrr/o=;
        b=LbqP+0KJuo6m9VBE//nnhVcxtIgoPJ1hTK/ve9xtkZrNx+HNb84B3ePaNLNNYfOAfC
         /ZVW5jdpDpdMwLSHR89Z0nAsWaQq/zVhy6U2VLhPKHMNFU0yPMvXfiiWraI33i0WK5MS
         fzFMLp2e7atnQju4Q8Ut7DI19w8Rk1FDTZ2cyXhEHsxu5IYpeLxUmYtGIEOAa6zoaPsB
         g4OXQS7Bj4L9cu/eDGZWRE/UBXpwUZp12VjMJ6DEND0UzFCw5ypxMYsrpg0FheMHeE4w
         +9nWgMJN2x/0QuiwikVVrDLzXIbKyKBdLpGcVtjlm58ZR5Ww5qWJjG4zKPf7jm8qG6Xx
         sJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XEGGYXaU/NGOrc/EPpwqwlJmxfyDRT0DkXZ17yrr/o=;
        b=on584XkJVcRC/smT2n5H9fQVCr9EeurjsOswOW8kNK3hrA74LLBeaezU0z9ooFz58X
         6pO/NNhYtTppxKDd176tBzLGu0nr3eSFJPvBGB4F9FfTdtAlEIerwNTzNjgwghkAMQ9W
         +ggdU0uaOyl/lyoWU3EyWXfsHlDL0tEVv75n7Ko3SqGHsg6WA8EML+hcYhn1o6VvKu4U
         0nnRgwb8Y2r1NMpJeDhFFOZRWoBic6EBRidh8sttUQWrbQSP21PH6n1+0Ug3GZvjbOqf
         Nae2KI7mDBIq3JhFNm2UGjTmqbi3K7vQESgzL8j5FuruZZ1CXd+a4Dvn4Z+967aiNP8m
         L+gg==
X-Gm-Message-State: AJIora8kMQmfxkKjdFp8U3uYk/CQUe6hnbUpCdEX5YUsiRUvUOgWiSTY
        fK7WqeyC1KqE6QDkeTq6XS/Bg0Ki6JqOTYILh30=
X-Google-Smtp-Source: AGRyM1ucoKhvmzKbgcYqjfLNAfzBzMsOcBn511V0sOYLjWRXkXpCNhOpSp8UMu496X8gCzw7cdQnoCbYPIiyJUFC5oE=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr11840064qki.131.1658389742345; Thu, 21
 Jul 2022 00:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <patch-2.2-5d8baa9cbc4-20220721T063543Z-avarab@gmail.com>
In-Reply-To: <patch-2.2-5d8baa9cbc4-20220721T063543Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 00:48:51 -0700
Message-ID: <CABPp-BFiNXM_2kfOQ+BnC5bWVEVZTk2kiFNuPSPPsz+5owM9kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] string-list API users: manually use string_list_init_*()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 11:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Convert various code that didn't use string_list_init_*() to do so, in
> cases where the only thing being allocated was the string list we can
> change from CALLOC_ARRAY() to ALLOC_ARRAY(), the string_list_init_*()
> function will zero out the memory.
>
> This covers cases that weren't matched by tho coccinelle rule in the

s/tho/the/ ?

> preceding commit, which is conservative enough to care about the type
> of what we're modifying.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  notes-utils.c | 4 ++--
>  reflog-walk.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/notes-utils.c b/notes-utils.c
> index d7d18e30f5a..73559d24ec8 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -129,8 +129,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite=
(const char *cmd)
>         c->cmd =3D cmd;
>         c->enabled =3D 1;
>         c->combine =3D combine_notes_concatenate;
> -       CALLOC_ARRAY(c->refs, 1);
> -       c->refs->strdup_strings =3D 1;
> +       ALLOC_ARRAY(c->refs, 1);
> +       string_list_init_dup(c->refs);

But c->refs is a struct string_list *; why doesn't cocci recognize
this one and convert it?

>         c->refs_from_env =3D 0;
>         c->mode_from_env =3D 0;
>         if (rewrite_mode_env) {
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 7aa6595a51f..2b17408f9a4 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -120,7 +120,7 @@ struct reflog_walk_info {
>  void init_reflog_walk(struct reflog_walk_info **info)
>  {
>         CALLOC_ARRAY(*info, 1);
> -       (*info)->complete_reflogs.strdup_strings =3D 1;
> +       string_list_init_dup(&((*info)->complete_reflogs));

Makes sense.

>  }
>
>  void reflog_walk_info_release(struct reflog_walk_info *info)
> --
> 2.37.1.1095.g64a1e8362fd
>
