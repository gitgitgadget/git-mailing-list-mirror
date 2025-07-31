Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF827E1D0
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002493; cv=none; b=j3gAc7fu5QrETtO+N8K5Qo0MuVzHPyaHqpg9ZLzqlt4IoufyVkGDYFoe7wX/4vpLH5Koxa0RRCQYx2lmUAtR3T3zX56nMWMAtQ88vNbva1iJbdj/IaYoNy0uXwSut+hwDOydmQikGsGVyaL7r4JS5KmepA0eJI0o5Nanot6EBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002493; c=relaxed/simple;
	bh=xv/Mdn2ELrQckteqLxm980IJkNtsHotCL8xW4HBQUTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd00f9r2g0cZ1g0SYbOBKiuCR7jw8o6sdTRITyDnykGWyA2/93Bmtq8yaTyE24TDzqFCYUxpt2d5rCRNtenwaVz+kexK+nfCAK9Jg/G7cYTv9PFzw+dDnr2hCwgMHBJ66DptX958CEI6+DhkRcUNaEUjlItJN0he4gd6dfT97cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5an33h+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j2o4iFSV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5an33h+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j2o4iFSV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB812140030F;
	Thu, 31 Jul 2025 18:54:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 18:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002490; x=
	1754088890; bh=t7FyoMPaW96EYWwr0SZCoxCBxGSpPTKI1XnrVg+Wjmk=; b=L
	5an33h+VKpBdmRSkJr6gPv29J6Vr/WPwJmeAnBpAym94Ndp1Lmy3t+rc+LLeXvur
	oiuYtAHo8nHdcjZGhgAAfo6I9ABAKVcENQb46BdvFaGMMsQxjV/FBmUm3X6YN+M4
	3P9VYbsBgg3wqOaNqFdWlbPUoLLAnrBb+4781Uys/CCzfZearL7CAxNMfS4eIKGe
	dKfmIToRkeY5rnyW/Jm8N0R44d5WzDekJO5ifK3ZPHp1x5sQd7GvWLhvQejzHwiz
	gpRN9RbItlHlvVY2qMwVPWmxLaudChvyBHruoJV2xOLsiJIn5vtOwh88brFOjzLv
	2FxLjHlC32IK2ZhyJ3ihg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002490; x=1754088890; bh=t7FyoMPaW96EYWwr0SZCoxCBxGSp
	PTKI1XnrVg+Wjmk=; b=j2o4iFSVynEia72LPq+xxvz9jqEDhbXMEwFtUiv6K/cG
	j8M8LVnyo7zshS2Ye9oNhCHUUzubbAxlNIAomvor+n20v+nSh8tFoiv/CSDo7sg1
	YnlFNbHur2hhZ2Q/3o5esU7H3HbMebDSIBRa+qoAxWBPO+r4EBwSPoBio875RhLN
	ZbBZttE069VJyInO+B8TLuyClDQ4GUHk/V7DADUCCBFx/6H9nQg5S1bQfFLzmYBU
	nDOeT81v1OBGfiEX4MWIVnjrueviKIbRPf3vk8sPECsgqMgSkdECuQRJu6w70LAO
	psQEsTlPayH5+rkAmv/r3i/acD7wV2AbVlZWNVxphA==
X-ME-Sender: <xms:OvSLaEGRbc1lFAMGhYKwn4y_ZT88oA_97iXsjBZ7isFavJAQJj8NAA>
    <xme:OvSLaNg0XGLEIGD6scRsHQHwKLOhIgJVfi5VfRHPt-G8MW9NSUdnemobSrjgIVUhE
    tRxvc0tLdOdwqOXPw>
X-ME-Received: <xmr:OvSLaP_YtucKoGK4WnCi2gO-0IpKjwWlLmpKsGbWlyb49FHhcQc_vcPxgzdvN2MCy_D4Tfa81JQ9sj7nASsSBGEFEq3NiOANaC4WcLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OvSLaEr8qQYcDByQmKexVIX6m3WrEl24BGVmceZzbHeJSHacODNMhA>
    <xmx:OvSLaO_S2uzWQb3B_TdnxiislDg5SZtKbkKguf5hrykMRwRNino1BQ>
    <xmx:OvSLaIU8lwQsOMv8xZTYSppWWqsWumxGW1wThIr42OqdzAFB8EM1Ug>
    <xmx:OvSLaEA6MqeaLruF11brTkKES6SJRaC_ZfkYzHgqU0GHWOq0uLOKiQ>
    <xmx:OvSLaGpBbeTM73J_ZM6VlaNeMWn2oLwBqaN_hCFc18uHiEuf7OcENxz0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 11/11] trace2: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:33 -0700
Message-ID: <20250731225433.4028872-12-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
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
2.50.1-618-g45d530d26b

