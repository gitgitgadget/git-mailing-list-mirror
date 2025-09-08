Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D71C7005
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309480; cv=none; b=BXPzYBqVQ5fUVCjw48naae/nNJ901yQu00di/wIL6+93ojUd/vAXncnItnRfr+S0EyOvNiE7J0wMnVHabQCwlSD6hwS7UULG0Vr78vv+bSxved6EVT8ZO3LceGG9mlriQyYbEWzKssYM5FoiZfvMX5HUIrmmm1iy1ulplBBPzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309480; c=relaxed/simple;
	bh=y+vHCeiSK5VGPy7NSVvILLl/0z2WZHQq07k3RVYgs6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV+oAehd10kefiwzdfKbGj6WCYvKz/DGWhcLN7ZGupMFTvcAxy/KwBFq+yYbhMkmntLSD2pOYGnEsW+8G8KhMa8CbujkLOsO4y6l+NPSHTnTbLGjQ5GNL7yHNSMN0VKCOn4LTG7b/VPMp3xJaRNS6Ro65bSHMCXmLECTBLmnEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmWAWuIb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmWAWuIb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2564696f8f.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309476; x=1757914276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnSii3VjgYSDWnmMTMKH7YGNaxHtM93pDz/JIcniLps=;
        b=QmWAWuIbU/m2rqY5oOGV5I+hGmzt2NPlh0eEDRs/L11Lxwh6nvZldCWq+vPMz9sUkf
         K6F5W/L6bWAtURhnrkcXa0fD8ALdEcG4+I/FwH4gbLDy0Brm5oS7CuCqZs9AlbRo2FWR
         MtaMlbgKu726zHxRC5FxBZjZ9XyIPEjnE0dOUxqsXNbIgv74764qUZcRUimRTV4agFnV
         4r90YnfzehG1DEPBQXADhvhNCcz/SUw9UqCIgLSosr2li+g0Kk9uUHfeGZBNoqcPHsBK
         O6JL+w0euqCqktXk502G95n2foS6FC41eOUYSKMPvJ3RMoF/dlVxNrbkvFSD86nWetCr
         4Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309476; x=1757914276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnSii3VjgYSDWnmMTMKH7YGNaxHtM93pDz/JIcniLps=;
        b=EoC9Jyde/tXVfNiCrL8NRgF1zw0yqRiaL/UEguDjn3IN4NTxuoe9hkewyEccQxJG2S
         YDNVeuocAytsUe/dtGnQa+1HmxCjFeR+6CioiXIIpW4E04O34zrYgcScI6zAU4APHw7l
         noNIlwU9qVHGEPBC4ygOMsQxns7hLbAqeWMLkf4gXA0TN+4/qu/yYXXXlL29Dmvb+GHn
         oLXqz175PNVM0OG4grmO4My7cA1KkeW2bpu4DpyIx2lOmz7mAvaifZPhy5QlWctcuUuw
         LrxkPZGkuescNfjn/eY2Fx3g6orAlmlhRcDcBpMtmND/wEZpP2I9r1xJd4fb+IHKou2G
         JUew==
X-Gm-Message-State: AOJu0Yx6F6FvZrSX2otU9QikgpFZlYWesIs2KNUmUCrEIC5mN7Xbrju9
	DS1BrjoHwheO9GyetVyQaoOwaMpn0hGkscjSqLxl8Sr0OGB8O9n3uoWAcNLXdA==
X-Gm-Gg: ASbGncvvCFHsxhIotw5yugRGzHRNJsPvQMh/H96HxrFOFGiDa0UDIyvyxSqs92B+Rhz
	T/tAcz2cU3q0vwa0wcTha4MAJuBAY33kQxOKganfrpiqVGNEm0X9AUGI2N3z9RIpJALglM34ikd
	YnNyJQe38upsasolDTxu6/hGPigx0oRSY9rjaAY7jXy3V63XS71uzNW1NatyUrCduT/mwd0Nc8o
	76Kn9siy6Ed/KXWmQubtZDdTuSFl/Xl45sdPFG/sk/28mT+4uFS1TkQ/vJFd2BC3whV1IEVGcJR
	vxxucnTwS1FiI64EKt5ESqUXNm3QVt6I2/kBR16RkAWFdydz4rATxSYFclbe8OzOdcBYDPHI1zj
	Z6KeNkLUxXiypgEkfyizJmDViyX/jWzcTSkFAvJE/acQH8kzR0zvgvcfXPgf60lkJr8em0hlD0e
	IwJ1s+
X-Google-Smtp-Source: AGHT+IFjpGj8qbCFVNVJ/ey9rGBog42qnhbzrz99tjnkJvgrL6zM215Wyq+3SnxsuHaSBynzE7WMeA==
X-Received: by 2002:a5d:5f82:0:b0:3e7:458e:f74 with SMTP id ffacd0b85a97d-3e7458e129bmr2358125f8f.24.1757309475823;
        Sun, 07 Sep 2025 22:31:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:15 -0700 (PDT)
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
Subject: [PATCH v8 1/7] promisor-remote: refactor to get rid of 'struct strvec'
Date: Mon,  8 Sep 2025 07:30:47 +0200
Message-ID: <20250908053056.956907-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250908053056.956907-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
 <20250908053056.956907-1-christian.couder@gmail.com>
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
index 08b0da8962..c3df8f071e 100644
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
 		if (!repo_config_get_string_tmp(the_repository, url_key, &url) && *url) {
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
 
 	repo_config_get_bool(the_repository, "promisor.advertise", &advertise_promisors);
 
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
 
 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
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
2.51.0.168.gc8716bf361

