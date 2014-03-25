From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 071/144] t5538-push-shallow.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:16 -0700
Message-ID: <1395735989-3396-72-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMlA-00037B-FX
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbaCYIaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:46 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:51306 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaCYI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:56 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so134604pde.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VxvyNJp4mVeiEaa5myD8tNPqJsvRqCgJAEWViVUafDs=;
        b=Etf5mBSikBEEBgzFXhhBzcS/PRG+Sn5A94LfTAlybbnuXeoikU6TpMyJQ9/Ed/F1G8
         83xz81JRt9mJfGOwrB6xzPfualVwDHIizBtCKULiM3Q8A8t8vi8PhwyMRNkuIlCc/ytu
         NkCTe45EZaMNFdIuqaJY2/pcl0jKGapH6e75vD1rdYrYimOqkDjKY3fEG1RPIPi14Ep+
         K8bxRt8QFYxBUyoXjni23ZVx2iQmtMuOCc48tAAwo85NdouRsz89VCaMkf9x9ZIfk2Eq
         9/0GijsxtzzeM6Rt5LmeYP01qrU9YmlgzgFDfzdRXBMhiqYlN9SxlB0tVqUg06fzOV0A
         w/wA==
X-Received: by 10.68.7.66 with SMTP id h2mr76407264pba.91.1395736075662;
        Tue, 25 Mar 2014 01:27:55 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244960>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5538-push-shallow.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 8e54ac5..23a729a 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -104,7 +104,7 @@ EOF
 '
=20
 test_expect_success 'push from full to shallow' '
-	! git --git-dir=3Dshallow2/.git cat-file blob `echo 1|git hash-object=
 --stdin` &&
+	! git --git-dir=3Dshallow2/.git cat-file blob $(echo 1|git hash-objec=
t --stdin) &&
 	commit 1 &&
 	git push shallow2/.git +master:refs/remotes/top/master &&
 	(
@@ -117,7 +117,7 @@ test_expect_success 'push from full to shallow' '
 3
 EOF
 	test_cmp expect actual &&
-	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
+	git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
 	)
 '
=20
--=20
1.7.10.4
