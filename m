Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B2C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF366109D
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhHMVF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHMVFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:05:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB73C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m4-20020a170902db04b029012d5b1d78d5so6843598plx.15
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UraMEISs3uBZz+u8u5vb1Wb0gohFJ3IWo58BN6nY9nQ=;
        b=VXnHhS2Jj/c036TXl6STso1t38ODoDYuIv6hWYrNXkgb94fgwkF/2+/pNKwspK0Zps
         Mu6TOmq88SyzqSkXbI+gFL0TTfJS6hMXsj15qYoPGW1zYDt9DZMeCvEMSwBNwxzBFX5r
         HYQCjyVsfEHVUeQZ5FK1FZ5JkmF1933Mmk1bmyEPmwFwxh+KOYRuWwL2LqaJg1V1bHYh
         5tKiV1u3TbdHjeNHnZ8QuJ5Ya5qeUea6tu6NR3KUrw4narbn2HPIKd8HmE/86D8EAxhH
         k+63IJU5l3m8yZrsd8D88tsAFKCRSJEicSnKfxBB8rYpTFNE4pVW31Du9BLWLMw40Tz2
         p5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UraMEISs3uBZz+u8u5vb1Wb0gohFJ3IWo58BN6nY9nQ=;
        b=BJXxCoCW/b4y3bAkdQZRz+fH2dhYVhGyiZYgktCgEmiGMbzUimef7XJ/1jQmyz4qKG
         Pz3GV2BsGrFmye5yrYhYzAy6g3MZ/uLWdW8XgfokxmETRJhBkrfHZep7J7OUR2IIUd2s
         jPkRm8ZXRkAvd3zDqx/9c0rK6ct3Po63zvDUvg4ByLfOGNxu+tzLUES5uxtZsnDYvJl/
         LjBNt0Z/HK8FzhNMboA6Aki4aVgzwaoB/hB5GYzhV79o+EYf/eLGo4dimR/GUMo5GOOi
         OuWnUtqTR8vPn57zSCcaXnVleRszss6PhcYo3Uvh4Em0ixayxczr4faPl71XdTIWLMUD
         E/gQ==
X-Gm-Message-State: AOAM531em4fFRiVMQIXn1qpnOvuGdUDRcWsrTRql1gnEruYDYInvrjAr
        uq6lb+r3RQvhb2RgHjZeG7HWQEzYivAzXNUpYjyuBEX7jhPo/4WFQ4PH47BaPbnL5inzv6FDaCv
        OWM8WzVW9WdNVFZuFF0qXSiRSexsmFhd3C96AkFVxdpKyire+1K3UJ/ONB9gPRVlVZsZYUNK02H
        r3
X-Google-Smtp-Source: ABdhPJxL8Bm56mxJBRu5JuoM3aby6D+Z+O24wI6IvVc07YnzYpU5O89DxhvchtoGcxeLdlSvKPwgiBV0fZSe9UpiFsQG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:94ac:0:b0:3e0:f21a:e6ff with
 SMTP id a12-20020aa794ac000000b003e0f21ae6ffmr4144655pfl.76.1628888727227;
 Fri, 13 Aug 2021 14:05:27 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:15 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <cover.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 0/8] In grep, no adding submodule ODB as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your reviews. I believe I've addressed all of them.

The main change is that I've also made a change in submodule-config to
avoid registering submodule ODBs as alternates (thanks, Matheus, for
noticing this).

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
 config.c                           | 18 ++++++---
 config.h                           |  3 ++
 grep.c                             | 51 +++++++++++++++---------
 grep.h                             | 18 +++++++--
 object-file.c                      |  5 +++
 submodule-config.c                 |  5 ++-
 submodule.c                        | 25 +++++++++++-
 submodule.h                        |  8 ++++
 t/README                           | 10 +++++
 t/t7814-grep-recurse-submodules.sh |  3 ++
 11 files changed, 156 insertions(+), 54 deletions(-)

Range-diff against v1:
1:  5994a517e8 = 1:  5994a517e8 submodule: lazily add submodule ODBs as alternates
2:  31e9b914c4 = 2:  31e9b914c4 grep: use submodule-ODB-as-alternate lazy-addition
3:  e5e6a0dc1e ! 3:  aa3f1f3c89 grep: typesafe versions of grep_source_init
    @@ builtin/grep.c: static int grep_file(struct grep_opt *opt, const char *filename)
      	if (num_threads > 1) {
     
      ## grep.c ##
    -@@ grep.c: int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
    +@@ grep.c: int grep_source(struct grep_opt *opt, struct grep_source *gs)
    + 	return grep_source_1(opt, gs, 0);
    + }
    + 
    ++static void grep_source_init_buf(struct grep_source *gs, char *buf,
    ++				 unsigned long size)
    ++{
    ++	gs->type = GREP_SOURCE_BUF;
    ++	gs->name = NULL;
    ++	gs->path = NULL;
    ++	gs->buf = buf;
    ++	gs->size = size;
    ++	gs->driver = NULL;
    ++	gs->identifier = NULL;
    ++}
    ++
    + int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
    + {
      	struct grep_source gs;
      	int r;
      
     -	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
    -+	grep_source_init_buf(&gs);
    - 	gs.buf = buf;
    - 	gs.size = size;
    +-	gs.buf = buf;
    +-	gs.size = size;
    ++	grep_source_init_buf(&gs, buf, size);
    + 
    + 	r = grep_source(opt, &gs);
      
     @@ grep.c: int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
      	return r;
    @@ grep.c: int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
     +	gs->size = 0;
     +	gs->driver = NULL;
     +	gs->identifier = oiddup(oid);
    -+}
    -+
    -+void grep_source_init_buf(struct grep_source *gs)
    -+{
    -+	gs->type = GREP_SOURCE_BUF;
    -+	gs->name = NULL;
    -+	gs->path = NULL;
    -+	gs->buf = NULL;
    -+	gs->size = 0;
    -+	gs->driver = NULL;
    -+	gs->identifier = NULL;
      }
      
      void grep_source_clear(struct grep_source *gs)
    @@ grep.h: struct grep_source {
     +			   const char *path);
     +void grep_source_init_oid(struct grep_source *gs, const char *name,
     +			  const char *path, const struct object_id *oid);
    -+void grep_source_init_buf(struct grep_source *gs);
      void grep_source_clear_data(struct grep_source *gs);
      void grep_source_clear(struct grep_source *gs);
      void grep_source_load_driver(struct grep_source *gs,
4:  30ead880b3 = 4:  050deacfb7 grep: read submodule entry with explicit repo
5:  f62608e88f ! 5:  3f24815224 grep: allocate subrepos on heap
    @@ builtin/grep.c: static void work_done(struct work_item *w)
     +		free(repos_to_free[i]);
     +	}
     +	free(repos_to_free);
    ++	repos_to_free_nr = 0;
    ++	repos_to_free_alloc = 0;
     +}
     +
      static void *run(void *arg)
6:  b2df245587 ! 6:  50c69a988b grep: add repository to OID grep sources
    @@ builtin/grep.c: static int grep_oid(struct grep_opt *opt, const struct object_id
      	strbuf_release(&pathbuf);
      
      	if (num_threads > 1) {
    +@@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
    + 	repo_read_gitmodules(subrepo, 0);
    + 
    + 	/*
    +-	 * NEEDSWORK: This adds the submodule's object directory to the list of
    +-	 * alternates for the single in-memory object store.  This has some bad
    +-	 * consequences for memory (processed objects will never be freed) and
    +-	 * performance (this increases the number of pack files git has to pay
    +-	 * attention to, to the sum of the number of pack files in all the
    +-	 * repositories processed so far).  This can be removed once the object
    +-	 * store is no longer global and instead is a member of the repository
    +-	 * object.
    ++	 * All code paths tested by test code no longer need submodule ODBs to
    ++	 * be added as alternates, but add it to the list just in case.
    ++	 * Submodule ODBs added through add_submodule_odb_by_path() will be
    ++	 * lazily registered as alternates when needed (and except in an
    ++	 * unexpected code interaction, it won't be needed).
    + 	 */
    + 	add_submodule_odb_by_path(subrepo->objects->odb->path);
    + 	obj_read_unlock();
     
      ## grep.c ##
     @@ grep.c: void grep_source_init_file(struct grep_source *gs, const char *name,
    @@ grep.c: void grep_source_init_oid(struct grep_source *gs, const char *name,
     +	gs->repo = repo;
      }
      
    - void grep_source_init_buf(struct grep_source *gs)
    + void grep_source_clear(struct grep_source *gs)
     @@ grep.c: static int grep_source_load_oid(struct grep_source *gs)
      {
      	enum object_type type;
    @@ grep.c: static int grep_source_load_oid(struct grep_source *gs)
      			     gs->name,
     
      ## grep.h ##
    +@@ grep.h: struct grep_opt {
    + 	struct grep_pat *header_list;
    + 	struct grep_pat **header_tail;
    + 	struct grep_expr *pattern_expression;
    ++
    ++	/*
    ++	 * NEEDSWORK: See if we can remove this field, because the repository
    ++	 * should probably be per-source, not per-repo. This is potentially the
    ++	 * cause of at least one bug - "git grep" ignoring the textconv
    ++	 * attributes from submodules. See [1] for more information.
    ++	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
    ++	 */
    + 	struct repository *repo;
    ++
    + 	const char *prefix;
    + 	int prefix_length;
    + 	regex_t regexp;
     @@ grep.h: struct grep_source {
      		GREP_SOURCE_BUF,
      	} type;
    @@ grep.h: struct grep_source {
     -			  const char *path, const struct object_id *oid);
     +			  const char *path, const struct object_id *oid,
     +			  struct repository *repo);
    - void grep_source_init_buf(struct grep_source *gs);
      void grep_source_clear_data(struct grep_source *gs);
      void grep_source_clear(struct grep_source *gs);
    + void grep_source_load_driver(struct grep_source *gs,
-:  ---------- > 7:  94db10a4e5 submodule-config: pass repo upon blob config read
7:  f1fc89894b = 8:  4a51fcfb77 t7814: show lack of alternate ODB-adding
-- 
2.33.0.rc1.237.g0d66db33f3-goog

