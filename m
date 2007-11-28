From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/2] Link porcelain commands from gitexecdir to bindir
Date: Wed, 28 Nov 2007 23:26:29 +0700
Message-ID: <20071128162629.GA5453@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 17:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPkX-0001WU-FK
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758465AbXK1Q0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbXK1Q0i
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:26:38 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:60986 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758621AbXK1Q0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:26:37 -0500
Received: by an-out-0708.google.com with SMTP id d31so311192and
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=as5XgKJREcGV2tqULNjbIqNDa8iZYf91OXSivgrhxrY=;
        b=n/nyWyb4FXaewbVaL7e1voOsJ6k7SsPzfu8ZX02Y0iDOP5sDV7s1xgwBBMDzwSGpk3TMQZiFV+ZCQxAQlZGUJZRqaqgLQXtTpbN6KbLWjQ6C2Y0kaDip/c9Uiwlb/Y9lWpAjVv7R8dWEuTbVpdAxqSN6ZKyTX450VD5dZD4MF3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=bmzTycR8mhvyFPQVVGri9uo7jJY9jmPmX1q8RbjXPmNs4mHb2384ZyVxfcVOWCPv1Vcs4pSwafBKzjyR76WFiOvDlJNyYAjRZ177iQPWTdQ8rBZnuKKUw46dJxzSg6D3oE2zilFKAlOlT92G6uphoZeUun8rDjMTSxssiRxIYKU=
Received: by 10.100.171.10 with SMTP id t10mr9362212ane.1196267194655;
        Wed, 28 Nov 2007 08:26:34 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.8])
        by mx.google.com with ESMTPS id c23sm2481196ana.2007.11.28.08.26.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 08:26:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 28 Nov 2007 23:26:29 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66372>

This also adds variable my_porcelains. If you are not happy
with the default porcelain list, you can add your favourite
commands too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The porcelain list needs eyeballs.

 Makefile    |   15 +++++++++++++++
 git.spec.in |    6 ++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3cf791f..0ab1569 100644
--- a/Makefile
+++ b/Makefile
@@ -262,6 +262,17 @@ BUILT_INS =3D \
 	git-fsck-objects$X git-cherry-pick$X git-status$X\
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
=20
+PORCELAINS =3D \
+	add$X am annotate$X apply$X archive$X bisect blame$X \
+	branch$X bundle$X checkout cherry-pick$X citool$X clean$X \
+	clone commit$X config$X cvsimport archimport \
+	daemon$X describe$X diff$X fetch$X format-patch$X fsck$X \
+	gc$X grep$X gui$X init$X instaweb log$X lost-found \
+	merge mergetool mv$X name-rev$X pull push$X quiltimport \
+	rebase remote rerere$X reset$X revert$X rm$X send-email \
+	show$X stash status submodule svn tag$X var$X \
+	whatchanged$X $(my_porcelains)
+
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS =3D $(PROGRAMS) $(SCRIPTS)
=20
@@ -1034,6 +1045,10 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS=
) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
+	if test 'z$(bindir_SQ)' !=3D 'z$(gitexecdir_SQ)'; \
+	then \
+		$(foreach p,$(PORCELAINS), ln -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-=
$p' '$(DESTDIR_SQ)$(bindir_SQ)/git-$p' || cp '$(DESTDIR_SQ)$(gitexecdir=
_SQ)/git-$p' '$(DESTDIR_SQ)$(bindir_SQ)/git-$p';) \
+	fi
 	./check_bindir 'z$(bindir_SQ)' 'z$(gitexecdir_SQ)' '$(DESTDIR_SQ)$(bi=
ndir_SQ)/git-shell$X'
=20
 install-doc:
diff --git a/git.spec.in b/git.spec.in
index b6637a7..6830b03 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -121,6 +121,7 @@ rm -rf $RPM_BUILD_ROOT
=20
 %files svn
 %defattr(-,root,root)
+%{_bindir}/*svn*
 %{_libexecdir}/git-core/*svn*
 %doc Documentation/*svn*.txt
 %{!?_without_docs: %{_mandir}/man1/*svn*.1*}
@@ -129,6 +130,7 @@ rm -rf $RPM_BUILD_ROOT
 %files cvs
 %defattr(-,root,root)
 %doc Documentation/*git-cvs*.txt
+%{_bindir}/*cvs*
 %{_libexecdir}/git-core/*cvs*
 %{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
 %{!?_without_docs: %doc Documentation/*git-cvs*.html }
@@ -136,6 +138,7 @@ rm -rf $RPM_BUILD_ROOT
 %files arch
 %defattr(-,root,root)
 %doc Documentation/git-archimport.txt
+%{_bindir}/git-archimport
 %{_libexecdir}/git-core/git-archimport
 %{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
 %{!?_without_docs: %doc Documentation/git-archimport.html }
@@ -143,13 +146,16 @@ rm -rf $RPM_BUILD_ROOT
 %files email
 %defattr(-,root,root)
 %doc Documentation/*email*.txt
+%{_bindir}/*email*
 %{_libexecdir}/git-core/*email*
 %{!?_without_docs: %{_mandir}/man1/*email*.1*}
 %{!?_without_docs: %doc Documentation/*email*.html }
=20
 %files gui
 %defattr(-,root,root)
+%{_bindir}/git-gui
 %{_libexecdir}/git-core/git-gui
+%{_bindir}/git-citool
 %{_libexecdir}/git-core/git-citool
 %{_datadir}/git-gui/
 %{!?_without_docs: %{_mandir}/man1/git-gui.1*}
--=20
1.5.3.6.2041.g106f-dirty
