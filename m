From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH 1/2] diff-no-index.c: rename read_directory()
Date: Fri, 21 Mar 2014 20:56:57 +0200
Message-ID: <1395428217-7669-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 19:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4cz-00018F-29
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaCUS5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:57:05 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:39381 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaCUS5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:57:01 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so2128602eek.20
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SsgQSLAzWEvmKNx4U4Br7LW8XOmKx95DiTpcREotJy4=;
        b=Nf49FwQYKdVQAjUpfXdQrA5GWs6r3qbnD9+S5+zw1xO0S5Bx/2aPTzdIfue1CCXDnF
         XvhYk2Zba0HYVyVSkPOVFd2brWiWma4T94GejWVBkiy3zuKrb3elXvGPTv0QYLLBt1xV
         fLnb5SOJfCYRys6BFo1iNGI8YfodWtmDy7VHaUSi4ON/80E4vU9UQV2nakLYITZQw7Z0
         sHyQrBUUKXl2Lz3EkG2ar6yaG8H3Oo9DvD1GLj45c6/7WUrSoJzDJaIqMfIA3MlaTq7/
         zlwq6PM0gCgY41E1hpLG+kD3FY+T3DXbOkbaDOHsZtxTnvkDxNIsdpX+KATAuAXESj3K
         0qOw==
X-Received: by 10.15.10.135 with SMTP id g7mr34476652eet.72.1395428220824;
        Fri, 21 Mar 2014 11:57:00 -0700 (PDT)
Received: from andrei-K52JT.pub.ro ([141.85.219.2])
        by mx.google.com with ESMTPSA id u1sm13440733eex.31.2014.03.21.11.56.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 11:57:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244725>


A subsequent patch will include dir.h in diff-no-index.c to 
access is_dot_or_dotdot(), however, dir.h declared a 
read_directory() which conflicts with a (different) 
read_directory() defined in diff-no-index.c. Rename
read_directory() from diff-no-index.c to avoid the conflict.

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---

 I plan on applying to GSoc 2014

 I received your feedback and I resend the patches from the bug that I
 solved in the past

 diff-no-index.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..5e4a76c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_path(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_path(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_path(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.7.9.5
