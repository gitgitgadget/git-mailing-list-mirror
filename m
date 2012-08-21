From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] Fix tests under GETTEXT_POISON on git-stash
Date: Tue, 21 Aug 2012 11:30:59 +0700
Message-ID: <1345523464-14586-3-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gEU-0001Eh-1k
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab2HUEhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:37:43 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50431 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2HUEhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:37:42 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2012 00:37:42 EDT
Received: by dakf10 with SMTP id f10so3249563dak.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/D2pUS64Vd2wb5yB7pPF/9X5kIa84sfG62r2T7J1bDk=;
        b=R7n94NTYRh8IBfkX58mfpvlvFPKf0ZetNOEGmI6QsoGNkHyu0Tbi2AOq+9Kl7nZpLe
         58YIkZxPIY/cQs0mjxVR6eQnZrpG5u2hktmaaDDkw0o9tQZXP9JM8JI0mWLpUL6CWyfT
         40oEibSk7T6DO/QPmb3Q880thsLFLjEXsfbvrG44fncAEVizpxVkeNFaDtchjBKdMaz0
         xSIUfjGq/9Yh89+a61syqW1nyWJd6T5CAbk7yvYffZs0kGVk8ECfmYnOlaiDrITD1VYM
         PFnEJuJb4rSw2LRgG+e/+L5Xcg+Qi/fV99xi4OUexUGFSZBEy1YsT1H93YiOZL30w4nP
         hP5A==
Received: by 10.66.84.163 with SMTP id a3mr31581685paz.61.1345523507351;
        Mon, 20 Aug 2012 21:31:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id iq1sm572726pbc.37.2012.08.20.21.31.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:31:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:31:32 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203932>

=46rom: Jiang Xin <worldhello.net@gmail.com>

Use i18n-specific test functions in test scripts for git-stash.
This issue was was introduced in v1.7.4.1-119-g355ec:

    355ec i18n: git-status basic messages

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3903-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cd04263..5dfbda7 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -610,7 +610,7 @@ test_expect_success 'stash apply shows status same =
as git status (relative to cu
 		git stash apply
 	) |
 	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 cat > expect << EOF
--=20
1.7.12.rc2
