Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1321B4F22
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073300; cv=none; b=Eef00uuDI4IRBo0BcwHh+ftZ5vWCmQ754xO4pFkK4Uy+VY8DSwx7y/dAyRR8MK0lN4MPhbqBcPBfmz2eM7oSqHERjWVCpG3BbPjTOksQq1uGH0U4mCs2KMvKaWkGrRnhP6v3txDqLcC07lRTFPVic7iTSYc4mBKvi9yV6jDmsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073300; c=relaxed/simple;
	bh=Yn/HstL74+s3wO/XA/Xeo7/zY4TZm706Z7ZP5ZqYJIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kM/g6L1nzOtrbtoLaGM7xS/HyyyTVe1KzwQNoM5RklsW+LHp2ZdyTlBVq3qjlCKEoojAq7hNo+7YlrSQRHp5rzqy2CZnQpOLZvFS784sCYN2MyslptFgMLDOJOSNkRsATl7erwfNoObjdZV1/eF4yFS1uUE19kM6lUvT5AFVOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqeu/Sqd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqeu/Sqd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90188ae58eso313648166b.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728073295; x=1728678095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1rQXjquIrtF5N/h7Y25ZBCfIYDDZSnKD8gHCsO3ft0=;
        b=Fqeu/Sqd+v0DgJ13JpScnW4xzR9DNEPWTZFdheOHdFrwiFHUcmlqA1SNf028yBNmq6
         RYfmnicsf18vB/sg2rdUz31cwRBEHLqBNgrln/JyDEUCFXWReNWTn5wpM4PC70TmZa6X
         GzIt4pfVbxPmizFNNfXSg6SfUVT11VJs5iGpj5uOsGXOsU56vYSU7sCuvG3BpNRzPz01
         XnbOJQaq27/Z5fLHXxpB9nWmG9/9r0ienzqUIJHHpkXfD1vbFbgC/YDc3aGCdSAjvW3/
         NOY8WAyVP6Wll2VDHv31G59UAhnO57qRtG2ohXpUIHYMN2dBgpYigGT4h+Np4PaPMmXG
         osvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073295; x=1728678095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1rQXjquIrtF5N/h7Y25ZBCfIYDDZSnKD8gHCsO3ft0=;
        b=XC1aY9M5skuWuK3IOglVH/JXVx82jpDw2YqVRiCUyGzB0swFCN0+mZNZF/qbgja1+O
         YKPfD3ZONP4P4Tl6r0uelS35Npab4XRkZHIVT7mysBHgmyTIKD0mbxdWWSzd/bFDw8GP
         JCabHgThxUh1u9Lj8nWX8sWpi3GzOhgDSZW/pRnE8GJc6X0ycPENZ/IxqGu7hsQu73Ro
         Ne1sJ/6qzgIEA+4HDF01+U88Wi0PTQZ45iRpMwRBXW1Fxw+xK4luiMowu1/oCSqq3SqN
         k13llgAvstupV6bT+zSxFlSbTxMUZHr0mu71ZHQBbmN0qa7xNsRR6BX1t3iLivtStx79
         uMwA==
X-Gm-Message-State: AOJu0YxnMAp3X7J5Kgfo10Aai5tSU2NBqMMBQXA8LVwng4d6+6RAntrn
	OH88fZ7tC6tuhitUvki0PQCswvCZXUvXGwDJOVoFQ71V7OvSHTtkERCSSQ==
X-Google-Smtp-Source: AGHT+IHZsxzFkd5ylFHuJijeFxEp8uoL/hF8YCBc3RdDaS60s245SPW/YmwlO9H3Atox5BLe8D46dw==
X-Received: by 2002:a17:907:3f93:b0:a7a:9ca6:527 with SMTP id a640c23a62f3a-a991bd052b1mr360648666b.8.1728073294690;
        Fri, 04 Oct 2024 13:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784ecasm36431466b.119.2024.10.04.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 13:21:34 -0700 (PDT)
Message-Id: <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
In-Reply-To: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 20:21:32 +0000
Subject: [PATCH v4] remote: allow specifying refs to prefetch
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

When using 'git fetch --prefetch', all fetchable refs are prefetched
by default. In large repositories with many refs, this can lead to
unnecessary network traffic and increased disk space use.

Introduce a new configuration option 'remote.<name>.prefetchref' that
allows users to specify specific ref patterns to be prefetched during
a 'git fetch --prefetch' operation.

The 'prefetchref' option accepts a space-separated list of ref
patterns (e.g., 'refs/heads/main !refs/heads/feature/*'). When the
'--prefetch' option is used with 'git fetch', only the refs matching
these patterns will be prefetched.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    remote: introduce config to set prefetch refs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2Fpastelsky%2Fsk%2Fremote-prefetchref-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/pastelsky/sk/remote-prefetchref-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1782

Range-diff vs v3:

 1:  717d5957c47 ! 1:  e3d8aee1ea8 remote: introduce config to set prefetch refs
     @@ Metadata
      Author: Shubham Kanodia <shubham.kanodia10@gmail.com>
      
       ## Commit message ##
     -    remote: introduce config to set prefetch refs
     +    remote: allow specifying refs to prefetch
      
     -    This commit introduces a new configuration option,
     -    remote.<name>.prefetchref, which allows users to specify specific
     -    ref patterns to be prefetched during a git fetch --prefetch
     -    operation.
     +    When using 'git fetch --prefetch', all fetchable refs are prefetched
     +    by default. In large repositories with many refs, this can lead to
     +    unnecessary network traffic and increased disk space use.
      
     -    The new option accepts a space-separated list of ref patterns.
     -    When the --prefetch option is used with git fetch, only the refs
     -    matching these patterns will be prefetched, instead of the
     -    default behavior of prefetching all fetchable refs.
     +    Introduce a new configuration option 'remote.<name>.prefetchref' that
     +    allows users to specify specific ref patterns to be prefetched during
     +    a 'git fetch --prefetch' operation.
      
     -    Example usage in .git/config:
     -    [remote "origin"]
     -        prefetchref = "refs/heads/main refs/heads/feature/*"
     -
     -    This change allows users to optimize their prefetch operations, potentially
     -    reducing network traffic and improving performance for large repositories
     -    with many refs.
     +    The 'prefetchref' option accepts a space-separated list of ref
     +    patterns (e.g., 'refs/heads/main !refs/heads/feature/*'). When the
     +    '--prefetch' option is used with 'git fetch', only the refs matching
     +    these patterns will be prefetched.
      
          Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
      
     @@ Documentation/config/remote.txt: remote.<name>.fetch::
       	linkgit:git-fetch[1].
       
      +remote.<name>.prefetchref::
     -+    Specify the refs to be prefetched when fetching from this remote.
     -+    The value is a space-separated list of ref patterns (e.g., "refs/heads/master !refs/heads/develop*").
     -+    This can be used to optimize fetch operations by specifying exactly which refs should be prefetched.
     ++	Specify the refs to be prefetched when fetching from this
     ++	remote. The value is a space-separated list of ref patterns
     ++	(e.g., "refs/heads/main !refs/heads/develop*"). This can be
     ++	used to optimize fetch operations by specifying exactly which
     ++	refs should be prefetched.
      +
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
       	linkgit:git-push[1].
      
       ## builtin/fetch.c ##
     -@@
     - #include "trace.h"
     - #include "trace2.h"
     - #include "bundle-uri.h"
     -+#include "wildmatch.h"
     - 
     - #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
     - 
      @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
       	}
       }
       
     ++static int pattern_matches_ref(const char *pattern, const char *refname)
     ++{
     ++	if (strchr(pattern, '*'))
     ++		return match_refspec_name_with_pattern(pattern, refname, NULL, NULL) != 0;
     ++	return strcmp(pattern, refname) == 0;
     ++}
     ++
      +static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
      +{
     -+	int i;
     -+	int has_positive = 0;
     -+	int matched_positive = 0;
     -+	int matched_negative = 0;
     ++	int has_positive = 0, matched_positive = 0, matched_negative = 0;
      +
     -+	for (i = 0; i < prefetch_refs->nr; i++) {
     ++	for (int i = 0; i < prefetch_refs->nr; i++) {
      +		const char *pattern = prefetch_refs->items[i].string;
      +		int is_negative = (*pattern == '!');
     ++		if (is_negative) pattern++;
     ++		else has_positive = 1;
      +
     -+		if (is_negative)
     -+			pattern++;
     -+		else
     -+			has_positive = 1;
     -+
     -+		if (wildmatch(pattern, refname, 0) == 0) {
     -+			if (is_negative)
     -+				matched_negative = 1;
     -+			else
     -+				matched_positive = 1;
     ++		if (pattern_matches_ref(pattern, refname)) {
     ++			if (is_negative) matched_negative = 1;
     ++			else matched_positive = 1;
      +		}
      +	}
      +
     -+	if (!has_positive)
     -+		return !matched_negative;
     -+
     -+	return matched_positive && !matched_negative;
     -+}
     -+
     -+
     -+static void ref_remove(struct ref **head, struct ref *to_remove)
     -+{
     -+	struct ref **pp, *p;
     -+
     -+	for (pp = head; (p = *pp) != NULL; pp = &p->next) {
     -+		if (p == to_remove) {
     -+			*pp = p->next;
     -+			return;
     -+		}
     -+	}
     ++	return has_positive ? (matched_positive && !matched_negative) : !matched_negative;
      +}
      +
       static struct ref *get_ref_map(struct remote *remote,
       			       const struct ref *remote_refs,
       			       struct refspec *rs,
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 	struct hashmap existing_refs;
       	int existing_refs_populated = 0;
       
     ++	struct ref *prefetch_filtered_ref_map = NULL, **ref_map_tail = &prefetch_filtered_ref_map;
     ++	struct ref *next;
     ++
       	filter_prefetch_refspec(rs);
      +
       	if (remote)
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +	 * Filter out advertised refs that we don't want to fetch during
      +	 * prefetch if a prefetchref config is set
      +	 */
     ++
      +	if (prefetch && remote->prefetch_refs.nr) {
     -+		struct ref *ref, *next;
     -+		for (ref = ref_map; ref; ref = next) {
     -+			next = ref->next;
     ++		prefetch_filtered_ref_map = NULL;
     ++		ref_map_tail = &prefetch_filtered_ref_map;
     ++
     ++		for (rm = ref_map; rm; rm = next) {
     ++			next = rm->next;
     ++			rm->next = NULL;
      +
     -+			if (!matches_prefetch_refs(ref->name, &remote->prefetch_refs)) {
     -+					ref_remove(&ref_map, ref);
     -+					free_one_ref(ref);
     ++			if (matches_prefetch_refs(rm->name, &remote->prefetch_refs)) {
     ++				*ref_map_tail = rm;
     ++				ref_map_tail = &rm->next;
     ++			} else {
     ++				free_one_ref(rm);
      +			}
      +		}
     ++		ref_map = prefetch_filtered_ref_map;
      +	}
      +
       	ref_map = ref_remove_duplicates(ref_map);
     @@ remote.c: static int handle_config(const char *key, const char *value,
       	else if (!strcmp(subkey, "url")) {
       		if (!value)
       			return config_error_nonbool(key);
     +@@ remote.c: struct strvec *push_url_of_remote(struct remote *remote)
     + 	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
     + }
     + 
     +-static int match_name_with_pattern(const char *key, const char *name,
     ++int match_refspec_name_with_pattern(const char *key, const char *name,
     + 				   const char *value, char **result)
     + {
     + 	const char *kstar = strchr(key, '*');
     +@@ remote.c: static int refspec_match(const struct refspec_item *refspec,
     + 			 const char *name)
     + {
     + 	if (refspec->pattern)
     +-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
     ++		return match_refspec_name_with_pattern(refspec->src, name, NULL, NULL);
     + 
     + 	return !strcmp(refspec->src, name);
     + }
     +@@ remote.c: static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
     + 			const char *key = refspec->dst ? refspec->dst : refspec->src;
     + 			const char *value = refspec->src;
     + 
     +-			if (match_name_with_pattern(key, needle, value, &expn_name))
     ++			if (match_refspec_name_with_pattern(key, needle, value, &expn_name))
     + 				string_list_append_nodup(&reversed, expn_name);
     + 		} else if (refspec->matching) {
     + 			/* For the special matching refspec, any query should match */
     +@@ remote.c: static void query_refspecs_multiple(struct refspec *rs,
     + 		if (!refspec->dst || refspec->negative)
     + 			continue;
     + 		if (refspec->pattern) {
     +-			if (match_name_with_pattern(key, needle, value, result))
     ++			if (match_refspec_name_with_pattern(key, needle, value, result))
     + 				string_list_append_nodup(results, *result);
     + 		} else if (!strcmp(needle, key)) {
     + 			string_list_append(results, value);
     +@@ remote.c: int query_refspecs(struct refspec *rs, struct refspec_item *query)
     + 		if (!refspec->dst || refspec->negative)
     + 			continue;
     + 		if (refspec->pattern) {
     +-			if (match_name_with_pattern(key, needle, value, result)) {
     ++			if (match_refspec_name_with_pattern(key, needle, value, result)) {
     + 				query->force = refspec->force;
     + 				return 0;
     + 			}
     +@@ remote.c: static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
     + 			const char *dst_side = item->dst ? item->dst : item->src;
     + 			int match;
     + 			if (direction == FROM_SRC)
     +-				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
     ++				match = match_refspec_name_with_pattern(item->src, ref->name, dst_side, &name);
     + 			else
     +-				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
     ++				match = match_refspec_name_with_pattern(dst_side, ref->name, item->src, &name);
     + 			if (match) {
     + 				matching_refs = i;
     + 				break;
     +@@ remote.c: static struct ref *get_expanded_map(const struct ref *remote_refs,
     + 
     + 		if (strchr(ref->name, '^'))
     + 			continue; /* a dereference item */
     +-		if (match_name_with_pattern(refspec->src, ref->name,
     ++		if (match_refspec_name_with_pattern(refspec->src, ref->name,
     + 					    refspec->dst, &expn_name) &&
     + 		    !ignore_symref_update(expn_name, &scratch)) {
     + 			struct ref *cpy = copy_ref(ref);
      
       ## remote.h ##
      @@
     @@ remote.h: struct remote {
       	/*
       	 * The setting for whether to fetch tags (as a separate rule from the
       	 * configured refspecs);
     +@@ remote.h: int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref
     + 
     + int check_ref_type(const struct ref *ref, int flags);
     + 
     ++int match_refspec_name_with_pattern(const char *key, const char *name,
     ++					const char *value, char **result);
     ++
     + /*
     +  * Free a single ref and its peer, or an entire list of refs and their peers,
     +  * respectively.
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +		git checkout -b feature && test_commit feature-commit-2 &&
      +		git checkout -b wip/test && test_commit wip-test-commit-2 &&
      +		git checkout -b topic/x && test_commit topic-x-commit-2 &&
     -+		git push -f origin feature wip/test topic/x&&
     ++		git push -f origin feature wip/test topic/x &&
      +		cd .. &&
      +
      +		git config remote.remote2.prefetchref "refs/heads/feature" &&
     -+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     -+		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
     ++			--recurse-submodules=no --quiet" &&
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" \
     ++			git maintenance run --task=prefetch 2>/dev/null &&
      +		test_subcommand git fetch remote2 $fetchargs <prefetch-positive.txt &&
      +
      +		git rev-parse refs/prefetch/remotes/remote2/feature &&
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +		cd .. &&
      +
      +		git config remote.remote3.prefetchref "!refs/heads/wip/*" &&
     -+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     -+		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
     ++			--recurse-submodules=no --quiet" &&
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" \
     ++			git maintenance run --task=prefetch 2>/dev/null &&
      +		test_subcommand git fetch remote3 $fetchargs <prefetch-negative.txt &&
      +		git rev-parse refs/prefetch/remotes/remote3/feature &&
      +		git rev-parse refs/prefetch/remotes/remote3/topic/x &&
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +		git push -f origin feature topic/x topic/y &&
      +		cd .. &&
      +
     -+		git config remote.remote4.prefetchref "refs/heads/topic/* !refs/heads/topic/y" &&
     -+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     -+		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" git maintenance run --task=prefetch 2>/dev/null &&
     ++		git config remote.remote4.prefetchref \
     ++			"refs/heads/topic/* !refs/heads/topic/y" &&
     ++		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
     ++			--recurse-submodules=no --quiet" &&
     ++		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" \
     ++			git maintenance run --task=prefetch 2>/dev/null &&
      +		test_subcommand git fetch remote4 $fetchargs <prefetch-mixed.txt &&
      +
      +		test_must_fail git rev-parse refs/prefetch/remotes/remote4/feature &&


 Documentation/config/remote.txt |  7 +++
 builtin/fetch.c                 | 53 ++++++++++++++++++++
 remote.c                        | 24 ++++++----
 remote.h                        |  6 +++
 t/t7900-maintenance.sh          | 85 +++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..186f439ed7b 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,13 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetchref::
+	Specify the refs to be prefetched when fetching from this
+	remote. The value is a space-separated list of ref patterns
+	(e.g., "refs/heads/main !refs/heads/develop*"). This can be
+	used to optimize fetch operations by specifying exactly which
+	refs should be prefetched.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf2..74603cfabe0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -485,6 +485,32 @@ static void filter_prefetch_refspec(struct refspec *rs)
 	}
 }
 
+static int pattern_matches_ref(const char *pattern, const char *refname)
+{
+	if (strchr(pattern, '*'))
+		return match_refspec_name_with_pattern(pattern, refname, NULL, NULL) != 0;
+	return strcmp(pattern, refname) == 0;
+}
+
+static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
+{
+	int has_positive = 0, matched_positive = 0, matched_negative = 0;
+
+	for (int i = 0; i < prefetch_refs->nr; i++) {
+		const char *pattern = prefetch_refs->items[i].string;
+		int is_negative = (*pattern == '!');
+		if (is_negative) pattern++;
+		else has_positive = 1;
+
+		if (pattern_matches_ref(pattern, refname)) {
+			if (is_negative) matched_negative = 1;
+			else matched_positive = 1;
+		}
+	}
+
+	return has_positive ? (matched_positive && !matched_negative) : !matched_negative;
+}
+
 static struct ref *get_ref_map(struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *rs,
@@ -501,7 +527,11 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	struct ref *prefetch_filtered_ref_map = NULL, **ref_map_tail = &prefetch_filtered_ref_map;
+	struct ref *next;
+
 	filter_prefetch_refspec(rs);
+
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 
@@ -610,6 +640,29 @@ static struct ref *get_ref_map(struct remote *remote,
 	else
 		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
 
+	/**
+	 * Filter out advertised refs that we don't want to fetch during
+	 * prefetch if a prefetchref config is set
+	 */
+
+	if (prefetch && remote->prefetch_refs.nr) {
+		prefetch_filtered_ref_map = NULL;
+		ref_map_tail = &prefetch_filtered_ref_map;
+
+		for (rm = ref_map; rm; rm = next) {
+			next = rm->next;
+			rm->next = NULL;
+
+			if (matches_prefetch_refs(rm->name, &remote->prefetch_refs)) {
+				*ref_map_tail = rm;
+				ref_map_tail = &rm->next;
+			} else {
+				free_one_ref(rm);
+			}
+		}
+		ref_map = prefetch_filtered_ref_map;
+	}
+
 	ref_map = ref_remove_duplicates(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
diff --git a/remote.c b/remote.c
index 8f3dee13186..6752c73370f 100644
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
@@ -868,7 +876,7 @@ struct strvec *push_url_of_remote(struct remote *remote)
 	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
 }
 
-static int match_name_with_pattern(const char *key, const char *name,
+int match_refspec_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result)
 {
 	const char *kstar = strchr(key, '*');
@@ -900,7 +908,7 @@ static int refspec_match(const struct refspec_item *refspec,
 			 const char *name)
 {
 	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+		return match_refspec_name_with_pattern(refspec->src, name, NULL, NULL);
 
 	return !strcmp(refspec->src, name);
 }
@@ -969,7 +977,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 			const char *key = refspec->dst ? refspec->dst : refspec->src;
 			const char *value = refspec->src;
 
-			if (match_name_with_pattern(key, needle, value, &expn_name))
+			if (match_refspec_name_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
 		} else if (refspec->matching) {
 			/* For the special matching refspec, any query should match */
@@ -1014,7 +1022,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
+			if (match_refspec_name_with_pattern(key, needle, value, result))
 				string_list_append_nodup(results, *result);
 		} else if (!strcmp(needle, key)) {
 			string_list_append(results, value);
@@ -1043,7 +1051,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
+			if (match_refspec_name_with_pattern(key, needle, value, result)) {
 				query->force = refspec->force;
 				return 0;
 			}
@@ -1456,9 +1464,9 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 			const char *dst_side = item->dst ? item->dst : item->src;
 			int match;
 			if (direction == FROM_SRC)
-				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
+				match = match_refspec_name_with_pattern(item->src, ref->name, dst_side, &name);
 			else
-				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
+				match = match_refspec_name_with_pattern(dst_side, ref->name, item->src, &name);
 			if (match) {
 				matching_refs = i;
 				break;
@@ -2076,7 +2084,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (match_name_with_pattern(refspec->src, ref->name,
+		if (match_refspec_name_with_pattern(refspec->src, ref->name,
 					    refspec->dst, &expn_name) &&
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);
diff --git a/remote.h b/remote.h
index b901b56746d..9ffef206f23 100644
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
@@ -207,6 +210,9 @@ int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref
 
 int check_ref_type(const struct ref *ref, int flags);
 
+int match_refspec_name_with_pattern(const char *key, const char *name,
+					const char *value, char **result);
+
 /*
  * Free a single ref and its peer, or an entire list of refs and their peers,
  * respectively.
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..fc1b5d14e75 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,91 @@ test_expect_success 'prefetch multiple remotes' '
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
+		git push -f origin feature wip/test topic/x &&
+		cd .. &&
+
+		git config remote.remote2.prefetchref "refs/heads/feature" &&
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
+			--recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-positive.txt" \
+			git maintenance run --task=prefetch 2>/dev/null &&
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
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
+			--recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-negative.txt" \
+			git maintenance run --task=prefetch 2>/dev/null &&
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
+		git config remote.remote4.prefetchref \
+			"refs/heads/topic/* !refs/heads/topic/y" &&
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head \
+			--recurse-submodules=no --quiet" &&
+		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" \
+			git maintenance run --task=prefetch 2>/dev/null &&
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
