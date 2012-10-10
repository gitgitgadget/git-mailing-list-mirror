From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] attr: a note about the order of .gitattributes lookup
Date: Wed, 10 Oct 2012 20:55:52 +0700
Message-ID: <20121010135552.GA11293@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 15:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLwlj-0005a1-N6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 15:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315Ab2JJN4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 09:56:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45251 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab2JJN4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 09:56:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so620669pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=t4XKDGAPbBpfSApjpTMLV0mrCVrCxXlP3ZNTANIY2yQ=;
        b=ghRErM7bW0A9CKHE+vkZgyO1/p9Bc+2eg4Pk0RvDizHVIwmKfdKJRqW/a2sMnxb5eB
         lg+M0YMwgpVoEmzuIDWxRL2Q+Uip/vIu+cJ8PY9Zf/JSQT9FhB5a5eSZ+ccHGpM/fRZo
         M7jht4a8NJ2+73kKK9FcFkfpZGm+4dZ0nvihuj2lVSY+3lb0BRl4FnAcbNbtILkKu0F6
         67++cJNKbqqw0GIf5HfLsvP7NMPryGm16X3qfegS88ANz4QnyYRxCvr+/MF9GqNU5Dz7
         Djiwxt07/BfoWPMYg5PvhpCugBbX3Qi2VnMGAwFpPCHZDALwLYAZTAyBWYQN2PuE9vRq
         rsRA==
Received: by 10.66.86.133 with SMTP id p5mr62080333paz.35.1349877361653;
        Wed, 10 Oct 2012 06:56:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id n7sm897178pav.26.2012.10.10.06.55.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 06:56:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 20:55:52 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207410>

This is the documentation part of

1a9d7e9 (attr.c: read .gitattributes from index as well. - 2007-08-14)
06f33c1 (Read attributes from the index that is being checked out - 200=
9-03-13)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I looked around but did not see anywhere mentioning this. If I did
 not miss anything, then we should take a note about this to avoid
 surprises.

 Resend, this time git@vger is CCed. Sorry for the noise.

 Documentation/gitattributes.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 99ed04d..8c52a99 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -66,6 +66,12 @@ is from the path in question, the lower its preceden=
ce). Finally
 global and system-wide files are considered (they have the lowest
 precedence).
=20
+Normally if `.gitattributes` is not found in a directory in work tree,
+the same path in the index is examined. If there's a `.gitattributes`
+version in the index, that version will be used. During checkout proce=
ss,
+the order of examination is reversed: index version is preferred over
+the work tree version.
+
 If you wish to affect only a single repository (i.e., to assign
 attributes to files that are particular to
 one user's workflow for that repository), then
--=20
1.7.12.1.406.g6ab07c4
