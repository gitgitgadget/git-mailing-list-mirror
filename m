Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CA2BEC39
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749439; cv=none; b=BKKZJLz8oi5gu5N3CrR0Dk06w2vENpUCevCjQJnUlqrc/Cjn7nlKq/x8MDpcN7ZGbhXkY7rGghen2JOjWZmHeSdOjq9c3kpG1EeCWfPury7SYadqf7k5J5nVWEL/IdTMXVSb3bNblayjCjBLjlXcE16wFt0EdFD2B40jaAco7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749439; c=relaxed/simple;
	bh=NBTpvSnCU0+dethE3OryF0AxxEevxC1fmjJeFBXI7so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIp8/bBYK8pGbX1KZVBj9p78fJBFZFdxxTtfbSFQNLpkTT+kncvR0D9WjDFSqz/iJZzALzWGZWNBHNzzr4LvopREvw7MyAzLOQr+2MaPUqmWYHpapylVlNXjtQxUKuemUHVs3iWmli9Yd7aamZN+VHv5UG0LOPItHjxy6mNaskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYbMpNDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zoa60WoF; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYbMpNDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zoa60WoF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 159901D00166
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 06:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749436;
	 x=1752835836; bh=zU7qlJqUYGlCO7QnBQo9liOofKgrrYqrFq76P6oJinI=; b=
	TYbMpNDUem7Dj6syEiwLB4XnV3rsVxL4LtLrGTYznhUWI+Y1YUDNCc6Uyt+p60Vq
	2vGZHtAkU5mYyi9EH1grOUA2TMdtVI1B5+HpbExJybhqSXJaIoJQLNayHN/8hsyC
	6vWpJxGp7lc+Qp6VOIGnwUErXM/tKbwgEz3oTZzW4PrFxUlCwhkSi5U4eMcAkrO2
	Q/+9D5CkUJGhtEs14PViDylZLEFHEtSwIkSXCyPzAPHTZxJbOfdW7RcvUuMIMl+R
	WV0H+mLcYKCqEXJSpiKyKtfLz/u39HaMU+1dE7NN+/9qyMvTdTtQ4SLA1MPppr38
	38ojv+lWc512hJZ/IGrezQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749436; x=
	1752835836; bh=zU7qlJqUYGlCO7QnBQo9liOofKgrrYqrFq76P6oJinI=; b=Z
	oa60WoF/zeNF27EY2HZGIta5oTwX2fcVPccrU/Qm8jtttdY3b6iPTcZQkR6XYBhi
	vHuA0NnJ3/1ZUc94tmXn0wRPlhLy1W2CQ5Xa7Fq/0YhHEHYICLHmsvzKv4Ob2FMU
	NieCIEVgBiPlspKQnTOjgOJEKyVg7AlS/D/l8zGB7te8GaiECxRAfsvJJHIUQbR0
	wDzWQwfB0n9bQslkn7Lt3DqONOdk3Ec9W1t+vJAecIRHdvScpaRwO3SX7J+jK1z+
	6FM6oQH4gjSlbf7VFRmsqdR6B2nFxqDbTVeGcU2MoAYVZCB+wz5q51NZyVFOaHJv
	6YaONEORZckDtfPD85Lvg==
X-ME-Sender: <xms:fNV4aEAdQ8DvFzuAHP85X-_PIayqqI6q8EdF2Ji1WhO_rmahd1WSzw>
    <xme:fNV4aIhf_RsXsRU07tPnAUvZmdXaLfAirBfi2B57NeuPzgz_lth_fgTaTAlNT1GFP
    vaOCoaEYmF0YM0h0w>
X-ME-Received: <xmr:fNV4aA9ei_iW0MJgC3HcBehEmx8KfwScPUtb79ukSg2veB0WikPnzqigmgoFYfe53XtZglfORJ5740zreZkuPIrqD7NEPTR3Srpo1oDA_xj9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:fNV4aM970WJE8RFnrQx0C-3GwvAWwTCWGXhEJDBQDbGvuQ3FuesS2A>
    <xmx:fNV4aBCe7K7M5GUtQkXF8vDltFmeKLgoD-4pk-cvyxIxkvgQY5oUzA>
    <xmx:fNV4aEy2gLajlI2m6EyWcsc5Ctvz66aLQgtSvXlmOdzr1hQtq423RQ>
    <xmx:fNV4aOSFOSfs3jbhaECWFNsYeGliFAuZ5ihSi3XlDGISitvUNHBvVQ>
    <xmx:fNV4aH4yH0ZrEBfDf_9goA2xAE47P5WChUjzNL4IiZk9IsrgoqZne01a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1431f559 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:41 +0200
Subject: [PATCH 21/21] config: fix sign comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-21-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are a couple of -Wsign-compare warnings in "config.c":

  - `prepare_include_condition_pattern()` is declared to return a signed
    int, but it either returns 0 or the index of the last dir separator
    in a path. That index will always be positive, so the return type of
    the function is changed to `size_t`, which allows us to drop a check
    for `prefix < 0` at the only callsite. Furthermore, this fixes a
    sign comparison warning when comparing `text.len < prefix`,

  - We treat `struct config_store_data::seen` as signed integer in
    several places even though it's unsigned.

  - There are multiple trivial sign comparison warnings where we use a
    signed loop index to iterate through an unsigned number of items.

Fix all of these issues and drop the `DISABLE_SIGN_COMPARE_WARNINGS`
macro.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/config.c b/config.c
index 947fba3d8d4..a530c48a048 100644
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
@@ -197,12 +195,12 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(const struct key_value_info *kvi,
-					     struct strbuf *pat)
+static size_t prepare_include_condition_pattern(const struct key_value_info *kvi,
+						struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
 	char *expanded;
-	int prefix = 0;
+	size_t prefix = 0;
 
 	expanded = interpolate_path(pat->buf, 1);
 	if (expanded) {
@@ -239,7 +237,8 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
-	int ret = 0, prefix;
+	size_t prefix;
+	int ret = 0;
 	const char *git_dir;
 	int already_tried_absolute = 0;
 
@@ -253,9 +252,6 @@ static int include_by_gitdir(const struct key_value_info *kvi,
 	prefix = prepare_include_condition_pattern(kvi, &pattern);
 
 again:
-	if (prefix < 0)
-		goto done;
-
 	if (prefix > 0) {
 		/*
 		 * perform literal matching on the prefix part so that
@@ -724,7 +720,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		unsigned long count;
 		char *endp;
-		int i;
 
 		count = strtoul(env, &endp, 10);
 		if (*endp) {
@@ -736,10 +731,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
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
@@ -747,7 +742,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
 			value = getenv_safe(&to_free, envvar.buf);
 			if (!value) {
 				ret = error(_("missing config value %s"), envvar.buf);
@@ -1614,13 +1609,13 @@ int config_with_options(config_fn_t fn, void *data,
 
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
@@ -2470,10 +2465,11 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
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
@@ -2716,7 +2712,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	} else {
 		struct stat st;
 		size_t copy_begin, copy_end;
-		int i, new_line = 0;
+		unsigned i;
+		int new_line = 0;
 		struct config_options opts;
 
 		if (!value_pattern)

-- 
2.50.1.465.gcb3da1c9e6.dirty

