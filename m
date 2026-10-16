Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC233DAAB3
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186653; cv=none; b=XfHYqBnnRExFl/j10C6iPPDdhpCtesuBrb0OQ89jC9PtlqGDSrOMey7y/oshcjyg0vcTMd8rnpi3K0DmLIe+1w+UCXJIVvZ8pNqncLqzKNc0JP5/46sk/uqICHaYCLL89bXBDoL6lBMdW5X2VVgDzC75S7DWrpRlkRiyfVD0Qtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186653; c=relaxed/simple;
	bh=tPewsMMqeLQ1lGySZVm5RVECL+7noTOQmfvzB/ninIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9S/lALQaQuJvbNd55YWJqJ2dUQga1oqgVsbFG7J3tajNvJhpKczU7oToiUCAmVRgVmpgFsMheE6z+rkNTSkoLchO8BCfdU14Pg7N11DTcjJG/nwfWGaiwvcOqKZgJWX1C7aon9Lh+QRAkLkOaOmxHxbbqA5+B1T/29k16pXQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcjak2M+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcjak2M+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-82478760557so183917a34.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186650; x=1792791450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+6Yq83A/wdhfoeyePpM5pHh/CeJYU+HOQTYcD29eWg=;
        b=bcjak2M+iLt0rKLBotWCRmvlzTi87BP/QIpbN5PvtW3y2H+UKQxOfXLW/lkcxPrvcr
         wfz2LiuvZzz9ZlO1bYEFolmc+JHbrhLRN4rbHD0Wsfkvx6MVdb032LA/DzWbYKBxug2Q
         C4IQY1j+amETrw85ZlFTzkWnmEjG11xeXrgFHt4/mzmVej7JYDv455AoWMxjce70ZiIg
         vrqT85QWF75U7w8DdskagVIhEnU/0pmBR70yaqpfgfzGT57syXu+5EyI7sTGmMSdshIL
         v7nIQn1hkQ11Th1fOTh2U4aB3eNVioOyqy8RpljPFAVxYp9OrtLRI+tKk96oocZXKVBv
         y2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186650; x=1792791450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+6Yq83A/wdhfoeyePpM5pHh/CeJYU+HOQTYcD29eWg=;
        b=RZqqc8JtB6f6MSbCmChleewXGwY8qJdIJfj+IckIJRg5WrggPpZza4zQma5zDdSwVw
         vD+qe46aS3A86b5Sz46gfyufy0RlqfR4Vmk0bSIfN567fkPSxKNDrTA4a9BUqvHCL2lJ
         RADFk66xZ4RZaVOvT3oQRHHr+KQCBCehU7IfxFb7i5oYoR83f6XRVojWz8Q7Aaqg3zXJ
         EnbNpbwP9ax1q/sC/+YpriPYwscoaoXKrn2Ao826rubsykRoyl6Gv6xRkDD8qyUp3woi
         6+sM9+e9zgvpEgKYNsp5ZK82uTQSeUI9FTUWl9BWkA4zD04BS1r0maoACHYQiqGw7NWN
         kXLw==
X-Gm-Message-State: AFq9FYK6UwEtFWARQt7bU0ZxJ+b4KV2Bwlj9liJOcyn5ZQiXjREPKbva
	bP2PeFtVK3eH0EbzdE0i+4oNxakP/K38HezhlQFq+7Vd4sVfPs38o1A6lpHJZQ==
X-Gm-Gg: AYBFou0qN+TYefS4mNu3FAe1aRGDDCQRxCy5Ar1/MDMdNFvdhZe25/z0dwL3E2OVZMa
	Q4lcn/VjuilaNcZRJSf9TDt96RHUgqwpWdlexe006tiMb1kjj6zC/qOoIsfpOzWX/qMr210yEVj
	1GJJLgYOw4oTzs7lLKZ+vHiaK8Su9alDoohsdpWa7NU+x+6cZN7NEz793Hr35yCNXRR1FM+7yv2
	Z/4gAb2d8pMxmhCYsLZEQuhLlAtukTzj/KUz59YO+IEePfLvLJ6Ctidu4a9YqVwFWt8rmhL5DyH
	l3gON1SCKS7NBTTNoGPeT9UD7/R4hpPQPsYuVexwBpqneSfbhKrA4iehaMQDHbv7Q6pggAxpoBK
	IwUqNp3kE2BwMxnZ/cI0bUxYaCBp6pQNJFrnn7g539OpzL98TRSvcqdgsYTsQ58f1N12A2VX7p9
	OwYcd3QA1LHZx8KFUFF981S7K57PoBOzP6Z/pAtwQHLdgArgiav3KfUtjG+JFPxD9fUsQlloeAo
	Xiv4KKme/X8gG8F4AmJsRtajXXIBUAW2QL98A==
X-Received: by 2002:a05:6820:200b:b0:6b1:a812:9871 with SMTP id 006d021491bc7-7035608e5b5mr626170eaf.18.1792186650187;
        Fri, 16 Oct 2026 14:37:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm834395a34.4.2026.10.16.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:37:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/4] object-file: explicitly write ".keep" lockfile
Date: Fri, 16 Oct 2026 16:37:15 -0500
Message-ID: <20261016213716.593278-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016213716.593278-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `odb_transaction_write_pack()` interface for the "files" backend
relies on git-index-pack(1) to write the specified packfile into an ODB
transaction as a packfile. To prevent a concurrent housekeeping
operation from deleting the newly written packfile prior to the
references being updated, a ".keep" lockfile is also generated by
git-index-pack(1) via the `--keep` option. Consequently, the ".keep"
lockfile is written into the ODB transaction alongside the packfile and
later migrated together to the primary ODB during transaction commit.

In a subsequent commit, writing the lockfile is deferred until
transaction commit and thus cannot rely on git-index-pack(1) to write
it. In preparation for this, update `odb_transaction_files_write_pack()`
to explicitly generate the same ".keep" lockfile itself.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 108 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index 210984f825..07a61c610a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1256,6 +1256,47 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
+static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
+			       const char *keep_msg)
+{
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
+	int ret = -1;
+	int fd;
+
+	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
+		    source->path, pack_name);
+	strbuf_addf(&contents, "%s\n", keep_msg);
+
+	fd = safe_create_file_with_leading_directories(source->odb->repo,
+						       lock_path.buf);
+	if (fd < 0) {
+		error_errno(_("unable to create '%s'"), lock_path.buf);
+		goto out;
+	}
+
+	if (write_in_full(fd, contents.buf, contents.len) < 0) {
+		error_errno(_("unable to write '%s'"), lock_path.buf);
+		close(fd);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	if (close(fd) < 0) {
+		error_errno(_("unable to close '%s'"), lock_path.buf);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&lock_path);
+	strbuf_release(&contents);
+
+	return ret;
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1348,9 +1389,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		container_of(base, struct odb_transaction_files, base);
 	struct repository *repo = base->source->odb->repo;
 	struct child_process child = CHILD_PROCESS_INIT;
+	struct strbuf final_path = STRBUF_INIT;
+	struct strbuf pack_name = STRBUF_INIT;
+	struct strbuf keep_msg = STRBUF_INIT;
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
+	int ret = -1;
 	int status;
 
 	hdr_err = parse_pack_header(&hdr, pack_fd);
@@ -1390,17 +1435,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		}
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
 
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
 
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
@@ -1424,34 +1464,58 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		lockfile = index_pack_lockfile(base->source, child.out, NULL);
-		if (lockfile) {
-			ALLOC_GROW(transaction->pack_lockfiles,
-				   transaction->pack_lockfiles_nr + 1,
-				   transaction->pack_lockfiles_alloc);
-			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-				register_tempfile(lockfile);
-			free(lockfile);
-		}
+		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
+
 		close(child.out);
 
 		status = finish_command(&child);
 		if (status) {
 			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			return -1;
+			goto out;
+		}
+
+		if (ret) {
+			strbuf_addstr(err_msg, "index-pack failed to report pack name");
+			goto out;
 		}
 
+		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+			    (uintmax_t)getpid(), hostname);
+
+		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
+					keep_msg.buf)) {
+			strbuf_addstr(err_msg, "lockfile write failed");
+			goto out;
+		}
+
+		ALLOC_GROW(transaction->pack_lockfiles,
+			   transaction->pack_lockfiles_nr + 1,
+			   transaction->pack_lockfiles_alloc);
+
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
+			    base->source->path, pack_name.buf);
+		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
+			register_tempfile(final_path.buf);
+
 		odb_source_prepare(transaction->quarantine,
 				   ODB_PREPARE_FLUSH_CACHES);
+
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	strbuf_release(&final_path);
+	strbuf_release(&pack_name);
+	strbuf_release(&keep_msg);
+
+	return ret;
 }
 
 static int odb_transaction_files_finalize(struct odb_transaction *base)
-- 
2.56.0.173.gf57c9a7388

