Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E36C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 23:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B922076A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 23:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8gbiZjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbgDOXaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:30:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50399 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgDOX3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 19:29:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 373FAC7956;
        Wed, 15 Apr 2020 19:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yzYkqGfqRtLUrx6QAs77Mp0FbEo=; b=V8gbiZ
        jl4TfRgDYU3Kz2YeYk5cZYy4zpZzVcHZlWS407u1B12t4GhP8IGaXN0fSjmmiswo
        elTK31O8pMK5s2tgdfoXh/ehcehKnh9yMB6g1NFx4UtCqYk7D4BP5E+780Z7OOHp
        5T+ovECDc04kJ6SKtK329z5pG9oxSqbeFRJBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y7OhAcaj+IZ9e4yq4/OZZGEpktFNC7ZT
        SNNS/nsinzC4qDt3oT2leHlrhK65xDUBrpLyRPZCDDVBLb7tWCx9dttCMR+77EbP
        TmyMHz0DvZi/eTkpbb9VhCdQZggzjc4PYLJPZlmT7sQ5AeFCyPbQqBeaC9EU9F0f
        KU/wunLAWmE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C445C7955;
        Wed, 15 Apr 2020 19:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63D8CC7952;
        Wed, 15 Apr 2020 19:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v8 0/9] Reftable support git-core
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 16:29:33 -0700
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 01 Apr 2020 11:28:49
        +0000")
Message-ID: <xmqqmu7c49b6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7890D2C-7F70-11EA-A0F5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend.

Since I queued the topic to 'pu', I needed to apply these fix-up
patches on top.  The change to the Makefile is about "make clean"
which forgot to clean the reftable library.  All the rest are ws
clean-ups.

There are build breakages reported on Windows, with possible fixes
(which IIRC were reported to segfault X-<), but I do not have URL or
message-IDs handy.

Thanks.


 Makefile            | 2 +-
 builtin/clone.c     | 2 +-
 builtin/init-db.c   | 4 ++--
 cache.h             | 2 +-
 reftable/reftable.h | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 9c1a7f0b81..3d5a585d8f 100644
--- a/Makefile
+++ b/Makefile
@@ -3126,7 +3126,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
diff --git a/builtin/clone.c b/builtin/clone.c
index 3bead96e44..54b1441b95 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1110,7 +1110,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template,
-                GIT_HASH_UNKNOWN,
+		GIT_HASH_UNKNOWN,
 		DEFAULT_REF_STORAGE, /* XXX */
 		INIT_DB_QUIET);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 888b421338..70645a1848 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -394,7 +394,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash, const char *ref_storage_format,
-            unsigned int flags)
+	    unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -433,7 +433,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format(&repo_fmt);
-        repo_fmt.ref_storage = xstrdup(ref_storage_format);
+	repo_fmt.ref_storage = xstrdup(ref_storage_format);
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
diff --git a/cache.h b/cache.h
index 83c4908ba0..89e257b7a5 100644
--- a/cache.h
+++ b/cache.h
@@ -628,7 +628,7 @@ int path_inside_repo(const char *prefix, const char *path);
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-            const char *ref_storage_format,
+	    const char *ref_storage_format,
 	    unsigned int flags);
 void initialize_repository_version(int hash_algo, const char *ref_storage_format);
 
diff --git a/reftable/reftable.h b/reftable/reftable.h
index 48722428b5..3086884be4 100644
--- a/reftable/reftable.h
+++ b/reftable/reftable.h
@@ -446,13 +446,13 @@ struct reftable_addition;
 /*
   returns a new transaction to add reftables to the given stack. As a side
   effect, the ref database is locked.
-*/ 
+*/
 int reftable_stack_new_addition(struct reftable_addition **dest, struct reftable_stack *st);
 
-/* Adds a reftable to transaction. */ 
+/* Adds a reftable to transaction. */
 int reftable_addition_add(struct reftable_addition *add,
-                          int (*write_table)(struct reftable_writer *wr, void *arg),
-                          void *arg);
+			  int (*write_table)(struct reftable_writer *wr, void *arg),
+			  void *arg);
 
 /* Commits the transaction, releasing the lock. */
 int reftable_addition_commit(struct reftable_addition *add);
