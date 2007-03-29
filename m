From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Added correct Python path to the RPM specfile.
Date: Thu, 29 Mar 2007 14:07:47 +0400
Message-ID: <20070329100747.GO59098@codelabs.ru>
References: <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWrXw-0000YJ-TC
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 12:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbXC2KHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 06:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934240AbXC2KHy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 06:07:54 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:55468 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934173AbXC2KHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 06:07:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=BPnq9cAofMowPe2Lw8oQrNkmQt6lmLRctOZykz6D3SWDq1wfrEck8ms7Jy8Yu+iu53q1xNFPaYIxFo3yAXwLCBRqgWieMR0Rbb03Dzz3Td6RrH9E9WPlTjnqQCwmUxBkT7P5RitWnSKDLINwcZKnZ6uZRaz6kv8UipMOj26tbO0=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWrXs-000Dvv-4c; Thu, 29 Mar 2007 14:07:52 +0400
Content-Disposition: inline
In-Reply-To: <20070329074424.GD59098@codelabs.ru>
X-Spam-Status: No, score=-1.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50,
	SUBJECT_DRUG_GAP_P
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43425>

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git.spec.in |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index e469f21..1e96eaa 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -1,4 +1,7 @@
 # Pass --without docs to rpmbuild if you don't want the documentation
+
+%define python_path /usr/bin/python
+
 Name: 		git
 Version: 	@@VERSION@@
 Release: 	1%{?dist}
@@ -93,12 +96,14 @@ Perl interface to Git
 
 %build
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     WITH_P4IMPORT=YesPlease prefix=%{_prefix} all %{!?_without_docs: doc}
+     WITH_P4IMPORT=YesPlease PYTHON_PATH=%{python_path} prefix=%{_prefix} all \
+     %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
-     WITH_OWN_SUBPROCESS_PY=YesPlease WITH_P4IMPORT=YesPlease \
+     WITH_OWN_SUBPROCESS_PY=YesPlease \
+     WITH_P4IMPORT=YesPlease PYTHON_PATH=%{python_path} \
      prefix=%{_prefix} mandir=%{_mandir} INSTALLDIRS=vendor \
      install %{!?_without_docs: install-doc}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
-- 
1.5.0.3-dirty
