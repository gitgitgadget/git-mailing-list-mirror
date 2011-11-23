From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] revert: do not pass non-literal string as format to git_path()
Date: Wed, 23 Nov 2011 19:45:36 +0700
Message-ID: <1322052336-13619-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 13:45:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTCD4-0003xg-77
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 13:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab1KWMpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 07:45:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65111 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1KWMpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 07:45:49 -0500
Received: by iage36 with SMTP id e36so1528822iag.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5uzEIQzDOMc2dPxpcOeRczZR+z0vwVbQzRo6mWmmcK8=;
        b=OTXKlxtNpYvz6NPSay6ehYClIqDeedq8v/e7u8F+tkzlQAs6ZjawyQeRwJTP/z/ULW
         kKCbIE0cchVNvSkpRd/3dGjRM3ROJQXv1ijVIAeqrQReBifWePAFZdxyBRDp4ukvzKsG
         YRW5pOU2YopVx0s23bHFTXz6eUFMxKCGszGtg=
Received: by 10.42.154.7 with SMTP id o7mr2764764icw.48.1322052348808;
        Wed, 23 Nov 2011 04:45:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.52.218])
        by mx.google.com with ESMTPS id wo4sm41106568igc.5.2011.11.23.04.45.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 04:45:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Nov 2011 19:45:39 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185847>

This fixes the following warning.

    CC builtin/revert.o
builtin/revert.c: In function =E2=80=98write_cherry_pick_head=E2=80=99:
builtin/revert.c:311: warning: format not a string literal and no forma=
t arguments

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0c61668..9b9b2e5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -308,7 +308,7 @@ static void write_cherry_pick_head(struct commit *c=
ommit, const char *pseudoref)
=20
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
=20
-	filename =3D git_path(pseudoref);
+	filename =3D git_path("%s", pseudoref);
 	fd =3D open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
--=20
1.7.4.74.g639db
