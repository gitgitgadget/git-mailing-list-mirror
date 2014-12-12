From: jguenther@gmail.com
Subject: [PATCH] git-prompt.sh: make $f local to __git_eread()
Date: Fri, 12 Dec 2014 15:59:56 -0600
Message-ID: <1418421596-7898-1-git-send-email-jguenther@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Justin Guenther <jguenther@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 23:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYGJ-0007IX-8X
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbaLLWAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:00:31 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64410 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaLLWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:00:30 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so7893062pab.26
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TtFjWCfr/Z/frX0N00Co7iAOIpByG+SfLo1oOrhVHlw=;
        b=qL75vTAtizuIEmqZuSBhkvTJ+arz1QbmSaqyUbrdNlmViaJy3MxJmASuvAAQub5DqG
         nkar45g+ujANdYxK26QFFKHnpM4ZHyO2dxbS+odUzS1r8jI6LCFa4/FnQgxq7RLeN2DH
         3K5We6zWHua1lxLN1jmts4XcvU5ycNFhn+U2im0wGbyKthQcKG+hlE7h+A6t60fXQJir
         0m4Ndxhua23UHADLnUtu2cglklkOrJNpX1D3AsCIInL+wBk4p8RI12N/IP2PDZg1EEIi
         9gWQRPMSru0Xb+m8ivFUH4RcHua5kCmj5ywDIpgiQCUymm5jw4vOValOhHM74+aHS4Ts
         5otw==
X-Received: by 10.68.139.1 with SMTP id qu1mr30257707pbb.51.1418421630176;
        Fri, 12 Dec 2014 14:00:30 -0800 (PST)
Received: from legion.unformed.ca (142-165-131-135.sktn.static.sasknet.sk.ca. [142.165.131.135])
        by mx.google.com with ESMTPSA id pb6sm2403829pbb.13.2014.12.12.14.00.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:00:29 -0800 (PST)
Received: by legion.unformed.ca (Postfix, from userid 500)
	id 86D0560D24; Fri, 12 Dec 2014 16:00:21 -0600 (CST)
X-Mailer: git-send-email 2.2.0.37.g2035459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261381>

From: Justin Guenther <jguenther@gmail.com>

This function uses (non-local) $f to store the value of its first parameter.
This can interfere with the user's environment.

Signed-off-by: Justin Guenther <jguenther@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c5473dc..729f769 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -270,7 +270,7 @@ __git_ps1_colorize_gitstring ()
 
 __git_eread ()
 {
-	f="$1"
+	local f="$1"
 	shift
 	test -r "$f" && read "$@" <"$f"
 }
-- 
2.2.0.37.g2035459
