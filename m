Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77D1C7005
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309484; cv=none; b=NREyO8/4YzwQK8NXUzQKXNUKa4LDGbjknowFSG7SMu1eDWYCq5+W+0Is4fg8VwGbCka4uFSN5tZ0eNg0Rwe1wYFjtNEKsQy7yZEfkoA3LbbOMaSoK7GFv4EHMr00RChXnwN1erSjV89/ivBSRBdBqbFdH3RdUQtF5eYX0dtnTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309484; c=relaxed/simple;
	bh=2mUUPoYJ8LLuIPKQfMkBv+R4pRxu1veNQAFklCbb7jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjjKTKgiRMrpUj8wN4KIoph8D7IGqPVIFPz7xAqOjn6/ISzip8crEonla8O7PyciQzxCoHhu6dsu+TmGTPXlzsYDV+5rwnjZq//UVClgnhXVEVFuTw4MFP/l+LNuWKbJ6x1Jd5W4yi+qgNQO4hC21swgoOFTSH/PGQ1nRlWmNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy5CE1Nh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy5CE1Nh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso33010675e9.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309480; x=1757914280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dITgs3My5T8pDrIpIbKG6925edH243lcU9f+DvMv35A=;
        b=Dy5CE1NhoNw/QXBMK4p9ORaS/UmmjXPNcX7zYdZK5rOqIlwUO/fKTtNXCjiLMAkDqT
         qgg1OVY5bZeBE2yO9731H4nx9ad8G0+Wf/I030H/C8AdspGK1YDGocY5cBwExUlci4Vv
         +mLQft1E2BHvWGWUVwnzsuIfMN67bg19CDFPYstZjKz4RtLmLsnvNvgM6Pbe0GNaAaFN
         kCSkXGTlCb6uKZikgiI3wR7w+YmJ8PWNIkzSBofqqnsuTuNYx28WAFf5UKGcTWNlEjWz
         +34SFOQ+/gsCuFzX9tnNrsuqqXOwiOSFlCVIRUpKLeV5rSSYE2vOtWgHAwvhVCisjHKu
         Srpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309480; x=1757914280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dITgs3My5T8pDrIpIbKG6925edH243lcU9f+DvMv35A=;
        b=KIQ/7zyLcIcZDHg16qsexxR9GGXoDgvwkwTfGEimZD1uL04ZWXh19GRD1TmWG5KEy0
         3RgCQVUHt1NF529aF1vEhCmUGEKK69LnrKnkr3lsLzYIrjA37VgF/BTvyRzAfWGobXr7
         Ydor6XF/twxjc0HzJmZqqpwuNDk2IDq1Oakn9ybbgaZin71qkfQ9XQoJVeqGPfIWesUu
         CGwU6rYSwDGEQOxHpYyu1Jz1cQmr1Iv+GjR9JUDNFPalJNaFVUnP1ctqyDJK33bpYB5I
         yt5T80UYW6Uqwy2p648NbR6coTovx6pBnoshz5jUZ/z9ctHA9Oqz7pCur4brj9xkx4of
         ecOA==
X-Gm-Message-State: AOJu0YyzPs3uPz0JrQTO8s2cJFZIiYZVk9Xgu0Wd/nAOmHMvgcba+Xpj
	kpOKKYsARfScc9D5IBHrEw+0btStBMQh0SvD4l2ETiUQMiGkCjuRvaFJypzTmg==
X-Gm-Gg: ASbGncto3C78d9JTVjyUgnv4izlC1FLfiWtiB5e7Sy6aJ+YeDovkklqN6PpoLCwzyeG
	5wpVt1kA0d8W5DZJGxcwdeIANjfbp3xFBFs/6ZPWF7sLWYqErfEWQdF6uWjUzEAJfeOT7SRdLUZ
	P07y/8e7PHcl06/axtXobTxXB7DubiuWdrV4V/B4+RAri44iPQhIFnBGIGQ578+TSU6Zh/D/63C
	FHSLqlgd8x0uzbJiNyPEpHUqK1F/RIp/Cq6Wqa+XRQwhvXL+40ioPJEUWwEA4c1jZ0XdiVd0TYe
	f9HOsVW5QdB1lw3j4A33pmAQ8AKDAppEzmClVQ15a6RN2SmPFAZRMjxuOqFDfFk049bWC2pfLhw
	mNjrIONnrL5UnYU8iScOBm2fyNzb73jUdpCeRiN1COAy0clzmPZT/ii8qu+pbxbrbHZy4uj5Up/
	z69JBG
X-Google-Smtp-Source: AGHT+IEoHf6rh29ZAzEcDNHkr26RdcsD1yW8O8QdDSs/1oZ6BG+YMdChcA+XGhHchBUUWJWFZK4QPw==
X-Received: by 2002:a05:6000:26c1:b0:3c2:502:d944 with SMTP id ffacd0b85a97d-3e61ce3dee1mr5208592f8f.0.1757309479726;
        Sun, 07 Sep 2025 22:31:19 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:18 -0700 (PDT)
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
Subject: [PATCH v8 4/7] promisor-remote: refactor how we parse advertised fields
Date: Mon,  8 Sep 2025 07:30:50 +0200
Message-ID: <20250908053056.956907-5-christian.couder@gmail.com>
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
 promisor-remote.c | 86 +++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 3913e32c11..c22128d09e 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -405,16 +405,20 @@ struct promisor_info {
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
@@ -531,11 +535,13 @@ enum accept_promisor {
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
@@ -578,6 +584,41 @@ static int skip_field_name_prefix(const char *elem, const char *field_name, cons
 	return 1;
 }
 
+static struct promisor_info *parse_one_advertised_remote(const char *remote_info)
+{
+	struct promisor_info *info = xcalloc(1, sizeof(*info));
+	struct string_list elem_list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&elem_list, remote_info, ",", -1);
+
+	for_each_string_list_item(item, &elem_list) {
+		const char *elem = item->string;
+		const char *p = strchr(elem, '=');
+
+		if (!p) {
+			warning(_("invalid element '%s' from remote info"), elem);
+			continue;
+		}
+
+		if (skip_field_name_prefix(elem, promisor_field_name, &p))
+			info->name = url_percent_decode(p);
+		else if (skip_field_name_prefix(elem, promisor_field_url, &p))
+			info->url = url_percent_decode(p);
+	}
+
+	string_list_clear(&elem_list, 0);
+
+	if (!info->name || !info->url) {
+		warning(_("server advertised a promisor remote without a name or URL: %s"),
+			remote_info);
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
@@ -614,32 +655,19 @@ static void filter_promisor_remote(struct repository *repo,
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
-			if (!skip_field_name_prefix(elems[j]->buf, promisor_field_name, &remote_name))
-				skip_field_name_prefix(elems[j]->buf, promisor_field_url, &remote_url);
-		}
+		advertised = parse_one_advertised_remote(remotes[i]->buf);
 
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
2.51.0.168.gc8716bf361

