Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2233D8
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741445; cv=none; b=bEldO7aRQj8Z34UT+ADQ0SbkJTHQ/tp6X6qEjsMMA/1GjPVN10oLtPF6B+Ip4kWflGLVvmWMV3/m91Y/f6NQtt7S/NUaAWdq8XNoxwPMlEvW+4EJ3wcOdyhe5OjOiLELukB08Rc6xOf++KWLRTkq+kfJcgSjlddjoEbozoENOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741445; c=relaxed/simple;
	bh=pYmUu6oaBxYbCMqd8yL01Yn2RYC3LLdg3vhUzgQ4mZw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HfFpzk9hc8im09ividB5zi4e0TIabxulUySUd8b22/pjKIMLhUSD1DdHKQXnVWj2pF8GxkkS3uJS2kOgwzQJaD77RCzacM5RoOL4mBGBoFYwbu1TMG2cfpED4IGTC+pZcNMEgSyNFhJ8qfEFNTXH36IF9iePEPc4ANd1NJH/YXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR0n2clc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR0n2clc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso1109575a12.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726741442; x=1727346242; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV6UWUgDfSc6l4XZyUG9aep0Wyug43ZUIdlppRh0OpA=;
        b=BR0n2clcwMv0cM+Hx4uPOVRzPBtrx/ENmTX0SEyvAA7A6QVu83uTGRYbtKYbW86wIn
         O5XL6vHEsQsYT0y3g1139JH2r8N9mM2PxsWhWRVfxvsojOZfHJ7lncNt+vqz+RYrdfU3
         EmzjtgLyoq03sQTDHFxdEkMpq3Xa7EIu5rlbBov8zZJ5/X8L5VAx5gNGxYYqoU11yKib
         a8igFk8zhr0sqJCpcKGxzWJLD/WGY2o9tOkub5UXNzU6Y6nNnPRSgJhMwQvbwztU+554
         4KI0LEc6BtCxcjZ3ixF3SLmKtCdhYO+/nwkgXDMivsi8q1S6mrWz+WUldiu/L/F/CLd0
         W1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726741442; x=1727346242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV6UWUgDfSc6l4XZyUG9aep0Wyug43ZUIdlppRh0OpA=;
        b=SQLfrLnTGf5d/hKW1Dbyfc0pV5g33gmC8VUbIcM4628Y4qCMbAiBAXLuIh4W2MejP1
         Y7j3lC5DEv7C9IxgLKL9Ix/JP4j/FTUMa8TOwXJZQCrL3y2YCcucd+8oualiYtHAsZG6
         MzuS1wuc5/AgpLhcoCU5UigkeFayLvbVwwoz7Zpp+LJoiJO30MxcP7OOYGRUJDV2jIN4
         zb5yByNq/rxomXw/atQh33wfNbmo919I3+LvlJgZNlGA6u9amCDk6haRXpUgtINkvAwr
         ZHjRXmsBNjoyjXhMrRenRj09sxolf6aHadh8RMorYDJbP2iCrS289bTbt8NX5ojF78mr
         6Fmg==
X-Gm-Message-State: AOJu0Yyvc8mikNeO3e40oisHqstqtby3EpejmWhfee5qvw1kCr/6TOzh
	7NQ2y8FTW3WbdmdSCFUV9VrKOlK2gG3XEB2eCeomPeadFIwX0i54L48png==
X-Google-Smtp-Source: AGHT+IGEWj+PgwUmg9qyFwCF11mGKK2+OqUF2+TSchTanGegT17irnJEJbF1nZMclUZSAGI0KmCp3Q==
X-Received: by 2002:a05:6402:13d3:b0:5c4:14ba:9cd7 with SMTP id 4fb4d7f45d1cf-5c4592223ecmr2708241a12.10.1726741441410;
        Thu, 19 Sep 2024 03:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb56b8bsm5934372a12.38.2024.09.19.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:24:00 -0700 (PDT)
Message-Id: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
In-Reply-To: <pull.1782.v2.git.1726409329993.gitgitgadget@gmail.com>
References: <pull.1782.v2.git.1726409329993.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 10:23:59 +0000
Subject: [PATCH v3] remote: introduce config to set prefetch refs
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2Fpastelsky%2Fsk%2Fremote-prefetchref-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/pastelsky/sk/remote-prefetchref-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1782

Range-diff vs v2:

 1:  f9f9e637bfa ! 1:  717d5957c47 remote: introduce config to set prefetch refs
     @@ Documentation/config/remote.txt: remote.<name>.fetch::
       
      +remote.<name>.prefetchref::
      +    Specify the refs to be prefetched when fetching from this remote.
     -+    The value is a space-separated list of ref patterns (e.g., "refs/heads/master refs/heads/develop*").
     -+    These patterns are used as the source part of the refspecs for prefetching.
     ++    The value is a space-separated list of ref patterns (e.g., "refs/heads/master !refs/heads/develop*").
      +    This can be used to optimize fetch operations by specifying exactly which refs should be prefetched.
      +
       remote.<name>.push::
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
      +		cd .. &&
      +
      +		git config remote.remote4.prefetchref "refs/heads/topic/* !refs/heads/topic/y" &&
     -+		# git config --add remote.remote4.prefetchref "!refs/topic/y" &&
     -+		cat .git/config &&
      +		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
      +		GIT_TRACE2_EVENT="$(pwd)/prefetch-mixed.txt" git maintenance run --task=prefetch 2>/dev/null &&
      +		test_subcommand git fetch remote4 $fetchargs <prefetch-mixed.txt &&


 Documentation/config/remote.txt |  5 +++
 builtin/fetch.c                 | 61 ++++++++++++++++++++++++++
 remote.c                        |  8 ++++
 remote.h                        |  3 ++
 t/t7900-maintenance.sh          | 78 +++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..b04ee0c4c22 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetchref::
+    Specify the refs to be prefetched when fetching from this remote.
+    The value is a space-separated list of ref patterns (e.g., "refs/heads/master !refs/heads/develop*").
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
index abae7a97546..054f1f06f95 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,84 @@ test_expect_success 'prefetch multiple remotes' '
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
