Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0FC32771
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiHQA2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiHQA2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:28:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A472857
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso202928wmr.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5wqvt77XJ4kLvghRosAVADWG5+GcmaXUz2CXgR/aBVE=;
        b=YzgQP8GCk4j7qGIU2tDMCODb4b4Xg18nF0kplRgMYKQwpL3MoBcvtgiQfcxhNF6lS5
         TM7qEzkx2xpicgERD0i6MbevKxnbKPxRlTpr7pbl8bvSaKFZEdVh05Vf9mqnshTYebcf
         LuZln/BTDPP2uGzP1LCyWZgX5IJVLuV/l3HESX6eIVZtw8AATHTcfzg+N96RfQW+gEny
         BfgOW+Q1gq1YKVT/3NVWN5w8Ssxl41vwpjAHPfWssZjoioprrWndschFgzSWJh4UlIC+
         8kwLEOFldlDE/SnuSJA1qInn5QbNHWXZLqcK11PRShUiVJIBTEaHkTP+UOoMirRQpfEd
         f9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5wqvt77XJ4kLvghRosAVADWG5+GcmaXUz2CXgR/aBVE=;
        b=0vfHeRNMGXbBuNPkhrO4I9GWY1LWwMKUwdk1rZIqRwwsFPDgKvog0/MoIhaDHswNGG
         +QDrqjCM6Inb2iKtT77VGRfuwmLg0pZwoeE3KQQ2K3oLayGvoIapLdvrVp7n1twKte4y
         OcyM8P408Vn1Ku9EA8H2uJjELgL3TjX2GKwPhr4slSOr6xKu7KEdyBELgtNqyCr7pRuz
         eZAH7UimHNMF4RYhea0h+PjbXtSbXu7VJqAaCEGqdKl8jgk8VM9ZJtXpmttO69HLAXTn
         LkFW5U7NQ9lvhj/id+kZI36E8qR8lZWSCKVJzWnhqZgETtCyTxZPVbw4vfRmCE2on7Ov
         UY8A==
X-Gm-Message-State: ACgBeo0/VAYznGrBofuPMAS05JuKIEAImcFY/sgS1kkh8//l7sNeasDl
        OcYhSMgv/kn8/yvZBDcf+KdZPcv0um8=
X-Google-Smtp-Source: AA6agR4zqR+jH98dB+R9W+a9dd9tSoqd+E3g8U5p41bmhag0ymaGRmUaKNI1YcRQQNs2M0XLsc/YEw==
X-Received: by 2002:a1c:4c18:0:b0:3a6:9e0:7c2a with SMTP id z24-20020a1c4c18000000b003a609e07c2amr518760wmf.42.1660696082761;
        Tue, 16 Aug 2022 17:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003a5f3f5883dsm355694wmq.17.2022.08.16.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:28:02 -0700 (PDT)
Message-Id: <46c9b48871bd8112866fa16062a4bf0f4776f09e.1660696081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 00:27:59 +0000
Subject: [PATCH 1/3] merge-ort: remove translator lego in new "submodule
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
 merge-ort.c | 90 +++++++++++++++++------------------------------------
 1 file changed, 28 insertions(+), 62 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f33df3ff65d..67159fc6ef9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4481,36 +4481,6 @@ static int record_conflicted_index_entries(struct merge_options *opt)
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
-	string_list_clear(&msg_list, 0);
-	strbuf_release(&tmp);
-}
-
 static void print_submodule_conflict_suggestion(struct string_list *csub) {
 	struct string_list_item *item;
 	struct strbuf msg = STRBUF_INIT;
@@ -4532,45 +4502,41 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
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

