Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C24C9DFC
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602757; cv=none; b=jpvKFHJG5Mu1VU6/7cyxVK8f9WCZu/fznzXZhxBPuQZ+ooG4r5lfUKnuUY5eABziqx9jL43f3ovmakq4jtJM0ecXSzuAUfpJHifp9bUahkqt03CioE2cK9vfgn6EB9s9317DUUCP+cLeRCPkr1YNrJEWbDIdFETpYUaEuYrUQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602757; c=relaxed/simple;
	bh=taZl76WKKfb2Ox396Nq00KGTKE7jJORwoSwtFqRBmOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY0OiJVIcNcK5FHHzgTtM5z7lFI4wDKNv4ID5fplr8YupDuZbDL1uDimpxT/+LLo4N7r//54fdz4N7rU0qPK9rmQYd1MFgQ2rK2rfrswyFlWWRUDH7m3Q2S7guyDJHG2vOl+ny495MboD6uugEEIOqyrG9x30cwlYmxPT2pB7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwRKcQpc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwRKcQpc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso13549545e9.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602753; x=1791207553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjWw9Wlmrb4V3LKzip9aGF98/bWIBDZZRghLRQtsppM=;
        b=QwRKcQpc5+STJGoz0cKEsndvhYF9qMCh37dBCk3owiIf4mzbELqt3JHgnRHWfoykEf
         EtcqWytlV5TcGDBL+EHTSQ3lKKdIqEL9CuD7H9kjEgWeUwbN6iG0XmgrX+3OL3C6FWOz
         +G2cqMI2nr85F4KukkS5gGvH2RXgVMCngJ2hlWR0hPKdwD5zi8judZcJ0ePJ52jo6RVn
         Cibv9JSMwbyFOtF+FBFoUt67Rppx1Sms4BjRh1I/6YOXsW7PLqCXwlixAb3HP+ipN6CP
         h/7HEBUHaPVXHYmgs0sOk0lCTrmfTzHTzvuCne9kDMsKaqFQiBShkMSNHYjGcqyMHexl
         eQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602753; x=1791207553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjWw9Wlmrb4V3LKzip9aGF98/bWIBDZZRghLRQtsppM=;
        b=jhr0Qq9FhTCgLz2fYsXta2zjb5FFmZd2/vT2egvn2z++e5ZWgHhaV5A5d3hTaVW0C2
         EB6zHoXUcqwSwxEloBqXMOdVRJJPG5dsYP+6IS7fL7LX+4j1nmW4xnwEqInJnsiElSvi
         9w1LqQ17LTT8cQGnhwrYzHNVvPddTLwFXsMab9QqKxPrgfzmR7edQ2dFK7UzhS/+r7r2
         0FYr2Wzi0TyHycsaODTm1JkrIdq7sb6dqvhdjHVJ3V3aca7p4CpKJXcxvgTox3RKquQC
         0t7NwcISl91maUn6wyqXzTTrWFM8jLf0OcjLBsGNgGUARdv30/mAYFeI8Xei8XsWIbcU
         nVXA==
X-Gm-Message-State: AFuF++kh5QTKPw89/FXj1mAqidGLwajLweWnkXT/ZYgwN/epns7BzePE
	75+GOp3m6lM0NvTyfUW0+i7TVyXo4/Km3Vftspm7nFJphg2Ahw8RpcXWcueMSw==
X-Gm-Gg: AYBFou32E+ifY2UrjZ5b+4QOaCZ4IsvXjdLlV0hH8D3C+CM0sWcLlMahpyN7HuLTPJj
	6DyaHf0CcuYceosllv9BrhBaAVz9sVzW6hc7VoACWdP8oAteX1HLY2jvqOMBdSfgw/wJk2EvlOW
	OlotC6nWBbsmcwPfXg8NLYgKLilV2bWQBwpXQVWJzthHkTmCUJ8Xf1yiKf76qSIb1TAI8y5oak4
	4IqrE5d8KscrJPW+hopIyCYbd119ogK7l28uXYqRdoYYhSIWXbqYG/Y271NN0abuTSEKNDlJZTW
	8kesz7lxUbs0J1hRlQ6vIEs1Ebkw9/UKmBm7s0BrwHa2wXfwN9QmfVdavWtVuFUC8DdkSmyFRGk
	tdAVIJJyLTpDe42f0brC9vyb2j5+Kq2zHK82xpIijXorJ+XN9jW/kDsq/5c64Wmqtmi7bGh46LO
	2UtEn/ooVlcTxdzMPISdgtZQ+wZyPeQCF96W6tAqCdzmzwV9hyK7Vpad+AVCQxmu3wBSF6fz6h/
	CrSaVgjaGTsiQtRg7hlCpqg5T4YOdwiinzhPIZonxuP0jW5QHjJWMFZFb3JApJ22OaYm3cJixIc
	yFdv/p4aUN9LZ9w+NY8XSs9mwrTm6ea1hKH4LFFTK7htAxphSdFtDmseIh58I9nK4K/pW1B/PFJ
	u3+v4ZFd/LWJiI2/HguPS
X-Received: by 2002:a05:600c:3514:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-49fe6701e7emr226750065e9.35.1790602752357;
        Mon, 28 Sep 2026 06:39:12 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:11 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 4/5] promisor-remote: prevent infinite recursion when lazy fetching
Date: Mon, 28 Sep 2026 15:38:45 +0200
Message-ID: <20260928133846.2094261-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com>
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
index 91245fe9a8..316d9950aa 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -24,7 +24,7 @@ struct promisor_remote_config {
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
 			 const struct object_id *oids,
-			 int oid_nr)
+			 int oid_nr, int depth)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
@@ -41,6 +41,7 @@ static int fetch_objects(struct repository *repo,
 		     "--filter=blob:none", "--stdin", NULL);
 	if (!repo_config_get_bool(repo, "promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
+	strvec_pushf(&child.env, "%s=%d", LAZY_FETCH_DEPTH_ENVIRONMENT, depth + 1);
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
@@ -282,6 +283,7 @@ static int try_promisor_remotes(struct repository *repo,
 				struct object_id **remaining_oids,
 				int *remaining_nr,
 				int *to_free,
+				int depth,
 				bool accepted_only)
 {
 	struct promisor_remote *r = repo->promisor_remote_config->promisors;
@@ -289,7 +291,8 @@ static int try_promisor_remotes(struct repository *repo,
 	for (; r; r = r->next) {
 		if (accepted_only != r->accepted)
 			continue;
-		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
+		if (fetch_objects(repo, r->name,
+				  *remaining_oids, *remaining_nr, depth) < 0) {
 			if (*remaining_nr == 1)
 				continue;
 			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
@@ -304,6 +307,8 @@ static int try_promisor_remotes(struct repository *repo,
 	return 0;
 }
 
+#define MAX_LAZY_FETCH_DEPTH 5
+
 /*
  * Lazily fetch the objects given in '*remaining_oids' from the
  * promisor remotes, trying the accepted ones first. See
@@ -318,6 +323,8 @@ static int lazy_fetch_objects(struct repository *repo,
 			      int *remaining_nr,
 			      int *to_free)
 {
+	int depth = (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
+
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
 		static int warning_shown;
 		if (!warning_shown) {
@@ -327,13 +334,24 @@ static int lazy_fetch_objects(struct repository *repo,
 		return 0;
 	}
 
+	if (depth >= MAX_LAZY_FETCH_DEPTH) {
+		static int warning_shown;
+		if (!warning_shown) {
+			warning_shown = 1;
+			warning(_("too many nested lazy fetches (%d); "
+				  "is a promisor remote pointing at the repository itself?"),
+				depth);
+		}
+		return 0;
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
2.56.0.rc2.20.g34f06850c1

