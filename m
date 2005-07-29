From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 5/2] Remove the explicit Makefile dependencies description
Date: Fri, 29 Jul 2005 17:48:50 +0200
Message-ID: <20050729154850.GH21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:51:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyX88-0005B9-H4
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVG2PuC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 11:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVG2PuC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 11:50:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13842 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262633AbVG2Psw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 11:48:52 -0400
Received: (qmail 11568 invoked by uid 2001); 29 Jul 2005 15:48:50 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove about one gazillion of explicit dependency rules with few lines
describing the general dependency pattern and then the exceptions. This
noticably shortens the Makefile and makes it easier to touch it.

This is part of the Cogito Makefile changes port.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit ee84cc0f730f0e744fe8d922b24f6f7ebe31d737
tree 0b3edc11a0eba131788e42768b56ba6ceba32b96
parent 601722751e42dfef8bcd2fe3d6b070b07eb9198e
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 15:46:40 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 15:46:40 +0200

 Makefile |   74 +++++++-------------------------------------------------------
 1 files changed, 8 insertions(+), 66 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -97,8 +97,9 @@ LIB_H += quote.h
 LIB_OBJS += quote.o 
 
 LIB_H += diff.h count-delta.h
-LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
-	count-delta.o diffcore-break.o diffcore-order.o
+DIFF_OBJS = diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
+	diffcore-break.o diffcore-order.o
+LIB_OBJS += $(DIFF_OBJS) count-delta.o
 
 LIB_OBJS += gitenv.o
 LIB_OBJS += server-info.o
@@ -136,75 +137,16 @@ test-delta: test-delta.c diff-delta.o pa
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 
-git-update-cache: update-cache.c
-git-diff-files: diff-files.c
-git-init-db: init-db.c
-git-write-tree: write-tree.c
-git-read-tree: read-tree.c
-git-commit-tree: commit-tree.c
-git-cat-file: cat-file.c
-git-fsck-cache: fsck-cache.c
-git-checkout-cache: checkout-cache.c
-git-diff-tree: diff-tree.c
-git-rev-tree: rev-tree.c
-git-ls-files: ls-files.c
-git-check-files: check-files.c
-git-ls-tree: ls-tree.c
-git-merge-base: merge-base.c
-git-merge-cache: merge-cache.c
-git-unpack-file: unpack-file.c
-git-export: export.c
-git-diff-cache: diff-cache.c
-git-convert-cache: convert-cache.c
-git-http-pull: http-pull.c pull.c
-git-local-pull: local-pull.c pull.c
-git-ssh-push: rsh.c
+git-http-pull: pull.c
+git-local-pull: pull.c
 git-ssh-pull: rsh.c pull.c
-git-rev-list: rev-list.c
-git-mktag: mktag.c
-git-diff-helper: diff-helper.c
-git-tar-tree: tar-tree.c
-git-hash-object: hash-object.c
-git-stripspace: stripspace.c
-git-diff-stages: diff-stages.c
-git-rev-parse: rev-parse.c
-git-patch-id: patch-id.c
-git-pack-objects: pack-objects.c
-git-unpack-objects: unpack-objects.c
-git-verify-pack: verify-pack.c
-git-receive-pack: receive-pack.c
-git-send-pack: send-pack.c
-git-prune-packed: prune-packed.c
-git-fetch-pack: fetch-pack.c
-git-var: var.c
-git-peek-remote: peek-remote.c
-git-update-server-info: update-server-info.c
-git-build-rev-cache: build-rev-cache.c
-git-show-rev-cache: show-rev-cache.c
+git-ssh-push: rsh.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
 
-# Library objects..
-blob.o: $(LIB_H)
-tree.o: $(LIB_H)
-commit.o: $(LIB_H)
-tag.o: $(LIB_H)
-object.o: $(LIB_H)
-read-cache.o: $(LIB_H)
-sha1_file.o: $(LIB_H)
-usage.o: $(LIB_H)
-rev-cache.o: $(LIB_H)
-strbuf.o: $(LIB_H)
-gitenv.o: $(LIB_H)
-entry.o: $(LIB_H)
-diff.o: $(LIB_H) diffcore.h
-diffcore-rename.o : $(LIB_H) diffcore.h
-diffcore-pathspec.o : $(LIB_H) diffcore.h
-diffcore-pickaxe.o : $(LIB_H) diffcore.h
-diffcore-break.o : $(LIB_H) diffcore.h
-diffcore-order.o : $(LIB_H) diffcore.h
-epoch.o: $(LIB_H)
+$(LIB_OBJS): $(LIB_H)
+$(DIFF_OBJS): diffcore.h
 
 git-core.spec: git-core.spec.in Makefile
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
