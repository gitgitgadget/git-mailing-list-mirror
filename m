From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 43/44] builtin/apply: add a cli option for be_silent
Date: Fri, 10 Jun 2016 22:11:17 +0200
Message-ID: <20160610201118.13813-44-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnc-0003vF-5p
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbcFJUMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34646 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597AbcFJUMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so1058713wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sAz3d4kOgcwSm+4e2f7oFqZSj+hKAJXYgSrBVLgFrRI=;
        b=ooXu5hwn61IUj6p+3oWD3ifKHbbdjnkFQTTtDoTh1sh6tIZ/O2XfyDbMF8ujssibti
         aZffv2tnIoowUDM4AV7GwI/uuLvqkdf0UayiuHN5eCMkpl8bWEdv2GABnSlzSjVxiE6x
         OnxUWj1mGstR4Ji/J1woRJRSRtp6MzA7j/zuXIaT/Csy4zd+bah1lVk+PnFYwXWZgxFC
         6LrYu5wD0aEpEOEXGsFgWroa3NViPx40Wg63Jn303xVztyeNJu/sULH7rRZ1NIsqhwWW
         SPS1AJt73JdYKBWjt2pR4nsRK1zLHNpq1du9QoCj3DRTLtsKpGxO0sJkELWcMi2MU1sQ
         l32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sAz3d4kOgcwSm+4e2f7oFqZSj+hKAJXYgSrBVLgFrRI=;
        b=EvWYupAWNU/cMavZQKuTNhlC60maC2CE2SrKhER2wGN1fyV4k56zXdjzOwmsR2biBC
         6PG77+UFSYmeX/qpV48PjrspJEczmIETthWrBV+ig9mLAho4sdo3U3TqBBmv9ccrUH2N
         fl6zWpRRqOitmo7JckquXbARThkT4i/TRBrdxGlZy1dWZryogqIRtjcU0N+8FELmQz9T
         5OTnuVjmXLxawZ90ltG3Tpr/GM2cvsrUCB40Y9FBXRFkj9BL3nCwrE4LAPQdMJie8l7L
         6O2ag+s2pyJgryHnPcUe8E9kmS/+vPv6qzLb7ruHObvpCtRoKaT6t8IGuzh+zzwJuTBU
         IkAA==
X-Gm-Message-State: ALyK8tJFvOGKKUJct1lEYcopk7E1hcRrGj5DdQXByw9pBz1nOkpWuSRmp1YIeuX51mn4YQ==
X-Received: by 10.28.230.200 with SMTP id e69mr657114wmi.53.1465589569418;
        Fri, 10 Jun 2016 13:12:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297046>

Let's make it possible to request a silent operation on the
command line.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index ddd61de..93744f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -74,6 +74,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
+		OPT_BOOL(0, "silent", &state.be_silent,
+			N_("do not print any output")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.9.0.rc2.362.g3cd93d0
