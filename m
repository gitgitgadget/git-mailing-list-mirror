From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/2] t7800-difftool: use "test_must_fail grep" instead of "! grep"
Date: Sun, 26 Oct 2014 18:15:41 -0700
Message-ID: <1414372542-3485-1-git-send-email-davvid@gmail.com>
References: <544CAC30.7000607@kdbg.org>
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 02:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiYuD-0004xh-EU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 02:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaJ0BP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 21:15:29 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62417 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaJ0BP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 21:15:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so264450pab.36
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 18:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bT8ZeqNF5oMP4QibWMvkZEtYvE3osN3usWc16VC2XUA=;
        b=ZX2KKhzyV0WiGyrMbJkioVcjnrgkjVWo6gJ2S3J5arTqRPfX/99ipcFp6aLKio8g2f
         BaHouUh1QeX72lfrljbKHxxcjC3jkgNLn+DlRmFm8RW8plbtMHvb/NWdxhBdt6p7MqEQ
         Sfh289IDZK4UGebN9jDWQIm0D6aGlCGcCeT07iDDgFCLODosu1wWyarf9EVQHSNWEOKb
         41rSfZwNQZE9miyIbRB67Jg8kTWGCkKL/yJZFReTP/fmTCIO7peNh3uvfgTnVh1C/nCd
         UlqO6WTRG8iZ1J0SFaAJ2lWYfQFzpsIySHPHDuwUZQ5SSU5fg5sAdV47mQyROGyVmdmf
         4omA==
X-Received: by 10.68.227.104 with SMTP id rz8mr20934462pbc.4.1414372528611;
        Sun, 26 Oct 2014 18:15:28 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id xr10sm9342375pab.35.2014.10.26.18.15.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 18:15:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.557.g1025af0
In-Reply-To: <544CAC30.7000607@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is new since v2.

This series now depends on "difftool--helper: exit when reading a prompt answer fails".

 t/t7800-difftool.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9cf5dc9..b5b7f62 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -288,8 +288,8 @@ test_expect_success PERL 'say no to the first file' '
 	git difftool -x cat branch <input >output &&
 	grep m2 output &&
 	grep br2 output &&
-	! grep master output &&
-	! grep branch output
+	test_must_fail grep master output &&
+	test_must_fail grep branch output
 '
 
 test_expect_success PERL 'say no to the second file' '
@@ -297,16 +297,16 @@ test_expect_success PERL 'say no to the second file' '
 	git difftool -x cat branch <input >output &&
 	grep master output &&
 	grep branch output &&
-	! grep m2 output &&
-	! grep br2 output
+	test_must_fail grep m2 output &&
+	test_must_fail grep br2 output
 '
 
 test_expect_success PERL 'ending prompt input with EOF' '
 	git difftool -x cat branch </dev/null >output &&
-	! grep master output &&
-	! grep branch output &&
-	! grep m2 output &&
-	! grep br2 output
+	test_must_fail grep master output &&
+	test_must_fail grep branch output &&
+	test_must_fail grep m2 output &&
+	test_must_fail grep br2 output
 '
 
 test_expect_success PERL 'difftool --tool-help' '
-- 
2.1.2.557.g1025af0
