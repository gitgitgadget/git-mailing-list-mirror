Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643F17556C
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009000; cv=none; b=XhYsd18vJrmAqlEQVmW8Vw2EqJbHeUqpegiawnfrTXelclOuua1s9zTlwF+2EQaSlqL54xo5AvY7SuADc9VbxDCMp/O3jmDgIOf2zbsHIJ4vwDqEk+Ibf3pv8pzKKVl5GfOD20UjPfB2NBceAMpAJEHmnqDzFMz7sTP/lUuupHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009000; c=relaxed/simple;
	bh=/6suZb2unyRBj5SKgV/YNumGzC9362n/HWHt5VyUHqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrM8rOEWgj79vHbMWxAVTw8JHNNHPLoRB90twUiyLbdgT21Wff9K/ZPiksABU1+XKHVjceTFux0eaRxy1ZIaZ863V7ttQPwjQCIy9u9v8phMfGRb8TOk3xWqv/jCQGyjw1vFhKb3nhaBr+xgTtFJOgwwjUUR+bIL2GtlzzSFztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WfORKgX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMap5+VV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WfORKgX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMap5+VV"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 76DFB1380278;
	Fri, 30 Aug 2024 05:09:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Aug 2024 05:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008998; x=1725095398; bh=dkQw+5FupR
	dKNKdyjK4XvrtwJVMJn3ONy0iDDli7EwA=; b=WfORKgX8qj+Q8AuaNyciXGL8o4
	cQ8TEk6SHS1wO9HSKqvQgOG2JdnypOFy+Df9e08mATr/1TOqshOpv5RYdJFmRt/P
	2ESqm42S3uYzdRgtXbXs+riyv2vnpLaKqdvhy6JFselAJwbLP1r7oPTKULGwnG/i
	/wvrYzHi7Cvi8/eZ2yKi0l0TD61yVXsWbCnLsPXVxWaxMFTncghAmEnrfuJCMyG6
	eqfLXOMYNdjbfTRrktGsvxBgCV0BWDHuRKhS4SoMhAwUefNf9ya6kUBv6/LiMwG7
	bfvrXjbMA+zrchIW6rCb4u1STc0+Xp+8BUcrfjpFXJpjtAmPnjvDLHjI9CNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008998; x=1725095398; bh=dkQw+5FupRdKNKdyjK4XvrtwJVMJ
	n3ONy0iDDli7EwA=; b=QMap5+VV1UUjJMdHmlPgUVfXrBThhGFwJfgRsiSLd1RP
	NOpnaZBn4Ot7HptaK4xnAEWQV+usY4PCPBlWXUSGYCg1q60OpI4GTl4jlFXY7IHO
	va1H36dL2sUqBjDiZVpDZ3SkUElxus7k61reb2Wro3fK3oNkLmjbL/OCGvzAZtU/
	OcXBlYx0zGHQ1hHMpq5HkpfRFBvnxxzQuBnzF1X62P4DqTqBoULga0Suk8uvP/Qt
	sJGMn8i6XMJvJ6e5YB6zRCm2MK3YTiVzvHVKDRKgnr42bkJCWvaksbNq2SOOijDr
	jdCa65v+RW5gM6M8BB6PMWKW2RYAY5c4QVxdg2uBDw==
X-ME-Sender: <xms:ZozRZsPAeIUlOu7gobuQfH7u06aVCGPG5a5Ar5BIOZG9ozo7QYhDjQ>
    <xme:ZozRZi9hU2ed_z1gjAJNRzg1DkCCsVcmrpXvuoaqjtlRd7wKNXcD8QJCSsyA9dBHj
    rDCNfeV37BoFSjSmA>
X-ME-Received: <xmr:ZozRZjTzhDigVUuFKJye_pu_vYg08GnO2IQ9mt9oC3YfgbyUsZY5W7Mib0f1UEsGG0sIMvxbu203_SffQ-bmfP7eJiXQYTstXh0hLhvL22hJgjVYgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:ZozRZkux7xOBCs29yyYXcLgQD9UN23qFX2R5F8FgcG3Y9hdEIMQ6Rw>
    <xmx:ZozRZkejv41NZ9zMEx_gxRD_79BlWbaq2XvmsRASRLorY_JU6OjjjQ>
    <xmx:ZozRZo3rpB-CCC6AaTjVdxQa0K1I9f9Turt_HQHABGQ7S_Utbx0FsA>
    <xmx:ZozRZo-KcoOnOGvtsccEBJi1Knfu8hUoFUUmoBPUWMPPSslCG-hRnw>
    <xmx:ZozRZj48b0JVa6H6gPBMsQqv4ys9hoLj65NTbjh_q5keQDeXGq628eIj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec2dda2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:46 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/21] environment: stop storing "core.preferSymlinkRefs"
 globally
Message-ID: <194d858877f9954059800e9a9b698e8c04447946.1725008898.git.ps@pks.im>
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

Same as the preceding commit, storing the "core.preferSymlinkRefs" value
globally is misdesigned as this setting may be set per repository.

There is only a single user of this value anyway, namely the "files"
backend. So let's just remove the global variable and read the value of
this setting when initializing the backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c             | 5 -----
 environment.c        | 1 -
 environment.h        | 1 -
 refs/files-backend.c | 5 ++++-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index 47101c3e977..a59890180a3 100644
--- a/config.c
+++ b/config.c
@@ -1447,11 +1447,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		prefer_symlink_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 992d87e0d60..6805c7b01df 100644
--- a/environment.c
+++ b/environment.c
@@ -34,7 +34,6 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
-int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
diff --git a/environment.h b/environment.h
index 315fd319951..0cab644e2d3 100644
--- a/environment.h
+++ b/environment.h
@@ -156,7 +156,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a536d7d1b57..e5b0aff00dc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -76,6 +77,7 @@ struct files_ref_store {
 
 	char *gitcommondir;
 	enum log_refs_config log_all_ref_updates;
+	int prefer_symlink_refs;
 
 	struct ref_cache *loose;
 
@@ -109,6 +111,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, refs->gitcommondir, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
@@ -2942,7 +2945,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		 * We try creating a symlink, if that succeeds we continue to the
 		 * next update. If not, we try and create a regular symref.
 		 */
-		if (update->new_target && prefer_symlink_refs)
+		if (update->new_target && refs->prefer_symlink_refs)
 			if (!create_ref_symlink(lock, update->new_target))
 				continue;
 
-- 
2.46.0.421.g159f2d50e7.dirty

