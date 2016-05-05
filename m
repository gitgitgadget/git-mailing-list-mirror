From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 2/7] test-parse-options: print quiet as integer
Date: Thu,  5 May 2016 15:19:57 +0530
Message-ID: <1462441802-4768-3-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwF-0007if-Og
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbcEEJvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:16 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34732 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbcEEJvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:14 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so35757032pfb.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fP8MrkkUEIpw9dXrYyOWRCiEWuYNRvqHUHyGbfXSg/A=;
        b=jYUjtYFFl58vHr0CQVvmfetDRHX67IivCyJ+aiArzkAK5CseCE/w2aaUVSeEIpQcmQ
         he/oUBgwdCvdP3FqH+r2bP+HceplIMHt4fMxeMYqVZ1kAYQU0FFFrCBV9bUkKdIr0zhm
         n25HRqVUMq8Bj0jBNfrmWDB1BEXmiLIK4ubydZCur0mjKrfSqN7f16Je9h2eE5B8kru2
         jm9Ody4o3f6dmyZVO8sTMlnL/1mKTtv2zftiH57nwStL6odLbnpCZ+F/Yd9++yPqRgVw
         To6pZgsaJ6/86oFH2BVkba0GqFskGsFlpgAg7EAwQ2WA2UCMoS+cGXqxRxpNw9y6sGnh
         DRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fP8MrkkUEIpw9dXrYyOWRCiEWuYNRvqHUHyGbfXSg/A=;
        b=YQp8FyVFwRkKpqOAa18m7HWo0oD2dszwHSDBESoDbJvgLKsdosjRQxUQERGN0JRFir
         gZiOkozwhebFCzVIEz/DVoauf6pu/mkd9JJBx9IA02WXMrwg9PyUtfc5CHK9ZxFS/KEM
         jQqH5b79oJa5vH0iLcDZYfdSSpoEGbBnBavOhx6qFQbesD3pawtwSgpdbFYAmRdltjPG
         9EP9I1rKvces7eaKshOR2GoPMX5BalcTF261Uo9fm5Qyz+c264SLo+uRLCZp+BGhY3kf
         AqTfcLxT92BJHGx/URIDhPZP3GbV9Ap/ybyBSh3PKTVMBF7P/+yX2hW2IVV7g5/BcI4X
         vGRQ==
X-Gm-Message-State: AOPr4FWHL554eNThlTWinYUYmazeCrS3HqBGWHlC+qXvUrBXzm4jaLHhwnvgPbBccjNzrg==
X-Received: by 10.98.52.195 with SMTP id b186mr19271926pfa.9.1462441874015;
        Thu, 05 May 2016 02:51:14 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293636>

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
