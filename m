Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BD1E86E
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641975; cv=none; b=l0ZW0o5I1+DkAWGJHJVSa92PKo62eezi9WsLneWxgnvVhkJtMPc+PDdeRzMTCvfYBwchLLWm5W3tEtJF/fZ8TQzZ9iIsj+g+8LLkKtQIOAbv4vrR+5Jb+6DW4WULOUhUsa7DbSnQ4mM04vjwkR7Ww8FLCzG81axl27oXPRZcUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641975; c=relaxed/simple;
	bh=K8c7zrz3BsEzSXdD0bAIEFml7K9yEkDFRfdtYIl1MW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4vy5znE5Q80x9cdKE7/Wvx6DCv7pcUh+f48nN20lZ4DXMrWXG5v24Yk4Z3kpORQKa+6dDrP04SM1jBNrG6DqMNFAuJ0ws/KA3aOJuxGD6Wzjo5Win/D9vmfNuA5+tPwgdQuW/jOUktsGD9bjGnutm+t9ctQlhut777P9UV/GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/J95DHn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/J95DHn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so75235535ad.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641973; x=1739246773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XrzHN4wuZPJQC7cj5lxtiODkgcNKnVudGps5nhWM6o=;
        b=D/J95DHnwsB11ERUn0qol2UkTXYOe62VtryBc+/9qS0uZw1leyjii/rD6NIqzr0Gj3
         4h/KPCGe6eDsDfUnz5y6NUCMwB5mXYs31+aw3zm/nIxmFeCTZWiNLW4cTVxNqGCWWM3U
         Nkpyqqr5Pd5cuDhazrQeNGUg69ZB4JyyAL1xd/5sPMr+j34P9xqJtNduNtCPlfEOc31A
         2V5/maZOplcsb+No3KOh/iOSFTadsq7IGWjLgwdMNZ6ouz9kT2/NabSk9Estn+f+bgKw
         BANLiSrtNJz2glHkGpZ3hgO44hIbtgYsNoXMurJDOMtUwscwI78xI0+m+2W0jjcvy3iP
         5NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641973; x=1739246773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XrzHN4wuZPJQC7cj5lxtiODkgcNKnVudGps5nhWM6o=;
        b=M4FUBVG/oRUKLswRycPna/eeG0NvW9JsQzp5A512vRBzCrNEkc6MhDVzr+HlbD/H/a
         BZ5Ji3xCuNOsOmyGHIdJfMmpbzA8U9lKTySRLeRxlbp/NY4tQ1UsuZTacXmOFxkyOGHq
         AdwoOvnnHenU1PhTj3PxmSR2PlQRtCcrfx/4E5tM646QvlBwI7m2/zMXFeHXXQ+9g3mD
         5awx1bbNo7Qneruq+rJ9pAkg8+vLoVtqlgirDibquCR2xat6FtrO1hQouAWml1/YXJRJ
         lIWV7hO8rMEswJREDIFpo2vWw0MZ4OZIvmgZ/iTRTPDYf/DoG5E4jP9Q2A01Hy3c1Obd
         GWXw==
X-Gm-Message-State: AOJu0YxJmWKgCjq5GqJhOmWkyimbau5kCVlCGGqqyLLD3+X1NsdbJiaO
	VUWUB5t/+ggB0Ip2GAmPPuTOkordqtHdrm+aphop1hty8MHJ04aJ7DFKWA==
X-Gm-Gg: ASbGncu04GTioZ8XJWDoBuavF0PcD/QciaT+mtZ1yS3u434A/H4swSKr83Nej7bqG45
	TEtY5qCKYm8MXDN3fV3BBWUU9Arbo9t42B7McZicJ8gzB97FD5OCK2EPpZMnHxbg/PbGjKqPuIJ
	qqWhO8udmdRI90xfSbJqv8u6g3NXqOY+lZZcdtbDZB+Oz1okolkLQ79wMynuFNUW5LNPD2tO6kX
	VvU56AnPyPrM2VkVYN/NcWcYwJxOSPtwnbB3e1thGawXjzfg/nCawJw2UcvMuxMTI/kmcAGc+Bf
	Ws6xjmp0orI9tQ==
X-Google-Smtp-Source: AGHT+IHmBZC6GgL9hoimycqvx+9ntUEQiBlNtTcLT+9JkWCiqNWOeX0RMA88qau8dOO3GFtAmTsCww==
X-Received: by 2002:a17:902:ea03:b0:216:4883:fb43 with SMTP id d9443c01a7336-21dd7dde209mr429757125ad.32.1738641972865;
        Mon, 03 Feb 2025 20:06:12 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:12 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.keller@gmail.com>,
	Matthew Rogers <mattr94@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC][PATCH v4 2/5] refspec: relocate refname_matches_negative_refspec_item
Date: Tue,  4 Feb 2025 09:35:55 +0530
Message-Id: <20250204040558.34766-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204040558.34766-1-meetsoni3017@gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com>
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

