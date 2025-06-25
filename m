Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5A25B30D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855878; cv=none; b=j9OGn8bxTiE+iDlzCiW2ypGckNFlIR68k5ajleGEq78eDcK+AayPeovtfDKaCZjP0BGbj8/2Ms1pEkc9RAxAN+5XuZYygqZYkn+gNxqqik/6KdzUkqxh+usfcXaYOBJwdSrpV0++yVBvu39mWXf2LQS6hWI39cMu9yYlw0xbd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855878; c=relaxed/simple;
	bh=Wp+qvTEfaIBu3o/xuwJXMFN/j0xDIejI2X//EVZsCfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvgrd4PnAxzgbVRXaR3vqcMKvSW2rn2ob3+ZtydcywdG+4FZt+3+5og20XQUbYZLjXMsHb7mJ3P4uQ2BuyMInBFJmCJ/gYAsmkoTVVxQuU44h3bQEJMRb57Jlvc8y2AWBIFTHiqOUz+MclQPMTYOKaoCuq25zYuY56361GY/gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c48nUWKI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c48nUWKI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so5950845e9.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855875; x=1751460675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWX0nuXaJsVhuH/Tfxp59XCQ3jEA/uMWvnbt1UWzXQ0=;
        b=c48nUWKIkH6Ib+NywIXzsdB2y7/RuF4eOC9I/TxgmEk9MIjF2bTtHkq6S80yOSWMJc
         RGbOGftGOR5HdsSAmPg1rm/ZBjbeyMXVLlDK+vbco7JrPZCmIrRpTXmunQ8yvZvzNoyy
         ErrIyb7tLTjfaivBkH+J7QdcSk+BFggHnhkK/P3dUUv3vTGTWyYuW0/42WZdRWJrET31
         E1cn2/6Dqsu/cU0ppwFf2IIZNClSO3e7p5LKH6usWWxkM9Udjg4/aFMGKGGBjQLD9xsG
         0epHUrLzrhVjJOeKFajQePrInzQSBgebE87UGIlEuY1m1D7FPfYX27rXXhpGv7CYgV+h
         8F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855875; x=1751460675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWX0nuXaJsVhuH/Tfxp59XCQ3jEA/uMWvnbt1UWzXQ0=;
        b=hI4KmspPW9iR1eNoss2A+5/qcNA/sZqm4lrWJprpKqunjuTK60mr+gsZoTDRyUiXPU
         zt58sAv3mCVUhpZOvSDbni/MciqbdJcapv2NXzN/s+eF4i8LlKQ/TiJWXOuAkjv4FOdZ
         w4O6mZVaa1P1MQMk7OYjB8lYGZCdMDD+cqLVgqiKgFAXp4bbmhRNklW5szQewg86whLy
         SCrUYw05qbLcY+ZlzXxX3osi7gqqJETKKTuqZBwF6huNOoxnOSI4PJHVUAzAoDxNXD+A
         gmMpPSm0deGRhVvwFu86qZeYoLn6xk34XKBOrdZqZTsmjr5l/9TRLpQkwoVAhDmbHW43
         fYAw==
X-Gm-Message-State: AOJu0YzOeTPxk5teAo0fLM43tjXY+TucFcRZ5HCdxjFky3CtSOjtkIoD
	5eCRHg87brv1GHutuuVUwYO2S0LUOw57pn6tdJrlGEwROTmCfidpLgnhPMZe/Q==
X-Gm-Gg: ASbGncu9CwF14vKzpc1Aukx5d5QeEd1iHfzWLaaRd5hDRl8DZ70ECPBDd/j5QX5HAI3
	v0jvsV8TRfLv6dbucq0bLlBzBRzkkmrFOMv21RlRKMdVZoNu1BeADLuDjZPQVi3s9lEPAd0neot
	82+llr/8b26+eXTnuSoc6YW1uLRbmwfHKOrxnehbfSVV7Cu+l6HOvhMd02yYb2P0fRI/wjDEEtw
	V4Mqvh8/FWost+EbfnNhnVyRWNT/HDZWPaFClLcL2LQSlw/yMaiSW+8CZeZ4ICpcGT75T5DaItV
	vuxK2OePtUN8Mwpc490oy0ZByN5VlAca8nXbK9f6CyynPoT+PeBCNMTm7h28D26k2iOtPGpGZ2n
	SfcDwZZFtmeBwLajN2FKF1eIkklBzot5iBVMpy8HLhvC3
X-Google-Smtp-Source: AGHT+IFaNZLXgMlN3lKmytFjAgd0tqr0N1pNBNct/Q7f5HmDhR1tbdJakrAff6WqHU0qe7lHk0mIJw==
X-Received: by 2002:a05:600c:5306:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-45381b767bdmr29729045e9.3.1750855874186;
        Wed, 25 Jun 2025 05:51:14 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349548sm19446905e9.10.2025.06.25.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:51:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/5] promisor-remote: refactor to get rid of 'struct strvec'
Date: Wed, 25 Jun 2025 14:50:51 +0200
Message-ID: <20250625125055.1375596-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.86.g149b275
In-Reply-To: <20250625125055.1375596-1-christian.couder@gmail.com>
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will use the new 'promisor-remote' protocol
capability introduced by d460267613 (Add 'promisor-remote' capability
to protocol v2, 2025-02-18) to pass and process more information
about promisor remotes than just their name and url.

For that purpose, we will need to store information about other
fields, especially information that might or might not be available
for different promisor remotes. Unfortunately using 'struct strvec',
as we currently do, to store information about the promisor remotes
with one 'struct strvec' for each field like "name" or "url" does not
scale easily in that case. We would need one 'struct strvec' for each
new field, and then we would have to pass all these 'struct strvec'
around.

Let's refactor this and introduce a new 'struct promisor_info'.

It will only store promisor remote information in its members. For now
it has only a 'name' member for the promisor remote name and an 'url'
member for its URL. We will use a 'struct string_list' to store the
instances of 'struct promisor_info'. For each 'item' in the
string_list, 'item->string' will point to the promisor remote name and
'item->util' will point to the corresponding 'struct promisor_info'
instance.

Explicit members are used within 'struct promisor_info' for type
safety and clarity regarding the specific information being handled,
rather than a generic key-value store. We want to specify and document
each field and its content, so adding new members to the struct as
more fields are supported is fine.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 111 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9d058586df..1cc614701b 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,9 +314,35 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
-static void promisor_info_vecs(struct repository *repo,
-			       struct strvec *names,
-			       struct strvec *urls)
+/*
+ * Struct for promisor remotes involved in the "promisor-remote"
+ * protocol capability.
+ *
+ * Except for "name", each <member> in this struct and its <value>
+ * should correspond (either on the client side or on the server side)
+ * to a "remote.<name>.<member>" config variable set to <value> where
+ * "<name>" is a promisor remote name.
+ */
+struct promisor_info {
+	const char *name;
+	const char *url;
+};
+
+static void promisor_info_list_clear(struct string_list *list)
+{
+	for (size_t i = 0; i < list->nr; i++) {
+		struct promisor_info *p = list->items[i].util;
+		free((char *)p->name);
+		free((char *)p->url);
+	}
+	string_list_clear(list, 1);
+}
+
+/*
+ * Populate 'list' with promisor remote information from the config.
+ * The 'util' pointer of each list item will hold a 'struct promisor_info'.
+ */
+static void promisor_config_info_list(struct repository *repo, struct string_list *list)
 {
 	struct promisor_remote *r;
 
@@ -328,8 +354,14 @@ static void promisor_info_vecs(struct repository *repo,
 
 		/* Only add remotes with a non empty URL */
 		if (!git_config_get_string_tmp(url_key, &url) && *url) {
-			strvec_push(names, r->name);
-			strvec_push(urls, url);
+			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
+			struct string_list_item *item;
+
+			new_info->name = xstrdup(r->name);
+			new_info->url = xstrdup(url);
+
+			item = string_list_append(list, new_info->name);
+			item->util = new_info;
 		}
 
 		free(url_key);
@@ -340,47 +372,36 @@ char *promisor_remote_info(struct repository *repo)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int advertise_promisors = 0;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 
 	git_config_get_bool("promisor.advertise", &advertise_promisors);
 
 	if (!advertise_promisors)
 		return NULL;
 
-	promisor_info_vecs(repo, &names, &urls);
+	promisor_config_info_list(repo, &config_info);
 
-	if (!names.nr)
+	if (!config_info.nr)
 		return NULL;
 
-	for (size_t i = 0; i < names.nr; i++) {
-		if (i)
+	for_each_string_list_item(item, &config_info) {
+		struct promisor_info *p = item->util;
+
+		if (item != config_info.items)
 			strbuf_addch(&sb, ';');
+
 		strbuf_addstr(&sb, "name=");
-		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
+		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
 		strbuf_addstr(&sb, ",url=");
-		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
+		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_clear(&config_info);
 
 	return strbuf_detach(&sb, NULL);
 }
 
-/*
- * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case sensitively to the strings in 'nicks'. If not found
- * 'nicks->nr' is returned.
- */
-static size_t remote_nick_find(struct strvec *nicks, const char *nick)
-{
-	for (size_t i = 0; i < nicks->nr; i++)
-		if (!strcmp(nicks->v[i], nick))
-			return i;
-	return nicks->nr;
-}
-
 enum accept_promisor {
 	ACCEPT_NONE = 0,
 	ACCEPT_KNOWN_URL,
@@ -390,19 +411,23 @@ enum accept_promisor {
 
 static int should_accept_remote(enum accept_promisor accept,
 				const char *remote_name, const char *remote_url,
-				struct strvec *names, struct strvec *urls)
+				struct string_list *config_info)
 {
-	size_t i;
+	struct promisor_info *p;
+	struct string_list_item *item;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	i = remote_nick_find(names, remote_name);
+	/* Get config info for that promisor remote */
+	item = string_list_lookup(config_info, remote_name);
 
-	if (i >= names->nr)
+	if (!item)
 		/* We don't know about that remote */
 		return 0;
 
+	p = item->util;
+
 	if (accept == ACCEPT_KNOWN_NAME)
 		return 1;
 
@@ -414,11 +439,15 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	if (!strcmp(urls->v[i], remote_url))
+	if (!p->url)
+		BUG("bad config_info (URL is NULL) for remote '%s'",
+		    remote_name);
+
+	if (!strcmp(p->url, remote_url))
 		return 1;
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, urls->v[i], remote_url);
+		remote_name, p->url, remote_url);
 
 	return 0;
 }
@@ -430,8 +459,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -450,8 +478,10 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL)
-		promisor_info_vecs(repo, &names, &urls);
+	if (accept != ACCEPT_ALL) {
+		promisor_config_info_list(repo, &config_info);
+		string_list_sort(&config_info);
+	}
 
 	/* Parse remote info received */
 
@@ -482,7 +512,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -490,8 +520,7 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_clear(&config_info);
 	strbuf_list_free(remotes);
 }
 
-- 
2.50.0.2.g875523421d

