From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 2/6] fn_out_diff_words_aux: Use short variable name
Date: Sun,  4 May 2008 12:20:11 +0800
Message-ID: <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVio-0004qs-Tk
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbYEDEUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYEDEUW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:22 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54656 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750906AbYEDEUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:19 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C4C80470AF; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81129>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 6633c9c..05f7c35 100644
--- a/diff.c
+++ b/diff.c
@@ -408,28 +408,32 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
-	struct diff_words_data *diff_words = priv;
+	struct diff_words_data *diff_words;
+	struct diff_words_buffer *dwb_minus, *dwb_plus;
+	FILE *outfile;
 
-	if (diff_words->minus.suppressed_newline) {
+	diff_words = priv;
+	dwb_minus = &(diff_words->minus);
+	dwb_plus = &(diff_words->plus);
+	outfile = diff_words->file;
+
+	if (dwp_minus->suppressed_newline) {
 		if (line[0] != '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
+			putc('\n', outfile);
+		dwp_minus->suppressed_newline = 0;
 	}
 
 	len--;
 	switch (line[0]) {
 		case '-':
-			print_word(diff_words->file,
-				   &diff_words->minus, len, DIFF_FILE_OLD, 1);
+			print_word(outfile, dwb_minus, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
+			print_word(outfile, dwb_plus, len, DIFF_FILE_NEW, 0);
 			break;
 		case ' ':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_PLAIN, 0);
-			diff_words->minus.current += len;
+			print_word(outfile, dwb_plus, len, DIFF_PLAIN, 0);
+			dwb_minus->current += len;
 			break;
 	}
 }
-- 
1.5.5.1.121.g26b3
