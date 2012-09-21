From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 02:22:46 +0530
Message-ID: <1348260766-25287-1-git-send-email-artagnon@gmail.com>
References: <505CCA55.6030609@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:53:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFADn-0006sM-I9
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab2IUUwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:52:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2IUUww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:52:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3406424pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m+zHVvaFNywHt+M87+1tTlujmkvuPrgBZvnJJzxJ/P4=;
        b=iihf+FCmsYDmns2kqdRa/xn1Vmx6FD2W9j0UyXIeFf0RhtSyrxhpUpmA/MJZvWInTa
         ZOx3lv45yetPWBt16f+b5WJN9Q7cxFqKL75lEl2ISa2wToUBhSpnBK5H0/y8pJkG8WOP
         /3oPNanFagreCfghKBvIYCW+WEiSFGDbvcW+jLRX7kGg1beh7btWv+CpjsmSwudVjXRq
         GAsDRmoaRh3PwzEbS+ybMaIQhAPFeeBOon1dCGHMKhX7IsrqpFWhhSePx9bGjzdfzBQb
         OjpxyssCnGwmmeS6cO9GCe/g9sdAtl9vf9j9qurxxw8BErxk+EDdg+QbvEicA3sXxY9j
         +zGQ==
Received: by 10.68.240.36 with SMTP id vx4mr18430546pbc.89.1348260772598;
        Fri, 21 Sep 2012 13:52:52 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id ho7sm5624046pbc.3.2012.09.21.13.52.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 13:52:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <505CCA55.6030609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206163>

Replace $SHELL with an explicit `/bin/sh`, as some shells do not
support all the features used in the script.  For example, ZSH does
not respect IFS, which is used in line 478.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..5710488 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -24,7 +24,7 @@ done,*)
 *' --tee '*|*' --va'*)
 	mkdir -p test-results
 	BASE=test-results/$(basename "$0" .sh)
-	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
+	(GIT_TEST_TEE_STARTED=done /bin/sh "$0" "$@" 2>&1;
 	 echo $? > $BASE.exit) | tee $BASE.out
 	test "$(cat $BASE.exit)" = 0
 	exit
-- 
1.7.8.1.362.g5d6df.dirty
