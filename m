From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 6/6] darwinports-Portfile: Portfile for cogito
Date: Mon, 11 Jul 2005 06:15:39 -0400
Message-ID: <20050711101530.10318.21470.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvKJ-0000BZ-Ps
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVGKKPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGKKPm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:15:42 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:2160 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261588AbVGKKPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:15:39 -0400
Received: (qmail 25184 invoked from network); 11 Jul 2005 10:15:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=nGoknVnDV5Ri12DMcv9VEnwC+dkRtU2uKEr7PwYbXuSaqdv03mINNHqjDuoEWW13RB49mmQDVleYqLOBP4sSO/+1nwgEKXaMBsHdURtW00rk2tXUKSaI5zclPwLenbUIkVFL7BdW4NwJF+AOneEdsGpo5TSlyKk/dXQcH6N9sq4=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:15:37 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A Portfile for darwinports.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 Makefile    |    2 ++
 Portfile.in |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -240,6 +240,8 @@ dist: cogito.spec
 	@rm $(tarname)/cogito.spec
 	@rmdir $(tarname)
 	gzip -9 $(tarname).tar
+	sed -e 's/@@VERSION@@/$(shell cat $(VERSION) | cut -d"-" -f2)/g' < Portfile.in > Portfile
+	echo "checksums md5 " `md5sum $(tarname).tar.gz | cut -d ' ' -f 1` >> Portfile
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE) config
diff --git a/Portfile.in b/Portfile.in
new file mode 100644
--- /dev/null
+++ b/Portfile.in
@@ -0,0 +1,25 @@
+# $Id: $
+PortSystem        1.0
+name              cogito
+version           @@VERSION@@
+categories        devel
+maintainers       bryan.larsen@gmail.com
+description       Git core + cogito tools to provide a full distributed SCM.
+long_description  The git core, developed by Linus Torvalds provides \
+		  an extremely fast and flexible filesystem-based \
+		  database designed to store directory trees with \
+		  regard to their history.  The cogito tools, \
+		  developed by Petr Baudis, provide full distributed \
+		  SCM (software change management) functionality.
+homepage          http://kernel.org/pub/software/scm/cogito/
+master_sites      http://kernel.org/pub/software/scm/cogito/
+configure	  {}
+depends_lib       bin:gcp:coreutils
+depends_lib       bin:gnuxargs:findutils
+build.type        gnu
+destroot.type     gnu
+destroot.destdir  prefix=${prefix} DESTDIR=${destroot}
+test.run          yes
+test.cmd          make
+test.target       test
+test.dir          ${worksrcpath}
