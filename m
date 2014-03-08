From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 12/28] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sat,  8 Mar 2014 09:48:04 +0700
Message-ID: <1394246900-31535-13-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7K8-0005La-CG
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbaCHCtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:11 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44598 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCtI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:08 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so4906283pab.8
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CfinsYHbp9mjCE/lgXyvLA6bs+HQpWLMyh7YD0s5m0c=;
        b=yW99FEprM0uMN7I/zPNfwAE3BYzJJPHjcOsEIDBujHuDGgBeP/f1YCxNk3bs2kRSZV
         Swn3rznUuK1lpc7MjVnNDUskFqRvdMS7iZeFdALYjKiavNCpgkCURDSN3HEUW2S5e993
         nO5KOiMHD3Mtw8MdeHTB9hLCbGO27nw6nYcEKevEVH0+ZinAIf8ZOSVWvvc2GRnH+q8m
         vvbBLtxeOR0hMDz1pnbALpzc56VOsNaMFLU53AmQroPCRWLud1FS4N12qvxaxv0LLq6i
         hay4lVmz+ByFmcVESlLg5HWcZx25GN56MZX5fDSdeabQSQpsan+RANvitXrwEa4CTbK4
         xrQg==
X-Received: by 10.66.66.66 with SMTP id d2mr26163494pat.80.1394246948634;
        Fri, 07 Mar 2014 18:49:08 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id vx10sm18720574pac.17.2014.03.07.18.49.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:41 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243653>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..475ca43 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -343,7 +343,7 @@ then
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"$(git rev-parse --git-path objects)"}
 fi
=20
 peel_committish () {
--=20
1.9.0.40.gaa8c3ea
