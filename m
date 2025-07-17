Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA829E100
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749392; cv=none; b=A6ZG8C0JtZurBb/6WO/IAJHSKMduwBEtM4PXm7mJ4ml4WUN1NPF/RW6O2gei40rNjImwYCPYHHcjMM3pEf0TQfbJjXjMZlzY3Q2VTSnPdymeyy/IyL3ubkYgEbuTjDl/GkuweaH36LHBsnUDSsVSTf898HuNCACF8TEFTDej3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749392; c=relaxed/simple;
	bh=P0J64A2HsRrF5Zgo6pAcnLAvK1UF3Nklrw1Ydc48hmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF6vA3pZoAa456BQ1wsPGBzs+1jTUu8aflVGSmW52C4rAP5MJpJQpk6HOU46Q1/eyoMkpMaXHdInu9QH+3g9A10JsJI5LMZEJ9e56LnHTrh0sLTP+cnm1Mdbd99x4IXsaBXGvUl1j8uwlplwVwYFNLaOJPIe/yqsx7xD1KSSy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hd9iArt8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHTlVoL0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hd9iArt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHTlVoL0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CA407A0200
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749389;
	 x=1752835789; bh=e+GdWsyLn12AqbGPyks4uce27zwJhmamfYldfLs7n40=; b=
	hd9iArt8P8oiOBWhGLt03KstpfCvHU68ihslTzbmaILmJll1gx3sFfpEVfi5hmXa
	I368HdYHLbKCSNKKSeMSmaHw3UGcggl3H853O8D/qfsX5x6Da/nyLN1zUiVTI4T2
	xjKqVFl5YA+bHBrYF8V61BZ9Q78BvYwwgOI/uFi2uqjrO2bbbxo3LPt9y2t51CZr
	3rUJeIwt6AcM5CjNLIbJa54g3jMm4qIspm4wRYsoy6izASgStlmYkV/ZK6j4qzvq
	Axp+iYxlohScryXF5zi3uXrBT7j9efmi3vjwLhXNpWzSaKVz9AIjXxvRikjlD6AZ
	x3MmqSFxqba0SmZBDHIV6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749389; x=
	1752835789; bh=e+GdWsyLn12AqbGPyks4uce27zwJhmamfYldfLs7n40=; b=D
	HTlVoL0Qfg//Wc6AonLpa86FAZnBxhSVRpbJuKYEkKbFfWGIYUKVtiOOk9sEuRY3
	0kZW2kRgkapN/+S0IpTSyI4tR7AiI+eHoBtiYczxnoLcFYyJqSfcVHBcIdLaf8Wg
	5G7WZ0y7V8GDtOTIxbwrvhCDfGoJmH9q1AJws55RbBsGJezZ8Xc0qUmciAp0xlZ1
	5LKDayixb2w7dix+YetJxb6t/YvkLDDnHyM2YndVtQU6hw8VsW8hHU/tKOqoiBwv
	BkbQ8MOqx9mnTgAqjlxe4LC4Xk25t6tgMkZyBK26knirA3utn7ahD5OHDQ78FKKK
	ow/8pbMOb38+yC5Ko5IWw==
X-ME-Sender: <xms:TdV4aIS8HI7bj8un6og8SPz0IgXAZ8YrnnlYw37p2Halmz6Uc-nMPA>
    <xme:TdV4aHxHbRHwKgpHhU5MwD0k0cl6sz1YvInS48r4NpueAYamek3eEYAsUjCBZFNL8
    3-HMGAUiaz8RBhTVg>
X-ME-Received: <xmr:TdV4aPNYhnBukohcHGefJTYAmqqSextddcQAj0o4m8JfPGdODQ8UbmmZ71MVhkoKonC8ff2sEqT7dxLt0K0el0udhW21g9an6MEI2nGNsOZ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:TdV4aOMmR_jesUtD_O3mHeESBk10S_czzhY0VU--6IqSLJE9oksQzA>
    <xmx:TdV4aJRtKhgLC1T_v8RcQSiGj8CPJlqb5MgVOPCkquigd76Cfpn--g>
    <xmx:TdV4aICp8tOhi1IY4xky8e-N8EUNKjoOFdkE2FIjHGi-LNT_FFh-tg>
    <xmx:TdV4aAjLLl1-BiyceuFSBFDGR19_daEbpX7otrU2zaOwOPXbnvhsog>
    <xmx:TdV4aJLKZSloZ2bJnbXqZfI73iwClgnWuvf4zt1SqieT7dD4fgT-noX_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9eae01f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:26 +0200
Subject: [PATCH 06/21] config: drop `git_config_get_string_multi()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-6-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove
`git_config_get_string_multi()`. All callsites are adjusted so that they
use `repo_config_get_string_multi(the_repository, ...)` instead. While
some callsites might already have a repository available, this
mechanical conversion is the exact same as the current situation and
thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c  | 4 ++--
 builtin/log.c | 2 +-
 config.h      | 6 ------
 reachable.c   | 2 +-
 versioncmp.c  | 4 ++--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e94931ff48f..f395cc57a15 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1919,7 +1919,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 	if (repo_config_get(the_repository, "maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
-	if (!git_config_get_string_multi(key, &list)) {
+	if (!repo_config_get_string_multi(the_repository, key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1988,7 +1988,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	}
 	if (!(config_file
 	      ? git_configset_get_string_multi(&cs, key, &list)
-	      : git_config_get_string_multi(key, &list))) {
+	      : repo_config_get_string_multi(the_repository, key, &list))) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 1bedc4ef355..b512f12e805 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -221,7 +221,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
 
-	if (!git_config_get_string_multi("log.excludeDecoration",
+	if (!repo_config_get_string_multi(the_repository, "log.excludeDecoration",
 					 &config_exclude)) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, config_exclude)
diff --git a/config.h b/config.h
index e90c1c4d335..f6635e48c23 100644
--- a/config.h
+++ b/config.h
@@ -719,12 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_string_multi(const char *key,
-				const struct string_list **dest)
-{
-	return repo_config_get_string_multi(the_repository, key, dest);
-}
-
 static inline int git_config_get_string(const char *key, char **dest)
 {
 	return repo_config_get_string(the_repository, key, dest);
diff --git a/reachable.c b/reachable.c
index e984b68a0c4..8330a14fa82 100644
--- a/reachable.c
+++ b/reachable.c
@@ -170,7 +170,7 @@ static void load_gc_recent_objects(struct recent_data *data)
 
 	data->extra_recent_oids_loaded = 1;
 
-	if (git_config_get_string_multi("gc.recentobjectshook", &programs))
+	if (repo_config_get_string_multi(the_repository, "gc.recentobjectshook", &programs))
 		return;
 
 	for (i = 0; i < programs->nr; i++) {
diff --git a/versioncmp.c b/versioncmp.c
index b6eebdb989c..3a81b17bc1b 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -167,8 +167,8 @@ int versioncmp(const char *s1, const char *s2)
 		const char *const oldk = "versionsort.prereleasesuffix";
 		const struct string_list *newl;
 		const struct string_list *oldl;
-		int new = git_config_get_string_multi(newk, &newl);
-		int old = git_config_get_string_multi(oldk, &oldl);
+		int new = repo_config_get_string_multi(the_repository, newk, &newl);
+		int old = repo_config_get_string_multi(the_repository, oldk, &oldl);
 
 		if (!new && !old)
 			warning("ignoring %s because %s is set", oldk, newk);

-- 
2.50.1.465.gcb3da1c9e6.dirty

