Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378D620323
	for <e@80x24.org>; Thu, 16 Mar 2017 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdCPXpo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 19:45:44 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36359 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbdCPXpn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 19:45:43 -0400
Received: by mail-pf0-f176.google.com with SMTP id o126so31311778pfb.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2fd7mmceT5YgHTHzKP7jAjR42mwJx36/uCWn6mlKK2g=;
        b=RsC8B5RwWcWCSYaGl80IHAdfRLB8gjuANPHN6alxhMfr60pEV5wiEovcWHG8lHjcYO
         59IJGEBaKz72+S2i+mf4YSErQ+o26ndLvyiUk25m05eg6XlHDUH3vvUpFbmlIYXgcmZX
         hTxzx7r60BGO2I/My9FkfA0VFG8IEC1M7lYBQKqfHCS6grfgN/iPfDLNSjcNMIJlcEms
         sbqoGgdYjKtjTz8BzErhyiBQD5UZl4tALY1YYDN2O8+S3YsKhKAtoVBkvG+xJMQQXrE/
         RFk782QGlp6pUeH4sBm+9M3V0HShWY6h+Px3bMViUYFO8kx0gOHRsEj9fFR5DJctpfEG
         falA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2fd7mmceT5YgHTHzKP7jAjR42mwJx36/uCWn6mlKK2g=;
        b=CCnsFt342VLzqk1uWjUkpENLC4thTKgKa2ebwSMqJfYEK8Xqru3nri2GCKgEZrjDv+
         It/ZI5yY7ZztI2csyWN/BQqfFcqQyDRYDaNPo5LeXrN7oBZjCuQAn6e1K3J8Of86wdJS
         j2YYnLzhKe12Gl0aqebtpf/wDdpTzeiSK/m/DvIReL3jKgn+O/Lgb4pqe1vcMyhL/PsL
         0jlninxg5yGAcw557EV64y/wQjIsI8yMJZ+E4YXwhAP2AQzl7k+/CFzFGAVYdVGOouTh
         pidZ9a3MSHPCgaoWeYdzFmgF0owmzVtDdd35nLylPvoHMC4FnBouqAiQQCcSNd0V/3Ow
         xzFQ==
X-Gm-Message-State: AFeK/H1wHI9rdQkItD70uwneTZhaSYwjGqMlfJTYTn5ebbFnZG8KUAKqUZDJcBnumVPe22KFX6HBH88WoPuG18zY
X-Received: by 10.98.112.134 with SMTP id l128mr13505378pfc.81.1489707941893;
 Thu, 16 Mar 2017 16:45:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 16 Mar 2017 16:45:41 -0700 (PDT)
In-Reply-To: <20170316222952.53801-7-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Mar 2017 16:45:41 -0700
Message-ID: <CAGZ79kbMB3e8AXsK5EYjDBe=7+AccF56+kFDY5PQ9i9=R+2G0w@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] submodule: decouple url and submodule interest
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> Currently the submodule.<name>.url config option is used to determine if
> a given submodule is of interest to the user.  This ends up being
> cumbersome in a world where we want to have different submodules checked
> out in different worktrees or a more generalized mechanism to select
> which submodules are of interest.
>
> In a future with worktree support for submodules, there will be multiple
> working trees, each of which may only need a subset of the submodules
> checked out.  The URL (which is where the submodule repository can be
> obtained) should not differ between different working trees.
>
> It may also be convenient for users to more easily specify groups of
> submodules they are interested in as apposed to running "git submodule

Did you mean opposed?

> init <path>" on each submodule they want checked out in their working
> tree.
>
> To this end two config options are introduced, submodule.active and
> submodule.<name>.active.  The submodule.active config holds a pathspec
> that specifies which submodules should exist in the working tree.  The
> submodule.<name>.active config is a boolean flag used to indicate if
> that particular submodule should exist in the working tree.
>
> Its important to note that submodule.active functions differently than
> the other configuration options since it takes a pathspec.  This allows
> users to adopt at least two new workflows:
>
>   1. Submodules can be grouped with a leading directory, such that a
>      pathspec e.g. 'lib/' would cover all library-ish modules to allow
>      those who are interested in library-ish modules to set
>      "submodule.active = lib/" just once to say any and all modules in
>      'lib/' are interesting.
>
>   2. Once the pathspec-attribute feature is invented, users can label
>      submodules with attributes to group them, so that a broad pathspec
>      with attribute requirements, e.g. ':(attr:lib)', can be used to say
>      any and all modules with the 'lib' attribute are interesting.
>      Since the .gitattributes file, just like the .gitmodules file, is
>      tracked by the superproject, when a submodule moves in the
>      superproject tree, the project can adjust which path gets the
>      attribute in .gitattributes, just like it can adjust which path has
>      the submodule in .gitmodules.
>
> Neither of these two additional configuration options solve the problem
> of wanting different submodules checked out in different worktrees
> because multiple worktrees share .git/config.  Only once per-worktree
> configurations become a reality can this be solved, but this is a
> necessary preparatory step for that future.
>
> Given these multiple ways to check if a submodule is of interest, the
> more fine-grained submodule.<name>.active option has the highest order
> of precedence followed by the pathspec check against submodule.active.
> To ensure backwards compatibility, if neither of these options are set,
> git falls back to checking the submodule.<name>.url option to determine
> if a submodule is interesting.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt       | 15 ++++++++++--
>  submodule.c                    | 50 ++++++++++++++++++++++++++++++++------
>  t/t7413-submodule-is-active.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5e5c2ae5f..d2d79b9d4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2920,8 +2920,9 @@ submodule.<name>.url::
>         The URL for a submodule. This variable is copied from the .gitmodules
>         file to the git config via 'git submodule init'. The user can change
>         the configured URL before obtaining the submodule via 'git submodule
> -       update'. After obtaining the submodule, the presence of this variable
> -       is used as a sign whether the submodule is of interest to git commands.
> +       update'. If neither submodule.<name>.active or submodule.active are
> +       set, the presence of this variable is used as a fallback to indicate
> +       whether the submodule is of interest to git commands.
>         See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>
>  submodule.<name>.update::
> @@ -2959,6 +2960,16 @@ submodule.<name>.ignore::
>         "--ignore-submodules" option. The 'git submodule' commands are not
>         affected by this setting.
>
> +submodule.<name>.active::
> +       Boolean value indicating if the submodule is of interest to git
> +       commands.  This config option takes precedence over the
> +       submodule.active config option.
> +
> +submodule.active::
> +       A repeated field which contains a pathspec used to match against a
> +       submodule's path to determine if the submodule is of interest to git
> +       commands.
> +
>  submodule.fetchJobs::
>         Specifies how many submodules are fetched/cloned at the same time.
>         A positive integer allows up to that number of submodules fetched
> diff --git a/submodule.c b/submodule.c
> index 0a2831d84..ad2779ee7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -212,25 +212,59 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
>  }
>
>  /*
> + * NEEDSWORK: With the addition of different configuration options to determine
> + * if a submodule is of interests, the validity of this function's name comes
> + * into question.  Once the dust has settled and more concrete terminology is
> + * decided upon, come up with a more proper name for this function.  One
> + * potential candidate could be 'is_submodule_active()'.
> + *
>   * Determine if a submodule has been initialized at a given 'path'
>   */
>  int is_submodule_initialized(const char *path)
>  {
>         int ret = 0;
> -       const struct submodule *module = NULL;
> +       char *key = NULL;
> +       char *value = NULL;
> +       const struct string_list *sl;
> +       const struct submodule *module = submodule_from_path(null_sha1, path);
>
> -       module = submodule_from_path(null_sha1, path);
> +       /* early return if there isn't a path->module mapping */
> +       if (!module)
> +               return 0;
>
> -       if (module) {
> -               char *key = xstrfmt("submodule.%s.url", module->name);
> -               char *value = NULL;
> +       /* submodule.<name>.active is set */
> +       key = xstrfmt("submodule.%s.active", module->name);
> +       if (!git_config_get_bool(key, &ret)) {
> +               free(key);
> +               return ret;
> +       }
> +       free(key);
>
> -               ret = !git_config_get_string(key, &value);
> +       /* submodule.active is set */
> +       sl = git_config_get_value_multi("submodule.active");
> +       if (sl) {
> +               struct pathspec ps;
> +               struct argv_array args = ARGV_ARRAY_INIT;
> +               const struct string_list_item *item;
>
> -               free(value);
> -               free(key);
> +               for_each_string_list_item(item, sl) {
> +                       argv_array_push(&args, item->string);
> +               }
> +
> +               parse_pathspec(&ps, 0, 0, NULL, args.argv);
> +               ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
> +
> +               argv_array_clear(&args);
> +               clear_pathspec(&ps);
> +               return ret;
>         }
>
> +       /* fallback to checking if the URL is set */
> +       key = xstrfmt("submodule.%s.url", module->name);
> +       ret = !git_config_get_string(key, &value);
> +
> +       free(value);
> +       free(key);
>         return ret;
>  }
>
> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> index f18e0c925..ea1644b58 100755
> --- a/t/t7413-submodule-is-active.sh
> +++ b/t/t7413-submodule-is-active.sh
> @@ -28,4 +28,59 @@ test_expect_success 'is-active works with urls' '
>         git -C super submodule--helper is-active sub1
>  '
>
> +test_expect_success 'is-active works with submodule.<name>.active config' '
> +       test_when_finished "git -C super config --unset submodule.sub1.active" &&

Sorry for late notice: This can be solved more elegantly with
test_config[_global].
If this is the only nit, we can fix it later, though.

> +       test_when_finished "git -C super config submodule.sub1.URL ../sub" &&

All tests look like they are structured very similarly; we also want
to test all combinations,
so maybe it is easier to make a function

test_active_case()
{
    on_submodule=$1
    expectation=$2
    with_URL=$3
    with_active_flag=$4
    with_active_pathspec=$5
    test_expect_success 'is_active for $1 $2 $3 $4 $5' '
      # do the actual test
    '
}

# here put all combinations for a submodule + the non-submodule case

I am not sure though, it would be a more disciplined approach, but not
necessarily
be covering the corner cases just as nice, i.e. having multiple
pathspecs, including 'exclude's.

Just food for thought.

Thanks,
Stefan
