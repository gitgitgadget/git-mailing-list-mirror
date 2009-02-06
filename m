From: dmellor@whistlingcat.com
Subject: [PATCH] Fix broken git help -w when installing from RPM
Date: Thu, 5 Feb 2009 22:38:29 -0800
Message-ID: <20090207052514.BEECA17A57@sandstone.whistlingcat.com>
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 06:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVfiF-0006F0-5P
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 06:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbZBGFZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 00:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZBGFZQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 00:25:16 -0500
Received: from quartz.whistlingcat.com ([67.223.228.111]:34044 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZBGFZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 00:25:15 -0500
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 3873D488006;
	Fri,  6 Feb 2009 21:25:15 -0800 (PST)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 06B1738E7346;
	Fri,  6 Feb 2009 21:25:14 -0800 (PST)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id BEECA17A57; Fri,  6 Feb 2009 21:25:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108812>

After the git-core package was renamed to git in 7c33d3a, git help -w was
still looking for files in /usr/share/doc/git-core-$VERSION instead of
/usr/share/doc/git-$VERSION.

My apologies if this posting is a duplicate. I tried to send this
last night, but it does not appear to have shown up on the mailing
list.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 git.spec.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 069ace0..5f035b0 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -97,7 +97,7 @@ BuildRequires:  perl(Error)
 %description -n perl-Git
 Perl interface to Git
 
-%define path_settings ETC_GITCONFIG=/etc/gitconfig prefix=%{_prefix} mandir=%{_mandir} htmldir=%{_docdir}/%{name}-core-%{version}
+%define path_settings ETC_GITCONFIG=/etc/gitconfig prefix=%{_prefix} mandir=%{_mandir} htmldir=%{_docdir}/%{name}-%{version}
 
 %prep
 %setup -q
@@ -190,6 +190,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
+- fix broken git help -w after git-core package was renamed to git.
+
 * Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
 - move git-cvsserver to bindir.
 
-- 
1.6.1.2
