Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2952BE03A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749426; cv=none; b=MqiYOQTPdmbnSE0kt/dxQEbL1ZsJoOlMd6yBiaBfOE/mYuH7lU591d6vEJyyQnxRptuPjYfXl9rxut2LiQvU8i6vj9QI/IGelVu7SeWhSVPF4obCi1zHiS272cTKqxFT7nRXD6cX4JbZmpXf6CCD2pdYzAHjokngfuOO9PDVOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749426; c=relaxed/simple;
	bh=QrgRUvdWc0YfkcfARen1fEeKrfcn0N7YHPSPJXMDrAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXziqON44FRLI/5lQH3oW/p+TWWgEfBePA8/zQ7LjrigVmMdbb7mPeiss1GGg6iaCqJDD4e95t2tm7gADH87NPy5l705ZFK56QRSZcTVgJ95w8F7Xs52n3Sqz3mHsaGiFqL5iVyXJHcUpYY1tz42FY87vGzHIxMe1O18DwRXx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PR9Eqkz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZdsm9VB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PR9Eqkz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZdsm9VB"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 129F97A0226
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 06:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749423;
	 x=1752835823; bh=6uERbeBhCxsAvOxNfEd/YqiH1aiwKRPh1jXvzZXM8HA=; b=
	PR9Eqkz9F0d65kW8TT75ZXPD0u7Xj/imTMpTlbOWjwIXqfbr7asQFXeqELNHMXQ9
	mYIcVCtU/txH1WLV0t1F3+QZyK6xrxEsF9R5oqpz823RMQ9/0Gb0/CY4hbqJUA50
	yeRZONxNEh/80tn+rehUSc6eWiNd60JnLKb6kzsu0XQosIZEfKNc1UhnLH/7ej+F
	FLAjCnvx1Hv02qJBKzzYGkjBYvp/BHgY3F0KCg4bswBR+41cSrzGYH2Oj7wvVPIq
	/53jjNpF4Agj2Hn/JqJQyaRa2LQsW8iymQtIXri3r7T0r+cJsN1Ad6f4/ToTMYp6
	xnH7l86o26PnzxOBeWtH5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749423; x=
	1752835823; bh=6uERbeBhCxsAvOxNfEd/YqiH1aiwKRPh1jXvzZXM8HA=; b=h
	Zdsm9VBXeQ34XBptBxk8PC2cFAQDPPYw7BU32TSPlGHsJZhggYo1zD1NLojRsQ0a
	oEmFJtbeQ4ol5XgL+FChioBczjCYEeU4Wm6xTTXtyshLsNvL7IRkknmeltblXDzy
	HR3mnTbjbpjOk7Bt4gC2eZVk21J/82mFEgsl6jlr3uWGEq2+Plx3fiMTPCez8nUd
	E9GN76c/XqY3pPlylN+RqUGaEeONUieOnfzzUQm7eFX/yXNrbeBMTMlK5HGJ1Fb8
	IkgOyLtzDjYTSNpGYiWoeNmHjQ6qlf+X1lyLxNovFyceqZJs2JC3t9zriaWbDFje
	PUSMGRWg6JENcTaFD1ADA==
X-ME-Sender: <xms:b9V4aM8H5FS_zJHA5b8xY9uL1msN2bzJDmi-ShfTQj_sWJQ14y85-g>
    <xme:b9V4aGu4ETUViWdeOuypEsNHCFlGSwubKHojdpshJepaY2M2_1UlvcyRgMNGSm6nw
    5ERctEKbbKRVZNwRQ>
X-ME-Received: <xmr:b9V4aLYoVblsUvMtW5eYavAgtL5h62ojeUgU5YoXzZYWekF5S2EM4TC1sOKWLgAUIDajObe7NAd7Ujwqg7do6tsnxjRT8aNB8JGD_cN8Zqrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:b9V4aOrOwmj0YeQe6f2sP2FIPzTlN8jOB6U4v8a1QveFauCkRci4Zg>
    <xmx:b9V4aI9COw5TtgjkQEBbW5rbuS_ArgWIn98d37z7pRD8JwpJRcVr2g>
    <xmx:b9V4aF_a2rlC8AXZ6KhCJN8gHWOJpSBuXz5zOACHZEwhrsZ-MCLo4A>
    <xmx:b9V4aPvzh0xOoeAmPYyPcqui2lAgOdoytEJpR93wJs9m7yF8sdMkmw>
    <xmx:b9V4aFmCR3MaRtEjnUU-iNHLGUg8PnYb0GtWO94L4FMddhexjinH9XzO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb5dfba9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:37 +0200
Subject: [PATCH 17/21] config: drop `git_config_get_multivar_gently()`
 wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-17-d888e4a17de1@pks.im>
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
`git_config_get_multivar_gently()`. All callsites are adjusted so that
they use `repo_config_get_multivar_gently(the_repository, ...)` instead.
While some callsites might already have a repository available, this
mechanical conversion is the exact same as the current situation and
thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c         | 2 +-
 builtin/clone.c  | 8 ++++----
 builtin/remote.c | 4 ++--
 config.h         | 7 -------
 scalar.c         | 6 +++---
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/branch.c b/branch.c
index 3dc237adf6c..26be3583471 100644
--- a/branch.c
+++ b/branch.c
@@ -130,7 +130,7 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 	if (repo_config_set_gently(the_repository, key.buf, NULL) < 0)
 		goto out_err;
 	for_each_string_list_item(item, remotes)
-		if (git_config_set_multivar_gently(key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
+		if (repo_config_set_multivar_gently(the_repository, key.buf, item->string, CONFIG_REGEX_NONE, 0) < 0)
 			goto out_err;
 
 	if (rebasing) {
diff --git a/builtin/clone.c b/builtin/clone.c
index f025a8f19e0..183297787cb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -762,16 +762,16 @@ static int write_one_config(const char *key, const char *value,
 {
 	/*
 	 * give git_clone_config a chance to write config values back to the
-	 * environment, since git_config_set_multivar_gently only deals with
+	 * environment, since repo_config_set_multivar_gently only deals with
 	 * config-file writes
 	 */
 	int apply_failed = git_clone_config(key, value, ctx, data);
 	if (apply_failed)
 		return apply_failed;
 
-	return git_config_set_multivar_gently(key,
-					      value ? value : "true",
-					      CONFIG_REGEX_NONE, 0);
+	return repo_config_set_multivar_gently(the_repository, key,
+					       value ? value : "true",
+					       CONFIG_REGEX_NONE, 0);
 }
 
 static void write_config(struct string_list *config)
diff --git a/builtin/remote.c b/builtin/remote.c
index 827639e0398..dd340a33259 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1633,8 +1633,8 @@ static int update(int argc, const char **argv, const char *prefix,
 
 static int remove_all_fetch_refspecs(const char *key)
 {
-	return git_config_set_multivar_gently(key, NULL, NULL,
-					      CONFIG_FLAGS_MULTI_REPLACE);
+	return repo_config_set_multivar_gently(the_repository, key, NULL, NULL,
+					       CONFIG_FLAGS_MULTI_REPLACE);
 }
 
 static void add_branches(struct remote *remote, const char **branches,
diff --git a/config.h b/config.h
index e69592ada15..a90b814292c 100644
--- a/config.h
+++ b/config.h
@@ -745,13 +745,6 @@ static inline void git_config_set_multivar_in_file(
 					 key, value, value_pattern, flags);
 }
 
-static inline int git_config_set_multivar_gently(const char *key, const char *value,
-				   const char *value_pattern, unsigned flags)
-{
-	return repo_config_set_multivar_gently(the_repository, key, value,
-					       value_pattern, flags);
-}
-
 static inline void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
diff --git a/scalar.c b/scalar.c
index c09c5ca194e..4a373c133d8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -196,9 +196,9 @@ static int set_recommended_config(int reconfigure)
 	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
-		if (git_config_set_multivar_gently("log.excludeDecoration",
-						   "refs/prefetch/*",
-						   CONFIG_REGEX_NONE, 0))
+		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
+						    "refs/prefetch/*",
+						    CONFIG_REGEX_NONE, 0))
 			return error(_("could not configure "
 				       "log.excludeDecoration"));
 	} else {

-- 
2.50.1.465.gcb3da1c9e6.dirty

