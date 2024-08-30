Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE00175D30
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009003; cv=none; b=E8JDQ8HxIQuMEKE9MSfpDTti2RNVXyAyDGrg0QlQLqsNm/0h4fXIYVp8WbuWn65OcxXfcAnjy0JYSKxykxUWgYPD66k0Mi19YXOhu2HycpLGEnlgnXEgu9U9P4hMygATJ1DCVrQmA4/cnsTAH6rOGmL/awqsfLM4ZoYRmvM8PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009003; c=relaxed/simple;
	bh=Iu3vDPgNXAZDAIcgXXU9Ke5jUY1p9Ytsn2EzS5cGhxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shwm0dSzsXhNlOi4ElVlLSK0Chkf4RNBUKvNzkos3FPHPhln44LJgiEd/7dOW9qbGP6J/0Zcz54MC/5r2j0cnLUlb1OGeCGN/SDEF9lc/6o4mBTGajoHKsAn3V08ryI+QKCk3KRA5E/72+NZiUgWSasIv7Pp1OzkSVg5gnLny6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qAEWl/UI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsIdeeFv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qAEWl/UI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsIdeeFv"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C8A681140229;
	Fri, 30 Aug 2024 05:10:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Aug 2024 05:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725009000; x=1725095400; bh=P3Tz/e7OIr
	UM3+si6TKcKwZZaFdVeqDfPakrWKeU4PM=; b=qAEWl/UIlq6tiGYvY2xgJsepSx
	6aOCsaVX81vjosCb38tVNlDBoTsZo1l0ZcSfQmlokXa4HCfzGwCkso8ELlmq546T
	5RoKSoJZps+5gdZZ2uJlLu3hzGRK4uhMHu6HWjtDqdwxuf+8Dx9rif2NrG2sIiVa
	SfWHsWmBZq+f5sS4cDzhBf+zbRC45ThHGnHMqj4N8M5yv42BFVMisr0ouWy/0bp8
	Bh/I/Ld4rav8873dwLJnRKMgzbQzaeVzyKdRDw3RjyUAh56yvB0UYQ4dfEK0CWuv
	aoBVwGx0LxlZOY5FYOwU8vHZFqHLozvRUV1gLpbPqoDicSygEHdlCrsE8JXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725009000; x=1725095400; bh=P3Tz/e7OIrUM3+si6TKcKwZZaFdV
	eqDfPakrWKeU4PM=; b=NsIdeeFvoA8CwTAM8DDLMqI2lTLJWCks35bgYX6s0puc
	qqat81KeobNPhEP2eJUfWv/n2XEjyvnOklutBRk6yAPpsu61GxNrMSTTrf9apjAQ
	Fao1ROodzO8sCdBMLZFxe92JV095HmJZpy/ED6zsHjAPD+nKRyuC68Yco/gFCbQa
	9/KbH3jvQvCK53DnJLlGio3azw5v22V6msjKpEL5N6BCR+hnY7lhmBtwhZf0FRB8
	BffAXjG1MYNPUdKuez3wN13UqzV9PXOOnCgGqIfBhoBpSqBj75Mrmh1ALyT8VaTY
	xcqcbUfq/pj10Y677tgm9/sVof3QX+wIh8KQsKzXWw==
X-ME-Sender: <xms:aIzRZh09I9J_e-vhS1jrrw5Azg66lRP5ydM3xC0c1n2_Ij-BDGQWuw>
    <xme:aIzRZoEvm-YHNMZ0lvdSI-kUbDy6dVmcmPKdzPI9Hdp9uR43nHawX7rrBFE1mS7rM
    SNz108BC3tvNQ4TsA>
X-ME-Received: <xmr:aIzRZh54DT0y2udcoNUxNk1kIpgj2g8992Tfqi5hUEXZ56NPlv2qaLIosdU9MIlQtxVVlsRItw2ziWoxG5jqubHV2ldGV5AjuyAzSbv7Jl1rH7odjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeffeetteekudekffevudefgfelhefgteffhfdvveff
    keevleevjeejfefgfeeinecuffhomhgrihhnpeifrghrnhgrmhgsihhguhhouhhsrhgvfh
    hsrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:aIzRZu2EMh2JMnvAvtBeDZ_grroN8D0F29H7ROjoQhzxk1UrS_4bGA>
    <xmx:aIzRZkFLrx4H04wGJhv8sJo362Q5f111-RHTxcpWFyvTc4FeE3J71A>
    <xmx:aIzRZv8MEs2OZmoBq-oBg4efRFJJ2KHOaQ11XaCZ3tjFMpUQTjIKsA>
    <xmx:aIzRZhk0DhhLWfVFlI8LsxIwGIfJLWrsyPQnamJcrJrtZBrucGO6iQ>
    <xmx:aIzRZgjNvk8owUAf5Qgd5niZgl3WN0zxiw0Fp_FBHdhzuijvmFh4D_yO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25444885 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:49 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/21] environment: stop storing "core.warnAmbiguousRefs"
 globally
Message-ID: <fc6fcebf7f737617c635b338e3c0dce10e77881c.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

Same as the preceding commits, storing the "core.warnAmbiguousRefs"
value globally is misdesigned as this setting may be set per repository.

Move the logic into the repo-settings subsystem. The usual pattern here
is that users are expected to call `prepare_repo_settings()` before they
access the settings themselves. This seems somewhat fragile though, as
it is easy to miss and leads to somewhat ugly code patterns at the call
sites.

Instead, introduce a new function that encapsulates this logic for us.
This also allows us to change how exactly the lazy initialization works
in the future, e.g. by only partially initializing values as requested
by the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c | 4 +++-
 config.c            | 5 -----
 environment.c       | 1 -
 environment.h       | 1 -
 object-name.c       | 5 +++--
 ref-filter.c        | 3 ++-
 refs.c              | 4 ++--
 repo-settings.c     | 9 +++++++++
 repo-settings.h     | 4 ++++
 9 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5108266daf..34b46754426 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -19,6 +19,7 @@
 #include "path.h"
 #include "diff.h"
 #include "read-cache-ll.h"
+#include "repo-settings.h"
 #include "repository.h"
 #include "revision.h"
 #include "setup.h"
@@ -899,7 +900,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (opt_with_value(arg, "--abbrev-ref", &arg)) {
 				abbrev_ref = 1;
-				abbrev_ref_strict = warn_ambiguous_refs;
+				abbrev_ref_strict =
+					repo_settings_get_warn_ambiguous_refs(the_repository);
 				if (arg) {
 					if (!strcmp(arg, "strict"))
 						abbrev_ref_strict = 1;
diff --git a/config.c b/config.c
index a59890180a3..53c68f3da61 100644
--- a/config.c
+++ b/config.c
@@ -1447,11 +1447,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.warnambiguousrefs")) {
-		warn_ambiguous_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index 6805c7b01df..9dd000cda36 100644
--- a/environment.c
+++ b/environment.c
@@ -35,7 +35,6 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
 char *git_commit_encoding;
diff --git a/environment.h b/environment.h
index 0cab644e2d3..aa38133da9c 100644
--- a/environment.h
+++ b/environment.h
@@ -156,7 +156,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
diff --git a/object-name.c b/object-name.c
index 09c1bd93a31..c892fbe80aa 100644
--- a/object-name.c
+++ b/object-name.c
@@ -20,6 +20,7 @@
 #include "pretty.h"
 #include "object-store-ll.h"
 #include "read-cache-ll.h"
+#include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
 #include "midx.h"
@@ -959,7 +960,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
+		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
@@ -1020,7 +1021,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	if (!refs_found)
 		return -1;
 
-	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
+	if (repo_settings_get_warn_ambiguous_refs(r) && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
 	     !get_short_oid(r, str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
diff --git a/ref-filter.c b/ref-filter.c
index b6c6c101276..7f5cf5a1269 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
+#include "repo-settings.h"
 #include "repository.h"
 #include "commit.h"
 #include "mailmap.h"
@@ -2160,7 +2161,7 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 	if (atom->option == R_SHORT)
 		return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 						    refname,
-						    warn_ambiguous_refs);
+						    repo_settings_get_warn_ambiguous_refs(the_repository));
 	else if (atom->option == R_LSTRIP)
 		return lstrip_ref_components(refname, atom->lstrip);
 	else if (atom->option == R_RSTRIP)
diff --git a/refs.c b/refs.c
index d7402bcd196..3bee3e78299 100644
--- a/refs.c
+++ b/refs.c
@@ -730,7 +730,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
-			if (!warn_ambiguous_refs)
+			if (!repo_settings_get_warn_ambiguous_refs(repo))
 				break;
 		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
 			warning(_("ignoring dangling symref %s"), fullref.buf);
@@ -775,7 +775,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 			if (oid)
 				oidcpy(oid, &hash);
 		}
-		if (!warn_ambiguous_refs)
+		if (!repo_settings_get_warn_ambiguous_refs(r))
 			break;
 	}
 	strbuf_release(&path);
diff --git a/repo-settings.c b/repo-settings.c
index 1322fd2f972..4699b4b3650 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -140,3 +140,12 @@ enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *re
 
 	return LOG_REFS_UNSET;
 }
+
+int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
+{
+	prepare_repo_settings(repo);
+	if (repo->settings.warn_ambiguous_refs < 0)
+		repo_cfg_bool(repo, "core.warnambiguousrefs",
+			      &repo->settings.warn_ambiguous_refs, 1);
+	return repo->settings.warn_ambiguous_refs;
+}
diff --git a/repo-settings.h b/repo-settings.h
index 76adb96a669..51d6156a117 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -56,16 +56,20 @@ struct repo_settings {
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
+	int warn_ambiguous_refs; /* lazily loaded via accessor */
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
+	.warn_ambiguous_refs = -1, \
 }
 
 void prepare_repo_settings(struct repository *r);
 
 /* Read the value for "core.logAllRefUpdates". */
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
+/* Read the value for "core.warnAmbiguousRefs". */
+int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
 
 #endif /* REPO_SETTINGS_H */
-- 
2.46.0.421.g159f2d50e7.dirty

