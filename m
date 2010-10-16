From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 6/8] t5523-push-upstream: add function to ensure fresh upstream repo
Date: Sun, 17 Oct 2010 02:37:01 +0800
Message-ID: <1287254223-4496-7-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
 <1287254223-4496-5-git-send-email-rctay89@gmail.com>
 <1287254223-4496-6-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdv-0002rt-Pf
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab0JPShq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab0JPShp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:45 -0400
Received: by mail-pz0-f46.google.com with SMTP id 33so271976pzk.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xvlVNwSRSm7fm0gALpluwrHQ5gOyhnqL02F/5Oz3lOk=;
        b=GSgPPUywe5JNCOiuBziUMaUb+FvUArvj7SGq+WhylqcQZnb6pAcATL1+VESSb82SFH
         zUNczNBYMUQ9BQtuMSUuMWJtoqpsGQ+tVlgEAEJ0XtAjMYu6N5cmfBOqsCQmv7EQxRfN
         yxMIii3yXLnBMOCvg0K+ojX/HMtJ3dPZ7mwQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eCrdIfmS44MSphryV0prcxvc1rwJzqgk20GWE5IG88dt757YE1ZnIgqAqJrO37buVW
         qTbXLhelYFoUp4VCylYY6WvIByAAQa9uNYz/QFj6NxPe4Pm/yucLnXg1RUheAMJHBSfS
         qmpV2bgNCCL+Z6UMw8M0Ng7onlbnXvLUSIgA0=
Received: by 10.142.112.12 with SMTP id k12mr1847000wfc.188.1287254265135;
        Sat, 16 Oct 2010 11:37:45 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159175>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5523-push-upstream.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 00da707..5a18533 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -3,8 +3,12 @@
 test_description='push with --set-upstream'
 . ./test-lib.sh
 
+ensure_fresh_upstream() {
+	rm -rf parent && git init --bare parent
+}
+
 test_expect_success 'setup bare parent' '
-	git init --bare parent &&
+	ensure_fresh_upstream &&
 	git remote add upstream parent
 '
 
-- 
1.7.2.2.513.ge1ef3
