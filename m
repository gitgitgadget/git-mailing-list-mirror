From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: stop pretending to support rpmbuild
Date: Mon, 04 Apr 2016 23:51:54 -0700
Message-ID: <xmqqy48s35v9.fsf_-_@gitster.mtv.corp.google.com>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
	<CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
	<20160402161636.GD13271@zaya.teonanacatl.net>
	<xmqqshz3fjeu.fsf_-_@gitster.mtv.corp.google.com>
	<1459794001.19561.10.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Todd Zullinger <tmz@pobox.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	=?utf-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>,
	Ron Isaacson <isaacson.ljits@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 08:53:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anKrb-0006hU-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 08:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbcDEGv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 02:51:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbcDEGv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 02:51:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBF074B4FD;
	Tue,  5 Apr 2016 02:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gr3vPvmhFLhe
	L6sa0J4geyVMkQE=; b=CyGnuBkDJcONkn5Z5kYWlCu1xn0WzisspfztKEK1391P
	L8RxbctZ5aYcSwEMAOhAlr7Hps+IPRymNyZymm3YusOnGBotMasbx7VFT94BIVZQ
	3JrkK2X0xIGk6TW8ufKA08l881RcfOxblT6I34JFN0XGxloEBOPu+AdJt5b/6Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m1VJpt
	s/KGFsOkpT9a94iQhUBiK3LcxugTRrelz4LUwxtvmtWV57k8b7jScMGZ6XzRc+NJ
	Q9UAY7aO4qbdthfFfdDd5mUCU6xFUKJCAyf1vpbIhNjmLrCIOI9eUglihcQCMm9e
	cAyD4T8MjmnGj1LuyoQw2IXlCn3v8vv0UzYtg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E310E4B4FC;
	Tue,  5 Apr 2016 02:51:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1FA8A4B4FB;
	Tue,  5 Apr 2016 02:51:55 -0400 (EDT)
In-Reply-To: <1459794001.19561.10.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Mon, 04 Apr 2016 20:20:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E26B50F2-FAFA-11E5-8992-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290765>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On za, 2016-04-02 at 20:41 -0700, Junio C Hamano wrote:
>> I think by now it is very clear that nobody active in the Git
>> development community tests RPM binaries built with git.spec.in we
>> have in our tree. I suspect RPM based distros are using their own
>> RPM build recipe without paying any attention to what we have in our
>> tree, and that is why no packager from RPM land gave any bug report
>> and correction before the release happened.
>
> Fedora, RHEL, CentOS, OpenSUSE and Mageia all use their own specfiles
> and local patches. I do test and distribute RPM packages based on the
> next branch, but use fedora's packaging to do so (which incidentally
> also broke and I had to work around this change, but I completely
> forgot about git.spec.in).
>
>> I'd propose that during the cycle for the next feature release, we'd
>> remove git.spec.in and stop pretending as if we support RPM
>> packaging.
>
> I would be in favor of that. In general, I find it much better to use=
 a
> distro's packaging and simply transplanting a tarball into it. That
> keeps the difference with what the distro provides minimal.

OK, while we wait for other people to raise their opinions, here is
to prepare for the removal, if we decide to follow through.

-- >8 --
Nobody in the active development community seems to watch breakages
in the rpmbuild target.  As most major RPM based distros use their
own specfile when packaging us, they aren't looking after us as
their pristine upstream tree, either.  At this point, it is turning
to be a disservice to the users to pretend that our tree natively
supports "make rpmbuild" target when we do not properly maintain it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile    |  17 +---
 git.spec.in | 330 ----------------------------------------------------=
--------
 2 files changed, 5 insertions(+), 342 deletions(-)

diff --git a/Makefile b/Makefile
index 2742a69..23182bc 100644
--- a/Makefile
+++ b/Makefile
@@ -443,7 +443,6 @@ DIFF =3D diff
 TAR =3D tar
 FIND =3D find
 INSTALL =3D install
-RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 XGETTEXT =3D xgettext
@@ -2396,31 +2395,25 @@ quick-install-html:
=20
 ### Maintainer's dist rules
=20
-git.spec: git.spec.in GIT-VERSION-FILE
-	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
-	mv $@+ $@
-
 GIT_TARNAME =3D git-$(GIT_VERSION)
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=3Dtar \
 		--prefix=3D$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
-	@cp git.spec configure $(GIT_TARNAME)
+	@cp configure $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
 	@$(MAKE) -C git-gui TARDIR=3D../$(GIT_TARNAME)/git-gui dist-version
 	$(TAR) rf $(GIT_TARNAME).tar \
-		$(GIT_TARNAME)/git.spec \
 		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
=20
-rpm: dist
-	$(RPMBUILD) \
-		--define "_source_filedigest_algorithm md5" \
-		--define "_binary_filedigest_algorithm md5" \
-		-ta $(GIT_TARNAME).tar.gz
+rpm::
+	@echo >&2 "Use distro packaged sources to run rpmbuild"
+	@false
+.PHONY: rpm
=20
 htmldocs =3D git-htmldocs-$(GIT_VERSION)
 manpages =3D git-manpages-$(GIT_VERSION)
diff --git a/git.spec.in b/git.spec.in
deleted file mode 100644
index d61d537..0000000
--- a/git.spec.in
+++ /dev/null
@@ -1,330 +0,0 @@
-# Pass --without docs to rpmbuild if you don't want the documentation
-
-Name: 		git
-Version: 	@@VERSION@@
-Release: 	1%{?dist}
-Summary:  	Core git tools
-License: 	GPL
-Group: 		Development/Tools
-URL: 		http://kernel.org/pub/software/scm/git/
-Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar=
=2Egz
-BuildRequires:	zlib-devel >=3D 1.2, openssl-devel, curl-devel, expat-d=
evel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
-BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} =
-n)
-
-Requires:	perl-Git =3D %{version}-%{release}
-Requires:	zlib >=3D 1.2, rsync, less, openssh-clients, expat
-Provides:	git-core =3D %{version}-%{release}
-Obsoletes:	git-core <=3D 1.5.4.2
-Obsoletes:	git-p4
-
-%description
-Git is a fast, scalable, distributed revision control system with an
-unusually rich command set that provides both high-level operations
-and full access to internals.
-
-The git rpm installs the core tools with minimal dependencies.  To
-install all git packages, including tools for integrating with other
-SCMs, install the git-all meta-package.
-
-%package all
-Summary:	Meta-package to pull in all git tools
-Group:		Development/Tools
-Requires:	git =3D %{version}-%{release}
-Requires:	git-svn =3D %{version}-%{release}
-Requires:	git-cvs =3D %{version}-%{release}
-Requires:	git-arch =3D %{version}-%{release}
-Requires:	git-email =3D %{version}-%{release}
-Requires:	gitk =3D %{version}-%{release}
-Requires:	gitweb =3D %{version}-%{release}
-Requires:	git-gui =3D %{version}-%{release}
-Obsoletes:	git <=3D 1.5.4.2
-
-%description all
-Git is a fast, scalable, distributed revision control system with an
-unusually rich command set that provides both high-level operations
-and full access to internals.
-
-This is a dummy package which brings in all subpackages.
-
-%package svn
-Summary:        Git tools for importing Subversion repositories
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}, subversion
-%description svn
-Git tools for importing Subversion repositories.
-
-%package cvs
-Summary:        Git tools for importing CVS repositories
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}, cvs, cvsps
-%description cvs
-Git tools for importing CVS repositories.
-
-%package arch
-Summary:        Git tools for importing Arch repositories
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}, tla
-%description arch
-Git tools for importing Arch repositories.
-
-%package email
-Summary:        Git tools for sending email
-Group:          Development/Tools
-Requires:	git =3D %{version}-%{release}
-%description email
-Git tools for sending email.
-
-%package gui
-Summary:        Git GUI tool
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
-%description gui
-Git GUI tool
-
-%package -n gitk
-Summary:        Git revision tree visualiser ('gitk')
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}, tk >=3D 8.4
-%description -n gitk
-Git revision tree visualiser ('gitk')
-
-%package -n gitweb
-Summary:	Git web interface
-Group:          Development/Tools
-Requires:       git =3D %{version}-%{release}
-%description -n gitweb
-Browsing git repository on the web
-
-%package -n perl-Git
-Summary:        Perl interface to Git
-Group:          Development/Libraries
-Requires:       git =3D %{version}-%{release}
-Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; e=
cho $version))
-BuildRequires:  perl(Error)
-BuildRequires:  perl(ExtUtils::MakeMaker)
-
-%description -n perl-Git
-Perl interface to Git
-
-%define path_settings ETC_GITCONFIG=3D/etc/gitconfig prefix=3D%{_prefi=
x} mandir=3D%{_mandir} htmldir=3D%{_docdir}/%{name}-%{version}
-%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from dist=
utils.sysconfig import get_python_lib; print get_python_lib()")}
-
-%prep
-%setup -q
-
-%build
-make %{_smp_mflags} CFLAGS=3D"$RPM_OPT_FLAGS" \
-     %{path_settings} \
-     all %{!?_without_docs: doc}
-
-%install
-rm -rf $RPM_BUILD_ROOT
-make %{_smp_mflags} CFLAGS=3D"$RPM_OPT_FLAGS" DESTDIR=3D$RPM_BUILD_ROO=
T \
-     %{path_settings} \
-     INSTALLDIRS=3Dvendor install %{!?_without_docs: install-doc}
-test ! -d $RPM_BUILD_ROOT%{python_sitelib} || rm -fr $RPM_BUILD_ROOT%{=
python_sitelib}
-find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
-find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
-find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
-
-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "archimport|svn|cvs=
|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROOT@@)         =
      > bin-man-doc-files
-(find $RPM_BUILD_ROOT%{_libexecdir}/git-core -type f | grep -vE "archi=
mport|svn|cvs|email|gitk|git-gui|git-citool" | sed -e s@^$RPM_BUILD_ROO=
T@@)               >> bin-man-doc-files
-(find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_=
ROOT@@) >> perl-files
-%if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f =
| grep -vE "archimport|svn|git-cvs|email|gitk|git-gui|git-citool" | sed=
 -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
-%else
-rm -rf $RPM_BUILD_ROOT%{_mandir}
-%endif
-rm -rf $RPM_BUILD_ROOT%{_datadir}/locale
-
-mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
-install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_RO=
OT%{_sysconfdir}/bash_completion.d/git
-
-%clean
-rm -rf $RPM_BUILD_ROOT
-
-%files -f bin-man-doc-files
-%defattr(-,root,root)
-%{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
-%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
-%{!?_without_docs: %doc Documentation/technical}
-%{_sysconfdir}/bash_completion.d
-
-%files svn
-%defattr(-,root,root)
-%{_libexecdir}/git-core/*svn*
-%doc Documentation/*svn*.txt
-%{!?_without_docs: %{_mandir}/man1/*svn*.1*}
-%{!?_without_docs: %doc Documentation/*svn*.html }
-
-%files cvs
-%defattr(-,root,root)
-%doc Documentation/*git-cvs*.txt
-%{_bindir}/git-cvsserver
-%{_libexecdir}/git-core/*cvs*
-%{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
-%{!?_without_docs: %doc Documentation/*git-cvs*.html }
-
-%files arch
-%defattr(-,root,root)
-%doc Documentation/git-archimport.txt
-%{_libexecdir}/git-core/git-archimport
-%{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
-%{!?_without_docs: %doc Documentation/git-archimport.html }
-
-%files email
-%defattr(-,root,root)
-%doc Documentation/*email*.txt
-%{_libexecdir}/git-core/*email*
-%{!?_without_docs: %{_mandir}/man1/*email*.1*}
-%{!?_without_docs: %doc Documentation/*email*.html }
-
-%files gui
-%defattr(-,root,root)
-%{_libexecdir}/git-core/git-gui
-%{_libexecdir}/git-core/git-citool
-%{_libexecdir}/git-core/git-gui--askpass
-%{_datadir}/git-gui/
-%{!?_without_docs: %{_mandir}/man1/git-gui.1*}
-%{!?_without_docs: %doc Documentation/git-gui.html}
-%{!?_without_docs: %{_mandir}/man1/git-citool.1*}
-%{!?_without_docs: %doc Documentation/git-citool.html}
-
-%files -n gitk
-%defattr(-,root,root)
-%doc Documentation/*gitk*.txt
-%{_bindir}/*gitk*
-%{_datadir}/gitk/
-%{!?_without_docs: %{_mandir}/man1/*gitk*.1*}
-%{!?_without_docs: %doc Documentation/*gitk*.html }
-
-%files -n gitweb
-%defattr(-,root,root)
-%doc gitweb/README gitweb/INSTALL Documentation/*gitweb*.txt
-%{_datadir}/gitweb
-%{!?_without_docs: %{_mandir}/man1/*gitweb*.1*}
-%{!?_without_docs: %{_mandir}/man5/*gitweb*.5*}
-%{!?_without_docs: %doc Documentation/*gitweb*.html }
-
-%files -n perl-Git -f perl-files
-%defattr(-,root,root)
-
-%files all
-# No files for you!
-
-%changelog
-* Sun Sep 18 2011 Jakub Narebski <jnareb@gmail.com>
-- Add gitweb manpages to 'gitweb' subpackage
-
-* Wed Jun 30 2010 Junio C Hamano <gitster@pobox.com>
-- Add 'gitweb' subpackage.
-
-* Fri Mar 26 2010 Ian Ward Comfort <icomfort@stanford.edu>
-- Ship bash completion support from contrib/ in the core package.
-
-* Sun Jan 31 2010 Junio C Hamano <gitster@pobox.com>
-- Do not use %define inside %{!?...} construct.
-
-* Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
-- We don't ship Python bits until a real foreign scm interface comes.
-
-* Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
-- fixed broken git help -w after renaming the git-core package to git.
-
-* Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
-- move git-cvsserver to bindir.
-
-* Sun Jun 15 2008 Junio C Hamano <gitster@pobox.com>
-- Remove curl from Requires list.
-
-* Fri Feb 15 2008 Kristian H=C3=B8gsberg <krh@redhat.com>
-- Rename git-core to just git and rename meta package from git to git-=
all.
-
-* Sun Feb 03 2008 James Bowes <jbowes@dangerouslyinc.com>
-- Add a BuildRequires for gettext
-
-* Fri Jan 11 2008 Junio C Hamano <gitster@pobox.com>
-- Include gitk message files
-
-* Sun Jan 06 2008 James Bowes <jbowes@dangerouslyinc.com>
-- Make the metapackage require the same version of the subpackages.
-
-* Wed Dec 12 2007 Junio C Hamano <gitster@pobox.com>
-- Adjust htmldir to point at /usr/share/doc/git-core-$version/
-
-* Sun Jul 15 2007 Sean Estabrooks <seanlkml@sympatico.ca>
-- Removed p4import.
-
-* Tue Jun 26 2007 Quy Tonthat <qtonthat@gmail.com>
-- Fixed problems looking for wrong manpages.
-
-* Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
-- Added documentation files for git-gui
-
-* Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
-- Added lib files for git-gui
-- Added Documentation/technical (As needed by Git Users Manual)
-
-* Tue May 8 2007 Quy Tonthat <qtonthat@gmail.com>
-- Added howto files
-
-* Tue Mar 27 2007 Eygene Ryabinkin <rea-git@codelabs.ru>
-- Added the git-p4 package: Perforce import stuff.
-
-* Mon Feb 13 2007 Nicolas Pitre <nico@fluxnic.net>
-- Update core package description (Git isn't as stupid as it used to b=
e)
-
-* Mon Feb 12 2007 Junio C Hamano <junkio@cox.net>
-- Add git-gui and git-citool.
-
-* Mon Nov 14 2005 H. Peter Anvin <hpa@zytor.com> 0.99.9j-1
-- Change subpackage names to git-<name> instead of git-core-<name>
-- Create empty root package which brings in all subpackages
-- Rename git-tk -> gitk
-
-* Thu Nov 10 2005 Chris Wright <chrisw@osdl.org> 0.99.9g-1
-- zlib dependency fix
-- Minor cleanups from split
-- Move arch import to separate package as well
-
-* Tue Sep 27 2005 Jim Radford <radford@blackbean.org>
-- Move programs with non-standard dependencies (svn, cvs, email)
-  into separate packages
-
-* Tue Sep 27 2005 H. Peter Anvin <hpa@zytor.com>
-- parallelize build
-- COPTS -> CFLAGS
-
-* Fri Sep 16 2005 Chris Wright <chrisw@osdl.org> 0.99.6-1
-- update to 0.99.6
-
-* Fri Sep 16 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
-- Linus noticed that less is required, added to the dependencies
-
-* Sun Sep 11 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
-- Updated dependencies
-- Don't assume manpages are gzipped
-
-* Thu Aug 18 2005 Chris Wright <chrisw@osdl.org> 0.99.4-4
-- drop sh_utils, sh-utils, diffutils, mktemp, and openssl Requires
-- use RPM_OPT_FLAGS in spec file, drop patch0
-
-* Wed Aug 17 2005 Tom "spot" Callaway <tcallawa@redhat.com> 0.99.4-3
-- use dist tag to differentiate between branches
-- use rpm optflags by default (patch0)
-- own %{_datadir}/git-core/
-
-* Mon Aug 15 2005 Chris Wright <chrisw@osdl.org>
-- update spec file to fix Buildroot, Requires, and drop Vendor
-
-* Sun Aug 07 2005 Horst H. von Brand <vonbrand@inf.utfsm.cl>
-- Redid the description
-- Cut overlong make line, loosened changelog a bit
-- I think Junio (or perhaps OSDL?) should be vendor...
-
-* Thu Jul 14 2005 Eric Biederman <ebiederm@xmission.com>
-- Add the man pages, and the --without docs build option
-
-* Wed Jul 7 2005 Chris Wright <chris@osdl.org>
-- initial git spec file
