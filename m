Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A85B1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbdJQRra (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:47:30 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:52112 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbdJQRr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:47:29 -0400
Received: by mail-qk0-f173.google.com with SMTP id 17so3065691qkq.8
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=50wY986hxHAY7yfh60C8JWSy5UVQpbkQGzSwK1g/9XQ=;
        b=TaWEJBDYH3uxwgzMaOw4BjxWrLYTmsdzTtwejn6GSPp8ANgmq5WtK23HPG7Nqsl1S9
         IZ0WxVqT8hPaApCJ0b7lC3Ku0GUf5FxXc+HkuHtZHY3qsCxdpUl6SnRRAJTwslExF3aA
         YlYwNTgTF0lISx5rTIyqkaTqnO6MBTFBji7pJxSNCZsON8+G6N8zZmTF0eQVoWDBW9g8
         jBP3jh5433bmg/tb8uxtyIO3TH0syi3Os26ou2Bak0xEyao9vGrSjjtkAuTvgsX0gp9d
         uQD0htsHyx5NbcDI7QAUNTtggfNvppQaqot1MVn9SJBnvD+o/keWE03MsTaK/1xjFZsw
         uWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=50wY986hxHAY7yfh60C8JWSy5UVQpbkQGzSwK1g/9XQ=;
        b=K/Z0800cvKdyy298PSGFfu1LSWzQjgE6/c/dUPO1lMv6JpUC3EzTDa7LIB1OlH+1bd
         nldFwnxymZVedYmALnagbGygBgnq+A77+NE1JsvHh4GiEJfSfb6WVaY/tYG4YoaRx9R9
         yLuYKPXpZWNJIEJoCI8U6RriEyhVXoYjDJC6lkV3R7k2X3vUQL5PuFKIT7oPR+1u2n4M
         w46I9W0rA0vGx3pOOZM/CEdINSrnwi82Aqasxr7fj5kC2lUdXn7xu80+sB4GyExNjN6U
         9bAEx+QvhKyTU216sw3hPEQ9tONWywJmRVZmZJC+fU9yvwUZw4VktFtnTFvIo6Oqow0U
         3pRA==
X-Gm-Message-State: AMCzsaXQMm9I3xgNIpIdgWUbdfqz8uRl/DWu+Tb4yjC70MEwsTW6ZDTm
        uLALpn0zS5S7/ak/mV0Vcauj7mcvOguW3+5QHPYh+w==
X-Google-Smtp-Source: ABhQp+TN+l5NK73+KEwrfhGR7VzOdwe0cS5afK9nyL/Z8fincM0tRA22hk9VSurQ0c+zbmNgZPOnfcZgVrqUiUxSUPo=
X-Received: by 10.55.18.165 with SMTP id 37mr19003710qks.352.1508262448639;
 Tue, 17 Oct 2017 10:47:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 17 Oct 2017 10:47:28 -0700 (PDT)
In-Reply-To: <20171016135827.GC12756@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net> <20171016135827.GC12756@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Oct 2017 10:47:28 -0700
Message-ID: <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] implement fetching of moved submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 6:58 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> We store the changed submodules paths to calculate which submodule needs
> fetching. This does not work for moved submodules since their paths do
> not stay the same in case of a moved submodules. In case of new
> submodules we do not have a path in the current checkout, since they
> just appeared in this fetch.
>
> It is more general to collect the submodule names for changes instead of
> their paths to include the above cases. If we do not have a
> configuration for a gitlink we rely on constructing a default name from
> the path if a git repository can be found at its path. We skip
> non-configured gitlinks whose default name collides with a configured
> one.

Thanks for working on this!

As detailed below, I wonder if it is easier (in maintenance, explaining
correctness, reviewing) if we'd rather keep two lists around. One for
based on names, and if we cannot lookup a name for a submodule, we
rather use the second path based list as a fallback. That would avoid
potential namespace collisions between names and paths, as well as
not having the confusion of mapping back and forth.

Most functions would then need to operate on path, as the name->path
mapping can be looked up for the first list, but the path->name mapping
cannot be looked up for the second list.

Cheers,
Stefan

> With the change described above we implement 'on-demand' fetching of
> changes in moved submodules.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

> ---
>  submodule-config.h          |   3 +
>  submodule.c                 | 138 ++++++++++++++++++++++++++++++++------------
>  t/t5526-fetch-submodules.sh |  35 +++++++++++
>  3 files changed, 138 insertions(+), 38 deletions(-)
>
> diff --git a/submodule-config.h b/submodule-config.h
> index e3845831f6..a5503a5d17 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -22,6 +22,9 @@ struct submodule {
>         int recommend_shallow;
>  };
>
> +#define SUBMODULE_INIT { NULL, NULL, NULL, RECURSE_SUBMODULES_NONE, \
> +       NULL, NULL, SUBMODULE_UPDATE_STRATEGY_INIT, {0}, -1 };
> +
>  struct submodule_cache;
>  struct repository;
>
> diff --git a/submodule.c b/submodule.c
> index 63e7094e16..71d1773e2e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -21,7 +21,7 @@
>  #include "parse-options.h"
>
>  static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> -static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
> +static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
>  static int initialized_fetch_ref_tips;
>  static struct oid_array ref_tips_before_fetch;
>  static struct oid_array ref_tips_after_fetch;
> @@ -674,11 +674,11 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
>  }
>
>  static struct oid_array *submodule_commits(struct string_list *submodules,
> -                                          const char *path)
> +                                          const char *name)
>  {
>         struct string_list_item *item;
>
> -       item = string_list_insert(submodules, path);
> +       item = string_list_insert(submodules, name);
>         if (item->util)
>                 return (struct oid_array *) item->util;
>
> @@ -687,39 +687,67 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
>         return (struct oid_array *) item->util;
>  }
>
> +struct collect_changed_submodules_cb_data {
> +       struct string_list *changed;
> +       const struct object_id *commit_oid;
> +};
> +
> +/*
> + * this would normally be two functions: default_name_from_path() and

Please start the comment capitalised. (minor nit)

> + * path_from_default_name(). Since the default name is the same as
> + * the submodule path we can get away with just one function which only
> + * checks whether there is a submodule in the working directory at that
> + * location.

This is an interesting comment, as it hints that we ought to keep it that way.
Earlier I was wondering if we want to make the name distinctively different
than its path, as that will confuse users *less* IMHO. (I just remember
someone asking on the mailing list why their "rename" did not work, as
they just renamed everything in the .gitmodules that looked like the path)

As the path/name is confusing, I'd wish we'd be super concise, such that
errors are harder to sneak into. For example, the arguments name should
be "path" as that is the only thing we can look up using is_sub_pop_gently,
if a "name" is given, than it just works because the chosen default name
was its path.

> +static const char *default_name_or_path(const char *path_or_name)
> +{
> +       int error_code;
> +
> +       if (!is_submodule_populated_gently(path_or_name, &error_code))
> +               return NULL;
> +
> +       return path_or_name;
> +}
> +


> +               if (submodule)
> +                       name = submodule->name;
> +               else {
> +                       name = default_name_or_path(p->two->path);

Here we use the path, as expected. So ideally we'd use
"default_name_for_path".


> +                       /* make sure name does not collide with existing one */
> +                       submodule = submodule_from_name(commit_oid, name);
> +                       if (submodule) {
> +                               warning("Submodule in commit %s at path: "
> +                                       "'%s' collides with a submodule named "
> +                                       "the same. Skipping it.",
> +                                       oid_to_hex(commit_oid), name);
> +                               name = NULL;
> +                       }

This is the ugly part of using one string list and storing names or
path in it. I wonder if we could omit this warning if we had 2 string lists?
One for names (which will then be used for renamed and new submodules)
and the "fall back" path based list. In such a world we would not need
to map back and forth between names and path.

> +               submodule = submodule_from_name(&null_oid, name->string);
> +               if (submodule)
> +                       path = submodule->path;
> +               else
> +                       path = default_name_or_path(name->string);
> +
> +               if (!path)
> +                       continue;


> +               submodule = submodule_from_name(&null_oid, name->string);
> +               if (submodule)
> +                       path = submodule->path;
> +               else
> +                       path = default_name_or_path(name->string);
> +
> +               if (!path)
> +                       continue;


>                 submodule = submodule_from_path(&null_oid, ce->name);
> +               if (!submodule) {
> +                       const char *name = default_name_or_path(ce->name);
> +                       if (name) {
> +                               default_submodule.path = default_submodule.name = name;
> +                               submodule = &default_submodule;
> +                       }
> +               }
>

>
> +test_expect_success "fetch new commits when submodule got renamed" '
> +       git clone . downstream_rename &&
> +       (
> +               cd downstream_rename &&
> +               git submodule update --init &&
> +# NEEDSWORK: we omitted --recursive for the submodule update here since
> +# that does not work. See test 7001 for mv "moving nested submodules"
> +# for details. Once that is fixed we should add the --recursive option
> +# here.
> +               git checkout -b rename &&
> +               git mv submodule submodule_renamed &&
> +               (
> +                       cd submodule_renamed &&
> +                       git checkout -b rename_sub &&
> +                       echo a >a &&
> +                       git add a &&
> +                       git commit -ma &&
> +                       git push origin rename_sub &&
> +                       git rev-parse HEAD >../../expect
> +               ) &&
> +               git add submodule_renamed &&
> +               git commit -m "update renamed submodule" &&
> +               git push origin rename
> +       ) &&
> +       (
> +               cd downstream &&
> +               git fetch --recurse-submodules=on-demand &&
> +               (
> +                       cd submodule &&
> +                       git rev-parse origin/rename_sub >../../actual
> +               )
> +       ) &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.14.1.145.gb3622a4
>
