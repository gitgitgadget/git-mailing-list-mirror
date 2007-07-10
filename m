From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 1/2] t0030: Remove repeated instructions and add missing &&
Date: Tue, 10 Jul 2007 23:53:45 +0200
Message-ID: <4693FFE9.3070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 23:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Nf4-0007nu-4R
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762593AbXGJVyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761796AbXGJVyF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 17:54:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:7525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762831AbXGJVx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 17:53:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1432735ugf
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 14:53:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=OvKQtYcZFv7fUEU4COWCas5xMlDw1/J6NqzASni1tjXKC1srpvesTYO8+3nOeKK+e3m/PDQC0SfR/OUmyE3/Ug7fphkK8H6uFjdRzKRfgAcSgGg4HXonQ4+0XxL/K99k4QQ56iwE+8jU2JFSZo190NfMOWLt/btVNXR6EyqeO0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZoTIlgt3aoY4vXxxmV9n6OK9nnXsmXxvDKYjD7wTVqdDs5NBX0QKzlWIU4M5UUy/qhcBPVKoGcM1+Gd1ic38/KdAhAk+T0Rty/f9xcD2LswoMQmgLQCxYrXUTq7scXDqf/KVfDjdLcdtTTxz28nam5Fx5g6Qmx3ih7y9nibcRHk=
Received: by 10.66.236.13 with SMTP id j13mr6197534ugh.1184104434655;
        Tue, 10 Jul 2007 14:53:54 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id f77sm2030211uga.2007.07.10.14.53.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jul 2007 14:53:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52113>

Moved some tests to another test_expect_success block.

Many tests now reuse the same "expect" file. Also replacing
many printf "" >expect with one >expect instruction.

Added missing && which concatenated tests in some
test_expect_success blocks.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 t/t0030-stripspace.sh |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index fdc9fdc..4a2980c 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -85,39 +85,36 @@ test_expect_success \
 '

 test_expect_success \
-    'consecutive blank lines at the beginning should be removed' '
-    printf "" > expect &&
+    'only consecutive blank lines should be completely removed' '
+    > expect &&
+
     printf "\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "\n\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "" > expect &&
     printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
-    git diff expect actual &&
+    git diff expect actual
+'

+test_expect_success \
+    'consecutive blank lines at the beginning should be removed' '
     printf "$ttt\n" > expect &&
     printf "\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&
@@ -139,26 +136,22 @@ test_expect_success \
     git diff expect actual &&

     printf "$ttt\n" > expect &&
+
     printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
     git diff expect actual
 '
@@ -186,26 +179,22 @@ test_expect_success \
     git diff expect actual &&

     printf "$ttt\n" > expect &&
+
     printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
     git diff expect actual &&

-    printf "$ttt\n" > expect &&
     printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
     git diff expect actual
 '
@@ -224,7 +213,7 @@ test_expect_success \
     'text plus spaces without newline at end should end with newline' '
     test `printf "$ttt$sss" | git stripspace | wc -l` -gt 0 &&
     test `printf "$ttt$ttt$sss" | git stripspace | wc -l` -gt 0 &&
-    test `printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l` -gt 0
+    test `printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l` -gt 0 &&
     test `printf "$ttt$sss$sss" | git stripspace | wc -l` -gt 0 &&
     test `printf "$ttt$ttt$sss$sss" | git stripspace | wc -l` -gt 0 &&
     test `printf "$ttt$sss$sss$sss" | git stripspace | wc -l` -gt 0
@@ -340,13 +329,13 @@ test_expect_success \
     printf "" >expect &&

     printf "" | git stripspace >actual &&
-    git diff expect actual
+    git diff expect actual &&

     printf "$sss$sss" | git stripspace >actual &&
-    git diff expect actual
+    git diff expect actual &&

     printf "$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual
+    git diff expect actual &&

     printf "$sss$sss$sss$sss" | git stripspace >actual &&
     git diff expect actual
-- 
1.5.0
