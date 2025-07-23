Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75E2EF649
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279780; cv=none; b=Svny8t62wB4HCRHVD34iButx47lyPYL4Pn213TFLyeQaCPsVemVveY3WIcxWufLeOaCsxfoDXicRKzZG3peEqq4AwcUl+z0AOxoWPgxRQjSGU1I//4q7ykXMxY7eop7bmqWk3fct4FnIIl8mD0gniTSOUrlFfknd6jIsBjKeTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279780; c=relaxed/simple;
	bh=bbQHFZBDGScRhF6HekHi/4I1wsNX4XytF8coauREjso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwkke2uppmGF8wAZVMse9Omn1ptVJwXst2kl75y6BG2Ql7sSoO4BipbHXUD8ptOcAxr2cvgimSZKIq2HPLdwP9egLsH0jD9U/NW2bcYE+Gr+EPESCdw3b1kXaYT9TTAEH2B7YRtBevv9Thz+pKvG1fYHZFEfnAJ2B0m/HFp/mTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMDjyt7Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nPIMGaFj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMDjyt7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nPIMGaFj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1A7714021BA;
	Wed, 23 Jul 2025 10:09:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 23 Jul 2025 10:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279776;
	 x=1753366176; bh=aH+HOpFp9LBqsb83bHunzZcx0OgF+aLQFr0buGAudos=; b=
	bMDjyt7ZysSbL5gh85RUyv27RFk2s7dKkckgbt69dCG6fGor800iNln8CgZJW/nn
	ZO17Zb5EOFh9EnBsb8s5iLWzvTB7NuV98DEBAGk+P4fdF+FTEkfJTEMVu8yj9viC
	1zqiL+CKa8rHQKfeQOrYuDewT0WD8D1r5rDfbP5GMnEAbiE6WcD4KtqaZNZGdzdG
	pule4a1a56VZXHFFtSp/VKIsA9/3N3ObcOOxlMoHHE6TOwBJYajoGbfecZDz4+fQ
	x1IcR9J59BqZYEsA37nh9pbkD3BIRgZ6JZuUfteLkA4Cd+IlYiO+cDjQ5hONGFNv
	eIXz7mre6c3zocD/TfqGUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279776; x=
	1753366176; bh=aH+HOpFp9LBqsb83bHunzZcx0OgF+aLQFr0buGAudos=; b=n
	PIMGaFj375sPdGwaGs8grnBve/XE7yH4nQ8RxSEX7LuhCvdMGQudS+9+7yDzaxmp
	RJvY7fvIW3TBHhQ6jB33PXUSSRvCAkwcInKfOcMu8a9G5WCzcy+xuJ2W6Bee7BAL
	Vm+85kTo5MYrda2YMNFJ2eHY8wHODaS9PihSdstmJ4MYyEe3Q3GCIQBUg8TMk9QO
	ktX9lj3bgBe/jprDybikdYW9V6kSO5LAhxhfN9JeGREXd66rzfFIf79Gnzf/2pph
	4Nvs44PxMHGoyL8Eg3yMcyVAIPQRSbkF9I+NU9idtdDgoWghm0/O5BmL5N3FaXfS
	3O3zRQvtU8AbFfxsm2rxA==
X-ME-Sender: <xms:IO2AaB5HHFNQ5GLXpPB7XaFo0eXQMNypOkk39ft3lX_KsXLsJuunRw>
    <xme:IO2AaPEx4JKDs4j9ESBVSJYRKN9uaU-LqQBgBxSICXKlv-Bhcs8tUwH5nvXsJlNtL
    pEaODz24oTAr-L9gQ>
X-ME-Received: <xmr:IO2AaKQSWia3l7ClzBzt35qwQHYkoPqGggA4-BQ0jJK3z5BHAjE7o_MNPN-ANACvyYT-PPca-Yd0_b1fYaWQGPMFUGc_UKspz-ZpHcEt8ABS>
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
X-ME-Proxy: <xmx:IO2AaIvFD5Lms3qHXEvI4DHNZhEjhcxTk3gusiuzW8O9s9Kf7Z50tg>
    <xmx:IO2AaJzp7Z_OxOnM5txClmah5BdO_dC-PgBAm75R_mSGRrj0qnl9Gw>
    <xmx:IO2AaC5Sk1fCU0A7MmJgSlXDMZNEqRHnfHqZ6aT2oH5HnRuzP87E9w>
    <xmx:IO2AaDVJyf3nwmS6gRlugfRs26rr4thPEpiVMYcxKNVDBjrc66oEPA>
    <xmx:IO2AaNKVY1CloSHvAKHWdlyyDJYA8qEYZkbKWzMqzA9Jw9hget-_ODIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 709547e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:42 +0200
Subject: [PATCH v2 21/21] config: fix sign comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-21-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of -Wsign-compare warnings in "config.c":

  - `prepare_include_condition_pattern()` is returns a signed integer,
    where it either returns a negative error code or the index of the
    last dir separator in a path. That index will always be a
    non-negative number, but we cannot just change the return type to a
    `size_t` due to it being re-used as error code. This is fixed by
    splitting up concerns: the return value is only used as error code,
    and the prefix is now returned via an out-pointer. This fixes a sign
    comparison warning when comparing `text.len < prefix`,

  - We treat `struct config_store_data::seen` as signed integer in
    several places even though it's unsigned.

  - There are multiple trivial sign comparison warnings where we use a
    signed loop index to iterate through an unsigned number of items.

Fix all of these issues and drop the `DISABLE_SIGN_COMPARE_WARNINGS`
macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index 947fba3d8d4..2fe8e52ae2a 100644
--- a/config.c
+++ b/config.c
@@ -6,8 +6,6 @@
  *
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "date.h"
@@ -198,11 +196,12 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 }
 
 static int prepare_include_condition_pattern(const struct key_value_info *kvi,
-					     struct strbuf *pat)
+					     struct strbuf *pat,
+					     size_t *out)
 {
 	struct strbuf path = STRBUF_INIT;
 	char *expanded;
-	int prefix = 0;
+	size_t prefix = 0;
 
 	expanded = interpolate_path(pat->buf, 1);
 	if (expanded) {
@@ -229,8 +228,10 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 
 	add_trailing_starstar_for_dir(pat);
 
+	*out = prefix;
+
 	strbuf_release(&path);
-	return prefix;
+	return 0;
 }
 
 static int include_by_gitdir(const struct key_value_info *kvi,
@@ -239,7 +240,8 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
-	int ret = 0, prefix;
+	size_t prefix;
+	int ret = 0;
 	const char *git_dir;
 	int already_tried_absolute = 0;
 
@@ -250,12 +252,11 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(kvi, &pattern);
-
-again:
-	if (prefix < 0)
+	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
+	if (ret < 0)
 		goto done;
 
+again:
 	if (prefix > 0) {
 		/*
 		 * perform literal matching on the prefix part so that
@@ -724,7 +725,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		unsigned long count;
 		char *endp;
-		int i;
 
 		count = strtoul(env, &endp, 10);
 		if (*endp) {
@@ -736,10 +736,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			goto out;
 		}
 
-		for (i = 0; i < count; i++) {
+		for (unsigned long i = 0; i < count; i++) {
 			const char *key, *value;
 
-			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);
 			key = getenv_safe(&to_free, envvar.buf);
 			if (!key) {
 				ret = error(_("missing config key %s"), envvar.buf);
@@ -747,7 +747,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
 			value = getenv_safe(&to_free, envvar.buf);
 			if (!value) {
 				ret = error(_("missing config value %s"), envvar.buf);
@@ -1614,13 +1614,13 @@ int config_with_options(config_fn_t fn, void *data,
 
 static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
-	int i, value_index;
+	int value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
 	struct config_context ctx = CONFIG_CONTEXT_INIT;
 
-	for (i = 0; i < list->nr; i++) {
+	for (size_t i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
@@ -2470,10 +2470,11 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
  */
 static void maybe_remove_section(struct config_store_data *store,
 				 size_t *begin_offset, size_t *end_offset,
-				 int *seen_ptr)
+				 unsigned *seen_ptr)
 {
 	size_t begin;
-	int i, seen, section_seen = 0;
+	int section_seen = 0;
+	unsigned int i, seen;
 
 	/*
 	 * First, ensure that this is the first key, and that there are no
@@ -2716,7 +2717,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	} else {
 		struct stat st;
 		size_t copy_begin, copy_end;
-		int i, new_line = 0;
+		unsigned i;
+		int new_line = 0;
 		struct config_options opts;
 
 		if (!value_pattern)

-- 
2.50.1.552.g942d659e1b.dirty

