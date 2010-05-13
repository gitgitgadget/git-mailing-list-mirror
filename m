From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Thu, 13 May 2010 15:08:02 +0530
Message-ID: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 13 11:38:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUrv-0002gW-Rh
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab0EMJiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 05:38:07 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:47134 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab0EMJiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 05:38:05 -0400
Received: by ywh36 with SMTP id 36so466424ywh.4
        for <git@vger.kernel.org>; Thu, 13 May 2010 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=HEFN95uxMDxBgVEIWd07PDt7fUZdxeS5f8tIBYZS3uQ=;
        b=jHNsjiWUCQg75k39sjn7q01N5TlfrVY/VjC2Dz5NHvtDKbUq4z5l1bGStiFSMczzmG
         w7eD8dEmjbWIijDTXi/e3SGkI5yZFNBqI7JhLYsCWMaxhNz5q3kmjX1r/pCpMuX7RvTi
         e/ThoV6Q+emeOWnQCSfRU99hoqCGU6tjqRM9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=LGHfX9ci+JyyNfQAsWGJdo+ZgJFYHHdkhC7r6XO2oiyny97Kq7cv0D0LGlCxPqQn/X
         GNnKUw0InsI8YEhuZlWkGRYC2CFWuKr4dhHOpgB8ovBnfnbWfYSWmS94gLwoaYxbtGme
         xnjU6E4BqDJsgHZiSiJy/EHcqE2FJ0KOOpvxE=
Received: by 10.90.46.6 with SMTP id t6mr230499agt.134.1273743482466; Thu, 13 
	May 2010 02:38:02 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Thu, 13 May 2010 02:38:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146984>

The current installation of gitweb requires us to give it a
target directory. But splitting of gitweb makes it difficult
for git instaweb to continue with the current method.

This commit allow installation of gitweb files into the target
'$(sharedir)/gitweb' by default when user type 'make install'.
This target act as root directory for instaweb servers.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

This is necessary step to acheive the goals of my GSoC project.
Currently instaweb script creates gitweb.* files in every repository
which is unnecessary. So if we have global folder for gitweb files we
can configure the instaweb server root to point to that direction.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index de7f680..0b262a9 100644
--- a/Makefile
+++ b/Makefile
@@ -269,6 +269,7 @@ mandir = share/man
 infodir = share/info
 gitexecdir = libexec/git-core
 sharedir = $(prefix)/share
+gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
 htmldir = share/doc/git-doc
 ifeq ($(prefix),/usr)
@@ -1971,6 +1972,7 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C gitweb gitwebdir=$(gitwebdir) install
 endif
 ifndef NO_PYTHON
 	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)'
DESTDIR='$(DESTDIR_SQ)' install
-- 
1.7.1.16.g5d405c.dirty
