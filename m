Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE32620D2
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855883; cv=none; b=hPKLSAKk7FjHHV/Rs2EtQVN4PpplGdrhNDWjHLfAq1TWcewXHvdXyzQKVE31N3r0kox52H5YgvhK0awjSBGxFcuyHueByo2QfXmq7WRgJFBOWkFY6O/9aZq7DMo4dWgPG0p1vxTe6r8ropiqf4TV4Atgwrb0dr9flixXd/lh2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855883; c=relaxed/simple;
	bh=W0RsBe0XUf7JD7oSP1x7CGShWQKcYl7K1Z0b1lcnyNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIdQAuroPd4Rw/7hxgBzdcw9HrQk7YPjJbteyb2w+mq/KEEkLo0g+mQr5AS7Xa/m0WdFvCv5IZ9iM+XJN0tD2sR/CeJ/cKDE0LewM8op7b4y1ocBSyyVdmCtSiHHl6uzvMF691f4eSjeArv0aZCBL7XrxpKxR7YVZtdGYg/sQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiOxmIDU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiOxmIDU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1028430f8f.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855879; x=1751460679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Py1Cn4EcEBCfbgpam2SGDdlKMn7QGImhCVIUJcMZZY=;
        b=JiOxmIDUJBPsFrJcSi8Z0DS8rQiVQS0pGe4hFecsLtG07+hbyJWC05JYShMyEoP+BM
         JgJmUt7O6hD1JDCUPHoVpWx6DdiHqYt/VlG8cdQ8dEqeI0Tuq6tNUEf4JA9AY2A8xR4/
         xUlIodzCMeAyyaNXMuiAiZerB86xm4+o3An6jHiNLs/GJymqnFnE9gpwgvjgvXzJAB1r
         oZ3OR64mN97/PM64UVUkjD0IIUu7A3adwUoW48mgpT2LK8IxwiEFvsYHj+G+bkQZq6cd
         Y0owkDssThxfIzjz9saEk/tUVzLzSIxp07+n4vGLybztVzU+uFoLr3xu0bz7FOyt9v9n
         2fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855879; x=1751460679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Py1Cn4EcEBCfbgpam2SGDdlKMn7QGImhCVIUJcMZZY=;
        b=raJ0uwR4BSAC2kIgfHzUDMsxi15dZqrV6e1zkSpCpofAUvCeaqMnpbX16sbpkxXg4K
         G03qsQf/JpiBJNg6Uz9vDxSRJtbEL//+j+3cKLUyx5fwiNniqpmshgaJNbPfvcXkI81R
         H9NppB/yQwkQahloudNbfZEvTQaPNiinmM9rwHobukf/rMOHkoRQSD8ev54t4kgZj6LJ
         NfRzr1ItJIT4yRfnOkuMzx/uaE29acx1O2v7XPVILtzel/DTTC+b5uIh1FJ/7/toGvAl
         GgbG+y2d9+MgHHHpo070vTAbMVISq/LRdwV74Fs352Eb16vzcIBlNRC/hmIFZU27SxTT
         aqTg==
X-Gm-Message-State: AOJu0Yx4WEkFo6TaY0EJX6+5r2hWOfWjdky88eG7RSNVLjjPi1xiIXAp
	MyUU8GMH/H6wSB9l3JBKuzY9eM4Lbvj7Ha+N8LtNxv9Gs53GZJw57WcLwTMzew==
X-Gm-Gg: ASbGncsiKPMJw+8km19ySBfDxrtu9P90BW3uHmXGPoBirM3eMP2q6TbkHjFFdYtaFpk
	INh+ysRU6iznZaaMmePT7x0USlW5ZoT53DHlE/UvKUwH8XbTpOL7IhTlQoQWjH+GVT4ykbDP/H2
	L8h2uDnUGVMHG4kCO01vYDjgR6KhmbAp56HJ4KW+85A7NMYVNbsmj5v+1putYbYP5W0wYYHFAf9
	lPIcaoVe96bdlAA8SSsAinwg3wzm/R4h/25nfXMu8s+ReS74sQoI/bE6KSiTjO3H8UMMB9SyFDD
	d04mJojxa6hLfWOcD5JBZG82at28vlwaJVCj0BDwMedH/y35/CBRVvzsyqi48hHKKw6mSNT6CnY
	OXE6Ekl7A7ilX4q8/57JnaatzzGA+0fi2L0YNcg5GtR83sp38mmnM7I8=
X-Google-Smtp-Source: AGHT+IF0HezpzKrKH0f1CVc3vuBA5CQlkZPIhRzwqAod2tBT0egvqzoe9CWSToHugt9VSGGt++L4SA==
X-Received: by 2002:a5d:64e5:0:b0:3a4:e844:745d with SMTP id ffacd0b85a97d-3a6ed675141mr2449690f8f.56.1750855879310;
        Wed, 25 Jun 2025 05:51:19 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349548sm19446905e9.10.2025.06.25.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:51:18 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/5] promisor-remote: use string constants for 'name' and 'url' too
Date: Wed, 25 Jun 2025 14:50:55 +0200
Message-ID: <20250625125055.1375596-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.86.g149b275
In-Reply-To: <20250625125055.1375596-1-christian.couder@gmail.com>
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com>
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
index 049406c882..1dc2f525ce 100644
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
 
@@ -520,9 +526,9 @@ char *promisor_remote_info(struct repository *repo)
 		if (item != config_info.items)
 			strbuf_addch(&sb, ';');
 
-		strbuf_addstr(&sb, "name=");
+		strbuf_addf(&sb, "%s=", promisor_field_name);
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
+		strbuf_addf(&sb, ",%s=", promisor_field_url);
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 
 		if (p->filter) {
@@ -667,9 +673,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
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
2.50.0.2.g875523421d

