Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785922D8DCA
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107077; cv=none; b=LAZ4S6Q68PoC7GTCtTlDg67IJFwBSQCFMu3zoJYej0/vdWTLxawKzTTFvAADFFXuFz7IapMg0r7THsjqvqC9ZugBqzmPXap9rKeJ6S/s+6Ex4hrUk5cMzkoaIfXbvw5K+kO5ODcEZJEmSKVYY4R+z+coa1U+232nzvcamWKwvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107077; c=relaxed/simple;
	bh=/TZsPcYPyPV2AsE5VPvUexsTZ7LwyoSL3kTzKf4HRAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+yl/nZjoOM/59izoH1SgsHZy8SWq2IXe8+I9t63LnxWPNcUIwPq2ZHhM8AeHKjNrhUQUIWVDWAUkddcvEriP4pkc0b2lELuYHxFQ9ZDp39OXvHqz++JHQSZzOGFDYWhXHKUpWDuXDq6zTmp7T+v0mbiVWeCmEmWJ4tN9P2AfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI3eRWsw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI3eRWsw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so30599065e9.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107073; x=1753711873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ynT6VD2KZk3dFrb4oXqgfAAAzjAskvgs9L8ntFLMsg=;
        b=QI3eRWswS6PTP8UTv0PbQoGll8ZuRwy09RV85lm8V8ySJ0HlngczhIjY545ZZutqiu
         nZqHObYlLKz2K1dcs4zrUxyNmr7Agwbt6Rj7xeWKvmo4caGzzeJdkcc6BTYmWd1V3y7d
         Sm3Ux9E6LuS1/6wuA8igJhFaQ65/nldeK7e/TvOz4D1X6QK8+aH2+n8U77IKh3YK10Oy
         kbTH3jiWS1C8XaA8dO+9tbmFm77g1FgECt3eiRHO0EnYG+LS49sDiQue0UogOmqK/Fgz
         ah7AYE7NR9+eCdBdih8qyryLsoScew+xgHF/VJ44RRSSr49vpxJoSe/3RM9RTRaR7QWC
         rQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107073; x=1753711873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ynT6VD2KZk3dFrb4oXqgfAAAzjAskvgs9L8ntFLMsg=;
        b=UbGptqdCIWtGsfLJAkocdZB9s2mbLfBw19HUiD/9ZeXNR9/kgBYZQedTVfdn9e2mUE
         Z+IZbSbX2pEWuOwjWxQiEXDyEIsG0GR+4n3mWSWMQVMaXm9w/lSFA8Ju4DA1H2cJREvg
         M2BqngVzXzUJklbbl7Grs8HAPxsLzWfP8HU95Z1hGoTaKBWDtoZ+47sT0qZDazUWYWaD
         IIk5FMBIHeT6KKBZQheZ+pgqNJPwy0A22arwHPpfVH3Z/TArvpOItEMBrVjp+pnvox6e
         hMBCpbKGSZoTq/wQeWrF8ly5nuQfJahEJOl63c3w49ZSuWtqgC6o+gNmbbdSo0+D15gr
         SXWQ==
X-Gm-Message-State: AOJu0YxjRceVI1gst+WuMlXZo5G3U3/IoMi9Z7Uo7Db983u3kNucGksk
	AJOW2PxIZNyepAv26Bo8PSrKWNi99prJl+D5fuOAmMXjYuoa3GUfITXNPCUxwQ==
X-Gm-Gg: ASbGncsXa7RDh1Ki4U1CDECKezqPtMPl6UrWMIKolbSxaVwQlWK0wJKOttcuP9k8i9T
	ciTz53KNEJYtUll7MNOi+UT/tUfC87ckwBzPnBZyEy0G/Im0aiJmubVXWRDOYHzv/ljUvJFCecX
	rg7SblM/3q17OC+ZpdQ4Bi62BkuWhoQtfjWBS8NqwYQy7tYuY0XMWA/4HjPFHlC58R2iD/mOUgk
	CTgl32/nhx/vQm8aIQVX+JgjN6sZQ6xZsl+lRqwhtaoi1FBpfnmIxSmfKG0fz66Q9puxv++KwaU
	aNpDHEp+Y0G9UTuMXbX6xgLIZZJr7lZRlgfe3Hw77ETU4Al2ZZpvBKndwkDN2srt7wlzGN13c38
	kr2bBcXFqUcDi59i2yzsLo2SN0LhoFrli5BLOdQzXupTvO/fnsJJ8XFfo17ThhVMwpL1HlVIhI6
	55sMe+
X-Google-Smtp-Source: AGHT+IF/IAjpQSTGNMNW3BwRzohVc/mrLODnRXGEdnKgm01qHJJ/+jR577n6BHhd5ylz+nYidmsFZQ==
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b60dd641d0mr19505574f8f.12.1753107072542;
        Mon, 21 Jul 2025 07:11:12 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm160885585e9.1.2025.07.21.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:11:11 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/5] promisor-remote: refactor to get rid of 'struct strvec'
Date: Mon, 21 Jul 2025 16:10:19 +0200
Message-ID: <20250721141056.2283349-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.324.gc7d7c83534
In-Reply-To: <20250721141056.2283349-1-christian.couder@gmail.com>
References: <20250625125055.1375596-1-christian.couder@gmail.com>
 <20250721141056.2283349-1-christian.couder@gmail.com>
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
 promisor-remote.c | 107 ++++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index be6f82d12f..0213b8768f 100644
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
 
@@ -414,11 +439,11 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	if (!strcmp(urls->v[i], remote_url))
+	if (!strcmp(p->url, remote_url))
 		return 1;
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, urls->v[i], remote_url);
+		remote_name, p->url, remote_url);
 
 	return 0;
 }
@@ -430,8 +455,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -450,8 +474,10 @@ static void filter_promisor_remote(struct repository *repo,
 	if (accept == ACCEPT_NONE)
 		return;
 
-	if (accept != ACCEPT_ALL)
-		promisor_info_vecs(repo, &names, &urls);
+	if (accept != ACCEPT_ALL) {
+		promisor_config_info_list(repo, &config_info);
+		string_list_sort(&config_info);
+	}
 
 	/* Parse remote info received */
 
@@ -482,7 +508,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -490,8 +516,7 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_clear(&config_info);
 	strbuf_list_free(remotes);
 }
 
-- 
2.50.1.324.gc7d7c83534

