Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F9423A65
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103467; cv=none; b=qNYm80nKUw+pV1toJVoyz+G4iwcnAKV+sSHOfCGZm/BXjLPyOBJ6+jPlFzrosEy7k8P5r0tzABj2GwLcozjJC7Pfs+qlWlNAlclt8WQWqzdi9RPjSyNzpB7hzJP1zYFPJv8FDMSyyTYHLV9Gjot/FMqP3AiuCyDnuykJFmyVAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103467; c=relaxed/simple;
	bh=iVOjyAtshQ+fLrSMIFOCxDVMBVuLZIJYphFgxrM06Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSmbwEpCIgb5dOa3+nAQTNvyKBqrPcQUq1jSAWQEG2ItWJZGqZWi/tNH5iSf/P5VYz7nv8JO+3QbplTfZEedwhXdLin2LVhDk/njj7ilvO0KBBcps4Gx1u65JfbXBy97n3Bav5QmDP087q92w4aaW/7A8O8iFbVhvABubaDKod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MXBhzp4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNNy2JGg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MXBhzp4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNNy2JGg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 133ACEC00E0;
	Wed, 10 Jun 2026 10:57:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 10:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103465;
	 x=1781189865; bh=acktvavx2TjUto/AcgfQxs9O12KPshMufHwJGyxkQBI=; b=
	MXBhzp4z+aom/HHWgypVyjgmFad7fP6XQvkkCbWKRrBX6+rFiAgf8NfqKT2qNlWE
	F90VKg2+vHRxbNnhL7rvfOPZuVqs0r6sTxvDsXwehJHymF3unIxSWk7shnPQ0Yks
	Hr7+JNYcVNQoDwDkH96yUFEm8I7iAVQd5aJgAMCbV9idy5/R3mdH+LRqocrHiiU5
	aDIoZvyoIM/emOzBzLjjFK8X8OxPlccqpx+T3CRLFjwC+ga/7sOiAT1C3uQY2ya6
	oLPR/5Ou8LC9w+1b09EOoYxOxgSxvPoxfPRUkWimkC2tO2l2abRpWTijHinilRAc
	fP9bxZoiJQBuQy/tu1qM9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103465; x=
	1781189865; bh=acktvavx2TjUto/AcgfQxs9O12KPshMufHwJGyxkQBI=; b=L
	NNy2JGgwUCAFOLCS61BQuK1FIFOnzldv4jxCkE7e9iDNTKqrimfFIydvM2H1W4zT
	XpBaBrhRz6UKDkeQwK5sP3cuokfHnpR9l1rkaXfGQEtcvQ/uPPwYHVdVYNOQsWbx
	8OR6yshhwPxMq8o9okX9zh89aWHBZj1RJUreZgsRrlc4U+th/QzYajF/pinzJAoJ
	zFE2qKprAddp7OVkM/8upg5pUm9DVNlsh+M0ashLC/FxgjDIUwmRfva7FDOOdCk2
	+r5cQtgXvin8oYYM6tPnZtaw+4by2c8CF1xGqz49K20l/nRKnyJ1JKG2dDPDWd7q
	TsHeABH6YDKAnBZ2YYETw==
X-ME-Sender: <xms:aHspatpyVlgaU4i_O1NpbB4UO3_kVoq1LLG_nkncyBnSTVaxt2q58w>
    <xme:aHspalpiig1XQG8p4tGui3LbFTUOw7IWB9RO4GumUEQlFo84-AwYoUiwt-kch0-Fl
    kd1fHfokxshZC2M2MpdKmUoebdrLfxnBHIka3nFsV0ni_p4sGTUNus>
X-ME-Received: <xmr:aHspan2yiQPyxOQrCMTxAAhqFte8YoxtMwdsEES3gFk6F5NQz5ijz8YW0-OIG9_D-vUwKq3Mcev8f3U7J0lpQ-qy_JzoS6mBCnAY03hOXg>
X-ME-Proxy-Cause: dmFkZTEJn+HOU7rfleF8wtEqd8n463JF/vFO1XgyixYBoTlaS7cpi00RU70QgROPWwUdI8
    Y2g43EXoqSDarANLeg/qY2LquMRGd0tg55WNrjpoPOxekNmdm0CiNmfLlAe8VSeyDVX037
    1j6uyoB+HxekonkoUDl50g7yk3LRnYScK6sStb5pBzwl/bteJm6VFNzksB07RoD4dmcJZY
    VdiIKVbEs3XzVwXK7AqTzvu/5bPY1eoMkecDU5MTuqJ0bbzDKf6zfqc/3gVc1Tt/VrPF+4
    ykKleLBBcmf2l0TF3giI6aolK2tMnS7lvcFPqLcY2GjwARLogkLqndIPr0EeRum5dexwVU
    NSScoWxRZSMBJEWCASYoP8FTxeUK7vxSMFvufz2Dsx3SFpBnX5J0SrA4LMAYsazUd6k2mO
    k9D+BGXLdykd8qHCjllt+V6fptc1B6PFoXMV97sPIwFTmuKmV8pl/PK7J5F64AsC1BaEFj
    3hH1t2+gXiLX+MR9WhRWACTrRQ7aC0es87iPGcAOUMTQxnpUOhR/RvxkZp2krjwQzegR0g
    asfCrUSLcmOn/7gggvgGBZ2gLbc8o642Phcwq3qVlyFCcQLpRKeFCDCgd6rbTZE6ZLgltt
    1H3cqYOrn+I6ajY/D1Fu+s0DN/2MZbCntiUY+bdC+i/bnb+dkgyq5nBdsxew
X-ME-Proxy: <xmx:aHspakCWE1E75VBGDFBxA4SDvEAUlw1oTeerG2pNz-SGa98_4XvL4Q>
    <xmx:aHspavf2GgssNQiTbEXsDA9CAxOCv7FwIqxbQ3N9RebMl_EeRkINRQ>
    <xmx:aHspapj8qG8BIhHP2CZM68uT8EPHcXN3ypb5ov6HHYMVDkCibu1eig>
    <xmx:aHspanrPmOU8isxmfa9jZ2i-P3un_pTWneRxMEE3MumdGFkk4ocB6g>
    <xmx:aXspanaLHyR-U5rPlM0Y3RVcBA8X6vEPKjur0jo69OnyRet26AOggmia>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ba8bdd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:15 +0200
Subject: [PATCH 9/9] refs: always use absolute paths for reference stores
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-9-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Both the "files" and "reftable" backends use
`refs_compute_filesystem_location()` to figure out the location of both
the git and common directories. Depending on how the function is called
we may or may not return an absolute path.

There isn't really a good reason to use relative paths though. Quite on
the contrary, because we sometimes use relative paths we are forced to
register for chdir(3p) notifications via `chdir_notify_reparent()`.

Adapt the function to always return absolute paths. This results in a
user-visible change in behaviour where we now unconditionally print
absolute paths in error messages. But arguably, that change in behaviour
is acceptable and may even be good in cases where a Git command may end
up accessing references across multiple different repositories.

Furthermore, drop the calls to `chdir_notify_reparent()`, which aren't
required anymore now that the paths are always absolute.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                      | 11 ++++++++---
 refs/files-backend.c        | 22 ----------------------
 refs/packed-backend.c       | 18 +-----------------
 refs/reftable-backend.c     | 17 -----------------
 t/pack-refs-tests.sh        |  6 +++---
 t/t0600-reffiles-backend.sh |  4 ++--
 t/t1423-ref-backend.sh      |  9 ++++++---
 t/t5510-fetch.sh            |  2 +-
 8 files changed, 21 insertions(+), 68 deletions(-)

diff --git a/refs.c b/refs.c
index 4912510590..8679677bf7 100644
--- a/refs.c
+++ b/refs.c
@@ -3579,15 +3579,16 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 		 * worktree path, as the 'gitdir' here is already the worktree
 		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
 		 */
+		strbuf_reset(refdir);
 		strbuf_addstr(refdir, gitdir);
-		return;
+		goto out;
 	}
 
 	if (!is_absolute_path(payload)) {
 		strbuf_addf(ref_common_dir, "/%s", payload);
-		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
 	} else {
-		strbuf_realpath(ref_common_dir, payload, 1);
+		strbuf_reset(ref_common_dir);
+		strbuf_addstr(ref_common_dir, payload);
 	}
 
 	strbuf_addbuf(refdir, ref_common_dir);
@@ -3598,4 +3599,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 			BUG("worktree path does not contain slash");
 		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
 	}
+
+out:
+	strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
+	strbuf_realpath(refdir, refdir->buf, 1);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 296981584b..762f392e67 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -21,7 +21,6 @@
 #include "../lockfile.h"
 #include "../path.h"
 #include "../dir.h"
-#include "../chdir-notify.h"
 #include "../setup.h"
 #include "../worktree.h"
 #include "../wrapper.h"
@@ -100,23 +99,6 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 	}
 }
 
-static void files_ref_store_reparent(const char *name UNUSED,
-				     const char *old_cwd,
-				     const char *new_cwd,
-				     void *payload)
-{
-	struct files_ref_store *refs = payload;
-	char *tmp;
-
-	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
-	free(refs->base.gitdir);
-	refs->base.gitdir = tmp;
-
-	tmp = reparent_relative_path(old_cwd, new_cwd, refs->gitcommondir);
-	free(refs->gitcommondir);
-	refs->gitcommondir = tmp;
-}
-
 /*
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
@@ -145,10 +127,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
-	chdir_notify_register(NULL, files_ref_store_reparent, refs);
-
 	strbuf_release(&refdir);
-
 	return ref_store;
 }
 
@@ -197,7 +176,6 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
 	free(refs->packed_ref_store);
-	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 499cb55dfa..89e41a35a3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -13,7 +13,6 @@
 #include "packed-backend.h"
 #include "../iterator.h"
 #include "../lockfile.h"
-#include "../chdir-notify.h"
 #include "../statinfo.h"
 #include "../worktree.h"
 #include "../wrapper.h"
@@ -211,19 +210,6 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
-static void packed_ref_store_reparent(const char *name UNUSED,
-				      const char *old_cwd,
-				      const char *new_cwd,
-				      void *payload)
-{
-	struct packed_ref_store *refs = payload;
-	char *tmp;
-
-	tmp = reparent_relative_path(old_cwd, new_cwd, refs->path);
-	free(refs->path);
-	refs->path = tmp;
-}
-
 /*
  * Since packed-refs is only stored in the common dir, don't parse the
  * payload and rely on the files-backend to set 'gitdir' correctly.
@@ -239,10 +225,9 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
 
 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
 	refs->store_flags = opts->access_flags;
-
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
-	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
+
 	return ref_store;
 }
 
@@ -287,7 +272,6 @@ static void packed_ref_store_release(struct ref_store *ref_store)
 	clear_snapshot(refs);
 	rollback_lock_file(&refs->lock);
 	delete_tempfile(&refs->tempfile);
-	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
 	free(refs->path);
 }
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8c93070677..8cc1dbbbdd 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2,7 +2,6 @@
 
 #include "../git-compat-util.h"
 #include "../abspath.h"
-#include "../chdir-notify.h"
 #include "../config.h"
 #include "../dir.h"
 #include "../environment.h"
@@ -365,19 +364,6 @@ static int reftable_be_config(const char *var, const char *value,
 	return 0;
 }
 
-static void reftable_be_reparent(const char *name UNUSED,
-				 const char *old_cwd,
-				 const char *new_cwd,
-				 void *payload)
-{
-	struct reftable_ref_store *refs = payload;
-	char *tmp;
-
-	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
-	free(refs->base.gitdir);
-	refs->base.gitdir = tmp;
-}
-
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
@@ -460,8 +446,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 			goto done;
 	}
 
-	chdir_notify_register(NULL, reftable_be_reparent, refs);
-
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
 	strbuf_release(&ref_common_dir);
@@ -487,7 +471,6 @@ static void reftable_be_release(struct ref_store *ref_store)
 		free(be);
 	}
 	strmap_clear(&refs->worktree_backends, 0);
-	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
 }
 
 static int reftable_be_create_on_disk(struct ref_store *ref_store,
diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index d76b087b09..357413ba3c 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -237,7 +237,7 @@ test_expect_success 'reject packed-refs with unterminated line' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
-	echo "fatal: unterminated line in .git/packed-refs: $HEAD refs/zzzzz" >expected_err &&
+	echo "fatal: unterminated line in $(pwd)/.git/packed-refs: $HEAD refs/zzzzz" >expected_err &&
 	test_must_fail git for-each-ref >out 2>err &&
 	test_cmp expected_err err
 '
@@ -246,7 +246,7 @@ test_expect_success 'reject packed-refs containing junk' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s\n" "bogus content" >>.git/packed-refs &&
-	echo "fatal: unexpected line in .git/packed-refs: bogus content" >expected_err &&
+	echo "fatal: unexpected line in $(pwd)/.git/packed-refs: bogus content" >expected_err &&
 	test_must_fail git for-each-ref >out 2>err &&
 	test_cmp expected_err err
 '
@@ -255,7 +255,7 @@ test_expect_success 'reject packed-refs with a short SHA-1' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
-	printf "fatal: unexpected line in .git/packed-refs: %.7s %s\n" $HEAD refs/zzzzz >expected_err &&
+	printf "fatal: unexpected line in $(pwd)/.git/packed-refs: %.7s %s\n" $HEAD refs/zzzzz >expected_err &&
 	test_must_fail git for-each-ref >out 2>err &&
 	test_cmp expected_err err
 '
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 74bfa2e9ba..b17f0940c2 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -96,7 +96,7 @@ test_expect_success 'non-empty directory blocks create' - <<\EOT
 	: >.git/$prefix/foo/bar/baz.lock &&
 	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref '$prefix/foo': there is a non-empty directory '.git/$prefix/foo' blocking reference '$prefix/foo'
+	fatal: cannot lock ref '$prefix/foo': there is a non-empty directory '$(pwd)/.git/$prefix/foo' blocking reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/foo $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -135,7 +135,7 @@ test_expect_success 'non-empty directory blocks indirect create' - <<\EOT
 	: >.git/$prefix/foo/bar/baz.lock &&
 	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref '$prefix/symref': there is a non-empty directory '.git/$prefix/foo' blocking reference '$prefix/foo'
+	fatal: cannot lock ref '$prefix/symref': there is a non-empty directory '$(pwd)/.git/$prefix/foo' blocking reference '$prefix/foo'
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index fd47d77e8e..875857f2d0 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -145,7 +145,8 @@ do
 				test_commit 3 &&
 
 				git refs migrate --dry-run --ref-format=$to_format >out &&
-				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+				BACKEND_PATH=$(sed "s/.* the result can be found at ${SQ}\(.*\)${SQ}$/\1/" out) &&
+				test_path_is_dir "$BACKEND_PATH" &&
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
 			)
 		'
@@ -160,7 +161,8 @@ do
 				test_commit 3 &&
 
 				git refs migrate --dry-run --ref-format=$to_format >out &&
-				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+				BACKEND_PATH=$(sed "s/.* the result can be found at ${SQ}\(.*\)${SQ}$/\1/" out) &&
+				test_path_is_dir "$BACKEND_PATH" &&
 
 				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
 
@@ -187,7 +189,8 @@ do
 				test_commit 3 &&
 
 				git refs migrate --dry-run --ref-format=$to_format >out &&
-				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+				BACKEND_PATH=$(sed "s/.* the result can be found at ${SQ}\(.*\)${SQ}$/\1/" out) &&
+				test_path_is_dir "$BACKEND_PATH" &&
 
 				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
 					"worktree add ../wt 2" "$method" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index eca9a973b5..d5f84d99df 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1741,7 +1741,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_df &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}./refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
+		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}$(pwd)/refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/Foo/bar >actual &&
 		test_cmp expect actual

-- 
2.54.0.1189.g8c84645362.dirty

