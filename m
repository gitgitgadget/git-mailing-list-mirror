From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/4] git-p4: fix small bug in locked test scripts
Date: Fri,  3 Apr 2015 19:53:35 +0100
Message-ID: <1428087218-8186-2-git-send-email-luke@diamand.org>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6jY-0001Fx-LM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 20:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbDCSyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 14:54:18 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37991 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbDCSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 14:54:12 -0400
Received: by wiun10 with SMTP id n10so1859580wiu.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmGXucoyPYM61o0gNF7wdYthLBWkkXztDsBI3YlXze0=;
        b=SVvNNOwdIXo/9Vttxs5ROF6F7PPOPIJnMX+BAzOAjYW8AZhAsJ/s1TPDqAWZPtTOhl
         +FMIrMIYMNvUXkgMfmZDp84nH+Mp7X+t5hqMGKGtFcQvboLouksqUkhRQgwWo7tf48zH
         Y5tbSF4bgdq6GyaKr0ODONTqwNcS0/RcEftjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmGXucoyPYM61o0gNF7wdYthLBWkkXztDsBI3YlXze0=;
        b=ZHlboHkbLBZJ1KYVNvYGnc7MYrJKJJxAMHwls1quEzqukNAKjyFlWBRpFXj88Kb8sI
         9RRXkcSaiWZ9t6HQejBzoPL+74ZCdnXSLfVIS6QPqlgVxBg2zW9Xf23eDfde/9qqw9Y1
         5TiqPKBhezm1u1uTwssg+v+zFvUKkvaiZLIijG/Zdu9aQFLt+1DnbjQ1WZij1a/i6R52
         gvdfOni703QqsB7N9L2SCZ1+9XipRLYHPOrbmYTi00y2ArMmpffyo/OKnKaAC6ZgoJ2x
         Pzyksit87ViEBBPIsWLdLdMhb7XTZwpHNT7XYQgddc/ibOY2vc7Ri9/c9uIfRovg5P1n
         gdbA==
X-Gm-Message-State: ALoCoQkz8ZpTWQBIDZYmWiO4iTI/2OIEyx+NdrOTSYv7fNVED+m7OwlxG3qb2lprYHur6TfhZKyN
X-Received: by 10.194.80.193 with SMTP id t1mr7795012wjx.8.1428087251111;
        Fri, 03 Apr 2015 11:54:11 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fy2sm3782967wic.15.2015.04.03.11.54.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 11:54:10 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428087218-8186-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266717>

Test script t9816-git-p4-locked.sh test #4 tests for
adding a file that is locked by Perforce automatially.
This is currently not supported by git-p4 and so is
expected to fail.

However, a small typo meant it always failed, even with
a fixed git-p4. Fix the typo to resolve this.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9816-git-p4-locked.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index e71e543..ce0eb22 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -41,7 +41,7 @@ test_expect_failure 'add with lock not taken' '
 	(
 		cd "$git" &&
 		echo line1 >>add-lock-not-taken &&
-		git add file2 &&
+		git add add-lock-not-taken &&
 		git commit -m "add add-lock-not-taken" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit --verbose
-- 
2.3.0.rc1.30.g76afe74
