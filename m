Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5AC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiHQGd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQGdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:33:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584895B047
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n4so15028477wrp.10
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=orLlAQr765bvkva4vFaQHGMvMkGu+ZWilMQG0k98LwA=;
        b=hDbaNYH/2EamR+FD/rs39Go2n3XUJ4Nb1t0pHWbgsKdxSBEfxFl7RKDM1x7OC5M4ho
         oR8zpXYOI6s3mf/xOUMQ3E8ZdrRIpTLedkwYEd/8U/Z8+rXiU8szqdYLytP7WYAb1SSz
         4X/qdZs/Wclj1YmqCQCMENL1JJZIGlYxt5ZXzBMI8Ulb/ndKNk3dOk4Tj1HdG5jzL1oD
         uWuy4e9HF3P3/iQWb5av/9TA3IVCFIzvmzIf0x1JyhFhuDYIEMNSNIRsxgWzYPqXp284
         bpAA2Ft7oH3uSMgk+nk0j4o4puy58r1UqvzErX9uZ+NqFbLLM0ZTI18eEk7CsPMv0JR0
         JO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=orLlAQr765bvkva4vFaQHGMvMkGu+ZWilMQG0k98LwA=;
        b=u9FSs7zYKNx4qkzXC34Feq0C+A3GqRm7XxRuKDzdW/Mv4GUQe/RvsckNIW3Cp/w/VS
         SUqcUslMF6HshaQ37VGn/4E2JgNqlfCpE5yiItgtv4HV6TnDEXxshKRZ7pUPqQJOsr8r
         xlSTNFoJSMymRLLApMjDM0bZ6U4BMUEh/LrtieFy1tFgzDrx4tL/5ia2HSHLs60wpvU+
         ekEsMxh6zBcVe1gj0zrsy2nyeIVpE1KRz9Aj2JDwfyrPARtGeV0TPiSExiUrEW130QqV
         CGWaGYE15lyJ5s6rYLnGFUigbdRGy41Cr8U876jhk09rqn/MSychNvTctAiidIlTkt+p
         0iFA==
X-Gm-Message-State: ACgBeo1/iIhAGM6jrZQCnqKUafLkmGy2fltFaA7mC6DSRXbU5YoR2O0i
        XYpWPC4piroW406tOyHZ8Js1ErLbdJg=
X-Google-Smtp-Source: AA6agR7J0qhfMuoa1Ep7Jfibvjt26vmtPMFPmVc/ERU2eFsbym41CUcqJ7SJ155tqRytIM3hF2aIWA==
X-Received: by 2002:adf:d4c2:0:b0:21e:ddf3:8b14 with SMTP id w2-20020adfd4c2000000b0021eddf38b14mr13824008wrk.355.1660718030543;
        Tue, 16 Aug 2022 23:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003a5de95b105sm1036616wme.41.2022.08.16.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:33:50 -0700 (PDT)
Message-Id: <374278c6a1d64e4f9ae43c9c49801997dd338850.1660718028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
        <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 06:33:46 +0000
Subject: [PATCH v2 1/3] merge-ort: remove translator lego in new "submodule
 conflict suggestion"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04), the new "submodule conflict suggestion" code was
translating 6 different pieces of the new message and then used
carefully crafted logic to allow stitching it back together with special
formatting.  Keep the components of the message together as much as
possible, so that:
  * we reduce the number of things translators have to translate
  * translators have more control over the format of the output
  * the code is much easier for developers to understand too

Also, reformat some comments running beyond the 80th column while at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 88 +++++++++++++++++------------------------------------
 1 file changed, 28 insertions(+), 60 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a52faf6e218..67159fc6ef9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4481,34 +4481,6 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	return errs;
 }
 
-static void format_submodule_conflict_suggestion(struct strbuf *msg) {
-	struct strbuf tmp = STRBUF_INIT;
-	struct string_list msg_list = STRING_LIST_INIT_DUP;
-	int i;
-
-	string_list_split(&msg_list, msg->buf, '\n', -1);
-	for (i = 0; i < msg_list.nr; i++) {
-		if (!i)
-			/*
-			 * TRANSLATORS: This is line item of submodule conflict message
-			 * from print_submodule_conflict_suggestion() below. For RTL
-			 * languages, the following swap is suggested:
-			 *      " - %s\n" -> "%s - \n"
-			 */
-			strbuf_addf(&tmp, _(" - %s\n"), msg_list.items[i].string);
-		else
-			/*
-			 * TRANSLATORS: This is line item of submodule conflict message
-			 * from print_submodule_conflict_suggestion() below. For RTL
-			 * languages, the following swap is suggested:
-			 *      "   %s\n" -> "%s   \n"
-			 */
-			strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
-	}
-	strbuf_reset(msg);
-	strbuf_add(msg, tmp.buf, tmp.len);
-}
-
 static void print_submodule_conflict_suggestion(struct string_list *csub) {
 	struct string_list_item *item;
 	struct strbuf msg = STRBUF_INIT;
@@ -4530,45 +4502,41 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
 			return;
 	}
 
-	printf(_("Recursive merging with submodules currently only supports "
-		"trivial cases.\nPlease manually handle the merging of each "
-		"conflicted submodule.\nThis can be accomplished with the following "
-		"steps:"));
-	putchar('\n');
-
+	strbuf_add_separated_string_list(&subs, " ", csub);
 	for_each_string_list_item(item, csub) {
 		struct conflicted_submodule_item *util = item->util;
+
 		/*
-		 * TRANSLATORS: This is a line of advice to resolve a merge conflict
-		 * in a submodule. The second argument is the abbreviated id of the
-		 * commit that needs to be merged.
-		 * E.g. - go to submodule (sub), and either merge commit abc1234"
+		 * TRANSLATORS: This is a line of advice to resolve a merge
+		 * conflict in a submodule. The first argument is the submodule
+		 * name, and the second argument is the abbreviated id of the
+		 * commit that needs to be merged.  For example:
+		 *  - go to submodule (mysubmodule), and either merge commit abc1234"
 		 */
-		strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s\n"
-			"or update to an existing commit which has merged those changes"),
-			item->string, util->abbrev);
-		format_submodule_conflict_suggestion(&tmp);
-		strbuf_add(&msg, tmp.buf, tmp.len);
-		strbuf_reset(&tmp);
+		strbuf_addf(&tmp, _(" - go to submodule (%s), and either merge commit %s\n"
+				    "   or update to an existing commit which has merged those changes\n"),
+			    item->string, util->abbrev);
 	}
-	strbuf_add_separated_string_list(&subs, " ", csub);
-	strbuf_addstr(&tmp, _("come back to superproject and run:"));
-	strbuf_addf(&tmp, "\n\ngit add %s\n\n", subs.buf);
-	strbuf_addstr(&tmp, _("to record the above merge or update"));
-	format_submodule_conflict_suggestion(&tmp);
-	strbuf_add(&msg, tmp.buf, tmp.len);
-	strbuf_reset(&tmp);
-
-	strbuf_addstr(&tmp, _("resolve any other conflicts in the superproject"));
-	format_submodule_conflict_suggestion(&tmp);
-	strbuf_add(&msg, tmp.buf, tmp.len);
-	strbuf_reset(&tmp);
-
-	strbuf_addstr(&tmp, _("commit the resulting index in the superproject"));
-	format_submodule_conflict_suggestion(&tmp);
-	strbuf_add(&msg, tmp.buf, tmp.len);
+
+	/*
+	 * TRANSLATORS: This is a detailed message for resolving submodule
+	 * conflicts.  The first argument is string containing one step per
+	 * submodule.  The second is a space-separated list of submodule names.
+	 */
+	strbuf_addf(&msg,
+		    _("Recursive merging with submodules currently only supports trivial cases.\n"
+		      "Please manually handle the merging of each conflicted submodule.\n"
+		      "This can be accomplished with the following steps:\n"
+		      "%s"
+		      " - come back to superproject and run:\n\n"
+		      "      git add %s\n\n"
+		      "   to record the above merge or update\n"
+		      " - resolve any other conflicts in the superproject\n"
+		      " - commit the resulting index in the superproject\n"),
+		    tmp.buf, subs.buf);
 
 	printf("%s", msg.buf);
+
 	strbuf_release(&subs);
 	strbuf_release(&tmp);
 	strbuf_release(&msg);
-- 
gitgitgadget

