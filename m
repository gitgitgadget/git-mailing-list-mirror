Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC2326D4B
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449610; cv=none; b=KrTAqHkfa9ybwG/jALIdtSQQwY+Li80qrk+3wMFoLgdbBeQS0yMz5Wy3XJ3qER5Vpfu0rWOHDXg4Rkne3lUZIsIaDPaCISr8Xc3C8Uxx6TwCIs1H4eCSPifRk8+2qMJZCEQ0YgK9iQ5/WMUzrJiis/S7bfnuColEl/sYX7U/5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449610; c=relaxed/simple;
	bh=JRVW++US6Zqa6qS7E480fBbbdvRhAD4ap6/QRhLJNPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr/Jm9EwiRb1jnNo7JQEKkNB7tu2O5H+UF42v8DPEdNUGvyAj87InHaSWmOUCrPAkbnBYp5ZhwY5PFxVEwf8SOzuWsrfNSzt59dJZE/9ebhU3zu4SZoUghp5hCbGLsKujYXRLejHWIzcnPWmoq1Pjt5DuF4uVjEYkvsZvxOTSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXSrKQ7q; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXSrKQ7q"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948a378b9deso89229241.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449608; x=1772054408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3fU83k38rJclLv/J8c2PISsbnW4QUY0fEjvDzB0Q6U=;
        b=QXSrKQ7qqHSQCmQ2j4f0FXRazhd+VgacW4PESBv+EesKMVXVey+3RgV253fG3R/gPN
         hXxEfBPdlXChiCnTzxcOh73gYGANIANgK/yF5PTA7dTrgzdEKbZmIVcGhoT1BpSlU5V5
         zeTQk5qK9WmxgSlcU0Vt+TGygxaHAm7tcWw3Hn7X8TpOe0wIvuQ/OuAbYEL/xFSa+CL3
         qSzYTRjKpIkEaxC5Vw5ENdxo6SbBqVFqB62tMTntn4aFlwnW+K8Gv8X5AdqKRQbvatIA
         7HzVOL9kd/LVpPPYleoO2VX0HdpR11lHCUZFkK6ihxtiawTYTMdDpSmS2TNAgjtvW1V6
         5mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449608; x=1772054408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3fU83k38rJclLv/J8c2PISsbnW4QUY0fEjvDzB0Q6U=;
        b=KRfkHC0ZXMKa6wN0FD9aO8fE6FQ1th0TjStMMj+MWezDzw27FL7AfIyyV+KTr3yfKq
         P1iqOcVWzT7sW37J9rsPsCXrcxi+d4JhlaNiz3myBDrE26WRmJVezazn7wIaNEaQk3wj
         TMaY/7/NMFXnrr2kmbyLzHaVzREibcWzUJuwMHioUgBb+dIrYUsn7Y4z0mQo0HCu+WnS
         /AryN+5ufPjqUeskoQn36njNscTg4ha9voURC8npROMGgAHC5CEvStyPSvzG8porJqpc
         2le3emj/2CaWn0KR4B5TJfxWUfexNjdgKm4numOAyPAhimjCKdrZ69+i+6cO2EjC1Ap8
         S69w==
X-Gm-Message-State: AOJu0YyXCTKVJNg3cZGYXBHH+Q7Y7rnmvENNVdMTJpoH3T+l02mZtcRU
	pQDzh7jtf+itRRlJle89oc/TahSGT7l5qYr4v5kGQe661/7EETx1zSMMZgOxrQ==
X-Gm-Gg: AZuq6aInQeVReYu8nxofCjioxo6zR/TmHFSww4qT3DwTadzGIledFBO1HSDh5KPdBPI
	/c0smScyM1uV+cZxHhkIz+cefNjhhBzabsCy+Pv7/SR614VlhCf9tsownziLioC0zpOO0AxHFwx
	sdmSgEEAqs7riAy7jUAro8kfp7rqeVM9KetjtGW2rng4WD4PxsjhnKCDBpQ7yDiyHglOiknBQph
	VTrPbsCZ81gNNhF38dW5ijQ6Xqz6AmXZk3wZVYk/wzga6adCihdc2zGSA0MKiDu1RidTm9zFiiT
	kYAIcv35xyerdAG4BZp/gaozOOdPp+uxt7IPk1Uj1g7YtKrPO6btPOhyPv+U7Q+ybSLOch8UleC
	C3RDJiecjCh5aFDpsfEcs+zTtkdr/IVsDz94HBv7sp6F2mDPKAmng/schNUeP865QNEGAKoDz5w
	A+ceb44upgn7rx8RQePV79QtdY4NXErugAKQwDM6QJiJaYWPe40GR4dwzBfD4dyZOLPg==
X-Received: by 2002:a05:6102:2ac1:b0:5f8:e2d0:4b24 with SMTP id ada2fe7eead31-5fe2acf4679mr5115319137.3.1771449608050;
        Wed, 18 Feb 2026 13:20:08 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:07 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 4/8] repo: rename struct field to repo_info_field
Date: Wed, 18 Feb 2026 18:08:40 -0300
Message-ID: <20260218211845.96009-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
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

