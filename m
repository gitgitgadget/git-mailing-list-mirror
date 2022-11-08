Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C00C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiKHSma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiKHSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6402181B
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id c1-20020a170902d48100b0018723580343so11794161plg.15
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2R3o2Am0MFayMeKl5FASeV6fHInGYw140p84pmEosA=;
        b=bSXrv+7fV0JVca2F4NOvkHxRE8Tq59OSO2efBKkl6xW8NDqxXMHp8QVittCzh8g3i+
         een58+0whrMsY8gLCMommFGS28TR04jR5hKpkrQnhdS7IiWeVA7PgCiGL/u65+VGZv1l
         5Nw1Z0m8EAkNGUMa18y4IMgFKn4loVPj7/fPVYfIu4F7u3eICS6DDqeNVj/0mzLHAAXp
         AX3yCclDsMDoXb8NWP5e0DfE95c1JhJ/zebIe+tri01JPkvQ0fshwqPo1+YxrZ5TJAtC
         7EximOB38P+jdH2dRYuTT4YkNW/X7ShfgeZWj2KE7RDASQqRDOuqN5Y2Q4JPbBT/N+hk
         FCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2R3o2Am0MFayMeKl5FASeV6fHInGYw140p84pmEosA=;
        b=4UyR+2XbzSqnaA31/NTx5ZE2t1K1oWQ6xZIwm3t4mp2GjdBThIdHKshWNZLrcbpmCg
         WWGBZe78R6Ivd8Ij2V9dBMvTdvzN624IT8n+6j+59SjFggShS8PMBfQIaIhBzipqMHNa
         fIbGgfI6Bpu6RYZHPtE/BBTjkKuJc14KjsSpHrCJC3DOwq8bFIPdHF2rKIwRS6ysy8Dy
         E7eedSHmSROZGdmF9Z7Ntu3Uvf19JafBfef5B7CPiCRK1CxSlo5vyoA6t8B6g9rEbTfa
         7EHi1CHcO9Pqko0TWhW10dDUZ1KODhly2pUbNLBvay+zXMPJ64LDyiP/TsilNaxHHwyH
         ki2w==
X-Gm-Message-State: ACrzQf0XkGUIusFIQkY/kY1iHtiG/iilJYA5afqmP7rC2psxhA9I4rDR
        7o2xL1J6scdTrbZXftWDD7Y63ytN6fk/7E2ove9M76bmHXv3GJWbOybT/U6TJA2W4TDDu2h9dT1
        NNMvcqE3GHA32RV+gJxRfMurvwAAy161jp0V06baM/yUPMzIHIfVrsFfhbvKLx23rmQ==
X-Google-Smtp-Source: AMsMyM4Jbp22DoA3GTt3GLvtEtFlE0TOUSkOT9wxSw2CJqiIO5Y12vVf9bavISaYv165vFYadwvgh2dFZ7weSl0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:22d2:b0:187:1f4a:6593 with SMTP
 id y18-20020a17090322d200b001871f4a6593mr49539614plg.138.1667932940685; Tue,
 08 Nov 2022 10:42:20 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:41:57 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-3-calvinwan@google.com>
Subject: [PATCH v4 2/5] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index b958162d28..31ee53bd57 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1900,25 +1900,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.38.1.431.g37b22c650d-goog

