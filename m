Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B65221F2F
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667295; cv=none; b=gd98ROibHNfqiKzPXLEZfXRdRBpKtz7IH/euRxx+okLmCp0Hn9EYqahQiD9sxPX46vUkV/a2a8LoCPEMV1Rce7v+oNnrmx4wStOoT9c0bwi2n7lPkrrRz4Lb0/+B95OLe31r8197d08AeebvZGrDv/WUD+FGyD6Yi0H9pay8fVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667295; c=relaxed/simple;
	bh=uPupdeSVOcX8nuMwescpdKMY09t+PMJZJmfm32lreBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+tBMwP0k7IQGsorQtjhwwe+ps9H2lvH1jLoaVSMw7EQY6CUma5jz5Ci7LEUsc7GpYfqT5a3jSLTVPxDsOzGkonDA1WsyRMshfJJ0DSFWoP/SLuaqYq2Py3Nq7GJhUhtjiG83USvehb001LHlcPwPb9KKale7cV1A+ywuzYyI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zmk1enET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+Nowej0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zmk1enET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+Nowej0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F62EEC037C;
	Thu, 20 Nov 2025 14:34:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 14:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1763667292; x=1763753692; bh=k3lHdAKR91mF19Z8mtutB14+H9Fjykxp
	/FerG2AQ5l0=; b=Zmk1enETwV8DmCakSdH7WjPVOyzQwJZD+wRYDGupmgRR6GzJ
	dTjXc6KCNnFHTReOM6RlrYO5CbW16MChmoU3ewdDlInxPX2wb6byPP+p+oEXPo32
	0cxOkjEj8B+rEk8oCexQcoJPuiVxm/F3U56CBea3jqOYO1kNhfHegRYh19HZJhBn
	ZLFO/tMBU++xVJSHWaGPhtbeFZgfztMghefdVZi12xvePOOyqHuz2Kc5OQcUK1Bs
	7wI0bczxiFhzfpFRvYgcCahXQheXbZNfztOl/VVbBaYmPf60RWs0wpfjgLcjWD3D
	ldadESm7KhEi7tEVB0OJWVw6PULvrTJNtS7ZUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763667292; x=
	1763753692; bh=k3lHdAKR91mF19Z8mtutB14+H9Fjykxp/FerG2AQ5l0=; b=G
	+Nowej0a+bf1UuGiFbPPaNPVAWJuXtgPUC1HR6+hL2AJLBgxSUeF/1m1DyOIhgVA
	nir2/qz/pWBn7LM3pgoq2L0A0J6uCDh7eM5xKakt5f21zi3Kqd/3FRjguxyvPp/Y
	4EBtLzhG2LHQ4enshzfxDx6X1lnD9iRuDcIpCakt5reSUFQvDiuMXyc7ID9I/NH0
	e/Z2ZWgRKOiJzGa+dIV5pgbW7j9D7EgSVk5oON+5wCvCneAnBxu2Lj4DKqkvFM7M
	29SuixAXopyUNzYHxtKFATIJpLuAGAxZ9o2DyWg9v2FcPbjgYIjQY0YcXc6pSkJp
	nMPD6NVAcvNt3q7KAA3Vw==
X-ME-Sender: <xms:W20fac0RSE36jd-baJqLlELqyC0obZUvkgRmYAbEJXVajmA8dxOseA>
    <xme:W20faeGC2Dmwgp8qFq2imZ4hWkOndy9WjcD0dqoOZsoGiL2YQ3ge28xBQOKEhRAW9
    RfgcuFU0OFytEzU9kF0MfSPmY0YPL1IIxMih1hy487shV8rBTTkcJc>
X-ME-Received: <xmr:W20faZ7tG1rrBA-ryC38G_CYnNhTFbQm-2pMGALi21kljxtxTiC9zjVUkfpjpcoQeXZu1XpZ7iMRxPqIc49qgRcQ5kheNpSLt-hh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejhffgfedvkeeftdfhjeegffeiveeiie
    efgeeuiefhjeelueefffejteekffffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:W20faUsuKGBinDNTlfhPWU0axj9wh8JAgrkUcM9D5WjeaWKnFY2TTg>
    <xmx:W20faa5NGG_WKjMLZTuFDPdH9RAs7NLt7Elrtdi8zaqA4PpkVjYkQg>
    <xmx:W20fafW0IfLfEZa_5XLqQaJSXR_hTiyMI8QM-1b90-HLIRuSey0Mhg>
    <xmx:W20fac89tTDeRlHxQRWzalK_yylT_rpUpUZJOdRCKvnIW5nwd0eFwQ>
    <xmx:XG0faR2MdBkfpvG3oXLBSG9wjFV5xQfrDqqsCREh1kxQ6V9TvpwbJvV5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 14:34:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: [PATCH] config: really pretend missing :(optional) value is not there
Date: Thu, 20 Nov 2025 11:34:50 -0800
Message-ID: <xmqqms4g7b1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Earlier we added support for a value spelled as ":(optional)path"
for configuration variables whose values are of type "path", with
the documented semantics "if the path is missing, behave as if such
a variable definition is not even there."

This has worked OK for code paths that reads configuration files and
stores the configured value as a string, where NULL in such a string
is treated as if the setting is not there, left as the default.

However, there are other code paths that do not _ignore_ such NULL
values and misbehave.  "git config get --path" is one of them.

When git_config_pathname() helper function finds that the value of
the variable is an optional path *and* the path is missing, it
leaves the destination pointer intact (which usually is left to
NULL) and returns 0 to signal a success.  format_config() helper
however assumed that the destination pointer always gets a string,
which no longer is the case, and segfaulted.

Make sure that git_config_pathname() clears the destination pointer
in such a case, and teach format_config() to react to the condition
by returning 1 (which is different from 0 that is a normal success
and negative that is an error) to its callers.  Adjust the callers
to react to this new return value that tells them to pretend as if
they did not even see this partcular <key, value> pair.

Reported-by: Han Jiang <jhcarl0814@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is only about "git config get --path".  Another patch for
   the rest of the callers of git_config_pathname() will follow in a
   separate message.

 builtin/config.c           | 45 ++++++++++++++++++++++++++++++--------
 config.c                   |  1 +
 t/t1311-config-optional.sh | 36 ++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 9 deletions(-)
 create mode 100755 t/t1311-config-optional.sh

diff --git a/builtin/config.c b/builtin/config.c
index 75852bd79d..e58eb6a176 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -261,6 +261,12 @@ struct strbuf_list {
 	int alloc;
 };
 
+/*
+ * Format the configuration key-value pair (`key_`, `value_`) and
+ * append it into strbuf `buf`.  Returns a negative value on failure,
+ * 0 on success, 1 on a missing optional value (i.e., telling the
+ * caller to pretend that <key_,value_> did not exist).
+ */
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
 			 const char *value_, const struct key_value_info *kvi)
@@ -299,7 +305,10 @@ static int format_config(const struct config_display_options *opts,
 			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
-			strbuf_addstr(buf, v);
+			if (v)
+				strbuf_addstr(buf, v);
+			else
+				return 1; /* :(optional)no-such-file */
 			free((char *)v);
 		} else if (opts->type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
@@ -344,6 +353,7 @@ static int collect_config(const char *key_, const char *value_,
 	struct collect_config_data *data = cb;
 	struct strbuf_list *values = data->values;
 	const struct key_value_info *kvi = ctx->kvi;
+	int status;
 
 	if (!(data->get_value_flags & GET_VALUE_KEY_REGEXP) &&
 	    strcmp(key_, data->key))
@@ -361,8 +371,15 @@ static int collect_config(const char *key_, const char *value_,
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
 
-	return format_config(data->display_opts, &values->items[values->nr++],
-			     key_, value_, kvi);
+	status = format_config(data->display_opts, &values->items[values->nr++],
+			       key_, value_, kvi);
+	if (status < 0)
+		return status;
+	if (status) {
+		strbuf_release(&values->items[--values->nr]);
+		status = 0;
+	}
+	return status;
 }
 
 static int get_value(const struct config_location_options *opts,
@@ -438,15 +455,23 @@ static int get_value(const struct config_location_options *opts,
 	if (!values.nr && display_opts->default_value) {
 		struct key_value_info kvi = KVI_INIT;
 		struct strbuf *item;
+		int status;
 
 		kvi_from_param(&kvi);
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item = &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(display_opts, item, key_,
-				  display_opts->default_value, &kvi) < 0)
+
+		status = format_config(display_opts, item, key_,
+				       display_opts->default_value, &kvi);
+		if (status < 0)
 			die(_("failed to format default config value: %s"),
 			    display_opts->default_value);
+		if (status) {
+			/* default was a missing optional value */
+			values.nr--;
+			strbuf_release(item);
+		}
 	}
 
 	ret = !values.nr;
@@ -714,11 +739,13 @@ static int get_urlmatch(const struct config_location_options *opts,
 	for_each_string_list_item(item, &values) {
 		struct urlmatch_current_candidate_value *matched = item->util;
 		struct strbuf buf = STRBUF_INIT;
+		int status;
 
-		format_config(&display_opts, &buf, item->string,
-			      matched->value_is_null ? NULL : matched->value.buf,
-			      &matched->kvi);
-		fwrite(buf.buf, 1, buf.len, stdout);
+		status = format_config(&display_opts, &buf, item->string,
+				       matched->value_is_null ? NULL : matched->value.buf,
+				       &matched->kvi);
+		if (!status)
+			fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 
 		strbuf_release(&matched->value);
diff --git a/config.c b/config.c
index f1def0dcfb..d55882c649 100644
--- a/config.c
+++ b/config.c
@@ -1291,6 +1291,7 @@ int git_config_pathname(char **dest, const char *var, const char *value)
 
 	if (is_optional && is_missing_file(path)) {
 		free(path);
+		*dest = NULL;
 		return 0;
 	}
 
diff --git a/t/t1311-config-optional.sh b/t/t1311-config-optional.sh
new file mode 100755
index 0000000000..766693387f
--- /dev/null
+++ b/t/t1311-config-optional.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2025 Google LLC
+#
+
+test_description=':(optional) paths'
+
+. ./test-lib.sh
+
+test_expect_success 'var=:(optional)path-exists' '
+	test_config a.path ":(optional)path-exists" &&
+	>path-exists &&
+	echo path-exists >expect &&
+
+	git config get --path a.path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'missing optional value is ignored' '
+	test_config a.path ":(optional)no-such-path" &&
+	test_must_fail git config get --path a.path >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'missing optional value is ignored in multi-value config' '
+	test_when_finished "git config unset --all a.path" &&
+	git config set --append a.path ":(optional)path-exists" &&
+	git config set --append a.path ":(optional)no-such-path" &&
+	>path-exists &&
+	echo path-exists >expect &&
+
+	git config --get --path a.path >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.52.0-101-g4c43c53c49

