From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec
Date: Tue, 27 Mar 2007 12:03:43 -0400
Message-ID: <20070327160343.GA1884@170.242.249.10.in-addr.arpa>
References: <20070327112514.GC14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 18:04:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWE9u-0004KS-Aa
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbXC0QDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbXC0QDs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:03:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:58473 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690AbXC0QDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:03:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id A893B1FFC157
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 16:03:46 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <20070327112514.GC14837@codelabs.ru>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43277>

We don't have a copy of subprocess.py anymore, so we removed that
option from the Makefile.  Let's not leave that cruft around the RPM
spec file either.
---

This applies on top of "[PATCH] Added git-p4 package to the list of git
RPMs.", which is what made me notice that it was there.  Untested, but
simply removing a completely unused option from the make command line
shouldn't cause any problems, right?  Right?

 git.spec.in |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index e469f21..4bf7a8f 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -92,15 +92,14 @@ Perl interface to Git
 %setup -q
 
 %build
-make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     WITH_P4IMPORT=YesPlease prefix=%{_prefix} all %{!?_without_docs: doc}
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_P4IMPORT=YesPlease \
+     prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
-     WITH_OWN_SUBPROCESS_PY=YesPlease WITH_P4IMPORT=YesPlease \
-     prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
-     install %{!?_without_docs: install-doc}
+     WITH_P4IMPORT=YesPlease prefix=%{_prefix} mandir=%{_mandir} \
+     INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
-- 
1.5.1.rc2
