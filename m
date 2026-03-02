Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAC390993
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487935; cv=none; b=e0NxCBOCncDS+VmTBPFmGfKY1gRUbNORAAGTqyLYwTKW0sV+3u2mn83p1k328ukW0J35OrJ6wXqpH8zkaJPjfLi1sHO1i9c4qOXqDCYYIcoQqYFefFIqjdvSZpnEfHD+5tG87rJrz5fApHcxWaNw5WRO0BJg7alXyeIzNMKZYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487935; c=relaxed/simple;
	bh=VBHzLZ7kfpVrE132Jj1OhcKTl0xRDCy6pexnwS8NiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZrJStM+463CYOQWillSsc51bDlWDwGhfrq6JJfCapxMEIlKD3vtd81Lhg9mS1YaBYk+0OayCvPDCuaoVQCQHMWyDEjwSn47rVBsTroTqv65D/5FfuSQkQKa0XKvwiaUiW+b3RGLrqAFstiycTptlLNdX827EJbYxf24bstQFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtaC1Gll; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtaC1Gll"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-662fc35291eso3158450eaf.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487933; x=1773092733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpvbGaIig9Q04uVNcPHpZDCSJH2tio+MTvkqq+VQ7QM=;
        b=RtaC1GllIatv/mcwfqhR28ijkAENHcx7MxlXJ62oKrJHjekx74JyTr34zYGY70/lb9
         x9yDPJxvUwTd0yV1c6V+axSc4XPe+UDV+8CbZeHzwcfQsJsf9LWav5vvTsa8RBBhza5I
         qJl1x3wWm0EsHcGmhahs4grXkgBBHIKdpvJwASdOcKD2Thg+312gyBP/rn5Q/hVXSvEq
         cu3VriZ8pP1WqwM/LQJTpKtPvxy2p+ILYd9O5UCjECTy7Dk5uxFcUNOOJyzIPvlK31aM
         UI+I2P1vkxWoIrjiMngrfir3xSP8k6KxMgOi5ssR9PA+Sc3NxZFzlg6J50phicF39gi+
         Phow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487933; x=1773092733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hpvbGaIig9Q04uVNcPHpZDCSJH2tio+MTvkqq+VQ7QM=;
        b=IP762hWksrye1vrLgMfmIxNSRtYZtwwgtCu9qYmvwnIvU454YD1vaTt0hIex0r2EsK
         4nyjsjxC5bKbjTAVy5YDM1lo4PF6GuuWjNn9VDCcP9uS9X+jb2E6YuasptTGlwI2xYz2
         nMH5KSLd5f5UV/QszANAHVFLW2s4vNdNuHWiUE1aclBNY0tZr9EAWf9ZJmJwon+5CPxG
         WCsth84gbeTaEf2eLJnLCauS7ofXScRbSXzmIRQ8v9evHoUXnhxE0olrXNc09pVNXDxL
         g/aytJ+8W/coZR60XtJtGE9non16Liumdm308Zy9TwACJBDeqgM6p1khuj7NbzZrI6Yt
         mx9A==
X-Gm-Message-State: AOJu0YwZAAEApqa9Ogrzs4St+GSDrXpYgOlVl/QLq8JChaVgUMBq8t6Z
	PlOqo+3qkMQ4kC+HYphhKWtlAzRa8KQT9XleU7p+qaWiLCfroHw54Etxgfe9HQ==
X-Gm-Gg: ATEYQzwope06LV9NkitruuG8nmyRUvVfAYwqF/NBwN+Khm/2o50UT1HubhXIU1i/tOj
	/lbYZRdfWNQ3dFTd4/sp2aHyElNKd2uLk/lBeueizMGmo5+XlrvCbneR9D/+r4cbg0tidxdde69
	ez+79QcluWTFaqVpqlqqoHmHux8ZrZ2IFGQ53zTfprTlvyFBmEwMTjEDrb1YDztPEQI8TFzBtkQ
	6rdrM96MNIALG2+wRY6iY9JgOCB4rtVC5kHLVT3PnWm9oo461imVN0YJbI1hDOeZG+FrBXXGm8n
	C3yaYiOSjjMBFjpGlZEex84nFvpjORD45wgsaGYbkvJpVRzA5pe1YX0iGCDUcGLBGtmyw2E6oma
	rmbYK0vgPoBO6TcwQOulQ7FAmRMVvUYUAbyUCqoc9dTD6xQftt+GwUk0CMXrYnb3NJvefNgFr48
	FpxQR+LT0GAj1Pbugotdhf69+dqVzBmGI=
X-Received: by 2002:a05:6820:2913:b0:662:c16f:4774 with SMTP id 006d021491bc7-679faf2ca20mr8730400eaf.51.1772487932949;
        Mon, 02 Mar 2026 13:45:32 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:32 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/6] builtin/repo: add helper for printing keyvalue output
Date: Mon,  2 Mar 2026 15:45:22 -0600
Message-ID: <20260302214526.2034279-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The machine-parsable formats for the git-repo(1) "structure" subcommand
print output in keyvalue pairs. Introduce the helper function
`print_keyvalue()` to remove some code duplication and improve
readability.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 77 +++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index c7c9f0f497..782194cf4c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -446,44 +446,51 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static inline void print_keyvalue(const char *key, char key_delim, size_t value,
+				  char value_delim)
+{
+	printf("%s%c%" PRIuMAX "%c", key, key_delim, (uintmax_t)value,
+	       value_delim);
+}
+
 static void structure_keyvalue_print(struct repo_structure *stats,
 				     char key_delim, char value_delim)
 {
-	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.branches, value_delim);
-	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.tags, value_delim);
-	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.remotes, value_delim);
-	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->refs.others, value_delim);
-
-	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
-	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.trees, value_delim);
-	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.blobs, value_delim);
-	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
-
-	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
-	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.trees, value_delim);
-	printf("objects.blobs.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.blobs, value_delim);
-	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
-
-	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
-	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
-	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
-	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
-	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+	print_keyvalue("references.branches.count", key_delim,
+		       stats->refs.branches, value_delim);
+	print_keyvalue("references.tags.count", key_delim,
+		       stats->refs.tags, value_delim);
+	print_keyvalue("references.remotes.count", key_delim,
+		       stats->refs.remotes, value_delim);
+	print_keyvalue("references.others.count", key_delim,
+		       stats->refs.others, value_delim);
+
+	print_keyvalue("objects.commits.count", key_delim,
+		       stats->objects.type_counts.commits, value_delim);
+	print_keyvalue("objects.trees.count", key_delim,
+		       stats->objects.type_counts.trees, value_delim);
+	print_keyvalue("objects.blobs.count", key_delim,
+		       stats->objects.type_counts.blobs, value_delim);
+	print_keyvalue("objects.tags.count", key_delim,
+		       stats->objects.type_counts.tags, value_delim);
+
+	print_keyvalue("objects.commits.inflated_size", key_delim,
+		       stats->objects.inflated_sizes.commits, value_delim);
+	print_keyvalue("objects.trees.inflated_size", key_delim,
+		       stats->objects.inflated_sizes.trees, value_delim);
+	print_keyvalue("objects.blobs.inflated_size", key_delim,
+		       stats->objects.inflated_sizes.blobs, value_delim);
+	print_keyvalue("objects.tags.inflated_size", key_delim,
+		       stats->objects.inflated_sizes.tags, value_delim);
+
+	print_keyvalue("objects.commits.disk_size", key_delim,
+		       stats->objects.disk_sizes.commits, value_delim);
+	print_keyvalue("objects.trees.disk_size", key_delim,
+		       stats->objects.disk_sizes.trees, value_delim);
+	print_keyvalue("objects.blobs.disk_size", key_delim,
+		       stats->objects.disk_sizes.blobs, value_delim);
+	print_keyvalue("objects.tags.disk_size", key_delim,
+		       stats->objects.disk_sizes.tags, value_delim);
 
 	fflush(stdout);
 }
-- 
2.53.0

