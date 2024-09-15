Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6B1C5789
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409337; cv=none; b=tRzhiCtHCn1W47RrgHGykpdoijrndjOHFHymOM4+7UQX/THGMaeOXVJx9brbmcvqWv7F5WrftVcdBUJ4eYewqjaUaZwJxFbqAWDj8lzjduVsFKwKb1advVg+eRjM5YGlxQUT2kezQ4O9aJZrjt3afPzgBZTmeFj1H2ZmKqvKL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409337; c=relaxed/simple;
	bh=OSZSUNmDMCwe+nPxKByMJDDY5ABSxJrt9S60PDJv3ic=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q+Ps6gjzF4AoK49Ner2IY5st47kRV6sf475FP98inGOhY+0N5oAvY1ryYqgAXxxQP775zw9pqM7RkYnSXcj+R647+HkgoK3EibQuWsdmR55EHZUBU0gqEO6X4d8jERdWr3mGnTIjd5iMYbYDWrcYJHc/LnaGrc3PrHKdf8NVawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGflucZC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGflucZC"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d64b27c45so392981966b.3
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409332; x=1727014132; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEewRlD2k/6wrcp3YZmQVTFBb1t0cRGaeaO2GbMXvyg=;
        b=NGflucZCpulQUZgCKcMdQw9Otpmca4k5dAZ2V+kTFXSy5PjAuvoVDX9vXCNrN0LyqV
         4Xbe2EJKcK9uo8qgtRiSUTeST/Lgmwil3WePFmKf7ZHhVvx5gm1p7gf2arHAmDi3dcJb
         VGo5URxzqKvTSJkvim1L4PLl8XuRy9yOhWT5ODqejLrxpW6YZjWEVZM0niznbNNl47m2
         +X0xnxp4FjgttYAoxbIYnFfGH6Pm68+7uJQ36EX7BU3tw1OR+n6MOoM7Tf6WYnMTJjFg
         QNXcKBWcOnn92URr595uG8RQst7yfoojpJnk5OZdQDMp6jYLyHyBf/ZsS2vrGh7xHdcH
         RsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409332; x=1727014132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEewRlD2k/6wrcp3YZmQVTFBb1t0cRGaeaO2GbMXvyg=;
        b=voD1unM5bJKlTYcZmuBr4YGTS0/eYGygu4fs2ebkjvMmszXlGEyLuwp0EfRVRCG3CG
         K4Rqxx/47dVqNVMLFAR3bWpANBdvPYFKZGU9nvPzhtYyhPvDljbnU0s72MwkH7zxHKlE
         p34Q/bRaRWxUALagXqjFLd80nZzI7f9OQejkWZBOXBsTqCe4bHKZBlVmCt++8hIRPzLp
         i9xTB0P+bOf8HADTaKFrMAfSQxJtr9J2jPCfTxpypQofqnYFC6z5pWg2JplDTWiID7h2
         96gUiX76L1B+jImPRWtOHDCl6Z4JHui3zq7RvBESWpD9KwBpdHkSj2UEOUy8stU8WaJf
         w6TA==
X-Gm-Message-State: AOJu0Yx89nhtVmhhZEhaKMsdQu4crIp/b7gPrH110qs9hFPaRXBql2dc
	dOv2glcd2HeCT7zHFvUGGoIzS6da3kJPIphreSuT29R7BhyYQslEDjDEag==
X-Google-Smtp-Source: AGHT+IEXVevlADLApa2+/bcAv+PD2yi/tmewvVIjU2cViNTiUHyj3UFgKTGTi6b6CHPZpHCWa4d81A==
X-Received: by 2002:a17:907:7286:b0:a8d:401b:db85 with SMTP id a640c23a62f3a-a9047d310bfmr847868966b.36.1726409331477;
        Sun, 15 Sep 2024 07:08:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e5961sm200411966b.181.2024.09.15.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:08:50 -0700 (PDT)
Message-Id: <pull.1782.v2.git.1726409329993.gitgitgadget@gmail.com>
In-Reply-To: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Sep 2024 14:08:49 +0000
Subject: [PATCH v2] remote: introduce config to set prefetch refs
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Derrick Stolee [ ]" <stolee@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

This commit introduces a new configuration option,
remote.<name>.prefetchref, which allows users to specify specific
ref patterns to be prefetched during a git fetch --prefetch
operation.

The new option accepts a space-separated list of ref patterns.
When the --prefetch option is used with git fetch, only the refs
matching these patterns will be prefetched, instead of the
default behavior of prefetching all fetchable refs.

Example usage in .git/config:
[remote "origin"]
    prefetchref = "refs/heads/main refs/heads/feature/*"

This change allows users to optimize their prefetch operations, potentially
reducing network traffic and improving performance for large repositories
with many refs.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    remote: introduce config to set prefetch refs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2Fpastelsky%2Fsk%2Fremote-prefetchref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/pastelsky/sk/remote-prefetchref-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1782

Range-diff vs v1:

 1:  3113d8b8635 ! 1:  f9f9e637bfa remote: introduce config to set prefetch refs
     @@ Documentation/config/remote.txt: remote.<name>.fetch::
       	linkgit:git-push[1].
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: static void find_non_local_tags(const struct ref *refs,
     - 	oidset_clear(&fetch_oids);
     +@@
     + #include "trace.h"
     + #include "trace2.h"
     + #include "bundle-uri.h"
     ++#include "wildmatch.h"
     + 
     + #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
     + 
     +@@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
     + 	}
       }
       
     -+static void apply_prefetch_refspec(struct remote *remote, struct refspec *rs)
     ++static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
      +{
     -+	if (remote->prefetch_refs.nr > 0) {
     -+		int i;
     -+		for (i = 0; i < remote->prefetch_refs.nr; i++) {
     -+			const char *src = remote->prefetch_refs.items[i].string;
     -+			struct strbuf dst = STRBUF_INIT;
     -+
     -+			strbuf_addf(&dst, "refs/prefetch/%s/", remote->name);
     -+			if (starts_with(src, "refs/heads/")) {
     -+				strbuf_addstr(&dst, src + 11);
     -+			} else if (starts_with(src, "refs/")) {
     -+				strbuf_addstr(&dst, src + 5);
     -+			} else {
     -+				strbuf_addstr(&dst, src);
     -+			}
     ++	int i;
     ++	int has_positive = 0;
     ++	int matched_positive = 0;
     ++	int matched_negative = 0;
     ++
     ++	for (i = 0; i < prefetch_refs->nr; i++) {
     ++		const char *pattern = prefetch_refs->items[i].string;
     ++		int is_negative = (*pattern == '!');
     ++
     ++		if (is_negative)
     ++			pattern++;
     ++		else
     ++			has_positive = 1;
      +
     -+			refspec_appendf(rs, "%s:%s", src, dst.buf);
     -+			strbuf_release(&dst);
     ++		if (wildmatch(pattern, refname, 0) == 0) {
     ++			if (is_negative)
     ++				matched_negative = 1;
     ++			else
     ++				matched_positive = 1;
      +		}
      +	}
     ++
     ++	if (!has_positive)
     ++		return !matched_negative;
     ++
     ++	return matched_positive && !matched_negative;
      +}
      +
      +
     - static void filter_prefetch_refspec(struct refspec *rs)
     - {
     - 	int i;
     ++static void ref_remove(struct ref **head, struct ref *to_remove)
     ++{
     ++	struct ref **pp, *p;
     ++
     ++	for (pp = head; (p = *pp) != NULL; pp = &p->next) {
     ++		if (p == to_remove) {
     ++			*pp = p->next;
     ++			return;
     ++		}
     ++	}
     ++}
     ++
     + static struct ref *get_ref_map(struct remote *remote,
     + 			       const struct ref *remote_refs,
     + 			       struct refspec *rs,
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	int existing_refs_populated = 0;
       
       	filter_prefetch_refspec(rs);
     --	if (remote)
     -+	if (remote) {
     ++
     + 	if (remote)
       		filter_prefetch_refspec(&remote->fetch);
     -+		if (prefetch)
     -+			apply_prefetch_refspec(remote, rs);
     + 
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 	else
     + 		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
     + 
     ++	/**
     ++	 * Filter out advertised refs that we don't want to fetch during
     ++	 * prefetch if a prefetchref config is set
     ++	 */
     ++	if (prefetch && remote->prefetch_refs.nr) {
     ++		struct ref *ref, *next;
     ++		for (ref = ref_map; ref; ref = next) {
     ++			next = ref->next;
     ++
     ++			if (!matches_prefetch_refs(ref->name, &remote->prefetch_refs)) {
     ++					ref_remove(&ref_map, ref);
     ++					free_one_ref(ref);
     ++			}
     ++		}
      +	}
     ++
     + 	ref_map = ref_remove_duplicates(ref_map);
       
     - 	if (rs->nr) {
     - 		struct refspec *fetch_refspec;
     + 	for (rm = ref_map; rm; rm = rm->next) {
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
       	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
       '
       
     -+test_expect_success 'prefetch only acts on remote.<name>.prefetchref refs if present' '
     -+	test_create_repo prefetch-test-mixed-patterns &&
     ++test_expect_success 'prefetch with positive prefetch ref patterns' '
     ++	test_create_repo filter-prefetch-positive &&
      +	(
     -+		cd prefetch-test-mixed-patterns &&
     ++		cd filter-prefetch-positive &&
      +		test_commit initial &&
     -+		git clone . clone1 &&
      +		git clone . clone2 &&
     -+
     -+		git remote add remote1 "file://$(pwd)/clone1" &&
      +		git remote add remote2 "file://$(pwd)/clone2" &&
      +
     -+		# Set single prefetchref pattern for remote1 and multiple for remote2
     -+		git config remote.remote1.prefetchref "refs/heads/foo" &&
     -+		git config remote.remote2.prefetchref "refs/heads/feature/* refs/heads/topic" &&
     -+
     -+		# Create branches in clone1 and push
     -+		(
     -+			cd clone1 &&
     -+			git checkout -b foo &&
     -+			test_commit foo-commit &&
     -+			git checkout -b feature/a &&
     -+			test_commit feature-a-commit &&
     -+			git checkout -b other &&
     -+			test_commit other-commit &&
     -+			git push origin foo feature/a other
     -+		) &&
     -+
     -+		# Create branches in clone2 and push
     -+		(
     -+			cd clone2 &&
     -+			git checkout -b topic &&
     -+			test_commit master-commit &&
     -+			git checkout -b feature/x &&
     -+			test_commit feature-x-commit &&
     -+			git checkout -b feature/y &&
     -+			test_commit feature-y-commit &&
     -+			git checkout -b dev &&
     -+			test_commit dev-commit &&
     -+			git push origin topic feature/x feature/y dev
     -+		) &&
     -+
     -+		# Run maintenance prefetch task
     -+		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
     -+
     -+		# Check that only specified refs were prefetched
     ++		cd clone2 &&
     ++		git checkout -b feature && test_commit feature-commit-2 &&
     ++		git checkout -b wip/test && test_commit wip-test-commit-2 &&
     ++		git checkout -b topic/x && test_commit topic-x-commit-2 &&
     ++		git push -f origin feature wip/test topic/x&&
     ++		cd .. &&
     ++
     ++		git config remote.remote2.prefetchref "refs/heads/feature" &&
      +		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     -+		test_subcommand git fetch remote1 $fetchargs <prefetch.txt &&
     -+		test_subcommand git fetch remote2 $fetchargs <prefetch.txt &&
     -+		ls -R .git/refs/prefetch &&
     -+
     -+		# Verify that only specified refs are in the prefetch refs for remote1
     -+		 git rev-parse refs/prefetch/remotes/remote1/foo &&
     -+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/feature/a &&
     -+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/other &&
     -+
     -+				# Verify that only specified refs are in the prefetch refs for remote2
     -+		git rev-parse refs/prefetch/remotes/remote2/feature/x &&
     -+		git rev-parse refs/prefetch/remotes/remote2/feature/y &&
     -+		git rev-parse refs/prefetch/remotes/remote2/topic &&
     -+		test_must_fail git rev-parse refs/prefetch/remotes/remote2/dev &&
     -+
     -+		# Fetch all refs and compare
     -+		git fetch --all &&
     -+		test_cmp_rev refs/remotes/remote1/foo refs/prefetch/remotes/remote1/foo &&
     -+		test_cmp_rev refs/remotes/remote2/feature/x refs/prefetch/remotes/remote2/feature/x &&
     -+		test_cmp_rev refs/remotes/remote2/feature/y refs/prefetch/remotes/remote2/feature/y &&
     -+		test_cmp_rev refs/remotes/remote2/topic refs/prefetch/remotes/remote2/topic
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		test_subcommand git fetch remote2 $fetchargs <prefetch-positive.txt &&
     ++
     ++		git rev-parse refs/prefetch/remotes/remote2/feature &&
     ++		test_must_fail git rev-parse refs/prefetch/remotes/remote2/wip/test &&
     ++		test_must_fail git rev-parse refs/prefetch/remotes/remote2/topic/x
     ++	)
     ++'
     ++
     ++test_expect_success 'prefetch with negative prefetch ref patterns' '
     ++	test_create_repo filter-prefetch-negative &&
     ++	(
     ++		cd filter-prefetch-negative &&
     ++		test_commit initial &&
     ++		git clone . clone3 &&
     ++		git remote add remote3 "file://$(pwd)/clone3" &&
     ++		cat .git/config &&
     ++
     ++		cd clone3 &&
     ++		git checkout -b feature && test_commit feature-commit-3 &&
     ++		git checkout -b wip/test && test_commit wip-test-commit-3 &&
     ++		git checkout -b topic/x && test_commit topic-x-commit-3 &&
     ++		git push -f origin feature wip/test topic/x &&
     ++		cd .. &&
     ++
     ++		git config remote.remote3.prefetchref "!refs/heads/wip/*" &&
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		test_subcommand git fetch remote3 $fetchargs <prefetch-negative.txt &&
     ++		git rev-parse refs/prefetch/remotes/remote3/feature &&
     ++		git rev-parse refs/prefetch/remotes/remote3/topic/x &&
     ++		test_must_fail git rev-parse refs/prefetch/remotes/remote3/wip/test
     ++	)
     ++'
     ++
     ++test_expect_success 'prefetch with positive & negative prefetch ref patterns' '
     ++	test_create_repo filter-prefetch-mixed &&
     ++	(
     ++		cd filter-prefetch-mixed &&
     ++		test_commit initial &&
     ++		git clone . clone4 &&
     ++		git remote add remote4 "file://$(pwd)/clone4" &&
     ++
     ++		cd clone4 &&
     ++		git checkout -b feature && test_commit feature-commit-4 &&
     ++		git checkout -b topic/x && test_commit topic-x-commit-4 &&
     ++		git checkout -b topic/y && test_commit topic-y-commit-4 &&
     ++		git push -f origin feature topic/x topic/y &&
     ++		cd .. &&
     ++
     ++		git config remote.remote4.prefetchref "refs/heads/topic/* !refs/heads/topic/y" &&
     ++		# git config --add remote.remote4.prefetchref "!refs/topic/y" &&
     ++		cat .git/config &&
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		test_subcommand git fetch remote4 $fetchargs <prefetch-mixed.txt &&
     ++
     ++		test_must_fail git rev-parse refs/prefetch/remotes/remote4/feature &&
     ++		test_must_fail git rev-parse refs/prefetch/remotes/remote4/topic/y &&
     ++		git rev-parse refs/prefetch/remotes/remote4/topic/x
      +	)
      +'
      +


 Documentation/config/remote.txt |  6 +++
 builtin/fetch.c                 | 61 +++++++++++++++++++++++++
 remote.c                        |  8 ++++
 remote.h                        |  3 ++
 t/t7900-maintenance.sh          | 80 +++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..b25d76dd3b1 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,12 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetchref::
+    Specify the refs to be prefetched when fetching from this remote.
+    The value is a space-separated list of ref patterns (e.g., "refs/heads/master refs/heads/develop*").
+    These patterns are used as the source part of the refspecs for prefetching.
+    This can be used to optimize fetch operations by specifying exactly which refs should be prefetched.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf2..16c8a31c2e1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -38,6 +38,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "bundle-uri.h"
+#include "wildmatch.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -485,6 +486,49 @@ static void filter_prefetch_refspec(struct refspec *rs)
 	}
 }
 
+static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
+{
+	int i;
+	int has_positive = 0;
+	int matched_positive = 0;
+	int matched_negative = 0;
+
+	for (i = 0; i < prefetch_refs->nr; i++) {
+		const char *pattern = prefetch_refs->items[i].string;
+		int is_negative = (*pattern == '!');
+
+		if (is_negative)
+			pattern++;
+		else
+			has_positive = 1;
+
+		if (wildmatch(pattern, refname, 0) == 0) {
+			if (is_negative)
+				matched_negative = 1;
+			else
+				matched_positive = 1;
+		}
+	}
+
+	if (!has_positive)
+		return !matched_negative;
+
+	return matched_positive && !matched_negative;
+}
+
+
+static void ref_remove(struct ref **head, struct ref *to_remove)
+{
+	struct ref **pp, *p;
+
+	for (pp = head; (p = *pp) != NULL; pp = &p->next) {
+		if (p == to_remove) {
+			*pp = p->next;
+			return;
+		}
+	}
+}
+
 static struct ref *get_ref_map(struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *rs,
@@ -502,6 +546,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	int existing_refs_populated = 0;
 
 	filter_prefetch_refspec(rs);
+
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 
@@ -610,6 +655,22 @@ static struct ref *get_ref_map(struct remote *remote,
 	else
 		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
 
+	/**
+	 * Filter out advertised refs that we don't want to fetch during
+	 * prefetch if a prefetchref config is set
+	 */
+	if (prefetch && remote->prefetch_refs.nr) {
+		struct ref *ref, *next;
+		for (ref = ref_map; ref; ref = next) {
+			next = ref->next;
+
+			if (!matches_prefetch_refs(ref->name, &remote->prefetch_refs)) {
+					ref_remove(&ref_map, ref);
+					free_one_ref(ref);
+			}
+		}
+	}
+
 	ref_map = ref_remove_duplicates(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
diff --git a/remote.c b/remote.c
index 8f3dee13186..b46d62b2c47 100644
--- a/remote.c
+++ b/remote.c
@@ -141,6 +141,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
+	string_list_init_dup(&ret->prefetch_refs);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
@@ -166,6 +167,7 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
+	string_list_clear(&remote->prefetch_refs, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -456,6 +458,12 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prefetchref")) {
+		if (!value)
+			return config_error_nonbool(key);
+		string_list_split(&remote->prefetch_refs, value, ' ', -1);
+		return 0;
+	}
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index b901b56746d..c18e68e0d8d 100644
--- a/remote.h
+++ b/remote.h
@@ -5,6 +5,7 @@
 #include "hashmap.h"
 #include "refspec.h"
 #include "strvec.h"
+#include "string-list.h"
 
 struct option;
 struct transport_ls_refs_options;
@@ -77,6 +78,8 @@ struct remote {
 
 	struct refspec fetch;
 
+	struct string_list prefetch_refs;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..5b64257eb7d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,86 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
+test_expect_success 'prefetch with positive prefetch ref patterns' '
+	test_create_repo filter-prefetch-positive &&
+	(
+		cd filter-prefetch-positive &&
+		test_commit initial &&
+		git clone . clone2 &&
+		git remote add remote2 "file://$(pwd)/clone2" &&
+
+		cd clone2 &&
+		git checkout -b feature && test_commit feature-commit-2 &&
+		git checkout -b wip/test && test_commit wip-test-commit-2 &&
+		git checkout -b topic/x && test_commit topic-x-commit-2 &&
+		git push -f origin feature wip/test topic/x&&
+		cd .. &&
+
+		git config remote.remote2.prefetchref "refs/heads/feature" &&
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" git maintenance run --task=prefetch 2>/dev/null &&
+		test_subcommand git fetch remote2 $fetchargs <prefetch-positive.txt &&
+
+		git rev-parse refs/prefetch/remotes/remote2/feature &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote2/wip/test &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote2/topic/x
+	)
+'
+
+test_expect_success 'prefetch with negative prefetch ref patterns' '
+	test_create_repo filter-prefetch-negative &&
+	(
+		cd filter-prefetch-negative &&
+		test_commit initial &&
+		git clone . clone3 &&
+		git remote add remote3 "file://$(pwd)/clone3" &&
+		cat .git/config &&
+
+		cd clone3 &&
+		git checkout -b feature && test_commit feature-commit-3 &&
+		git checkout -b wip/test && test_commit wip-test-commit-3 &&
+		git checkout -b topic/x && test_commit topic-x-commit-3 &&
+		git push -f origin feature wip/test topic/x &&
+		cd .. &&
+
+		git config remote.remote3.prefetchref "!refs/heads/wip/*" &&
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" git maintenance run --task=prefetch 2>/dev/null &&
+		test_subcommand git fetch remote3 $fetchargs <prefetch-negative.txt &&
+		git rev-parse refs/prefetch/remotes/remote3/feature &&
+		git rev-parse refs/prefetch/remotes/remote3/topic/x &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote3/wip/test
+	)
+'
+
+test_expect_success 'prefetch with positive & negative prefetch ref patterns' '
+	test_create_repo filter-prefetch-mixed &&
+	(
+		cd filter-prefetch-mixed &&
+		test_commit initial &&
+		git clone . clone4 &&
+		git remote add remote4 "file://$(pwd)/clone4" &&
+
+		cd clone4 &&
+		git checkout -b feature && test_commit feature-commit-4 &&
+		git checkout -b topic/x && test_commit topic-x-commit-4 &&
+		git checkout -b topic/y && test_commit topic-y-commit-4 &&
+		git push -f origin feature topic/x topic/y &&
+		cd .. &&
+
+		git config remote.remote4.prefetchref "refs/heads/topic/* !refs/heads/topic/y" &&
+		# git config --add remote.remote4.prefetchref "!refs/topic/y" &&
+		cat .git/config &&
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" git maintenance run --task=prefetch 2>/dev/null &&
+		test_subcommand git fetch remote4 $fetchargs <prefetch-mixed.txt &&
+
+		test_must_fail git rev-parse refs/prefetch/remotes/remote4/feature &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote4/topic/y &&
+		git rev-parse refs/prefetch/remotes/remote4/topic/x
+	)
+'
+
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
