Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C21EA7C4
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753674958; cv=none; b=EkEBcXOk+9SuSMebWvZ9Ngordl3jxEGdNIXdMJnWBJmQrGpXfqMNJ1mKPyj3LVj0NpeeiITx8lqyW2dxikOUokvVfvbt89SG+vs6dBgzHeo/gau3JyR0Ak/ua178frMT2wa4qLXkMKT23MjFqjt1cFJotIAsFqW4cTtUA3LO+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753674958; c=relaxed/simple;
	bh=CSJU5AmxadcTPinSFGkowaqUpIzec8Szicj7ItF7fqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UviLjl8ByXt7xKrZPm0RbYdySEKaTa5LP6Fnc5JuBTi91kgc6FMa0PSZu9L9zjNcI5ynipqvEB4yM2orziARkQdbcT4OvXHeoKxqOZt7vq201io+3ehuAynylewxKAOnREh6/Rc/s5W3ONSp/ZnsUxpWdeXvUjGj1zeuC3RTZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eUsRid5W; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eUsRid5W"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3600875b3a.1
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753674955; x=1754279755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtoerjetN+E9agNOBbuM2wVnLsERSyf0trXfAn29kbM=;
        b=eUsRid5WXFozOcDIW+zI/xHCrcMxG8jwCyg/kqcslIPvnMGkGH5ktBSN29J8mzGXsQ
         YxNqJq7nfG8GLvHIeYrCcRiW/XVHa9VHIJTyJGlYoIgaV+Iv5zEAdIXNceW7j8hZP2eg
         qFbwlUZbhzqaB3hsY1f5D+7b65SK6iiYcq/tVsX5OUEUX5Nd8q8//7UEvEc+rEMC6+kY
         xqSPRCQ9HTMn6ycxYIRiFxfpGJk7dLHZxzNkD/OlFn8pB2zHCVz9Bw4wK+N1oRRAYxAj
         o2bPmz6PlENSdUnNAm1mMUWccbfmHnRuPGL6QLTNIq0BKKDTWwezYBa01SP/ul99Oknz
         yOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753674955; x=1754279755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtoerjetN+E9agNOBbuM2wVnLsERSyf0trXfAn29kbM=;
        b=F0PWsCLGCovodJRbyh5gNHeoowfrnhnxjw8+AOVp8wGcQPZNCyenr5y5BVPXnwSPfl
         aRaXnMvvvzSEVZJxciVHYfBiCSl09H961g24VdHkAtlwbUNkmiG/g7hyGuh1nVyaq37c
         BueWN2cKzQLgwQ0E3/eQokbMAVP5NWiMbcnZBNIxkwtPL+evPAn+ydB27GwAHOt+9TmC
         +MjDA9Nx1+c1Agtg+Dg6AO6VCTOJyqAcGF0cHquA7c0/mBRFXKWmzccfLKeg7uLrHho7
         jshxOknvFC/E1tNrjBata9HYO6vT8e4dM0iCwTDKGfiDcUo1L42FHqcGyoBHUgqh2l1j
         lGUg==
X-Gm-Message-State: AOJu0YxrhOnS8tahhdGgl6ZlCGneP/1NMrcmiZAR97doaaJnvD4Nhkb+
	PCbBONbrV30/NXJOkOV7PZsBr7EjEkaPZ/3J1pdIfALW2af0uUCrQEQJTQJl1waA30DdOPGTR4R
	AJxvR
X-Gm-Gg: ASbGnctV/sCD88cLAk9k9PUooMg2vZQakRoVzpXrK0rQG0rmEjlpuHm0mHXY7Sf4pkM
	3qX+gpx+rcqkMYWxIpCRIvwwOUJZ6h+TtTPKZ2xUUzQRGQ6AszNCehno/efHv7SiHm7NHeF1p/H
	10U58wFeDBaN55seJhZRzyRt4z7aWGdZCRn7qeDIR0YXPUxnggHtFyAM/Yrw5EjtKyGUwkEXEl/
	mN9XBx2yN5eHKN0tyk98aeFjW3dFrsj+Ayl984ymf0pA38JOUzhUkZP6gNQSJAWTNz+euqxdWea
	A6HiJWC2LCkcV/V3186d2fQAq5IaOQNPf3k8ht1VcxLe4gpiq47RTkB/AingzG//rF48SOw2m1y
	2XF8sTd/9lDWQgBT2behb//7oHqxpu5EycP++/NxAHtTtJTTCFZciBgnalXXo
X-Google-Smtp-Source: AGHT+IGceku70iVsqcBMzz9LUPDKvMnLNKqZGe0eZk5NDfD0i21cBJ0TaojDGZlarXLCZvwMVO5f5A==
X-Received: by 2002:a05:6a20:7d9f:b0:238:abe:6363 with SMTP id adf61e73a8af0-23d5b705b80mr25812996637.14.1753674955479;
        Sun, 27 Jul 2025 20:55:55 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6af84fsm3792195a12.50.2025.07.27.20.55.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 20:55:54 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] blame: remove parameter detailed in get_commit_info()
Date: Mon, 28 Jul 2025 11:55:48 +0800
Message-ID: <20250728035548.94277-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_commit_info() function accepts a parameter that can be used to
stop the commit parsing early.
However, none of the callers use this feature, and testing proved that
the performance gain of stopping parsing early is negligible.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 builtin/blame.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 91586e685..dc934abef 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -197,9 +197,7 @@ static void commit_info_destroy(struct commit_info *ci)
 	strbuf_release(&ci->summary);
 }
 
-static void get_commit_info(struct commit *commit,
-			    struct commit_info *ret,
-			    int detailed)
+static void get_commit_info(struct commit *commit, struct commit_info *ret)
 {
 	int len;
 	const char *subject, *encoding;
@@ -211,11 +209,6 @@ static void get_commit_info(struct commit *commit,
 		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
-	if (!detailed) {
-		repo_unuse_commit_buffer(the_repository, commit, message);
-		return;
-	}
-
 	get_ac_line(message, "\ncommitter ",
 		    &ret->committer, &ret->committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
@@ -263,7 +256,7 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 		return 0;
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(suspect->commit, &ci);
 	printf("author %s\n", ci.author.buf);
 	printf("author-mail %s\n", ci.author_mail.buf);
 	printf("author-time %"PRItime"\n", ci.author_time);
@@ -471,7 +464,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 	const char *default_color = NULL, *color = NULL, *reset = NULL;
 
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(suspect->commit, &ci);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
@@ -665,7 +658,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			struct commit_info ci = COMMIT_INFO_INIT;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(suspect->commit, &ci, 1);
+			get_commit_info(suspect->commit, &ci);
 			if (*option & OUTPUT_SHOW_EMAIL)
 				num = utf8_strwidth(ci.author_mail.buf);
 			else
-- 
2.50.0

