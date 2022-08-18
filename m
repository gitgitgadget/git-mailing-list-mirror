Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5EC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiHRHPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbiHRHPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:15:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419C876A9
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso449629wmr.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=orLlAQr765bvkva4vFaQHGMvMkGu+ZWilMQG0k98LwA=;
        b=g1nnbOb+rmobCpHR8vQLE/E0aIDBMnWmugNMxdxWT1o6eS+r+8Hf3s2k79MSitI17o
         CAdRoSsow/lrFXE7bnhpygU0qxHecEHV4LVdr/5AEuCRNf5s3iX8rDgAGcfvFuwT1z2H
         WaZIoR13Uzwxvk/nrsjrW8wHfxNCmyV79vrNRbDFNrFr5Ztbrunj7FqwwRHb4i8aXmaE
         FLGyTiuxpO1IWfFpZVdKaWU4iea2KasbYbB+9nieiAp9u/xvTtANlcjO34M6t0hnzGto
         8vLOogB/vRCQMitiH8qnr+NEj6reEvQ4P2fn6ZwvOOqZ8rZuS93XQAKukWqXiyQdBD6c
         8ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=orLlAQr765bvkva4vFaQHGMvMkGu+ZWilMQG0k98LwA=;
        b=QEGdKuJlkzFJL5RPg91HiPsNqYpRe+3JRZVs4T7JXtrjKC8Hgm83J3F0XoE4A1CunS
         D/2sj3BsSVEtXA599fY/y0GAtq0bVolw9dflGC0VHRseeQl+vypGi3m6o8KemBoORXFY
         CSK2UiM+y/LaTmxZDBTkBb6nyWbKqZtChbZ5iwUvQqBRyWJ3kJzEuB+csGb2qsb7vuuB
         TeVLwzZcD0UBINoY1RG4PJX3ypYpo6jgZZ9+n9GuQaWfnmlebARqwfhqBUl7i3lCo5f/
         w5878gjM94yj15ntZgUJkTz6049k8apeKh8IHivari5ag8Cu2KbpttdOiriLQhzQGr8A
         a2bA==
X-Gm-Message-State: ACgBeo3TkNDcB49FQ8YI+KCpL4gvteE7h0cTwv4+Njd+Fzi/zDamHVGJ
        m0hiWvOXUMpxEgs1fEl8x6DsYs80nEg=
X-Google-Smtp-Source: AA6agR4RgnEOQ73vaLIEuvzRmBBixEgEOBqwsvuvEqbOZNeUndUNQiZ2RCxjOvgiadxh+Lgj5H7J+Q==
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr954442wmq.71.1660806929993;
        Thu, 18 Aug 2022 00:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm4626080wms.25.2022.08.18.00.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:15:29 -0700 (PDT)
Message-Id: <374278c6a1d64e4f9ae43c9c49801997dd338850.1660806927.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
References: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
        <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:15:25 +0000
Subject: [PATCH v3 1/3] merge-ort: remove translator lego in new "submodule
 conflict suggestion"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
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

