From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/25] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Tue, 18 Feb 2014 20:40:00 +0700
Message-ID: <1392730814-19656-12-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvj-0007tj-S8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbaBRNlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:21 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48735 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656AbaBRNlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:19 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so15872144pdb.38
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ODOrVmvk/lz504lhZ32erDBOoqkYPe6MO/2bX+wq4do=;
        b=wUVu/Ga97NL1bCazXld7jLnXKEkq6uEaG6q5dY7gIqMtS5VPIaJuAmAAZlkf3E0UQE
         SsDI0a4aNyKz9HD6mNL4Y+TVFh1/TaUJeu8/yott54fMDECAlkEhWHsVNcfVAX0L/qav
         7oy778UTJ0c7m/OPm0JEVOogwQWYAOnrUn1rfi8KQoZ5MeUInHwmnDdRJ2HlnJkER6a9
         Q0Xa87YHDf3B4csR6qW0H2xgTGM/5NPDS6vIqQhQA7sLKaaNiMlWWhdiFT5BurTk1/9e
         pLoZpJGsEsCm4YiGXel5vUs+bOQMsSjyrR7DbCtJUFbLr14Vz00AXXSkpjJoIbZKeUA7
         Jzwg==
X-Received: by 10.69.31.97 with SMTP id kl1mr33390741pbd.62.1392730879428;
        Tue, 18 Feb 2014 05:41:19 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id oa3sm56107633pbb.15.2014.02.18.05.41.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:32 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242309>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..fec9430 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -343,7 +343,7 @@ then
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"`git rev-parse --git-path objects`"}
 fi
=20
 peel_committish () {
--=20
1.8.5.2.240.g8478abd
