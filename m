Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4F81F404
	for <e@80x24.org>; Wed, 14 Feb 2018 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966310AbeBNAi0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 19:38:26 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44622 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966207AbeBNAiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 19:38:24 -0500
Received: by mail-oi0-f68.google.com with SMTP id b3so15291804oib.11
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 16:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MtFbXizrV9mfBCFyxK4pbBKOdJY/eyQucGm6W+4QHNI=;
        b=UNq7r4RWzmBT/VgUXneX+T1fculLTtTJ7JXqV2JyOl26KtVOym6T+qNNf/xpRIPQDU
         5baGwFIj+g5fq0Jhoo5eGuo+pPgryK8aNM3AuiUYjZkMyMzmmu5xe577ftIx3jXZqatK
         tjyD/+tHJP/MwdNEkIHd8c2EGOwSt/oDzzHJZlbmIQqt2dggE0Y7PW1qp8xPc4+agKVM
         bgYrmYjyPW2rXL0LXA5xvjKGRyg5dVfO5CR3UHW2LLQ+afaQwoKNfnF8Ht5ET5LzDTnr
         WxeSZtK/QxLocb/6hEfGnVHpNGFCAJbmjIRo4uvdixHD3L8CNu7mf/BB+7OiEOuiS+5j
         ORxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MtFbXizrV9mfBCFyxK4pbBKOdJY/eyQucGm6W+4QHNI=;
        b=N9FCubZ+oHWOcPY6zWhQXg/ajat8W+3ctj0PBsWzTYBJYEU8VWK3OukgMz+ikWqja3
         cjTt0vMkWgo0jqPswcm3r2JGoJJm7YXrCP+2o7UNtTSjfI5EcLtLEohNjVwDi3XgETVj
         7719l3DOtS6dLmjKtvNEagM0peeUVSDJdmcRkgSnh3AAXIiHTaBEe3S2VB8IPQCfNH7O
         fQvp7jKVbAoWe+ThfaAaHt0uukgX7TPpmSVoZ91ggefk3RnMO9BhqYC89HJcdo2jBsz/
         1PVg/tEnJSHacQxWMaYwEDaN8jJAql4Ytmz8dVleELDvyAldp1qLUNwjjLzWM6aQkdK4
         x4IA==
X-Gm-Message-State: APf1xPA4YdRj8oizTKNCKWr+Ra1qO5zq6yrn5Ac3t7ajBSxHnxIv0t0i
        FXc2xR08bW6J93J76Sm6aBvMj4v1mHMIF1TElIj5gg==
X-Google-Smtp-Source: AH8x225ovDTeMLNiZAa08PRy1pMVq/OuV0HMVcwfx2QbeifM8yRXRrq//1QRFdHJMCnH7WdYV2AaChYDXsfRH/I4gyE=
X-Received: by 10.202.76.207 with SMTP id z198mr2139512oia.183.1518568703919;
 Tue, 13 Feb 2018 16:38:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 16:37:53 -0800 (PST)
In-Reply-To: <20180213012241.187007-15-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213012241.187007-15-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 07:37:53 +0700
Message-ID: <CACsJy8DmXrO9bxv10DsDpSWxm2BiZwwfhso4=ZRQs_xhrpAgfg@mail.gmail.com>
Subject: Re: [PATCH 14/26] sha1_file: allow prepare_alt_odb to handle
 arbitrary repositories
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 8:22 AM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  object-store.h |  3 +--
>  sha1_file.c    | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/object-store.h b/object-store.h
> index d96a16edd1..add1d4e27c 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -61,7 +61,6 @@ struct packed_git {
>         char pack_name[FLEX_ARRAY]; /* more */
>  };
>
> -#define prepare_alt_odb(r) prepare_alt_odb_##r()
> -extern void prepare_alt_odb_the_repository(void);
> +void prepare_alt_odb(struct repository *r);
>
>  #endif /* OBJECT_STORE_H */
> diff --git a/sha1_file.c b/sha1_file.c
> index d18ce3aeba..f046d560f8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -677,21 +677,22 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
>         return r;
>  }
>
> -void prepare_alt_odb_the_repository(void)
> +void prepare_alt_odb(struct repository *r)
>  {
> -       const char *alt;
> -
> -       if (the_repository->objects.alt_odb_tail)
> +       if (r->objects.alt_odb_tail)
>                 return;
>
> -       alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> +       r->objects.alt_odb_tail = &r->objects.alt_odb_list;
> +
> +       if (!r->ignore_env) {
> +               const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);

If one day the majority of git moves to use 'struct repository', then
ALTERNATE_DB_ENVIRONMENT is always ignored because ignore_env is
always true. I think if you ignore_env, then you still need to get
this "alt" from  'struct raw_object_store' (or 'struct repository').

Since you get lots of getenv() in repo_setup_env(), I think this
getenv(ALTERNATE_DB_ENVIRONMENT) belongs there too. Then here, if
ignore_env is true, you read r->objects.alt or something instead of
doing getenv().

I really want to kill this getenv() in this code, which is basically
delayed initialization because we haven't done proper init on
the_repo. I realize that it cannot be done earlier, when
prepare_alt_odb() does not even have a  'struct repository *' to work
with. Would it be ok if I contributed a patch on top of your series to
basically do repo_init(&the_repo) for all builtin/external commands
(and fix all the bugs that come with it)? Then we would not need
ignore_env here anymore.

> +               if (!alt)
> +                       alt = "";
>
> -       the_repository->objects.alt_odb_tail =
> -                       &the_repository->objects.alt_odb_list;
> -       link_alt_odb_entries(the_repository, alt,
> -                            PATH_SEP, NULL, 0);
> +               link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
> +       }
>
> -       read_info_alternates(the_repository, get_object_directory(), 0);
> +       read_info_alternates(r, r->objects.objectdir, 0);
>  }
>
>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
> --
> 2.16.1.73.ga2c3e9663f.dirty
>



-- 
Duy
