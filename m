From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] remote-hg: improve basic test
Date: Wed, 28 Aug 2013 14:23:10 -0500
Message-ID: <1377717793-27170-6-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPo-0003hD-3L
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab3H1T2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:22 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52332 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab3H1T2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:19 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so3331419oag.14
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S7Kl28oxZ7lf20E93JOUmRGpR7z9Bipazov3G8WSJEY=;
        b=CnUX1CS5xnHCXrH2pfl12Q2HHPT2RG2Z6LSuDCqlfWX/iJ4lbupbA3p6UYSNNE4mJ1
         qVKFkKDr5cxgKPXqsZjbH9ugjdTDatp/Bv5MlGbYUBilfzpuW9p/B2aoX2qsKY1QV/Z4
         pFDl9UC+7FcEgUzIWiYbl7lM4tCbIlHIC50R2sTpsSitUdigKlS3G5O0Mys028ITxIbj
         qO7VgIEV2Ah4pGcfgimBFGlGzzXEmklO3PDoC8yXC6P4hzXYkrdaIYVfzNgRRYHgZ3Pr
         oFWmjTcYxVxkxQsc2OOWkqbPn83ia47yXxCGKsyFe1Ci4vrVPilJNE+nEPqSyC8lUwW+
         FGJg==
X-Received: by 10.182.237.75 with SMTP id va11mr3222636obc.5.1377718098906;
        Wed, 28 Aug 2013 12:28:18 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm27510313obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233199>

It appears 'let' is not present in all shells.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 94b0bba..5a6f745 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -75,10 +75,10 @@ check_push () {
 			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error || ref_ret=1
 			;;
 		esac
-		let 'ref_ret' && echo "match for '$branch' failed" && break
+		test $ref_ret -ne 0 && echo "match for '$branch' failed" && break
 	done
 
-	if let 'expected_ret != ret || ref_ret'
+	if test $expected_ret -ne $ret -o $ref_ret -ne 0
 	then
 		return 1
 	fi
-- 
1.8.4-fc
