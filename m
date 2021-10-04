Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77633C4332F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAF9613CF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhJDQ7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbhJDQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151ACC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o20so13935194wro.3
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RM2kaD4zPcEkoFHN9UJthugd2LTz0cfzsm58mTjVpOw=;
        b=FHa3Ihb3WyWkqL7zpJUfdRpxCJSyCt3vAv0eIhkC6Lr09zAYB3DVSqUQb2p2r0Lv2m
         42s7Gt6DskEo5T8eM6HRzlBmioBYjZy/N/2wgp8MXjDtcQVuzmCFOmjZ7qY4Md9R8R8r
         Nw1spDMf2YCxfnQ0N4TcFy/T5eIMSlkV6vrNYkegpnN8UZROkKz9oqfmFQ5kmvdNRrhV
         hMwjhTQ48luJ5Rms3KlzmiRMOxZoIcaWySKNx7MPtS7qIQhZLEpD5UNDWk36bobUydGN
         w8tXqWu76ejla9jh17iafxyXUeK9Y6G4Q0jt2bmq+cQevul6D8yGV9y87J3PHrmus0/6
         cKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RM2kaD4zPcEkoFHN9UJthugd2LTz0cfzsm58mTjVpOw=;
        b=koGYdFgQ2Yx6TuTb9X1hpW/uv6PrhEotXoX6ZQ1opQ9dggSHa30dVMNqweocNl0kbo
         vCypM/AsbR4urfOncXPtTWst+6IoNjVBV3BH50rCKdPIpkgArBwuQWNI1ya1P7hG9uSH
         WKou2KW8AcZYWYdN4+Pwc8IFgg3Ih6GXwR+NNNnkrYxwU8uissw4W1rwIqBz7o/bS+95
         idH5diMbtH3ooh8uvBUFu9v1O0wY6TlFbvoQm1cXv4zbPPny5rOix0aJmv0Z9XBlemBH
         0OFqoA2njgjJuzTVHSi3z8xs4TizUUes6XEdgjfc980l62AEstofMiwif0vyr/JfDdiF
         gRUA==
X-Gm-Message-State: AOAM531PZT5Xkx4eWBn1QI5axWxVuz/yavYPejPAdhZf7bLxqzX0g2DA
        jRA6mWtWkF1DpAeKMCk3bHYY/gki2aE=
X-Google-Smtp-Source: ABdhPJz+1kDDy2vD9HPh3pP4bCLZbMK/6teVLW4GfW7BGtBjyoW2luNeWWJ7TARro43bLI4Szx+9AA==
X-Received: by 2002:adf:bd8a:: with SMTP id l10mr4221728wrh.159.1633366670722;
        Mon, 04 Oct 2021 09:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21sm14666949wmk.10.2021.10.04.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:50 -0700 (PDT)
Message-Id: <bc08513734099decc96e7e4d8747e6e93aa435c6.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:40 +0000
Subject: [PATCH v8 2/9] tmp-objdir: disable ref updates when replacing the
 primary odb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When creating a subprocess with a temporary ODB, we set the
GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
to update refs, since the tmp-objdir may go away.

Introduce a similar mechanism for in-process temporary ODBs when
we call tmp_objdir_replace_primary_odb. Now both mechanisms set
the disable_ref_updates flag on the odb, which is queried by
the ref_transaction_prepare function.

Note: This change adds an assumption that the state of
the_repository is relevant for any ref transaction that might
be initiated. Unwinding this assumption should be straightforward
by saving the relevant repository to query in the transaction or
the ref_store.

Peff's test case was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden. See the call to notes_cache_put in
fill_textconv where errors are ignored.

Reported-by: Jeff King <peff@peff.net>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 environment.c  | 4 ++++
 object-file.c  | 6 ++++++
 object-store.h | 9 ++++++++-
 refs.c         | 2 +-
 repository.c   | 2 ++
 repository.h   | 1 +
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index b4ba4fa22db..46ec5072c05 100644
--- a/environment.c
+++ b/environment.c
@@ -176,6 +176,10 @@ void setup_git_env(const char *git_dir)
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		args.disable_ref_updates = 1;
+	}
+
 	repo_set_gitdir(the_repository, git_dir, &args);
 	strvec_clear(&to_free);
 
diff --git a/object-file.c b/object-file.c
index 990381abee5..f16441afb93 100644
--- a/object-file.c
+++ b/object-file.c
@@ -767,6 +767,12 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 */
 	new_odb = xcalloc(1, sizeof(*new_odb));
 	new_odb->path = xstrdup(dir);
+
+	/*
+	 * Disable ref updates while a temporary odb is active, since
+	 * the objects in the database may roll back.
+	 */
+	new_odb->disable_ref_updates = 1;
 	new_odb->will_destroy = will_destroy;
 	new_odb->next = the_repository->objects->odb;
 	the_repository->objects->odb = new_odb;
diff --git a/object-store.h b/object-store.h
index 74b1b5872a6..bd53bdf2f2e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,10 +27,17 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This is a temporary object store created by the tmp_objdir
+	 * facility. Disable ref updates since the objects in the store
+	 * might be discarded on rollback.
+	 */
+	unsigned int disable_ref_updates : 1;
+
 	/*
 	 * This object store is ephemeral, so there is no need to fsync.
 	 */
-	int will_destroy;
+	unsigned int will_destroy : 1;
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
diff --git a/refs.c b/refs.c
index 8b9f7c3a80a..7c182607dcf 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,7 +2126,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+	if (the_repository->objects->odb->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index 710a3b4bf87..18e0526da01 100644
--- a/repository.c
+++ b/repository.c
@@ -80,6 +80,8 @@ void repo_set_gitdir(struct repository *repo,
 	expand_base_dir(&repo->objects->odb->path, o->object_dir,
 			repo->commondir, "objects");
 
+	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
diff --git a/repository.h b/repository.h
index 3740c93bc0f..77316367d99 100644
--- a/repository.h
+++ b/repository.h
@@ -162,6 +162,7 @@ struct set_gitdir_args {
 	const char *graft_file;
 	const char *index_file;
 	const char *alternate_db;
+	int disable_ref_updates;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
-- 
gitgitgadget

