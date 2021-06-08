Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5EC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6FC6101A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFHA15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHA14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:27:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB6C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 17:26:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d12-20020ac85acc0000b0290248a842f529so1135281qtd.15
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uRw4aNsTMAcnqFn57wJq3FdABL8Sv+42+sq4PS8Z2IU=;
        b=Ehfy+nO38nSXFQcnkOolixhfof6VvyR//lVXwylb/y7lNjL6/7Df7I/QMTAAXBTBsl
         rJvTghA/aIajOr37Ob5OneSpjYOYeAjFzjVI2xs80kqfAyzYDZKxEmrnx/hwc+Qf8BMk
         APTUxqAVCeInbIG/1GYHTjcoEmTPNRTQbc7Ry1wrpOOvr2Dkk0Na8od8KbZHI1LihFCI
         hJaK6WPpxwlaqKlE7P4PeQF/+1bLSgt5TmxK/SZd7Lt8QP9VDabe8fD8ZRtxCtiXtc97
         K017YD2VbdPw8Qr405UcoEFkA/Bky0mb5hii2B2u3Yso6lUGR+WAgCSCXp5i170XZdej
         bwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uRw4aNsTMAcnqFn57wJq3FdABL8Sv+42+sq4PS8Z2IU=;
        b=uavc2G4noPlbqTaf/XuihNTyp+tImJkgaBOEIrUH+a2I5Fa6q023e6zM2x8F0CMLp1
         9VMWe3/rjtzHlvJqi0+pVBkX9z0IvcxjU1DG7cwxZ21rRLXGjrwFMljx1UeSWNQBUGC8
         pUtqC+GfSn/rK0Md/Gj8NN6f6FOklXPh4PqLwqZgOGkXeLuTjredo3w2XZxQ/XxSppWC
         GpDdF1YCHO/yO/37GPR74ffoS22bYdGLo7jbvYVFIfYBL0nDewbcNmQ1rfg408zlkDmx
         8iFI1/d46uIuLhSpzbgg9eFtPlvilvrpSnhIia7ixvw0F/sxaaRM3NP+/rMI8NI+aKF1
         4BUw==
X-Gm-Message-State: AOAM531ahMNsdS2eLw7w9DrLbxj+BxxNc3imMfInRgL+aZ7ouQVYb3Vn
        76xHu2QOEcWeXcE8tjRWMhBEzFBIc3pQ5GMuAZc4H5O+KrbyaR/cZe+hEwLyOAwNwssk0DKWV1R
        HIvWQpv0Xiym3h+FhwXGzj/EiIp7l7k7hhcqtMSzvKq7l36HjQaddApZO/G4lAWqevr1LRAHF6B
        DS
X-Google-Smtp-Source: ABdhPJzk6QloMEi9K3CLbWr2cACb29EcErihqQZP6IMrcVFPNdgGkYXCEDJ+Lv120jtlimZdfXOa3n8NVlmTTJGS7sWc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:fa4a:: with SMTP id
 k10mr20575073qvo.18.1623111963155; Mon, 07 Jun 2021 17:26:03 -0700 (PDT)
Date:   Mon,  7 Jun 2021 17:25:55 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <cover.1623111879.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v2 0/4] First steps towards partial clone submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your reviews. I believe I've addressed all review
comments, including the one from Elijah about the test failing with
sha256 (which turns out to be because I didn't add a call to
setup_git_directory(), which the other test helpers do).

Jonathan Tan (4):
  promisor-remote: read partialClone config here
  promisor-remote: support per-repository config
  run-command: move envvar-resetting function
  promisor-remote: teach lazy-fetch in any repo

 Makefile                      |   1 +
 cache.h                       |   1 -
 object-file.c                 |   7 +-
 promisor-remote.c             | 125 ++++++++++++++++++++--------------
 promisor-remote.h             |  28 +++++---
 repository.c                  |   6 ++
 repository.h                  |   4 ++
 run-command.c                 |  10 +++
 run-command.h                 |   9 +++
 setup.c                       |  10 ++-
 submodule.c                   |  14 +---
 t/helper/test-partial-clone.c |  43 ++++++++++++
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/t0410-partial-clone.sh      |  23 +++++++
 15 files changed, 201 insertions(+), 82 deletions(-)
 create mode 100644 t/helper/test-partial-clone.c

Range-diff against v1:
1:  4a7ad9ffeb ! 1:  07290cba86 promisor-remote: read partialClone config here
    @@ promisor-remote.c: static int promisor_remote_config(const char *var, const char
      	const char *subkey;
      
     +	if (!strcmp(var, "extensions.partialclone")) {
    -+		repository_format_partial_clone = xstrdup(value);
    ++		/*
    ++		 * NULL value is handled in handle_extension_v0 in setup.c.
    ++		 */
    ++		if (value)
    ++			repository_format_partial_clone = xstrdup(value);
     +		return 0;
     +	}
     +
2:  d8f5fa9b9f ! 2:  c462927ff2 promisor-remote: support per-repository config
    @@ promisor-remote.c: static void promisor_remote_move_to_tail(struct promisor_remo
      	const char *name;
      	size_t namelen;
      	const char *subkey;
    - 
    - 	if (!strcmp(var, "extensions.partialclone")) {
    --		repository_format_partial_clone = xstrdup(value);
    -+		config->repository_format_partial_clone = xstrdup(value);
    +@@ promisor-remote.c: static int promisor_remote_config(const char *var, const char *value, void *data
    + 		 * NULL value is handled in handle_extension_v0 in setup.c.
    + 		 */
    + 		if (value)
    +-			repository_format_partial_clone = xstrdup(value);
    ++			config->repository_format_partial_clone = xstrdup(value);
      		return 0;
      	}
      
    @@ promisor-remote.c: static int promisor_remote_config(const char *var, const char
      }
      
     -static void promisor_remote_clear(void)
    -+static void promisor_remote_clear(struct promisor_remote_config *config)
    ++void promisor_remote_clear(struct promisor_remote_config *config)
      {
     -	while (promisors) {
     -		struct promisor_remote *r = promisors;
     -		promisors = promisors->next;
    ++	FREE_AND_NULL(config->repository_format_partial_clone);
    ++
     +	while (config->promisors) {
     +		struct promisor_remote *r = config->promisors;
     +		config->promisors = config->promisors->next;
    @@ promisor-remote.h: struct promisor_remote {
     +	repo_promisor_remote_reinit(the_repository);
     +}
     +
    ++void promisor_remote_clear(struct promisor_remote_config *config);
    ++
     +struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
     +static inline struct promisor_remote *promisor_remote_find(const char *remote_name)
     +{
    @@ promisor-remote.h: struct promisor_remote {
      /*
       * Fetches all requested objects from all promisor remotes, trying them one at
     
    + ## repository.c ##
    +@@
    + #include "lockfile.h"
    + #include "submodule-config.h"
    + #include "sparse-index.h"
    ++#include "promisor-remote.h"
    + 
    + /* The main repository */
    + static struct repository the_repo;
    +@@ repository.c: void repo_clear(struct repository *repo)
    + 		if (repo->index != &the_index)
    + 			FREE_AND_NULL(repo->index);
    + 	}
    ++
    ++	if (repo->promisor_remote_config) {
    ++		promisor_remote_clear(repo->promisor_remote_config);
    ++		FREE_AND_NULL(repo->promisor_remote_config);
    ++	}
    + }
    + 
    + int repo_read_index(struct repository *repo)
    +
      ## repository.h ##
     @@ repository.h: struct lock_file;
      struct pathspec;
3:  c5307a9f02 ! 3:  9cbdf60981 run-command: move envvar-resetting function
    @@ run-command.h: int run_processes_parallel_tr2(int n, get_next_task_fn, start_fai
      			       const char *tr2_category, const char *tr2_label);
      
     +/**
    -+ * Convenience function that adds entries to env_array that resets all
    -+ * repo-specific environment variables except for CONFIG_DATA_ENVIRONMENT. See
    -+ * local_repo_env in cache.h for more information.
    ++ * Convenience function which adds all GIT_* environment variables to env_array
    ++ * with the exception of GIT_CONFIG_PARAMETERS. When used as the env_array of a
    ++ * subprocess, these entries cause the corresponding environment variables to
    ++ * be unset in the subprocess. See local_repo_env in cache.h for more
    ++ * information.
     + */
     +void prepare_other_repo_env(struct strvec *env_array);
     +
4:  b70a00b9b0 ! 4:  5b41569ace promisor-remote: teach lazy-fetch in any repo
    @@ t/helper/test-partial-clone.c (new)
     +#include "repository.h"
     +#include "object-store.h"
     +
    ++/*
    ++ * Prints the size of the object corresponding to the given hash in a specific
    ++ * gitdir. This is similar to "git -C gitdir cat-file -s", except that this
    ++ * exercises the code that accesses the object of an arbitrary repository that
    ++ * is not the_repository. ("git -C gitdir" makes it so that the_repository is
    ++ * the one in gitdir.)
    ++ */
     +static void object_info(const char *gitdir, const char *oid_hex)
     +{
     +	struct repository r;
    @@ t/helper/test-partial-clone.c (new)
     +
     +int cmd__partial_clone(int argc, const char **argv)
     +{
    ++	setup_git_directory();
    ++
     +	if (argc < 4)
     +		die("too few arguments");
     +
    @@ t/t0410-partial-clone.sh: test_expect_success 'do not fetch when checking existe
     +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
     +	rm -rf full partial.git &&
     +	test_create_repo full &&
    -+	printf 12345 >full/file.txt &&
    -+	git -C full add file.txt &&
    -+	git -C full commit -m "first commit" &&
    ++	test_commit -C full create-a-file file.txt &&
     +
     +	test_config -C full uploadpack.allowfilter 1 &&
     +	test_config -C full uploadpack.allowanysha1inwant 1 &&
     +	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
    -+	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
    ++	FILE_HASH=$(git -C full rev-parse HEAD:file.txt) &&
     +
     +	# Sanity check that the file is missing
     +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
     +	grep "[?]$FILE_HASH" out &&
     +
    -+	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
    -+	test "$OUT" -eq 5 &&
    ++	git -C full cat-file -s "$FILE_HASH" >expect &&
    ++	test-tool partial-clone object-info partial.git "$FILE_HASH" >actual &&
    ++	test_cmp expect actual &&
     +
     +	# Sanity check that the file is now present
     +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-- 
2.32.0.rc1.229.g3e70b5a671-goog

