From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 07/12] t4013: call git-merge instead of git-pull
Date: Thu,  7 May 2015 16:44:03 +0800
Message-ID: <1430988248-18285-8-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQI-0005dY-2a
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbbEGIon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:43 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34903 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbEGIoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:39 -0400
Received: by pdbqd1 with SMTP id qd1so35390143pdb.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Trg4enhGf6nto8N3mtjI62Muj2mB//OemLKkuErck1o=;
        b=dfNIucGEbrGX24rM2rnphCGCsZA4mLNzoXmrh7f11RcrvFk8fPZ7y5G/g9jTfnwOO9
         EhmLZgZ1YmEbAzKON+eHzADKmgTJL8ndajcYNYNSA+NeTwSCpllv0l0uRmKW5XHA8R9N
         AlwPWwDIEj1o5a/5Yqi573t9Upc0++M+IEs+S6qOMDsWsmbk2fedSQssGiuiedonpEup
         e+xpW8LnNRIU1Lyjp1l0LEgRziLZC4Q8cWCiUur12gyw28RxAtpFjdFsHJnZJmORNhaV
         brre/zcPypCWDN+ihu9cipwUaLQus8QjZBsnR5+ESuWdyE2l/siiH3mNo5BqHdIyQ213
         DEXQ==
X-Received: by 10.66.167.232 with SMTP id zr8mr5010722pab.23.1430988279318;
        Thu, 07 May 2015 01:44:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268518>

Since "git fetch ." does not update any refs, "git pull . side" is
equivalent to calling "git merge side".

As such, replace the call to git-pull with a call to git-merge to reduce
the dependence on git-pull's functionality to reduce irrelevant test
breakage when git-pull is rewritten to C.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * This is a new patch in the patch series.

 t/t4013-diff-various.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6ec6072..48f2fe2 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -64,7 +64,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout master &&
-	git pull -s ours . side &&
+	git merge -s ours side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
-- 
2.1.4
