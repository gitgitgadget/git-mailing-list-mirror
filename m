Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CF3B05B4
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684445; cv=none; b=P0UmA9H14UhtPot1tWnuGhMtI99O0aAXMWJi9G+rVvyn0x99bxi+mc32HpTIF+RAKLg22zxofcX2IJuWCDOmPrb9poW+5I2RxkCiKdTQ9leEeIaf6/5VX761owW/LRuG8g8Oz53VoV8e6ErY/LSXKhn4esv8P+iXt9gYCq4yNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684445; c=relaxed/simple;
	bh=iFbATzSByS4KoIJ6R3JC3mwPeXjTvZGPjWJO7e/f3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIChRLtZRpRXHv4D280JDZv3/E4CEKlIBqfItF/L+GDD+e6DIRegOOLyiUz4nfNqk1/IBDELpiZTk4iG4QmsU4o2EXQLweYBQywLmtd5yGRjp5M9ZWYcNol0a4E+VEjMS6lNQUdC846B1yGWW1imgXvV+F3IT5/cr7yvd5x3f/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5LlcaCw; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5LlcaCw"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f4b7091dso2116126d50.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684442; x=1791289242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCGeIqksKzJu6jJVXbC95dqQk36fJrk333bHNaB1ODc=;
        b=e5LlcaCwcbfSCritw5OfuL2vC+AYDZ43SGPBeBAZiNoHYG4xRVRINhBUHCoweaMwQB
         CN64f8uHlUivE6b9FyP+9N8CPvB5ciI27WSyClwQ0dRFq0Hg8n0Gu/N1rwatz2Xv81jD
         DxO0qxI4GfgO8lei2H9xGfUDjJLp/SUqo2njsnsDJrsYESVKtSC8kLE+4NKCeO0lZrA0
         l9LVlhVjg8bsiAK4TyBRF5BE0HBXa9pDTC5jU/IdNVzqYGczndj4JmFM7FYGab1KMLde
         2+KiqAyC5yNNOBNEWpgMgcURy8V2F2tqZAvi4GT8Ez5cImdE1gXfHAVdXNub3Jxfu8Rw
         Kg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684442; x=1791289242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCGeIqksKzJu6jJVXbC95dqQk36fJrk333bHNaB1ODc=;
        b=HSDnKrWSx+g79610fynuuTqIHh6FWhu78U7dQYTSiK8m1Sf3RUURv58Vr47rPXkEkF
         J/ndrDOxcXRB9gLP+JNWXywTKRAQbjwfs/E/FmjCn3V0exGrQ732rtAC8NZg2BZOrYA3
         hpDFg9X01oDK1Jig0eCOP6UZcTsB6W1X4vi0MjYuacADPFyYrIhwK9+e+n4OvMjFbHne
         2vo9WepqdmblMnmn0HMFPkUltI/QJy/snCDg9nYwUHC2pa1A0kcUsMSpKHZ7IgXEFWlL
         mThzbEdJuT8BiSVHXGWAGB4NWnie0Qr9TI/6Kp27N5B/wevQZ3y/SyfTe9Zfcq0DeDIF
         psMg==
X-Gm-Message-State: AFuF++lkD/igvzQsiDvRSdlXQZWORqFhnHHir6dtvPLW++2cmGB3J8do
	3Wpk0bobEpTXXH5kx16SJSTjqiXRm6PD3Z4rsGJfSvPCTE0KIWyus2TyL8ahOgYy
X-Gm-Gg: AYBFou206r0sBZGE3kFz/HHDZdpEpFCEh90AXeW710D/XUO7zi8IgoM+aKSUq54zT1I
	NHyR0sybZjUtpShYbEl/RTixH4qiGumVJSmfA3lczmIh/+5vyNWT2pIeO26h+0e0gLSxVQ1S+YQ
	XpvhtmMKv/e17591GlKVyk9hCXJjKCp+wH1FdWNZUFlXTCNOWMHYoh1tlC0P5QBYyL/INbsUyo/
	sGR/D8zbv/VuDTr8I5g5nEFlzbbE6ZTRw8ntxS3IskHRiVb1s4icom+Lm9ejZHaSRaAbkRzssF+
	lHULX83Y1sMIATgTTryQ9kXB0KslpqW4vSPlCPPxBHdryPXDPnJg0OAtD/y/lOZYUdQ0B5GxEM+
	DuIDKz4Q5iAo8xv5djGefWU9d9i69gWzkJG1s6DhugOTpfufQulrN7imHGPvloFJWoMmkO5L0YO
	EmMSsDCorZphIbgwr+Z8PlpAvO8vHjnvq2lQM6A5Y4SttXe85plzFUdee9ECHcXNVKoWbeN3Cv8
	lE6/85ESfgePtYgsATqtcCy+TxMGiY0aC8w9ILvBHJitaYjJEI6xH8C/2f7tRg1fuCdOaklUNSK
	PR4uI0ylwgizQt2/4dpmdA==
X-Received: by 2002:a53:c045:0:10b0:675:5fef:4d0b with SMTP id 956f58d0204a3-67560b04cabmr642171d50.49.1790684442363;
        Tue, 29 Sep 2026 05:20:42 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:41 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Antonin Delpeuch <antonin@delpeuch.eu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/5] stash: prepare merge options earlier
Date: Tue, 29 Sep 2026 08:18:28 -0400
Message-ID: <35b64ae3217629498ea19c1285edfeb32c5cb53d.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we will reuse these options for the index merge of
"apply --index", not just for the worktree.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dfea2d2c4c..d2b736d4e6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -664,6 +664,11 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
+	init_ui_merge_options(&o, the_repository);
+
+	if (quiet)
+		o.verbosity = 0;
+
 	if (index) {
 		if (oideq(&info->b_tree, &info->i_tree) ||
 		    oideq(&c_tree, &info->i_tree)) {
@@ -695,8 +700,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		}
 	}
 
-	init_ui_merge_options(&o, the_repository);
-
 	o.branch1 = label_ours ? label_ours : "Updated upstream";
 	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
 	o.ancestor = label_base ? label_base : "Stash base";
@@ -704,9 +707,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
 
-	if (quiet)
-		o.verbosity = 0;
-
 	if (o.verbosity >= 3)
 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
 
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

