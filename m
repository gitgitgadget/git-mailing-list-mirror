Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740EFC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiA0HCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiA0HCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 02:02:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD6C061714
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:02:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id n10so2316172edv.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8okE5Sqr0llEpfrYwz8FIZP4ZDaz8Tk7KRU7lJNMsM=;
        b=YbKyIWydtZStbAirkAl8m9GZUlfMhlemX5TADrmx1EOnBJeIx95gtytQvMB/qYwLOB
         Z/r3gzTR4TDQRPxzfk2Xb35zAaBUl54tx3Pb1loim6bZWnl1PaQPvbWX6LJYAikrW6yB
         2Zq0NGTMn2iK8Ddg3FJyLdCw8v3OcOr4Tbk31xTLk4Xusayyo+e5ute2iG+qFAl+iKbL
         YnrCfj02oKIy6ETDk18PPy8IO5Msi4HVIqkJZg4Ixh0/sNv8fsKcQi9LpHcRuXg3SNso
         2p3u1XjCaBCsWEoRXXTznAednTwmhZ76xDRYrwFiSaj9sdHSsv2FYc9Nu9XqFeMVQbmR
         zfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8okE5Sqr0llEpfrYwz8FIZP4ZDaz8Tk7KRU7lJNMsM=;
        b=eJJPZjUIym6/rQjgXIpFVMIBT17Qp19PrKzhpY4KRX8E8IxSlOSDDmrGm5GTTASDex
         2WFdu2meUL4jlufNEZSw6r8rZXcyswvKfHKRJD2cpRVVfYbLlYtJDlsca/loVhSa/ccI
         97pzMSJ6f+VVdD0SBkLhotY/njmTvdLPBJt8AV27uRxJMtribk4dt0iGWWKXzh/F0opY
         faWbvaIQaOvW4uBtALGCALDcnZIEsnSw4zlGrRW/f5BICkfsOKu/mthEqDQPu2bx4JHq
         tqp9ya6N8AM3MbjDVvRzsdevpTd+0NbDVVIH4LQVVN4d2cHBdhblPJRSIlchnoXzHbqm
         8QqQ==
X-Gm-Message-State: AOAM5304DjF8JKOa/7VVDGuJG0BoFr43V9PkF2pnTwxb4MOJvWqXi2fK
        c7Ei4zXuSr+MEKlgDvUHHjk7YzPPjq/lBzw1Zl0=
X-Google-Smtp-Source: ABdhPJxyN+WK8r4hdgrv7jyCK3Lj5Bp9hJUO+mvZzQ/4QNvBn8PYqOOnHdPaNrXADQ5s7yLfWvMYZAGgb2+oVAsdTS4=
X-Received: by 2002:aa7:da44:: with SMTP id w4mr2397631eds.146.1643266929938;
 Wed, 26 Jan 2022 23:02:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <d262a76b448a495f00f460e9ed9439a74946de49.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <d262a76b448a495f00f460e9ed9439a74946de49.1643136134.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 23:01:58 -0800
Message-ID: <CABPp-BGjDW8-epG8NXr7tF2nibEty=W+Z058-aWB7wQAn86CNA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] worktree: create init_worktree_config()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Upgrading a repository to use extensions.worktreeConfig is non-trivial.
> There are several steps involved, including moving some config settings
> from the common config file to the main worktree's config.worktree file.
> The previous change updated the documentation with all of these details.
>
> Commands such as 'git sparse-checkout set' upgrade the repository to use
> extensions.worktreeConfig without following these steps, causing some
> user pain in some special cases.
>
> Create a helper method, init_worktree_config(), that will be used in a
> later change to fix this behavior within 'git sparse-checkout set'. The
> method is carefully documented in worktree.h.

I was curious why you were only fixing `set` and not `init`, but I
looked ahead and it appears you are fixing both, since both use
set_config().  And I can see leaving out the mention of `init` since
it's deprecated.  Anyway, it's all good here, I'm basically just
thinking out loud...

> Note that we do _not_ upgrade the repository format version to 1 during
> this process. The worktree config extension must be considered by Git
> and third-party tools even if core.repositoryFormatVersion is 0 for
> historical reasons documented in 11664196ac ("Revert
> "check_repository_format_gently(): refuse extensions for old
> repositories"", 2020-07-15). This is a special case for this extension,
> and newer extensions (such as extensions.objectFormat) still need to
> upgrade the repository format version.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  worktree.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  worktree.h | 19 +++++++++++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 6f598dcfcdf..dc4ead4c8fb 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -5,6 +5,7 @@
>  #include "worktree.h"
>  #include "dir.h"
>  #include "wt-status.h"
> +#include "config.h"
>
>  void free_worktrees(struct worktree **worktrees)
>  {
> @@ -826,3 +827,72 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
>         *wtpath = path;
>         return 0;
>  }
> +
> +static int move_config_setting(const char *key, const char *value,
> +                              const char *from_file, const char *to_file)
> +{
> +       if (git_config_set_in_file_gently(to_file, key, value))
> +               return error(_("unable to set %s in '%s'"), key, to_file);
> +       if (git_config_set_in_file_gently(from_file, key, NULL))
> +               return error(_("unable to unset %s in '%s'"), key, from_file);
> +       return 0;
> +}
> +
> +int init_worktree_config(struct repository *r)
> +{
> +       int res = 0;
> +       int bare = 0;
> +       struct config_set cs = { { 0 } };
> +       const char *core_worktree;
> +       char *common_config_file = xstrfmt("%s/config", r->commondir);
> +       char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> +
> +       /*
> +        * If the extension is already enabled, then we can skip the
> +        * upgrade process.
> +        */
> +       if (repository_format_worktree_config)
> +               return 0;
> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
> +               return error(_("failed to set extensions.worktreeConfig setting"));
> +
> +       git_configset_init(&cs);
> +       git_configset_add_file(&cs, common_config_file);
> +
> +       /*
> +        * If core.bare is true in the common config file, then we need to
> +        * move it to the base worktree's config file or it will break all
> +        * worktrees. If it is false, then leave it in place because it
> +        * _could_ be negating a global core.bare=true.
> +        */
> +       if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
> +               if ((res = move_config_setting("core.bare", "true",
> +                                              common_config_file,
> +                                              main_worktree_file)))
> +                       goto cleanup;
> +       }
> +       /*
> +        * If core.worktree is set, then the base worktree is located
> +        * somewhere different than the parent of the common Git dir.
> +        * Relocate that value to avoid breaking all worktrees with this
> +        * upgrade to worktree config.
> +        */
> +       if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
> +               if ((res = move_config_setting("core.worktree", core_worktree,
> +                                              common_config_file,
> +                                              main_worktree_file)))
> +                       goto cleanup;
> +       }
> +
> +       /*
> +        * Ensure that we use worktree config for the remaining lifetime
> +        * of the current process.
> +        */
> +       repository_format_worktree_config = 1;
> +
> +cleanup:
> +       git_configset_clear(&cs);
> +       free(common_config_file);
> +       free(main_worktree_file);
> +       return res;
> +}
> diff --git a/worktree.h b/worktree.h
> index 9e06fcbdf3d..5ea5fcc3647 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -183,4 +183,23 @@ void strbuf_worktree_ref(const struct worktree *wt,
>                          struct strbuf *sb,
>                          const char *refname);
>
> +/**
> + * Enable worktree config for the first time. This will make the following
> + * adjustments:
> + *
> + * 1. Add extensions.worktreeConfig=true in the common config file.
> + *
> + * 2. If the common config file has a core.worktree value or core.bare is
> + *    set to true, then those values are moved to the main worktree's
> + *    config.worktree file.

This is a bit ambiguous.  If core.worktree is set and core.bare is
false, are both moved or only one?  I'm afraid folks won't understand
that it's just one from this description.


> + *
> + * If extensions.worktreeConfig is already true, then this method
> + * terminates early without any of the above steps. The existing config
> + * arrangement is assumed to be intentional.
> + *
> + * Returns 0 on success. Reports an error message and returns non-zero
> + * if any of these steps fail.
> + */
> +int init_worktree_config(struct repository *r);
> +
>  #endif
> --

Other than the ambiguity in worktree.h, this patch looks solid.
