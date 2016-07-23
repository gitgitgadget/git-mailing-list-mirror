Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEB0203C1
	for <e@80x24.org>; Sat, 23 Jul 2016 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcGWOLL (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 10:11:11 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:59702 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750882AbcGWOLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 10:11:08 -0400
Received: (qmail 30558 invoked from network); 23 Jul 2016 14:11:05 -0000
Received: (qmail 5673 invoked from network); 23 Jul 2016 14:11:05 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 Jul 2016 14:10:59 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Git <git@vger.kernel.org>
Cc:	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2] i18n: notes: mark comment for translation
Date:	Sat, 23 Jul 2016 14:10:27 +0000
Message-Id: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark comment displayed when editing a note for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---

It seems that strbuf_add_commented_lines adds a trailing newline. So adding
another strbuf_addch(&buf, '\n') would make 2 lines rather only one.

 builtin/notes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 0572051..1d6a096 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -91,7 +91,7 @@ static const char * const git_notes_get_ref_usage[] = {
 };
 
 static const char note_template[] =
-	"\nWrite/edit the notes for the following object:\n";
+	N_("Write/edit the notes for the following object:");
 
 struct note_data {
 	int given;
@@ -179,7 +179,8 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, note_template, strlen(note_template));
+		strbuf_addch(&buf, '\n');
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
 		strbuf_addch(&buf, '\n');
 		write_or_die(fd, buf.buf, buf.len);
 
-- 
2.7.4

