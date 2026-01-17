Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1952C234A
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768683734; cv=none; b=O53KzZ0lL9vkzm/RBEdRlCOMygi6VU1N/qPgmjbY10yBqplV9eY4mwXtaDUwwHYQEkFa3VcnHoHIh+4VvN5o29hsmyOfMhp4Tj1AXFUg3f2hAjcWzxjBjh8H5SFacrmjo6IgDmmvyTZ7R1H5QqHPommn7Vp/bdHEdKpSEKr3h7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768683734; c=relaxed/simple;
	bh=Tx6rdbQYHbQjO5ZBfLzdzq3BING51d2Jc1kQk0W3iD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5mhBimqAuafIVXVmsfY/hQ5soZMGPkYTkwBjQ20jnTIU57NovVBPbvIa04RgS48Ah3hwgLUmhTfEul2IoJx6ttuRu62nUEfwfDoSvVsJlhtnnYe1aKoNmd9niwyUXFkqY06meYo8xXwVGDDx5CMrHTznOJH/TeTB6gjpYA2Pek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhEpPbUy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhEpPbUy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso17055945e9.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768683731; x=1769288531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQGAAKv1eF0C2s6gbQx9cIBjaPSWXSOodlbjK1H39Xg=;
        b=GhEpPbUyRkYciJEQFJvl7QAoaX+pAzAeRKeKJrd5ESA5BpCs75km4OsTjdNmKT5GKY
         G2HvZHMJC51+di2fF/R4+q1sB7sKzgjzEGOE1tdijbnn2gpdpRCVKPV/F+0vKL5x0d0r
         7St0oriMmH+HXtoiO5KJ7T9yKcFGAOdJoJrazizLCXa3yFpzTKbefEQuESVNIbJwckBB
         ueUcVRoB3/P6jtfUJvuDStYnNl+h/AcPpMDv7Ld1cwP9iqRmfvj7FsYom/OmlOYl8+6q
         +gB8wntAEwfaBil1Hl1NJQewlznuy4cLw7Qvjv3Kd30mLq+X6jGaq2xleTi7xdIPpMCq
         KljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768683731; x=1769288531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQGAAKv1eF0C2s6gbQx9cIBjaPSWXSOodlbjK1H39Xg=;
        b=C0NTmg7QKoc3x0rYHEjdLhHjHAMSyqpjHiAm3mRVwA1Ldd676rcMvp84xaH6Os4wkZ
         lOLDvCRBLoYPpVtWbQvK+j+Y1Sh3kehlNXpEweY2oSeMPevSq02WIriV/qkNiDI4H1o1
         x+H60j8uTYxFZXCgR0MQamPjNxQaiJSdliZkosNtYc0qleh4Jum27b2IBAfsJgFRl3/1
         c5KeVC1HMf9SvHS5RGZZBUEhHGBNqnPB+0wGgtzXn0COedWX6rAdb+D+GtiNn7cCw+II
         yCTvCUHLVXSp18tRBllleiV0WImRFJ3mfzLawOyvw+0f8u2CxtkL+QO0Ua2wQCRvQk+Y
         1csA==
X-Gm-Message-State: AOJu0YzkR3M+cP7g6dsKLSB3iaWQkygEV6z1UBYWRwi2CIkdZI/63OeL
	bwivCwRfP6jpLUHc6qHYr3ZhHUzBkXJylhr0zDOt+nwQ6zFqjyW0B2zggVgcuMaI
X-Gm-Gg: AY/fxX69byZdCRcQsW5amhEvN+RkmeOIW/EGlxQpB5HA8s/0FehKRfXOkY20QhdWbbk
	3+UbmJ/hJxTIzSjksNOkIj6f2QWYJCmo2OPGo6Ox3fRWfbx2v5+KdbumPSBPyGI/rFTHD8cadLU
	f/cvSYmhAMa+BlPy0W/wDvFWjnjCi5kDTq0FxfUrWknWNAfv0pH7Z+7Cy2EUjgxu+W4knQ1XIrN
	egAixmG/8daMb/Px+3wl2CZwTcHDieSVrzWQMT8frdN9RHiUJo9RkKaBih8AlvUmnU4YKjNroSe
	SRQfdbrwmddl8gRcI3KdotxSUakOWMczD59hHA3Emmruw0ZM4k6zq6cO6csZzajOOgAGRmY8ZZ7
	5GZYn2s02ka4Mu7G2fc/GNtf3mYddFBTAjJ2Obp0kBvUegsZ/yY7rqFzv9OmcI4wyAsmsTO3Rar
	/9pA==
X-Received: by 2002:a05:600c:458d:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-4801e341e2emr70601665e9.19.1768683731090;
        Sat, 17 Jan 2026 13:02:11 -0800 (PST)
Received: from ubuntu ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8caceesm108768795e9.13.2026.01.17.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 13:02:10 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v3 0/3] store repo specific config values in new `struct repo_config_values`
Date: Sat, 17 Jan 2026 21:59:25 +0100
Message-Id: <cover.1768681947.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768318762.git.belkid98@gmail.com>
References: <cover.1768318762.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Git Community,
Over the course of my ongoing internship, which focused on moving repo specific
global variables in environment.h into local scope, I have attempted to move some
variables into the struct repo-settings.
However there has been some design concerns as regards the use of
`prepare_repo_settings()` with respect to when and where to call the
function, and also the change in behaviours when the variable is lazily
loaded as discussed in [1] and [2].

After different deliberations, Phillip Wood proposed creating a new config
struct [3], adding it to the repository struct and passing the repo struct to
`git_default_config()` to store parsed repo specific config values per repo.
This ensures the current behaviours will be retained.

I have experimented with this approach for some values and I would
appreciate feedbacks about this approach before we can move forward
and use it for more variables related to `git_default_config()`.

For now, the parsed value is stored in `the_repository` in
`git_default_*_config()` and further efforts to pass the repository
parameter to `git_default_config()` as the callback parameter will
be looked into later on.
The link to the CI tests can be see in [4]

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
4. https://gitlab.com/gitlab-community/gitlab-org/git/-/pipelines/2266020513

Changes in v3:
==============
- Moved declaration and definition of repo_config_values_init into patch 1
- Returned commit message in line 1 of builtin/backfill.c

Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct
    repo_config_values`

 attr.c                      |  7 ++++---
 branch.h                    |  2 --
 builtin/backfill.c          |  2 +-
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/mv.c                |  2 +-
 builtin/push.c              |  2 +-
 builtin/sparse-checkout.c   | 22 +++++++++++-----------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 dir.c                       |  2 +-
 environment.c               | 28 ++++++++++++++++++----------
 environment.h               | 15 +++++++++++++--
 repository.c                |  1 +
 repository.h                |  4 ++++
 sparse-index.c              |  6 ++++--
 unpack-trees.c              |  2 +-
 wt-status.c                 |  2 +-
 20 files changed, 67 insertions(+), 42 deletions(-)

 Range diff versus v2:
 =====================

 1:  b6f8deaa40 ! 1:  1aa41da833 environment: stop storing `core.attributesFile` globally
    @@ Metadata
      ## Commit message ##
         environment: stop storing `core.attributesFile` globally

    -    The config value parsed in git_default_core_config() is loaded eagerly
    +    The config value is parsed in git_default_core_config(), loaded eagerly
         and stored in the global variable `git_attributes_file`.
         Storing this value in a global variable can lead to unexpected
         behaviours when more than one Git repository run in the same Git process.

    -    Move this value into a `struct repo_config_values` which holds all the
    -    values parsed by `git_default_config()` and can be accessed per
    -    repository via `git_default_config()`. This will ensure the current
    -    behaviour remains the same while also enabling the libification of Git.
    +    Create a new struct `repo_config_values` to hold this value and
    +    other repository dependent values parsed by `git_default_config()` and
    +    can be accessed per repository via `git_default_config()`.
    +    This will ensure the current behaviour remains the same while also
    +    enabling the libification of Git.

         It is important to note that `git_default_config()` is a wrapper to other
         `git_default_*_config()` such as `git_default_core_config()`.
    @@ environment.c: static int git_default_core_config(const char *var, const char *v
      	}

      	if (!strcmp(var, "core.bare")) {
    +@@ environment.c: int git_default_config(const char *var, const char *value,
    + 	/* Add other config variables here and to Documentation/config.adoc. */
    + 	return 0;
    + }
    ++
    ++void repo_config_values_init(struct repo_config_values *cfg)
    ++{
    ++	cfg->attributes_file_path = NULL;
    ++}

      ## environment.h ##
     @@ environment.h: extern const char * const local_repo_env[];
    @@ environment.h: extern const char * const local_repo_env[];
      /*
       * Wrapper of getenv() that returns a strdup value. This value is kept
       * in argv to be freed later.
    +@@ environment.h: const char *strip_namespace(const char *namespaced_ref);
    + int git_default_config(const char *, const char *,
    + 		       const struct config_context *, void *);
    +
    ++void repo_config_values_init(struct repo_config_values *cfg);
    ++
    + /*
    +  * TODO: All the below state either explicitly or implicitly relies on
    +  * `the_repository`. We should eventually get rid of these and make the
     @@ environment.h: extern int assume_unchanged;
      extern int warn_on_object_refname_ambiguity;
      extern char *apply_default_whitespace;
    @@ environment.h: extern int assume_unchanged;
      extern int pack_compression_level;
      extern unsigned long pack_size_limit_cfg;

    + ## repository.c ##
    +@@ repository.c: void initialize_repository(struct repository *repo)
    + 	ALLOC_ARRAY(repo->index, 1);
    + 	index_state_init(repo->index, repo);
    + 	repo->check_deprecated_config = true;
    ++	repo_config_values_init(&repo->config_values);
    +
    + 	/*
    + 	 * When a command runs inside a repository, it learns what
    +
      ## repository.h ##
     @@

2:  1e83c077f2 ! 2:  fd95169de4 environment: environment: stop using core.sparseCheckout globally
    @@ Commit message
         when different Git repositories running in the same process access this
         variable.

    -    Move the parsed value into `struct repo_config_values` which holds all the
    -    values parsed by `git_default_config()` and can be accessed
    -    per repo via `git_default_config()`. This retains current
    +    Move the parsed value into `struct repo_config_values` to retains current
         behaviours while achieving the repository scoped access.

         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
    @@ Commit message
         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

      ## builtin/backfill.c ##
    -@@
    --/* We need this macro to access core_apply_sparse_checkout */
    - #define USE_THE_REPOSITORY_VARIABLE
    -
    - #include "builtin.h"
     @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
      	repo_config(repo, git_default_config, NULL);

    @@ environment.c: static int git_default_core_config(const char *var, const char *v
      		return 0;
      	}

    +@@ environment.c: int git_default_config(const char *var, const char *value,
    + void repo_config_values_init(struct repo_config_values *cfg)
    + {
    + 	cfg->attributes_file_path = NULL;
    ++	cfg->sparse_checkout = 0;
    + }

      ## environment.h ##
     @@ environment.h: struct strvec;
3:  6e54e22ac7 ! 3:  9a411db9f8 environment: move "branch.autoSetupMerge" into `struct repo_config_values`
    @@ Commit message
         `git_branch_track`. This global variable can cause unexpected behaviours
         when multiple Git repos run in the the same process.

    -    Move this value into `struct repo_config_values` which holds all values
    -    parsed by `git_default_config()` and can be accessed per
    -    repo via `git_default_config()`. This would retain the same
    +    Move this value into `struct repo_config_values` to retain current
         behaviours while achieving repository scoped access.

         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
    @@ environment.c: static int git_default_i18n_config(const char *var, const char *v
      		return 0;
      	}
      	if (!strcmp(var, "branch.autosetuprebase")) {
    -@@ environment.c: int git_default_config(const char *var, const char *value,
    - 	/* Add other config variables here and to Documentation/config.adoc. */
    - 	return 0;
    - }
    -+
    -+void repo_config_values_init(struct repo_config_values *cfg)
    -+{
    +@@ environment.c: void repo_config_values_init(struct repo_config_values *cfg)
    + {
    + 	cfg->attributes_file_path = NULL;
    + 	cfg->sparse_checkout = 0;
     +	cfg->git_branch_track = BRANCH_TRACK_REMOTE;
    -+}
    + }

      ## environment.h ##
     @@
    @@ environment.h: struct repo_config_values {
      };

      /*
    -@@ environment.h: const char *strip_namespace(const char *namespaced_ref);
    - int git_default_config(const char *, const char *,
    - 		       const struct config_context *, void *);
    -
    -+void repo_config_values_init(struct repo_config_values *cfg);
    -+
    - /*
    -  * TODO: All the below state either explicitly or implicitly relies on
    -  * `the_repository`. We should eventually get rid of these and make the
    -
    - ## repository.c ##
    -@@ repository.c: void initialize_repository(struct repository *repo)
    - 	ALLOC_ARRAY(repo->index, 1);
    - 	index_state_init(repo->index, repo);
    - 	repo->check_deprecated_config = true;
    -+	repo_config_values_init(&repo->config_values);
    -
    - 	/*
    - 	 * When a command runs inside a repository, it learns what


-- 
2.34.1

