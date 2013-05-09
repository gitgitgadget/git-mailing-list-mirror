From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] fast-export: trivial cleanup
Date: Wed,  8 May 2013 20:16:58 -0500
Message-ID: <1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVO-0000py-9B
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab3EIBSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:18:42 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:41603 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3EIBSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:18:39 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so1281143oag.36
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=X9emAQEQ//rZpDhMCpsi2gr8QHH/vzA7M/7DCLSXOrM=;
        b=vnB/DwMZVyNOTQiYokKvVU5L94xnWEhe6kuNI/Imm1B2G8ludT/MIn8lENopAffHTo
         W2cJXG2iqh7WmZ4G5t0f9oueUjm1elVW02bjFNdWUyShZwugq6axQ/wbRY5uZ7eoychS
         6LwvsNlCZ0x0JefC8Ur7CXgQFFktUlaqiL+2xuo3BV7nHLUtWUMaHe3IvKqlwkstyGre
         Eksv4YWDnuSynLlp36m/xZ8cssN2zZrq0mQS+/oLlERax0BPKNuJ6vqRGDCRsjRt/WG3
         P+00celFqkgK55rF+HkvGdgMA6Of+ciAuyjMT/+n/KofIURjCOuIXTh0Cx425IuFbLr2
         DkAQ==
X-Received: by 10.182.74.131 with SMTP id t3mr3083896obv.87.1368062318626;
        Wed, 08 May 2013 18:18:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm1087369obc.6.2013.05.08.18.18.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:18:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223695>

Cast the object to a commit, only to get the object back?

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8091354..d24b4d9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -550,7 +550,6 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 
 static void handle_tags_and_duplicates(struct string_list *extra_refs)
 {
-	struct commit *commit;
 	int i;
 
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
@@ -562,9 +561,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+			printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));
 			show_progress();
 			break;
 		}
-- 
1.8.3.rc1.553.gac13664
