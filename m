From: Mike Blume <blume.mike@gmail.com>
Subject: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Thu, 13 Nov 2014 14:40:19 -0800
Message-ID: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
Cc: Mike Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:40:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp33z-0001Ya-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 23:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934216AbaKMWkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 17:40:24 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39119 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065AbaKMWkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 17:40:23 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so16203290pab.40
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rGxnR79YCo/rmXnUj787GDwUNeyIGukps6WcpxHUQR8=;
        b=GlR7OkwltfTL6rHTsOjP6GhXPZ+W4EJY8ZQSd+ZiC7AIoayzDjbt0yPV06NBryw95F
         eodjdutnU9PtXadcukKI8vzsiUZX0u9WYXa0uHHFFNgdMCXdUOcGdQ2zxkK12jYzMLbV
         vimyUeUxBAZz9LupxlhVfBaPnreEUc3hmHaAREtPUgf56pOQjAkXH+4duujG/1Stuq63
         FV3Mtw1Im2rdmNjXc/Z6JFZ/dld2jKFr7az0CS2oPUUzjsK1BuIOa+hNBu8X9xKiklmL
         9ECR0iG/saNIHoL8niG8HFqFz48MycqnWUftKPV8opgWOTJwTHWwZ1o3aQVjof5RnZPj
         iQKg==
X-Received: by 10.68.250.131 with SMTP id zc3mr5986320pbc.34.1415918423376;
        Thu, 13 Nov 2014 14:40:23 -0800 (PST)
Received: from tcc-michael-4.local.com ([50.59.189.124])
        by mx.google.com with ESMTPSA id cf12sm25734861pdb.77.2014.11.13.14.40.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Nov 2014 14:40:22 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.197.g60bf093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
TTY on Yosemite and higher

Signed-off-by: Mike Blume <blume.mike@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-terminal.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5184549..6395a34 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -29,7 +29,10 @@ test_lazy_prereq TTY '
 	# After 2000 iterations or so it hangs.
 	# https://rt.cpan.org/Ticket/Display.html?id=65692
 	#
-	test "$(uname -s)" != Darwin &&
+	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
+	# appears to be gone.
+	#
+	test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1)" -ge 14 &&
 
 	perl "$TEST_DIRECTORY"/test-terminal.perl \
 		sh -c "test -t 1 && test -t 2"
-- 
2.2.0.rc1.197.g60bf093
