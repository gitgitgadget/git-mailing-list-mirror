Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688729ACE5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749429; cv=none; b=DXigDJMfc2UBtXNSwJ3GsCS2hSn3SLpDkPJIc7NujYGcYVMZ+HI1n6TyAF35UrEdBhzxQPup592fSjx9+ircjlJqKZJQ0YN7gFxp6AItePwdX4XF1vyrnBlvq/N4zvJIz4jFlw5IaKtBc/mFRzeLpg88vw0sCxTAfi5ebVtmfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749429; c=relaxed/simple;
	bh=gG6OVd64hXeGOAnf7RkhzdPC0e3x1EYeR1snnQnCMmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLNaMY/SMejMLjrKOwSjKpUsrDy2xypV6RdG7NklqjIQaz5g3cIYh143KOS7wfinAnUjiSg2RjQVunDIKKxvipIJLzoRTV43b9lNjZhPiUlnNeL2HyfV6sc/WAyg2luDN6v6CfuwUDAEr8X+t+Sp3cUlY+BVKdkUed4JwM0lQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o9r7OCRm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7q71A6P; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o9r7OCRm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7q71A6P"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05D437A0200
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749426;
	 x=1752835826; bh=LUD9aPHGBZraaeOGJGkHLKG6azGIyO60NjujzkZHejs=; b=
	o9r7OCRmOgPS6pIUXJjwH9sTFfJRYUals8EPFmG4J2247Qq1XZ8WvF/QdIqxAimQ
	sA7S5F+1lVg6r40bmqWzaK/RHZ8FZ14Z3hcKJQ5T9CVVyT2LJlxXmDCW6kB6RKNL
	XWtz020Dhose/4t99vfRc9nqmZBG2FaivzZ9oWegnbrW8f5nSlzLVmapH/E2QJvO
	wipeeV43FMv+rDHtOh6pLRyFcUOHQ14kqwE3SmKqEdjkCcW9et+M8Yow4RmwPPfO
	xuYKJelSga2AEIikxmE7a7QzgHA209OAczCDlHq19389QJZjx9PZ05yXgHD/NJmn
	RVJqUBr5G9FH1114dJsJeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749426; x=
	1752835826; bh=LUD9aPHGBZraaeOGJGkHLKG6azGIyO60NjujzkZHejs=; b=Z
	7q71A6PreC1O52G6X2E3lBLUM5KyAuckBwcuW2RAsDKCbJiAds0UeRIl/oUYEv0/
	yOT9r9pyWO6eoWtrLdE2yBJyGWc8Z0OHG9uFoxIojFbSUCtu5qc1SdwoWcZ7d2W5
	j5//LDy4F+y+BKK6eE85O2z+x4IAsG+eY6YPuauuaSChalGNTxALTQlt2FMdlaQt
	B011i9w2gVqKRVyTrs7BEIlLidrwY8OVTqcycVD5FdkFq/KYNkokjyTcrWNE0vSo
	a7pZkLm4LR2W1oKYmPrN6N74ik96U+OBO32orBF7IJL/vj4LWSwOFqgGYsUnnLY0
	gZ6bJbKOZO6goZdhFodJA==
X-ME-Sender: <xms:ctV4aFfFXVkjTBKCg3d4myVC0FqslXJ2Y5aG5CCH9b6lwUdVCRLVhQ>
    <xme:ctV4aFObjyZIz4maPe6cKh-XS4icyplrrNWTOW65L7r7mosVUX9ksJxp1uNy7s5N5
    Th2h5-62PII1YMK8g>
X-ME-Received: <xmr:ctV4aH41qwMQ7qiuZ0ICUOk7u2lgpSUhtwjWlCRqD6NbxL-neTMLE8UVYlHr3QKxu3fT2VWo-LgYlpiYgzXG_6J42kBZmsvuBov9O3EGkQf_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:ctV4aBLwQZfNoAHuoVn1DjbrMue6aLw_i2lDl8NE-gd0PiP0qDVsJQ>
    <xmx:ctV4aJdQBlNR0o8ekjzujg_O1Ciuwaludja8P5tlSCXmHRHLwi0VHg>
    <xmx:ctV4aMcDS1JTjpSrd5Dlq3jx09Ano4OB-0ZYTLQbQEsD13Y2JOT-Nw>
    <xmx:ctV4aEMFXVX_OGmtgPPUQ33K1NgkKHMshnGh8Xjf8ijwdGN4hFQ8wg>
    <xmx:ctV4aIE98UVnImwc8Sr8_ta4XwipIWd5yYnABkUff6mf2KuGvQerUpbs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30e3b247 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:38 +0200
Subject: [PATCH 18/21] config: drop `git_config_set_multivar()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-18-d888e4a17de1@pks.im>
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

Follow through with that intent and remove `git_config_set_multivar()`.
All callsites are adjusted so that they use
`repo_config_set_multivar(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c |  4 ++--
 builtin/clone.c  |  2 +-
 builtin/remote.c | 20 ++++++++++----------
 config.h         |  7 -------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5de0691d18d..fa5ced452e5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -987,10 +987,10 @@ int cmd_branch(int argc,
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
diff --git a/builtin/clone.c b/builtin/clone.c
index 183297787cb..c990f398ef6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -822,7 +822,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 		/* Configure the remote */
 		if (value.len) {
 			strbuf_addf(&key, "remote.%s.fetch", remote_name);
-			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			repo_config_set_multivar(the_repository, key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
diff --git a/builtin/remote.c b/builtin/remote.c
index dd340a33259..4c63a8bb576 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -132,7 +132,7 @@ static void add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
-	git_config_set_multivar(key, tmp->buf, "^$", 0);
+	repo_config_set_multivar(the_repository, key, tmp->buf, "^$", 0);
 }
 
 static const char mirror_advice[] =
@@ -634,15 +634,15 @@ static int migrate_file(struct remote *remote)
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url.nr; i++)
-		git_config_set_multivar(buf.buf, remote->url.v[i], "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->url.v[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push.nr; i++)
-		git_config_set_multivar(buf.buf, remote->push.items[i].raw, "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->push.items[i].raw, "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch.nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->fetch.items[i].raw, "^$", 0);
 #ifndef WITH_BREAKING_CHANGES
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(repo_git_path_replace(the_repository, &buf,
@@ -771,7 +771,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 	if (oldremote->fetch.nr) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 		for (i = 0; i < oldremote->fetch.nr; i++) {
 			char *ptr;
@@ -791,7 +791,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 					  "\tPlease update the configuration manually if necessary."),
 					buf2.buf);
 
-			git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
+			repo_config_set_multivar(the_repository, buf.buf, buf2.buf, "^$", 0);
 		}
 	}
 
@@ -1790,7 +1790,7 @@ static int set_url(int argc, const char **argv, const char *prefix,
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
 		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
+			repo_config_set_multivar(the_repository, name_buf.buf, newurl,
 						       "^$", 0);
 		else
 			repo_config_set(the_repository, name_buf.buf, newurl);
@@ -1814,10 +1814,10 @@ static int set_url(int argc, const char **argv, const char *prefix,
 	regfree(&old_regex);
 
 	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
+		repo_config_set_multivar(the_repository, name_buf.buf, newurl, oldurl, 0);
 	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl,
-					CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, name_buf.buf, NULL, oldurl,
+					 CONFIG_FLAGS_MULTI_REPLACE);
 out:
 	strbuf_release(&name_buf);
 	return 0;
diff --git a/config.h b/config.h
index a90b814292c..61774f17db3 100644
--- a/config.h
+++ b/config.h
@@ -744,13 +744,6 @@ static inline void git_config_set_multivar_in_file(
 	repo_config_set_multivar_in_file(the_repository, config_filename,
 					 key, value, value_pattern, flags);
 }
-
-static inline void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_pattern, unsigned flags)
-{
-	repo_config_set_multivar(the_repository, key, value,
-				 value_pattern, flags);
-}
 # endif /* USE_THE_REPOSITORY_VARIABLE */
 
 #endif /* CONFIG_H */

-- 
2.50.1.465.gcb3da1c9e6.dirty

