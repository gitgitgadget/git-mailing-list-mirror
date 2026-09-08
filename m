Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131A582BB1
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885724; cv=none; b=sxMUV62T7lYf0fosIpMpeXW4TuVMWHpdtaQcH+J9ACkygmsqAW98GpPF4PGNMs2oXWyIMhwU5765lLD9liXiZ32FNKvGGgRlNl6XnPK+o+N6br2o4go58mZGCQIcAt67dnIF0BpJ3Zb2m3zFEaLuaS8sdiDW6QRcS2MWOCfVLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885724; c=relaxed/simple;
	bh=YZs7bPnaYw4Jmf7AZeDHigcX7OvSX6jbooeifWoIIUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbvxsEKiQ1j1ONZ2Vs9lrYssOUn1LsF/iw4Nxiv2ElaOKA9C5+Jsc5NFPCvdYcFEoHvO/nNqPEMdO5Dj4jCjGqTblAKH2gYb0JR/6LeNeYCEhHFDnpZFy7mVUwkTq0oYmOFo/jjjIIuNDWY7aqII3ide7fnNaDgkQtUSCB+AsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RosDFinI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RosDFinI"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485843aeab8so5403107f8f.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885720; x=1789490520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gL5onyP5qP8SCyVCzHBEF1p9RUEC5zBMrZm4hyaVJs=;
        b=RosDFinIFk8f2/7Fcn55kluwNrrBPGzWfFue46it3Ge52+UmTEb5/2fpJNXMDhK4Sz
         FrnoHtIopoJoKrnzEM9SbgO0YBgTMwQTemFde0+iLMCMUVoZdJyEvDEw/8ztisMxsDAo
         JD2tJtzSpFmxao2jYrXBXgF5Z8iHwJjjXBAYPQ+jH2FVbsGV+mx9h6GqQ9SOH+IxTKly
         G8NWd0rJyM7T5aRBZtTnKFWYuobB+XC4OkOrsI5j6bgI2ObgsWg6HQmw+12cHC2PAU1H
         lMMiDgoAzI91vw5MQxLSJkCT8zqmMJ5Qp0EfF/fVq40DdizW7p+M7O19yXcHeAkzXFp0
         aHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885720; x=1789490520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gL5onyP5qP8SCyVCzHBEF1p9RUEC5zBMrZm4hyaVJs=;
        b=qLClROOAWcZ3JIb4KeSDjXwgNjW4AM9gES9M5qhy8d+cOpNDC0GGwfG5MPzkavzQQ4
         /Mbni9s3VE9j1dBltotpYxmD/quG0YtXP1fGODsffkglUc7wVJrBVMxVmsMwl27nOlkR
         dTiz/7ek9Y8vYWspGGeMOeRV9GPExM7/iot97sqBQZZQAD3pEFZGRfO2R1PbUTB/5hBP
         UG4jOCdIUWjwAjyqdIiluClpwM/Lhr7eIbMd1ALAWEkkLhy9sOOIufMLaK3JqNrB4y7Y
         IOtr3Gs3MhRfj6sL/pLZCmWDNA8OUc5i8xPsBr6W+BTSVLWUFUVdC8NsjAP9eqDkXnZ4
         AJGA==
X-Gm-Message-State: AFuF++lOTaveQ79YSEJpVa7m4hhy+eMezoqxKDary8Wk+RUehXApETDB
	m+0ToL2iU+tEPZVdreCLDRTELtG/RkQKJFpPgamCMYGYjJSuMu7GpFaMC2UEoQtN
X-Gm-Gg: AYBFou2ZQFdm+ZirQjH1lB4ZvZTuKyK2xltSIDZmV69VIaXKc+ww6a7G7ijIxGicWJ6
	2hfQYetm3JKJ+qF1OY51fteoNBMrnpYoqH96iHlj6XVK4tHuSRIcsiD1WlI0w8s56ft2ZSKWX6T
	9eZbs/gH7Ao9/EfB2p4GDWRLpuvbNjnnwFV0Q4o+r5g+mybmwxSHZroZxz+bPwkTB2VU6f8t/0i
	P8u1TuRbXruqhjDU355FxFvrXQQKfdqBEOZaaKnQqQQpIs86Et4Mm1M/T3XwT45LL68XaZwmMeu
	+lOhfaM8xYesZvVWPFHQoIwLdwZ0wVsh8nerOdsVxEKgBDPVj+jVtUnOCec5Gph8n1tdYoxaI4S
	C14F2bL5eTJho9xHQ0yUnHmHa58py1ZWFPVWkcNPPn+Z5YFMduFknLPpShz7o0E6opaOecbMYQJ
	PePEL4sVXz0dz6sDXcn0Fu9Mno2GuavOuhRCZx60NHQwUlcHLJLdEIykGeCaMbme+0bxx+WCUk/
	gwuwqRamQrKdIGi+CqVK4zxLJdtWEkYxgoBPEz9U/8FX1yPT+dolTJBl+aglKS5m+3G+sC66scV
	ViAERmOLNl0OBuTUDXcX5Cors+nXbvdJQ8+R5e4IQXgzLKLynnVMJIjIIrFtqrJAuLN7//UHsLb
	j
X-Received: by 2002:a05:6000:481d:b0:484:36c1:2881 with SMTP id ffacd0b85a97d-48586e4a5c8mr65680620f8f.2.1788885719632;
        Tue, 08 Sep 2026 09:41:59 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:58 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 4/5] promisor-remote: prevent infinite recursion when lazy fetching
Date: Tue,  8 Sep 2026 18:41:28 +0200
Message-ID: <20260908164129.560396-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a repository R is configured to lazy fetch from a promisor remote P
which is also configured to in turn lazy fetch from R, there is an
infinite recursion: R asks P for a missing object, P asks R for it,
and so on. The simplest case of this is a repository configured as its
own promisor remote.

This is not reachable when serving a repository by default, as
`upload-pack` sets `GIT_NO_LAZY_FETCH` to 1, which makes the nested
`upload-pack` refuse to lazily fetch. A following commit will let
server operators allow lazy fetching for repositories they trust
though, and as `GIT_NO_LAZY_FETCH` is then set to 0 and passed down to
child processes, nothing stops the recursion anymore.

It does not recurse forever in practice, but only because each level
adds one more variable to the environment of the child process, so
after a while `exec()` fails with:

    fatal: cannot exec 'git-upload-pack ...': Argument list too long
    fatal: unable to fork

To avoid this pathological case altogether, let's use a new
`GIT_INTERNAL_LAZY_FETCH_DEPTH` to count the recursion depth, and let's
check that it doesn't exceed a MAX_LAZY_FETCH_DEPTH limit (set to 5 for
now).

Note that some nesting is legitimate: when `git fetch` runs
`index-pack`, it can lazily fetch REF_DELTA bases that are missing
locally, so the limit should not be 1.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 environment.h            |  8 ++++++++
 promisor-remote.c        | 26 ++++++++++++++++++++++----
 t/t0410-partial-clone.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/environment.h b/environment.h
index e7ec5b0437..f2833be9fe 100644
--- a/environment.h
+++ b/environment.h
@@ -52,6 +52,14 @@
  */
 #define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
 
+/*
+ * Environment variable used to detect that a lazy fetch is already in
+ * progress in a parent process, to prevent infinite recursion when a
+ * promisor remote resolves back to the repository being served.
+ * This is an internal variable that should not be set by the user.
+ */
+#define LAZY_FETCH_DEPTH_ENVIRONMENT "GIT_INTERNAL_LAZY_FETCH_DEPTH"
+
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
diff --git a/promisor-remote.c b/promisor-remote.c
index df17fec3bb..e9c5b413f1 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -24,7 +24,7 @@ struct promisor_remote_config {
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
 			 const struct object_id *oids,
-			 int oid_nr)
+			 int oid_nr, unsigned long depth)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
@@ -41,6 +41,7 @@ static int fetch_objects(struct repository *repo,
 		     "--filter=blob:none", "--stdin", NULL);
 	if (!repo_config_get_bool(repo, "promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
+	strvec_pushf(&child.env, "%s=%lu", LAZY_FETCH_DEPTH_ENVIRONMENT, depth + 1);
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
@@ -269,6 +270,7 @@ static bool try_promisor_remotes(struct repository *repo,
 				 struct object_id **remaining_oids,
 				 int *remaining_nr,
 				 int *to_free,
+				 unsigned long depth,
 				 bool accepted_only)
 {
 	struct promisor_remote *r = repo->promisor_remote_config->promisors;
@@ -276,7 +278,8 @@ static bool try_promisor_remotes(struct repository *repo,
 	for (; r; r = r->next) {
 		if (accepted_only != r->accepted)
 			continue;
-		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
+		if (fetch_objects(repo, r->name,
+				  *remaining_oids, *remaining_nr, depth) < 0) {
 			if (*remaining_nr == 1)
 				continue;
 			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
@@ -291,6 +294,8 @@ static bool try_promisor_remotes(struct repository *repo,
 	return false;
 }
 
+#define MAX_LAZY_FETCH_DEPTH 5
+
 /*
  * Return 'true' if all the objects could be fetched, 'false' otherwise.
  */
@@ -299,6 +304,8 @@ static bool lazy_fetch_objects(struct repository *repo,
 			       int *remaining_nr,
 			       int *to_free)
 {
+	unsigned long depth = git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
+
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
 		static int warning_shown;
 		if (!warning_shown) {
@@ -308,13 +315,24 @@ static bool lazy_fetch_objects(struct repository *repo,
 		return false;
 	}
 
+	if (depth >= MAX_LAZY_FETCH_DEPTH) {
+		static int warning_shown;
+		if (!warning_shown) {
+			warning_shown = 1;
+			warning(_("too many nested lazy fetches (%lu); "
+				  "is a promisor remote pointing at the repository itself?"),
+				depth);
+		}
+		return false;
+	}
+
 	promisor_remote_init(repo);
 
 	/* Try accepted remotes first (those the server told us to use) */
 	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
-				    to_free, true) ||
+				    to_free, depth, true) ||
 		try_promisor_remotes(repo, remaining_oids, remaining_nr,
-				     to_free, false);
+				     to_free, depth, false);
 }
 
 void promisor_remote_get_direct(struct repository *repo,
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 788e9a1631..a54685e3c7 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -709,6 +709,39 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	test_grep ! "[?]$FILE_HASH" out
 '
 
+test_expect_success 'lazy-fetch does not recurse infinitely between two promisor remotes' '
+	rm -rf full partial1.git partial2.git &&
+
+	# Create a repo with a blob
+	test_create_repo full &&
+	test_config -C full uploadpack.allowfilter 1 &&
+	test_config -C full uploadpack.allowanysha1inwant 1 &&
+	test_commit -C full create-a-file file.txt &&
+	FILE_HASH=$(git -C full rev-parse HEAD:file.txt) &&
+
+	# Create partial clone repos without blobs
+	git clone --filter=blob:none --bare "file://$(pwd)/full" partial1.git &&
+	git clone --filter=blob:none --bare "file://$(pwd)/full" partial2.git &&
+	test_config -C partial1.git uploadpack.allowfilter 1 &&
+	test_config -C partial1.git uploadpack.allowanysha1inwant 1 &&
+	test_config -C partial2.git uploadpack.allowfilter 1 &&
+	test_config -C partial2.git uploadpack.allowanysha1inwant 1 &&
+
+	# Configure the partial repos as remotes of each other
+	git -C partial2.git remote set-url origin "file://$(pwd)/partial1.git" &&
+	git -C partial1.git remote set-url origin "file://$(pwd)/partial2.git" &&
+
+	# Make sure lazy fetching fails
+	test_must_fail env GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 \
+		git -C partial1.git cat-file -e "$FILE_HASH" 2>err &&
+	test_grep "too many nested lazy fetches" err &&
+
+	# Make sure the recursion was bounded, i.e. that only
+	# MAX_LAZY_FETCH_DEPTH "git fetch" subprocesses were spawned
+	grep "run_command: GIT_INTERNAL_LAZY_FETCH_DEPTH" trace >fetches &&
+	test_line_count = 5 fetches
+'
+
 test_expect_success 'push should not fetch new commit objects' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.55.0.792.ged91fccac1.dirty

