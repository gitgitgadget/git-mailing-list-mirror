Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280912F5323
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279731; cv=none; b=rUVBgtXk3xzxBjOa4n0YZ3RNxCYqdnm9kvRsCyukvKq7/xVshNP7r5vs1nOGSYfBRUjzArfSQrqwLaEbMsLs4PgnHmdG4cOeyukDh4pAnPzbvwKneUFuwFyBvrgqNj9+1afYT5WPHW/j8s6qTA1oRcpF3vdz/iC2tuY9A/W4Wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279731; c=relaxed/simple;
	bh=X5OKZ7qlKJZ5SPUeQgDVM7BEk6K6pdLuy49D1n/WTko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjdxOcFCXROInUoyrsVTYgRUyNktss7PHo4qRHDELJ+4Uv6bNYi3si5+YnPvxXmKr0pMEhxRYdol790Zt2cZMXio5T4YKWcdQXfHYvuR/bXDjkj0Cu7GSrc3ADrincz115pokN08a89wfHeItJxC8WVJYUHyk7ubcB+34e+5qEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=udUfP7Z3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlgvcobP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="udUfP7Z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlgvcobP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E1D3EC19D2;
	Wed, 23 Jul 2025 10:08:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 10:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279729;
	 x=1753366129; bh=YfEm4bxGWxyTW26VewplAkSceMOPMcencZN7z16hmxY=; b=
	udUfP7Z30VkmBO9xqv/usgiUQNezOn4fnWiZkdrFhxbGEi48cJetaqGMVoKzmH0z
	0A5R2Oo/Yk2hfAa9MbSeKyvHG4WJYIOhKqjMHQg5jPeQv72y3XefJ7i9T3EUlS86
	k83C7SpeuvRZDlX6evgwzT9DuA9LizEceU4EiRK3OJ+jSW5BbNpYp34rB9pp119n
	ZtFzzTCDEPOobrqOdmTWMj0s3SoFlPlNJbbmJqxcbzc9eDTOFOE/OuqYS29xEWDY
	DIBdPzKLdOIG4+xlXLvVDYcOTHXju5XgePm4Mnd6JAhJJDkm7I+gvzt+FoVHuluE
	SPMlmCnXFIZ5uRbi7XKBgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279729; x=
	1753366129; bh=YfEm4bxGWxyTW26VewplAkSceMOPMcencZN7z16hmxY=; b=j
	lgvcobPH2mJV6sMR7NRNPToZdLK3zuPe+N+kuzuBOr3JMq2cSvPtthR0vv46+omi
	IBoysSDXhobaLBLfu3Vv5bgPqZU0ccu+ekPS6WMECkhAp3IWnJ7/qPTDc+K+Lbz+
	cX3b/ZcS81eNSwCA7UN9DNdku0uWgudpVNmQpcSjkgGgVTuqzbCVsZJCLxjGJ2UE
	22iKPCicxzqA0sURhbPPyJMWiNxn7CDemdvWp9cgeIAPMf34qJRomaBBcBYKGPNz
	HxC8WE89J2ES6aWFSegw4QrrpVqF3BDd1QqoXIS0+luTqwnWiJgJ40MOGHeIN6pD
	tgAshW98VYuMbYFE3A53g==
X-ME-Sender: <xms:8OyAaHMChrtyQ63GXy_wU8LcgWfXZojj9iFDsMBNOEybbp7p1GIOFQ>
    <xme:8OyAaCJTj26N880WyZ0CIrQzlJT29PkrauGB4CLcuBIzHxit9s7JDDchpGSl-xjcV
    rIHN6UQThBP6MYNhg>
X-ME-Received: <xmr:8OyAaIE66R5ZlNL7ujC4naWJjtKxij82jxWpjHEZrx8amOYC-QxDYyhfdSeRxVf5mObNDUHZut2wmBw2UZAzuYRs7GSU63LxiIyAX9Humznw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8OyAaKRMkGqL954EWuFZOd3SXuCeYR9ZaivqSJFBC3H2osMJuRGXIA>
    <xmx:8OyAaEHlE4E2PcpzBlrGRI1XOmlo-Yumg7QpbpmyeLrOAC9viW0uig>
    <xmx:8OyAaG-18WZWuC6ADtffQ5afFarbAI_hHV0dTBS3h0_GZvghY7xHlQ>
    <xmx:8OyAaOLxETRjGyN2KgsePtagqn23cjuootLdpOQGQnYiWmoKTdofrA>
    <xmx:8eyAaHc-9twm7RyBOelVzQH6GEp0r5fJ1CmRA6owhY3JIn2zWCqBoXw5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d79e8a7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:27 +0200
Subject: [PATCH v2 06/21] config: drop `git_config_get_string_multi()`
 wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-6-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
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
2.50.1.552.g942d659e1b.dirty

