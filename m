Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63D29DB81
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749385; cv=none; b=B/8YzzLp2Snwt4NPr+dJGkSR053uoitBsFR8u2NEOPbgrc4w1ZCKE2oZLAbENVXiYwgU8D9LIYGqNk5MyGxOldx8gWb0j1zyvAUA63AuSreCcvIt8bbdru4CLtyr1CkpQERzAI72vUk0KH6+SH94rPB85zSqHyUammswL34B03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749385; c=relaxed/simple;
	bh=ZikjLa/jmSLMerOpJvEWQOAGu/8EgWKSoLVXktz6VBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCNuQh8U2dec9azks00j4SPFrqg2+A+pp3zKU7vKnIkouUSyRnE6nSBTFo+aN4+eFK17RDhZglRZb1yFlZ1ixQd7o5u7rTeUtZjm8fP5qA8uJ2EnN99m+vRTc6debQFCCzS52nYuPD4mgTZK458l6kTlxm8u1d8xJEn5JN0S5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=htYv7WGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6EDEC+3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="htYv7WGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6EDEC+3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8521E7A0209
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Jul 2025 06:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749382;
	 x=1752835782; bh=+uqyYkVTq91xA+ZBB7x1iOznZ/DNXHcabtNXglCrJCQ=; b=
	htYv7WGxELjfpZEbCQvEikki44f5w+51Cztzc6pbHM87Qv/HKApSOMLWAdpCLo8g
	xCs8onTveCDvTTIHbic+7jlqfOP/2fInW88iaeZwU7GHlIqJPsS8CFhFl9V3I9uQ
	kaTcTkpS61CJ1/Aw1SpfwG64//c64btbvLHYIbzRh/xBWfs2If+fnWqNME9W+GSb
	f9hb3oAGAHL4tLHnISdxXRcmWq3U5bpgs5UvzKaPwLCRFFvUdzwQsHR7DK6yuKw4
	vPr7n8tupesUtiB+yioBGsMQ3xjWTMMu2OOo+oHQSzmRTFar1PYEH6g9GZTUTeNk
	qFs4GsWHMS7tE3HK5VTHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749382; x=
	1752835782; bh=+uqyYkVTq91xA+ZBB7x1iOznZ/DNXHcabtNXglCrJCQ=; b=n
	6EDEC+3naKw5WtHKBmz0N5ReERuEK18J1D9JTSuhmzkqa+TlwBEX2qUBFj5kIjDZ
	Y1jiTFocMxcLAbmsWX4VYDxTpCoaHdHtfM7ZbMKY0XNx+lra/0fxRVv83puZTZd7
	cKXLdeZtGqzxP3lHkbetmfmSefJPoks+LuBznTk6beaCyX3nV7838vcYY3yETRpE
	tNphZ9gIE4HEIN6TXLB/pbq+sFXyUauiQo2lsjVsfzRwDsFF4noxqHbCxrtrY1DO
	OZ66DHakdnoK1nDw1gvrmN4rV/D0/ZWLJKvCcM+T4BFI8wFezv9t4BGagz/iHovw
	FMDixJPZslc3ueRCtAqmA==
X-ME-Sender: <xms:RtV4aEsM3N-cYi3oSpnnwfUd7qo5N5w1g5kily0EvkXawgl6O9z64w>
    <xme:RtV4aDcJA9_3NsajNQtFJMlHcdzJEPAWNORM-x71SRao59RmNjwQ1AK04yyLKFE8H
    GR6JP1-9e-nQs7sRg>
X-ME-Received: <xmr:RtV4aJLXu0fWW-cejbudW3QOz9w9VEkhxfjsgulBfgklad9sFPOqNDyTzNZi2-rT8OI-xSvcqDWGlesfoZGswduaUq9RD15UzxI0lmWyi-3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:RtV4aJbqZEbzSVbmiOD7T9TeNgL_aPaXlMXkSB4uF8Gj10L_P9SWdQ>
    <xmx:RtV4aMuSrbt-0YFcL51eoX67p5Hc9CuvpfmksazBisJfHg3s6JsIBg>
    <xmx:RtV4aOvr7EYqYz7-HpQFsJf5jRZqKs7jA9ikiT0mVrxwI77aj3j6AQ>
    <xmx:RtV4aJc0DS7H8jIL0s_Se-6QukFRxQJxBwkKb1AnctL7a9zKmJVavw>
    <xmx:RtV4aAXhlwfxjdPE-spcSzSiQlEU2GiZ9XUN5c5kWNOGsDmpEubE_gfz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46a93806 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:24 +0200
Subject: [PATCH 04/21] config: drop `git_config_get_value()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-4-d888e4a17de1@pks.im>
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

Follow through with that intent and remove `git_config_get_value()`. All
callsites are adjusted so that they use
`repo_config_get_value(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 4 ++--
 builtin/pull.c         | 6 +++---
 config.h               | 5 -----
 rebase-interactive.c   | 2 +-
 t/helper/test-config.c | 2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e5c3d082eda..e94931ff48f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -114,7 +114,7 @@ static int gc_config_is_timestamp_never(const char *var)
 	const char *value;
 	timestamp_t expire;
 
-	if (!git_config_get_value(var, &value) && value) {
+	if (!repo_config_get_value(the_repository, var, &value) && value) {
 		if (parse_expiry_date(value, &expire))
 			die(_("failed to parse '%s' value '%s'"), var, value);
 		return expire == 0;
@@ -178,7 +178,7 @@ static void gc_config(struct gc_config *cfg)
 	char *owned = NULL;
 	unsigned long ulongval;
 
-	if (!git_config_get_value("gc.packrefs", &value)) {
+	if (!repo_config_get_value(the_repository, "gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
 			cfg->pack_refs = -1;
 		else
diff --git a/builtin/pull.c b/builtin/pull.c
index d13ed9b5176..5ea51c31f58 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -312,7 +312,7 @@ static const char *config_get_ff(void)
 {
 	const char *value;
 
-	if (git_config_get_value("pull.ff", &value))
+	if (repo_config_get_value(the_repository, "pull.ff", &value))
 		return NULL;
 
 	switch (git_parse_maybe_bool(value)) {
@@ -343,7 +343,7 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 	if (curr_branch) {
 		char *key = xstrfmt("branch.%s.rebase", curr_branch->name);
 
-		if (!git_config_get_value(key, &value)) {
+		if (!repo_config_get_value(the_repository, key, &value)) {
 			enum rebase_type ret = parse_config_rebase(key, value, 1);
 			free(key);
 			return ret;
@@ -352,7 +352,7 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 		free(key);
 	}
 
-	if (!git_config_get_value("pull.rebase", &value))
+	if (!repo_config_get_value(the_repository, "pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
 	*rebase_unspecified = 1;
diff --git a/config.h b/config.h
index 9261ed0f8d7..5dc330b88b1 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_value(const char *key, const char **value)
-{
-	return repo_config_get_value(the_repository, key, value);
-}
-
 static inline int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
 	return repo_config_get_value_multi(the_repository, key, dest);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index cbeb8641477..809f76a87b8 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -30,7 +30,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
-	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
+	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
 			!strcasecmp("ignore", value))
 		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index cacf6f306b1..99c91512173 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -110,7 +110,7 @@ int cmd__config(int argc, const char **argv)
 		fprintf(stderr, "Please, provide a command name on the command-line\n");
 		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
-		if (!git_config_get_value(argv[2], &v)) {
+		if (!repo_config_get_value(the_repository, argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else

-- 
2.50.1.465.gcb3da1c9e6.dirty

