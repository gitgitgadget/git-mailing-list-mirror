From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 07/16] t3600 (rm): add lots of missing &&
Date: Sat,  2 Oct 2010 23:10:35 -0600
Message-ID: <1286082644-31595-8-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpq-0001zH-RF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab0JCFJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 01:09:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:30 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1068412pvg.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kBJWCkTEz+czczqZ28OhWmcU7SKb6xnmDWtINwU4fp4=;
        b=xDx4EStX4dl4RIl1ykZPCGMd+aVY8BCDzkHrUg6aNW50J7f+wiV+TjKBQngCH9XQTC
         SOQSfCnfKAVfO0/0EdX0ABmGInfES9l9CXpvi/Cikr/oizuH2/TEDaGXC3eyJa+c9h3r
         Qi02abfz25ok9VEI1RheCf/YZnK61c4pmjB04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DlbamKSy3Bw9+Arr5vREKvrnC4myOu7rR4+j0iqoJ5OmyXxLIu8cuffUhx66K+wNTj
         BjqsHY0x7FIf8RuDs22jho/3TsZ2wHYZ+LP8qNqVHG2sffranQsVaxUSWaM2c9PkNycC
         uxMk7wIsYYfz8j7Z9EEGWyU9Xew5qI+CE36fM=
Received: by 10.142.248.37 with SMTP id v37mr6831746wfh.349.1286082569711;
        Sat, 02 Oct 2010 22:09:29 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157838>

Also replace failing code with similar clean-up to set the appropriate
state the test needs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3600-rm.sh |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..9660ae0 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,33 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
+    'echo content > foo &&
+     git add foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content > foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" > foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      git rm --cached -f foo'
 
 test_expect_success \
@@ -170,7 +166,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
 
@@ -183,7 +179,7 @@ test_expect_success 'refuse to remove cached empty file with modifications' '
 
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
 
@@ -201,7 +197,7 @@ test_expect_success 'Recursive without -r fails' '
 '
 
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
-- 
1.7.3.1.66.gab790
