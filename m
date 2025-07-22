Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A92417C8
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184557; cv=none; b=XTuSEOkRUN1XFYGY1Xy9FK0CHamicBmSaXmLgaYA/Cb1ilXqhY5PhLBhtoJy/McBCAHYdfkrnC10f7gqNWwgmDOp/DKcGJFSng7A8JQXevinB1qWlmJ6K0wGPHNPOS9/sFl+/ilZG2Prt4P1lsL7JBHeKtnBvzTHEnIPPttlmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184557; c=relaxed/simple;
	bh=RLpU7U6Lw2Pn49/b/3OH89PMYXwGEOmMJwWL17P88tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRZKXr1b3+X08ZpsO2SkCxMuWtuRnDyzjL5QgRDUMq/xMU+U97kNlWKzyLFamuGhDOlMVbNBrhkeBBMfKZoqTmh53/QLShuyGgDDNh8kz/9z0l5cWS0lZTKeZ4m3iPBFww1ErUAZ4Su+hwWL06Tvhi08w3T0aa2YUOt9BhpA9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e7c7BWt7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e7c7BWt7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23e210ebd5dso45739515ad.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753184554; x=1753789354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdwuSTUqZK2APyvcQSQviMjH2zfpcbI7+PKAV/RuaxE=;
        b=e7c7BWt7Sixobb2PD6Czivz1cjucPpbkBClc7KZW+ujkhsat50b35aCrCMpL2b7HbB
         va/SypwlmIfzhO8gVON9MYkYQH25tkCYnohE1rYO2nyZcuxU5ddnT3z0YRC0pFprEWHM
         NvN76uArLNr/Wqo/RUbPbmL8i7Jh2hWyc7H++zHnMayjWci5dTqogRV2tAhT8+ClWQoy
         Orr86IzbH6WycYpoeHnYoG2oV+bdXl9Z3LrBdPZG/gbd5uPEJ2DPx4UawVB6ynlMNwDG
         wSrUzWufMKM5Xuvp4Ge4pFpjCN+WTIFyLh6Ffc6Uj3V//nv9HzHzfY3dhZsZ384LO1Ic
         c1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184554; x=1753789354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdwuSTUqZK2APyvcQSQviMjH2zfpcbI7+PKAV/RuaxE=;
        b=KaULH9LO6RXENDMOc5kwBQrTOg7qIWWW/8lvQ8+Kl52Qir9YgzQMBAY+PAQx24TKp/
         Hteqej7aOaDadlbMqdgSxqaEhRnyw5f2xJ6bG+W1Xqk1p13lRMEwd6VX27HUfjZq8of3
         ZJFtFe7nO++rQda5Pp/C//2HFklzUSAwSekSZDQVHrlSmIA5hXlbajy+itJpL9WjdI2b
         As9W9Q4rk0xXFdXO+7rf3eX3gx1OjGFoJrdoV1zDMd4XS6tRtDMSYxJSnxSNmEuFMfMf
         0cH48lfI6to+2fv2ItaSeT0PGnTOl1KLCDzPD1hCLYVtgEmO87xrGssRUdNPTT9lHfL0
         s6eQ==
X-Gm-Message-State: AOJu0YymwaWq8Poz4UObVoOfI3sNVW7I8F6lUjMoaMP2aJPl1A5Kn59j
	15Sn+wdjRANPMY0ZBPGrSWntRgn2qn10t2sYuNZdJO+6Q2ajVPqSc3KmmUhwIOyOtZClE0Qp9Mw
	z0XO4
X-Gm-Gg: ASbGncuvYNdpTHfuZpwAIeNUJDGXOtV/1EzkeeBeVret78jPj1FGzc+GILAJaS/AHfJ
	sqK6N7lw2LXpieJiPjiOGWMPAANPlU+Ee0xB3Rvm0G0WwSsqLCgcaYly4oCezhttRTkYDK/4rgU
	OKaBCxT4ba3EFsywr5hDF3yUM9cDR1/a2OaGsNfElwlaLlj5dOTDFsixw05M8qnF6oTlxKGBZhG
	5T5rI/2aEgBNpfNtFt+EceaDJqk8KMEYk5nWC4ue31tjfIYeq0UKr0+rLYsXbA1avN1G5xZhjAe
	CKUnebbn8O53bjQ6frKFz2Kb+eOPUjQqDX2W+n3fuk6Y+cbRD8e1pglsr/dBOepcnA/hGfYa4jQ
	0btCzHKHsulUUJfOO8uHca+TF3+YX5+ouPAEHURLNkWNTLyBGpv+xVf2sVObXBX/4aH2tjw==
X-Google-Smtp-Source: AGHT+IEcwEE1xxzArmzMpqoKDTgstw27kNT9NUl4DTKY/1YGl9EVTcjAtsOdJTfDXOmSdq7ISUGw6Q==
X-Received: by 2002:a17:902:ebcb:b0:237:e753:1808 with SMTP id d9443c01a7336-23f8accd820mr45163295ad.20.1753184553645;
        Tue, 22 Jul 2025 04:42:33 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4949sm74289815ad.122.2025.07.22.04.42.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 04:42:33 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] blame: only parse detailed commit info if needed
Date: Tue, 22 Jul 2025 19:42:20 +0800
Message-ID: <20250722114220.87570-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit cee7f245d (git-pickaxe: blame rewritten., 2006-10-19),
The function get_commit_info can terminate commit parsing early if only
the author information is needed. This ability is not used by callers
who do not require detailed commit information. Stop requesting detailed
commit information for these callers.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 builtin/blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 91586e685..b6a38e530 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -471,7 +471,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 	const char *default_color = NULL, *color = NULL, *reset = NULL;
 
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(suspect->commit, &ci, 0);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
@@ -665,7 +665,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			struct commit_info ci = COMMIT_INFO_INIT;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(suspect->commit, &ci, 1);
+			get_commit_info(suspect->commit, &ci, 0);
 			if (*option & OUTPUT_SHOW_EMAIL)
 				num = utf8_strwidth(ci.author_mail.buf);
 			else
-- 
2.50.1.321.gea4e667e7

