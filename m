Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E01C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABFA60F11
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhHPVKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhHPVKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F82C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so351023pjo.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=veEtxEdaab1btGKRflD7ecoNCrao1dmcFmeLONM0bT4=;
        b=dg8ThJkrtx/tzyIW2gzSEk21J6owaBf2IdK7j3IGNHt4jBSHzqpyxOgWV68NMbUaxp
         H7VKvsq1cSF4iZfgfCgiEGCVCoupzr1hJSFRNwHu1r397gGY08E79q1aojdkW4Y/h7Po
         /86Gjr7Cz0TIA90kyXN7fcM4SeCOz98DMfbxOmhJqn1iAj/FKj71iOx+ij/RLrflDOVE
         /iKi/6FZ5h1THFzV7bdktNGRRdOSl3Zwk/1HE3HXNiT4dt4UkFLVkLEV7OYIIf2Y7Kyv
         TEVHJtfnvL0BNRnWs3Mi3mGhigZUQBCt7yADEPXmI8N7n2ERrjXU5OaIjDLaW907dH2O
         3FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=veEtxEdaab1btGKRflD7ecoNCrao1dmcFmeLONM0bT4=;
        b=RiHBj4KYpSE58lG0KDpw2aYVzWMqwEbsGCn5RJEANIy82jKBXlGG9Yj/tlaYQAokCd
         0lZ1R2RM7OfFNQX+9AsnnBuvB+puz1bKwU8DOjT1p9EsD+LeBSyStYxZPHGmzv2+F5lY
         iW9CK9qiAfnpCbkzzQE2Ym9z5VTtDlJrmm3IIsx40BD0888MxZtGZduqtiOqHxO0b45K
         dsEKVGjDFWmuF+wh+xPzcTr5NUtB2qoBLhWStVA6/BAwM9LRvVhSXnRPgWQVH+ipowIO
         Yb8FtDNpWWRrDHnnXWdrorjPPt3jtNYNqTfM+x4sZSwrSR3wm8uj9qAefpjmavVKBh+I
         1Bpw==
X-Gm-Message-State: AOAM530VL1mszW/6Vt+ACkxzJVEWrEpTgYB6xid8j6DQ8jWjY4bEyFeo
        oGT9Ud5EZGZHS0OMC/8YhJktA9VLJNpmCHozha9fMV7GnZLug8gUD/0vuEt+yhRsU9uO6XjcJI0
        y7+Q3SlMfZN9j2UWg/Xa3CP8v/kwpL5IpwxBloGN4v/4fujP973O0a3pORsFct6HuehrFetIlsK
        F8
X-Google-Smtp-Source: ABdhPJzYnbCLfuwyhb+QqfUK9gLZMjqrkexOUNSu8YLyC5b3VBI2X6oRy9FCEvdHMcBwvSr0osw6IqjJD81g+h3GmPFu
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8c81:b029:12c:ee37:3f58 with
 SMTP id t1-20020a1709028c81b029012cee373f58mr128767plo.45.1629148201232; Mon,
 16 Aug 2021 14:10:01 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:50 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <cover.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 0/8] In grep, no adding submodule ODB as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reviewing, everyone. Here are the requested changes.

Jonathan Tan (8):
  submodule: lazily add submodule ODBs as alternates
  grep: use submodule-ODB-as-alternate lazy-addition
  grep: typesafe versions of grep_source_init
  grep: read submodule entry with explicit repo
  grep: allocate subrepos on heap
  grep: add repository to OID grep sources
  submodule-config: pass repo upon blob config read
  t7814: show lack of alternate ODB-adding

 builtin/grep.c                     | 64 +++++++++++++++++++-----------
 config.c                           | 20 ++++++----
 config.h                           |  3 ++
 grep.c                             | 51 +++++++++++++++---------
 grep.h                             | 22 ++++++++--
 object-file.c                      |  5 +++
 submodule-config.c                 |  5 ++-
 submodule.c                        | 25 +++++++++++-
 submodule.h                        |  8 ++++
 t/README                           | 10 +++++
 t/t7814-grep-recurse-submodules.sh |  3 ++
 11 files changed, 161 insertions(+), 55 deletions(-)

Range-diff against v2:
1:  5994a517e8 = 1:  5994a517e8 submodule: lazily add submodule ODBs as alternates
2:  31e9b914c4 = 2:  31e9b914c4 grep: use submodule-ODB-as-alternate lazy-addition
3:  aa3f1f3c89 = 3:  aa3f1f3c89 grep: typesafe versions of grep_source_init
4:  050deacfb7 = 4:  050deacfb7 grep: read submodule entry with explicit repo
5:  3f24815224 ! 5:  7d1eeac4b5 grep: allocate subrepos on heap
    @@ builtin/grep.c: static void work_done(struct work_item *w)
     +		repo_clear(repos_to_free[i]);
     +		free(repos_to_free[i]);
     +	}
    -+	free(repos_to_free);
    ++	FREE_AND_NULL(repos_to_free);
     +	repos_to_free_nr = 0;
     +	repos_to_free_alloc = 0;
     +}
6:  50c69a988b ! 6:  f362fc278c grep: add repository to OID grep sources
    @@ grep.h: struct grep_opt {
     +
     +	/*
     +	 * NEEDSWORK: See if we can remove this field, because the repository
    -+	 * should probably be per-source, not per-repo. This is potentially the
    -+	 * cause of at least one bug - "git grep" ignoring the textconv
    -+	 * attributes from submodules. See [1] for more information.
    ++	 * should probably be per-source. That is, grep.c functions using this
    ++	 * field should probably start using "repo" in "struct grep_source"
    ++	 * instead.
    ++	 *
    ++	 * This is potentially the cause of at least one bug - "git grep"
    ++	 * ignoring the textconv attributes from submodules. See [1] for more
    ++	 * information.
     +	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
     +	 */
      	struct repository *repo;
7:  94db10a4e5 ! 7:  8b86618531 submodule-config: pass repo upon blob config read
    @@ Commit message
         submodule's ODB as an alternate and then reading an object from
         the_repository.
     
    +    This makes the "grep --recurse-submodules with submodules without
    +    .gitmodules in the working tree" test in t7814 work when
    +    GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is true.
    +
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## config.c ##
    @@ config.c: int git_config_from_blob_oid(config_fn_t fn,
      				    const char *name,
      				    void *data)
      {
    -@@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
    + 	struct object_id oid;
      
    - 	if (get_oid(name, &oid) < 0)
    +-	if (get_oid(name, &oid) < 0)
    ++	if (repo_get_oid(repo, name, &oid) < 0)
      		return error(_("unable to resolve config blob '%s'"), name);
     -	return git_config_from_blob_oid(fn, name, &oid, data);
     +	return git_config_from_blob_oid(fn, name, repo, &oid, data);
8:  4a51fcfb77 = 8:  4b3176f99e t7814: show lack of alternate ODB-adding
-- 
2.33.0.rc1.237.g0d66db33f3-goog

