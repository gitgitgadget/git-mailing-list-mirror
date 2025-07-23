Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DD2F4A0C
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279727; cv=none; b=HqVQFifVq8uU/cVJBCVTt1+EoLewkn8zHu+QYUILJHDCC0mqh8TLY/C9F0jAkaCFSK919hWYJtHZZUfpgZLkZISnNKytYJoDu7dY7EuK0u4tSdFPqrgUq2+X4cUt3PlLDlz9TjDKqz6Q3EUuIVwj4uGs4qOodcCKWaNxyfmdMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279727; c=relaxed/simple;
	bh=MvYjfTFH64SgaQ7C6Ou0hwMgIlD+cyTWdP7umrwfGaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgCrarQEFtMAo3UGSlPLooaqXdyurS2vBlNelODiHVU8R/txyj7zPHzLVo7tqT8ERkETfVq4j+UWZdVlG1beuPJXjhbGwmWlw4cNBtqNTKt/mBmhGM9FJnDqDASbRIEnwoh7uaAEngb0fzTckwDugIjWtv2jtuIVF2xIc1GDYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CyhIJtlx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg/uVFkZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CyhIJtlx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg/uVFkZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 43DB9EC19E3;
	Wed, 23 Jul 2025 10:08:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 10:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279723;
	 x=1753366123; bh=3ajrO7fpNQEnsebQMWx4KziZzyXazL2N1zg7vz8siOM=; b=
	CyhIJtlx4F9eiZOHSV4L2A4wCSlX5TVqFTxz1dwloK/q3o0r08m5IW9Z9Sjf0dF/
	AZJPWlKH9NJZ7McBUJVRZ1GKgznBgNg2sywIp5lvQ6Rs88Cw6I5iSkyng4XZlby3
	C9XZHRqlPaBVKmNIhQvij7H7JSgTAD2uxyGGJUMKuEkrkaIypi4IYZsIIN1LpFOy
	mfzdTLS8AroaUvzLMQ+0UBe1oTIk3YBpLQAFm6HYHuLRZxdNJHJTDk3OaRUdkYrg
	498CR6RVQunBivWM6/7ggUXMiY2hCcJZ521rGwIQFEDbB5DLAQSvavrOiPoF6cBx
	+9ACNP+sZnlZQ4ciGqZMJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279723; x=
	1753366123; bh=3ajrO7fpNQEnsebQMWx4KziZzyXazL2N1zg7vz8siOM=; b=R
	g/uVFkZspENl4iKZppmRnDtkkR5sx3s8nJWCdNx4E8Lc/9b2LCYiKIjik1Ta236P
	G6z84F9lNSyHtYEmhdpHnYaCrswuhAE4xMdwGyWxAasS2Nz7xKkNvKWPMB5BK99X
	Ybo30WyPHwmIyJ65xYM467cFbSClsreZobWwuHj71Vb/g4AASGR2G9PSy9q7bQGz
	rcZaK1r2swesfd5Qo/jID3v0HqO0btjHXL9Nfe9cIfuKm+H/JW9/DGry01F5xJpt
	RDJESq2aiGQDQ53RwagQXh3ZesPP90ztv++PBTBfhZJrE+eNOAOYrnzttOal00HM
	Sf4vdFZ+Bp0m0kxd+jdfQ==
X-ME-Sender: <xms:6-yAaGbDmpa357Sn9YbpFoQg1K38-ZBSf_hIgbpvo45WVe1UL-2C_w>
    <xme:6-yAaJnMw_V7yJ6oyIG7zi1oVl1kxy5k3a-6kqmyMQjuFwLJal5zckfAGvBJU_pdB
    1PyWZHmTnF4w2Vyzg>
X-ME-Received: <xmr:6-yAaCzcFQGLh6E9OpWShE-ghMlc4jmeIQZqaLrYhtuPyNMHQd5I5MjwoilXUpf030kOJ-C6w3YynN2QbPu-zq17_oo6eJkBLbNvjbBjdiaG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6-yAaHPEdCT7SU7t1Z7FQmVwxXT0tjMcM-SVJ55XARuEoUVKIcc2ow>
    <xmx:6-yAaGTi0t9BiT5Wx75ZV6dJ7l_VgTZkjnsloHvNyIHMXKNLQktlBA>
    <xmx:6-yAaFbv9At5x_9Kt_lmFpwP_hOTbykwwvwtTLx5ckoOScuryWuhKg>
    <xmx:6-yAaD0jaw-outLjJQQuWKAw7lbKWR7WP8tWdgvnn3667QHEga6TKQ>
    <xmx:6-yAaJqWwkzlqjO2SYvus1857t01GY7fmXc_ZmxfUIsHbGo_e7UjpiKq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35027d4a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:25 +0200
Subject: [PATCH v2 04/21] config: drop `git_config_get_value()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-4-1502d60d3867@pks.im>
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
2.50.1.552.g942d659e1b.dirty

