From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/15] Makefile: "pot" target to extract messages marked for
 translation
Date: Mon, 21 Feb 2011 04:15:30 -0600
Message-ID: <20110221101530.GE32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:15:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSns-00014T-VY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1BUKPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:15:36 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39038 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab1BUKPf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:15:35 -0500
Received: by iwn8 with SMTP id 8so1726888iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L2fedx0QcZhSTmGaoxJiKlvB4ceOfYgGFtS4GjJfDYg=;
        b=fHeoiK2DxA0d+5hvqwTW1GMsZUAIpJp3J0UrTC8IeBsicbr65XAXl3ij32EPWNaUO/
         +9TsfEp4cUqo9/6fnSoKYnBBS8EBjH+UNjBw/YyU+xFE7ZSZCwNEcySJpgnN7Jtp9KZ3
         9NXqpaf3vcOcLlpGab8iTWVWT3+A1trK+CYsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OriphjHffDSwMjfra1Rpiow4lv+MjbqiE6/akNM+nmcf4HPB/HKV8TI3KT3aYD6Ga5
         DAVkIgtymgBNQP8qhbjwZQf+91sqZkFWsm7T43y88xfIMe/uql/V3Z2+1g8K2EyhZ/Kr
         ng+GrE6hiGvOB6gFq1cWK0LYGkw7tIwk6W2vc=
Received: by 10.42.180.194 with SMTP id bv2mr1753292icb.171.1298283335366;
        Mon, 21 Feb 2011 02:15:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id d21sm5038729ibg.9.2011.02.21.02.15.33
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:15:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167456>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Tue, 31 Aug 2010 16:35:16 +0000

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
1.7.4.1
