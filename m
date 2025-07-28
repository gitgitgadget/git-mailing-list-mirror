Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD11E492
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673125; cv=none; b=Ffp14+4Asb6khc91HKI7rb/Xo2y2rGNm8IHslXHhLV4oCmTQlR+GCQs9rmWZA/XuYOCTSnibLm3qb2bMkVLq7edbQW+Ubx71jjB2kPrywkn0pwiu8XMdelYKhHucVN3aUhttxev8YswGa767IFWD5jnl/UfZQy+r3gONgEnAa1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673125; c=relaxed/simple;
	bh=hqQDW3GVfMOH1nIoA1uK5c5cOueCuN7ox5dLtI4/MDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGEso+MSjicOTsWb7fvQg1SDqpsfo+ef7OK3aoZWR5ry5vmQp9ETfKkj2IwCpGdiLc0PErXPifZRkcvq94uXA9UtZUASbxT8nQdniwUgtspw0yIp4CuuNgohPkNsvB0W4yTSrJhuiigjfkz+2oPGOQj0ndbK/dKBGzh7J3KCVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IA9P3gs3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IA9P3gs3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3150999a12.3
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753673123; x=1754277923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qO4znpJvCKOD4H2CWtHJqDCWdJDYG+elyi2/gIQGzuM=;
        b=IA9P3gs38w8IT9roNHsZrQhibFbl3st6BK+yE68m5xE8BO5gU6CFfJHID0eE6jRXCl
         7+t7zsjhXxr+Bpx4uZa16Pgrr0JSNC7k/DtnEbI6JegybzeAgH3emBht0aki5DkKMBDG
         0DQt7umdqUcaLES0pHp1kPFYe+Cs20qdWD6gGQpqEpLsIBKyo3kWcES47RBx85tyusZ/
         jenXekk91nix9zVtV6a5Nt6yD89itIac8MQtoSmvO9In19FDRNdtN5vraewHUAqEJ7xb
         e47FVqiVjrN1L546THxTESdLf0ROuEXhfBTQr3SmRJhXv6HbwnbMtOgoGoW2pMcNowmc
         vfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673123; x=1754277923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qO4znpJvCKOD4H2CWtHJqDCWdJDYG+elyi2/gIQGzuM=;
        b=TJnJ42So4cMVTkCqrhzDbwWKCh1H+K3Dt+DDZZ6ogiJ8KB+8EYNOf1MgPHCEd3Exmy
         y9ug/wTs1T+qcyyVyUYli+MZujDYwWaorzrk0f0OdPQBUU467PIg9sORqJtAgcu2CgOZ
         QLILRN9PLtyq0cpEV36JyRYUjWT1QsBUgikS41aOffy5AsJJOUqgpHE+1G33k5a0X1YB
         EHP8H/EADOQ90DCnnUkabeGDO8pmfne5v3/RovpT2UMdZiUwcnDkkffjYeKEmxmaG15D
         TVEq0XT+L45vsiqF/OCMcQZ9l7LcpORWEp+tNqhOOpIBVM2fg2i0fLYnsyz61sMSXXqN
         uarw==
X-Gm-Message-State: AOJu0YzILds/h0K4BoW3LOJfGw/66ZHeWL8ilQvsHmZhbvIK6ZG/fAhn
	4dxsLsxf+AlKBkYzoXdAKChz1h4VA4FJV7aJN6XTiVLwFrpna6QuLLJk6lyGcWw3xLEBzLXkx0c
	Q07+F
X-Gm-Gg: ASbGncv6dsMfi3B0mqojMZR1HqqESd7gZePObftUB8JV2AOTwVjCm40IrFfYfI2C+gM
	xWQjPzB4leOD7WQbloC9sVS3Y2ziw71gvkMr757UD2Q27uTfBu0xQllzZ1qK3nQSwhHcq8iztPX
	E8awflCKgb8ObKwCaxsHznF0zuKON5mj+Ufq4nL0A4nXlKeI/p+SxN3bFnFHEp4JTdHMIVuQjku
	nRg0uNStT8aDtXXEzLuJ3tj91q7pGxsyx8FW9J0jFnAxPPFwCbARfuweNcu494/cwL8Tir2P2ok
	O1rIyBTJMwc9OkzwToI5nWUjQrT91z7z+C4A4naSMzZwfN0tdWK4z4NbBmT4ONegKN8gaMTIclv
	HtHsL8i2p00i6IYFALH3dA1d6vIIPMckyAU5A4gh9jhfsAgS419z3ZWnMU8hG
X-Google-Smtp-Source: AGHT+IHjFaoJnI8VGwUx0hIcpgJRko+5YMEjcOOsaHKRNKtqgaqGtvmJ5bzZ9us3ZjOZNYoMO+SnUg==
X-Received: by 2002:a05:6a20:1590:b0:233:d31d:25d9 with SMTP id adf61e73a8af0-23d7017bf64mr16597263637.21.1753673122645;
        Sun, 27 Jul 2025 20:25:22 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b2dccc8sm4307399b3a.101.2025.07.27.20.25.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Jul 2025 20:25:21 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] blame: remove parameter detailed in get_commit_info()
Date: Mon, 28 Jul 2025 11:25:15 +0800
Message-ID: <20250728032515.74742-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

