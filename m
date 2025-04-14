Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6B27B512
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646657; cv=none; b=QHCiOywBbBxfCe1IoawNR2G/ejwP/6B1DNH3M7rM8Ea71Hp8KN5KA0jNQhw3HhHh9zGpi4t386gQ4Y7ScFlf/YcsVC2/BxM3skcWWhwDO2qP8cHzm29pmQB4/FTJnJyP2kaa0qCABDgy7ZklcczCqLYVbvQEf+kaN3CZj5QPAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646657; c=relaxed/simple;
	bh=pbwm2Q8Xcta2B4AdmnaegU6rhLs9UiHgFsLz5a221NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmfhL3SeAzBpPO7bLiPsLFcIEqqmp+LUZhw6AMvIw2i4Ko2ddD1Ty028MtgCmlBMhGli05T20/tAn1R6zHSUddSfQR3uTTtkjndel34LVt34CmtiWgPOQBj8RXmcBeJLQWlh+TmscfIcT4U4rywl3sdQyIOh8Nwvs5WczPv9DCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqlQQfLV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqlQQfLV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913b539aabso2707253f8f.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744646653; x=1745251453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgajhPRf+bdlOs5P1RR2J7u1G+Sh8ym6z97HpQfX4Eo=;
        b=kqlQQfLVVNBvlAyk4GGahB9nkc+Xdhykte83m32PHQpR8PSzlcybjH2HUmcy2JtJIo
         rPQa+aFmK8Tytkz1LSISUSAA6SBKvUXGgBFYz23qJ0EPcy1sJbI/lr3JdHRHWICF4b8t
         JwE0GvYIt7EGSIHkyMwBhQNe90kKg/V3cwcIDg7gq+ZCALfw/pqZvUEXK+wySb0ycwLb
         flau9OSiN58Xz+jF1un3Ipe2mUcYQZtpoexrDH9pywQaw3KV7dXxw+m7ZAiOCqX1J8S1
         xlpU9Y3/LaaOxI+1/2rzAOlHBGFk9hpx1mhhcgwxCC2KfRh6kY+CVWDV8ADjFv09riaZ
         DYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646653; x=1745251453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgajhPRf+bdlOs5P1RR2J7u1G+Sh8ym6z97HpQfX4Eo=;
        b=nh3zgeDv3bugbdYpXW7ibJL7/c9x5j/ZVcM2H2ojo1Bonu7H/xT6/s2gZNATHXRZRH
         uVbLpdCamuOhUcwk6665wP4XbkD+wok4f8ujwnGaH6hgSdk1hhsO7iW475pUhgEX/xLT
         dhEcSBHSXgdesyoS4kiWtu/r++a0KcfODZZx8TCpD7o1uoY7cgtcQAr2s33cxbfWBjbR
         eUmaNPJnXbfpfucKSMoQU4V0aYm71VuFhUMsZfKdG02ltWTAMN+glcvNANOc3otszYT+
         URti0DQko+zylvXwDAWQ2NdI7Wb69ovOqNjZ503DnNeiLaB/vnPLI5bairBO5Nmbz80T
         ppaQ==
X-Gm-Message-State: AOJu0YwVxkYQk+TR5LpaFKVCNY9jb+WWFBRJahacWD6O4VJuY/g5hhxo
	p1t4qhjUBSH4RUuIiYQpSlQEvM/SNJo/tJv1+mieEHqXsgUs5kpTNUjQuQ==
X-Gm-Gg: ASbGncs7p/untz1QFJG+vpfvtMJpIfnzInomRdDSPq2bSxbyY91i554zEyvYQZvRiT+
	Gt+voRL3x1Fziq44PwTDhDict0ICyDKYQ58IfX+ItdrZFzMHOV+5Rfhi6SLlm2LzKn9ivQhfjST
	GNRmkemPvQ1SVEfGd3Xttibt9vmg/27X3lPqolfL5CDROTIjkA4xFNHz22if2XN+CCF1geDT3T4
	NT0qgMb/yZIC6vpFMSnYmtMw5qSAv1CHGd2Jh/aPdreAM8z2TUEOV9NVlA4VkkCeZ9diZ46Jryt
	CVU/xh2iCeVKYJNuQT+8BOyBIxjULZ5IlOctwygXcJIHW13ZPR60CLLEyuCQjCvGk8MuFMRDN/4
	=
X-Google-Smtp-Source: AGHT+IHjMsPBWrad7kPPEzOBqhzUJhWKZZQ8aVcRcsLd8/VSkIjtJgEC5AEz5b7f0snrculUnmGbZg==
X-Received: by 2002:a5d:64e7:0:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-39ea51d353dmr10527590f8f.1.1744646652296;
        Mon, 14 Apr 2025 09:04:12 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:a9d4:af7b:bb5c:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm11258029f8f.42.2025.04.14.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:04:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] promisor-remote: refactor to get rid of 'struct strvec'
Date: Mon, 14 Apr 2025 18:03:41 +0200
Message-ID: <20250414160343.2216312-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.158.gd3b09c1afe
In-Reply-To: <20250414160343.2216312-1-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
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

Let's refactor this and introduce a new 'struct promisor_info' linked
list that contains a 'struct string_list fields'. This string_list
stores the field names, like "name" and "url", in the 'string' member
of its items, and the field values in the 'util' member of its items.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 124 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 37 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5801ebfd9b..0fb07f25af 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,10 +314,38 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
-static void promisor_info_vecs(struct repository *repo,
-			       struct strvec *names,
-			       struct strvec *urls)
+/*
+ * Linked list for promisor remotes.
+ *
+ * 'fields' should not be sorted, as we will rely on the order we put
+ * things into it. So, for example, 'string_list_append()' should be
+ * used instead of 'string_list_insert()'.
+ */
+struct promisor_info {
+	struct promisor_info *next;
+	struct string_list fields;
+};
+
+static void free_info_list(struct promisor_info *p)
+{
+	struct promisor_info *next;
+
+	for (; p; p = next) {
+		next = p->next;
+		string_list_clear(&p->fields, 0);
+		free(p);
+	}
+}
+
+/*
+ * Prepare a 'struct promisor_info' linked list of promisor
+ * remotes. For each promisor remote, some of its fields, starting
+ * with "name" and "url", are put in the 'fields' string_list.
+ */
+static struct promisor_info *promisor_info_list(struct repository *repo)
 {
+	struct promisor_info *infos = NULL;
+	struct promisor_info **last_info = &infos;
 	struct promisor_remote *r;
 
 	promisor_remote_init(repo);
@@ -328,57 +356,75 @@ static void promisor_info_vecs(struct repository *repo,
 
 		/* Only add remotes with a non empty URL */
 		if (!git_config_get_string_tmp(url_key, &url) && *url) {
-			strvec_push(names, r->name);
-			strvec_push(urls, url);
+			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
+
+			string_list_init_dup(&new_info->fields);
+
+			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
+			string_list_append(&new_info->fields, "url")->util = (char *)url;
+
+			*last_info = new_info;
+			last_info = &new_info->next;
 		}
 
 		free(url_key);
 	}
+
+	return infos;
 }
 
 char *promisor_remote_info(struct repository *repo)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int advertise_promisors = 0;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct promisor_info *info_list;
+	struct promisor_info *r, *p;
 
 	git_config_get_bool("promisor.advertise", &advertise_promisors);
 
 	if (!advertise_promisors)
 		return NULL;
 
-	promisor_info_vecs(repo, &names, &urls);
+	info_list = promisor_info_list(repo);
 
-	if (!names.nr)
+	if (!info_list)
 		return NULL;
 
-	for (size_t i = 0; i < names.nr; i++) {
-		if (i)
+	for (p = NULL, r = info_list; r; p = r, r = r->next) {
+		struct string_list_item *item;
+		int first = 1;
+
+		if (r != info_list)
 			strbuf_addch(&sb, ';');
-		strbuf_addstr(&sb, "name=");
-		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
-		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
+
+		for_each_string_list_item(item, &r->fields) {
+			if (first)
+				first = 0;
+			else
+				strbuf_addch(&sb, ',');
+			strbuf_addf(&sb, "%s=", item->string);
+			strbuf_addstr_urlencode(&sb, (char *)item->util, allow_unsanitized);
+		}
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	free_info_list(p);
 
 	return strbuf_detach(&sb, NULL);
 }
 
 /*
- * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case sensitively to the strings in 'nicks'. If not found
- * 'nicks->nr' is returned.
+ * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
+ * is compared case sensitively to the strings in 'p'. If not found
+ * NULL is returned.
  */
-static size_t remote_nick_find(struct strvec *nicks, const char *nick)
+static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)
 {
-	for (size_t i = 0; i < nicks->nr; i++)
-		if (!strcmp(nicks->v[i], nick))
-			return i;
-	return nicks->nr;
+	for (; p; p = p->next) {
+		assert(!strcmp(p->fields.items[0].string, "name"));
+		if (!strcmp(p->fields.items[0].util, nick))
+			return p;
+	}
+	return NULL;
 }
 
 enum accept_promisor {
@@ -390,16 +436,17 @@ enum accept_promisor {
 
 static int should_accept_remote(enum accept_promisor accept,
 				const char *remote_name, const char *remote_url,
-				struct strvec *names, struct strvec *urls)
+				struct promisor_info *info_list)
 {
-	size_t i;
+	struct promisor_info *p;
+	const char *local_url;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	i = remote_nick_find(names, remote_name);
+	p = remote_nick_find(info_list, remote_name);
 
-	if (i >= names->nr)
+	if (!p)
 		/* We don't know about that remote */
 		return 0;
 
@@ -414,11 +461,16 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	if (!strcmp(urls->v[i], remote_url))
+	if (strcmp(p->fields.items[1].string, "url"))
+		BUG("Bad info_list for remote '%s'", remote_name);
+
+	local_url = p->fields.items[1].util;
+
+	if (!strcmp(local_url, remote_url))
 		return 1;
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, urls->v[i], remote_url);
+		remote_name, local_url, remote_url);
 
 	return 0;
 }
@@ -430,8 +482,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct promisor_info *info_list = NULL;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -451,7 +502,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL)
-		promisor_info_vecs(repo, &names, &urls);
+		info_list = promisor_info_list(repo);
 
 	/* Parse remote info received */
 
@@ -482,7 +533,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, info_list))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -490,8 +541,7 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	free_info_list(info_list);
 	strbuf_list_free(remotes);
 }
 
-- 
2.49.0.158.g6ac6832dc3.dirty

