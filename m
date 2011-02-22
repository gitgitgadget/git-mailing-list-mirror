From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 04/73] Makefile: "pot" target to extract messages marked for translation
Date: Tue, 22 Feb 2011 23:41:23 +0000
Message-ID: <1298418152-27789-5-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wx-0001H8-HD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1BVXno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:44 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab1BVXne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:34 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Q16HALI07iFEvPeBj6jmTlHI6OU0GVMnoHFedL4UQhs=;
        b=Nmdn0LtweZoXOEsS946pCOnzm2w5axGeEk75MB3zgxUdKXEnjdUvSC8gStMvjK7rZE
         JyT2dnAxV35ygOouDuNGo/miVpa6Lwf/rwAqpP9vSGS/x9WZCtmi9TsMMktHL6WLpp1D
         fq7eHxHcpXsP/dls492Ot45HtJGNfmjCz4JDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cSF6AnOPoLsCLFZf52r09k5kaNrdpOulNj5H+x/1Slnieq9lTkS0GnRRZ6AVnW3iEc
         H4xIv3ZIer4V2YB6QK7PcekrjXOmqktgkIcpbOOPqwdSTI3XSluEf/Kd97UgStzdndKD
         Bd1KYpLIcuy1Z52p5yE9l7bkMz0/4p1Cd62tE=
Received: by 10.204.33.70 with SMTP id g6mr3036670bkd.177.1298418213862;
        Tue, 22 Feb 2011 15:43:33 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.33
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:33 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167655>

Add rules to generate a template (po/git.pot) listing messages marked
for translation in the C portion of git.

To get started translating, just run "make pot".

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |   16 ++++++++++++++++
 po/.gitignore |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 po/.gitignore

diff --git a/Makefile b/Makefile
index 4e9d935..1cc6c60 100644
--- a/Makefile
+++ b/Makefile
@@ -321,6 +321,7 @@ INSTALL =3D install
 RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
+XGETTEXT =3D xgettext
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
 GCOV =3D gcov
@@ -1590,6 +1591,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_XGETTEXT =3D @echo '   ' XGETTEXT $@;
 	QUIET_GCOV     =3D @echo '   ' GCOV $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2057,6 +2059,20 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
=20
+XGETTEXT_FLAGS =3D \
+	--force-po \
+	--add-comments \
+	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
+	--from-code=3DUTF-8
+XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ --=
language=3DC
+LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
+
+po/git.pot: $(LOCALIZED_C)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)=
 && \
+	mv $@+ $@
+
+pot: po/git.pot
+
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
diff --git a/po/.gitignore b/po/.gitignore
new file mode 100644
index 0000000..a242a86
--- /dev/null
+++ b/po/.gitignore
@@ -0,0 +1 @@
+/git.pot
--=20
1.7.2.3
