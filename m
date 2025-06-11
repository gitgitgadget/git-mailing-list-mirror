Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7728C855
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649533; cv=none; b=mfVx4iLqSzjFtsEdiCGAxgyrBaeQSRt2UPTpl8cikZs8r1vcCuuUr7j3ombwhyfYtYRx8NaqovXUKj3mo5Ef651UgibT2fXOdErgrBYaR1aoE7kdlh3tZcYhlgfwiIljXcNraZYzj/aAnCByEsPBTRDXnal9l2fEvPXxm47sy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649533; c=relaxed/simple;
	bh=VesuiuwsSftDInDkdkH+IT6UcSqiECmni9tM7munI8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3LuoHBmxJcdBtoZaeFbpgMWmoz/XeBpXlj5RiISJv13HklW6Qb3WpwWC+GKsGTj5AED7Q6FiW+W+4HOr5nF0A+869YZRVqtoi40pyIQE8CclQ6mh8d6qAzXgQiOE/HYO4lcE2JS/thLnv1mUYfErhBieqRzCvWlEEVvN4f3pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+Ww3jJi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Ww3jJi"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45305c280a3so15636165e9.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649528; x=1750254328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iBJuiOr2wtrsB50RwQZU0DmxTcJGJKbvo2oHVv7mh4=;
        b=k+Ww3jJiXCN5xLAV6+OOXMRKEgJeCVQ4EyBQH3gWUhCnDUhVJERVy6ytZrenkDCKhG
         N6nBTxh3Ja28FrQ+LnvCkJgih19DnhCWykdhoRmSOCOZKbPtQqa/gWQWBqFesmdajI4e
         JXmKIJp5XcLB8wwr/Fm3N92AVe/+JnrpE2YEhvvNFVs3/mZ40dyM69rtkHaHPzrwXnU7
         7OIM89bPjXoe/6rInI3EP20NzwwnIE0TR9RoCAC06jlkymVOPTqOu2XAa90D2DD0Ur0A
         EEROrI0akW//080nnlHOQBZCe115NFOOUZFNTfktEfwNRcVbATDHVqZ7Irpk1BiVadUA
         CTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649528; x=1750254328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iBJuiOr2wtrsB50RwQZU0DmxTcJGJKbvo2oHVv7mh4=;
        b=Xo7DyamOk7OEQrq6jNbFKDdVDwTcW1seY6tiYIYpzP2bItt0RB3t6x8j4fdjolGriK
         JCk+YJhQTVNmNywcZA+Iz11CtUqZU4TAKOKKgGA2BIvesl+/TLebmkO5Ck0WGUsCfhJB
         ZqSgDYL5UnTiyUc6jKi2a9aIqs8Si/wfAvGI6t9C5z2pUXG5QsT5qR2eAb3siV3UDEgC
         rfR1nY97fu+z0ahv8hpStOFTvEvKdSonFwJ9DpFjXJZHgB/JHIT8G5D5lreS32hK3mQG
         EnnlNVzpGxa+uQ7bgdg1sK4tNU7Op6Rr+PIIu+ythNAGXjQI0iNO+I2PJgYNcHD+BGlw
         GSXw==
X-Gm-Message-State: AOJu0YwRPDLZQ9dJJvy7feGVNvCzsiN/6A3vM+YKD4UU8AnFmzJilUo/
	TWDvWwoLVB3H9fCYrsbaZT7v4CV34o5vtSApwKWphQQMoLuqNhnAMn5fV7/Mvw==
X-Gm-Gg: ASbGncuYSWwfeiML0Q76drGWAf22yWUcfYNIrw/H5Z8tzI2jkZhJAGww00G/fHwfEE3
	AW3yLO4OM4SSq2ft/cA/f9jixSpDJzDgguKHrSOZ4Q3qwqg9TmuubdHjqYw63D7OlOrYx6ATLnZ
	PLM4016MPeElhJoQpiFQmIeNcRUXCDaitGT0GTui038aLTfxMimpc2CD2mPgBOgmP97TUvxjWiE
	2AGtzQhuUF0MFxOlMnylP2jpeGjwPW9dVNxP92kuE22dooOc4Hav1qQmF7RYi8a1vaXt+prCWk/
	/6O5wzRSlefmKlppnBam2T7LHh5q3ypMgmAxsy0mkSslMfE2jbtznoc9qpFnwYWP3bFrl3yuPaK
	tdPqT7c/lIaTT6AQHiL3q493kB+5vkDB2IvvVfDBdySx+
X-Google-Smtp-Source: AGHT+IHXNKc9UsNVRpVHD8MaxC3kloNUgZXvdryueMIBQIsWDZGLkWD51juo09P35ibgvCpg2KtF+Q==
X-Received: by 2002:a05:600c:1f1a:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-45324893661mr33006645e9.15.1749649528365;
        Wed, 11 Jun 2025 06:45:28 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/5] promisor-remote: use string constants for 'name' and 'url' too
Date: Wed, 11 Jun 2025 15:45:06 +0200
Message-ID: <20250611134506.2975856-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.5.ge8efe62b7f
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started to define `promisor_field_filter` and
`promisor_field_token`, and used them instead of the
"partialCloneFilter" and "token" string literals.

Let's do the same for "name" and "url" to avoid repeating them
several times and for consistency with the other fields.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 939cc78a7d..07fa0158ec 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,12 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * All the fields used in "promisor-remote" protocol capability,
+ * including the mandatory "name" and "url" ones.
+ */
+static const char promisor_field_name[] = "name";
+static const char promisor_field_url[] = "url";
 static const char promisor_field_filter[] = "partialCloneFilter";
 static const char promisor_field_token[] = "token";
 
@@ -514,9 +520,9 @@ char *promisor_remote_info(struct repository *repo)
 		if (item != config_info.items)
 			strbuf_addch(&sb, ';');
 
-		strbuf_addstr(&sb, "name=");
+		strbuf_addf(&sb, "%s=", promisor_field_name);
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
+		strbuf_addf(&sb, ",%s=", promisor_field_url);
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 
 		if (p->filter) {
@@ -661,9 +667,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 		*p = '\0';
 		value = url_percent_decode(p + 1);
 
-		if (!strcmp(elem, "name"))
+		if (!strcmp(elem, promisor_field_name))
 			info->name = value;
-		else if (!strcmp(elem, "url"))
+		else if (!strcmp(elem, promisor_field_url))
 			info->url = value;
 		else if (!strcasecmp(elem, promisor_field_filter))
 			info->filter = value;
-- 
2.50.0.rc2.5.ge8efe62b7f

