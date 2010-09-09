From: davi.reis@gmail.com
Subject: [PATCH 2/2] Added test from David Glasser.
Date: Thu,  9 Sep 2010 11:21:54 -0700
Message-ID: <1284056514-4935-2-git-send-email-davi.reis@gmail.com>
References: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
Cc: Davi Reis <davi@dhcp-172-19-8-195.mtv.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 20:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otln8-0005xF-Kp
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab0IISXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:23:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55707 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0IISXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:23:53 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so778567gyd.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HmG+vwynLiv1Dg5qaezd6ca4jGlcZfjRdLO0GQ6Ryek=;
        b=I6VBvgEDXxLqR/SN3LCgX8fHovH5r7a7O6SDHdetehtWxXuWqpGXcb3CZaN6gry5v6
         2q1YQsTi7ipJUGDq5MolFUgbze7nyIntCoDGGPriES+1aHKhaI/Q5OQKLXZ759EdqVmn
         ZrSIwyJeycahoEFrcifjOMdoHI9mLonVxhpdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hwk2NQqmIXL89E4TFZKT0RLqhrLOmjAkvsu6JksGggQh0B4S8xMESwfGUqItQ/X1ka
         cJNsnLuSTHcftNY16lt5H8VVTl8HI9LDoRFi4T/l9GOBCLmY7cX2VOp0uCa75TsZHRzB
         n7o7nYSYriQ2NfvY6pnpBSV1GR27psSefMUGo=
Received: by 10.150.144.3 with SMTP id r3mr91137ybd.127.1284056632456;
        Thu, 09 Sep 2010 11:23:52 -0700 (PDT)
Received: from localhost.localdomain (dhcp-172-19-8-195.mtv.corp.google.com [172.19.8.195])
        by mx.google.com with ESMTPS id x3sm7858350ybl.22.2010.09.09.11.23.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 11:23:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155871>

From: Davi Reis <davi@dhcp-172-19-8-195.mtv.corp.google.com>

---
 builtin/ls-tree.c           |    2 +-
 t/t3100-ls-tree-restrict.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fa427e2..37920d0 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -52,7 +52,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 		speclen = strlen(spec);
 		if (speclen <= len)
 			continue;
-		if (spec[len] != 0 && spec[len] != '/')
+		if (spec[len] != '/')
 			continue;
 		if (memcmp(pathname, spec, len))
 			continue;
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index eee0d34..9dd74b5 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -165,4 +165,13 @@ test_expect_success \
 EOF
      test_output'
 
+test_expect_success \
+    'ls-tree with one path a prefix of the other' \
+    'git ls-tree $tree path2/baz path2/bazbo >current &&
+     make_expected <<\EOF &&
+040000 tree X  path2/baz
+120000 blob X  path2/bazbo
+EOF
+     test_output'
+
 test_done
-- 
1.7.2.2
