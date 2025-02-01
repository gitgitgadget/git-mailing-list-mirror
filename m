Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA16BA34
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392183; cv=none; b=mQnpVYYnSg66S2RIv/jfqiXBkH4uzhj7pTYvJg7ycOKhL57Oo8zmaSdwhFnN+9sPbANtL2KQP4pood8YWHxJ7WC/ng3c4xuumCcqgFXudQJWPd6CBESbjiEopu+Oo7CARbKhxKPmK1U5H9WYNoogC0l8yzFP08qUY5uzbGnMHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392183; c=relaxed/simple;
	bh=K8c7zrz3BsEzSXdD0bAIEFml7K9yEkDFRfdtYIl1MW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOIuAje4Ik5TQb0rkwo70nE79Lo0ZnVOH70ybsArW4Wj1TbByxFeE/jQbJwKHrM6QQ/k2/ooKh5J9QyLe+EwUq9RP2NtWf3p8t04sfdQlTes07CeczLraP/OoZ9QuqvuSfGXTGtRKzQUpsxk6VHrwXYPlJbX2e8Uf04gUTJ1vUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM1k+Yca; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM1k+Yca"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163dc5155fso49594615ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392180; x=1738996980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XrzHN4wuZPJQC7cj5lxtiODkgcNKnVudGps5nhWM6o=;
        b=HM1k+YcawlLTgAa2DcjKtcZg25mbTSN4W9GeD8D9UF4aYKoHPBjZ8FqPp87nBHpRmq
         2gCCm1B9LJIvgg+Y08zJv6iNT8phxRKXTepDDMXp80g+qhZxrWDGqPXJL270IidRq6pr
         xvTrocwLrURkaKSxobBSLG7RuXtY8M4AIrJveTNqMWEUNUh7CmJJ1YoqjZG2G1/FWf4D
         eBZZiIUuG3dZnJsbl+x45Ms2MgkiBI3IR3EwCNS9kpe8ISm9ZlEU6bCZUDeW1yz5Dgh0
         pbqBEfQ3jhcQTH1qCYAuJtItd9g8zoQqILKtmCQmKsG2BV83IlCDjpCERMd6/2x40aLG
         PQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392180; x=1738996980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XrzHN4wuZPJQC7cj5lxtiODkgcNKnVudGps5nhWM6o=;
        b=k/2ZNY5RxbBVtjJSc+klwS/i5+wsmWAByj3qiFDj4K4y779Ir6ntvQKGtC2HpTxw4x
         jP7738+hzODO/eeC/f5826Nlu9gm++FHN22ycoavy3+nu1R2rHHkWmcvqeKfZkL3dr7A
         csiAOrVDLTpDSiHSX5SaGFovfTacCzNhYuVrFfF7DoDW2zeRiqtsgl5jFN80dDZmk/BK
         Ax9sjgxmpjGP/Zdsf6kJGhTawJrtrN3ataVG8bbYM4YNUaTX0RVTLs6wGVtlzXls5RXs
         c/cz+8qH1s8H0zUM+z6cYBCF841XgmDNPp+aZYKeKsEJSyu0SDzsM63RK+Jk1B/029gU
         ccVw==
X-Gm-Message-State: AOJu0YxEHfmuoXniFJghf8FyznAoJC+6pENJfPEHN6m5pJXZra7j2a3S
	k2MryPTcVPCxMde+F5X8NOVkLYD8M5eqDm4BrEuGj3f5zF0iNVtUi+x5VsXn
X-Gm-Gg: ASbGncsgI3Bfu30Tq2dYQRBajo/vjiHCPPagofRYjPK2oDNRx5LsNne+E/zdUgqb2Qx
	F9P300+b7bq28rteZBvZVPzuV9QgEyDFqw5cwmUFED3WgE3OO/l5AiH6HKu7yKcNWfTO0ReH+Z2
	usK+BFF5dv3vK+8uKs/6CTVFbS8jUZYNwJ2oilcn+U67g1T8kr1kIp7pIIh7xPYM4ndEEq2xk2o
	7LDyNu3mXIVi6BrYETwVMAIcx8pxneWO8Hyij63wLq/RNrIuRpx9RIDgbiJXonF+LBzgx6k/9s4
	G5hhd73TRlG+lA==
X-Google-Smtp-Source: AGHT+IEbd1o4HRqRCy4hZlZ+za6BhYHIeCcZvAjBpUAizcH3C5bN+Ax9/bAKwKh/eoQGi4OyJgYp0g==
X-Received: by 2002:a05:6a20:9c8b:b0:1e1:b28e:a148 with SMTP id adf61e73a8af0-1ed7a5a56d7mr20628078637.5.1738392180594;
        Fri, 31 Jan 2025 22:43:00 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:43:00 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matthew Rogers <mattr94@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/5] refspec: relocate refname_matches_negative_refspec_item
Date: Sat,  1 Feb 2025 12:11:59 +0530
Message-Id: <20250201064202.76116-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201064202.76116-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `refname_matches_negative_refspec_item()`,
`refspec_match()`, and `match_name_with_pattern()` from `remote.c` to
`refspec.c`. These functions focus on refspec matching, so placing them
in `refspec.c` aligns with the separation of concerns. Keep
refspec-related logic in `refspec.c` and remote-specific logic in
`remote.c` for better code organization.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  9 +++++++++
 remote.c  | 48 ------------------------------------------------
 3 files changed, 57 insertions(+), 48 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6d86e04442..b447768304 100644
--- a/refspec.c
+++ b/refspec.c
@@ -276,3 +276,51 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		}
 	}
 }
+
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result)
+{
+	const char *kstar = strchr(key, '*');
+	size_t klen;
+	size_t ksuffixlen;
+	size_t namelen;
+	int ret;
+	if (!kstar)
+		die(_("key '%s' of pattern had no '*'"), key);
+	klen = kstar - key;
+	ksuffixlen = strlen(kstar + 1);
+	namelen = strlen(name);
+	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
+	if (ret && value) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *vstar = strchr(value, '*');
+		if (!vstar)
+			die(_("value '%s' of pattern has no '*'"), value);
+		strbuf_add(&sb, value, vstar - value);
+		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+		strbuf_addstr(&sb, vstar + 1);
+		*result = strbuf_detach(&sb, NULL);
+	}
+	return ret;
+}
+
+static int refspec_match(const struct refspec_item *refspec,
+			 const char *name)
+{
+	if (refspec->pattern)
+		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+
+	return !strcmp(refspec->src, name);
+}
+
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++) {
+		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
+			return 1;
+	}
+	return 0;
+}
diff --git a/refspec.h b/refspec.h
index 69d693c87d..584d9c9eb5 100644
--- a/refspec.h
+++ b/refspec.h
@@ -71,4 +71,13 @@ struct strvec;
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes);
 
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
+
+/*
+ * Checks whether a name matches a pattern and optionally generates a result.
+ * Returns 1 if the name matches the pattern, 0 otherwise.
+ */
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index cb70ce6f3b..1da8ec7037 100644
--- a/remote.c
+++ b/remote.c
@@ -907,54 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-static int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
-{
-	const char *kstar = strchr(key, '*');
-	size_t klen;
-	size_t ksuffixlen;
-	size_t namelen;
-	int ret;
-	if (!kstar)
-		die(_("key '%s' of pattern had no '*'"), key);
-	klen = kstar - key;
-	ksuffixlen = strlen(kstar + 1);
-	namelen = strlen(name);
-	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
-		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
-	if (ret && value) {
-		struct strbuf sb = STRBUF_INIT;
-		const char *vstar = strchr(value, '*');
-		if (!vstar)
-			die(_("value '%s' of pattern has no '*'"), value);
-		strbuf_add(&sb, value, vstar - value);
-		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
-		strbuf_addstr(&sb, vstar + 1);
-		*result = strbuf_detach(&sb, NULL);
-	}
-	return ret;
-}
-
-static int refspec_match(const struct refspec_item *refspec,
-			 const char *name)
-{
-	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
-
-	return !strcmp(refspec->src, name);
-}
-
-int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
-{
-	int i;
-
-	for (i = 0; i < rs->nr; i++) {
-		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
-			return 1;
-	}
-	return 0;
-}
-
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 {
 	struct ref **tail;
-- 
2.34.1

