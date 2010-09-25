From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 03/16] t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
Date: Sat, 25 Sep 2010 13:06:54 -0600
Message-ID: <1285441627-28233-4-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:05:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza40-00051f-PA
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab0IYTFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:32 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so891416pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PHgjYQQJyuf3TyytzKK+65tMM3e6qSfSdPWJNJhqe+s=;
        b=b3DkxI7/xwQQawbTzheW5uj95ygXErwNoptVEvl1ZtR+TdscbCjA3yigAUPvidnR4O
         wmxfpBFpXJ3ErRbfd77GN60gbaqPthJjm78sUOuFguWN15F/hvPtQX9KUCH8cC+xjGar
         yYu/3ucb1/9KvDcpSC6h2vKM+9mEE40R03BTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rWlmHvE7n4WMYT5jsNhMBfpLCvCne5J8dTaDC0dcyc93ukwxE92af8h/LCdkKlHHtg
         wyLP1KxXgx0MS+JPjCQC3BMjYrIeFtKfegXAG1Fucu1gh0sRPOSkRI0aqWbXR+v0lA/M
         UAKhjf1At++9fbdui1vvHEtKWyHrMeNDKdbhY=
Received: by 10.114.39.20 with SMTP id m20mr5628258wam.227.1285441532253;
        Sat, 25 Sep 2010 12:05:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157173>

Also, replace "|| return 1" with "&&" in order to keep commands chained.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1001-read-tree-m-2way.sh   |   18 +++++++++---------
 t/t1002-read-tree-m-u-2way.sh |   10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 93ca84f..ce8112c 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -98,8 +98,8 @@ test_expect_success \
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >4.out || return 1
-     git diff --no-index M.out 4.out >4diff.out
+     git ls-files --stage >4.out &&
+     test_might_fail git diff --no-index M.out 4.out >4diff.out &&
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
@@ -112,8 +112,8 @@ test_expect_success \
      git update-index --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >5.out || return 1
-     git diff --no-index M.out 5.out >5diff.out
+     git ls-files --stage >5.out &&
+     test_might_fail git diff --no-index M.out 5.out >5diff.out &&
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
@@ -213,8 +213,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_might_fail git diff --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
 
@@ -227,8 +227,8 @@ test_expect_success \
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >15.out || return 1
-     git diff --no-index M.out 15.out >15diff.out
+     git ls-files --stage >15.out &&
+     test_might_fail git diff --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
@@ -377,7 +377,7 @@ test_expect_success \
      git ls-files --stage >treeM.out &&
 
      rm -f a &&
-     mkdir a
+     mkdir a &&
      : >a/b &&
      git update-index --add --remove a a/b &&
      treeH=`git write-tree` &&
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 0241329..a9492e9 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -205,8 +205,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      git read-tree -m -u $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff -U0 --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_might_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
@@ -226,8 +226,8 @@ test_expect_success \
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      git read-tree -m -u $treeH $treeM &&
-     git ls-files --stage >15.out || return 1
-     git diff -U0 --no-index M.out 15.out >15diff.out
+     git ls-files --stage >15.out &&
+     test_might_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
@@ -314,7 +314,7 @@ test_expect_success \
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
     'DF vs DF/DF case setup.' \
-    'rm -f .git/index
+    'rm -f .git/index &&
      echo DF >DF &&
      git update-index --add DF &&
      treeDF=`git write-tree` &&
-- 
1.7.3.95.g14291
