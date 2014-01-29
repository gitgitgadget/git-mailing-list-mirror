From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/2] builtin/apply.c: reduce scope of variables
Date: Wed, 29 Jan 2014 05:30:27 -0800
Message-ID: <1391002227-7727-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8VDw-0005TZ-4T
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaA2Nac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:30:32 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44825 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaA2Nab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:30:31 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so1760791pab.17
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UMBuC4CLwF15gOWdCSJbzf47WtxRg3IESv/XsGAb/RY=;
        b=VGBaxNDZUKnRcIn3LYOsvHPxhtI0KEZWviBvQhvgHDMlcNI9NPqYszmkpyh0uEkHiK
         s9rtiYqw8vbh1O4LAMpmJKCcnRlRa1RoP83u6yAXNNGwebrD8uCQfIkNWGyc5h0OSgqU
         u2jja0+I6YV7FpBgGHfZOmmZET++rT1hxViQpGUTuOC/ix+CX7i9ojKmraaM1kv2+wLE
         ICqRVX49ZuCXzwKf6PnLtF5sjQYy8pl0TloJJWI3ZOVJQtGrVwqTIatEPop83tvNFQQs
         513JBINgSpuEA/IKu23zR3ztY4i4BDk9afUe3vt9QLlbvbVnd9pBZgO1n/43zwzKdUls
         CjmQ==
X-Received: by 10.68.197.234 with SMTP id ix10mr7933603pbc.80.1391002231415;
        Wed, 29 Jan 2014 05:30:31 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id gg10sm7239437pbc.46.2014.01.29.05.30.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:30:30 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241209>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/apply.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..a7e72d5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1943,13 +1943,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 				       size - offset - hdrsize, patch);
 
 	if (!patchsize) {
-		static const char *binhdr[] = {
-			"Binary files ",
-			"Files ",
-			NULL,
-		};
 		static const char git_binary[] = "GIT binary patch\n";
-		int i;
 		int hd = hdrsize + offset;
 		unsigned long llen = linelen(buffer + hd, size - hd);
 
@@ -1965,6 +1959,12 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 				patchsize = 0;
 		}
 		else if (!memcmp(" differ\n", buffer + hd + llen - 8, 8)) {
+			static const char *binhdr[] = {
+				"Binary files ",
+				"Files ",
+				NULL,
+			};
+			int i;
 			for (i = 0; binhdr[i]; i++) {
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
-- 
1.7.10.4
