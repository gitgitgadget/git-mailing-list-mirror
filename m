Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55832C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A138608FC
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhFQRPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhFQRPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A5C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k13-20020ad454ed0000b029025d9d53c67eso2756480qvx.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SHozFl7gXVcRUsYCwM6NKuMJ9Uc/ZXn9DY+UzsxxKRk=;
        b=MerYaV78V0DVqhmKfn+gd363NKV8ApQXzvsih7GBHKNmMnPi60qO6fxAAnKCn49gyG
         arCdWWAyrEzEz9+JPnJnRou/JBu+EuwkUOJ8Kti8QMRpL372gHqS9KEG3pJutLxAzg23
         nt23vv9IXB4t1N20ibHgh4R2M0r6Q4/IS7Kok564B7R3+r/hBIm0IqcPJ9C08uQelWoJ
         PMNrNr5BF9gH4IEfH1o7i8T9OVstpRcyFbGbmIgiso3ra9net0z6GI4vxit4aCeia1ff
         mmsrtpMWnLYFfmkoc44xpeaIkNgwW3w4bvCe06mWTBSjsAiLd8t+rQoTrjxIKMZOcOc9
         T3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SHozFl7gXVcRUsYCwM6NKuMJ9Uc/ZXn9DY+UzsxxKRk=;
        b=lVtPrnixlo1FEEBstxVjL+Byv/hkbkzx8Tf1wtRDKBSRrKE59v+d6tpdGooDKm/ngH
         eOrKK76r1XirEkl9YbNzLGt8W39OJYz5GdgYDcabPAC9iDZvKonWtZKWuNRMAYCIlbRS
         L4EBBY8/HNpXUQb00IIQUeo1Wi1EUJgC8A5kc3yzqnKh1yMQKJ8GO1eX0U5i5zJ8LZvb
         yxqsFApF/8emzh/5EDpWNh7KDC/RD32UEKqhv1jQI244wL/P39tAqz0Sq4Xmzu2GvdIi
         HfBM+Aa3lllAe+MPIu89LIeIgviVuSlE8+HgrAyMj4hkSqMrcoGRzejNEq1L1np7I9ma
         bs8w==
X-Gm-Message-State: AOAM53348jWx+UUkB3Wo512TG0bONypfUj/OZdAjtq3kre5FVcBtlOBy
        P8P75kcBMElihtgjO3xg7MoBXuW3tyheYFs8743z6Da3XpIIWxyO88imqwv41qR1/M75SucqnD4
        suc0TytpEaaTfJjKsyzI2Nnp+6VWDI4yj4kSqQysmdFp4oz++Fu4x93ri11LHibkRRxKhfwBULi
        hP
X-Google-Smtp-Source: ABdhPJwubgK9BKYxiNdwT8TheLfoRml49MwCT6/TGyy9LncVovOvXvhgUHckCr325jLHJ5YSqSoVoFTO9jmgzEHQ+VAV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8607:: with SMTP id
 y7mr8043819ybk.17.1623950010174; Thu, 17 Jun 2021 10:13:30 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:13:21 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <cover.1623949899.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 0/5] First steps towards partial clone submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting from [1]:

> I'm happy with Jonathan and Peff's responses on patch 3; as I
> mentioned above I just didn't understand the original code before
> Jonathan's changes.  (Perhaps some comments could be added to clarify
> that code area, but again that's clarifying the code that existed
> before Jonathan's patch so it doesn't need to be part of his series.)
> So that only leaves my nitpicks on patches 1 & 4; otherwise the series
> looks good to me.

I've addressed Elijah's comments on patches 1 and 4.

[1] https://lore.kernel.org/git/CABPp-BFD5=98C0+WnfK=+s7twZ960ORiZzUSP94GD2A4bXJ69Q@mail.gmail.com/

Jonathan Tan (5):
  repository: move global r_f_p_c to repo struct
  promisor-remote: support per-repository config
  submodule: refrain from filtering GIT_CONFIG_COUNT
  run-command: refactor subprocess env preparation
  promisor-remote: teach lazy-fetch in any repo

 Makefile                      |   1 +
 object-file.c                 |   7 +--
 promisor-remote.c             | 108 ++++++++++++++++++----------------
 promisor-remote.h             |  28 ++++++---
 repository.c                  |  10 ++++
 repository.h                  |   5 ++
 run-command.c                 |  12 ++++
 run-command.h                 |  10 ++++
 setup.c                       |  17 ++++--
 submodule.c                   |  17 +-----
 t/helper/test-partial-clone.c |  43 ++++++++++++++
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/t0410-partial-clone.sh      |  23 ++++++++
 14 files changed, 199 insertions(+), 84 deletions(-)
 create mode 100644 t/helper/test-partial-clone.c

Range-diff against v3:
1:  e8e6a95951 ! 1:  0bd009597d repository: move global r_f_p_c to repo struct
    @@ repository.c: int repo_init(struct repository *repo,
      
      	repo_set_hash_algo(repo, format.hash_algo);
      
    ++	/* take ownership of format.partial_clone */
     +	repo->repository_format_partial_clone = format.partial_clone;
     +	format.partial_clone = NULL;
     +
    @@ setup.c: int discover_git_directory(struct strbuf *commondir,
      		return -1;
      	}
      
    ++	/* take ownership of candidate.partial_clone */
     +	the_repository->repository_format_partial_clone =
     +		candidate.partial_clone;
     +	candidate.partial_clone = NULL;
    @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     -		if (startup_info->have_repository)
     +		if (startup_info->have_repository) {
      			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
    ++			/* take ownership of repo_fmt.partial_clone */
     +			the_repository->repository_format_partial_clone =
     +				repo_fmt.partial_clone;
     +			repo_fmt.partial_clone = NULL;
    @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
      	}
      	/*
      	 * Since precompose_string_if_needed() needs to look at
    -@@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
    - 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
    - 	}
    - 
    --
    - 	strbuf_release(&dir);
    - 	strbuf_release(&gitdir);
    - 	clear_repository_format(&repo_fmt);
     @@ setup.c: void check_repository_format(struct repository_format *fmt)
      	check_repository_format_gently(get_git_dir(), fmt, NULL);
      	startup_info->have_repository = 1;
2:  07eb0a0f39 = 2:  8a478b46bf promisor-remote: support per-repository config
3:  004ac92e9b = 3:  78b4108ae1 submodule: refrain from filtering GIT_CONFIG_COUNT
4:  ce0454f442 ! 4:  1778cbf878 run-command: refactor subprocess env preparation
    @@ run-command.h: int run_processes_parallel_tr2(int n, get_next_task_fn, start_fai
     +/**
     + * Convenience function which prepares env_array for a command to be run in a
     + * new repo. This adds all GIT_* environment variables to env_array with the
    -+ * exception of GIT_CONFIG_PARAMETERS (which cause the corresponding
    -+ * environment variables to be unset in the subprocess) and adds an environment
    -+ * variable pointing to new_git_dir. See local_repo_env in cache.h for more
    -+ * information.
    ++ * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
    ++ * corresponding environment variables to be unset in the subprocess) and adds
    ++ * an environment variable pointing to new_git_dir. See local_repo_env in
    ++ * cache.h for more information.
     + */
     +void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
     +
5:  a3278d61f0 = 5:  dbba426b6a promisor-remote: teach lazy-fetch in any repo
-- 
2.32.0.272.g935e593368-goog

