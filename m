Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FCC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjBGSSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBGSRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97583D080
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q133-20020a25d98b000000b0089ab1a9f0fdso5973294ybg.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcCDJ/9InDiBfm3IVYXcLEw2c7g9o9VhW+yu1jBDgF0=;
        b=XINfUpgxlb7xYljqJyK6pZRvLj0USdtSA2nfKtCkBUWfn+v5url1e7WHO3zFHkfk6a
         Cj7M8AqiWUoPuwe2ykMnEUFaw9rP3qJjFTXRYxF7zjoLhXO2R9i9YaRFjnu4X9Ml1Xmw
         8qdoGcIFgoaM0f82vPEra5X0SyUq44kTpX+zl5+FWORa+dBekrzTcecfcTkYDGuL/J/x
         hRnu7SyPpI4DNSWNe8gE+Db9aS9+YTcQxAO1Ig/BCqOsdia62fpAzMxALMnfmozSWDra
         IcExwDKqh5Oo+VAYdOLly1JGhHr1dpTsgAkbl1oiTCP0Mv7P0mt40qqmUbzEBVKPwAHa
         EGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcCDJ/9InDiBfm3IVYXcLEw2c7g9o9VhW+yu1jBDgF0=;
        b=wvOyNJoWGUE9mLAWar4H8Ef9jAByRAZLEMRAHA8ZGKhz9gGGQf15p3Kqqh7HW9MUy2
         vUZKSjFzvXgG3cuSYMlHiw0ckbkdOpugWLIL5cpAnonZ2jPYEjmkDCvoNsWr+RaeSJRY
         wrrnIzGLHWszEe4Wxj8Gi4lWfS5DWaNg8UCfVzhrPOUys2EPrVgJ1SL3qKm4qgos+IHh
         p9buqLVykWfyKPozo6WpojliZgtKk63Zcbb0oPduMKj+NECszq5wLevzQ2p0eU3f/Ia1
         4Cu6/6LT4LYkoO1gxy8idfN4Oyr++TK48fTQvWoe2RuGuezw1udGC8px3EMBnhMgXV/d
         SlxA==
X-Gm-Message-State: AO0yUKWlkzywB376uA6KOYrbsEkxRxEDjsVfPwxYMfKUKwDEFAxxwPTm
        dkWGQH/fjADDu3E5xmONJQmfWrS0y2f419T4MfFnZG7SKZMq93eMwGqG3ohGYLrEqUa0mrP9v0f
        o9kHtrfW1BC/ufPlf4Gp/ZlF5dSUFq/jWpOqyFfOxBfu/Sb/rmFSpG6zSqxRBFaD12A==
X-Google-Smtp-Source: AK7set9PQyEL9U2mmPK6KITBOFAM5DMEN01xKmkP+1YiZ1y60X/1Upz2WEgR7fVWROsFUOx51wRnkoO2tvwfXlM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:3d0:b0:837:b2e9:9cfc with SMTP
 id g16-20020a05690203d000b00837b2e99cfcmr445764ybs.637.1675793840532; Tue, 07
 Feb 2023 10:17:20 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:02 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-4-calvinwan@google.com>
Subject: [PATCH v7 3/7] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
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
index faf37c1101..768d4b4cd7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1870,6 +1870,45 @@ int fetch_submodules(struct repository *r,
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
@@ -1909,39 +1948,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
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
2.39.1.519.gcb327c4b5f-goog

