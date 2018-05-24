Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1A01F42D
	for <e@80x24.org>; Thu, 24 May 2018 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965337AbeEXXHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 19:07:52 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34956 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965089AbeEXXHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 19:07:50 -0400
Received: by mail-yw0-f196.google.com with SMTP id m8-v6so1134846ywd.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YV2kvS+8Q3t6NKAPqntsPjJQIstF2QrnFAapoJQCY8g=;
        b=Py6Oy8sNPOZgmjJVLMOCAri7uqzafhYHltsk/jpk12yUlfCD4w8hQ6xgXfaJf6RvDS
         /iCyUi2QR2/Uhi1r5OpD2EJFMzdXcl9upx+QiBac806VKWeafvidyEnqNjp+Gv27UHxu
         7o3dSS0p0kGsvix8h3aaEGs42892yAA6UjZtHyQcGfWJdIN9ayHZX+7aLRS6Ek4Ym+5V
         JgfVHKqvvsnixHZatevi6IntQyJkWcGXu59cyIIr7gA7wbWsCFcQXraLuxRppe2e/NxM
         2pdp9oj221M8HBonDkt8AsHqQ6Lc3IiszRZb+WmEERKIL+PqmQg8DRYp6kFAxKvC2x68
         zypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YV2kvS+8Q3t6NKAPqntsPjJQIstF2QrnFAapoJQCY8g=;
        b=fT+hOrHIkzftEP5YLzh4X54nyI53+mcCCH90AUSd6lNeX0JZnCL7Vy7oqMgo8iu5ny
         kLWbzfORmJxVyAAnL+VSUYeF+pNCwI1Lpgi7opbqQ2LJWK9cqs8KwSWTb4dkDWIhc2P3
         6HiG+ijtisTSGr5hXZI3bOTNcj7KQfIQvmy5mksW8lbuJQbt6AR9mHBQYjKifv7IU0lw
         cjek13YUwhgfC8SPCcp00s4qxosdi/x6TBsEtPjBi+LbJvkOwdZjAislfQlSE154WGbg
         oSt9t5BeD20lqjWvLL9jIBCmucB6cRknouvPzPpeLijzpQv6PqaaXPc5CevC+gwL6VOK
         u4iA==
X-Gm-Message-State: ALKqPwe6ZX4qlWlJan3ZR4+ypseiQRhjhJmYVAwQhjP36fPMNiGC+p6m
        oKXsTg5OnHuL3M76JR+L1EzC22mJneSe1/hQBU0K+cluKsI=
X-Google-Smtp-Source: AB8JxZrKG7L/6nD5mmZ7Bt4B/0mdQ4aAyvgFOmGxVQOz8n2kD3+QweMTLdWduS/YWteIflFm4Jz1/p3PWNhjikFLjBU=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr5085822ywg.345.1527203269875;
 Thu, 24 May 2018 16:07:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 16:07:49 -0700 (PDT)
In-Reply-To: <20180524204729.19896-1-jonathantanmy@google.com>
References: <20180524204729.19896-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 16:07:49 -0700
Message-ID: <CAGZ79kbB-8dbO5QjpG-G+9uRpa1m-_oypfw=kRFu__Ws7FV0Xg@mail.gmail.com>
Subject: Re: [PATCH] submodule: do not pass null OID to setup_revisions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, May 24, 2018 at 1:47 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> If "git pull --recurse-submodules --rebase" is invoked when the current
> branch and its corresponding remote-tracking branch have no merge base,
> a "bad object" fatal error occurs. This issue was introduced with commit
> a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
> changes only)", 2017-06-23), which also introduced this feature.

Ok, what should happen instead?

> This is because cmd_pull() in builtin/pull.c thus invokes
> submodule_touches_in_range() with a null OID as the first parameter.
> Ensure that this case works, and document what happens in this case.

By documenting you mean adding a test, i.e. documenting it for the
developers, not the users.

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  submodule.c               |  6 ++++--
>  submodule.h               |  5 ++++-
>  t/t5572-pull-submodule.sh | 21 +++++++++++++++++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 74d35b2577..49def93dd9 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1169,8 +1169,10 @@ int submodule_touches_in_range(struct object_id *excl_oid,
>
>         argv_array_push(&args, "--"); /* args[0] program name */
>         argv_array_push(&args, oid_to_hex(incl_oid));
> -       argv_array_push(&args, "--not");
> -       argv_array_push(&args, oid_to_hex(excl_oid));
> +       if (!is_null_oid(excl_oid)) {
> +               argv_array_push(&args, "--not");
> +               argv_array_push(&args, oid_to_hex(excl_oid));
> +       }
>
>         collect_changed_submodules(&subs, &args);
>         ret = subs.nr;
> diff --git a/submodule.h b/submodule.h
> index e5526f6aaa..1fd7111f60 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -94,7 +94,10 @@ extern int merge_submodule(struct object_id *result, const char *path,
>                            const struct object_id *a,
>                            const struct object_id *b, int search);
>
> -/* Checks if there are submodule changes in a..b. */
> +/*
> + * Checks if there are submodule changes in a..b. If a is the null OID,
> + * checks b and all its ancestors instead.
> + */
>  extern int submodule_touches_in_range(struct object_id *a,
>                                       struct object_id *b);
>  extern int find_unpushed_submodules(struct oid_array *commits,
> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index 321bd37deb..f916729a12 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -132,4 +132,25 @@ test_expect_success 'pull rebase recursing fails with conflicts' '
>         test_i18ngrep "locally recorded submodule modifications" err
>  '
>
> +test_expect_success 'branch has no merge base with remote-tracking counterpart' '
> +       rm -rf parent child &&
> +
> +       test_create_repo a-submodule &&
> +       test_commit -C a-submodule foo &&
> +
> +       test_create_repo parent &&
> +       git -C parent submodule add "$(pwd)/a-submodule" &&
> +       git -C parent commit -m foo &&
> +
> +       git clone parent child &&
> +
> +       # Reset master so that it has no merge base with
> +       # refs/remotes/origin/master.
> +       OTHER=$(git -C child commit-tree -m bar \
> +               $(git -C child rev-parse HEAD^{tree})) &&
> +       git -C child reset --hard "$OTHER" &&

I inserted a test_pause here and inspect child:
* the submodule is the same as in parent, so this patch is
  just testing it works with submodules the same?
* No, the submodule is not cloned into the child
  at all. So we do not know what do do with the submodule.

However this patch is about making sure the superproject
works out well, without this patch we'd have
$ git -C child pull --recurse-submodules --rebase
fatal: bad object 0000000000000000000000000000000000000000
which is to be avoided.

Yes I think this is the best way to fix the issue, I thought for some time that
could first check if submodules are initialzed or active, but these
are checks are done afterwards, so this is ok.

Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
Stefan
