Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78036C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKHSmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiKHSmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02266C8C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so14654356ybf.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXvsqKgSINLop8HJijHfOtFPSIYo6zDFwIipieqNbTE=;
        b=iD5KhW5rHtiRzg+DFXB6YkpqAG+hXFgUMcqskDGF5fd2bWYzITwJRsoVr1IHVKUsBA
         btXyQAgcP0qR70vGALysvw6hHg1ByvK9Wk1sQehvqMvG/7Jdu8nUqOKplTHnH5rzOm6l
         HiJ36/hfOurB5kKImmEaRc3VIClSfcAIAfLP/dqohnOUfWxEsMzNP7tCMSkrdTq8dU7i
         E1cMr0AHnr506aAS++9CgMPtKj3jRorbHU+w739OhOsWcwT6iXCix4BtWfKLQ4vSimo+
         I0zUgJ5IL3cOzkGJ4ZijDpbKuG9d+DDfPBjxalhUCmBIx/N5oXdW+TdfgNTasbv7+jyx
         cStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXvsqKgSINLop8HJijHfOtFPSIYo6zDFwIipieqNbTE=;
        b=aHEIALwScdCJ0O5URhe2lmrg1lQQWoEsSsTQrWzU5mty8Yl0FsDLBz21ajA6Cw1/+k
         yVv8a89yOQO6zdhjizpxmrxYWyKVb4ZROCPCKbaX2nmHRZn45eOwHN1/CI9BREbmiGsh
         gUj7IcOXD8UQOqqpG7PkgJO6eDBOBbWkx3I8rhBJ/37IptCQ7oKaQbtG57uI+hMc6HpC
         tJm+R814hBCYbB1Kl8pBImEiFk0cu7wq+h/kwHm760KrVY0hBCz/1mlkwd2O1NpvStEw
         nYWvXmWLXd8KozhDYAgWKT6qZSTA2HIZbSJ4W5ha6LYyPF6B4zD5GlCp7lvNF8tw6xhY
         AUpg==
X-Gm-Message-State: ACrzQf2OQ/81RnArfG8I+LBJ610E28iWx2YvsuESn2Vs2GRkVu3Zqnxo
        2WsiNph2AkJ1minjRQFlTVnIpdsqrgBMpe/5oez87t5I32izAyusC/uVk/VoM9/YpjHjQq1Cbqj
        1NBWToXCP/AGUQBMgacfsRqelZM3dRy0fUyKBrzcrY2c5LcY3mYKAUEFj5CurjAJ+gA==
X-Google-Smtp-Source: AMsMyM5g9vhyU8Msk6FD0RliVBAgpfhY4XNsgrl13mtg4Ldw/M10/VgUtxv4UjzzKHh3rITfUlbYZERUJgLFybA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:4d5:0:b0:370:b2b:c52a with SMTP id
 204-20020a8104d5000000b003700b2bc52amr999972ywe.342.1667932942136; Tue, 08
 Nov 2022 10:42:22 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:41:58 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-4-calvinwan@google.com>
Subject: [PATCH v4 3/5] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index 31ee53bd57..fd3385620c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1864,6 +1864,45 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int parse_status_porcelain(char *str, size_t len,
+				  unsigned *dirty_submodule,
+				  int ignore_untracked)
+{
+	/* regular untracked files */
+	if (str[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (str[0] == 'u' ||
+	    str[0] == '1' ||
+	    str[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (len < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+			    str);
+
+		if (str[5] == 'S' && str[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (str[0] == 'u' ||
+		    str[0] == '2' ||
+		    memcmp(str + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+	    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	     ignore_untracked)) {
+		/*
+		* We're not interested in any further information from
+		* the child any more, neither output nor its exit code.
+		*/
+		return 1;
+	}
+	return 0;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1903,39 +1942,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		char *str = buf.buf;
 		const size_t len = buf.len;
 
-		/* regular untracked files */
-		if (str[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (str[0] == 'u' ||
-		    str[0] == '1' ||
-		    str[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    str);
-
-			if (str[5] == 'S' && str[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (str[0] == 'u' ||
-			    str[0] == '2' ||
-			    memcmp(str + 5, "S..U", 4))
-				/* other change */
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked)) {
-			/*
-			 * We're not interested in any further information from
-			 * the child any more, neither output nor its exit code.
-			 */
-			ignore_cp_exit_code = 1;
+		ignore_cp_exit_code = parse_status_porcelain(str, len, &dirty_submodule,
+							     ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.38.1.431.g37b22c650d-goog

