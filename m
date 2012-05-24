From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Do not autosquash in case of an implied interactive rebase
Date: Thu, 24 May 2012 13:52:55 +0000
Message-ID: <1337867575-7212-1-git-send-email-vfr@lyx.org>
Cc: Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 15:53:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYTu-0002WS-7D
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 15:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab2EXNx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 09:53:29 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45438 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2EXNx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 09:53:27 -0400
Received: by eeit10 with SMTP id t10so2439318eei.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 06:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=jOdnHetuo5QoHYrjB72zkAusJCEap4dAFhfEIiOjeDU=;
        b=XuHbIiMRGcQHXzdMElJFBOn0567zQOHrIenxH3OGh3SrlsAkwEa7sS+FUJvjKzZ5Fz
         vF6R64p4ywU4+DnoATbENrgglZbeZGxeSLJGJmTPSSY4MP/3GFPFo5CCfx7DByX3WWm6
         4vMXkjQTsOiJRi124T150B3fI3MHum8L8tiHJhYJ7tw9W2DwH+kIdcfivKkKrBCnSeAJ
         pXHgfUAZRtHqIE7mkpovelqE0x5osfpdlT+lEqxR91Lm4iVmNutSjlcRfKY5or1xc6nQ
         JfCDyQlrheuoQ9/FNuIYQha5qS9rLbeTZM/WEI6nDhCuNViK13rTjT/gzjndXFuBDCRg
         KxUA==
Received: by 10.213.112.210 with SMTP id x18mr2220806ebp.33.1337867605863;
        Thu, 24 May 2012 06:53:25 -0700 (PDT)
Received: from localhost (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id s47sm1289568eef.4.2012.05.24.06.53.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 06:53:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQkLFciXxIr/wAht6C6+/m0ndw5ucFTUJBF9s59ZNQTJRTibISX/dAQy9vSfrIzlph4lEy0D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198372>

The option to autosquash is only used in case of an interactive rebase.
When merges are preserved, rebase uses an interactive rebase internally,
but in this case autosquash should still be disabled.
---
 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..9148ec2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -167,6 +167,7 @@ run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
+		autosquash=
 	fi
 	. git-rebase--$type
 }
-- 
1.7.9.msysgit.0
