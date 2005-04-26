From: Martin Atukunda <matlads@ds.co.ug>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 18:15:56 +0300
Message-ID: <200504261815.56889.matlads@ds.co.ug>
References: <20050426032422.GQ13467@pasky.ji.cz> <426DBF94.3010502@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 17:18:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQRoN-0006YZ-AK
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 17:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDZPVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZPUm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 11:20:42 -0400
Received: from mail1.starcom.co.ug ([217.113.72.31]:18291 "EHLO
	mail1.starcom.co.ug") by vger.kernel.org with ESMTP id S261568AbVDZPUC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 11:20:02 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.starcom.co.ug with esmtp; Tue, 26 Apr 2005 18:19:57 +0300
  id 000E5BFD.426E5C1D.000029DF
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id BC1D8500B
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 18:20:57 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.50)
	id 1DQRn3-0005Nd-1M
	for git@vger.kernel.org; Tue, 26 Apr 2005 18:15:57 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <426DBF94.3010502@timesys.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 26 April 2005 07:12, Mike Taht wrote:
> >   Yes, this is a huge change. No, I don't expect any further changes of
> > similar scale. I think the new interface is significantly simpler _and_
> > cleaner than the old one.
>
> Heh. Another huge change would be moving the top level directories
> around a bit.
>
>
> bindings  COPYING  git.spec  Makefile  programs  README.reference  tests
> contrib   doc      include   po        README    src  VERSION
>
> Leaving fixing the makefiles aside as an exercise for the interested
> reader... that's:
<snip>
something like:

--- cogito-0.8.orig/Makefile	2005-04-26 06:02:01.000000000 +0300
+++ cogito-0.8/Makefile	2005-04-26 18:10:52.558786968 +0300
@@ -15,7 +15,7 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely 
randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
-CFLAGS=-g -O2 -Wall
+CFLAGS=-g -O2 -Wall -Isrc
 
 # Should be changed to /usr/local
 prefix=$(HOME)
@@ -25,19 +25,23 @@
 CC=gcc
 AR=ar
 
-SCRIPTS=git-merge-one-file-script git-prune-script git-pull-script 
git-tag-script
+SCRIPTS=programs/cogito/git-merge-one-file-script 
programs/cogito/git-prune-script \
+	programs/cogito/git-pull-script programs/cogito/git-tag-script
 
-PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
-	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
-	diff-tree-helper
-
-SCRIPT=	commit-id tree-id parent-id cg-Xdiffdo cg-Xmergefile \
-	cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
-	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
-	cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
-	cg-tag cg-update cg-Xlib
+PROG=   src/update-cache src/show-diff src/init-db src/write-tree 
src/read-tree src/commit-tree \
+	src/cat-file src/fsck-cache src/checkout-cache src/diff-tree src/rev-tree 
src/show-files \
+	src/check-files src/ls-tree src/merge-base src/merge-cache src/unpack-file 
src/git-export \
+	src/diff-cache src/convert-cache src/http-pull src/rpush src/rpull 
src/rev-list src/git-mktag \
+	src/diff-tree-helper
+
+SCRIPT=	programs/cogito/commit-id programs/cogito/tree-id 
programs/cogito/parent-id programs/cogito/cg-Xdiffdo\
+	programs/cogito/cg-Xmergefile programs/cogito/cg-add 
programs/cogito/cg-admin-lsobj \
+	programs/cogito/cg-cancel programs/cogito/cg-clone programs/cogito/cg-commit 
programs/cogito/cg-diff \
+	programs/cogito/cg-export programs/cogito/cg-help programs/cogito/cg-init 
programs/cogito/cg-log \
+	programs/cogito/cg-ls programs/cogito/cg-merge programs/cogito/cg-mkpatch 
programs/cogito/cg-patch \
+	programs/cogito/cg-pull programs/cogito/cg-branch-add 
programs/cogito/cg-branch-ls \
+	programs/cogito/cg-rm programs/cogito/cg-seek programs/cogito/cg-status 
programs/cogito/cg-tag \
+	programs/cogito/cg-update programs/cogito/cg-Xlib
 
 COMMON=	read-cache.o
 
@@ -45,17 +49,17 @@
 
 VERSION= VERSION
 
-LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
-LIB_FILE=libgit.a
-LIB_H=cache.h object.h
+LIB_OBJS=src/read-cache.o src/sha1_file.o src/usage.o src/object.o 
src/commit.o src/tree.o src/blob.o src/rsh.o
+LIB_FILE=src/libgit.a
+LIB_H=src/cache.h src/object.h src/rsh.h
 
-LIB_H += strbuf.h
-LIB_OBJS += strbuf.o
+LIB_H += src/strbuf.h
+LIB_OBJS += src/strbuf.o
 
-LIB_H += diff.h
-LIB_OBJS += diff.o
+LIB_H += src/diff.h
+LIB_OBJS += src/diff.o
 
-LIBS = -lz
+LIBS = -lz -lcurl
 
 ifdef MOZILLA_SHA1
 	SHA1_HEADER="mozilla-sha1/sha1.h"
@@ -98,8 +102,14 @@
 	install -m755 -d $(DESTDIR)$(bindir)
 	install $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 
+uninstall:
+	$(foreach file,$(SCRIPT),$(shell rm $(DESTDIR)$(bindir)/$(shell basename 
$(file))))
+	$(foreach file,$(PROG),$(shell rm $(DESTDIR)$(bindir)/$(shell basename 
$(file))))
+	$(foreach file,$(SCRIPTS),$(shell rm $(DESTDIR)$(bindir)/$(shell basename 
$(file))))
+	$(foreach file,$(GEN_SCRIPT),$(shell rm $(DESTDIR)$(bindir)/$(shell basename 
$(file))))
+
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
+	rm -f *.o src/*.o cogito/*.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) 
$(LIB_FILE)
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
