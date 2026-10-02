Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76D3ED5C7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929432; cv=none; b=VdiPUhyix912SBbcdTJDIoK05rW29cPjQbG34Tcx1TXH3nKx4rmEKWIBcLWbb1UzDSjfvQcIqd0lDFoxwQYLHVL/jT3XUOju0jpUEsAi6HRa1XCpDWKc+8R/cPgzWa9YdOViuF2mIyb/AaXDjV9I1T+F2Vph+lPCV5Sb9rupFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929432; c=relaxed/simple;
	bh=taZl76WKKfb2Ox396Nq00KGTKE7jJORwoSwtFqRBmOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZIahV8VzAx13GraYjWJCzLs060lMPIu/cruKprXxTINe2kzvffJS3IKdplMiLSkOVFIGXxkD0jN1dWp3O3cHuHcKN9OuvGEYCLub3bWHbtrzlbtvJJ2ZCnpQpSJLnvP8EmgqMg5Ff7nngRCU1+pzT1JDQ6/KJDVrvWzMZ/K7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+ayymwG; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+ayymwG"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b9d8056d2so258626f8f.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929426; x=1791534226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjWw9Wlmrb4V3LKzip9aGF98/bWIBDZZRghLRQtsppM=;
        b=p+ayymwGGVWQfAfsM/QUEpKLxljG08Yu+I2DlVcgxc+J0U6TzuuPNhpg1cbRvXH6qI
         X8eNdpLbSBNq11IhslWTklD4iDhsjIfMSy8gxdphrDZEMEovHv6fcCW29yEbhgrfWpX3
         rCd9qjOz4eJ0QA2qbKwechR5bFOULh9hGjU1/jFV/zTInG0dwJayIiSNugfOADTKaYdH
         dxlBAo+FHV1F2P2SP+T/JVRF/Xr1R3XdlPSefllUVJQ5Qxl1L6Y+JcZ78WbVsdRAZnvb
         D5qZtqFdjIzwIkhEAfZxaRWAlyNZbFO1ujn1JSllpyfZzmyneTeqAYUWbpI51Ab7cvWI
         F18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929426; x=1791534226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjWw9Wlmrb4V3LKzip9aGF98/bWIBDZZRghLRQtsppM=;
        b=CaVkKnqDl08TWqJDj+7A3IqZsgvS1+YcvYD9qnNN1iYvc2WnlFLGuj3wxkLmDVvO8U
         FEIIxMZ7Ptc+egPDfNAkcI80/u7xXLSgy3Ac0tudu383EY5nlIMjOvJYrQffaPXigJN/
         ObIouiJNCieJlAnagZj4ss9p8tK65IvGAVACj6vxtQstQhhlvDgDwpLpoc/sDSHJSFwd
         jnaBw1BzXC9kLQwxCGF2KAv+MKZy4Bbh+rhKJtitC0xrFyJKizr0NH5W8/vGgcR/k9sa
         pVhd6lHM24kvGnsJmm9FUUs1JBDgcFQAJOEtSITZY/OVBottTxvT5OX+BTAxq9OeBHhh
         lx4A==
X-Gm-Message-State: AFq9FYK2NoDDw0nq7Xr3fQ5C1Qh57TKAO34u0pfHS3uRlHEZSUg9yS2N
	r0PNcfFHI9ljNJ6SGRjlDPjj8OMW+t2qvCNLDFYjpCd4UOwaIBb+6zZgI8RVPQ==
X-Gm-Gg: AYBFou1L2S9BTb3bi0H6iab1Q/868yjPen6+Pn5U+52f2JaQ9PSOuqJ+/VXIU/cvnrZ
	7bBEcvSvKQf/kksyJYfwNJ/qplN0izjG2urc52Ca3Ghku01F7hpkMpI3NddAp+TPvtXid/+6C80
	3wak+zmTuBsPuFLxjVWlqDTTZw/vL/bwnxMgmXQDXQap0sgSLooQSkbFdy5wmFIPIzwqKgTGBnZ
	LUKk/39WaTgom2XnTA7RkY4FTPEvbMiEKoD3mZBzRFwML/LC0UDIyaZx0Uo0V0JMKgFd1Hh5EN7
	6ye38A5qaFw9sgH2UdrpA7VcD+W5G+jhqk4BPep0EXXm19BNM3kWIbCXdww4VjIfpr+PyASVi+6
	6QqmTKLU2E6cZ1Q9rXsxm/8J8KFcdLjFly8Rk2O84zg6/BEu8UICfQpv6QO4J7QokiETPv9+mre
	7NxpgL2SnYj6jz8QTRyEtUvAuKiDihmD49MG3q4v8b0mqV+DJPqre6FYjLW9QdVuQCa7PHG2gSt
	5phg3xEE17+X+BBLQuMg/9pSkEOtrV3S1/GkmWlyVDTwa8Yf97x6k67Z3dIKMjSMSOgDC7Zvsqk
	dA/ZNOOC3aESyRDPwAACNesB87BLGqs+YAMbTbi0mcZHeqEYBjqd6zkZYqdR83KTTISLMtiV9OI
	/87Duw4sF
X-Received: by 2002:a05:6000:250a:b0:48b:5e2:52dd with SMTP id ffacd0b85a97d-48b12739690mr3718277f8f.11.1790929426298;
        Fri, 02 Oct 2026 01:23:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 4/5] promisor-remote: prevent infinite recursion when lazy fetching
Date: Fri,  2 Oct 2026 10:23:21 +0200
Message-ID: <20261002082322.2682869-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com>
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

