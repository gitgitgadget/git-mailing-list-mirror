From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 2/7] test-parse-options: print quiet as integer
Date: Sun,  1 May 2016 01:33:31 +0530
Message-ID: <1462046616-2582-2-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb7h-0000zH-M7
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcD3UEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34618 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbcD3UEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so15365059pfz.1
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fP8MrkkUEIpw9dXrYyOWRCiEWuYNRvqHUHyGbfXSg/A=;
        b=nwn+uVjraOkH997PAA5PqJg8zjXZvJwDnAw1QrtxtAFJYwm3GfkfcY48t2DLdfJuiI
         0wX6Gtstp6y3+qexb06nyEPfiggo67GrJ2ywGQQmyETYsvu5KQmSOOCBY6SEqmJ8i8YN
         ySxJwIMw4kL0JM5Sy7Bu5cR3tbMGJX8SRfq0/0VWnQzFhyjCua9EJ7RyTj8FE6MI348v
         1p/6XtxP7tIZF7PEkPKzm5n/uQaKPxSBmSB3C7cwvGaFFmK+fJt53DfsEjdDOoIHZ3ls
         jAPu47iwf1LCqypdEFum1xG6Elt3dUBJE7P/aD7tY/YlB2sseL3uGdXfMT7RrarjBcJO
         0zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fP8MrkkUEIpw9dXrYyOWRCiEWuYNRvqHUHyGbfXSg/A=;
        b=VeF/l4tlv2eZj7mYlh7AfrcczSGJJBdw0QLPYDpsZ/iL4lbjPdxBGbCnLAKUXnAoJI
         CzarmIMRAVJC0W9BJpgep5v9rgEFS//dNuK7CzZBiQpGy/A2CnHOcYVvuDPSq82jsZGD
         hAHYeq1GjpTfBGipPZWSU/ydym0XNLR4ZqdUig98jioPlhyGuS697u5SPaOhr6HM77d9
         mlBXZOPfOylsTlRB5mjaN7TbB4Wm3lZAhzV633VkJFj3qedWhxk+GmJDRnr4LNOMxKDt
         WylwvGBthaA9Cy9GPGcM2Mlraqi4xCsaY8LGZPYGDBBAUDFCv/s5e1XJ9HI762XMFnF5
         u1tA==
X-Gm-Message-State: AOPr4FUz/XKF0SqQt5Ac9sHjdVXXZq3GJYXg7GOyQ7M5t0D3d8Jv+aZngr2r6YB5ZODFUQ==
X-Received: by 10.98.79.213 with SMTP id f82mr38779894pfj.65.1462046649006;
        Sat, 30 Apr 2016 13:04:09 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293128>

We would want to see how multiple --quiet options affect the value of
the underlying variable (we may want "--quiet --quiet" to still be 1, or
we may want to see the value incremented to 2). Show the value as
integer to allow us to inspect it.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 26 +++++++++++++-------------
 test-parse-options.c     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 477fcff..450da45 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -64,7 +64,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -164,7 +164,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 2
-quiet: no
+quiet: 0
 dry run: yes
 file: prefix/my.file
 EOF
@@ -184,7 +184,7 @@ timestamp: 0
 string: 321
 abbrev: 10
 verbose: 2
-quiet: no
+quiet: 0
 dry run: no
 file: prefix/fi.le
 EOF
@@ -212,7 +212,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: a1
@@ -235,7 +235,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -264,7 +264,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -303,7 +303,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: --quux
@@ -323,7 +323,7 @@ timestamp: 1
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: yes
+quiet: 1
 dry run: no
 file: (not set)
 arg 00: foo
@@ -345,7 +345,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -374,7 +374,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -399,7 +399,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -430,7 +430,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -449,7 +449,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
diff --git a/test-parse-options.c b/test-parse-options.c
index 2c8c8f1..86afa98 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
 	printf("verbose: %d\n", verbose);
-	printf("quiet: %s\n", quiet ? "yes" : "no");
+	printf("quiet: %d\n", quiet);
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
 
-- 
2.8.1
