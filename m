From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 06/15] t3600 (rm): add lots of missing &&
Date: Sun, 26 Sep 2010 17:14:30 -0600
Message-ID: <1285542879-16381-7-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:13:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00PL-0005V8-1T
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268Ab0IZXNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249Ab0IZXNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so1036112pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=07wgGzK35VW3CDOWzQiyR/8dKfylSpa1Fa2Q0+3knUY=;
        b=GNPG4upVH6SVJYAOTQY60hlZfL7LpIhy7uwJaPQw7v+qcvuDR2MIUSMgDxt3KkJ85P
         NAt4q2ffZ28g+HM4XqTmrat+AFh3pTWJHyqTYoLXswS3N2HvRDdA+Mzz/R8I7WNl4cqw
         1j6aHTtZvBBZsExd5D6OfUGelYVMK3SEhI+7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=v3KxXN8qhD5CYqX7Z02e9Sb29RPAKqhget3z5OtWrNGWQdCdk1SEtYFIEPiO4GiAWJ
         ddWVmjZly2jeFUPFggTQ2SeyNydQTnUjvPU3BJt0dEVIcHAnW0bSabO0/qi/A/KNf6hc
         rYIpuEvQmKpSOdI1p+jlvqiIWzUU7jUe8myFg=
Received: by 10.114.110.2 with SMTP id i2mr7283452wac.193.1285542794910;
        Sun, 26 Sep 2010 16:13:14 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157267>

Also delete unnecessary, failing code and add some test_when_finished
calls to make sure tests clean up after themselves.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3600-rm.sh |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..b1f9abf 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,33 @@ test_expect_success \
=20
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the f=
ile' \
-    'echo content > foo
-     git add foo
+    'echo content > foo &&
+     git add foo &&
      git rm --cached foo'
=20
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the f=
ile' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content > foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" > foo &&
+     test_when_finished "git checkout HEAD -- foo" &&
      git rm --cached foo'
=20
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither =
the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
+     test_when_finished "git checkout HEAD -- foo" &&
      test_must_fail git rm --cached foo
 '
=20
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached onl=
y did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      git rm --cached -f foo'
=20
 test_expect_success \
@@ -170,7 +166,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
=20
@@ -183,7 +179,7 @@ test_expect_success 'refuse to remove cached empty =
file with modifications' '
=20
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
=20
@@ -201,7 +197,7 @@ test_expect_success 'Recursive without -r fails' '
 '
=20
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
--=20
1.7.3.95.g14291
