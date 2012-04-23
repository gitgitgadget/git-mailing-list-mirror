From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/10] Makefile: feed all header files to xgettext
Date: Mon, 23 Apr 2012 19:30:21 +0700
Message-ID: <1335184230-8870-2-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIT5-0005J3-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab2DWMeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:06 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33527 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2DWMeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:04 -0400
Received: by dadz8 with SMTP id z8so15499270dad.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mLtT9/ofIjc3vVivc2degaM7j5SpDUywSNxcNMcMTsA=;
        b=DiPH/aZhQsri1ocQtfJ7hQUzLQHqV77gZP7A0thGG1RlF+nkCIBMfCbVq2DVSesv6w
         HnbkFzjxlVe52+SDUV+Jkn6RrBLphmwRZBaKLr4gPZPLsv8/PxwBQSaZXwPPEAW13Mym
         W6GsXFT1mGHzykJunG62aHnyELnuF92VSLPNsvwqZx5vwNN9RJkOPVStt9dM+haa6Oyp
         9Sv2cUPcwcMdB1RFCgKbHvab4TEDuSGqA22QReD8VU4cfCBED09DXWpfbVt0rT5huEo+
         iocNKqRIZ9BPtklExKuOQQ/WrYXqPMtbmVYSL9953Q1u07GPt8WULhGuCqYWqslzzA0Y
         ZUgw==
Received: by 10.68.189.231 with SMTP id gl7mr36455673pbc.151.1335184443171;
        Mon, 23 Apr 2012 05:34:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id ih3sm18807pbc.10.2012.04.23.05.33.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:30:45 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196115>

Translation markers may be present in header files too. Make sure we
don't miss any.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index be1957a..dab7362 100644
--- a/Makefile
+++ b/Makefile
@@ -386,6 +386,7 @@ XDIFF_OBJS =3D
 VCSSVN_H =3D
 VCSSVN_OBJS =3D
 VCSSVN_TEST_OBJS =3D
+MISC_H =3D
 EXTRA_CPPFLAGS =3D
 LIB_H =3D
 LIB_OBJS =3D
@@ -543,6 +544,35 @@ LIB_FILE=3Dlibgit.a
 XDIFF_LIB=3Dxdiff/lib.a
 VCSSVN_LIB=3Dvcs-svn/lib.a
=20
+XDIFF_H +=3D xdiff/xinclude.h
+XDIFF_H +=3D xdiff/xmacros.h
+XDIFF_H +=3D xdiff/xdiff.h
+XDIFF_H +=3D xdiff/xtypes.h
+XDIFF_H +=3D xdiff/xutils.h
+XDIFF_H +=3D xdiff/xprepare.h
+XDIFF_H +=3D xdiff/xdiffi.h
+XDIFF_H +=3D xdiff/xemit.h
+
+VCSSVN_H +=3D vcs-svn/line_buffer.h
+VCSSVN_H +=3D vcs-svn/sliding_window.h
+VCSSVN_H +=3D vcs-svn/repo_tree.h
+VCSSVN_H +=3D vcs-svn/fast_export.h
+VCSSVN_H +=3D vcs-svn/svndiff.h
+VCSSVN_H +=3D vcs-svn/svndump.h
+
+MISC_H +=3D branch.h
+MISC_H +=3D bundle.h
+MISC_H +=3D bisect.h
+MISC_H +=3D fetch-pack.h
+MISC_H +=3D thread-utils.h
+MISC_H +=3D send-pack.h
+MISC_H +=3D shortlog.h
+MISC_H +=3D reachable.h
+MISC_H +=3D wt-status.h
+MISC_H +=3D tar.h
+MISC_H +=3D url.h
+MISC_H +=3D walker.h
+
 LIB_H +=3D advice.h
 LIB_H +=3D archive.h
 LIB_H +=3D argv-array.h
@@ -2170,24 +2200,8 @@ connect.o transport.o url.o http-backend.o: url.=
h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
-XDIFF_H +=3D xdiff/xinclude.h
-XDIFF_H +=3D xdiff/xmacros.h
-XDIFF_H +=3D xdiff/xdiff.h
-XDIFF_H +=3D xdiff/xtypes.h
-XDIFF_H +=3D xdiff/xutils.h
-XDIFF_H +=3D xdiff/xprepare.h
-XDIFF_H +=3D xdiff/xdiffi.h
-XDIFF_H +=3D xdiff/xemit.h
-
 xdiff-interface.o $(XDIFF_OBJS): $(XDIFF_H)
=20
-VCSSVN_H +=3D vcs-svn/line_buffer.h
-VCSSVN_H +=3D vcs-svn/sliding_window.h
-VCSSVN_H +=3D vcs-svn/repo_tree.h
-VCSSVN_H +=3D vcs-svn/fast_export.h
-VCSSVN_H +=3D vcs-svn/svndiff.h
-VCSSVN_H +=3D vcs-svn/svndump.h
-
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) $(VCSSVN_H)
 endif
=20
@@ -2282,7 +2296,7 @@ XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=
=3DC \
 	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
 XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell
 XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --keyword=3D__ --language=3D=
Perl
-LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
+LOCALIZED_C :=3D $(C_OBJ:o=3Dc) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(MISC=
_H)
 LOCALIZED_SH :=3D $(SCRIPT_SH)
 LOCALIZED_PERL :=3D $(SCRIPT_PERL)
=20
--=20
1.7.8.36.g69ee2
