Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526BC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJTX0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:58 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2878129741
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:55 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id a22-20020a0568300b9600b0065c0cef3662so610180otv.14
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCueAvPmcQ8WV8lVsi1yzTc2SSQu9FZapWvIkvQekMM=;
        b=sptY6Qdrow5qD36MkeFUjM9CpYV8GleDvFRFrDLR8U42HDBEGaPzGKB3uCMqcrmnNb
         tYXkBZscNjDN07s15qNQyN6vzZ9qxP4f5qbeNuT1YcJKd+8Kbaj0s9oEjkbg+qXt0AzF
         4ut/7c9JYkOXRNSbpwGfCdaGsZIicsRcJbBrzuP5F7Zk3NKYT2wapbFrIi0NGeGVi9kk
         S+rXgBDi5EUwxUrgSKpA3P2VIiiw0HFx0kPjn0Ez5pFR8KLjKGex5WPMPSFVuY0TOyEW
         486mF2KsU4XlmY3bBAmhKygQ4B/o2hibsDNgJ+ANPXVJTBoJSjAQhNuB+8Q094LZi+Q7
         bn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCueAvPmcQ8WV8lVsi1yzTc2SSQu9FZapWvIkvQekMM=;
        b=GqfuryyjlzYgSylbT0I6/ICJn10gOsxe2cWEuv0Quz7gTRCgtVGD1+qn1+V7aOsCwR
         ML2dLfLashJ1sqhrlDyd3goTFpzI8yKqv2knTDiCq7Ub/2ake6NiFO3UVAs312Fr1AnL
         vSYbqWeuDrMj5+N1dwslmKNw26/3UVinXSOTOOjBUfLD+iMBvPOVvRxyvFgNPxo8ea6B
         Du/yNWco3eYLfE3Abm20YllB8M1P6D69XsIpG9m78mtCa9f2Qg1y6GHYmGbWUSbTM8ss
         Q931ffNIHDBsW4EyVhU49wBYI/fqAWHEkgvzIG11DJk3Q6c1ZadUflziJhgDB4VEnvdb
         0xfg==
X-Gm-Message-State: ACrzQf3M/R+WbMiT72LBjksLABC5FP1zJGz7mfYB2mtvxlRGI50qmIfN
        +OghWvTG/gDn45aDAS4SAzk2NpwaiClutljeMdAKflBOjWwg7ENDpP6sbPcLAvL51hCbGgfiH3s
        i+TXl/DCIEYisWvLfZcS2raS9PrFAoPSXcJdBz5TQOn2Qef/dYPxDz3zKEoG7KkafAA==
X-Google-Smtp-Source: AMsMyM4ZFY5HAx+EjwQ23abqGLko4zGRmqI7LNOiHZASiKHI5e37mwdeyTPfE6ohI9fdBiQmvFI7Dz5YjpkrhNg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6870:558d:b0:136:60bd:1944 with SMTP
 id n13-20020a056870558d00b0013660bd1944mr10406538oao.100.1666308354880; Thu,
 20 Oct 2022 16:25:54 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:30 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-5-calvinwan@google.com>
Subject: [PATCH v3 4/6] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
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
index ac214f250d..289be0fb93 100644
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
2.38.0.135.g90850a2211-goog

