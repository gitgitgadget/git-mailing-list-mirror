Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F161F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeCCLkU (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37986 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCCLkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:40:19 -0500
Received: by mail-pg0-f68.google.com with SMTP id l24so4866227pgc.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aAdJmP4bdYYhm+Ai8+N0itCzyhi7vsg8namNdhgiK4=;
        b=albTjqTxeSfGNuox+bvU8mpsgeaQDX8disLnTe4wXBQWU0I6fGy7zXXozPqVOLtF/D
         rMK1XTMVvSja0IKKlOm8G4eo/Iivws12j0+l40OkSVCVsAgAvB8cOyE7zJKF+GOR/LB/
         R7bV/xvFiFgmOAEnvHDQ0icpkBz3Tsu31L7TZlS9y1uDnFY7RwQu8Mu/YL1ccJCvh2Rp
         cr+Xo6KtoysTuiPI3OZKThq+Buf37nYmdfypmqYWJkA+iCdbqWhnsddz8PPIUzIEOQsy
         IWNbqbpl5oZeW49huVmLf+9eeDEGrLpxLy3Ql+fo5ZSV8cAPsueFdhwTIqvoVJxt+6iF
         xXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aAdJmP4bdYYhm+Ai8+N0itCzyhi7vsg8namNdhgiK4=;
        b=EuvBsMbJ3d3IKrXM2bHvMhQXLNdIPecLTGYViotHAIDxwnSpla48STrnEJCyDQiYcC
         p00xJiFpbam0ZwR7ddUQCZvO5JtJvDIrJNnJBlFCtEBTCDcAP/oCC+A5ZDU2QW/wd19R
         /zlF7YDxdfEXsln0n3ONjhUryObQ6nKTRvbH4TstDRn78Bsj9d2LazCg240qLheRekbi
         sbBtz8lBIIrAijB6WiYGz7KdVx2UEzmCVwKZHm61IOz+SLtBc5O9VA9Wuw6WoiCz3R/E
         5glkGNaVq/S1mZnn2LFFI+1a45eSxi8EsndrS6NztNqOEKovu+L08h30QLp1RhqV+06G
         nCaA==
X-Gm-Message-State: APf1xPApGH/TTqSJpU1hxE4Ide5pMLOdl3E0Ee21P5jDsrf+vKLjlZsS
        gfbizEYAO7nnZQ+f26wrgHokXA==
X-Google-Smtp-Source: AG47ELt4Oj0Wx5rafQry8xWx9M8quGFJqqN/AmwZzPiEb5TFgH4GR5Mtun01qh0ndWEu2VSXzDWS8Q==
X-Received: by 10.98.36.217 with SMTP id k86mr8809284pfk.137.1520077218453;
        Sat, 03 Mar 2018 03:40:18 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e23sm16613492pfi.76.2018.03.03.03.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:40:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:40:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 43/44] packfile: allow find_pack_entry to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:36 +0700
Message-Id: <20180303113637.26518-44-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 11 +++++------
 packfile.h |  3 +--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7388debbb2..bafe81544d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1844,19 +1844,18 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git(the_repository);
-	if (!the_repository->objects.packed_git)
+	prepare_packed_git(r);
+	if (!r->objects.packed_git)
 		return 0;
 
-	list_for_each(pos, &the_repository->objects.packed_git_mru) {
+	list_for_each(pos, &r->objects.packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(sha1, e, p)) {
-			list_move(&p->mru,
-				  &the_repository->objects.packed_git_mru);
+			list_move(&p->mru, &r->objects.packed_git_mru);
 			return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index e68f790ea7..fe1a6380e6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -127,8 +127,7 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
-extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
+extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
-- 
2.16.1.435.g8f24da2e1a

