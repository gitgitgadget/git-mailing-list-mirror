Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FB30FC2C
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922347; cv=pass; b=BxXOgbVLM0N4R9tL+E6uM4MgZgeXoq2mWQBimmQ6HFApS9GrQfiljXHodCwFNHI8gv0I6cwLxDh7T4OUlYYI7DKKgb9ljy5JbEsvrAj9B7HuoTsfBVqE7ELEJNal2MsiVsrWGkvR+hVLVIhPp19gBHchEZXG6a516io27T4JDdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922347; c=relaxed/simple;
	bh=T2EjQLPdWx1q8PDAU9jdqPhklkzw+ethfK+B9zMiIuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXUrNYjCLAwFtizjOJB02+bPmij6dm7DfnWFvlsgV+H1aRPukcX3utQVhw6rJIoCeaPL2+iEEClQYQRHFSfgOmSi5fcYwGHGPuy8Z34IMpSvcp/SAYQxc+AMg0/ijMXOdDxFUN8FAjIE+mpCXKJff/URkbobKC5AWkJl36Zt3gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuXIj2Lm; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuXIj2Lm"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121a0bcd364so6908557c88.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:19:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768922344; cv=none;
        d=google.com; s=arc-20240605;
        b=dVq+lHuVyW4RlBEqQakazgZsfSeoEv/9D9/oaUyahfytOpA8k8gCXVR/rULUh6m62N
         kOE3q16RDRku/ErMzVIksiY1lMJAFlg7ZOK4Pit6oGAUp2J3jq4owR9aWK0SicY/OlTi
         wCZEtrqXjGmaFaYxtizabCUndTGA5Mb+NKQXDdyaEu5uIr/tpjyEiUV7bwTmKDOuGIky
         e+qlxsQ+IrhPFD8u4wRmBeEc0qnPkCmI5HeM19C9aOjsV6WKlTmFxRIFZH5+6Bh8wDXp
         P8ncGpEf/oOcPsxK1YLM9POqD9JPwxqcmh8WBtIj4hO8bDYi1IVdNfdASpzxGNcPbilt
         b8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j+BJ/gPA7CnlYx65j2o8ugnniPCh24F5xPCu1423koE=;
        fh=6ChGh/cqfJ2IP/yKbYYCRIDlRygZolbrkzinphvGRu0=;
        b=jPP++6tytwjf+u/eo1BKJcHphRfm1tqZ5RmCaZ/VIr4E9sisCpzszQzKEe//LgNXz2
         /WZc6sifrfln+blC1BiZa+icS2OMAFtP98uIvHPaXBv9WcIA3266Yyhazr+asXwp0Xi7
         93vKV825iVhoSq107ay2hFk8jY5dWhnbxNzjyEB5XYd6O/G9ope2zgX/+g6jU2OYsQtX
         2/h4qyuozCTsb7dGCMsJRN8YvFy34hJQ4LOZPSYo/VLOWYqg2DFnq650wjow+rZWZ4Pj
         x9NHV/4XMoeAZdIuzyoZege6DbcGbyeLBqElrD3wznv8lKlT/IW74VdN9N3tJBnmh33L
         npeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768922344; x=1769527144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j+BJ/gPA7CnlYx65j2o8ugnniPCh24F5xPCu1423koE=;
        b=RuXIj2LmqBonXWybZQypuAk3sTkD88Alyq78eQ+7hMkWtz5IfRph1vv9JAxXsVQ6RV
         +CivXcjmHdFoWkoy7n1xlN8+GMRuw58oHb25Zo/X3W6YFX1qIpP1pRFCeebOeUXzN7e+
         FaO2onPfsxAeIs4zZ+Ij2lsTotRfVJiddPRgKVCmwjwb+IbJoa4eNKaX2fAmgYUAr9Zv
         RJPDxnWO1CD99f7o9khgwXzEEwAVLt8J7mLr4lPyuoIKSdp8i4or7/Z4keYnBRZH0fn9
         /ZJBEM/vaTNcfstfYoF+bEt25bqqXtXsQrI65XbtMOYqFVG6GiwvfBxZJQTpcrh3lnPJ
         EvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922344; x=1769527144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+BJ/gPA7CnlYx65j2o8ugnniPCh24F5xPCu1423koE=;
        b=MbJIuq6fs0GvgmKZj8mxqdgn1UkD6Pwx++AU5pNX9YMxnpU6QEHc4DybiEfYnlOC/M
         jV1BEGSyW2EhIIyUcrXHvfIq4OIJIRAdUvQHe8j5j7n1WWQJlsZ2bY9cByC+V2k35vGx
         kXavLz83fQ53fyoCls/xUqc1xx53MtpnqhiYpRM2OGwk/te8SP77eWPHvEZMdn+l2+4T
         FRgOOdOMQiC8YLVeazHyjNogSQ5brx8ZYQKh3HWMkszlG8QRpknrOC3Wl0c8uQi5DyB0
         zgAal2P8PKF7xpchrqNvg5qndCGUFTnGPXlAVB+SYmT1J8tip5VmMyo2yL4y4LgY2mvE
         gYWQ==
X-Gm-Message-State: AOJu0Yw6jjrSUrLbl7GhuS9LkDFXOuyYlOfTQab0+HvMYToOF8Q/Wv+v
	w3eJoDs72Hfu3MHSVFftO5zrN0GVZ8kJ4AwVJ3HbzgCcVJLclLSqKAOdHu38Lxm9u0n1UCUdL3w
	EK+E4KPfu7vRmsrX9nTbtbtfapPQVliBoJS5u7VU=
X-Gm-Gg: AY/fxX750wsjfNE5pnp88GZZj+9Kq0XQkLVpnX2vxIE/zN0Wb5wp77c9+Ec2gOJel9Z
	tyBUcR+w1dFI0cIMYY7Aw5eTZpd2ohBori7CPJSytxffWVkPa7SquPKmc4v1/EdvfxGgv9zJmM9
	MOfReiEWy7ZOjcsIJEaNf3bTCmDtCVYz3ov19tGi3pCWngA247EjOdQAGb5CeKS63w1lynXYEgi
	257K272VBzL5lE2TzXw/p0ky2T/6dXPCOTAXezG3xWtobuJ0ya83rxH8Qs5IcmKEGHEbWPY
X-Received: by 2002:a05:7022:2484:b0:119:e56c:18a5 with SMTP id
 a92af1059eb24-1244a7257afmr11694569c88.13.1768922344048; Tue, 20 Jan 2026
 07:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768318762.git.belkid98@gmail.com> <cover.1768681947.git.belkid98@gmail.com>
In-Reply-To: <cover.1768681947.git.belkid98@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 20 Jan 2026 16:19:05 +0100
X-Gm-Features: AZwV_Qjq32lZ1AosjqoCfCUACLgNLP-15PJ1v8CTRPvItxldJjyRPpVqPBQL2KA
Message-ID: <CAD=f0L8fs5Jxs7o-KkbXx3s3eR9jh6uN=Sok-z2S=fMX1yFMtQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 0/3] store repo specific config values in new
 `struct repo_config_values`
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Jan 2026 at 22:02, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
> Hi Git Community,
> Over the course of my ongoing internship, which focused on moving repo specific
> global variables in environment.h into local scope, I have attempted to move some
> variables into the struct repo-settings.
> However there has been some design concerns as regards the use of
> `prepare_repo_settings()` with respect to when and where to call the
> function, and also the change in behaviours when the variable is lazily
> loaded as discussed in [1] and [2].
>
> After different deliberations, Phillip Wood proposed creating a new config
> struct [3], adding it to the repository struct and passing the repo struct to
> `git_default_config()` to store parsed repo specific config values per repo.
> This ensures the current behaviours will be retained.
>
> I have experimented with this approach for some values and I would
> appreciate feedbacks about this approach before we can move forward
> and use it for more variables related to `git_default_config()`.
>
> For now, the parsed value is stored in `the_repository` in
> `git_default_*_config()` and further efforts to pass the repository
> parameter to `git_default_config()` as the callback parameter will
> be looked into later on.
> The link to the CI tests can be see in [4]
>
> 1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
> 2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
> 3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
> 4. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2266020513
>
> Changes in v3:
> ==============
> - Moved declaration and definition of repo_config_values_init into patch 1
> - Returned commit message in line 1 of builtin/backfill.c
>
> Olamide Caleb Bello (3):
>   environment: stop storing `core.attributesFile` globally
>   environment: environment: stop using core.sparseCheckout globally
>   environment: move "branch.autoSetupMerge" into `struct
>     repo_config_values`
>
>  attr.c                      |  7 ++++---
>  branch.h                    |  2 --
>  builtin/backfill.c          |  2 +-
>  builtin/branch.c            |  2 +-
>  builtin/checkout.c          |  2 +-
>  builtin/clone.c             |  2 +-
>  builtin/grep.c              |  2 +-
>  builtin/mv.c                |  2 +-
>  builtin/push.c              |  2 +-
>  builtin/sparse-checkout.c   | 22 +++++++++++-----------
>  builtin/submodule--helper.c |  2 +-
>  builtin/worktree.c          |  2 +-
>  dir.c                       |  2 +-
>  environment.c               | 28 ++++++++++++++++++----------
>  environment.h               | 15 +++++++++++++--
>  repository.c                |  1 +
>  repository.h                |  4 ++++
>  sparse-index.c              |  6 ++++--
>  unpack-trees.c              |  2 +-
>  wt-status.c                 |  2 +-
>  20 files changed, 67 insertions(+), 42 deletions(-)
>
>  Range diff versus v2:
>  =====================
>
>  1:  b6f8deaa40 ! 1:  1aa41da833 environment: stop storing `core.attributesFile` globally
>     @@ Metadata
>       ## Commit message ##
>          environment: stop storing `core.attributesFile` globally
>
>     -    The config value parsed in git_default_core_config() is loaded eagerly
>     +    The config value is parsed in git_default_core_config(), loaded eagerly
>          and stored in the global variable `git_attributes_file`.
>          Storing this value in a global variable can lead to unexpected
>          behaviours when more than one Git repository run in the same Git process.
>
>     -    Move this value into a `struct repo_config_values` which holds all the
>     -    values parsed by `git_default_config()` and can be accessed per
>     -    repository via `git_default_config()`. This will ensure the current
>     -    behaviour remains the same while also enabling the libification of Git.
>     +    Create a new struct `repo_config_values` to hold this value and
>     +    other repository dependent values parsed by `git_default_config()` and
>     +    can be accessed per repository via `git_default_config()`.
>     +    This will ensure the current behaviour remains the same while also
>     +    enabling the libification of Git.
>
>          It is important to note that `git_default_config()` is a wrapper to other
>          `git_default_*_config()` such as `git_default_core_config()`.
>     @@ environment.c: static int git_default_core_config(const char *var, const char *v
>         }
>
>         if (!strcmp(var, "core.bare")) {
>     +@@ environment.c: int git_default_config(const char *var, const char *value,
>     +   /* Add other config variables here and to Documentation/config.adoc. */
>     +   return 0;
>     + }
>     ++
>     ++void repo_config_values_init(struct repo_config_values *cfg)
>     ++{
>     ++  cfg->attributes_file_path = NULL;
>     ++}
>
>       ## environment.h ##
>      @@ environment.h: extern const char * const local_repo_env[];
>     @@ environment.h: extern const char * const local_repo_env[];
>       /*
>        * Wrapper of getenv() that returns a strdup value. This value is kept
>        * in argv to be freed later.
>     +@@ environment.h: const char *strip_namespace(const char *namespaced_ref);
>     + int git_default_config(const char *, const char *,
>     +                  const struct config_context *, void *);
>     +
>     ++void repo_config_values_init(struct repo_config_values *cfg);
>     ++
>     + /*
>     +  * TODO: All the below state either explicitly or implicitly relies on
>     +  * `the_repository`. We should eventually get rid of these and make the
>      @@ environment.h: extern int assume_unchanged;
>       extern int warn_on_object_refname_ambiguity;
>       extern char *apply_default_whitespace;
>     @@ environment.h: extern int assume_unchanged;
>       extern int pack_compression_level;
>       extern unsigned long pack_size_limit_cfg;
>
>     + ## repository.c ##
>     +@@ repository.c: void initialize_repository(struct repository *repo)
>     +   ALLOC_ARRAY(repo->index, 1);
>     +   index_state_init(repo->index, repo);
>     +   repo->check_deprecated_config = true;
>     ++  repo_config_values_init(&repo->config_values);
>     +
>     +   /*
>     +    * When a command runs inside a repository, it learns what
>     +
>       ## repository.h ##
>      @@
>
> 2:  1e83c077f2 ! 2:  fd95169de4 environment: environment: stop using core.sparseCheckout globally
>     @@ Commit message
>          when different Git repositories running in the same process access this
>          variable.
>
>     -    Move the parsed value into `struct repo_config_values` which holds all the
>     -    values parsed by `git_default_config()` and can be accessed
>     -    per repo via `git_default_config()`. This retains current
>     +    Move the parsed value into `struct repo_config_values` to retains current
>          behaviours while achieving the repository scoped access.
>
>          Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>     @@ Commit message
>          Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>
>       ## builtin/backfill.c ##
>     -@@
>     --/* We need this macro to access core_apply_sparse_checkout */
>     - #define USE_THE_REPOSITORY_VARIABLE
>     -
>     - #include "builtin.h"
>      @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>         repo_config(repo, git_default_config, NULL);
>
>     @@ environment.c: static int git_default_core_config(const char *var, const char *v
>                 return 0;
>         }
>
>     +@@ environment.c: int git_default_config(const char *var, const char *value,
>     + void repo_config_values_init(struct repo_config_values *cfg)
>     + {
>     +   cfg->attributes_file_path = NULL;
>     ++  cfg->sparse_checkout = 0;
>     + }
>
>       ## environment.h ##
>      @@ environment.h: struct strvec;
> 3:  6e54e22ac7 ! 3:  9a411db9f8 environment: move "branch.autoSetupMerge" into `struct repo_config_values`
>     @@ Commit message
>          `git_branch_track`. This global variable can cause unexpected behaviours
>          when multiple Git repos run in the the same process.
>
>     -    Move this value into `struct repo_config_values` which holds all values
>     -    parsed by `git_default_config()` and can be accessed per
>     -    repo via `git_default_config()`. This would retain the same
>     +    Move this value into `struct repo_config_values` to retain current
>          behaviours while achieving repository scoped access.
>
>          Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>     @@ environment.c: static int git_default_i18n_config(const char *var, const char *v
>                 return 0;
>         }
>         if (!strcmp(var, "branch.autosetuprebase")) {
>     -@@ environment.c: int git_default_config(const char *var, const char *value,
>     -   /* Add other config variables here and to Documentation/config.adoc. */
>     -   return 0;
>     - }
>     -+
>     -+void repo_config_values_init(struct repo_config_values *cfg)
>     -+{
>     +@@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
>     + {
>     +   cfg->attributes_file_path = NULL;
>     +   cfg->sparse_checkout = 0;
>      +  cfg->git_branch_track = BRANCH_TRACK_REMOTE;
>     -+}
>     + }
>
>       ## environment.h ##
>      @@
>     @@ environment.h: struct repo_config_values {
>       };
>
>       /*
>     -@@ environment.h: const char *strip_namespace(const char *namespaced_ref);
>     - int git_default_config(const char *, const char *,
>     -                  const struct config_context *, void *);
>     -
>     -+void repo_config_values_init(struct repo_config_values *cfg);
>     -+
>     - /*
>     -  * TODO: All the below state either explicitly or implicitly relies on
>     -  * `the_repository`. We should eventually get rid of these and make the
>     -
>     - ## repository.c ##
>     -@@ repository.c: void initialize_repository(struct repository *repo)
>     -   ALLOC_ARRAY(repo->index, 1);
>     -   index_state_init(repo->index, repo);
>     -   repo->check_deprecated_config = true;
>     -+  repo_config_values_init(&repo->config_values);
>     -
>     -   /*
>     -    * When a command runs inside a repository, it learns what
>
>

Hello
Replying to this to get reviews and feedback.

Thanks
