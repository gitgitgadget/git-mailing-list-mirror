Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BB39936E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117754; cv=none; b=Ki+7nvx/NKjshLNBA5V2LwbyVwA9WcVYqxW3DHQN8Jskam8Kr45o08aW31xbFQsUM5Hn1O0gQF9EZzn1BaC42LGojXHmTTJ/L/coef8JNtNYBSQ2lHuXnvwjQVEmNXQ1nc9iHavats0sPoU1XRsnHsllfYTdRRGLT+tPD81dcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117754; c=relaxed/simple;
	bh=ajIQ7m/vTyS4B3gCFZ94Z873y3h128WvfIpNfwYxdng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ+wkPpE7H2tCGyPidCH2KNqNwhmzo5z5HjX2R+gdv6VV242BvM2ERyTgE9q2Eby15uKZGz048jJxJCEamj0WUMq5O1avlJgw2k+Q8Qt/Ax8io1zmXc64uWOgv1AKR/yB2w3aMAC2TPMxuOKcxJ7MlmmvQK9bvZJwR0Iq6wvI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A870gI3X; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A870gI3X"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b28d7c729fso1204510b6e.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117752; x=1792722552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00jL7CUz/hsfrQdc86abNadDdQJOH3q3pk3pELwPyPc=;
        b=A870gI3XqpxS2qsjFw+/zt5qVXxeouYJciAkmwTmqB/h3+xe+NnSY5CmPGbjch8Xq6
         n+ftfBkwf9itGYDPTL4XgKTCaerV2n5UPfdVzFP1/HbQfxJSr7q/TdABXYuQMpVbCoUP
         smheigqtp7VJsXbcVMsM67UEZRgk/u0lVCNMQiwl71cf9xpjSoFKLbeU3sU/21/DUHot
         AC1i/F8/dPVCXWiymLWuaCOOwMj2eRCSMVtX7pIBbizP0fa7QaJsJbPGq56gc9TVW/cK
         8dBJwgYLCn7/XI0t/QaalhKkHXWhkaf9zx1YEndlb/T6eV0YojXuaT7Dbg4Ke6+uMMJO
         e9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117752; x=1792722552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00jL7CUz/hsfrQdc86abNadDdQJOH3q3pk3pELwPyPc=;
        b=aNBg9sY2BAqyeV1vUy+EgeADF5v0z7kQcfn0HTBHd28f/aXK8klzjKLUATXoerKaB9
         Bq3UCf1m3NJVDy8S+JP/cltYs76F6pMBglG50KAzRuZRzf8BpVRJX+GV/qA/6ybWF8m4
         Mmj8HTWRHuP99glsQG16RZHABDYvqXtbJtZmeH+k91LqlnQUKHgHEIiQMLmnGETWwlR2
         d6yUMgWumVDZyp54cgP+rr65727N4ABPmKdzm/exx4XuPZnxxhyeGjEPcCfcN+O8MYk7
         HkrcvYbDdUK0oa930dOSkMxDlrfGydYefhCqoVcaomWDQLl7CKo1ihRcISN6c26QRQdY
         Ppnw==
X-Gm-Message-State: AFq9FYJPty0HirfFks2U7bDwdGEgt/RpIC3zZzFcA3CTEjQm7teKjpOV
	IXkBqvS2HmS2lxTVeEWLpTnXSMhs2DbMS6N7RhUgNtq6fnUDhGlrWCr4uDGh+w==
X-Gm-Gg: AYBFou0hFJN/YZ/ts6PuGvQYpeG2vkYq52j+Avl/wuBBPlIn5Cf6O6ckZSztyDsbYCd
	jthLQ2Yx2FF2OVR8+oWqMh4CgDmIUfxBQzgWgp4+9G9RcprViWBDCxBFyj2J40LDUKlNXJvNHoC
	dzi2MmFLU2CtxZzDZhrzgoLTbixyHI/v7rb9gtOMES48nQ0rQy/GuwLjqFeuuI+kln6AWPhawWu
	fx63lOrU0kYW2/VfK9ujQOs6a7Xtden7p6FBw1UCK/ATOpUZzse4oeT+AVt9LTvSJlu9p90xRgI
	XEG8Z1IBOzbLFGcrkhVyIQzYjtBG4toy+9vjzC5Uima/OLIkbKe0iaqdEYD5s7vxx72ttl59Gh2
	zntWCwNkGtZpBzkg1RSa7gIvqLu+01w/bEh7GaNlDtpX/c2RUB3SjXFD35NJyT/tMABgl/E7VHv
	Ioc/+vcCj43fS6NkgmRGLeKFQmqf26k/cqNyDjL71HZvTrnTgTSRjtZw/2NNPg82MuDF7KRPPG0
	yDvFu7ksMBEpDa/rHNKrHz6i3+P0YTdlj2KWQ==
X-Received: by 2002:a05:6808:4fde:b0:4fb:a7f3:420d with SMTP id 5614622812f47-50c57696145mr19600473b6e.48.1792117752040;
        Thu, 15 Oct 2026 19:29:12 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572a9sm506284b6e.4.2026.10.15.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:29:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Qin ShiCheng <qeesung@live.com>
Subject: [PATCH 3/3] object-file: write ".keep" lockfiles during transaction commit
Date: Thu, 15 Oct 2026 21:29:01 -0500
Message-ID: <20261016022901.3838402-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20261016022901.3838402-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" ODB backend writes a ".keep" lockfile into the transaction
quarantine directory via `odb_transaction_files_write_pack()`. When the
ODB transaction is committed, the ".keep" lockfile is migrated to the
primary ODB alongside its packfile. Writing the temporary lockfile in
this manner has a couple of downsides:

  - Failing to migrate the lockfile during transaction commit due to a
    concurrent process already acquiring the same lock still allows the
    rest of the transaction to be migrated into the primary ODB. This
    dirties the primary ODB with new objects even though no references
    were updated and the operation failed.

  - Even more concerning, the ".keep" tempfile atexit(3) handler tries
    to remove any lockfile of the same name regardless of whether it was
    created by the same process. If the ".keep" lockfile of the same
    name for a concurrent process gets deleted prematurely, its packfile
    becomes at risk of being deleted by concurrent housekeeping.

Stop creating/registering the temporary lockfiles when writing the
packfile to the transaction and instead do so when committing the
transaction. This ensures the lockfile is properly acquired prior to
migrating objects and that only the owning process can delete its own
lockfiles.

Reported-by: Qin ShiCheng <qeesung@live.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c              | 76 +++++++++++++++++++++-----------------
 t/t5547-push-quarantine.sh | 29 +++++++++++++--
 2 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/object-file.c b/object-file.c
index ebe46d35de..39e6299be1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -492,6 +492,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 	const char *prefix;
 
+	struct strvec pack_names;
 	struct tempfile **pack_lockfiles;
 	size_t pack_lockfiles_nr;
 	size_t pack_lockfiles_alloc;
@@ -1257,7 +1258,7 @@ int read_loose_object(struct repository *repo,
 }
 
 static int write_pack_lock(struct odb_source *source, const char *pack_name,
-			   const char *keep_msg)
+			   const char *keep_msg, struct tempfile **out)
 {
 	struct strbuf lock_path = STRBUF_INIT;
 	struct strbuf contents = STRBUF_INIT;
@@ -1284,6 +1285,7 @@ static int write_pack_lock(struct odb_source *source, const char *pack_name,
 		goto out;
 	}
 
+	*out = register_tempfile(lock_path.buf);
 	ret = 0;
 
 out:
@@ -1293,6 +1295,40 @@ static int write_pack_lock(struct odb_source *source, const char *pack_name,
 	return ret;
 }
 
+static int write_pack_locks(struct odb_transaction_files *transaction)
+{
+	struct strbuf keep_msg = STRBUF_INIT;
+	char hostname[HOST_NAME_MAX + 1];
+	int ret = 0;
+
+	if (!transaction->pack_names.nr)
+		return 0;
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+		    (uintmax_t)getpid(), hostname);
+
+	for (size_t i = 0; i < transaction->pack_names.nr; i++) {
+		struct tempfile *lock;
+
+		ret = write_pack_lock(transaction->base.source,
+				      transaction->pack_names.v[i],
+				      keep_msg.buf, &lock);
+		if (ret < 0)
+			break;
+
+		ALLOC_GROW(transaction->pack_lockfiles,
+			   transaction->pack_lockfiles_nr + 1,
+			   transaction->pack_lockfiles_alloc);
+		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] = lock;
+	}
+
+	strbuf_release(&keep_msg);
+
+	return ret;
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1321,6 +1357,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		delete_tempfile(&temp);
 		strbuf_release(&temp_path);
 
+		if (write_pack_locks(transaction))
+			return error(_("unable to lock packfiles"));
+
 		/*
 		 * Make the object files visible in the primary ODB after their data is
 		 * fully durable.
@@ -1426,18 +1465,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 	} else {
-		struct strbuf final_path = STRBUF_INIT;
 		struct strbuf pack_name = STRBUF_INIT;
-		struct strbuf keep_msg = STRBUF_INIT;
-		char hostname[HOST_NAME_MAX + 1];
 		int ret;
 
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
-		if (xgethostname(hostname, sizeof(hostname)))
-			xsnprintf(hostname, sizeof(hostname), "localhost");
-
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
 		if (err_fd)
@@ -1477,37 +1510,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
-			    (uintmax_t)getpid(), hostname);
-
-		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
-			strbuf_release(&pack_name);
-			strbuf_release(&keep_msg);
-			strbuf_addstr(err_msg, "lockfile write failed");
-			return -1;
-		}
-
-		ALLOC_GROW(transaction->pack_lockfiles,
-			   transaction->pack_lockfiles_nr + 1,
-			   transaction->pack_lockfiles_alloc);
-
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
-			    base->source->path, pack_name.buf);
-		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-			register_tempfile(final_path.buf);
+		strvec_push(&transaction->pack_names, pack_name.buf);
 
 		odb_source_prepare(transaction->quarantine,
 				   ODB_PREPARE_FLUSH_CACHES);
 
-		strbuf_release(&final_path);
 		strbuf_release(&pack_name);
-		strbuf_release(&keep_msg);
 	}
 
 	return 0;
@@ -1523,6 +1531,7 @@ static int odb_transaction_files_finalize(struct odb_transaction *base)
 		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
 
 	free(transaction->pack_lockfiles);
+	strvec_clear(&transaction->pack_names);
 
 	return ret;
 }
@@ -1555,6 +1564,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
 	transaction->flags = flags;
+	strvec_init(&transaction->pack_names);
 
 	transaction->prefix = "bulk-fsync";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1b7097179e..cf349eee2c 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -77,10 +77,9 @@ test_expect_success '.keep file is removed after push' '
 	git -C keep.git config set receive.unpackLimit 0 &&
 
 	# While incoming objects are still quarantined, validate that the
-	# ".keep" lockfile is present in the quarantine directory.
+	# ".keep" lockfile is not present in the quarantine directory.
 	test_hook -C keep.git pre-receive <<-\EOF &&
-	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
-	test -f "$keep"
+	test ! -e "$GIT_QUARANTINE_PATH"/pack/pack-*.keep
 	EOF
 
 	# After quarantined objects are migrated, validate that the ".keep"
@@ -101,4 +100,28 @@ test_expect_success '.keep file is removed after push' '
 	test_path_is_missing "$keep"
 '
 
+test_expect_success '.keep file created outside of process is not removed' '
+	test_when_finished rm -rf keep.git &&
+	git init --bare keep.git &&
+
+	git -C keep.git config set receive.unpackLimit 0 &&
+
+	# Create a ".keep" lockfile matching the packfile to simulate a
+	# concurrent git-receive-pack(1) that was already written its lockfile.
+	test_hook -C keep.git pre-receive <<-\EOF &&
+	pack="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.pack)" &&
+	pack="${pack##*/}" &&
+	echo "baz" >"objects/pack/${pack%.pack}.keep"
+	EOF
+
+	test_commit bar &&
+	test_must_fail git push keep.git HEAD &&
+
+	# The ".keep" lockfile of the concurrent git-receive-pack(1) should be
+	# left in its place.
+	keep="$(ls keep.git/objects/pack/pack-*.keep)" &&
+	test_path_is_file "$keep" &&
+	test_grep "baz" "$keep"
+'
+
 test_done
-- 
2.55.0.424.g13c7afec21

