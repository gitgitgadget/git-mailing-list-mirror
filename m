Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB01E20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbdAVV3h (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 16:29:37 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36239 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdAVV3g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 16:29:36 -0500
Received: by mail-vk0-f65.google.com with SMTP id n19so9780880vkd.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MFyT75B+a9f/rZda8FNc9osd43fIOQ2jLESdALalpz8=;
        b=JU8Oky9DLLhzrJtY7Mn8SApLP8xcB0+KE298uiSH/zz2ypOGOfBhGM+3QS4ENOZclI
         Q7KLYJehoaG6gUynBYrS2b1QD93UjzQ3s1mgxt60NY1IU9WOfjkwVgkgr+BpqKxVOnvH
         AREM1Q4WnmBdVeBCLN8a6GJWl4m5sNMf3/He9HP9uDV7XMO9UEHT7iovZH77gyKkCUTe
         2tqEKEB22SZSclclRwZzMy5VaHpKpi/y2ZM3ltQyIiv/UxB2+khe8zJKS3lnYn5tfRYW
         vNCKPDJVoYH1jkXU6AM1IOfCuxlKFpuhPaT6SG0hmAlXR2Ojms5cdMZ42ZYAuqSm/CPb
         0u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFyT75B+a9f/rZda8FNc9osd43fIOQ2jLESdALalpz8=;
        b=TqU94QZdVC8dNu1xxeBDk1RAfAavb8ILZm1041EaEi78gpL0UFfvKd0eQ1d69/1KeD
         +mRcIpPmxZi85xpZDJ3jOFLdtl5/7zrR8PATnnH0s3QF2vYCA+2qY0dxcX62VVYoixNB
         gLqWa5r/vuiADCkeepMeVn9RhPLGaKN3jCuEi8tagLkeoQwVvKe8tEHKVLOi04qJMveF
         FQY1CwOReOHmTCC3sK1TJb7TdzcAKDqHiXQWEVr4CaHSGry4oDdwHf71mpBNa0Xzx9UM
         c3J0P4vU0/+biL3Gi50Z+pEsvy/C1eF9UpmA6IeW7ls5p0Q/cCLcI78EGAHCRgbD0A6N
         THIQ==
X-Gm-Message-State: AIkVDXJx5Aj78Vy9qV1gT/Xlbcl57wWqdjIvHG1NfGGN2+ww4QtPmJJPEemws8gOOwUfkg==
X-Received: by 10.31.124.194 with SMTP id x185mr11748542vkc.119.1485120558848;
        Sun, 22 Jan 2017 13:29:18 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id b94sm5484032uab.28.2017.01.22.13.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jan 2017 13:29:18 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] blame: add option to print tips (--tips)
Date:   Sun, 22 Jan 2017 15:28:55 -0600
Message-Id: <20170122212855.25924-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/blame.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 126b8c9e5..4bc449f40 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1884,6 +1884,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_SHOW_TIPS      02000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -1939,14 +1940,18 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	struct commit_info ci;
 	char hex[GIT_SHA1_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
 
+	if (opt & OUTPUT_SHOW_TIPS)
+		printf("\t%.*s: %s\n", revision_length, hex, ci.summary.buf);
+
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+		int length = revision_length;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -2609,6 +2614,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
+		OPT_BIT(0, "tips", &output_option, N_("Show tips before content lines"), OUTPUT_SHOW_TIPS),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
-- 
2.11.0.rc1

