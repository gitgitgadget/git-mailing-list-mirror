From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] t0302: "unreadable" test needs SANITY prereq
Date: Fri, 12 Jun 2015 21:29:58 +0800
Message-ID: <1434115798-8250-1-git-send-email-pyokagan@gmail.com>
Cc: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 15:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3P2S-0003mi-7w
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbbFLNaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:30:17 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33802 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbbFLNaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:30:14 -0400
Received: by payr10 with SMTP id r10so23399167pay.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Zj10YVJvJunZlSMu3GX+AECObzrxznzLN4OrwA2xLRg=;
        b=XEok0IZWrgdMn0hyIeWJPgahmFgrFNGqxdqCMr1z0Sbe0mn3kAjTA93XZrIgYBnt5G
         realf6581srfcf4Q2NKUVDBbVO7kxFjZV5rngwBsYuGaw6o67WgHHCcdZiFscvrrI+I1
         1vznzHqeb8yiWWYB7we1cBWy7sK04l+GGwTi6g8ChRRcOfGNsfEbtoDflyn0hNg3oilS
         MSZY5KbQMvgHe/2tRfTJ9oxW8RK89ZXsfvoj6OvlErBILMHJLNSwrM9FTxYXvhr84QR7
         vGGU2M9vsy70gwTdlOJOZnyczs0svm2SriuC5/y747CWQW48F0urnb/GgbuTdPyLYRL0
         tb9A==
X-Received: by 10.68.179.228 with SMTP id dj4mr23017586pbc.141.1434115813440;
        Fri, 12 Jun 2015 06:30:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id oa3sm3751254pbb.23.2015.06.12.06.30.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jun 2015 06:30:12 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271488>

The test expects that "chmod -r ~/.git-credentials" would make it
unreadable to the user, and thus needs the SANITY prerequisite.

Reported-by: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t0302-credential-store.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 0979df9..1d8d1f2 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -75,7 +75,7 @@ test_expect_success 'get: use xdg file if home file has no matches' '
 	EOF
 '
 
-test_expect_success POSIXPERM 'get: use xdg file if home file is unreadable' '
+test_expect_success POSIXPERM,SANITY 'get: use xdg file if home file is unreadable' '
 	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
 	chmod -r "$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
-- 
2.1.4
