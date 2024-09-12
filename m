Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0D1A2649
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140628; cv=none; b=Q5j+WJY0rcDvjHcae4vtLCS15USh5xZebx6xPcIsw4ui5yzGAo9gn3hk5WkSlE2/RgQ6GSfjSHPLnpWsah1qFibfksLyGxQmUwT/tq1wr0wgdp2snVeTBz+FxzfXkrnSJOnzCc7dRSWvS1pN4tX2XW1P8CmqYeEp3i/l6XEvAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140628; c=relaxed/simple;
	bh=YbAXqBup/LUIpJt0GsaH9j+7L+nl9PZxVecXDgQjQEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5/Cjp0lc5C5YZ1n548bEp6sAqEtyQlpOlKzaHBfrxFOr2w9in1KcZDRe0EVqwFmDQbb/scsDgzFFXApLUfM8z9VSQuNM6LW06m+tQjjsR/X38+2ZUdhHSgcvJcy2vnx7oBWqzSlPdN1ndolXvXHKEQnAqq18IWSwDKUb6QShRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dzSWi9Gi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LFDX4dzA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dzSWi9Gi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LFDX4dzA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 05E0F1380639;
	Thu, 12 Sep 2024 07:30:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140626; x=1726227026; bh=cU8F9Z1DOi
	OvSpwPsRrgbam6abXF2jjtGFLey3zV9cU=; b=dzSWi9GihFrz5F0UdWBofIzBNL
	/ERjbmhnZe3L9gThrUWWWQhpXpd4S74mIuJxdZn0mhdw5E3fFaT9OgCSWtAETzrv
	9uqDroxCekVaa/GvKGMc7M16MwBEF4PWpmAzfmn+pd1bQqbNTh0eWBREQz/PbXlo
	cw18PsOybftAYnjpf7HZ8DNFvaV6KOaCVY7IQ3urCF2FXSsQsRfQ0yszMm/Q7X4g
	+lLYDkoakshb57NYqrGnD5tis+iV/aHKW9LYbD/aBsurfIK2CxF7e3a9HrNR59i9
	1bwhyNpt112MYBM6HUCmefYq/8Xd7yRsdlQsf3AAr7aM7Bc+uoj4av9YDIlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140626; x=1726227026; bh=cU8F9Z1DOiOvSpwPsRrgbam6abXF
	2jjtGFLey3zV9cU=; b=LFDX4dzAHrsXSpa4jkx5RtgNiIvacUAueoc23e0GKblz
	HTmYA/YEm1NG2qaOv3qNfPCI2gUdZV7X4EPMEggNMmTD58bdLGSg8RPv13u5h6bo
	iI0+ylsL6Ue4o7s8QFiiYylDTvRluHoztB5gQ/ltrhdu5NMy7ly0MA0fM2ektqZV
	dfhZL/pTQe1UHxBjWuvZg0tFNi+m80AcliOpkmqJesGspU10PWrWdTbFIiGTB8mT
	Huzvk+NCr7l62dxZXMHcQqrUFfcSwC/H+YzWc65e5157FKYINo8y9jHIRLIcHQud
	EJieHHKTIfBdmESNeSM9GcyytaNUVO1JqgzqFlfTHQ==
X-ME-Sender: <xms:0dDiZojYSGsc2m2OQMuZhnX4GTjdRvAcV5aBclAlWG8a90wjIh6gJQ>
    <xme:0dDiZhB-5PX6BubutlKNM1XtoW17nkTudifrGVRvN_NmoyneIjTPYC2apjPEMPzr7
    s80xuS_PM10XX5dWw>
X-ME-Received: <xmr:0dDiZgFlrAm49VIPU31MIfltXs3UC0jKYKXIKUD96XhGudlBSl24ZzvxFyVwP54V1vJC9F6Y5DtPKubKNNRu3diTQ7WI0pTVMuhKnOjW0ZJv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudeffeetteekudekffevudefgfelhefgteffhfdvveff
    keevleevjeejfefgfeeinecuffhomhgrihhnpeifrghrnhgrmhgsihhguhhouhhsrhgvfh
    hsrdhinhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0dDiZpRT9UAV4FnwzIY8IkFdkZXJcipi7zyTuj11SVfNNpF7zHSflg>
    <xmx:0dDiZlxSP7L0FttT7Nj0ExWlPaO4pL7Ke8cY7EAoybqzHzVaKfSHVg>
    <xmx:0dDiZn5Vq_5zeQ7r7In0iseK1xE93YDxy3lXypexfiioTd9A2utMWQ>
    <xmx:0dDiZiwsiOQBwDKAqykNyc9b0wCzgKYOTPlF9andLMNijGBcY7ro-Q>
    <xmx:0dDiZoqw1GSIWszN-FOPmfaDMq4lggYJJqE_-8sgPCRhlxUJDB7nGflv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49bc5da2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:30:15 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 20/21] environment: stop storing "core.warnAmbiguousRefs"
 globally
Message-ID: <3c4a9259fbbe7d0aa7edbffaffb26b13feb5f52b.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

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
2.46.0.551.gc5ee8f2d1c.dirty

