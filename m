Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9390207D6
	for <e@80x24.org>; Sat, 29 Apr 2017 10:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166531AbdD2KDN (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 06:03:13 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:3356 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166527AbdD2KDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 06:03:11 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 4FEE42003CE;
        Sat, 29 Apr 2017 12:03:08 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] i18n: remove i18n from tag reflog message
Date:   Sat, 29 Apr 2017 12:02:53 +0200
Message-Id: <20170429100253.4710-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The building of the reflog message is using strbuf, which is not
friendly with internationalization frameworks. No other reflog
messages are translated right now and switching all the messages to
i18n would require a major rework of the way the messages are built.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/tag.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 222404522..bdf1e88e9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -309,7 +309,7 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 	if (rla) {
 		strbuf_addstr(sb, rla);
 	} else {
-		strbuf_addstr(sb, _("tag: tagging "));
+		strbuf_addstr(sb, "tag: tagging ");
 		strbuf_add_unique_abbrev(sb, sha1, DEFAULT_ABBREV);
 	}
 
@@ -317,14 +317,14 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 	type = sha1_object_info(sha1, NULL);
 	switch (type) {
 	default:
-		strbuf_addstr(sb, _("object of unknown type"));
+		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
 		if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
-			strbuf_addstr(sb, _("commit object"));
+			strbuf_addstr(sb, "commit object");
 		}
 		free(buf);
 
@@ -332,13 +332,13 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
-		strbuf_addstr(sb, _("tree object"));
+		strbuf_addstr(sb, "tree object");
 		break;
 	case OBJ_BLOB:
-		strbuf_addstr(sb, _("blob object"));
+		strbuf_addstr(sb, "blob object");
 		break;
 	case OBJ_TAG:
-		strbuf_addstr(sb, _("other tag object"));
+		strbuf_addstr(sb, "other tag object");
 		break;
 	}
 	strbuf_addch(sb, ')');
-- 
2.12.0

