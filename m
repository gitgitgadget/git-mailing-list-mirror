Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A629CE9
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079086; cv=none; b=LUIywm+zUImHV8sI7abGgaQQvOTqczXwf3Sox8QX9bISIokMy9wfct4JClLi/fTK4r7ov8vZKD8SLJXSeOuurXrv4leeNB/W/UKN5sXQg9cX6JRVR4R6Tm8J5ZtrIfWrTyilYRGTQaQ8b+NfNLDtSRegpjqht5ZeYipSRv5knBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079086; c=relaxed/simple;
	bh=fE5Licgc3OsVySATjQzWAccywlK+mqdPrwdH8VorQzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR/lTewftmT1+mvz5hpMkK5l7XVAajSBWjoaY6qXjHlhO1nnxewNo6K0Pq4lGYG3cyFRHz4lMx51XuE6Ft0lYmSvERYysIGdUtjS9fa+zP0siwNxOZVvq4sGZGycmR33Az9y+EzOW/tt22ogxzIWE2JAgFC8wRvRIGqM6kMpcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORtwaXAB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORtwaXAB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f2676bb21so11061885ad.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766079084; x=1766683884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=laLswlAEaRgFwAez7xi+/J1ldkDYLiNxSC4dPkJ+bis=;
        b=ORtwaXABQO9IiT+xXWer4U+FanYN+PiIhu+gAmrtwPk1Hf9aJFQRQVlrmCr1PTs2ET
         lfHlkqIEdyYlqA+B5XmZBoSjVLRn0EZJBU/NW4AztwSWvoIY3eYt6yPE3rhXj6+g6f7q
         J5C0pDAbQFl+z6wV+KFdTMUatZRWqrwnFxdotbVhTnUi2Dhl8FYhPZ928ppoRPzz8Lba
         ty3mc4dnzlACeAXktJGVets0jKMvjAr8uS3VxfXOiDBN03WlWobnCpsrxv12CJVadDUh
         MEQeJlfqu9zwmFzEmzvvF/UBqmBrcHpq9NPsk8a+yoE8tyN3p453Kk0scBfmQ3tkzc82
         vLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766079084; x=1766683884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laLswlAEaRgFwAez7xi+/J1ldkDYLiNxSC4dPkJ+bis=;
        b=B3kBvGm/PPv4eQts9FHtXZHbqdGDGQuYV6w1KlQ71KRsPvMsJNPhi3lpW58l4BBMsE
         pL1PiGYYLcHLpQziGCUJeGwKFyC5EEtPLzq01UO8J/7j8JjZ1M479G2qQawGT4ytcw5o
         0h9x8qE3Z9Q3RrTI6AEeORnJaCYFZ+m1qnGp+h0KJPlS477HQ0K8IJY192J34oehy8ne
         Tp5kwPZdRJMqWhcaVxjKoHwNzMFuQw0WcrZdKibQIjulF8KCLx86OmG7+OBlT7NdctfM
         eFbaaN7V55drC1PYz/1g9fD4JQ7vav+Li/I4WzXftDfwlQNeg/AjUEJza76dFVj5s0MK
         4i6w==
X-Gm-Message-State: AOJu0Yz+26TnLzJnOl2SQ0qmnBcdKKLZaCDk/H0DzlwWYh7VnTWbaCGW
	qK1EdQSR40bRsAa8zeJhPb05C9Un9rVqyXiuV+sgU2AW5SJ6cLBnc+dHoLsboDmcH6jvzVQ/5Vf
	ohciCTUXCoCap4TcR3qsg8xPuFuY8mrnj0DzYeuaQHg==
X-Gm-Gg: AY/fxX4OS7EeKJadsvyNosUA9CTkO/wsaPKWAQbCrNZodfZGEKOifhBreoAYYJGASda
	Gxn7+ZnfFidlIVAKExO0EvTnzi0CUQ/7TMUv34qFxiLGz9CMhX8OG4F0YUJdlr5HL4oip78Sx5X
	TwrmchRBallUUdACBn3iQvMCZALJUSz0CqoyLwU8KDkdfc2W/3SXSmbpiPJep4lrCosOEQBJX9M
	2BoewJ/U7E8pAIUmsmOy1XKE2ENTgD3kdW98Jgw2CnwiclkWcmEWTdXeBNyabypd8lJocQBl0M=
X-Google-Smtp-Source: AGHT+IFCYE1BNEfxzH8pHz8GNexC/dvnHw7GQ24fM7haE/yv0VU915cvnyHYhO4gVOxPcaT5NSe/ryBgICyohQ16Wv0=
X-Received: by 2002:a05:7022:4089:b0:11b:9386:8264 with SMTP id
 a92af1059eb24-121722ed029mr18142c88.41.1766079083687; Thu, 18 Dec 2025
 09:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUO7jQQAERTe5xYc@ubuntu>
In-Reply-To: <aUO7jQQAERTe5xYc@ubuntu>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 18 Dec 2025 18:31:25 +0100
X-Gm-Features: AQt7F2rKRp2ZoqX_8PrSoauvHBIMw33z5z5YnCltwsyfADs0COLJeni6pORKj9w
Message-ID: <CAD=f0L8hCyUK6OJXrz7=KNVTJ_cjkX3pt6N-ZiH+58PHR21=3g@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move "core.attributesFile" into repo-setting
To: git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 09:30, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
> When handling multiple repositories within the same process, relying on
> global state for accessing the "core.attributesFile" configuration can
> lead to incorrect values being used. It also makes it harder to isolate
> repositories and hinders the libification of git.
> The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> retrieve "core.attributesFile" via `git_attr_global_file()`
> which reads from global state `git_attributes_file`.
>
> Move the "core.attributesFile" configuration into the
> `struct repo_settings` instead of relying on the global state.
> A new function `repo_settings_get_attributesfile_path()` is added
> and used to retrieve this setting in a repository-scoped manner.
> The functions to retrieve "core.attributesFile" are replaced with
> the new accessor function `repo_settings_get_attributesfile_path()`
> This improves multi-repository behaviour and aligns with the goal of
> libifying of Git.
>
> Note that in `bootstrap_attr_stack()`, the `index_state` is used only
> if it exists, else we default to `the_repository`.
>
> Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
> The link to the GitHub CI is provided below
> https://github.com/cloobTech/git/actions/runs/20284228144

The link to Ayush's patches, which this patch is based on, is provided in
[1].
The 'git_attributes_file' member of `struct repository` is now
accessed via the `struct index_state`,
istate->repo, as most of the callers in the attributes subsystem
already use the `index_state`,
rather than through the `struct repository *repo` as done in [1] which
only knows its primary index.
This ensures that the index actually owns the attributes as pointed
out by Junio in the threads.

[1]. https://lore.kernel.org/git/20250309153321.254844-1-ayu.chandekar@gmail.com/

>
>  attr.c          | 20 +++++++++-----------
>  attr.h          |  3 ---
>  builtin/var.c   |  2 +-
>  environment.c   |  6 ------
>  environment.h   |  1 -
>  repo-settings.c | 10 ++++++++++
>  repo-settings.h |  8 ++++++++
>  7 files changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index 4999b7e09d..9e51f8e70b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
>         return system_wide;
>  }
>
> -const char *git_attr_global_file(void)
> -{
> -       if (!git_attributes_file)
> -               git_attributes_file = xdg_config_home("attributes");
> -
> -       return git_attributes_file;
> -}
> -
>  int git_attr_system_is_enabled(void)
>  {
>         return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
> @@ -912,6 +904,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  {
>         struct attr_stack *e;
>         unsigned flags = READ_ATTR_MACRO_OK;
> +       const char *attributes_file_path;
> +       struct repository *repo;
>
>         if (*stack)
>                 return;
> @@ -926,9 +920,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
>                 push_stack(stack, e, NULL, 0);
>         }
>
> -       /* home directory */
> -       if (git_attr_global_file()) {
> -               e = read_attr_from_file(git_attr_global_file(), flags);
> +       if (istate && istate->repo)
> +               repo = istate->repo;
> +       else
> +               repo = the_repository;
> +       attributes_file_path = repo_settings_get_attributesfile_path(repo);
> +       if (attributes_file_path) {
> +               e = read_attr_from_file(attributes_file_path, flags);
>                 push_stack(stack, e, NULL, 0);
>         }
>
> diff --git a/attr.h b/attr.h
> index a04a521092..956ce6ba62 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -232,9 +232,6 @@ void attr_start(void);
>  /* Return the system gitattributes file. */
>  const char *git_attr_system_file(void);
>
> -/* Return the global gitattributes file, if any. */
> -const char *git_attr_global_file(void);
> -
>  /* Return whether the system gitattributes file is enabled and should be used. */
>  int git_attr_system_is_enabled(void);
>
> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..fd577f2930 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -72,7 +72,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
>
>  static char *git_attr_val_global(int ident_flag UNUSED)
>  {
> -       char *file = xstrdup_or_null(git_attr_global_file());
> +       char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
>         if (file) {
>                 normalize_path_copy(file, file);
>                 return file;
> diff --git a/environment.c b/environment.c
> index a770b5921d..ed7d8f42d9 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,7 +53,6 @@ char *git_commit_encoding;
>  char *git_log_output_encoding;
>  char *apply_default_whitespace;
>  char *apply_default_ignorewhitespace;
> -char *git_attributes_file;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  int fsync_object_files = -1;
> @@ -363,11 +362,6 @@ static int git_default_core_config(const char *var, const char *value,
>                 return 0;
>         }
>
> -       if (!strcmp(var, "core.attributesfile")) {
> -               FREE_AND_NULL(git_attributes_file);
> -               return git_config_pathname(&git_attributes_file, var, value);
> -       }
> -
>         if (!strcmp(var, "core.bare")) {
>                 is_bare_repository_cfg = git_config_bool(var, value);
>                 return 0;
> diff --git a/environment.h b/environment.h
> index 51898c99cd..3512a7072e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -152,7 +152,6 @@ extern int assume_unchanged;
>  extern int warn_on_object_refname_ambiguity;
>  extern char *apply_default_whitespace;
>  extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>  extern int zlib_compression_level;
>  extern int pack_compression_level;
>  extern unsigned long pack_size_limit_cfg;
> diff --git a/repo-settings.c b/repo-settings.c
> index 195c24e9c0..396cf79f20 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -5,6 +5,7 @@
>  #include "midx.h"
>  #include "pack-objects.h"
>  #include "setup.h"
> +#include "path.h"
>
>  static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>                           int def)
> @@ -158,6 +159,7 @@ void repo_settings_clear(struct repository *r)
>         struct repo_settings empty = REPO_SETTINGS_INIT;
>         FREE_AND_NULL(r->settings.fsmonitor);
>         FREE_AND_NULL(r->settings.hooks_path);
> +       FREE_AND_NULL(r->settings.git_attributes_file);
>         r->settings = empty;
>  }
>
> @@ -230,3 +232,11 @@ void repo_settings_reset_shared_repository(struct repository *repo)
>  {
>         repo->settings.shared_repository_initialized = 0;
>  }
> +const char *repo_settings_get_attributesfile_path(struct repository *repo)
> +{
> +       if (!repo->settings.git_attributes_file) {
> +               if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file))
> +                       repo->settings.git_attributes_file = xdg_config_home("attributes");
> +       }
> +       return repo->settings.git_attributes_file;
> +}
> diff --git a/repo-settings.h b/repo-settings.h
> index d477885561..362f355267 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -68,6 +68,7 @@ struct repo_settings {
>         unsigned long big_file_threshold;
>
>         char *hooks_path;
> +       char *git_attributes_file;
>  };
>  #define REPO_SETTINGS_INIT { \
>         .shared_repository = -1, \
> @@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
>  void repo_settings_set_shared_repository(struct repository *repo, int value);
>  void repo_settings_reset_shared_repository(struct repository *repo);
>
> +/*
> + * Read the value for "core.attributesfile".
> + * Defaults to xdg_config_home("attributes") if the core.attributesfile
> + * isn't available.
> + */
> +const char *repo_settings_get_attributesfile_path(struct repository *repo);
> +
>  #endif /* REPO_SETTINGS_H */
> --
> 2.34.1
>
