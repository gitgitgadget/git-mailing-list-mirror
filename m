From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec
Date: Thu, 29 Mar 2007 10:37:03 -0400
Message-ID: <20070329143703.GA17854@170.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 16:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvkt-0006q9-Jt
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbXC2OhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbXC2OhI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:37:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37512 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbXC2OhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:37:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 6E8621FFC143
	for <git@vger.kernel.org>; Thu, 29 Mar 2007 14:37:06 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43436>

We don't have a copy of subprocess.py anymore, so we removed that
option from the Makefile.  Let's not leave that cruft around the RPM
spec file either.
---

Resend of earlier patch, this time on top of 'master' instead of a
random patch from the list.

 git.spec.in |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 46aee88..be6da58 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -85,13 +85,12 @@ Perl interface to Git
 %setup -q
 
 %build
-make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} all %{!?_without_docs: doc}
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" prefix=%{_prefix} \
+     all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
-     WITH_OWN_SUBPROCESS_PY=YesPlease \
      prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
      install %{!?_without_docs: install-doc}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
-- 
1.5.1.rc2.4.g442d
