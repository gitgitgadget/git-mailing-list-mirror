From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH] t7300: fix broken && chains
Date: Sun, 30 Aug 2015 11:18:09 +0200
Message-ID: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 11:18:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVylM-0004NA-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 11:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbH3JSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 05:18:53 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35975 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbH3JSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 05:18:52 -0400
Received: by labnh1 with SMTP id nh1so30287291lab.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=aLKmMKUZmuxiAkYTNe7EF2k76rdNxbY1fu3pJYWpfk0=;
        b=jyNxETOvoE+DB9zXqrQgWIsBJfsF5KX8VieDAjnlabgF9X2EVmmZ1oCeQ2J/w3u3Jb
         4jl9MjfBwkhEW0/DQC4f3tXsheBNb8vDIsWeQpZMDudF10kNH3rfIuSLROUUT7DegwQU
         8Golxwj04WqHNbPV06PjPLYZ82AcnYs2HWf7Ttns6gciYzDDBKP7t/Gz2FERdKLnk02u
         F+b9wLIuggVZ0X0QGFYJSAOPKq8wBXqu6OeTc8eV08oTsR4d4PCIXCLAB/FqoGzDTtHl
         rf+kTsRS8+sXFRdHUPzJoV5JgMaGhhY2gHe6ISH6dlYE1ASkquV+MB43+YyynlglYnol
         MYdw==
X-Received: by 10.112.25.69 with SMTP id a5mr8442393lbg.16.1440926331019;
        Sun, 30 Aug 2015 02:18:51 -0700 (PDT)
Received: from localhost.localdomain (78-72-191-38-no36.tbcn.telia.com. [78.72.191.38])
        by smtp.gmail.com with ESMTPSA id w3sm2913603lag.13.2015.08.30.02.18.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2015 02:18:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.4.410.gd6567e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276814>

While we are here, remove some boilerplate by using test_commit.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/t7300-clean.sh | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 27557d6..86ceb38 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -432,9 +432,7 @@ test_expect_success 'nested git work tree' '
 	(
 		cd foo &&
 		git init &&
-		>hello.world
-		git add . &&
-		git commit -a -m nested
+		test_commit nested hello.world
 	) &&
 	(
 		cd bar &&
@@ -443,9 +441,7 @@ test_expect_success 'nested git work tree' '
 	(
 		cd baz/boo &&
 		git init &&
-		>deeper.world
-		git add . &&
-		git commit -a -m deeply.nested
+		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
 	test -f foo/.git/index &&
@@ -601,9 +597,7 @@ test_expect_success 'force removal of nested git wo=
rk tree' '
 	(
 		cd foo &&
 		git init &&
-		>hello.world
-		git add . &&
-		git commit -a -m nested
+		test_commit nested hello.world
 	) &&
 	(
 		cd bar &&
@@ -612,9 +606,7 @@ test_expect_success 'force removal of nested git wo=
rk tree' '
 	(
 		cd baz/boo &&
 		git init &&
-		>deeper.world
-		git add . &&
-		git commit -a -m deeply.nested
+		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -f -d &&
 	! test -d foo &&
--=20
2.4.4.410.gd6567e3
