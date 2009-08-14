From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 2/2] test that git push --delete deletes the remote ref
Date: Thu, 13 Aug 2009 22:05:49 -0700
Message-ID: <1250226349-20397-3-git-send-email-srabbelier@gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 07:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbozp-0003Az-2N
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 07:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbZHNFGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 01:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbZHNFGO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 01:06:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:60673 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbZHNFGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 01:06:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so44914rvb.5
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=44+hn9Rsi0RdtnL8mDIZ5slU6gbsV7GqjMIBQARZsMo=;
        b=AxCv4PkEvdwRTtZvlSIWDLAUih3qQWgqCNjGlpW670FQe+659vxzhWkiQGbpUsM1Av
         sjFDO2n155CZDlInYeYReZzyTTI918gy3BWtYqV+sZi32hMDU1jTxFydees4Bv5oG5RE
         YbJY/ceH9UWtYYI2Wg/O9VaSh+E+bmLnYmxu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eygCwjm5IOIRvdsmM4MX8kZCGtvCVsN0p2SI988EwBRRp0fKVAXzCKQQmZiCLS77VC
         YE878pC60NHD9M2cf2r/d6fJoGSamMRBENx6Ht/C7blCRiZ42n2z/NPUQo+VA/FhrKj2
         2AybIDCl9RZXj8VffeaYjkaT2dN6P2tWfIgXw=
Received: by 10.140.192.18 with SMTP id p18mr852700rvf.95.1250226372715;
        Thu, 13 Aug 2009 22:06:12 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm5737547rvb.40.2009.08.13.22.06.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 22:06:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125896>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Not a lot of tests yet, but I suspect reviewers will ask for more
    and/or new features will pop up that need testing, hence a
    seperate patch with tests.

 t/t5516-fetch-push.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2d2633f..64da9a6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -586,4 +586,10 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'allow deleting a remote ref with --delete' '
+	mk_test heads/master &&
+	git push --delete testrepo refs/heads/master &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
+'
+
 test_done
-- 
1.6.4.16.g72c66.dirty
