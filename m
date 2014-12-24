From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/5] t2004: drop unnecessary write-tree/read-tree
Date: Wed, 24 Dec 2014 04:43:13 -0500
Message-ID: <1419414196-58587-3-git-send-email-sunshine@sunshineco.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUk-0005C2-FG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaLXJoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:24 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:45286 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaLXJoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:06 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so7181290iga.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BXzbLR9G8icKkOSI9PYwsMYg/HpKojGBpckfjo+byyM=;
        b=nFJ6Hzh1zbxEYQcCVfOgjEq513K+vCyxe28F1+EXQNhezZLwxf3jODC++oW/gbPVyw
         CNAJBUcb6Pv/5J+MgZ/KKXa4lDsXR9SYX86WUWqiYoNOv8dLbQiquG6yPx7x68OE7+uk
         5GVxFMejTvSSO/CGw+35ana1OoinF1tArsoF/KVPkSQJa0+6y46toG/hc/fgeuAKfDb5
         UP+kuCCO8RPuOVY7nhDYz/pQtoxl8uNyXw7JXsf2rmdgmdWh69D2UKks/jrAeeJ4x6lg
         /KwXGJeR9OY9p/zKzsf3pbkTSjCpp1lM0st0ykGY4LYz3T8OQiUqpMTk9NcRzQm08Ux+
         paXw==
X-Received: by 10.42.22.144 with SMTP id o16mr26078975icb.0.1419414245704;
        Wed, 24 Dec 2014 01:44:05 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.04
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:05 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
In-Reply-To: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261800>

Unlike earlier tests which reference several trees prepared by "setup",
no other tests utilize the tree from the "symlink" test, so there is no
need to write it (or read it back immediately).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2004-checkout-cache-temp.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 28e50d6..22d1a24 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -198,9 +198,6 @@ test_expect_success 'checkout --temp within subdir' '
 test_expect_success 'checkout --temp symlink' '
 	rm -f path* .merge_* actual .git/index &&
 	test_ln_s_add b a &&
-	t4=$(git write-tree) &&
-	rm -f .git/index &&
-	git read-tree $t4 &&
 	git checkout-index --temp -a >actual &&
 	test_line_count = 1 actual &&
 	test $(cut "-d	" -f2 actual) = a &&
-- 
2.2.1.267.g0ad48de
