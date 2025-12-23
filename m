Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419A30F7FE
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488297; cv=none; b=GKTI3s3Cok9Ypf8oVSorED+4H7lGBeCwX0G++0uJNQ+tzqY1SxhaD6d6w4FjF+FWSrsPxaOTG9NspNA3+oEP08iiBTBEHDCbLYQb0amPWuB9J5pNzkmiWBsWkOXPseGky/JahsIZ1QcE9vQp3ZZRv+bypo+/4ZJYbr/02+bG88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488297; c=relaxed/simple;
	bh=QuWRJdzkeRe8G0z0aK+62UHULlthIWXoFV6OcpLLFp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXXkbWfXAU0P/4G63YmepLFH9XlBbXa8mQWEulWpIibymHzbqNm4LGLuH3hMfeZpMYAtHiNEs0qtTuHQd5l3ilPAqKe+sIBYbjEbNeo7Ck9a4qIFyMZGO+FopbnCbdttUa27aB19SP5bPtBPb4ELUKY+BEQkdL2N2N1oOzJC/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrxjMny6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrxjMny6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47789cd2083so25648945e9.2
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488293; x=1767093093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrHBDCqqwQwOETIwH+/5CrtdlO2SyLDpaYfV4JOFzmo=;
        b=jrxjMny6cKDmFat4EbtvYq1a+5C7i3RJ4goN2AgW2/qwfEZdrwdmCjee0dwUOP/vum
         5jSF2lGeJyMmeBdp61xb5NOVPR0C6d3perCY/7sDGTom4kH7mJ5bLzHRVeRD/ZEuzC4f
         pf2dn5DD2VRkrfz2NrkmAO5nMUzk2ShsGX2IOwemOB5rKpdPbX6F9AH3pDcEeXSI0H97
         iZ01vLSBs567/jL5rHjIVmkbLV5inKK8767YVAq/aK2EWPVQKn/2FPB7NsPgAQyETOHj
         CHEFjvmu1zyZVWueCJSX5CMBoOGyP4R6m8z5HMh6enDGoaivSDuh5iHB/H+6kxHRzNPr
         qRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488293; x=1767093093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrHBDCqqwQwOETIwH+/5CrtdlO2SyLDpaYfV4JOFzmo=;
        b=ZJM5FOBDIJqelHUSQN23pK0VFzQVyetBSB9rS1nYTi2e8sWtUYqw7cSUcobJ6HvItP
         ASrbfieR/ZLQAiwvCfaZ0TI8Uqzv4fwItz1p3esWo5Zo14vvJkjlRYYVfYktos4cOkbZ
         vGWR0BzTnsJ9YGQelabBXqmpnTDYQD5BT4Jv/gZx5ArHjuDc8Ckc5DDdF5jpM+nNGNaJ
         g8bsBAqzO+rfDPf9GCvM/5b+0qKUxAHW/tuuM1373JNLaQO0mEdONQ3on1AQyGl2toTz
         YCtwb7bxyUAgyiISMAzOIsXSba+7iaX/cRnMSUmJdloz+YOSGmZNL2XV/BGjD57YvSqb
         2Peg==
X-Gm-Message-State: AOJu0YxmAPGE1cJGrQa111jqO+zmnppxcaoSFAa0TABOI4gQ8MsakqGF
	wasur/dJNkVfiS5ma9ciEOzCRxX8jR7uCZQ1ZdAkhlX5M18XzljFrK0Qi2un7g==
X-Gm-Gg: AY/fxX4aD8GS9omsFIrcisxx5Mmir/TC/57EftmI8xMVYemhNyGk1cCXcYoONmy4vAv
	oYRAxT3pe2WgXU8C34xR8Kxvbjm+T/T/OewL0+5ribITTkGetqOour+c1HMf5WCrs+wvW/oKDc7
	vAjK602/a/nxzkvVHD64LpuR5Uc2btFRxde+r20ETV186YN7+E7RW453O2ugIVyekJp8ZK0OPUV
	hVxzCBVOxAAiki8EbdEqQZuZo6K+vzgDrJOzdE6mUr1sd06IOTR1LKdgU9JlCWbzVccwrbmkZq+
	VlR1pZ+aPbjmaftoayEGTLKK5N8Yr2aLgD1AgmiJMwkVAYs647LCiht0sUV78KaM0Vl9rZYz0TT
	z0VtOIxn3mDJGTRG52/OydmSuVenezbNP5kxJ4SdxwaLjJa4fv1wkR1P/9+epApEBSgtsPnjJbW
	rV1g3KsPA5OWMSGYvLGfw0w+MUsRYhCNO5wnCDzvLYSFsAdAhVSn/ahD43dISuQ1JBm0Rw0oQM4
	CzxPG7RjwF7cMl4mo5AVfFaz9k=
X-Google-Smtp-Source: AGHT+IHfGynMafRcqs5c/OPos0XWMSoOUJ3oCTI5T5XoOhSocgxbMGkXJW2MJa1mwiZyITgvh0NtcQ==
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr132556645e9.0.1766488293210;
        Tue, 23 Dec 2025 03:11:33 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:32 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/9] promisor-remote: refactor initialising field lists
Date: Tue, 23 Dec 2025 12:11:05 +0100
Message-ID: <20251223111113.47473-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "promisor-remote.c", the fields_sent() and fields_checked()
functions serve similar purposes and contain a small amount of
duplicated code.

As we are going to add a similar function in a following commit,
let's refactor this common code into a new initialize_fields_list()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 77ebf537e2..5d8151cedb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -375,18 +375,24 @@ static char *fields_from_config(struct string_list *fields_list, const char *con
 	return fields;
 }
 
+static struct string_list *initialize_fields_list(struct string_list *fields_list, int *initialized,
+						  const char *config_key)
+{
+	if (!*initialized) {
+		fields_list->cmp = strcasecmp;
+		fields_from_config(fields_list, config_key);
+		*initialized = 1;
+	}
+
+	return fields_list;
+}
+
 static struct string_list *fields_sent(void)
 {
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.sendFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.sendFields");
 }
 
 static struct string_list *fields_checked(void)
@@ -394,13 +400,7 @@ static struct string_list *fields_checked(void)
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.checkFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
 }
 
 /*
-- 
2.52.0.319.gfcaffa7898

