From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 18/23] tests --conflicted.
Date: Sat, 23 Apr 2011 17:22:47 +1000
Message-ID: <1303543372-77843-19-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCv-00054D-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab1DWHYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab1DWHYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:40 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=NOS6CtiC7I+jvUHT/d6ssT9eExH0gdst3lHFEhg6/I4=;
        b=gPgp6itdophzso/9tbCphDPsMWd31WN7nQmCKlKPFxCgdobuYy7chphgor8IPUyzz7
         w/0HgketxcPHbY1djnS0irOfznAGnxmxow7SA+L2ZaBITA4HrjPurv4fRudle4Q9YDGF
         R6Hk3q/E3DFD7+sL3zM47HcOcWPQNZhf2kemw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KHoDKjKiJ2eLY+KsVKLXA1/T03VlXA8M3YBUaieknGSkKqF954tKfv+0ahuvmpr1pT
         199RjVMN0AEYozdxGHLzDY8bENW+1QNqyBhK+lCrWahsi3FrBX9vk8+sDtrSzHG+oKTq
         6t08kvackIA8TYas/n6THHrqMdTvzD3Y0AJJY=
Received: by 10.68.65.229 with SMTP id a5mr2814528pbt.474.1303543480189;
        Sat, 23 Apr 2011 00:24:40 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171968>

---
 t/t1520-test.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index ddca519..a18c1d7 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -442,4 +442,30 @@ test_expect_success 'existence' \
        --not-branch-exists A 
 '
 
+test_expect_success 'git test --conflicted # should fail' \
+'
+	test_must_fail git test --conflicted
+'
+
+test_expect_success 'git test --not-conflicted' \
+'
+	git test --not-conflicted
+'
+
+test_expect_success 'git test --conflicted' \
+'
+	test_when_finished "git reset --hard HEAD" && 
+        ! git merge F &&
+	git test --conflicted 
+	
+'
+
+test_expect_success 'git test --not-conflicted # should fail when there are conflcted files' \
+'
+	test_when_finished "git reset --hard HEAD" && 
+        ! git merge F &&
+	test_must_fail git test --not-conflicted 
+	
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622
