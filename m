From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 18/19] t/t9814-git-p4-rename.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:31 -0700
Message-ID: <1400593832-6510-19-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRk-0000Bh-7p
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbaETNvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:08 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38322 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbaETNu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:56 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so345822pad.9
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TzqtrNvbY+h4IFuvUf30WXJOyt3Vi8ihzg7Sv8LzOZ0=;
        b=jz6Zw6uACYANQ4JRKJ54qLsc3xjL+ZtjylJovGkiWczszfK6xLjQlTw/KWNyNC9kX5
         qEYK6txol7maghLOj2zTwpVNZflYlFujfh3KycoEFpVylIIxyTl0iq5dTk4Ied1LQsFv
         Ma2BLbhodKoYfG3epSL5bWnFAD4qnRkKNFvjNbztYaLPClPdMVledIG8pAHPE+HYDZHk
         3CD/z34z97O6iZMUcZ/etiySzEpH/6lqOq1wVXZvozo40RxqbwMr7WouikmbuJDwDHr8
         4kzqE6GkN272SP1Kk/hqD/Cs/au/AOHpF0YaglCcziT7n/lhDU4xijtP1SXK8CbcRJLL
         b2Fw==
X-Received: by 10.67.4.138 with SMTP id ce10mr50747046pad.12.1400593856397;
        Tue, 20 May 2014 06:50:56 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249672>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9814-git-p4-rename.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index be802e0..1fc1f5f 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -177,7 +177,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 &&
+		test "$src" = file10 || test "$src" = file11 &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -191,7 +191,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 -o "$src" = file11 -o "$src" = file12 &&
+		test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-- 
1.7.10.4
