From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] sh-18n: quell "unused variable" warning
Date: Wed, 25 May 2011 11:55:43 +0200
Message-ID: <62c2e1619edcb37c0411f29a34b6bc10e3899a97.1306317312.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 11:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPApK-0007R8-UV
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 11:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1EYJzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 05:55:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45401 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753315Ab1EYJzt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 05:55:49 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B0A742092A;
	Wed, 25 May 2011 05:55:48 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 25 May 2011 05:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=smtpout; bh=gcRPtU+/CyBx7FmTOCZXTRINPBo=; b=o8HNgliREKratNVPkUfZfgmTG4sKi/1P144ScwIYuTtsUFsqnt3fsWnWRzC6WLhZWYgobsoxDzhUJ9aLgoi2xUPugMFSAdwrTmafgV+kPbpiAw1C6ZY0NBTl12pp69V5MzLcgINliuZk4Q1K3ac2aGQ+d3GzkZjPsvu/UTRZ9vk=
X-Sasl-enc: 2L4j+nlBsqkFOWbmPbs0XejfHaW0EAgkvB9nOnxf2TiE 1306317348
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3854544059E;
	Wed, 25 May 2011 05:55:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.639.gce8e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174378>

    CC sh-i18n--envsubst.o
sh-i18n--envsubst.c: In Funktion =C2=BBmain=C2=AB:
sh-i18n--envsubst.c:71:22: Warnung: Variable =C2=BBshow_variables=C2=AB=
 gesetzt,
aber nicht verwendet [-Wunused-but-set-variable]

show_variables is indeed unused. Comment it out rather than remove it s=
o
that the relation with upstream remains clear.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Why is it that even with LANG=3DC exported, gcc gives localized warning=
s?

And yes, I'm on gcc 4.6 now (F15)...
---
 sh-i18n--envsubst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 7125093..2eb0ee4 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -68,7 +68,7 @@ int
 main (int argc, char *argv[])
 {
   /* Default values for command line options.  */
-  unsigned short int show_variables =3D 0;
+  /* unsigned short int show_variables =3D 0; */
=20
   switch (argc)
 	{
@@ -88,7 +88,7 @@ main (int argc, char *argv[])
 	  /* git sh-i18n--envsubst --variables '$foo and $bar' */
 	  if (strcmp(argv[1], "--variables"))
 		error ("first argument must be --variables when two are given");
-	  show_variables =3D 1;
+	  /* show_variables =3D 1; */
       print_variables (argv[2]);
 	  break;
 	default:
--=20
1.7.5.2.639.gce8e1
