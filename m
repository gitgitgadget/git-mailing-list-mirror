Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA943C04D
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918202; cv=none; b=SJ061mjFogNdS0CUjA6o8ylxU8eWTbZbotixv9H7s8fWCVeJolLVrPqAJnjH2zv7P01dfWLKBPUpGf1PmEj9VXV9mR10806eEbzlmrbXLsdxqe9gEOA74XOsFVUhTUBDAs5VVlBGKsTBP40VF+UybBn2VKeI6lqjxz7ijnoRayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918202; c=relaxed/simple;
	bh=HwfEI86CdCU2fzCxXw6ReS8x5fHgrtWaB3/WRbC3JZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpM4kCBoYxQB8gwvCCJh2Eo6CeCf/4QquB162LZ0J7BTcWaTVFgs1860aeVWkCoeE61Aqf8y40MK3VguLLauPXOgtfvBRiza1XZ4RuxhxChmWxs1oDIFdZAuTr0AXx8fNdHLfAITTCR40V76TJwTV0q2HK4Dp3ePcIh///D4JEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX5cPygd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX5cPygd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so3481953a12.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768918200; x=1769523000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S4lG8zkSZ1REK7yqCW3O4vsIKK2s45KOtnWETsqvQ8=;
        b=IX5cPygdLW4Z7V2P90OAi/uRcmNKR66of2t2XNXfnCDDe9PE1BhD/vuxEIkGlNaIFj
         XZczmzOo6CEwsTam6R/pB0DoWcM71rQO0bRSEGGEVmUj/ZcnZxYjmLStcz8GssFSNnqE
         8qVKc3AoT7Zx5ZjKEq6Rmy1boD6sZybRZa7MMUnxuDaSp5XwWJgD5TFEQFFhHR5W5OaA
         O5NL50TrVhch4JbHA8073Ezs4M6q00OPskLAV/gGOJbVIYbwxbWwN+GspCZR5DxsoWf3
         GT6shJy1Y1uaPMRf9zmHPKnFtR21sAeQ6QxE+81EcieLosXm3w2oQ0JrzHynA2Qj3J9r
         GRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918200; x=1769523000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7S4lG8zkSZ1REK7yqCW3O4vsIKK2s45KOtnWETsqvQ8=;
        b=J7h+8TpweZqi2Ozqn0426ZWQNIFP7rG+dZNVkwm/ZUTGCeZyb+PwGBPuYctaHsv4M9
         70ALuBNoK0llK94aF0XbSfRTcrqNaHu7hLwDeRYyEYmVrQEj2VR14QaFgzMj2o4tuK+C
         GMsGiFq1UMLB9i3IS1T8tNknaqD2MVjKjxZr/wL9WNw2CGuNzMxDYredrPESt5Qh1A7Z
         wsEP51gQ1FLKAuoqPhGRwwHxL0wkVTlTDBKuHC0z2lA2fCWH2cVh0bIdKGUyB6XGjG7i
         ChXabufB+Ch9VYL2NAAZMOMRqMJgZqSnqj+xDhvTr13WJS2zvce++X4xr3ShYsFAJbh+
         XoHQ==
X-Gm-Message-State: AOJu0YwtFBO5iYUPtSjrNjPNXK2rAu368iBfx7NmJFbGyNZa6I8vn9zj
	BnlRSOJ1i6cB5t5qDmdu141u/DV123xwG8YI1QKQyZ4VZbkHA1HLAZzuwIgKag==
X-Gm-Gg: AZuq6aJsGhzCNsSezo/TT3sLrihMfx0w/cY21mHuJFcJ3OqsTZnnGAGiuUeTaafogxh
	IvMvuRCKG89AeVpEPzCcHTGWCdkq4f/+sFuTCtM3uKtLeWofrANbvD23upvlj4THU367ogw0crV
	iDDNvoUWjxeAm17jtGAwPoPI2+UWWWcRtz438Z28KF4oqHuKe1hklZEO0eGNqgpy7q6ZrMpxAxO
	7EXo4LRuvN4FMZJc+YBRvWWIacgMSV+UhRkomdH2lNbghg9BNi4mjcW7q4dWaCD55kZJWffFN5S
	fkM9HRDZQzL8aVfseSxC6c9l+JhuVUflGWS9wEKt9YtH5zvWjGJex6WlcwV5+/dlpGNkERqk4rL
	fveViH35MKNDUvpZzgwtEbdYnIq7dzPiVsAmrf6hSoi2bd5u/qayqbrwrbLxBNl/JlSOX/+MH2E
	kLJjLKk/qFdvik8xQfD61oRIyqDVXtHg12U8jPDWfeZlu35Q==
X-Received: by 2002:a17:90b:2fc4:b0:34a:4cc0:9e38 with SMTP id 98e67ed59e1d1-352c3ea74bbmr1711397a91.10.1768918200400;
        Tue, 20 Jan 2026 06:10:00 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:2062:a538:8b6f:d4b5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d5a3ea3dsm1362250a91.3.2026.01.20.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:10:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 2/3] show-index: use gettext wrapping in error messages
Date: Tue, 20 Jan 2026 19:35:40 +0530
Message-ID: <20260120140901.517928-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, error messages were passed directly to die().
As suggested by the Git coding guidelines, wrap user-visible strings
in the _() macro so they can be translated.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index be62edc57b..a9c2f18b73 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -41,23 +41,23 @@ int cmd_show_index(int argc,
 	}
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
-		die("unable to read header");
+		die(_("unable to read header"));
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
 		if (version < 2 || version > 2)
-			die("unknown index version");
+			die(_("unknown index version"));
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	} else {
 		version = 1;
 		if (fread(&top_index[2], 254 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	}
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
 		if (n < nr)
-			die("corrupt index file");
+			die(_("corrupt index file"));
 		nr = n;
 	}
 
@@ -99,7 +99,7 @@ int cmd_show_index(int argc,
 			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
 
 			if (fread(entry, 4 + hashsz, 1, stdin) != 1)
-				die("unable to read entry %u/%u", i, nr);
+				die(_("unable to read entry %u/%u"), i, nr);
 			offset = ntohl(entry[0]);
 			printf("%u %s\n", offset, hash_to_hex((void *)(entry+1)));
 		}
@@ -113,15 +113,15 @@ int cmd_show_index(int argc,
 		ALLOC_ARRAY(entries, nr);
 		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
-				die("unable to read sha1 %u/%u", i, nr);
+				die(_("unable to read sha1 %u/%u"), i, nr);
 			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
 		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
-				die("unable to read crc %u/%u", i, nr);
+				die(_("unable to read crc %u/%u"), i, nr);
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].off, 4, 1, stdin) != 1)
-				die("unable to read 32b offset %u/%u", i, nr);
+				die(_("unable to read 32b offset %u/%u"), i, nr);
 		for (i = 0; i < nr; i++) {
 			uint64_t offset;
 			uint32_t off = ntohl(entries[i].off);
@@ -130,9 +130,9 @@ int cmd_show_index(int argc,
 			} else {
 				uint32_t off64[2];
 				if ((off & 0x7fffffff) != off64_nr)
-					die("inconsistent 64b offset index");
+					die(_("inconsistent 64b offset index"));
 				if (fread(off64, 8, 1, stdin) != 1)
-					die("unable to read 64b offset %u", off64_nr);
+					die(_("unable to read 64b offset %u"), off64_nr);
 				offset = (((uint64_t)ntohl(off64[0])) << 32) |
 						     ntohl(off64[1]);
 				off64_nr++;
-- 
2.52.0

