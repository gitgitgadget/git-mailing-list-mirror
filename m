From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 13/16] t7601 (merge-pull-config): add missing &&
Date: Sat, 25 Sep 2010 13:07:04 -0600
Message-ID: <1285441627-28233-14-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4u-0005Xq-TN
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab0IYTF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:56 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48425 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab0IYTFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:54 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1062331pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G0W/ViYpVxK6fq1XOZhora25z95YB8K6euzXHS0HvLA=;
        b=TS7ska0S/4C9yp+DFOwKP/4buLJqoSa8NY1dr25sA8p500x/vUe70kiF9IgkY/eorB
         aiq8ASs2INDLC6JY91fcr9C009zGME6ImdHaXKPbueRBNY9BHaRNUu78fJZinaJL/LYV
         DZrAu9Gg3wc6XygvOrcdvPzTk6ZdTNRle0fsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pplkGXXjhhTWFW7TVKv+QRD7ic4kaFAQx3gxjkBr9K3E8AxtmpnjifSxAZ+YlJEW9i
         YbX2vNx1aZd/QwtzqbxoxP7cP7U5CVT2DLHjp4svsR2CRXzcUXU85Rf4C19qzKoRApgn
         +VA8JV3/481WjFsxT1zMnbiMDJ/m4rY2ynwSA=
Received: by 10.114.12.15 with SMTP id 15mr5652329wal.134.1285441554463;
        Sat, 25 Sep 2010 12:05:54 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157183>

Also prefix several relevant git merge commands with 'test_must_fail' to
keep the tests passing.

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
