From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Call make always with CFLAGS in git.spec
Date: Tue,  6 Feb 2007 16:08:55 -0300
Message-ID: <11707889352302-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 22:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEXo0-00026g-3h
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 22:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965531AbXBFVYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 16:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965528AbXBFVYR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 16:24:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41948 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965535AbXBFVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 16:24:16 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l16LO4lv013164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Feb 2007 18:24:05 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l16J8uPb018975;
	Tue, 6 Feb 2007 16:08:56 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l16J8unI018974;
	Tue, 6 Feb 2007 16:08:56 -0300
X-Mailer: git-send-email 1.5.0.rc3
X-Greylist: Delayed for 02:15:08 by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Tue, 06 Feb 2007 18:24:05 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2529/Tue Feb  6 16:25:02 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	UPPERCASE_25_50 autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38875>

If not, the binaries get built once with the correct CFLAGS, and then again
with the ones in the Makefile when installing

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 git.spec.in |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index fb95e37..1213325 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -89,7 +89,8 @@ make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
+     WITH_OWN_SUBPROCESS_PY=YesPlease \
      prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
      install %{!?_without_docs: install-doc}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
-- 
1.5.0.rc3
