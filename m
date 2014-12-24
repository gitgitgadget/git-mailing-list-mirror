From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/5] t2004: standardize file naming in symlink test
Date: Wed, 24 Dec 2014 04:43:14 -0500
Message-ID: <1419414196-58587-4-git-send-email-sunshine@sunshineco.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUR-00053S-45
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbaLXJoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:13 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34957 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaLXJoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:07 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so7114745ieb.7
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YG821DvRyHriE2TxglJM7ZrwBL/FsRisa6ZOUD0/b0E=;
        b=nhEVGS6PyCSB6lnzdkH/J/HUyl/nuS+HSYVHX5uzMxyvIPKVDtMzktf7VsHm95LcgU
         FacroWGKmQnpLQcQCtILRm1EWLWZH8aKakqTeYFW1uh7e+xce1OSvh3ynjjGrqCP2Lym
         C4Rr2kXfZmkBrJt9DiUFk7tKicduUirKR/vq4nL3jUcwoydbqsFPmJmaB7UzWlHVEHP6
         /MJH8BbAL2/RAbCTT0uy+oak5RHnSMZoeFVnAleXCbupKsr7ISMI01QpHFGBw1uMYvKm
         1ogh6RNMns9VUx6lN+jDs0iIcA3stIpxbcRbnYwnRme7WQRuEsrC8rwmVt0ediGsIijI
         hENg==
X-Received: by 10.42.199.211 with SMTP id et19mr1957568icb.9.1419414246657;
        Wed, 24 Dec 2014 01:44:06 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:06 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
In-Reply-To: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261798>

Update "symlink" test to use the common file naming scheme so that its
temporary files can be cleaned up by the "rm -f path*" idiom employed by
other tests in this script.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2004-checkout-cache-temp.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 22d1a24..602fbc7 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -197,13 +197,13 @@ test_expect_success 'checkout --temp within subdir' '
 
 test_expect_success 'checkout --temp symlink' '
 	rm -f path* .merge_* actual .git/index &&
-	test_ln_s_add b a &&
+	test_ln_s_add path7 path6 &&
 	git checkout-index --temp -a >actual &&
 	test_line_count = 1 actual &&
-	test $(cut "-d	" -f2 actual) = a &&
+	test $(cut "-d	" -f2 actual) = path6 &&
 	p=$(cut "-d	" -f1 actual) &&
 	test -f $p &&
-	test $(cat $p) = b
+	test $(cat $p) = path7
 '
 
 test_done
-- 
2.2.1.267.g0ad48de
