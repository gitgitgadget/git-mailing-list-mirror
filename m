From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] unset GREP_OPTIONS in test-lib.sh
Date: Wed, 18 Nov 2009 17:15:19 +0100
Message-ID: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 17:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAnBt-0002rQ-2n
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 17:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbZKRQPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 11:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbZKRQPR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 11:15:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:10341 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395AbZKRQPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 11:15:16 -0500
Received: by fg-out-1718.google.com with SMTP id d23so347413fga.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nCJ6yLUWq8mBCStNw3MM2dEsFCL3GUqEBS4otRvgSe4=;
        b=wXGNt6a9q2+x+MlXPJFgzM9SRTAQuQ2hXLqDic6Sb6bDUXAQcT2G8GcBK0r8FvKuL2
         R48YCpuoovAZo442JRaz8BB1KEiilThjFLW+TwWepxYpKUCM1ztfJZ/uonzIMEPxwgxV
         +vOHsIh1Naa0I3g6rqKPfsYmPmOXpxXFJGSZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uIrBO4wzLCbWIvR4G3eyCEA96+B8l3bYdy3z5G097QA7SLu7+0SbyReBfraWgmmXIi
         wlnCQqA1IiEEKwM0snyqr5N8v4eNROLeDO/kTBjzRe8jiJp7dr5W9gQ9IkubfWKTxJX+
         ak+9vxI48BlFA4ou24Rel2Pn+7l9WfKdizJ7c=
Received: by 10.86.204.9 with SMTP id b9mr1505439fgg.7.1258560921397;
        Wed, 18 Nov 2009 08:15:21 -0800 (PST)
Received: from localhost ([141.76.90.217])
        by mx.google.com with ESMTPS id d8sm4193482fga.3.2009.11.18.08.15.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 08:15:20 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.307.gd603
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133189>

I used to set GREP_OPTIONS to exclude *.orig and *.rej files. But with this
the test t4252-am-options.sh fails because it calls grep with a .rej file:

    grep "@@ -1,3 +1,3 @@" file-2.rej

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..6ac8dc6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -65,6 +65,8 @@ GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 # CDPATH into the environment
 unset CDPATH
 
+unset GREP_OPTIONS
+
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 	1|2|true)
 		echo "* warning: Some tests will not work if GIT_TRACE" \
-- 
tg: (785c58e..) bw/unset-GREP_OPTIONS (depends on: master)
