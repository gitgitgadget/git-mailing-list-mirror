Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC183750A9
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257108; cv=none; b=KEuVZYkzWxFeroSBL9ukrez509oqrDdtjaURaf26GZtXzbL0KLFXCid5IR9U3VqQOegBHHOGMsVK3UfhG+w9nDT0k2StQqsHCcsA8gDEOQEZVCRbiFVYbpa3lzQFwZCqulYe5N4Jqu+dh27KmXS8rB3mv9eAv5SMrUbOTJWpWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257108; c=relaxed/simple;
	bh=qzC16Dqz+p33EVzeOG+WZP22VNa/mYLWOhs0staSwbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZswQo3gAm+ZNaWRWT6OT9cNYXD1hDOP/xFNISGp9oTz9gutt1USKTjtAeWJpNr97QrguEKedm+a0sUgLIvXmkYtlaSVtR1jPIkhCm77StZB09ux93Fd4t9+l2LSsZPJWPaJx0WOwCQpYMLcj3DlmR3teEpy0UnIMFAFTor0sFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibf2TAjC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibf2TAjC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aea41d4fbcso1495615ad.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257106; x=1773861906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeIgDHSxkfhVyzU/EaYv6diYb8ba2P8aqcstwvDCK+4=;
        b=ibf2TAjCefW5zMNpN1vT50CHCLljTvsouaAmXEsWZIhGRoGR73eGRpRNmj0Gjo6x7v
         0vO1qvvVv51oObyio/QJFKJMJyx57JFR9U6FOCBF5RBwWfxh8L+iTl1+p1An4HfM1kgZ
         3YOP39adAz3OtkANCL6OEmD0XIZrzZ7a0BYN4zXKxYwTyzenkJWMgZkvnqPipgtPShE9
         shHYWpLNYJyaS0gpcpvQunk7uKQ/8ghuTzo660om2W82rzoQvxuPpaYBv9vM0NzEhq+g
         8sAssUMKFd5CA8BoHgqTQmX5SHZIcIOaSSFAZck/MmqTtJL/w2XwdrZ/vFuRwHb1DxFv
         ig8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257106; x=1773861906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeIgDHSxkfhVyzU/EaYv6diYb8ba2P8aqcstwvDCK+4=;
        b=ppzEZCm6I7t1AJQDug6zZ4jBTzH6dXrM7WAhZJrv09twYJXZ7HBMB6mEWovy/5I7Et
         k6phlufpyxzDrzI62RhA02Dw+myrg27/3UMtKWaGoT7Dl+2SIATJfwwtPTn/s3giMFVW
         armU8tKXygPr9jV/oU4BTX34NZvsp7ztqvRHjNBBCkL5bRN0fSGFcZDEm1uBx8H+ZTNs
         7ND7fdfC3bsC8/u8KlMB+GyLEPI1ynPyNGNBwum5w1gdtEHFLTxSvBD9gY1dTGy5eKZS
         Td4gpAt/3p/MxDJ9i8jjY2uQ3LBsObHyMdR3/FjW4LJ0fxApxgBSbOmdFgyG1Pv0YsMn
         vv0g==
X-Gm-Message-State: AOJu0Yyuu00hfFIM5uCM5wqv99FB9KzIfuwuYd69GDHX10BHBnD2nSkm
	2FbPLLV1c2mLIhhwt67WquvJpxsUa0KedYetHqvwFKWj8RwaFRWRw9S4iA1bgg==
X-Gm-Gg: ATEYQzwgjejouvudiPy8R5LlnlXSjEXzuji2k885bclOeD0iIuS3AuBNZ2DLX3J2h/Q
	Zuca7nE+uQT1dr4nHyvuBg8ceomD9Abdg+nbvmGZCVwno99utBnKjSVSa+CXmSztTt2/LmpRNoA
	awYg2QHZOEaRuqiqfgbw3vWBRCgdoPMbEI0nMVmiSQXbK1SC+4hYL+Q1FPaGHVg0TCB3FjkOZdj
	xuj6dbftzNGseB3kqnntPgKsA14may8LZMwXAhBUpZzT7vkwhg86zEykacrFZwuZrvP8MPn3zxT
	p8TbHuQjgZpknvT56IDTue1QY3Y1EtCsFR1ZfKU7c8L9DU8tvEArDbWKT0vILXsU/1qUXV52TqW
	E5iGBjDCE6e30+Y/KtUlbgL8acV1BD/21Eze1Yz+ODV/Pthq0caZ4eie2ai3pJYFjDFr5VvEpxT
	CMdu9aBCfrW+ITONyq8KkwaFWPNT5vlnCBZM4FFHfOiWwuvKbVr2sP/h5Ok9En943PTyyT4F6Ba
	X9bNks=
X-Received: by 2002:a17:902:d506:b0:2ae:aa16:acfb with SMTP id d9443c01a7336-2aeae80cc3fmr36080125ad.22.1773257106081;
        Wed, 11 Mar 2026 12:25:06 -0700 (PDT)
Received: from localhost.localdomain ([115.98.233.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae360cb7sm31985545ad.72.2026.03.11.12.25.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 12:25:05 -0700 (PDT)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com,
	amishhhaaaa@gmail.com
Subject: [PATCH v5] help: cleanup the contruction of keys_uniq
Date: Thu, 12 Mar 2026 00:54:53 +0530
Message-ID: <20260311192453.62213-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

construction of keys_uniq depends on sort operation
executed on keys before processing, which does not
gurantee that keys_uniq will be sorted.

refactor the code to shift the sort operation after
the processing to remove dependency on key's sort operation
and strictly maintain the sorted order of keys_uniq.

move strbuf init and release out of loop to reuse same buffer.

dedent sort -u and sed in tests and replace grep with sed, to
avoid piping grep's output to sed.

Suggested-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/help.c  | 91 ++++++++++++++++++++++++++++++-------------------
 t/t0012-help.sh | 39 ++++++++++++---------
 2 files changed, 78 insertions(+), 52 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..daadc61c70 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -111,6 +111,49 @@ struct slot_expansion {
 	int found;
 };
 
+static void set_config_vars(struct string_list *keys_uniq, struct string_list_item *var)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str = var->string;
+	const char *wildcard = strchr(str, '*');
+	const char *tag = strchr(str, '<');
+	const char *cut;
+
+	if (wildcard && tag)
+		cut = wildcard < tag ? wildcard : tag;
+	else if (wildcard)
+		cut = wildcard;
+	else if (tag)
+		cut = tag;
+	else {
+		string_list_append(keys_uniq, str);
+		return;
+	}
+
+	strbuf_add(&sb, str, cut - str);
+	string_list_append(keys_uniq, sb.buf);
+	strbuf_release(&sb);
+}
+
+static void set_config_sections(struct string_list *keys_uniq, struct string_list_item *var)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str = var->string;
+	const char *dot = strchr(str, '.');
+	const char *cut;
+
+	if (dot)
+		cut = dot;
+	else {
+		set_config_vars(keys_uniq, var);
+		return;
+	}
+
+	strbuf_add(&sb, str, cut - str);
+	string_list_append(keys_uniq, sb.buf);
+	strbuf_release(&sb);
+}
+
 static void list_config_help(enum show_config_type type)
 {
 	struct slot_expansion slot_expansions[] = {
@@ -131,13 +174,12 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
+	struct strbuf sb = STRBUF_INIT;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
-		struct strbuf sb = STRBUF_INIT;
 
 		for (e = slot_expansions; e->prefix; e++) {
-
 			strbuf_reset(&sb);
 			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
 			if (!strcasecmp(var, sb.buf)) {
@@ -146,60 +188,39 @@ static void list_config_help(enum show_config_type type)
 				break;
 			}
 		}
-		strbuf_release(&sb);
+
 		if (!e->prefix)
 			string_list_append(&keys, var);
 	}
 
+	strbuf_release(&sb);
+
 	for (e = slot_expansions; e->prefix; e++)
 		if (!e->found)
 			BUG("slot_expansion %s.%s is not used",
 			    e->prefix, e->placeholder);
 
-	string_list_sort(&keys);
 	for (size_t i = 0; i < keys.nr; i++) {
-		const char *var = keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
-
 		switch (type) {
 		case SHOW_CONFIG_HUMAN:
-			puts(var);
-			continue;
+			string_list_append(&keys_uniq, keys.items[i].string);
+			break;
 		case SHOW_CONFIG_SECTIONS:
-			dot = strchr(var, '.');
+			set_config_sections(&keys_uniq, &keys.items[i]);
 			break;
 		case SHOW_CONFIG_VARS:
+			set_config_vars(&keys_uniq, &keys.items[i]);
 			break;
+		default:
+			BUG("%d: unexpected type", type);
 		}
-		wildcard = strchr(var, '*');
-		tag = strchr(var, '<');
-
-		if (!dot && !wildcard && !tag) {
-			string_list_append(&keys_uniq, var);
-			continue;
-		}
-
-		if (dot)
-			cut = dot;
-		else if (wildcard && !tag)
-			cut = wildcard;
-		else if (!wildcard && tag)
-			cut = tag;
-		else
-			cut = wildcard < tag ? wildcard : tag;
-
-		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
-
 	}
-	string_list_clear(&keys, 0);
-	string_list_remove_duplicates(&keys_uniq, 0);
+
+	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
 	string_list_clear(&keys_uniq, 0);
+	string_list_clear(&keys, 0);
 }
 
 static enum help_format parse_help_format(const char *format)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index d3a0967e9d..40b2d656a5 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -141,20 +141,23 @@ test_expect_success 'git help -c' '
 
 	'\''git help config'\'' for more information
 	EOF
-	grep -v -E \
-		-e "^[^.]+\.[^.]+$" \
-		-e "^[^.]+\.[^.]+\.[^.]+$" \
-		help.output >actual &&
+	sed -E -e "
+		/^[^.]+\.[^.]+$/d
+		/^[^.]+\.[^.]+\.[^.]+$/d
+	" help.output >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git help --config-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\*.*//" -e "s/<.*//" |
-	     sort -u >human.munged &&
+	sed -E -e "
+		/^[^.]+\.[^.]+$/b out
+		/^[^.]+\.[^.]+\.[^.]+$/b out
+		d
+		: out
+		s/\*.*//
+		s/<.*//
+	" human | sort -u >human.munged &&
 
 	git help --config-for-completion >vars &&
 	test_cmp human.munged vars
@@ -162,14 +165,16 @@ test_expect_success 'git help --config-for-completion' '
 
 test_expect_success 'git help --config-sections-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\..*//" |
-	     sort -u >human.munged &&
-
-	git help --config-sections-for-completion >sections &&
-	test_cmp human.munged sections
+	sed -E -e "
+		/^[^.]+\.[^.]+$/b out
+		/^[^.]+\.[^.]+\.[^.]+$/b out
+		d
+		: out
+		s/\..*//
+	" human | sort -u >expect &&
+	
+	git help --config-sections-for-completion >actual &&
+	test_cmp expect actual
 '
 
 test_section_spacing () {
-- 
2.52.0

