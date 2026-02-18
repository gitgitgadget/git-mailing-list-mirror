Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF0335540
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453478; cv=pass; b=dYHHIOUWeOCoGNGo9XG1HPfil1H3311DHJ2Gb7BZ1/hqsmisZYei0uzLcl1xi5W0x19LZp8G9FJ4flmP8INsBOwhw21IVnA2qiyu9J4r2ocvmKc8Yj919GwZM2+TOo5jCtUX1T/PmvRIcGFAe54nSQS+h0SyPVhFlp4xl2yTHbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453478; c=relaxed/simple;
	bh=hIog7y5gJ63TTibymINv43QAXbeZqbNK2d0bzTuFSaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPdh23v33tlexHEeSLQSJL2hqEIh94CRv0K+NLB/J3CDbohjVrFKVcTtPBEc4LeUZg1YSB4Ke+mex0uZfAZJYyb8cwJAt40jwz98gukywLI3YifZtzFkdQjbe71/aAsK66/KSYpPQGOj2Zqci14tWT7Lxs4jGY4B9g1o88A/XhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ip6xfRcF; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ip6xfRcF"
ARC-Seal: i=1; a=rsa-sha256; t=1771453465; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XkUQLOCndMV8gDZumClu8Stz16Oio4i+ACi4WsunhESJjqjAgo2gwKlN0YvVytZQONsH6yPkoE/hulnlJfH4Q3CU0OX8ChcWDJ+nB7eMiWQpSpkLqkVsrfwCUUvaHHffJFyt/abjGaGR3tSAm/VIzccXtvEuE4hx7c42xeJ3rIk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453465; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vRXCdlK2LWNDQnY1N1DnBkAEhR/CswvsmFGAIR6lpAs=; 
	b=BT6MJjm37foQZjnIA6BIEOtFGTdXMFC2imUJm6qSPFa7zO4olvBePSoFEgVpSwHvIX49/QClciRjYSFZ9aFwfdUsLgF4CrV5BMjFJ7jWh2KXaGjkTb1WTbAUwF9AI9gLuDcylyjvUypyd1BIoN6FU+ek5a4hAGEXGKosFQvd674=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453465;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vRXCdlK2LWNDQnY1N1DnBkAEhR/CswvsmFGAIR6lpAs=;
	b=ip6xfRcFa6jCoMG1ho3Darp3ubgsTJAnfstZz7ilZJFhau2qJGYntMYIXTfQGScz
	lsG3EdcnCZ4w+a1PYPGsdxyQGCdJ2U6Zi4iTOgrZqcniBU6/xd+/B/rhu5psKDQYmxK
	GyNt4sXpkJkb2sFOW6nSJ3Qa91QrAfOEeHD7i3Wo=
Received: by mx.zohomail.com with SMTPS id 1771453462162248.13190237979336;
	Wed, 18 Feb 2026 14:24:22 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 7/8] hook: allow out-of-repo 'git hook' invocations
Date: Thu, 19 Feb 2026 00:23:51 +0200
Message-ID: <20260218222352.55393-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Since hooks can now be supplied via the config, and a config can be
present without a gitdir via the global and system configs, we can start
to allow 'git hook run' to occur without a gitdir. This enables us to do
things like run sendemail-validate hooks when running 'git send-email'
from a nongit directory.

It still doesn't make sense to look for hooks in the hookdir in nongit
repos, though, as there is no hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 git.c           |  2 +-
 hook.c          | 30 ++++++++++++++++++++++++++++--
 t/t1800-hook.sh | 16 +++++++++++-----
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/git.c b/git.c
index 744cb6527e..6480ff8373 100644
--- a/git.c
+++ b/git.c
@@ -587,7 +587,7 @@ static struct cmd_struct commands[] = {
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "history", cmd_history, RUN_SETUP },
-	{ "hook", cmd_hook, RUN_SETUP },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index fee0a7ab4f..2c8252b2c4 100644
--- a/hook.c
+++ b/hook.c
@@ -18,6 +18,9 @@ const char *find_hook(struct repository *r, const char *name)
 
 	int found_hook;
 
+	if (!r || !r->gitdir)
+		return NULL;
+
 	repo_git_path_replace(r, &path, "hooks/%s", name);
 	found_hook = access(path.buf, X_OK) >= 0;
 #ifdef STRIP_EXTENSION
@@ -268,12 +271,18 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_clear(&cb_data.event_hooks, 0);
 }
 
-/* Return the hook config map for `r`, populating it first if needed. */
+/*
+ * Return the hook config map for `r`, populating it first if needed.
+ *
+ * Out-of-repo calls (r->gitdir == NULL) allocate and return a temporary
+ * cache map; the caller is responsible for freeing it with
+ * hook_cache_clear() + free().
+ */
 static struct strmap *get_hook_config_cache(struct repository *r)
 {
 	struct strmap *cache = NULL;
 
-	if (r) {
+	if (r && r->gitdir) {
 		/*
 		 * For in-repo calls, the map is stored in r->hook_config_cache,
 		 * so repeated invocations don't parse the configs, so allocate
@@ -285,6 +294,14 @@ static struct strmap *get_hook_config_cache(struct repository *r)
 			build_hook_config_map(r, r->hook_config_cache);
 		}
 		cache = r->hook_config_cache;
+	} else {
+		/*
+		 * Out-of-repo calls (no gitdir) allocate and return a temporary
+		 * map cache which gets free'd immediately by the caller.
+		 */
+		cache = xcalloc(1, sizeof(*cache));
+		strmap_init(cache);
+		build_hook_config_map(r, cache);
 	}
 
 	return cache;
@@ -315,6 +332,15 @@ static void list_hooks_add_configured(struct repository *r,
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
+
+	/*
+	 * Cleanup temporary cache for out-of-repo calls since they can't be
+	 * stored persistently. Next out-of-repo calls will have to re-parse.
+	 */
+	if (!r || !r->gitdir) {
+		hook_cache_clear(cache);
+		free(cache);
+	}
 }
 
 struct string_list *list_hooks(struct repository *r, const char *hookname,
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index fb6bc554b9..e58151e8f8 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -131,12 +131,18 @@ test_expect_success 'git hook run -- pass arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git hook run -- out-of-repo runs excluded' '
-	test_hook test-hook <<-EOF &&
-	echo Test hook
-	EOF
+test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
 
-	nongit test_must_fail git hook run test-hook
+	echo "global-hook" >expect &&
+	nongit git hook list test-hook >actual &&
+	test_cmp expect actual &&
+
+	echo "no repo no problems" >expect &&
+
+	nongit git hook run test-hook 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
-- 
2.52.0.732.gb351b5166d.dirty

