Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9633C196B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044631; cv=none; b=LXwWskDoK/0F4ut5nZn+iAMxkWr1I4Mt7RDNdjCmMhj7iU/pM9MlO3psdaH2f4gyHYZa92rMe8p/UHwlOd9/5yU8j2lilJYjI1Wv4uAN+0nTyxqjwve9WIAEFN7otTSJMIxeciWznZGh3A1Tt+tHBDvVIJRDx+w5oIAXWNG+bNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044631; c=relaxed/simple;
	bh=JRVW++US6Zqa6qS7E480fBbbdvRhAD4ap6/QRhLJNPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL1wOW8ZasZ+5gbXclK7HprURKicXOHpnR85E7UNcRjMq62oLCZVbk7f2ohPTXHrJNszPumPaxIbCrcmpsmODs/6vXqotqEwXWLJWYTxyrkMgJLX92p5dxRj79FX3bkhebNAJC1PeVgF0/MM2wFxEDokFziLZ7jbCn3I3EkrxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEGl5yoO; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEGl5yoO"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso11701241.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044629; x=1772649429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3fU83k38rJclLv/J8c2PISsbnW4QUY0fEjvDzB0Q6U=;
        b=iEGl5yoOGU3I3uLaqDg9jhG+035VienldKbcsA6uyorzq9o7wUoJho0cTrlC6pgBMe
         G8983CYBlO5n/xAGDLxBVpr0VV+0yh2EbrsZM7lOJpFB09mZqgwPG4V5+1XuhPWo8vol
         Ypxdz3h99kkpx6FXYBCM7s6P5V2s7b7g7kjTWkvgxEFO+zvFZmfsSsqhoseFs/y3S4Y2
         8UqrHI9Aatc5vILmU+VUVJF9K+t0CTOUctHq66B8Yaw0jxHsEzmhFghjvBseJybH520n
         y9OWqLgm9DIKcMMUgW6mstC8TvIUKbvs6GQuSLQPG6SgZ/sj3Yli4r1XqIG2e591qpBw
         KJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044629; x=1772649429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3fU83k38rJclLv/J8c2PISsbnW4QUY0fEjvDzB0Q6U=;
        b=YDmMN/Xjv9/CsAajkk9Gw9Ns/xQa/AHh1LeHf+E8Yc053ot3B2BZWCNeHMji1v8fJh
         5glPBFJh2L4OfmTgAER7rkqHlDx73C6fxRbyxERwFrskjPVLHsAtswJ1VpQJYmbkswZo
         FXAp5cybOLENckCjjodqevazGFHz1dxdWmY9Smff5NVn+Z2XzkpsDYjH2JbEvZcOnmuQ
         EycOa5sbXeh4FfJ4HNf9EdFE1exZEWuT7Z3ENMWsXfZzOdtwUcLmfZqUJ9ZYZDOOPKyM
         It0Qpnvqf3qDf/S9cmtNrcLPc0P4yrLfK69Fj5SWRR89+QctvFy5FBobXTj8AVuUj5Zx
         6H2Q==
X-Gm-Message-State: AOJu0YxWjejH2ndT+Jl8JMiLV3R6GThFrkxK1mFml+XtZbfuPPLeHP89
	qgQzGFK/FUo/dsqiDYUO0j/Hf7DvnJPu7aebTVjabv4X3r1pivS9dwy2fAknvQ==
X-Gm-Gg: ATEYQzy7lv64hBv4nZPR1HZYf4dK0ftcjFl+5a72dVfiDLOJzqD+hvwsiUR+ef8DqZB
	NkFma+ow19jJgobneFvsu9foBMxetUmuH/a4IvypgR8f3Amza0cmOrgYqqf3MBUCE8UPGy0LJpb
	QfHNG3dUeZmVA23pfJD8GgijIxBNJJiaSxCyDMPqvgRyhJ7ous7NIF/ED3Wz/J0amRgIollu3QO
	w4CNNJ9moPLDo3TfGCB9trCjaGQ3zrUN4L0GDRf8iy6GsYapcb2ZOsgqMD0ertu7gezRNNXmnNy
	HoyaAU0Kupc3FrmvWwoGvqoxdgIFRCFSaqk2/ZI5eBz78w//z/g0TMyN6HXDP0R1oXKFDN4PdF2
	LMi5ZkgfIAQqtggX4QUzyly/PDmh8xNvL1t3y1firXWm1Dr+LpvdQXbMSvQGBso36058EcVhp90
	6UR52gSlMiDtrjmj2XYuOE8ZHuwwo0M5cYKjs2nTaWPxt7N9Huv3MCFXgPt0M3pF/4IJwJSqw=
X-Received: by 2002:a05:6102:38d0:b0:5f5:3bc4:725f with SMTP id ada2fe7eead31-5ff1415db8cmr743260137.37.1772044628760;
        Wed, 25 Feb 2026 10:37:08 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:08 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 4/8] repo: rename struct field to repo_info_field
Date: Wed, 25 Feb 2026 13:32:13 -0300
Message-ID: <20260225183559.79303-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the name of the struct field to repo_info_field, making it
explicit that it is an internal data type of git-repo-info.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index c60a41ba7b..f943be7451 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -31,7 +31,7 @@ enum output_format {
 	FORMAT_NUL_TERMINATED,
 };
 
-struct field {
+struct repo_info_field {
 	const char *key;
 	get_value_fn *get_value;
 };
@@ -63,7 +63,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 }
 
 /* repo_info_field keys must be in lexicographical order */
-static const struct field repo_info_field[] = {
+static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
@@ -72,19 +72,20 @@ static const struct field repo_info_field[] = {
 
 static int repo_info_field_cmp(const void *va, const void *vb)
 {
-	const struct field *a = va;
-	const struct field *b = vb;
+	const struct repo_info_field *a = va;
+	const struct repo_info_field *b = vb;
 
 	return strcmp(a->key, b->key);
 }
 
-static const struct field *get_repo_info_field(const char *key)
+static const struct repo_info_field *get_repo_info_field(const char *key)
 {
-	const struct field search_key = { key, NULL };
-	const struct field *found = bsearch(&search_key, repo_info_field,
-					    ARRAY_SIZE(repo_info_field),
-					    sizeof(*found),
-					    repo_info_field_cmp);
+	const struct repo_info_field search_key = { key, NULL };
+	const struct repo_info_field *found = bsearch(&search_key,
+						      repo_info_field,
+						      ARRAY_SIZE(repo_info_field),
+						      sizeof(*found),
+						      repo_info_field_cmp);
 
 	return found;
 }
@@ -115,7 +116,7 @@ static int print_fields(int argc, const char **argv,
 
 	for (int i = 0; i < argc; i++) {
 		const char *key = argv[i];
-		const struct field *field = get_repo_info_field(key);
+		const struct repo_info_field *field = get_repo_info_field(key);
 
 		if (!field) {
 			ret = error(_("key '%s' not found"), key);
@@ -137,7 +138,7 @@ static int print_all_fields(struct repository *repo,
 	struct strbuf valbuf = STRBUF_INIT;
 
 	for (size_t i = 0; i < ARRAY_SIZE(repo_info_field); i++) {
-		const struct field *field = &repo_info_field[i];
+		const struct repo_info_field *field = &repo_info_field[i];
 
 		strbuf_reset(&valbuf);
 		field->get_value(repo, &valbuf);
@@ -164,7 +165,7 @@ static int print_keys(enum output_format format)
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(repo_info_field); i++) {
-		const struct field *field = &repo_info_field[i];
+		const struct repo_info_field *field = &repo_info_field[i];
 		printf("%s%c", field->key, sep);
 	}
 
-- 
2.50.1 (Apple Git-155)

