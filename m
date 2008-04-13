From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] git clean: Add test to verify directories aren't removed with a prefix
Date: Sun, 13 Apr 2008 18:49:38 -0500
Message-ID: <1208130578-24748-2-git-send-email-shawn.bohrer@gmail.com>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
 <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: jobh@broadpark.no
X-From: git-owner@vger.kernel.org Mon Apr 14 01:50:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlBxy-0001KL-R1
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 01:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbYDMXtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 19:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYDMXtr
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 19:49:47 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:52288 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYDMXtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 19:49:46 -0400
Received: by an-out-0708.google.com with SMTP id d31so353311and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=43MCTexas1145jKMdbh3vhxYxHb2NoSHtGzC/l9wCeY=;
        b=FbLWQClY2+lIEK5Uq9IEdP+tWdtTv7mWagvFmUH+Aot0kISx83ofrI+LecfZmTWmkrcV9nkj5LtubyDA3UxskvBd2RLJ0fLpxKIapAM3lf4YwsbOJxpjH2nkxhMlzPKtlRwq/CQ3jCyqHPiJ4m0iWYLK/f51xmgsUw6W6z3LyRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g13O5cT6QhozomB4nUSPcQnkgkXEURASRManJNlNEIwnPKAKAoyXtLWy/zgd39YoeXs9e/kr2DAlYvxfoCcjpN7Qtf5Nl6Izu9Vo+snnTATl7oxdXWPvP02kNCOuBgOoi7WiCy7GCUCmFEhSs+l7RiTa+tY4KL3p2u6Xzc2gVmA=
Received: by 10.100.152.11 with SMTP id z11mr10967057and.18.1208130586041;
        Sun, 13 Apr 2008 16:49:46 -0700 (PDT)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id i8sm2056165rng.3.2008.04.13.16.49.42
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 16:49:44 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Sun, 13 Apr 2008 18:49:43 -0500
X-Mailer: git-send-email 1.5.5.106.g42c8b
In-Reply-To: <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79427>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 t/t7300-clean.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index afccfc9..a50492f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -75,8 +75,8 @@ test_expect_success 'git-clean src/ src/' '
 
 test_expect_success 'git-clean with prefix' '
 
-	mkdir -p build docs &&
-	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	mkdir -p build docs src/test &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
 	(cd src/ && git-clean) &&
 	test -f Makefile &&
 	test -f README &&
@@ -84,6 +84,7 @@ test_expect_success 'git-clean with prefix' '
 	test -f src/part2.c &&
 	test -f a.out &&
 	test ! -f src/part3.c &&
+	test -f src/test/1.c &&
 	test -f docs/manual.txt &&
 	test -f obj.o &&
 	test -f build/lib.so
-- 
1.5.5.106.g42c8b
