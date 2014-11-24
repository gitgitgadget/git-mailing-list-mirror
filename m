From: Dan Wyand <danwyand@gmail.com>
Subject: [PATCH] git-sh-setup.sh: use dashdash with basename call
Date: Mon, 24 Nov 2014 18:03:31 -0500
Message-ID: <1416870211-13959-1-git-send-email-danwyand@gmail.com>
Cc: Dan Wyand <danwyand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 00:03:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2fY-0006S5-3T
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbaKXXDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 18:03:40 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38138 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaKXXDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:03:39 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so7479426lbj.37
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 15:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=46pPDm1k85SxOtaljXRd7K8BNyXn9rtR/MrMkUFPygE=;
        b=ru7lrL2Xngo7yfT1q8JSBpe3jdZ65mthzA5OSX4RnFVRLTGneMuIUKXU64xZTkOCio
         /5st/ZDC7gqW+CmkaiR8sF/UybW5D4qqwDDC0qRtfLvN69Yp7voypQVRmkjrfWPlSK4u
         hCLcgiYhRDrri+imGhS6DEFonz80pg0B6JM/rTRnXiyJitM00IZ8vYgYdy8MBDvcboYR
         42X+IaYn2XoN+N+F4ltAsKIP/b6VllFLw/FzyZUd9WXPT7xZevDdPHeLmGto6/8KPXCY
         FTohHLvRthlfvJXjepX/RFun5el4QIXNIKVNXCLmDHeylptZvb1tDcIfMKOb6rzvmnJx
         mf7w==
X-Received: by 10.112.73.102 with SMTP id k6mr9926715lbv.75.1416870217747;
        Mon, 24 Nov 2014 15:03:37 -0800 (PST)
Received: from localhost.localdomain (173-166-145-18-washingtondc.hfc.comcastbusiness.net. [173.166.145.18])
        by mx.google.com with ESMTPSA id li3sm2132104lbc.31.2014.11.24.15.03.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Nov 2014 15:03:37 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260165>

Calling basename on a argument that starts with a dash, like a login shell,
will result in an error. This patch adds '--' before the argument so that the
argument is interpreted properly.
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9447980..5cdae33 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -81,7 +81,7 @@ if test -n "$OPTIONS_SPEC"; then
 		echo exit $?
 	)"
 else
-	dashless=$(basename "$0" | sed -e 's/-/ /')
+	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
 		die "usage: $dashless $USAGE"
 	}
-- 
2.1.3
