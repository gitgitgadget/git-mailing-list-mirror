From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/16] t/t5505-remote: test push-refspec in branches-file
Date: Fri, 21 Jun 2013 16:42:26 +0530
Message-ID: <1371813160-4200-3-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKC-0003IJ-AF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965495Ab3FULQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:05 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47021 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965269Ab3FULQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so7687324pad.32
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xlXY8pdML+EEb3PJJihP5iz4lxMyO9L//Tox9fLyZtc=;
        b=w2ppI1a3iNc1qUM7K64MDmBD/YQqz5pjM6k3XnhLsJ3cPldpZjbtqv20O1cVGkmp3E
         SzRPqxwaESDa80A6fWv6eLBU1wAsaS1gu0vZcIKs3Ot+XS3e0EG2gR+xVdWcWQy646Ra
         0DRZRK/Emq1aP+IBiao21XtJiuBX8nbdSbVrgHxc59HMvPJSlg9PfcQBekO0FX/wQLtU
         Al+K9II2ixEA95hPl6O5USs8cQSvDYGg8IRZX78qFxCWHTrnvrMI+MbQyzxPiyrP8Ynm
         t6VUK4ZzCBM/QDsq2t0FbTEvOc5Vv9fdnhH3Vid6VaqSsiOAiZI53rcKCJbSSUUCz/Ny
         Pvtw==
X-Received: by 10.66.232.101 with SMTP id tn5mr16016018pac.132.1371813361891;
        Fri, 21 Jun 2013 04:16:01 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.15.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228598>

The test "migrate a remote from named file in $GIT_DIR/branches" reads
the branches-file, but only checks that the url and fetch-refspec are
set correctly.  Check that the push-refspec is also set correctly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4d5810f..38c62ec 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -698,7 +698,8 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rename origin origin &&
 		! test -f .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
 	)
 '
 
-- 
1.8.3.1.499.g7ad3486.dirty
