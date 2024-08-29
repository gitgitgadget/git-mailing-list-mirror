Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D1190698
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924372; cv=none; b=sPDt9wrxewvw/MxSgCd3tGLa5AElMSOrLpdUCxqi1I4x/KBRxTYSy3lnR+hbRbPHkhuRZloRvpASpfiHTBCm0NUlhSBnhOXOZan1LZealH2y4wX6NVx7H9/iQY3uM7HvnP6qSyJLECTim9885TSXLfh6h8UfpirL/MDqXC5e77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924372; c=relaxed/simple;
	bh=Oc/TSoFv6/iYtIEW+1fOLOSoOCK73ggocGrkPK0LxE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nih402mPHH73vsvZU4D4myF1SqDFOK1HEDUyzCFnCeRUymvaPJfS2S3eeB4uDL0bn3m8wLLt0lIh1AWziwnTE4BTzeMHmL87OaDcqonfxa5KYTbBCH6/HosT4nwv16BoamuOOFOXsQpYNUZtstD5gZpQoycn+HBVZPKY5DWA5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qN+5KI2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJH+AFUr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qN+5KI2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJH+AFUr"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 35BDB1390162;
	Thu, 29 Aug 2024 05:39:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924370; x=1725010770; bh=WyNdldPUzz
	5dqRYOdZvlKIwOlWCvnuUB+UnIKepSVCE=; b=qN+5KI2uL/SoDoRIlIG2xbar2L
	qlw/tpmJA+jgyFfuOrTKFKWS9Evnq5poWjYKHHfpkFGN1vUrMy2Xb107apmEkYgp
	g+jBkrRNOCID3E/AKxVsfY/HxSGvo0BOSRcgGTE7XcveHO6Qof/emuy7QjqaqNP5
	V2+RvBSLPE5VwJcxsF2KTxsDFjVZUAJmrXdhjeL2hvwnXcwlukuwBzC+hgDzgxso
	53Jb3tEgo7IbSiKndTDr75Egp54FaTALCs7cO4AAYX+We0/AV7GrfWOqwl/v2RT5
	W4y3BADAI0d30nGECzGzz5VuWhDSpooRKT553UJmeqE6RAN92JXc/j2AoWbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924370; x=1725010770; bh=WyNdldPUzz5dqRYOdZvlKIwOlWCv
	nuUB+UnIKepSVCE=; b=XJH+AFUrLXwPl+MTJXGjRIzMQJ1xvV4aUzwTU/geZSNp
	oSXrbcwwAV6kQBOwEUcbNknsai8JusfiL8iYBBFd9IQrwxNUAYTRdb2PN0CFAnAL
	GSYsxsgDbrUPEmK6qnEefKZExBi3r52ryGqM5XdxCPdU2n2walfXSDMtrgqcFeTK
	/ZC3cqBOAJ+Il2hGe6Zh6kKPDV8k57kYP4rrB+KgKKtG91hDb7Qb/xKFy/9/teDg
	mFRPFglYowxz7SWYZ7QcKZRFowjnYNEYxatNZM0NoTWKOcnBRAspFWqEwrD7zSbk
	27KTFenndeuViTJFu09QcMhZSla9zoQ7Cr0ng83iCQ==
X-ME-Sender: <xms:0kHQZmQi4w97JCbOg4wuSxSkPW8Py4tfFEgsFAHMUqM_IqrxI8Uk1A>
    <xme:0kHQZryYwYgQ-wzxujTQBRajxuMUnuamVPrsHMm-iqbtTUxwDMV2diZ2SvOIbE3d0
    Rej1SY3z9YoPYF1yQ>
X-ME-Received: <xmr:0kHQZj1IV_b4yOhH4h38Kl-8w6auq4sCKjmdk3_17dtBJxbSfKNDDZUbA1h0JjgTjaItNw_6Zam9Sf0TLRgTS17_5xAvJEYauA4TP9j0DS9Mc7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeffeetteekudekffevudefgfelhefgteffhfdvveff
    keevleevjeejfefgfeeinecuffhomhgrihhnpeifrghrnhgrmhgsihhguhhouhhsrhgvfh
    hsrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:0kHQZiD8LxH9j44DwpAI0d-HKN3-TRVlm36ZVMq19zvb-RFiSVpQxQ>
    <xmx:0kHQZvjdttcKo6qsKFgLv1J5teQFbjDu8tL-vPD8tryKMxvMtIJ58A>
    <xmx:0kHQZuruz1X6LRmh4UtBwN67obY7VxSL1IbNa-4W9T4HPlJbo7oYrQ>
    <xmx:0kHQZiiHhPhwNhk5LAjlZ3tzIp6LSBVauUoumv__a5Zy6VBFpqczuw>
    <xmx:0kHQZiuyEjwr2iSJyWuqHD2Tts126W1d6n6gNhpaPzf2y8YiYz8o3mZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 482586d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:21 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 20/21] environment: stop storing "core.warnAmbiguousRefs"
 globally
Message-ID: <f2a28d38e5d1f314cbe8e890a9fec530152f7dc1.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

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
 builtin/rev-parse.c | 3 ++-
 config.c            | 5 -----
 environment.c       | 1 -
 environment.h       | 1 -
 object-name.c       | 4 ++--
 ref-filter.c        | 2 +-
 refs.c              | 4 ++--
 repo-settings.c     | 9 +++++++++
 repo-settings.h     | 4 ++++
 9 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 65b0b5e2c0a..bd06f6cc4c4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -898,7 +898,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
index 09c1bd93a31..baeed4deeed 100644
--- a/object-name.c
+++ b/object-name.c
@@ -959,7 +959,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
+		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
@@ -1020,7 +1020,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	if (!refs_found)
 		return -1;
 
-	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
+	if (repo_settings_get_warn_ambiguous_refs(r) && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
 	     !get_short_oid(r, str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
diff --git a/ref-filter.c b/ref-filter.c
index b6c6c101276..6a1f4c1ee98 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2160,7 +2160,7 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 	if (atom->option == R_SHORT)
 		return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 						    refname,
-						    warn_ambiguous_refs);
+						    repo_settings_get_warn_ambiguous_refs(the_repository));
 	else if (atom->option == R_LSTRIP)
 		return lstrip_ref_components(refname, atom->lstrip);
 	else if (atom->option == R_RSTRIP)
diff --git a/refs.c b/refs.c
index 822e0063ef6..bc348632121 100644
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

