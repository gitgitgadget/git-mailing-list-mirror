From: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
Subject: [PATCH v3] t7012: Implement test for git-checkout
Date: Sat, 26 Mar 2016 22:07:51 +0530
Message-ID: <56F6BADF.4000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 17:39:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajrF7-00035K-S1
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 17:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbcCZQjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 12:39:06 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34337 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbcCZQjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 12:39:04 -0400
Received: by mail-pa0-f66.google.com with SMTP id hj7so9986135pac.1
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=D8OceA6dJfH2RqtI1AMH+GlDoEGe1Rm6cNnXGm0QV+Y=;
        b=khEbGreVOHZDMIuGVJuaLQWCOFCPJYJjbjTwQT7J5MGNUUqAxYCir9cbHtc3SB7tUi
         gcX5Zs5yLnZRQmdEp0ydX1OYTPK+8m6RMF5PWkXfZRiKXhloeWAbwfB3DP40QBg28p4m
         UT94UrruTFyMZhAaybDQaZGOwHHFp5WWlE5N9bT41FVP0mlXIOy1ksvSOCYjHZGIyUzu
         jVJf9KZ08sDSQWa7+FpMhOoXGcNyVTJ6hPkmOAxCsH6TikA1SU2K/QGEUVUCDRjhD/f0
         EcfFkyO/wYtYQ0sZDhWl4s2K75CFoEDxFvGozkY1x577O+j2PLUzumWSeRbh8DskGUZT
         7aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=D8OceA6dJfH2RqtI1AMH+GlDoEGe1Rm6cNnXGm0QV+Y=;
        b=Yq64mNvW1S6+MhACyzYIu/G+ZwbPxEzauddUGjTknEQZkRvQkzwkZ3vABoCZe/kzU9
         7GsK2MCqvqiyRcEBIF4eltwwKLoat6BNluiCvAWkpZt6eEdoUb+ftjBCTWWbCuL7+Vgt
         kDLYDc/FD5yoywvBPBbza2XFiJn8NkQvT4aUF4Io++oMRMSEQmdt5lJjKjcp9uD9yNZr
         +TWukkA1NS36wu/djSNJhyCH/R5Vp/9HRDujItwCBZn92xrO0fRxz2D2xZA99+3Z3M7O
         YWGZLjK2ltq1nIgIeWFn8TNiQwzzNTA75cHcVJNcpprZ91FrE1LQnCFBaWrcNVdXghlP
         OfHg==
X-Gm-Message-State: AD7BkJLJFDx2AnQiUL6wtgTfgD6t1tx7GB9MQ9UJxo0v6oG+HtHOqaqDGTsW72zx+cm7Dw==
X-Received: by 10.66.100.196 with SMTP id fa4mr29857788pab.37.1459010343065;
        Sat, 26 Mar 2016 09:39:03 -0700 (PDT)
Received: from [0.0.0.0] ([128.199.85.127])
        by smtp.gmail.com with ESMTPSA id ux2sm24202832pac.46.2016.03.26.09.39.01
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2016 09:39:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289985>

Previously a TODO; add a test for git-checkout skipping a
file with the skip-worktree bit set.

Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
---

Replaced test_must_fail around grep with '!', as suggested by Eric.

 t/t7012-skip-worktree-writing.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7012-skip-worktree-writing.sh
b/t/t7012-skip-worktree-writing.sh
index 9ceaa40..276f076 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
 #TODO test_expect_failure 'git-apply removes file' false
 #TODO test_expect_failure 'git-mv to skip-worktree' false
 #TODO test_expect_failure 'git-mv from skip-worktree' false
-#TODO test_expect_failure 'git-checkout' false
+
+test_expect_success 'git-checkout ignores skip-worktree file' '
+	echo >1 &&
+	git commit -m "Add files" &&
+	echo dirty >1 &&
+	echo dirty >2 &&
+	git update-index --skip-worktree 1 &&
+	git checkout -- . &&
+	grep -q dirty 1 &&
+	! grep -q dirty 2
+'
  test_done
-- 
2.7.4
