Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D255261399
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855881; cv=none; b=LUZw1jvJad1djbVDTTxc+HoDzlST137ZVSqlGIO5h7sV3iKFFnW0u9K8gasgJpB5QTyRGm5z6hvPzsnI4rEa9OhQ4uZwdgA+PKUzwibzQscZcRAiPxiFT8nuDRJUFoHv3hMFv5mPjKtlgDjFlWCCyh6eLcQO6SuXb6jr8RiPyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855881; c=relaxed/simple;
	bh=mcQPeTqLeyoWuzTHzjQguLHrj/nR+pvl4qpT566ikxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR+SAl190U+uTb1llBJ/qjzPixOtlXP5e3Fhg2/H8uBH5OnzhPP4A+0hzQZECfpdPDqklbs+Y+Cf5EJyugxJy3cv4921IChVEHcyrGJ28Nf9zo678V9kvkoBhp5bzp9KW1apXiScMsLTRJd8Mlz3Z3Z3ciICdiNf9Qc7E0PeXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwB7wAkO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwB7wAkO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1019465f8f.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855877; x=1751460677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQjYS2GGyP4OvWfRog2j8Evjlpafyr6OPb1kfKsSfxc=;
        b=JwB7wAkO6RbXADSmIzzydLQZlFwAILJtrXYfZ/GXk1YPLyuLkO2l+PMIFScs4qFuzm
         Qtp3OiKIWdFVQP/DQE4R4soETJCefRcpoYr2M8NrxDabPTOYgnHGDZbxWO3BIVK8OV+y
         lDfApBEaZ1i5RVUV7tOwXvBYRW6MggTq63Q860SXRijmkfXdcEKAJOpuJiGTzkzCYE5a
         au1LkxwfU+m1vHKTPL2zb5dYzxdUlSyOaU93NHsE8i9MWxYiEBzdxKf9sSWK85zLb3e3
         Ht3fKDc7FgkJ0K+D+JNJOxnKQZ+TcmRXGmZF6O/rqBys7NU554PK1aR2WZ5ZEEP1oTik
         XFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855877; x=1751460677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQjYS2GGyP4OvWfRog2j8Evjlpafyr6OPb1kfKsSfxc=;
        b=usejHHLI4CFLL5DkScIFFdbjIOzwZE8FtXfnqLYvNibhfd0GE7d8Kqx3t9blSjhadj
         MtVtNecryqtXlL3q2g2NAqZ+pA9iHvZkcBkkYge4IkzQ1dWpN0QKgyentzarRLf7iA+b
         yAm0T6/ZzJD8cBM5QyxKRl6M1o2yKA2QDwVp+pqL2H5eiRr3rRdU9VjiHyU+w4m1XygA
         1ldrNyKTlwKMwQMnjGTROuV5tEPf9Vcr3sArPlyR4dKLBqhNuHUKGHOAw567FErNoQqF
         MlSUf32vA+Fv75vd8zWfJyXuNO/ySS5obi9Nd8raIVOmjU7selLjwEAwQyoi+NOH0S4Z
         965g==
X-Gm-Message-State: AOJu0YzhKngJ3TR6U0Qx7XIlSmiupXH8Ck3gds4Vjo8nYaReWtg7niS/
	avtV57RJhQYYoSNffnxuTD5xlCfLG/EK0h3rk6sGdDa+1cRmG/wV1jO41fpYjg==
X-Gm-Gg: ASbGncsUBunIRvKY3s/5iveBHFJiv1DKhnpamp9N4jAa4F2UvxdCJ4TGYZLy0zzkwJT
	BQB6wDXEGTIkaJ5iCk7QGqYZJUASAKvfcAGjgq9wFOeafcTBR4Opu9Jbbei9MviKTaU0KHnxF/s
	2PYdpi6m0K7v1q3C26l+eob2HcsclRTZl3Iq/lFt2O8Bxi9npwN4z7G5CpHyPsaEy6I4PsVHPq5
	YErI5MihNaATX4mqbrUWMnqjqtj6TCTQypPewlnkiObbWrQZym6bGETqhFKYWYhfYDdZV8uxG97
	76JSqpKiI18BHXFBaJOsvVsguzkTmAvbU+UkNLf3MmF4xC5yVLwUPyp3WAtxjd9lEUxIFuoJigh
	OAWvD//ypm4roY7xNcRV3qnV5eyI1KxDPIAjJNuXHA/v9
X-Google-Smtp-Source: AGHT+IHD4Xt/9s3cp1Vtb4XCzpHEbhu9Vt4jYhnjYb782Y1XQSribPp0qNivfqm3c6PGAV3ttAVAMA==
X-Received: by 2002:a05:6000:4203:b0:3a5:2d42:aa23 with SMTP id ffacd0b85a97d-3a6ed62e85emr2034112f8f.22.1750855876438;
        Wed, 25 Jun 2025 05:51:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349548sm19446905e9.10.2025.06.25.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:51:15 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/5] promisor-remote: refactor how we parse advertised fields
Date: Wed, 25 Jun 2025 14:50:53 +0200
Message-ID: <20250625125055.1375596-4-christian.couder@gmail.com>
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

In a follow up commit we are going to parse more fields, like a filter
and a token, coming from the server when it advertises promisor remotes
using the "promisor-remote" capability.

To prepare for this, let's refactor the code that parses the advertised
fields coming from the server into a new parse_one_advertised_remote()
function that will populate a `struct promisor_info` with the content
of the fields it parsed.

While at it, let's also pass this `struct promisor_info` to the
should_accept_remote() function, instead of passing it the parsed name
and url.

These changes will make it simpler to both parse more fields and access
the content of these parsed fields in follow up commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 91 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index ddb9514de0..b68772d573 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -404,16 +404,20 @@ struct promisor_info {
 	const char *token;
 };
 
+static void promisor_info_free(struct promisor_info *p)
+{
+	free((char *)p->name);
+	free((char *)p->url);
+	free((char *)p->filter);
+	free((char *)p->token);
+	free(p);
+}
+
 static void promisor_info_list_clear(struct string_list *list)
 {
-	for (size_t i = 0; i < list->nr; i++) {
-		struct promisor_info *p = list->items[i].util;
-		free((char *)p->name);
-		free((char *)p->url);
-		free((char *)p->filter);
-		free((char *)p->token);
-	}
-	string_list_clear(list, 1);
+	for (size_t i = 0; i < list->nr; i++)
+		promisor_info_free(list->items[i].util);
+	string_list_clear(list, 0);
 }
 
 static void set_one_field(struct promisor_info *p,
@@ -530,11 +534,13 @@ enum accept_promisor {
 };
 
 static int should_accept_remote(enum accept_promisor accept,
-				const char *remote_name, const char *remote_url,
+				struct promisor_info *advertised,
 				struct string_list *config_info)
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
+	const char *remote_name = advertised->name;
+	const char *remote_url = advertised->url;
 
 	if (accept == ACCEPT_ALL)
 		return 1;
@@ -572,6 +578,46 @@ static int should_accept_remote(enum accept_promisor accept,
 	return 0;
 }
 
+static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
+{
+	struct promisor_info *info = xcalloc(1, sizeof(*info));
+	struct strbuf **elems = strbuf_split(remote_info, ',');
+
+	for (size_t i = 0; elems[i]; i++) {
+		char *elem = elems[i]->buf;
+		char *value;
+		char *p = strchr(elem, '=');
+
+		strbuf_strip_suffix(elems[i], ",");
+
+		if (!p) {
+			warning(_("invalid element '%s' from remote info"), elem);
+			continue;
+		}
+
+		*p = '\0';
+		value = url_percent_decode(p + 1);
+
+		if (!strcmp(elem, "name"))
+			info->name = value;
+		else if (!strcmp(elem, "url"))
+			info->url = value;
+		else
+			free(value);
+	}
+
+	strbuf_list_free(elems);
+
+	if (!info->name || !info->url) {
+		warning(_("server advertised a promisor remote without a name or URL: %s"),
+			remote_info->buf);
+		promisor_info_free(info);
+		return NULL;
+	}
+
+	return info;
+}
+
 static void filter_promisor_remote(struct repository *repo,
 				   struct strvec *accepted,
 				   const char *info)
@@ -608,32 +654,19 @@ static void filter_promisor_remote(struct repository *repo,
 	remotes = strbuf_split_str(info, ';', 0);
 
 	for (size_t i = 0; remotes[i]; i++) {
-		struct strbuf **elems;
-		const char *remote_name = NULL;
-		const char *remote_url = NULL;
-		char *decoded_name = NULL;
-		char *decoded_url = NULL;
+		struct promisor_info *advertised;
 
 		strbuf_strip_suffix(remotes[i], ";");
-		elems = strbuf_split(remotes[i], ',');
 
-		for (size_t j = 0; elems[j]; j++) {
-			strbuf_strip_suffix(elems[j], ",");
-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
-				skip_prefix(elems[j]->buf, "url=", &remote_url);
-		}
+		advertised = parse_one_advertised_remote(remotes[i]);
 
-		if (remote_name)
-			decoded_name = url_percent_decode(remote_name);
-		if (remote_url)
-			decoded_url = url_percent_decode(remote_url);
+		if (!advertised)
+			continue;
 
-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
-			strvec_push(accepted, decoded_name);
+		if (should_accept_remote(accept, advertised, &config_info))
+			strvec_push(accepted, advertised->name);
 
-		strbuf_list_free(elems);
-		free(decoded_name);
-		free(decoded_url);
+		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
-- 
2.50.0.2.g875523421d

