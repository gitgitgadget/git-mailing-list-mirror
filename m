Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835A3806D2
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367732; cv=none; b=oRnNqPj9FOBJgcshox5kM1FnJ72aBFKsNLhbHeOHGJT1iaNtAMaIJu4KPBzWw74S3bE38/39rM0qZcrLd1i10RLiedVLF0AgrRCApQcmTNjIMNU0dQ+2o/K99WCslhj4955AsN3w+Uyx1ppC17HaXPBQ8YlIrMUrU4WaR1oeiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367732; c=relaxed/simple;
	bh=9/UyBj0zJoVSFtD20mhThGjEaqBS8o0k+zbBHvzFRaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7IVaA83g6YPFZd3e1nhfkF9q7LjUx2QGECJeSIIg6jgsyBVMPAyZ13ZWWEswPkCdGLVjCR3QFBWE2Yq4iat/1QdQyq9SXmQpNS/sk+kwShmW+l4ZByUOvf1Ci3W9xsDqiVvAhDTfzanb550cGJppyLguQrGSdmC6tkvpwU3RWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhtSovkO; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtSovkO"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso563797eec.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792367730; x=1792972530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EycEQjSBOvhlbu1rMlaspOV2zy533YjSFBNr5ghMLy8=;
        b=BhtSovkOeywsZJJ/sZX6VHm44cnNqAKcY1iZCYuYrCC0/bGjtUxXvgEJJh/WDEiH0R
         Cq19RoD0clsulvkNRFy1ELLx7zcWgAxt5Q7K54ySOGbN3+3FiKC1DcTsXSZIw1I4Lm5c
         BYmQ9JsyKmkeP6vbM7kbONxUd4j4PvcZQanXvBu8p3PJDB3DR9F4lcw0IKlHzw0HIEdW
         MzSr3fKDewqKaPurMRDaa7REjP3YbKs4ik5PCRGQ8nfRpoULofLUTkuypidp75Xx7yqC
         /7qGXI+DiyAHXK0bkyz3iDf9nZScZZU6gAI6BnQado3TvrcCD6878rxdtyjOnDMUw+on
         E0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792367730; x=1792972530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EycEQjSBOvhlbu1rMlaspOV2zy533YjSFBNr5ghMLy8=;
        b=FAEZ1Cz+PAJ6bjNiyTb/v/+cDbqtMHrDtsSe9JkV8gSxnNpBBkY9zzy7QV173OeNRC
         y5hxbResa2req4h7C9AwWEJzSt/jsaltNWR+bDmfPSpNb0vFyUbU3no1xxaWEBk7GS4D
         ltnAjJQN5fMenKzTAK2F52XAE2I9lCRecP0GEwz4uBcS+u9PmjrBGZuPIZh8LBuGrTjE
         2vBzSD+dgRMtq6jd9NrASW8gAnWxjli62MNCb8EFQR5f5ih9kTLaofMC/yUYhvcp6elm
         WXRxM71V9lAD/BCC9MBvxsGG3JF3XZenZeNJh7eF1Q4pkhMqnmAdDxSEp1XkejYZmUpO
         64CA==
X-Gm-Message-State: AFq9FYKw9U4OXoqREYFubA7yHg7U2x0M1StiJzXl1oTB4M6EUDBsWRss
	pod0K0cSe0YLWXwwRZyjQcyqfNk1anWvo/j0J4ISdulH43axnOGCPqrgmoZFe3ot
X-Gm-Gg: AYBFou3+hEl+mQr8QR19pPvvmxuGJxYFAsAuVZ8Lcz32xCxcRnqgdfLK9ACHJxVRB0W
	h1LqbTmvOk1ez5ypyBma+IwRFz0e+keigXBXi2WAdwKGov94JhbigQNF5D6qU53r7tWBQF2P4Jh
	ejTM88ljT4KT0UgpIh/x+Eu8hXu3LkP13V4RsXCYvTxC1yVcMMCgcgFNxYbqwOzXx1AzNEjc/g8
	gc2jGEcuJtSY3JrtP0HRqxXETZXbMJ5jikwq6DtKsQ9F0qtxAUTK5NtZcl1mgE/tG8tcm02xup5
	uXqyeEzerOhuhVyHCoOrutPnsI9xmv5UkX/6OucweWxWDQ2pXjwYoamjP4RZx1F0qEEPHP/xu1q
	ktKF8f3mcbb8bMoepzkMGcFF72xHR2NvWC3wQwHHWFAnWr75dx49syGbz7pYT+onC3l61A9Kac2
	1+FhfxLnvQCVgUykW6bJCGy58OrrzFoqY86lLbbsGkAwU4NQcX0yJoVOjO8I3W7G7JPA2R0qIDX
	RxYRhy0mgA2p/hq72WtJzNupGG5jYT6
X-Received: by 2002:a05:7301:2710:b0:360:b8b4:840a with SMTP id 5a478bee46e88-361a2747820mr10213049eec.39.1792367729989;
        Sun, 18 Oct 2026 16:55:29 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm43057006eec.12.2026.10.18.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:55:29 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v1] remote.c: defer remote.<name>.followRemoteHEAD validation
Date: Sun, 18 Oct 2026 16:55:07 -0700
Message-ID: <20261018235508.848-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing from 86129fd (fetch.c: defer fetch.followRemoteHEAD
validation), apply the same treatment to
remote.<name>.followRemoteHEAD, which is still validated in
handle_config(). That emits a warning for any command that loads the
remote configuration, such as "git push" or "git remote -v", even
though only "git fetch" ever consults the value.

Store the raw string in struct remote instead, and resolve it lazily
in do_fetch() through the get_follow_remote_head() helper introduced
by 86129fd. This replaces the parsed follow_remote_head and
no_warn_branch members, and the NEEDSWORK comment left behind by
86129fd is removed. "git remote set-head" now compares against the
raw string to decide whether to rewrite "always" to "warn".

Because both settings now go through the same parser,
fetch.followRemoteHEAD accepts "warn-if-not-<branch>", which
previously was only recognized for remote.<name>.followRemoteHEAD.
Document it under fetch.followRemoteHEAD, drop the remote-specific
paragraph, and add tests for the new fetch-level form.

Messages for an unrecognized or missing value no longer name the
fetch. prefix, as the helper now serves both the fetch-level and
the remote-level setting.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 Documentation/config/fetch.adoc  |  3 +++
 Documentation/config/remote.adoc |  4 ----
 builtin/fetch.c                  | 26 +++++++++++++-------------
 builtin/remote.c                 |  2 +-
 remote.c                         | 28 ++++------------------------
 remote.h                         |  4 ++--
 t/t5510-fetch.sh                 | 28 ++++++++++++++++++++++++++++
 7 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 00435e9a16..5e70949c2b 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -139,6 +139,9 @@ remove the value for the `fetch.bundleCreationToken` value before fetching.
 `warn`;;
 	Display a warning if the remote advertises a different `HEAD` than what is
 	set locally.  Behaves like "create" if the local symbolic-ref doesn't exist.
+`warn-if-not-<branch>`;;
+	Like "warn", but do not display the warning if the remote's `HEAD`
+	is `remotes/<name>/<branch>`.
 `always`;;
 	Silently update `remotes/<name>/HEAD` whenever the remote advertises a new
 	value.
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..56b036fc98 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -171,7 +171,3 @@ remote.<name>.followRemoteHEAD::
 	`remotes/<name>/HEAD` symbolic-ref.  Overrides the value of
 	`fetch.followRemoteHEAD`.  See `fetch.followRemoteHEAD` for a description of
 	accepted values.
-+
-In addition to the values supported by `fetch.followRemoteHEAD`, this setting
-may also take on the value "warn-if-not-`$branch`", which behaves like "warn",
-but ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1f76ae6242..aa112f9b5a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -187,19 +187,23 @@ static int git_fetch_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
-static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting,
+    const char **no_warn_branch)
 {
+	*no_warn_branch = NULL;
 	if (!setting)
-		die(_("missing value for 'fetch.followRemoteHEAD'"));
+		die(_("missing value for 'followRemoteHEAD'"));
 	else if (!strcmp(setting, "never"))
 		return FOLLOW_REMOTE_NEVER;
 	else if (!strcmp(setting, "create"))
 		return FOLLOW_REMOTE_CREATE;
 	else if (!strcmp(setting, "warn"))
 		return FOLLOW_REMOTE_WARN;
+	else if (skip_prefix(setting, "warn-if-not-", no_warn_branch))
+		return FOLLOW_REMOTE_WARN;
 	else if (!strcmp(setting, "always"))
 		return FOLLOW_REMOTE_ALWAYS;
-	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
+	warning(_("unrecognized followRemoteHEAD value '%s' ignored"), setting);
 	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 }
 
@@ -1760,12 +1764,11 @@ static void warn_set_head(const char *remote, const char *head_name,
 }
 
 static int set_head(const struct ref *remote_refs, struct remote *remote,
-			int follow_remote_head)
+		    int follow_remote_head, const char *no_warn_branch)
 {
 	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
-	const char *no_warn_branch = remote->no_warn_branch;
 	char *head_name = NULL;
 	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
@@ -1955,6 +1958,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
+	const char *no_warn_branch = NULL;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1978,14 +1982,10 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			/*
-			 * See remote.c's handling of remote.<name>.followRemoteHEAD
-			 * for the analogous, still-unresolved case.
-			 */
-			if (transport->remote->follow_remote_head)
-				follow_remote_head = transport->remote->follow_remote_head;
+			if (transport->remote->follow_remote_head_seen)
+				follow_remote_head = get_follow_remote_head(transport->remote->follow_remote_head_raw, &no_warn_branch);
 			else if (config->follow_remote_head_seen)
-				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw, &no_warn_branch);
 			else
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
@@ -2195,7 +2195,7 @@ static int do_fetch(struct transport *transport,
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
 		 */
-		set_head(remote_refs, transport->remote, follow_remote_head);
+		set_head(remote_refs, transport->remote, follow_remote_head, no_warn_branch);
 	}
 
 cleanup:
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..92eaffb4a0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1606,7 +1606,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	}
 	if (opt_a)
 		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
-	if (remote->follow_remote_head == FOLLOW_REMOTE_ALWAYS) {
+	if (remote->follow_remote_head_raw && !strcmp(remote->follow_remote_head_raw, "always")) {
 		struct strbuf config_name = STRBUF_INIT;
 		strbuf_addf(&config_name,
 			"remote.%s.followremotehead", remote->name);
diff --git a/remote.c b/remote.c
index 49ee2ea318..fa230005ff 100644
--- a/remote.c
+++ b/remote.c
@@ -184,6 +184,7 @@ static void remote_clear(struct remote *remote)
 	string_list_clear(&remote->server_options, 0);
 	string_list_clear(&remote->negotiation_restrict, 0);
 	string_list_clear(&remote->negotiation_include, 0);
+	free(remote->follow_remote_head_raw);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -581,30 +582,9 @@ static int handle_config(const char *key, const char *value,
 		return parse_transport_option(key, value,
 					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
-		const char *no_warn_branch;
-		/*
-		 * NEEDSWORK: this is validated/warned about here, during config
-		 * parsing, regardless of whether the fetch that triggered this
-		 * parse will ever consult it for this particular remote. See
-		 * fetch.c's deferred handling of fetch.followRemoteHEAD for the
-		 * pattern this should likely follow.
-		 */
-		if (!strcmp(value, "never"))
-			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(value, "create"))
-			remote->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(value, "warn")) {
-			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch = NULL;
-		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
-			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch = no_warn_branch;
-		} else if (!strcmp(value, "always")) {
-			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
-		} else {
-			warning(_("unrecognized followRemoteHEAD value '%s' ignored"),
-				value);
-		}
+		free(remote->follow_remote_head_raw);
+		remote->follow_remote_head_raw = xstrdup_or_null(value);
+		remote->follow_remote_head_seen = 1;
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index cca02033b9..e80beee6bb 100644
--- a/remote.h
+++ b/remote.h
@@ -122,8 +122,8 @@ struct remote {
 	struct string_list negotiation_restrict;
 	struct string_list negotiation_include;
 
-	enum follow_remote_head_settings follow_remote_head;
-	const char *no_warn_branch;
+	char *follow_remote_head_raw;
+	int follow_remote_head_seen;
 };
 
 /**
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 17c0be499c..1e5ad50912 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -290,6 +290,34 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is di
 	test "z$head" = "z$branch"
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn-if-not-branch branch is same" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "warn-if-not-main" &&
+	actual=$(git -C two fetch) &&
+	test "z" = "z$actual" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
+'
+
+test_expect_success "fetch test default followRemoteHEAD warn-if-not-branch branch is different" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "warn-if-not-some/different-branch" &&
+	git -C two fetch >actual &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have ${SQ}other${SQ} locally." >expect &&
+	test_cmp expect actual &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
+'
+
 test_expect_success "fetch test default followRemoteHEAD always" '
 	git -C two rev-parse --verify refs/remotes/origin/other &&
 	git -C two remote set-head origin other &&
-- 
2.55.0.windows.3

