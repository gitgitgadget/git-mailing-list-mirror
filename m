From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 02/14] t/t5505-remote: test push-refspec in branches-file
Date: Sat, 22 Jun 2013 13:28:09 +0530
Message-ID: <1371887901-5659-3-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIn0-00013o-4D
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682Ab3FVIBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:48 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48872 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423187Ab3FVIBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:46 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so8820112pbc.12
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IvP2EBuS3IFy19lEaitCfKD1RR2n1/JC8Qrq6kAGnC0=;
        b=i91+NeBFajl3q5j8hku9LwHr71Dne8NJShSKsYC85ZPXvYj0dkweiQ4xTxV6nyMznv
         k8r6XNHMfUYOmxyFwsFxU7NMrOgClLZuwYBpl93WIkU0CGdBv0YxnYbhSop2tL6ZzYOE
         /AeobD0PfG+uB4knvF+5cCnxknkk4yYPfeN1jRJ5qMBsfQb9k+2/y3iXtTpc7jq+Jwk0
         Ae1ZmBquPWBxOqJU3goB7fnmgAEXNZ9CCLfTksuHSIBJjbDs/BpJFkGErQaZdU4G4jXR
         y0Rh/2IlqxcsWYnTTJmxDbtchiSdrwaEFpc/jR4ADzSRXnbnLm3lygkF2IlSEldInXW7
         5ciw==
X-Received: by 10.68.76.34 with SMTP id h2mr752219pbw.20.1371888105524;
        Sat, 22 Jun 2013 01:01:45 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228691>

The test "migrate a remote from named file in $GIT_DIR/branches" reads
the branches-file, but only checks that the url and fetch-refspec are
set correctly.  Check that the push-refspec is also set correctly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f679ded..74ddd77 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -764,7 +764,8 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rename origin origin &&
 		! test -f .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
 	)
 '
 
-- 
1.8.3.1.498.gacf2885
