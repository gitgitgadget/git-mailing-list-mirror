Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF381A2649
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140624; cv=none; b=M76eKfJMNS0FG2PrtZPd+PBFgaf2QQb2SlBfe/4rLhq6ajDYoEVcSA5pJ/jmlbaQr+bgNYObdCZI5x8JE1CkEA03c0qG/m4xN6QuA1yR14NUiZjOuLFK5ESIQMhDvioXQZxT/snloCp7ygSDOYdXV+bwMYBdP0kvXchoCottRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140624; c=relaxed/simple;
	bh=dRqd6E2r3WAI7vwX+mkTqGOw55v10Va64DgdJ/BbtuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2zehM2YHqv2BWBs/tFv9Ou5UV5eeM2ii2cwl8UXSUkjA6iu/NeuSG5bu2yv25hP5o8xNVgvTa5bkzvGOuMmhkh1C1QpmPVbrjY14jLkVEaEydbtWDGNlKgvpsfK9xJPjlAAB/jwbnw/FMmatQxTzF3/STaBeMnnOfJxJMgHq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8qZ7gLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJxRF/zr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8qZ7gLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJxRF/zr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CAF11380644;
	Thu, 12 Sep 2024 07:30:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Sep 2024 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140622; x=1726227022; bh=ekEaVdiMI7
	Zl9sLM0K5Gtb4/6LU1pex3wqXHi45eXaI=; b=L8qZ7gLauKVqXdDe3PTJ8NOcfE
	2xMkxgc2D8xp0tEebcKIYeEJmWd69ydM9fZdbeixHy8aebWmSj+9b9aNMWExKfu9
	OfgmYNpRjkgdh5Z6y1Fj8lm9yu0750fDoNleOEQa/uTrVlQRVBnPz5ebpR5n/4Kq
	whkeQTMDMxSh3pdvkg1YiKayc0RxfNfLmdTh4nDQORF1AlyIA5i3BcEI/r/3twNS
	jGhLUkGjjjjVrDLHC5COJGgRh5WxW+Q9f3QgK1RpCsogG5k+emyFr+0Ips5IOeip
	TrJGCo5dk6OAW4N3NWdzS0S66UDXABB/kgwWWOk/Awl5qECT72A9NktPx+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140622; x=1726227022; bh=ekEaVdiMI7Zl9sLM0K5Gtb4/6LU1
	pex3wqXHi45eXaI=; b=CJxRF/zru8QFlEVKrwupB3wlt/0CFLG73Jp69adsxmr5
	ujE5ULkh+7Y6ZhsU9xjz+gGHYz+Ro55e+1Z/KEbCvj4E3L4dT1fmsubOVv6ZTo4w
	logwMuc0fb8XYFOXxuhgZkZjqwrz9VsrPZLkKwQQc2sXVaLehD0xbat9N5pb3Hzg
	39vqJleiRvh+8LAdZE5tErmSGjnwfDLM2a4jnwfAtcFkmw5zeHRRAAXKlOt9lzVN
	JhcHttXd/1FAS84r4XSagjNtXu4hg/MM5MxvDs2jQUfaZj9+TVsasMx9mkuHSD8Q
	NjFRKXmmzaiNijsVqufgPBeJtUfDcCbi25+wyDd4WA==
X-ME-Sender: <xms:ztDiZpKbM56RzHgyGYrRByfLG0OGMY0ZkIGtwI-KNFoq1_W2CGKRmw>
    <xme:ztDiZlKFTAgrZRU-970AHzTwka5gr5o568DTJIvVJBwDeqOR_PdPpJZOEhDbcDkPN
    OQUAgJGEEe7Qy_wJA>
X-ME-Received: <xmr:ztDiZhvIVEOC_sSSMeGxn4KNMveK8EFxUj9Z31HESqDf6VT7yYiI6BJBi2QQnJahv23wEUv__bJdhPQhO8A_i0P2CS3bCEUB3pmtBAMKBUkv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:ztDiZqbhqP6VyuhcjaT22BpdgblsQnvR6VyX87chaJ69qV91W_EAyg>
    <xmx:ztDiZgb87l3WHo2OB6Qg63sAN_vjWp32GqwLfa1S4gyxgG71fyx0Qw>
    <xmx:ztDiZuBOnb8CmtQdZvD0kfDBhFzZke-kdnybwMniU_ERyuKwp_MJLg>
    <xmx:ztDiZuZm9VOddN4l72MC80t3w-DMFdZcva-dzSTaAk31NG7_g_T1hw>
    <xmx:ztDiZvyBkZuAIlRNULO6P654L2he8Y0gbKx8spK6dbAGW65M6Yf900pU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e66893ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:30:12 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 19/21] environment: stop storing "core.preferSymlinkRefs"
 globally
Message-ID: <e3527e7d73f33b15c056abdfb6140c42f41560eb.1726139990.git.ps@pks.im>
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
2.46.0.551.gc5ee8f2d1c.dirty

