From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/16] apply: do not check sha1 when repository has not been found
Date: Thu, 11 Mar 2010 20:22:30 +0700
Message-ID: <1268313754-28179-13-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMk-0001K7-FD
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab0CKNXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:49 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48003 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0CKNXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:47 -0500
Received: by pvb32 with SMTP id 32so5769pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qH8px+H8y+X3FN+m/i1ab8CUwCjxgaxs6NBlqk3EEXQ=;
        b=GbcWSsTX/9Z20U/XEbjzzfv1rXmXFcH+s6AVBwp1UMe6zU22gygeqnbYv95bMZUGiN
         O1LXpd7HaGhxv+ucFPAs4YRyM778wUtCrAKN9LMtLGViw+F8R6Cut4Qx95jgco7J3sYw
         TjYat9+zGO1BIMYNfyIx8aOzIW1re5kDM4m5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tXT0gsjLgwQLvKfCsevLBgFD2rd4awbx5IR57mjh5eQtD46I4R48XPOT58XIk0a0Bx
         3NWSL+DICcxHdXpSIyLxeJn7EVUfRvSb3k7xJu+kLxtY1TanhToNdQrW09F1SwMrsiBv
         3sB4SVuCiFtQ8j+uETSd3pfJgT1DQftfanWjA=
Received: by 10.140.247.19 with SMTP id u19mr1735119rvh.263.1268313826154;
        Thu, 11 Mar 2010 05:23:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 20sm2780125pzk.11.2010.03.11.05.23.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:41 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141974>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d27aac6..ea7bf57 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2441,7 +2441,7 @@ static int apply_binary(struct image *img, struct=
 patch *patch)
 		return 0; /* deletion patch */
 	}
=20
-	if (has_sha1_file(sha1)) {
+	if (startup_info->have_repository && has_sha1_file(sha1)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
--=20
1.7.0.1.384.g6abcaa
