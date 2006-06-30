From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/3] Delete manuals if compiling without docs
Date: Fri, 30 Jun 2006 01:09:26 -0400
Message-ID: <20060630050926.701.24647.stgit@dv.roinet.com>
References: <20060630050923.701.37665.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jun 30 07:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwBFz-0002Lx-EO
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 07:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWF3FJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 01:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWF3FJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 01:09:28 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5015 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750922AbWF3FJ1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 01:09:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwBFu-0004a9-R6
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:26 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FwBFu-0000Bg-6G
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:26 -0400
To: git@vger.kernel.org
In-Reply-To: <20060630050923.701.37665.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22955>

From: Pavel Roskin <proski@gnu.org>

Otherwise, rpm would complain about unpacked files.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 git.spec.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 8ccd256..b8feda3 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -86,6 +86,8 @@ make %{_smp_mflags} DESTDIR=$RPM_BUILD_R
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 %if %{!?_without_docs:1}0
 (find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+%else
+rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
 
 %clean
