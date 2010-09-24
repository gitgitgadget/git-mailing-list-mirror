From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 14/16] t7601 (merge-pull-config): add missing &&
Date: Fri, 24 Sep 2010 16:22:54 -0600
Message-ID: <1285366976-22216-15-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGeq-0000n6-LA
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab0IXWVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60844 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab0IXWVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:46 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so2090828qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hz2FCYapfB9BrScV3jCNIA+wxArWvB/AN9cYUYt4kIE=;
        b=RrZSIEPTHAtUUKrd4HescpP0t5V1FIE0mDAMc2mdwQ8DRwRcpjUqG0hSObw73YM8Gu
         Hx+nCFAIpCngKBeqBza1hF9Dm2DYg9dBv0ZkRbACJqDNR80k06hfESklS3MSStBt6hvn
         nqZ4NazQ1wvNUXVsvGzkkOTt6a2UD2fljEVPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xk+p7r+gXTKFXNMNOOZgbf73Qbz2nmh54+XWkubpakjOMyfUHiaBlJ4EbzBZGVkZqA
         d+3L4BwN1CUnF3cMg/Kp9xd9UQZBoxps5upyvDSA/eteucJKziLwKOGfdyPFPANAFmb0
         +nksZ+yxXXW+WTIFHRGQjdvhbe6VpHBMvCX/w=
Received: by 10.220.128.142 with SMTP id k14mr582795vcs.244.1285366906006;
        Fri, 24 Sep 2010 15:21:46 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157085>

I also had to add a test_must_fail in front of each of the calls to git
merge as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 7ba94ea..b44b293 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -114,13 +114,13 @@ test_expect_success 'setup conflicted merge' '
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive -s resolve c6
+	test_must_fail git merge -s recursive -s resolve c6 &&
 	auto_count=$(conflict_count) &&
 	test $auto_count = $recursive_count &&
 	test $auto_count != $resolve_count
@@ -129,13 +129,13 @@ test_expect_success 'merge picks up the best result' '
 test_expect_success 'merge picks up the best result (from config)' '
 	git config pull.twohead "recursive resolve" &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge c6
+	test_must_fail git merge c6 &&
 	auto_count=$(conflict_count) &&
 	test $auto_count = $recursive_count &&
 	test $auto_count != $resolve_count
-- 
1.7.3.95.g14291
