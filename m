From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-hg: add missing config for basic tests
Date: Mon, 12 Nov 2012 18:41:05 +0100
Message-ID: <1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:41:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy15-0004TU-8i
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab2KLRl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:41:28 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36570 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2KLRl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:41:27 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so197208bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lg+NnxgBHP0hB3KSyNa7zCDftKcpkae5/BsWkQxECfU=;
        b=nINIFEnaL6+XMZuL9ZlrANY7MP1lS4TDmlfPn+q/c0w2CMLxpTiAN80DVyqtaWQndK
         LiJ9Gi/h6IalMWBK6kaWg6+wTBSSAwxEPKOYsHINg8NcU8tbUQvBH/AE4SSH+XVqXy/Q
         I/umvnFZzFbu02LheVtEpD8nE/xtD047Fqx7iI9krBCSRs3KUlwigMzgO7guGeJYO+jb
         aA/sL5cJMkpv/Phb5B5djnfuUKX+zDrl3GkzQsNLh43e0cSnjfJozlZm2TXVFM9ch4Cz
         r+58/epSi1uhLYUe0MM85vR/pyWpAS/H0lS5HKXOHC8A3jY15nQ/phd6IV7Y2Owv+h94
         U3kw==
Received: by 10.204.5.205 with SMTP id 13mr902531bkw.111.1352742086883;
        Mon, 12 Nov 2012 09:41:26 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id ht18sm3871313bkc.14.2012.11.12.09.41.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 09:41:25 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209492>

From: Ramkumar Ramachandra <artagnon@gmail.com>

'hg commit' fails otherwise in some versiosn of mercurial because of
the missing user information. Other versions simply throw a warning and
guess though.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 40e6e3c..031dcbd 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -29,6 +29,15 @@ check () {
 	test_cmp expected actual
 }
 
+setup () {
+	(
+	echo "[ui]"
+	echo "username = A U Thor <author@example.com>"
+	) >> "$HOME"/.hgrc
+}
+
+setup
+
 test_expect_success 'cloning' '
   test_when_finished "rm -rf gitrepo*" &&
 
-- 
1.8.0
