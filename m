Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23728150E
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664002; cv=none; b=FyLQCPwEXZPAGc6Ffl5ZpU6CEjFW/9Nv0fczWOEuUQ7U/De1CSaf6/rR2qp+nW2ww4eAVQRREmURpX5pHlo8N1vh6T9fzP9VYDZ4ozenxm42CD9n/npiMNeb3no64j3mSVc8cMq7B5+TWpnSXhHACvIVeegyz9CFD6bzRmMOma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664002; c=relaxed/simple;
	bh=CM7WADT+sAdTFNJHINdM5A7KuAGLMdTaweI9lQskHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKvQy7WdvRd2Fk77BcZfMvY6+7eWh+8HIBzi3wPSARdIMqDjmIyIdT7nWyVvhyrgy/K2fZWzobtxMvmwJyWSYOt0w7wxwFa5lnO5YgpUvRBrsQK7U45XG22suCn5ueNQYY5PU5GPrJAkYplEvIN9FK5XPffGCfHLgkkeThr6DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ikvhf9m4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikvhf9m4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso32991725e9.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663998; x=1748268798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oot/nzX4iwi/jFsg1f8flnoWwWQtLPHtaDGXv0uyn7E=;
        b=Ikvhf9m4kOSHbtAyG7JRtXm10KL8hq0HTxtoc7Ci1h1QOnxPEXQj/HOnJQEsfCvFZF
         C+8ex9sPEJnU4zeAd4+pT7xjjsdIgGA/+RZKU5ExhUkdKIoC0TQNZWUqRPe67mOqUKUt
         ujhe9dxFDuHfAuBgQMIFOV2C/KyTlsUX+BUY1h81a9E4y0/X+pIDRj+xkH5NbsteczEX
         Hvj65bqQJlW8u4SyMClb2QvQXqH1hg2eIsMWwCqg7RLbAPAEfuv15JSF8j7xYll3DDHB
         5AwPa9XZernugemTxLQqcmMOqENbwT6Jj64Vzy3ux0wq5Zz9ppkEV79ggIomGtsad+9I
         5M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663998; x=1748268798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oot/nzX4iwi/jFsg1f8flnoWwWQtLPHtaDGXv0uyn7E=;
        b=h5l1O4dez9o+CbpcTM3aQ79+R+Cbu3ge9cAfPDC8X5jOparSqgqzapETflPfZtyJUc
         fYVa0Zk5yUyUGw770yssFxwwlGiuahfb76GoocMhkiDQ29GmY8xDQp2pEBAWatti4pgR
         aLlHRqggkIlFIU/VqbPsVGd3t1dqb4cdag8twUPaUfw4ZgXr1XFabOJaMFDMpbDzCSLN
         WUgHs1JM4zuGD5KpuALfqC/jC5vfT9oqSsFMrm0RSbuY6GgKnTmkylib0WP/VjRjMtEL
         ys2DAO/Gfqf7glnOA/sCI7jvtrH3QXpyqzZMFW1XZ9jL0yYviMouDA2O01KKS+8PPGJr
         zYrA==
X-Gm-Message-State: AOJu0Yzvw/uGEEeQyatJt0UJyIO1WxMMVIYcMevf9BY13Fw55BebqTMB
	Nd72bJvUNMBtwSIV+rrnoRA3w2aeKTlIprF/706xiF9QNgCFicjLOqA4CiK4gJYQ
X-Gm-Gg: ASbGncuIdT3V/UMz2aNOzd3oXgIHiE2JGkelYWIbDj9U23/H606956XUFSsqAY2gPMQ
	wF+Rg4wZIvuotQsT01O/iikivxLcsS4HDSkUPYZtTceluItVm0I4FQpWVWtsKibQAKvFZMohANZ
	nXWCxHnmXQUqyUEcRJzYoxL5i2VrL2KGcz/yKhRTbrNrsXuDCRYRIP1iD3Ya5en2Nl4k7lxEhyC
	0amHvtIBZsG/S3ERNWGJanSeSFv4s96ccSGiTZu2HH0NoxsXuOvs+mXAT5xpot2aiLRfm3XrgvA
	FAd3tmtKtSGdKdEsjVzI7vQPfHM3283HMxX/mToPDlEhXDbAhMCbrCsp13BpoFZk/EBf5z9czHN
	wwVstezaS4Lagbrh+oluxgf6OsAESiMiDSVpE
X-Google-Smtp-Source: AGHT+IEMvumcFRaAQ/lhxXigZLnrXvBgh7sYS0unWVMdpbjWVEOWdk9QaCZuKZP/mNYe6xtNbXmWZg==
X-Received: by 2002:a05:600c:3554:b0:442:e0f9:394d with SMTP id 5b1f17b1804b1-442fd672031mr119632465e9.24.1747663998024;
        Mon, 19 May 2025 07:13:18 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm160372405e9.13.2025.05.19.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:13:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct strvec'
Date: Mon, 19 May 2025 16:12:55 +0200
Message-ID: <20250519141259.3061550-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.596.g707f6eb7a2.dirty
In-Reply-To: <20250519141259.3061550-1-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
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
list which for now only contains a 'next' pointer, a 'name' member for
the promisor remote name and an 'url' member for its URL.

Explicit members are used within 'struct promisor_info' for type
safety and clarity regarding the specific information being handled,
rather than a generic key-value store. We want to specify and document
each field and its content, so adding new members to the struct as
more fields are supported is fine.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 107 +++++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9d058586df..94e87f2f48 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,10 +314,37 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
-static void promisor_info_vecs(struct repository *repo,
-			       struct strvec *names,
-			       struct strvec *urls)
+/*
+ * Linked list for promisor remotes involved in the "promisor-remote"
+ * protocol capability.
+ *
+ * Except for "next" and "name", each <member> in this struct and its
+ * <value> should correspond to a "remote.<name>.<member>" config
+ * variable set to <value> where "<name>" is a promisor remote name.
+ */
+struct promisor_info {
+	struct promisor_info *next;
+	const char *name;
+	const char *url;
+};
+
+static void promisor_info_list_free(struct promisor_info *p)
+{
+	struct promisor_info *next;
+
+	for (; p; p = next) {
+		next = p->next;
+		free((char *)p->name);
+		free((char *)p->url);
+		free(p);
+	}
+}
+
+/* Prepare a 'struct promisor_info' linked list with config information. */
+static struct promisor_info *promisor_config_info_list(struct repository *repo)
 {
+	struct promisor_info *infos = NULL;
+	struct promisor_info **last_info = &infos;
 	struct promisor_remote *r;
 
 	promisor_remote_init(repo);
@@ -328,57 +355,65 @@ static void promisor_info_vecs(struct repository *repo,
 
 		/* Only add remotes with a non empty URL */
 		if (!git_config_get_string_tmp(url_key, &url) && *url) {
-			strvec_push(names, r->name);
-			strvec_push(urls, url);
+			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
+
+			new_info->name = xstrdup(r->name);
+			new_info->url = xstrdup(url);
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
+	struct promisor_info *config_info;
+	struct promisor_info *p;
 
 	git_config_get_bool("promisor.advertise", &advertise_promisors);
 
 	if (!advertise_promisors)
 		return NULL;
 
-	promisor_info_vecs(repo, &names, &urls);
+	config_info = promisor_config_info_list(repo);
 
-	if (!names.nr)
+	if (!config_info)
 		return NULL;
 
-	for (size_t i = 0; i < names.nr; i++) {
-		if (i)
+	for (p = config_info; p; p = p->next) {
+		if (p != config_info)
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
+	promisor_info_list_free(config_info);
 
 	return strbuf_detach(&sb, NULL);
 }
 
 /*
- * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case sensitively to the strings in 'nicks'. If not found
- * 'nicks->nr' is returned.
+ * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
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
+		if (!strcmp(p->name, nick))
+			return p;
+	}
+	return NULL;
 }
 
 enum accept_promisor {
@@ -390,16 +425,16 @@ enum accept_promisor {
 
 static int should_accept_remote(enum accept_promisor accept,
 				const char *remote_name, const char *remote_url,
-				struct strvec *names, struct strvec *urls)
+				struct promisor_info *config_info)
 {
-	size_t i;
+	struct promisor_info *p;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
 
-	i = remote_nick_find(names, remote_name);
+	p = remote_nick_find(config_info, remote_name);
 
-	if (i >= names->nr)
+	if (!p)
 		/* We don't know about that remote */
 		return 0;
 
@@ -414,11 +449,15 @@ static int should_accept_remote(enum accept_promisor accept,
 		return 0;
 	}
 
-	if (!strcmp(urls->v[i], remote_url))
+	if (!p->url)
+		BUG("Bad config_info (invalid URL) for remote '%s'.\n",
+		    remote_name);
+
+	if (!strcmp(p->url, remote_url))
 		return 1;
 
 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, urls->v[i], remote_url);
+		remote_name, p->url, remote_url);
 
 	return 0;
 }
@@ -430,8 +469,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strbuf **remotes;
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct strvec names = STRVEC_INIT;
-	struct strvec urls = STRVEC_INIT;
+	struct promisor_info *config_info = NULL;
 
 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
@@ -451,7 +489,7 @@ static void filter_promisor_remote(struct repository *repo,
 		return;
 
 	if (accept != ACCEPT_ALL)
-		promisor_info_vecs(repo, &names, &urls);
+		config_info = promisor_config_info_list(repo);
 
 	/* Parse remote info received */
 
@@ -482,7 +520,7 @@ static void filter_promisor_remote(struct repository *repo,
 		if (remote_url)
 			decoded_url = url_percent_decode(remote_url);
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, config_info))
 			strvec_push(accepted, decoded_name);
 
 		strbuf_list_free(elems);
@@ -490,8 +528,7 @@ static void filter_promisor_remote(struct repository *repo,
 		free(decoded_url);
 	}
 
-	strvec_clear(&names);
-	strvec_clear(&urls);
+	promisor_info_list_free(config_info);
 	strbuf_list_free(remotes);
 }
 
-- 
2.49.0.596.g707f6eb7a2.dirty

