Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3292D979A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059896; cv=none; b=CYP/Hv3j7lBvcfnIh74PImVWeeEAWX9CfTVqc2X1IeMUyX8xqPIark6ko5XuOfTA1LdLeYYb5Sb0RNDdEptpGIfxyfid8prBgAOPKgShFUBq6TMeVVbmm6Svu0ihIU7Yo14P3e74y5vsJCAHUQSuAbDH+jyxce15gXLUixXRZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059896; c=relaxed/simple;
	bh=YK5jejNTrwPwmgAGRBdrTVKiV/lZ15b95nF8+Nqbr84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmYMZvLp9HHwKGqyUa4wPoZVw2U2v2XZeP7QKRiezmrDRcLTLhHQ2y9Wq72ykaKu2Flz991iFkviXOy/5xdjAiBY2Dd1pj94SaUjLiA/29ukWSuygQmuKdRkvdNF44EjibvA7e7fQPdEU1ozJyEkSIyZZUnv38HjkfLmms+ATSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfMyREWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbuuEUcU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfMyREWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbuuEUcU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 905401400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 09 Jul 2025 07:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059894;
	 x=1752146294; bh=MozGUq4AUmWCrtW87+1yd8PmgY/t78rmFRN/AYYfjSE=; b=
	rfMyREWLsUpovha9jabXqQt2Ov7tKOdaPnODqjQ4YhfGQyepjWYknAQWOqvmh8Qm
	UlTqxAvi242Eto7gWEfmknaminFVRyk8hDTMZE9PmM1RZRELrglvSJqnmc90UoOr
	ZPtcU42pvyCHGTWjfqY0oemYhpBjLfHlwoOe5auAlmrl/iE8ZWkOS8gIIEhAK9ma
	+mNUiKJK4AUXddFB0qS793hKmoeeqdVAEUQ0wgORTsWTStV0q9LNuas4nMd9w/ew
	fhSNIVrj0sKQMJno2IwPv14yZliwbYFlrkJsQn29UerMRFmAXDN2iZ6jeh6yOyU0
	VcXShPxdePfGX4v14LiLqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059894; x=
	1752146294; bh=MozGUq4AUmWCrtW87+1yd8PmgY/t78rmFRN/AYYfjSE=; b=C
	buuEUcU9ncG0g3WAFznwGwQoD3T5mdVi4h4HXeI9t4yneagBca3juE1XLm3xCfQl
	zf65sseR9ltSe2OFECi7jVrx6v4zGUilEVi6gYrTZvxHZv3NUntiaf3ilswrk2HN
	qn6Ji5ILhD3/rxHmfySMza8T8KIQicccOveRs3POa4XEWU896en1c+XTZhjvICEV
	jl3O6d3GpvGh7eQHH2XzMaZ1vRhbS8c7JI3J/qyWXOVZRrzTpSukkAr4Z+HkTeDn
	zpNq+Yp1xf2G7LFdEXkQ/HoGKr9g/wFuty/zRqftYJvQZwIUr6XhtzsL3bCs7sNM
	5LISjGLkYu+uwnNKhzxTg==
X-ME-Sender: <xms:9k9uaG26iC3OB9AZWteEkSyTE5V03mzj50ELftv873lvIHnXUOwcLQ>
    <xme:9k9uaLG5Uxlk7ImAbJsMLQk2jblX9jKBmC_wBWNZmD4edN2UX3y2S7ShHWEjHnKJ5
    SOwKnsJALvxl8Y3rQ>
X-ME-Received: <xmr:9k9uaISXHBdnu9rU5cwpMYEJSeXrvZerTCPo3HYVujkA_EiY2H7fEzgCjjGoJeSKSRzU2gPXJIlHTteCkIktCECEzSfOAN6jveiQ94n_Mh6YJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:9k9uaKAQIk77gzj1_wUS1pkVXgGxC3NrsXAGDOf-720-lBcJOqswRw>
    <xmx:9k9uaA3Bm7RtGK1Par35ZhEPB_srzXDjaQhI43WwYN1MdpLxb6ahwQ>
    <xmx:9k9uaAXqvSJoum_n6nIyvg2Ohi4SpkpFHsLS9VudAV3QmOJ5OKINHA>
    <xmx:9k9uaKnBTFa_2bYwIy3vJpXI1gU6Z-7t8NWM29Q4o87YZaDa6GgzOA>
    <xmx:9k9uaI-dcnUX3jctPK4Sb33GZYSB7oBwut1qbb3dsXGg0T81680O7eHd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e34b9b93 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:28 +0200
Subject: [PATCH 18/19] environment: move object creation mode into repo
 settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-18-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The object creation mode controls whether we use hardlinks or renames to
move objects into place. The value for that config is stored in a global
variable, which is bad practice nowadays.

Refactor the config value so that it is instead tracked via our repo
settings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c        | 12 ------------
 environment.c   |  4 ----
 environment.h   |  6 ------
 object-file.c   |  3 ++-
 repo-settings.c | 16 ++++++++++++++++
 repo-settings.h |  6 ++++++
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/config.c b/config.c
index b7d1fa90fbf..81a29e37010 100644
--- a/config.c
+++ b/config.c
@@ -1568,18 +1568,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.createobject")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcmp(value, "rename"))
-			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
-		else if (!strcmp(value, "link"))
-			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
-		else
-			die(_("invalid mode for object creation: %s"), value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index dbb186b56d0..ed0e9c62346 100644
--- a/environment.c
+++ b/environment.c
@@ -56,10 +56,6 @@ char *check_roundtrip_encoding;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
-#ifndef OBJECT_CREATION_MODE
-#define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
-#endif
-enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
diff --git a/environment.h b/environment.h
index 4245b58af6e..7c5ddc1da8f 100644
--- a/environment.h
+++ b/environment.h
@@ -179,12 +179,6 @@ enum push_default_type {
 };
 extern enum push_default_type push_default;
 
-enum object_creation_mode {
-	OBJECT_CREATION_USES_HARDLINKS = 0,
-	OBJECT_CREATION_USES_RENAMES = 1
-};
-extern enum object_creation_mode object_creation_mode;
-
 extern int grafts_keep_true_parents;
 
 extern int repository_format_precious_objects;
diff --git a/object-file.c b/object-file.c
index 0afd39dd346..55396d4eaeb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -600,7 +600,8 @@ int finalize_object_file_flags(struct repository *repo,
 retry:
 	ret = 0;
 
-	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
+	prepare_repo_settings(repo);
+	if (repo->settings.object_creation_mode == OBJECT_CREATION_USES_RENAMES)
 		goto try_rename;
 	else if (link(tmpfile, filename))
 		ret = errno;
diff --git a/repo-settings.c b/repo-settings.c
index 1d3626018a0..38a4145c3eb 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -189,6 +189,22 @@ void prepare_repo_settings(struct repository *r)
 		if (!pack_compression_seen)
 			r->settings.pack_compression_level = Z_DEFAULT_COMPRESSION;
 	}
+
+	if (!repo_config_get_string_tmp(r, "core.createobject", &strval)) {
+		if (!strval)
+			die(_("missing value for '%s'"), strval);
+		if (!strcmp(strval, "rename"))
+			r->settings.object_creation_mode = OBJECT_CREATION_USES_RENAMES;
+		else if (!strcmp(strval, "link"))
+			r->settings.object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
+		else
+			die(_("invalid mode for object creation: %s"), strval);
+	} else {
+#ifndef OBJECT_CREATION_MODE
+# define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
+#endif
+		r->settings.object_creation_mode = OBJECT_CREATION_MODE;
+	}
 }
 
 void repo_settings_clear(struct repository *r)
diff --git a/repo-settings.h b/repo-settings.h
index f60900317cf..18074115145 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -23,6 +23,11 @@ enum log_refs_config {
 	LOG_REFS_ALWAYS
 };
 
+enum object_creation_mode {
+	OBJECT_CREATION_USES_HARDLINKS = 0,
+	OBJECT_CREATION_USES_RENAMES = 1
+};
+
 struct repo_settings {
 	int initialized;
 
@@ -60,6 +65,7 @@ struct repo_settings {
 	int pack_use_sparse;
 	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
+	enum object_creation_mode object_creation_mode;
 
 	int core_multi_pack_index;
 	int warn_ambiguous_refs; /* lazily loaded via accessor */

-- 
2.50.1.327.g047016eb4a.dirty

