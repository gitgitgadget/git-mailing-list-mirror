Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0435A394
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275652; cv=none; b=e2P2cAyCPxXHJ0G0/qD4ie/mjCgmcbwj6u6TYRk97xg5v+yoVur5bpj41RCMXO6CQdfuoCTgAh9c17bFzRlgSBogUrgLRASCOdn9deVXCbD+r+FWsqHJqqvns3Dx2XFyrJuzYBDvwh1fQ6JC99aM6dzwX8q6yltuNKMhUsuJ4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275652; c=relaxed/simple;
	bh=j7yRl5UjDBBNnicpllOmLztyKOElor7ZwYaGnrrqZbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSLxBrIqMFjA1F/s3ziDKD7/0/JvtsZhPFad2Whd0KSA1bASa/kCLetIqDo3aXkTQQ+wdJQnK7HIdKJoyK14pxiAMgv/ZKcHgUoL8nxIf1bX40NBsSCepbuF+tmghVKRkRn7/L+TyVan4uen3lWacm0pJrwaU7LYAAkHNoO/SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP1hJ7+O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP1hJ7+O"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806bf39419so28533065e9.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772275649; x=1772880449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1UpQlqZ7vfXkIIiTnNaTjdhBo+lWfSWyjd3fchsH2g=;
        b=GP1hJ7+OzZa4lxHXz83apwNdZVwfRCbdr6Utkn+XBU0jcAh9oqZpJ9MQR58ajTYYXo
         xbyXlTdUJjWNwzSbOc/My7G5nEqiB6EliRDMNaU4Wkmz0AJsBRc+LS3f7A05SvtIVkfe
         Z7n/mBrXAlmZWceXZq9buKi2+eLUXrC7n8MCDnI9aNUe0FIlcg8d11FvGDkbEDeuWPv0
         TatnZ8bLZlNjOs1W8pt+JcHIA/ioyWgQYbFRjngALq8/qBT1WWfYVXr6UZvQ5ExcTV/t
         BMyKqAt0XZoVUm1UFyxN8JxUGIpybN7P94iZeCeuQZFwFbmIh6GeL6D4MibP7voh91ei
         BWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772275649; x=1772880449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1UpQlqZ7vfXkIIiTnNaTjdhBo+lWfSWyjd3fchsH2g=;
        b=B4uW/6gYLezFRHtZj73iz33YOjBad2WcuFKR8GV4HwoiKnAgeI11wNX+Z+FUe9fjAn
         upVW1pvgVizT8zpk+KvgzlWZwEZJQsYMMHL/BS4Q/JpFI+ExW6LTvTYfSPWFDJuV4LkM
         TVAVvFjh9V2k7kH+YzLL+5yfEcYl/9oV+2UyeQaiwOfMwV8DZC9M9eNTPnpn3sGHLjRf
         i63GrrWQD/EeEKR4kVDcjvWH5MxhiSJVQy6MF3zI+JciunFWS7UWeEgWvXmDoJ15riRN
         EJb+/0W5TBGu47XZQrLnEkN/DVf8lryZ6B3LNpr0fSY5WiNTIDg7t7pms+wJmUcGD4jM
         VuUA==
X-Gm-Message-State: AOJu0Yxl8vyhVSq+UUekxjHXhGWC7TDcKK8ndlliEKU8zM8QiygYBhDZ
	+TTjxx3AdZtii9qh8ICz/za2T1u3eKN/KSCyca1mMbi0kO0m7Zc3yWrT200aCA==
X-Gm-Gg: ATEYQzylUsE9XIovZlpe1IiektF+A4gpb0RCWOFziQGLv10umKocKr81z2z/+2/1BR/
	2mGxFonoOF9vnl1xDQnOp/wjwEfa/ODr00rylQVw34WWORzxzMzb8iW4/fcGN5aCtYIZVNN0gr6
	g1f6Y+gVicmjY+AKD9zasjlkngDM6I4c0FLAj23SGx7g+2vKnjRRe/mzE8Z5gFoG5ak4qiqQsR9
	DYefDZjoFWA//2eD22wctmkY5M/pMvRBHfDhqxRMikDJq0xwOHGQaiQsdKHdKHLETRS97U2sXxR
	V4KEohmcM7Us2peXTS6NU7EoKHLkdpwpfXhcDpzOkDl8YWs/46foSNpaI9+/rTADI27oVD4WSyR
	OVlOizKv2hoEOVsv+Jau7+uBTqt49+mL+Ninhbzc5eFskbzljtHlyeMNZEqzJVQ08HKYjOKhRSk
	K3Y9s1VkRnXEtN+IyqzW2age2VybjVk/zidosOBCjZN8mSz2Dx8vWPN5q0zxIpGUF/YLwoWTSHd
	V/XdbE3rRLZNGFAPA==
X-Received: by 2002:a05:600c:4f08:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483c992e3c0mr87864375e9.12.1772275648618;
        Sat, 28 Feb 2026 02:47:28 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84139sm179357795e9.14.2026.02.28.02.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 02:47:28 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: avarab@gmail.com,
	gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
Date: Sat, 28 Feb 2026 16:16:54 +0530
Message-ID: <20260228104654.80831-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260228104654.80831-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
 <20260228104654.80831-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

construction of keys_uniq depends on sort operation
executed on keys before processing, which does not
gurantee that keys_uniq will be sorted.

refactor the code to shift the sort operation after
the processing to remove dependency on key's sort operation
and strictly maintain the sorted order of keys_uniq.
dedent sort -u and sed in tests and replace grep with sed.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/help.c  | 84 ++++++++++++++++++++++++++++++-------------------
 t/t0012-help.sh | 26 +++++++--------
 2 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..3658836d23 100644
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
@@ -156,50 +199,27 @@ static void list_config_help(enum show_config_type type)
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
index d3a0967e9d..03104b3bf4 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -141,20 +141,20 @@ test_expect_success 'git help -c' '
 
 	'\''git help config'\'' for more information
 	EOF
-	grep -v -E \
-		-e "^[^.]+\.[^.]+$" \
-		-e "^[^.]+\.[^.]+\.[^.]+$" \
+	sed \
+		-e "/^[^.]*\.[^.]*$/d" \
+		-e "/^[^.]*\.[^.]*\.[^.]*$/d" \
 		help.output >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git help --config-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\*.*//" -e "s/<.*//" |
-	     sort -u >human.munged &&
+	sed -n \
+	     -e "/^[^.]*\.[^.]*$/p" \
+	     -e "/^[^.]*\.[^.]*\.[^.]*$/p" human |
+	sed -e "s/\*.*//" -e "s/<.*//" |
+	sort -u >human.munged &&
 
 	git help --config-for-completion >vars &&
 	test_cmp human.munged vars
@@ -162,11 +162,11 @@ test_expect_success 'git help --config-for-completion' '
 
 test_expect_success 'git help --config-sections-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\..*//" |
-	     sort -u >human.munged &&
+	sed -n \
+	     -e "/^[^.]*\.[^.]*$/p" \
+	     -e "/^[^.]*\.[^.]*\.[^.]*$/p" human |
+	sed -e "s/\..*//" |
+	sort -u >human.munged &&
 
 	git help --config-sections-for-completion >sections &&
 	test_cmp human.munged sections
-- 
2.52.0

