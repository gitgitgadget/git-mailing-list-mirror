Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF632376BC2
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376887; cv=none; b=KGltakn8oWrPUsmjnnvMXK+GjhgRWOM9pW0pjMhJ0DjZ/GNgtfhOiuj2YqCW1NUQ55tUumQ60PUOFVmvuLqk8uRiunBy9u9t6aG3amu6k6W64BOYXMfVIVUlN1ztJJJcgkSUExsYTIuIx7ZVf3dl5O2il6iAM/eIOIvf/dAr/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376887; c=relaxed/simple;
	bh=mXeUwRR+zKhyUYeDKpK2DlYXTh0o+jQGmcb15BDfmt4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pB064T51Qy5HYOJDzUsno8/CiLJQAYeSAVyTAsxUF4wGeyLTHyBNsHXvauWsGHri3qnCYyyRF1Ga7V0E6flQLNK0e1BKEevXiBbDzU1NiuEjqpBFXsA3mOEaChbzPXho0Xh7gpCN9LQyOBIF0EdtINTkfeTE/C4FBUK/uvw3P0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdj8beJp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdj8beJp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12056277571so10074092c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376883; x=1768981683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c4Hi9VeW6Sch7oz86sYAybCT+hK00MonnSVesYMBPM=;
        b=Kdj8beJp+6sZX5TDJShVK6hGuKsXbuuJqtAOuoq5vc+lJoZZDf8YW7Ni4eZcUH5fcP
         topmsrmOetprvwZgawr3FkBtSBt7NVa3ym4QUnSx84qVzYf6YK1pO9QZtAUtxeoTsAAt
         2OjkEz64kbhVkf7XgT+kW9ZCi1r77xLdaegIkIbxdVmVL4Ch/SJavxXjQ2jQK7j/JYWn
         zS8XBQl39/YP021QS9bcEC2xVFY872HM5woGvO0vdaGpNAmv6NEqrj4oEgkqkVTMsbj3
         UmXXShtkEX51LUwfthYfkYOp0exZ+4LndwlL3DpXbYJUDa//rXzcu9DW7QtbHbGDk1N3
         APRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376883; x=1768981683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7c4Hi9VeW6Sch7oz86sYAybCT+hK00MonnSVesYMBPM=;
        b=uq2RbCXcY9pjgpvDPuWkD4ZgjZ9d5sZ2Ot8UBeVJB270M0nu3PBkR6+OY4BT+JSHD4
         rWHHYMiueHdRG2HVWmUAhGUaHeUmFbdpdxoavTefE9o0riB4F/onl54wOj38L2I5MfVj
         HYVj6zY9wBEw/3XTxnqp3sqVpbY0lBZJ01Ffk9n1xch48xG8cb0eR2VdPlG9CSok5arO
         b/cgF5MS0OHQAmiC7j7j14egeLJeKtpieTdqQkyAMSiwmWye+TcRf0gQSW6p2byAgTcl
         iAiqLdHUgUfvGibwqHYFSK54Eb9iUpEmHYS/FFZG2y9hTfkV3H6kHChE2AJYxDMTO9be
         kobQ==
X-Gm-Message-State: AOJu0YzSEhGEvt0AI4ZP2t5l/HhIY2+6vSrC6R2TS2zFd6Up0rN5vCGS
	OD2yoqPupyd3dAxRAeq4fAKjlxpc4QOUMTCmc1SQAfTuK7D83Mxzz8ppG2RLaQ==
X-Gm-Gg: AY/fxX6kwvHa4as8mGd99yffUnlVNMZX6KvZJ1BnMYzge4t28UU9PGoaelfz2tTDHhh
	L8HrwefwjHszGPplkWkIrXJrUGNdlUE6imIKhgmebbS4LJQvjNfpH8ThZe+4n5Wi9TEPu3ODQUW
	NkP3dV5qV3sWbhJ9IKUNAz8JYkVDOLCpzciUvr01UlpP/r6wWMKlDjTw2UId+pISZXFCfZhOHd3
	NPQCZP8EHvEFU1MVpAn/pjwv/VQwDCV3rj5Rt+JGAbFcHmfvNp/OZ86ATFCJI9ukbB9TyJeJ2H2
	sr7xBw/H88TmEXjEabzfk1KKA1kgH8voLPTw+IFVV6pwUy3Aoh27S8AP9sswtsv0N1o7Ds+gf4Y
	0iY2ak52mYD71bTeFPPZ4LSo7jSOBSEBnM4TsZkS8Oh4gYeEN/kROaK5PjFy/M/nhG1+deZGShi
	DzyI5ZkFOUm00tPMLmEVY70RE5
X-Received: by 2002:a05:7022:6287:b0:11e:3e9:3e9f with SMTP id a92af1059eb24-12336aa0407mr1842060c88.50.1768376882726;
        Tue, 13 Jan 2026 23:48:02 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm30338763c88.11.2026.01.13.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:02 -0800 (PST)
Message-Id: <d2b66286c23b5736949610c89b4d51e025307845.1768376879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:55 +0000
Subject: [PATCH v3 1/5] read-cache: update add_files_to_cache take param
 ignored_too
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The ignored_too parameter is added to the function
add_files_to_cache for usage of explicit updating the index for the updated
submodule using the explicit patchspec to the submodule.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 builtin/add.c      |  2 +-
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 read-cache-ll.h    |  2 +-
 read-cache.c       | 10 ++++++++--
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..eef4959ee3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -584,7 +584,7 @@ int cmd_add(int argc,
 	else
 		exit_status |= add_files_to_cache(repo, prefix,
 						  &pathspec, ps_matched,
-						  include_sparse, flags);
+						  include_sparse, flags, ignored_too);
 
 	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
 	    report_path_error(ps_matched, &pathspec))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..88d6a68022 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,7 +899,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					   0);
+					0, 0);
 			init_ui_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..1a00642090 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -455,7 +455,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, ps_matched, 0, 0);
+				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
 			exit(128);
 
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b49d9af4..2c8b4b21b1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -481,7 +481,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags);
+		       int include_sparse, int flags, int ignored_too );
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index 032480d0c7..0f4981d79f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3881,9 +3881,12 @@ void overlay_tree_on_index(struct index_state *istate,
 
 struct update_callback_data {
 	struct index_state *index;
+	struct repository *repo;
+	struct pathspec *pathspec;
 	int include_sparse;
 	int flags;
 	int add_errors;
+	int ignored_too;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3925,7 +3928,7 @@ static void update_callback(struct diff_queue_struct *q,
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_TYPE_CHANGED: {
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
@@ -3946,7 +3949,7 @@ static void update_callback(struct diff_queue_struct *q,
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
-		       int include_sparse, int flags)
+		       int include_sparse, int flags, int ignored_too )
 {
 	struct odb_transaction *transaction;
 	struct update_callback_data data;
@@ -3956,6 +3959,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.repo = repo;
+	data.ignored_too = ignored_too;
+	data.pathspec = (struct pathspec *)pathspec;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-- 
gitgitgadget

