From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH 2/4] Remove p4 rpm from git.spec.in.
Date: Sun, 15 Jul 2007 15:51:01 -0400
Message-ID: <20070715155101.af14204c.seanlkml@sympatico.ca>
References: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 21:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAA9l-0007rP-72
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 21:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXGOTxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXGOTxW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 15:53:22 -0400
Received: from bay0-omc2-s39.bay0.hotmail.com ([65.54.246.175]:53999 "EHLO
	bay0-omc2-s39.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120AbXGOTxV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 15:53:21 -0400
Received: from BAYC1-PASMTP12.bayc1.hotmail.com ([65.54.191.185]) by bay0-omc2-s39.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:53:21 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:53:36 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IAA9f-00016T-OQ
	for git@vger.kernel.org; Sun, 15 Jul 2007 15:53:19 -0400
In-Reply-To: <20070715154804.2877361d.seanlkml@sympatico.ca>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 19:53:36.0570 (UTC) FILETIME=[D50A99A0:01C7C719]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52582>


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 git.spec.in |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)


NOTE:  Unfortunately i have no way to test this here, anyone?


diff --git a/git.spec.in b/git.spec.in
index 27182ba..fe7b3d8 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -12,7 +12,7 @@ URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
 BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
-Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, git-p4, perl-Git
+Requires:	git-core, git-svn, git-cvs, git-arch, git-email, gitk, git-gui, perl-Git
 
 %description
 Git is a fast, scalable, distributed revision control system with an
@@ -53,13 +53,6 @@ Requires:       git-core = %{version}-%{release}, tla
 %description arch
 Git tools for importing Arch repositories.
 
-%package p4
-Summary:        Git tools for importing Perforce repositories
-Group:          Development/Tools
-Requires:       git-core = %{version}-%{release}, python
-%description p4
-Git tools for importing Perforce repositories.
-
 %package email
 Summary:        Git tools for sending email
 Group:          Development/Tools
@@ -95,14 +88,14 @@ Perl interface to Git
 %setup -q
 
 %build
-make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_P4IMPORT=YesPlease \
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" \
      ETC_GITCONFIG=/etc/gitconfig \
-     prefix=%{_prefix} PYTHON_PATH=%{python_path} all %{!?_without_docs: doc}
+     prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
-     WITH_P4IMPORT=YesPlease prefix=%{_prefix} mandir=%{_mandir} \
+     prefix=%{_prefix} mandir=%{_mandir} \
      ETC_GITCONFIG=/etc/gitconfig \
      PYTHON_PATH=%{python_path} \
      INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
@@ -110,10 +103,10 @@ find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 
-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "p4import|archimport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "archimport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 (find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "p4import|archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
@@ -145,13 +138,6 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
 %{!?_without_docs: %doc Documentation/git-archimport.html }
 
-%files p4
-%defattr(-,root,root)
-%doc Documentation/git-p4import.txt
-%{_bindir}/git-p4import
-%{!?_without_docs: %{_mandir}/man1/git-p4import.1*}
-%{!?_without_docs: %doc Documentation/git-p4import.html }
-
 %files email
 %defattr(-,root,root)
 %doc Documentation/*email*.txt
@@ -187,6 +173,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Sun Jul 15 2007 Sean Estabrooks <seanlkml@sympatico.ca>
+- Removed p4import.
+
 * Tue Jun 26 2007 Quy Tonthat <qtonthat@gmail.com>
 - Fixed problems looking for wrong manpages.
 
-- 
1.5.3.rc0.826.gc301a3

On Sun, 15 Jul 2007 15:48:04 -0400
Sean <seanlkml@sympatico.ca> wrote:

> Hi Junio,
> 
> Having caught up on some list emails, it appears that Git now has a
> much better option for importing from Perforce in the git-p4 front
> end to fast-import.
> 
> Is there anyone out there actually even using git-p4import?  It was
> written for a very specific case, by a git wannabe hacker who had
> never used Perforce before, and not intended for inclusion in Git
> proper...
> 
> My guess is that it could be removed outright without pain to anyone,
> but as a first step, it could be moved into contrib for 1.5.3.
> 
> Sean
> 
