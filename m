From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/16] enter_repo(): initialize other variables as setup_git_directory_gently() does
Date: Thu, 11 Mar 2010 20:22:20 +0700
Message-ID: <1268313754-28179-3-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMd-0001K7-Ny
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab0CKNWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:22:54 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45113 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:22:53 -0500
Received: by pwi1 with SMTP id 1so9227pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CQWyAqWZKZlDPTCvHu/TTOeev6J2O0hl2dV7LK7ZkIQ=;
        b=Xo++lzBno6FwBh5rstKrg70R9fXTreFiofC7hnFsCL/n5iZuGl3EPCi0QXvlzIFUoW
         k3RrNDM22geP9QK1hLrjpyxXNwXuLSiW9dNBFyq68Pni+4A9iS9d82yLxOK8c7Qri4/6
         j8pSJN1bl/TKv2Hfsxr+ouE9BEVVKKq7hoLvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jXW111MF5p9ZhJ3c0MJ9t0IWz4zFm9jshrTI0zyUfRCzAn67aQA/ndRlrGY0cGFAT+
         bxcTcDRN9601dEiBmIXUqE8ES7A/4Y4TP4MMI4Tw3VT7CavbAkirIN3kZ/msAIpFZy3J
         eB5BQuxmqdf+Ad4iUwXlI1glVQxQfDCtMuZ9w=
Received: by 10.140.247.21 with SMTP id u21mr1757727rvh.250.1268313771465;
        Thu, 11 Mar 2010 05:22:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8774671pzk.10.2010.03.11.05.22.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:22:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:22:46 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141963>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 3019da2..e067292 100644
--- a/setup.c
+++ b/setup.c
@@ -535,8 +535,14 @@ char *enter_repo(char *path, int strict)
=20
 	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
 	    validate_headref("HEAD") =3D=3D 0) {
-		set_git_dir(".");
+		inside_work_tree =3D 0;
+		inside_git_dir =3D 1;
 		check_repository_format();
+		set_git_dir(".");
+		if (startup_info) {
+			startup_info->prefix =3D NULL;
+			startup_info->have_repository =3D 1;
+		}
 		return path;
 	}
=20
--=20
1.7.0.1.384.g6abcaa
