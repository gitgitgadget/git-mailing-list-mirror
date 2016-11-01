Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12D420229
	for <e@80x24.org>; Tue,  1 Nov 2016 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbcKAQjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 12:39:36 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36677 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbcKAQjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 12:39:33 -0400
Received: by mail-qk0-f174.google.com with SMTP id o68so206238304qkf.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R4asR92ElPkR3rbfhG4txOeXQIvL+I/Ow6nf8sMvkvg=;
        b=G6A3289ZMGFFy4GnRvKl0q8I+x/kxddiwzWVXZrz3I7mkfnIka2ra8bbGSwUfkFL0k
         kZBWd+6TjL8jrqnEfowSNorhu94Sn/zy+c4n30K8SKp04L71JnCriBTaj0rs1Th1gYcU
         yB/tvgcaSNlyPgrmbfIq0wFEXZgg/rj9rWAJuNVOMIMf9ZtEM8dtoFtD6Eb8VD3eMTTo
         brKdJYbpkhBqrg9b16bZ3sv4PhcXzxzqF8nDCorbF619tIkzs04Ae/bckWyqzSKXdAO8
         snO2ahwYqhHz7BnJK2ilv32+JOzIRpGEtv5z4pf8cBlA91proVJ60HOoTruntnMt2l5c
         5I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R4asR92ElPkR3rbfhG4txOeXQIvL+I/Ow6nf8sMvkvg=;
        b=R9o2lJfBiLAEmmwPNH/EheDhLZ4ce/wUgTBhwiP38dOzOhw/GQ0M/hqMcXVOeZZx/X
         YD6ZZV3PZEYj2Drooe1rGIy0X49DaTPt7aVV3ImTI/N1CZHvVpu6Sx77wQTrKLg8tZ5k
         cnWJmVEXxMPwVldleO+81Chh/8Z5EM8YJEXsqoAYoWR23xyE4gXt5ct7Aj+2oO7pMZvV
         CBJsdpWko1kt+yJmpf6yUM8dbT5jZrbkirOPj5loPTWA1eGqx1dizBoxoLQDCP/UwSit
         43DcWlQku5opIukIFgJfcv4D/nm0B5/fhHWUN4fSWj9piise+/9p9wdJ26FQmYHXBKHf
         dpxg==
X-Gm-Message-State: ABUngve6If4F4EzkrA/eaOOaTke9lWkAW1sTFB1eDyoyZ8i3ulbNSZQ+BffJfhIBgEJ4HUxYltP9QHvWWTXAHWh6
X-Received: by 10.55.73.213 with SMTP id w204mr9534475qka.53.1478018371794;
 Tue, 01 Nov 2016 09:39:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 09:39:31 -0700 (PDT)
In-Reply-To: <1477953496-103596-3-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-3-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 09:39:31 -0700
Message-ID: <CAGZ79kYtZXqN5gd2LDdZAik4WxMU66oKRZOtvuAQ-Nwv7SDH+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] submodules: load gitmodules file from commit sha1
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach submodules to load a '.gitmodules' file from a commit sha1.  This
> enables the population of the submodule_cache to be based on the state
> of the '.gitmodules' file from a particular commit.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h            |  2 ++
>  config.c           |  8 ++++----
>  submodule-config.c |  6 +++---
>  submodule-config.h |  3 +++
>  submodule.c        | 12 ++++++++++++
>  submodule.h        |  1 +
>  6 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 1be6526..559a461 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1690,6 +1690,8 @@ extern int git_default_config(const char *, const char *, void *);
>  extern int git_config_from_file(config_fn_t fn, const char *, void *);
>  extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
>                                         const char *name, const char *buf, size_t len, void *data);
> +extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
> +                                    const unsigned char *sha1, void *data);
>  extern void git_config_push_parameter(const char *text);
>  extern int git_config_from_parameters(config_fn_t fn, void *data);
>  extern void git_config(config_fn_t fn, void *);
> diff --git a/config.c b/config.c
> index 83fdecb..4d78e72 100644
> --- a/config.c
> +++ b/config.c
> @@ -1214,10 +1214,10 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
>         return do_config_from(&top, fn, data);
>  }
>
> -static int git_config_from_blob_sha1(config_fn_t fn,
> -                                    const char *name,
> -                                    const unsigned char *sha1,
> -                                    void *data)
> +int git_config_from_blob_sha1(config_fn_t fn,
> +                             const char *name,
> +                             const unsigned char *sha1,

While looking at this code, we may want to investigate if a conversion
to struct object_id (instead of const char * for sha1) is feasible.

> +                             void *data)
>  {
>         enum object_type type;
>         char *buf;
> diff --git a/submodule-config.c b/submodule-config.c
> index 098085b..8b9a2ef 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -379,9 +379,9 @@ static int parse_config(const char *var, const char *value, void *data)
>         return ret;
>  }
>
> -static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> -                                     unsigned char *gitmodules_sha1,
> -                                     struct strbuf *rev)
> +int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> +                              unsigned char *gitmodules_sha1,
> +                              struct strbuf *rev)
>  {
>         int ret = 0;
>
> diff --git a/submodule-config.h b/submodule-config.h
> index d05c542..78584ba 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -29,6 +29,9 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
>                 const char *name);
>  const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
>                 const char *path);
> +extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
> +                                     unsigned char *gitmodules_sha1,
> +                                     struct strbuf *rev);

no need for extern here as it is a function declaration, not a
variable declaration;
(as said on patch 1, I think consistency to the surrounding is important here)

>  void submodule_free(void);
>
>  #endif /* SUBMODULE_CONFIG_H */
> diff --git a/submodule.c b/submodule.c
> index ff4e7b2..19dfbd4 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -198,6 +198,18 @@ void gitmodules_config(void)
>         }
>  }
>
> +void gitmodules_config_sha1(const unsigned char *commit_sha1)
> +{
> +       struct strbuf rev = STRBUF_INIT;
> +       unsigned char sha1[20];
> +
> +       if (gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
> +               git_config_from_blob_sha1(submodule_config, rev.buf,
> +                                         sha1, NULL);
> +       }
> +       strbuf_release(&rev);
> +}
> +
>  /*
>   * Determine if a submodule has been initialized at a given 'path'
>   */
> diff --git a/submodule.h b/submodule.h
> index bd039ca..9a24ac8 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -37,6 +37,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>                 const char *path);
>  int submodule_config(const char *var, const char *value, void *cb);
>  void gitmodules_config(void);
> +extern void gitmodules_config_sha1(const unsigned char *commit_sha1);

same.

>  extern int is_submodule_initialized(const char *path);
>  extern int is_submodule_checked_out(const char *path);
>  int parse_submodule_update_strategy(const char *value,
> --
> 2.8.0.rc3.226.g39d4020
>
