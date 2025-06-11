Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC71E487
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649528; cv=none; b=bwzJagEVrus+kL55aIMMx2KvPpmMums1PbGe6naBTSKqVtoh6/aURSxI8pRFbAl6DtculXh2g0aNmxUnFKuXnXxwnQ1jL4IoORPp8sVgycR78py5dALZ1oedoE3Bz/raarhFY/uO5dP8GDPS+ujrsUjGjnRKjPvy7TaxAk6Gqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649528; c=relaxed/simple;
	bh=tWRSiV0QbYWxDnJEoYe/95WImJ/l9HHsatFO0LaD160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt1Givqm5HNBbPYC4qin8DpAQ9L3jjYV6mgQjKkHzZ1BqoIbz2htTBXreA2jB5CwrnV0iFwcjYOLpL2nnTA0ei+fmHTwi4cJ1kTFv0Uc2vlKfFaemzLp59wFaGHLa6DWbPt4C5CWDQfw2VDrDZQT9ibJhAsaPCTWY/52DTp6l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTZ2M5yu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTZ2M5yu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-452f9735424so18326565e9.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649524; x=1750254324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ting6DmMEofdlvSoWEBL3mmNmXUO+bTMAzrT942pXHI=;
        b=NTZ2M5yuHCNwg82YIFg9KWHKy+ctePLUmGT+IDcGTotJt/du9yFCJn4g0ahqbib+YA
         mJxUIWU1xglX68L9e7ySATpMF6vqS6dAYT87NX86zfHdxCb0IXYBtdT4y918mvcYLLv9
         5i3eYN48EhLb3jlpALHh9emXXdw7yXYOwxWgfyJdYzUQJgP29s30xTYdC/iFwPh361FP
         s7aDgKPoeQkTCU+uNBC0q+zHUXIYsWnJKkMeFXrkdaMe3jJ8X28TqQu1nJCLRpKv+vxA
         5XBwtdi+iJqTwuLzXOab5pHkLhJ3zKzXbpBbjeBHGBomZQSEt+gvZtJ93BOkkfHYcRIn
         x0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649524; x=1750254324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ting6DmMEofdlvSoWEBL3mmNmXUO+bTMAzrT942pXHI=;
        b=kX+sEXQQRSV4HitOXDpNlT6J6y2FeCf6x8txfMShN1iQIyB4TcRICgG5VOZrEf/XLp
         rYaAAV0oa/6DrPcTBmeF/UA1/pUZ6sG3naFB7ymhd87Wok3Ej4SmFOYaoNPODpWKMBuU
         lLJ/KXkKVdqanXKx96bzWgmmWQZ/woh/a7seE/60PaAUpTrszpRl3NUrGLJHlWWwZTpl
         t0/pB0dB3gmbRDuj1aE9Yot8JrdXjIEGOLpsmTnkl7mTrhT1Ciiurc/RVZb5uwQeT2Sw
         7AxeHfUKx3t9c5bWL9OLmuzOK1rjSXxopxgta6cV7acLci3ablmnEpngdDbcsTXddvZp
         jXnQ==
X-Gm-Message-State: AOJu0Yz7g4L/kMu2+CKDXwGBEFmj+NLnGQ1NEcN4kb66Ve8j3uh4/G2z
	CqAtHPMgDN9fQAcBO7Pnwx/iBGoAAfXKXL5TtYuSpGVKzi1MkOoHbhEFdUUfeg==
X-Gm-Gg: ASbGncs7PANuN3usV4N5eI88j9c1lC/CMus80Ao8ZaKTIxAexDJjzXFnL/Wt5WaX+Dp
	tNxF83+SE3ic/7UoIHO1VG7F521IPXClbDTBROH0RGCbm9dIkBwkui8pZHo5hJ8A9wIY+HEWT1r
	yMFb/V1hbwQtHfHpgWSxE3DFpf7i9iK9tKkR7zpS71l0OWWq0jgMS4Jt6IHBJoDoazDwoJm+sYx
	WcVWZtPhp4neOEFgetnKGqQZAeB1JFyFqQI4MGCS2TFcvDWPO2sp93e0e7YwbT5yEQ5nCiWwd3q
	yXn1CVEy23ZaVi9hoFnOMlBufcxwdol45VTHtIKEc9ZzVD6n+C4A/fuODTIPpiPH7rs7meZQkQL
	vozOtxP8vrinK6kggTNk7YtnkT5a0nyy3NFMB14HsJxD7
X-Google-Smtp-Source: AGHT+IE4Ry2C3Xl7V9Iv9n9nV+9e7jnr1UqjHtSy92D9mL17u26x2xFLVnewjpIdY6UE/Ux6gmEV0g==
X-Received: by 2002:a05:600c:154c:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-453248b0ee1mr36009695e9.10.1749649523762;
        Wed, 11 Jun 2025 06:45:23 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:23 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/5] promisor-remote: refactor to get rid of 'struct strvec'
Date: Wed, 11 Jun 2025 15:45:02 +0200
Message-ID: <20250611134506.2975856-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.5.ge8efe62b7f
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
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
scale easily in that case.

Let's refactor this and introduce a new 'struct promisor_info'.

It will only store promisor remote information in its members. For now
it has only a 'name' member for the promisor remote name and an 'url'
member for its URL. We will use use a 'struct string_list' to store
the instances of 'struct promisor_info'. For each 'item' in the
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
index 9d058586df..90a063ea53 100644
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
+		BUG("bad config_info (invalid URL) for remote '%s'",
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
2.50.0.rc2.5.ge8efe62b7f

