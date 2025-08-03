Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202102836A4
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754204003; cv=none; b=cvsJqdij9qotf2tucRIlM3Je1Qi0sznsuRUALPBLQOM78ebLtFxGdcpJ6aebHZG8nybD3Dc0HPxX1AKH9xpVgObcy445Hn4YEhcvbEpflZSLdkTuAEWXYsuQvAN7/ibI8Dbx+GZf2/z/D2nvIuAH6rokag0t02Xm7dnlmw3RJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754204003; c=relaxed/simple;
	bh=kieOyMXetP3Ma5BvA6qAzHW5J7lRx+kHLG9SX7rgWEE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbLhlgFXQp3aLlD448sz3zUDUl+jRilM43UlYDiTVgZnSxk5BRSBkPw7yNGn16EquhyKDJij5Kodf0YzHLCGXJ9PNxuQkgap9t6RBDGNDzSYyoQlzTlqMq+GXPBxG9QPYUkiTkiv7HfcO5nvNqyWqDNzy9awY+RUPOfd/meLxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BH+D3ME5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1GT7RFQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BH+D3ME5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1GT7RFQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 87B67EC1517;
	Sun,  3 Aug 2025 02:53:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 03 Aug 2025 02:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754204001; x=
	1754290401; bh=9+HeGcroD5qA3AM8H7GKOX/hYwc5BQF3iuZAo/nsOtk=; b=B
	H+D3ME5hG5LPenKD29u0eb80xQb6Zi8PW54ydnIj7WplfQkqPqOdA1clAU7tGbXe
	hpY54lu5qtXM1XWiNEFZ0RSzJOUKpS1ee6xSs9WMLeQOuhA3NAXBwODbOSEKrnxx
	DjhvgVr+ZoPPFo4LiaOnDfxKS6CuANoqY6LtXhsXfOfKwMGXIQYNqJVUAIH/gHhD
	De6dzuMaQ1y2dZuZeGVRBxpKghd3re3oE4UvkHPl02U4xIsgFVk87CXQPeV8iTZZ
	wLHEKWNuGyD6OtAX2Ek5z4KTXXpx8coBFdWereMD7Rf/BfqZD1Q0VvxxLz2WQlkg
	TQht1pvEYM2Yx+JGfUcRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754204001; x=1754290401; bh=9+HeGcroD5qA3AM8H7GKOX/hYwc5
	BQF3iuZAo/nsOtk=; b=j1GT7RFQYfp4fZUUwaJ3MZHNcEQ/eBpZV08vm4OXoL91
	nE08dG0ZIj2uQ485Y8lMTjgKrENeZk/AzKAFMeHEx5oElICDfSfSgDrxUv+uO6S8
	i+0dj8fX70Mglk6unwxYzTMSQVLzLcpvU+cyPq3+4gMVuNimSKQDFHUzAd9g3V6O
	M9svC9YDzU4lgtixI1KTT8WiL/a0arpErWXnOK39jCQalJPTxUiuzkoJN3E8+l7b
	doiTXRfoLxWip6Vrcn9/9n8WrqZDF1S48tA0LvEh8Bj9twp11NMJuZL2pmcHtMl5
	4knUF3paqH/o3Bmbf0EskmeC4Xv/0gzZ2RdxIdY1PA==
X-ME-Sender: <xms:YQePaBHvjQSTrcGw2Ff_z3kC-r14QkNPdiC42ltslpKNEi2oXApHSg>
    <xme:YQePaGgGLcuxuMGIPYceLKS85OsdYfJvrxYKAf-VJt1dIjYged6S78mrv6TrPbReR
    1v1yyPCpp_67YyEUQ>
X-ME-Received: <xmr:YQePaE9zpzXV0fXyCWHc4I2LFAqaHzEAeyvpjR4JhY6olU9ekWEqE51-cmtSebB9povV7qLCdeZKs1xN8YGEU6ejGvOY2-EJ4onSOqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:YQePaFqQfwIN4_JhHx5QzrVP3BjpsGBSwc6CEjwZJFguFjbEpcCWsw>
    <xmx:YQePaL89kWjY8VUPRa7BfhRj9ZvOyi9oMGkJbvoynPZjWKwDpyR7cQ>
    <xmx:YQePaBWX-WxRh00ZW2Xj_Nd0UqUDpgKd5379tsRzhzAH0CnJhCuccw>
    <xmx:YQePaJApMNP7_t6vgGflqj8du6t2SlKMWKlIGTuFqPf_9at8ISrFmA>
    <xmx:YQePaDrHoCx8TtXhrwjDqlcirv-ibrOg1X5_xlHuQlwwsyP6QmdSwwsk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 12/12] trace2: do not use strbuf_split*()
Date: Sat,  2 Aug 2025 23:53:04 -0700
Message-ID: <20250803065304.3325286-13-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tr2_cfg_load_patterns() and tr2_load_env_vars() functions are
functions with very similar structure that each reads an environment
variable, splits its value at the ',' boundaries, and trims the
resulting string pieces into an array of strbufs.

But the code paths that later use these strbufs take no advantage of
the strbuf-ness of the result (they do not benefit from <ptr,len>
representation to avoid having to run strlen(<ptr>), for example).

Simplify the code by teaching these functions to split into a string
list instead; even the trimming comes for free ;-).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace2/tr2_cfg.c | 78 +++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 2b7cfcd10c..bbcfeda60a 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -8,87 +8,65 @@
 #include "trace2/tr2_sysenv.h"
 #include "wildmatch.h"
 
-static struct strbuf **tr2_cfg_patterns;
-static int tr2_cfg_count_patterns;
+static struct string_list tr2_cfg_patterns = STRING_LIST_INIT_DUP;
 static int tr2_cfg_loaded;
 
-static struct strbuf **tr2_cfg_env_vars;
-static int tr2_cfg_env_vars_count;
+static struct string_list tr2_cfg_env_vars = STRING_LIST_INIT_DUP;
 static int tr2_cfg_env_vars_loaded;
 
 /*
  * Parse a string containing a comma-delimited list of config keys
- * or wildcard patterns into a list of strbufs.
+ * or wildcard patterns into a string list.
  */
-static int tr2_cfg_load_patterns(void)
+static size_t tr2_cfg_load_patterns(void)
 {
-	struct strbuf **s;
 	const char *envvar;
 
 	if (tr2_cfg_loaded)
-		return tr2_cfg_count_patterns;
+		return tr2_cfg_patterns.nr;
 	tr2_cfg_loaded = 1;
 
 	envvar = tr2_sysenv_get(TR2_SYSENV_CFG_PARAM);
 	if (!envvar || !*envvar)
-		return tr2_cfg_count_patterns;
+		return tr2_cfg_patterns.nr;
 
-	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
-	for (s = tr2_cfg_patterns; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim(*s);
-	}
-
-	tr2_cfg_count_patterns = s - tr2_cfg_patterns;
-	return tr2_cfg_count_patterns;
+	string_list_split_f(&tr2_cfg_patterns, envvar, ",", -1,
+			    STRING_LIST_SPLIT_TRIM);
+	return tr2_cfg_patterns.nr;
 }
 
 void tr2_cfg_free_patterns(void)
 {
-	if (tr2_cfg_patterns)
-		strbuf_list_free(tr2_cfg_patterns);
-	tr2_cfg_count_patterns = 0;
+	if (tr2_cfg_patterns.nr)
+		string_list_clear(&tr2_cfg_patterns, 0);
 	tr2_cfg_loaded = 0;
 }
 
 /*
  * Parse a string containing a comma-delimited list of environment variable
- * names into a list of strbufs.
+ * names into a string list.
  */
-static int tr2_load_env_vars(void)
+static size_t tr2_load_env_vars(void)
 {
-	struct strbuf **s;
 	const char *varlist;
 
 	if (tr2_cfg_env_vars_loaded)
-		return tr2_cfg_env_vars_count;
+		return tr2_cfg_env_vars.nr;
 	tr2_cfg_env_vars_loaded = 1;
 
 	varlist = tr2_sysenv_get(TR2_SYSENV_ENV_VARS);
 	if (!varlist || !*varlist)
-		return tr2_cfg_env_vars_count;
-
-	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
-	for (s = tr2_cfg_env_vars; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim(*s);
-	}
+		return tr2_cfg_env_vars.nr;
 
-	tr2_cfg_env_vars_count = s - tr2_cfg_env_vars;
-	return tr2_cfg_env_vars_count;
+	string_list_split_f(&tr2_cfg_env_vars, varlist, ",", -1,
+			    STRING_LIST_SPLIT_TRIM);
+	return tr2_cfg_env_vars.nr;
 }
 
 void tr2_cfg_free_env_vars(void)
 {
-	if (tr2_cfg_env_vars)
-		strbuf_list_free(tr2_cfg_env_vars);
-	tr2_cfg_env_vars_count = 0;
+	if (tr2_cfg_env_vars.nr)
+		string_list_clear(&tr2_cfg_env_vars, 0);
 	tr2_cfg_env_vars_loaded = 0;
 }
 
@@ -103,12 +81,11 @@ struct tr2_cfg_data {
 static int tr2_cfg_cb(const char *key, const char *value,
 		      const struct config_context *ctx, void *d)
 {
-	struct strbuf **s;
+	struct string_list_item *item;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
 
-	for (s = tr2_cfg_patterns; *s; s++) {
-		struct strbuf *buf = *s;
-		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
+	for_each_string_list_item(item, &tr2_cfg_patterns) {
+		int wm = wildmatch(item->string, key, WM_CASEFOLD);
 		if (wm == WM_MATCH) {
 			trace2_def_param_fl(data->file, data->line, key, value,
 					    ctx->kvi);
@@ -130,17 +107,16 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 void tr2_list_env_vars_fl(const char *file, int line)
 {
 	struct key_value_info kvi = KVI_INIT;
-	struct strbuf **s;
+	struct string_list_item *item;
 
 	kvi_from_param(&kvi);
 	if (tr2_load_env_vars() <= 0)
 		return;
 
-	for (s = tr2_cfg_env_vars; *s; s++) {
-		struct strbuf *buf = *s;
-		const char *val = getenv(buf->buf);
+	for_each_string_list_item(item, &tr2_cfg_env_vars) {
+		const char *val = getenv(item->string);
 		if (val && *val)
-			trace2_def_param_fl(file, line, buf->buf, val, &kvi);
+			trace2_def_param_fl(file, line, item->string, val, &kvi);
 	}
 }
 
-- 
2.50.1-633-g69dfdd50af

