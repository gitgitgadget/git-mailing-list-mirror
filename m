Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CC42A7AF
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299594; cv=none; b=TfXA2qEGmNmXRYOYIV87GISySCQd46v83bDxFUO1B8AjKkrl0SRuSks07oWv5/PAK2YGgjbYmkpGJ1S2tNfpUdlsT4bPfVhMUP5e+gg93AXW2hcOfORUfHM8NouhFpAz2Nx0uJJQ5Oy6ltUd+xbZL7YbQDr2vPDdMAtdW85U1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299594; c=relaxed/simple;
	bh=siltPaVOVNuIdH3pgD9AofSPlxKybXiwXZkbynYq8jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZMWNw5CCn/wvvG6QBumXMMa2IBb29mWeu1WoHBagO2gLBxNrpxmpPR7/LIiJrysvzw5g2prxfSAQJvuZ7SObCpBxLMfkBV5klHxQgJ+Wo19YaQ2GP9Xsr3oOsXCdLn6WeiVewEmdkitZHwJGme5hlTtc1pyS1f1lXIU5vRL1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6D09czt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6D09czt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso7828469a91.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299592; x=1784904392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/joNRGbrXNpQv+kJ538PKivie1bA+98dHLnKEUJJNH4=;
        b=U6D09cztOEvo9VED9ycVmCzRne6XKMcJ7uC7XHS5MrksZiQGbGfHP52AUWDG8vhwJP
         GlrDaU/t1Vf0aoA0OmN01GbKTGu3gBsrtGn8zJXLeWcUAhaTc02K2GBNK7fGAcxViz6N
         JbvTv0g/dbMDGfRqypVAaMmKWYEzAfG/p/atBdURfq21A6b7+3xUGvHia7k1kB8zsdm5
         SvlyWS70khpKOyg0rLthc6D/MiPhGXfKyI0UgHI8l0KgeukSpWl3l9SI5OQqJOB22qg5
         G69B8zb3ydn2XoRimpXErxQ9AYpgUuiylZwAnOMC1pXwQfu/uMuaXbk8qr3gl+EucyQk
         PiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299592; x=1784904392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/joNRGbrXNpQv+kJ538PKivie1bA+98dHLnKEUJJNH4=;
        b=YdLS5TQj42tJNRM0EPDmefeBZKUrSPkYkFc3rWx9vZylbNib8u0Dwprfo626P0dM+O
         hp+ZwCGXEgFpme+5+FcC9C/g44tZcL6/VDrkZAt/OuKcTBPVr5qIoNqkeFEDMW4cefFb
         VDyobWlPAhAcVV3zafpSNDa2q0MIX0aR5fJvGTF47hzABASg6yhae8KUUuW1Zg4zIPK5
         4tK09iRZ8efv/xntXlsOZZhfRPNwuy1aJ36GJcsus3yPgVnbEF/G+degWVh3pST1Dwxn
         j8cECVIDBRTuD65MzEyycJ4xudaNISjdKM/TITDMD9tO1ElLsK64WdxzXHFSvs3ASh8H
         9MLA==
X-Gm-Message-State: AOJu0YyrcQR3uWH2WOocODBrVcczZai5jMeUbJhy9JQJBKVUtMN0VNAL
	S/5nZagjTRFcFnU/u7zZ5x4IqcFuSUxLJjQK4pjLk/RDlH00oWoEL6YNbkoMZ/le
X-Gm-Gg: AfdE7clvKs7n4nterIVLIhA++84Krqz0jLa0WMjnIIBnMGE1W9zzI/CUaMuWVnTFjYi
	Vb46POXGqPmVQ65JuHwR+yV9/4hbLYiAxCnu4agJmP19LFprAk/XlVmegSje6G9a1NOWLuOjSZU
	fkLpVwfb9qSX8TgwYZamJCi9W6Zgt9YXE79+i2IzynBG82UcSHRX14qzOjy1WL+LRXbJ5vpb/wF
	ka+V/HQunzNoW2IWCHZPme9ESrSYNJeAns/DqadtTjGNCAabOYXpG+okKhTBUFOo+PN1Jfcmoxe
	12MRMJodhdScSaE+ttfkozW+JH5DRmGgAgjTIM2dl8X3UkY9RYixlSTcM631tjr6GanziuLIBmt
	5zgSPmV5d7GFcSH0pd20ELcIsnpT6cjBM3VQNqvL9n4WrDWwJkNcU0wsyM5aKWqnce6mNCXQDq1
	YUcTkoXpI+uvv0WlimPtkzn05lFQ==
X-Received: by 2002:a17:90b:4c48:b0:387:e0cb:7f0 with SMTP id 98e67ed59e1d1-38e4b585ed3mr2908861a91.36.1784299592372;
        Fri, 17 Jul 2026 07:46:32 -0700 (PDT)
Received: from sahitya-07.tail6abcb.ts.net ([2401:4900:8fba:f9ce:cbbb:4c5:5b88:5b73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9b9dsm1190327a91.9.2026.07.17.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:31 -0700 (PDT)
From: Sahitya Chandra <sahityajb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	avarab@gmail.com,
	stolee@gmail.com,
	peff@peff.net,
	ps@pks.im,
	Sahitya Chandra <sahityajb@gmail.com>
Subject: [PATCH v2] wt-status: avoid repeated insertion for untracked paths
Date: Fri, 17 Jul 2026 20:16:20 +0530
Message-ID: <20260717144620.259031-1-sahityajb@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716185045.229320-1-sahityajb@gmail.com>
References: <20260716185045.229320-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt_status_collect_untracked() copies entries from dir.entries and
dir.ignored into string_lists using string_list_insert(). That keeps the
destination lists sorted and deduplicated, but makes the code harder to
reason about because it rebuilds sorted lists through repeated sorted
insertion.

Collect the entries with string_list_append() instead, then sort and
deduplicate each list once with string_list_sort_u(). This preserves the
sorted, duplicate-free result while making the collection strategy explicit.

Signed-off-by: Sahitya Chandra <sahityajb@gmail.com>
---
Changes since v1:
- Use string_list_sort_u() instead of open-coding sort plus deduplication.
- Reword the subject and commit message to avoid overclaiming an O(n^2)
  cost when the input from fill_directory() is already sorted.

 wt-status.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 58461e02f8..57772c7501 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -832,14 +832,16 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->untracked, ent->name);
+			string_list_append(&s->untracked, ent->name);
 	}
+	string_list_sort_u(&s->untracked, 0);
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
-			string_list_insert(&s->ignored, ent->name);
+			string_list_append(&s->ignored, ent->name);
 	}
+	string_list_sort_u(&s->ignored, 0);
 
 	dir_clear(&dir);
 

base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
-- 
2.43.0
