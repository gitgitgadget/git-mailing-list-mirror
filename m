Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D13112BD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481684; cv=none; b=Kz6px59DwGO2t4FjSYp/WP7Dqcm4QkIxqSgxpjnPr19No22vNGiCUnAVZ/C66vpH8SIljxEhHRCEWfuYItWjPIdeHcY3sJl/kNsoS2X9lOLhShf6somOQhFFcfjT4qy+rbNs7NfUhj9L3OQr+BxFPRHwMwNKlDuAHbt41Wbep88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481684; c=relaxed/simple;
	bh=02WURZcZvL7f5bpDeQpVEnldAZd3vQySpU5VPJCKRQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9oYRXGPfMaF3M9B/iSa1RGov1OWr3ygxeXiMvTAITyz0z+YbA+6rpsIiQm+VowT6KO6akr7Pu+7xrOWtm4N96ndZbiDQTbDZw5MnTvDz/ZVvYInyxah4b6pUvn3hymj2YDrh4Bfa996S1MLwr7fWvSWuFgw7O0CEUHoGSudaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy2SJRve; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy2SJRve"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so29656955e9.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 12:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481681; x=1773086481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94rpIcLxgG7UBMY7yN7x4K5rb5sZ4hArbRLyH+Tf7Ng=;
        b=Hy2SJRveDXKS1dkcj9jsoW2Fo+vA2PQC4KfKnL5yNxIJwkXggLZ0dTv0NArY91WZcy
         BpNF/O/m1J/zoip9rTk0ok5W4dmV8tAEwlSEJHnGz/mi7xflOtTuEXXeGOSQQAisoZ7Z
         M/8Xsuq7Kx8aKEFqg9EbWKv04d1YENLTuTYNf+xDgYlPkpHHxOTuZtyRqaV2njnuq0Bn
         zuZ3mNadY2NdHWL1fzyF8yWbgxGjtMyiGQuEIfLWrnpXOtUJAMYjyp8GrrT7/1KYjaBa
         xKBO8wrUakR7sgAuiaH6N/vPu/EGhl7+rBZ5lVG42SGRbv8mDJUcn8cPqw9piSFs+Kj0
         lbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481681; x=1773086481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94rpIcLxgG7UBMY7yN7x4K5rb5sZ4hArbRLyH+Tf7Ng=;
        b=QZSckEmRQ+osq4qpsfLbmnfxAw+IbJqBELVldIEF7auvMbbCZJxx7Hr6RQkW32FAO3
         +0xXwPPGrZ5uRO1+npjh2BjQWD4Jyr+Ji53nrlpYSDCvkBa3Yv00pa05BgftgxshzTAt
         R1gYhR2EucDrMRtBKBnDnX5VH2tc7FSwV4TuxN+b1VYCBAiqVqZPo92bFYk1Y8AhiFu9
         WTkQZ80pUfohvmyXw04EEccrdz/pFe4cFjZEW84TFFuHV0c46Al1/mEyhOWJx7Zinr8u
         Vy7VxTf83AJXLO/B0KADeUAsfjnQukYHv2F+FzhoaN5lHwhjCzLHnTa+XVS9DE+G5VZQ
         0AsQ==
X-Gm-Message-State: AOJu0Yy74JkREmZ9HcZ3KqAfwbUdyJJu/KdSU6eoOX46jF88yf1yA3Nf
	BWgYGylKq91jGQY2gvtfTPIhZOIVYGMxPYhsNYJVQgCJRigjXTIxtKQ2P61WPCQY
X-Gm-Gg: ATEYQzx89H+Y+c+gt07FXNsi4787NtuyBOmbiIPCQBsLbhMVEUYtUXbiKw1pgshXrKI
	Pazqf7k5TjqVkIb4aNMvF9zyOPajBj00/tksRVUNACh/Tx5h2q711FKhDV5cIW5xderT+DtEgd1
	a4PcIEoFxlkzoALYY8xznkFRkf9B18w8RnwmL9Iz1QUlTNT9wff6HT00LTXzbR8U6bCvPjAJOCd
	cEmpR3HBL8TQT0MKHlK3s/RML+uPgSpHdLDCfcghn40EIJXrPp40eZu/3CoJw10KFiOOmmLIvAp
	L7DqfvbmM8dQBPIN82GtMU4R+/9DdETJCtfagNfypXZBYPl93BglYpAcxd19npYC4uXbrD3rs3M
	r6gUC2UYH3RpmPohQa7Z4a0klZJzb8+ACY3kzvdTsBygFdOjh3fG57wgMh5GQHEyHgfGHJBxJ4j
	W4JRE9fyxY4mk0JVhyc31mJEbQZa6/EyvAq700WdEKXeHGWpo1BIuWrY8Xl7ipLky3ftHdbOMGo
	vWxhVxnVg==
X-Received: by 2002:a05:600c:34d0:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-483c9bdb2d2mr258971095e9.31.1772481681394;
        Mon, 02 Mar 2026 12:01:21 -0800 (PST)
Received: from localhost.localdomain ([105.113.67.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126547absm446875e9.7.2026.03.02.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:01:20 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v2 4/5] odb: use oidmap_clear_with_free() to release replace_map entries
Date: Mon,  2 Mar 2026 21:00:16 +0100
Message-ID: <20260302200018.75731-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Replace the direct oidmap_clear() call in odb_free() with
oidmap_clear_with_free(), and introduce a free_replace_map_entry()
helper to properly free each struct replace_object stored in the map.

This centralizes cleanup logic and ensures entries are released
correctly via a dedicated callback.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 odb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 1679cc0465..8ca497203f 100644
--- a/odb.c
+++ b/odb.c
@@ -14,6 +14,7 @@
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "odb.h"
+#include "oidmap.h"
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
@@ -1089,6 +1090,13 @@ void odb_close(struct object_database *o)
 	close_commit_graph(o);
 }
 
+static void free_replace_map_entry(void *e)
+{
+	struct replace_object *entry =
+		container_of(e, struct replace_object, original);
+	free(entry);
+}
+
 static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
@@ -1109,7 +1117,8 @@ void odb_free(struct object_database *o)
 
 	free(o->alternate_db);
 
-	oidmap_clear(&o->replace_map, 1);
+	if (o->replace_map_initialized)
+		oidmap_clear_with_free(&o->replace_map, free_replace_map_entry);
 	pthread_mutex_destroy(&o->replace_mutex);
 
 	odb_close(o);
-- 
2.43.0

