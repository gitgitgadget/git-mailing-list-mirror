From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Thu, 17 Feb 2011 20:31:26 -0600
Message-ID: <20110218023126.GB23435@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 03:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqG8D-00081g-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 03:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab1BRCbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 21:31:36 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56421 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1BRCbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 21:31:34 -0500
Received: by vws16 with SMTP id 16so1611425vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 18:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6E6DkTP2hfi8xCR/qwDx1hG5+bep3XSdxvf+pfy78oY=;
        b=G8H+omaPtcVHw73RGs1abmk8iuK+/8yiy8iV/HdRSd3lsfjR8g5Enjx1v4alKEQlxO
         xxqPGGnHxwm16GHCz0wBBi3geUq8PMlpgKhCOkz08Wf/Ta4N/uj61AjLUxnqq5drDxoy
         7ho1eg/1g2el5XvlaT5w75p4Ys7YIgGj/22fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UbPeRs0vK10z8SiGyQvpCCoBVcbmyRoZz4ujGxen3vNWi2Dx6F0lhOsBVqk1m5ZPbH
         joXceJNFmGnjA871hXCMkglKnN2eCG9zR/rFm29ue1TsJIchx9QBDA5CtnxuQ+8jV+t/
         JTDe2Qk3auxng5qmq8M36Pp4rLuMedG3TgwuA=
Received: by 10.52.161.226 with SMTP id xv2mr278552vdb.13.1297996293338;
        Thu, 17 Feb 2011 18:31:33 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id f17sm116115vbv.6.2011.02.17.18.31.29
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 18:31:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218022701.GA23435@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167155>

Move sources for libgit.a to a libgit/ subdirectory.  This way, a
person wanting to tackle the reusable part of git will know where to
look, and those looking to work on individual commands know to look
elsewhere.

Perhaps some day the libgit/ subdirectory can be managed as an
independent subproject (for example if it gets merged with libgit2).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                                        |  281 ++++++++++++-----------
 abspath.c => libgit/abspath.c                   |    0
 [ etc etc etc ]
 zlib.c => libgit/zlib.c                         |    0
 117 files changed, 142 insertions(+), 139 deletions(-)
 rename abspath.c => libgit/abspath.c (100%)
 [ etc ]
 rename zlib.c => libgit/zlib.c (100%)

diff --git a/Makefile b/Makefile
index ade7923..b812c1e 100644
--- a/Makefile
+++ b/Makefile
@@ -561,121 +561,121 @@ LIB_H += utf8.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
-LIB_OBJS += abspath.o
-LIB_OBJS += advice.o
-LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
-LIB_OBJS += archive.o
-LIB_OBJS += archive-tar.o
-LIB_OBJS += archive-zip.o
-LIB_OBJS += attr.o
-LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blob.o
-LIB_OBJS += branch.o
-LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
-LIB_OBJS += color.o
-LIB_OBJS += combine-diff.o
-LIB_OBJS += commit.o
-LIB_OBJS += config.o
-LIB_OBJS += connect.o
-LIB_OBJS += convert.o
-LIB_OBJS += copy.o
-LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
-LIB_OBJS += decorate.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += dir.o
-LIB_OBJS += editor.o
-LIB_OBJS += entry.o
-LIB_OBJS += environment.o
-LIB_OBJS += exec_cmd.o
-LIB_OBJS += fsck.o
-LIB_OBJS += graph.o
-LIB_OBJS += grep.o
-LIB_OBJS += hash.o
-LIB_OBJS += help.o
-LIB_OBJS += hex.o
-LIB_OBJS += ident.o
-LIB_OBJS += levenshtein.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += ll-merge.o
-LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
-LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
-LIB_OBJS += merge-file.o
-LIB_OBJS += merge-recursive.o
-LIB_OBJS += name-hash.o
-LIB_OBJS += notes.o
-LIB_OBJS += notes-cache.o
-LIB_OBJS += notes-merge.o
-LIB_OBJS += object.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-refs.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += pager.o
-LIB_OBJS += parse-options.o
-LIB_OBJS += patch-delta.o
-LIB_OBJS += patch-ids.o
-LIB_OBJS += path.o
-LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
-LIB_OBJS += progress.o
-LIB_OBJS += quote.o
-LIB_OBJS += reachable.o
-LIB_OBJS += read-cache.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
-LIB_OBJS += remote.o
-LIB_OBJS += replace_object.o
-LIB_OBJS += rerere.o
-LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
-LIB_OBJS += run-command.o
-LIB_OBJS += server-info.o
-LIB_OBJS += setup.o
-LIB_OBJS += sha1-lookup.o
-LIB_OBJS += sha1_file.o
-LIB_OBJS += sha1_name.o
-LIB_OBJS += shallow.o
-LIB_OBJS += sideband.o
-LIB_OBJS += sigchain.o
-LIB_OBJS += strbuf.o
-LIB_OBJS += string-list.o
-LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
-LIB_OBJS += trace.o
-LIB_OBJS += transport.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += tree-diff.o
-LIB_OBJS += tree.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += unpack-trees.o
-LIB_OBJS += url.o
-LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
-LIB_OBJS += walker.o
-LIB_OBJS += wrapper.o
-LIB_OBJS += write_or_die.o
-LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
+LIB_OBJS += libgit/abspath.o
+LIB_OBJS += libgit/advice.o
+LIB_OBJS += libgit/alias.o
+LIB_OBJS += libgit/alloc.o
+LIB_OBJS += libgit/archive.o
+LIB_OBJS += libgit/archive-tar.o
+LIB_OBJS += libgit/archive-zip.o
+LIB_OBJS += libgit/attr.o
+LIB_OBJS += libgit/base85.o
+LIB_OBJS += libgit/bisect.o
+LIB_OBJS += libgit/blob.o
+LIB_OBJS += libgit/branch.o
+LIB_OBJS += libgit/bundle.o
+LIB_OBJS += libgit/cache-tree.o
+LIB_OBJS += libgit/color.o
+LIB_OBJS += libgit/combine-diff.o
+LIB_OBJS += libgit/commit.o
+LIB_OBJS += libgit/config.o
+LIB_OBJS += libgit/connect.o
+LIB_OBJS += libgit/convert.o
+LIB_OBJS += libgit/copy.o
+LIB_OBJS += libgit/csum-file.o
+LIB_OBJS += libgit/ctype.o
+LIB_OBJS += libgit/date.o
+LIB_OBJS += libgit/decorate.o
+LIB_OBJS += libgit/diffcore-break.o
+LIB_OBJS += libgit/diffcore-delta.o
+LIB_OBJS += libgit/diffcore-order.o
+LIB_OBJS += libgit/diffcore-pickaxe.o
+LIB_OBJS += libgit/diffcore-rename.o
+LIB_OBJS += libgit/diff-delta.o
+LIB_OBJS += libgit/diff-lib.o
+LIB_OBJS += libgit/diff-no-index.o
+LIB_OBJS += libgit/diff.o
+LIB_OBJS += libgit/dir.o
+LIB_OBJS += libgit/editor.o
+LIB_OBJS += libgit/entry.o
+LIB_OBJS += libgit/environment.o
+LIB_OBJS += libgit/exec_cmd.o
+LIB_OBJS += libgit/fsck.o
+LIB_OBJS += libgit/graph.o
+LIB_OBJS += libgit/grep.o
+LIB_OBJS += libgit/hash.o
+LIB_OBJS += libgit/help.o
+LIB_OBJS += libgit/hex.o
+LIB_OBJS += libgit/ident.o
+LIB_OBJS += libgit/levenshtein.o
+LIB_OBJS += libgit/list-objects.o
+LIB_OBJS += libgit/ll-merge.o
+LIB_OBJS += libgit/lockfile.o
+LIB_OBJS += libgit/log-tree.o
+LIB_OBJS += libgit/mailmap.o
+LIB_OBJS += libgit/match-trees.o
+LIB_OBJS += libgit/merge-file.o
+LIB_OBJS += libgit/merge-recursive.o
+LIB_OBJS += libgit/name-hash.o
+LIB_OBJS += libgit/notes.o
+LIB_OBJS += libgit/notes-cache.o
+LIB_OBJS += libgit/notes-merge.o
+LIB_OBJS += libgit/object.o
+LIB_OBJS += libgit/pack-check.o
+LIB_OBJS += libgit/pack-refs.o
+LIB_OBJS += libgit/pack-revindex.o
+LIB_OBJS += libgit/pack-write.o
+LIB_OBJS += libgit/pager.o
+LIB_OBJS += libgit/parse-options.o
+LIB_OBJS += libgit/patch-delta.o
+LIB_OBJS += libgit/patch-ids.o
+LIB_OBJS += libgit/path.o
+LIB_OBJS += libgit/pkt-line.o
+LIB_OBJS += libgit/preload-index.o
+LIB_OBJS += libgit/pretty.o
+LIB_OBJS += libgit/progress.o
+LIB_OBJS += libgit/quote.o
+LIB_OBJS += libgit/reachable.o
+LIB_OBJS += libgit/read-cache.o
+LIB_OBJS += libgit/reflog-walk.o
+LIB_OBJS += libgit/refs.o
+LIB_OBJS += libgit/remote.o
+LIB_OBJS += libgit/replace_object.o
+LIB_OBJS += libgit/rerere.o
+LIB_OBJS += libgit/resolve-undo.o
+LIB_OBJS += libgit/revision.o
+LIB_OBJS += libgit/run-command.o
+LIB_OBJS += libgit/server-info.o
+LIB_OBJS += libgit/setup.o
+LIB_OBJS += libgit/sha1-lookup.o
+LIB_OBJS += libgit/sha1_file.o
+LIB_OBJS += libgit/sha1_name.o
+LIB_OBJS += libgit/shallow.o
+LIB_OBJS += libgit/sideband.o
+LIB_OBJS += libgit/sigchain.o
+LIB_OBJS += libgit/strbuf.o
+LIB_OBJS += libgit/string-list.o
+LIB_OBJS += libgit/submodule.o
+LIB_OBJS += libgit/symlinks.o
+LIB_OBJS += libgit/tag.o
+LIB_OBJS += libgit/trace.o
+LIB_OBJS += libgit/transport.o
+LIB_OBJS += libgit/transport-helper.o
+LIB_OBJS += libgit/tree-diff.o
+LIB_OBJS += libgit/tree.o
+LIB_OBJS += libgit/tree-walk.o
+LIB_OBJS += libgit/unpack-trees.o
+LIB_OBJS += libgit/url.o
+LIB_OBJS += libgit/usage.o
+LIB_OBJS += libgit/userdiff.o
+LIB_OBJS += libgit/utf8.o
+LIB_OBJS += libgit/walker.o
+LIB_OBJS += libgit/wrapper.o
+LIB_OBJS += libgit/write_or_die.o
+LIB_OBJS += libgit/ws.o
+LIB_OBJS += libgit/wt-status.o
+LIB_OBJS += libgit/xdiff-interface.o
+LIB_OBJS += libgit/zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -1524,7 +1524,7 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
+	LIB_OBJS += libgit/thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
@@ -1683,7 +1683,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+libgit/help.o: common-cmds.h
 
 builtin/help.o: common-cmds.h
 builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -1946,21 +1946,22 @@ else
 # gcc detects!
 
 $(GIT_OBJS): $(LIB_H)
-builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o branch.o transport.o: branch.h
-builtin/bundle.o bundle.o transport.o: bundle.h
-builtin/bisect--helper.o builtin/rev-list.o bisect.o: bisect.h
-builtin/clone.o builtin/fetch-pack.o transport.o: fetch-pack.h
-builtin/grep.o builtin/pack-objects.o transport-helper.o: thread-utils.h
-builtin/send-pack.o transport.o: send-pack.h
+builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o: branch.h
+libgit/branch.o libgit/transport.o: branch.h
+builtin/bundle.o libgit/bundle.o libgit/transport.o: bundle.h
+builtin/bisect--helper.o builtin/rev-list.o libgit/bisect.o: bisect.h
+builtin/clone.o builtin/fetch-pack.o libgit/transport.o: fetch-pack.h
+builtin/grep.o builtin/pack-objects.o libgit/transport-helper.o: thread-utils.h
+builtin/send-pack.o libgit/transport.o: send-pack.h
 builtin/log.o builtin/shortlog.o: shortlog.h
-builtin/prune.o builtin/reflog.o reachable.o: reachable.h
-builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
-builtin/tar-tree.o archive-tar.o: tar.h
-connect.o transport.o http-backend.o: url.h
-http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
+builtin/prune.o builtin/reflog.o libgit/reachable.o: reachable.h
+builtin/commit.o builtin/revert.o libgit/wt-status.o: wt-status.h
+builtin/tar-tree.o libgit/archive-tar.o: tar.h
+libgit/connect.o libgit/transport.o http-backend.o: url.h
+http-fetch.o http-walker.o remote-curl.o libgit/transport.o libgit/walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
-xdiff-interface.o $(XDIFF_OBJS): \
+libgit/xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
@@ -1972,7 +1973,7 @@ $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
 test-svn-fe.o: vcs-svn/svndump.h
 endif
 
-exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
+libgit/exec_cmd.s libgit/exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
@@ -1980,9 +1981,11 @@ exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.s config.o: EXTRA_CPPFLAGS = -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+libgit/config.s libgit/config.o: EXTRA_CPPFLAGS = \
+	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.s attr.o: EXTRA_CPPFLAGS = -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+libgit/attr.s libgit/attr.o: EXTRA_CPPFLAGS = \
+	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
 http.s http.o: EXTRA_CPPFLAGS = -DGIT_HTTP_USER_AGENT='"git/$(GIT_VERSION)"'
 
@@ -2006,10 +2009,10 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
+git-http-fetch$X: libgit/revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-push$X: libgit/revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
@@ -2123,15 +2126,15 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
-test-ctype$X: ctype.o
+test-ctype$X: libgit/ctype.o
 
-test-date$X: date.o ctype.o
+test-date$X: libgit/date.o libgit/ctype.o
 
-test-delta$X: diff-delta.o patch-delta.o
+test-delta$X: libgit/diff-delta.o libgit/patch-delta.o
 
 test-line-buffer$X: vcs-svn/lib.a
 
-test-parse-options$X: parse-options.o
+test-parse-options$X: libgit/parse-options.o
 
 test-string-pool$X: vcs-svn/lib.a
 
@@ -2316,7 +2319,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+		libgit/*.o builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
diff --git a/abspath.c b/libgit/abspath.c
similarity index 100%
rename from abspath.c
rename to libgit/abspath.c
diff --git a/advice.c b/libgit/advice.c
similarity index 100%
rename from advice.c
rename to libgit/advice.c
diff --git a/alias.c b/libgit/alias.c
similarity index 100%
rename from alias.c
rename to libgit/alias.c
diff --git a/alloc.c b/libgit/alloc.c
similarity index 100%
rename from alloc.c
rename to libgit/alloc.c
diff --git a/archive-tar.c b/libgit/archive-tar.c
similarity index 100%
rename from archive-tar.c
rename to libgit/archive-tar.c
diff --git a/archive-zip.c b/libgit/archive-zip.c
similarity index 100%
rename from archive-zip.c
rename to libgit/archive-zip.c
diff --git a/archive.c b/libgit/archive.c
similarity index 100%
rename from archive.c
rename to libgit/archive.c
diff --git a/attr.c b/libgit/attr.c
similarity index 100%
rename from attr.c
rename to libgit/attr.c
diff --git a/base85.c b/libgit/base85.c
similarity index 100%
rename from base85.c
rename to libgit/base85.c
diff --git a/bisect.c b/libgit/bisect.c
similarity index 100%
rename from bisect.c
rename to libgit/bisect.c
diff --git a/blob.c b/libgit/blob.c
similarity index 100%
rename from blob.c
rename to libgit/blob.c
diff --git a/branch.c b/libgit/branch.c
similarity index 100%
rename from branch.c
rename to libgit/branch.c
diff --git a/bundle.c b/libgit/bundle.c
similarity index 100%
rename from bundle.c
rename to libgit/bundle.c
diff --git a/cache-tree.c b/libgit/cache-tree.c
similarity index 100%
rename from cache-tree.c
rename to libgit/cache-tree.c
diff --git a/color.c b/libgit/color.c
similarity index 100%
rename from color.c
rename to libgit/color.c
diff --git a/combine-diff.c b/libgit/combine-diff.c
similarity index 100%
rename from combine-diff.c
rename to libgit/combine-diff.c
diff --git a/commit.c b/libgit/commit.c
similarity index 100%
rename from commit.c
rename to libgit/commit.c
diff --git a/config.c b/libgit/config.c
similarity index 100%
rename from config.c
rename to libgit/config.c
diff --git a/connect.c b/libgit/connect.c
similarity index 100%
rename from connect.c
rename to libgit/connect.c
diff --git a/convert.c b/libgit/convert.c
similarity index 100%
rename from convert.c
rename to libgit/convert.c
diff --git a/copy.c b/libgit/copy.c
similarity index 100%
rename from copy.c
rename to libgit/copy.c
diff --git a/csum-file.c b/libgit/csum-file.c
similarity index 100%
rename from csum-file.c
rename to libgit/csum-file.c
diff --git a/ctype.c b/libgit/ctype.c
similarity index 100%
rename from ctype.c
rename to libgit/ctype.c
diff --git a/date.c b/libgit/date.c
similarity index 100%
rename from date.c
rename to libgit/date.c
diff --git a/decorate.c b/libgit/decorate.c
similarity index 100%
rename from decorate.c
rename to libgit/decorate.c
diff --git a/diff-delta.c b/libgit/diff-delta.c
similarity index 100%
rename from diff-delta.c
rename to libgit/diff-delta.c
diff --git a/diff-lib.c b/libgit/diff-lib.c
similarity index 100%
rename from diff-lib.c
rename to libgit/diff-lib.c
diff --git a/diff-no-index.c b/libgit/diff-no-index.c
similarity index 100%
rename from diff-no-index.c
rename to libgit/diff-no-index.c
diff --git a/diff.c b/libgit/diff.c
similarity index 100%
rename from diff.c
rename to libgit/diff.c
diff --git a/diffcore-break.c b/libgit/diffcore-break.c
similarity index 100%
rename from diffcore-break.c
rename to libgit/diffcore-break.c
diff --git a/diffcore-delta.c b/libgit/diffcore-delta.c
similarity index 100%
rename from diffcore-delta.c
rename to libgit/diffcore-delta.c
diff --git a/diffcore-order.c b/libgit/diffcore-order.c
similarity index 100%
rename from diffcore-order.c
rename to libgit/diffcore-order.c
diff --git a/diffcore-pickaxe.c b/libgit/diffcore-pickaxe.c
similarity index 100%
rename from diffcore-pickaxe.c
rename to libgit/diffcore-pickaxe.c
diff --git a/diffcore-rename.c b/libgit/diffcore-rename.c
similarity index 100%
rename from diffcore-rename.c
rename to libgit/diffcore-rename.c
diff --git a/dir.c b/libgit/dir.c
similarity index 100%
rename from dir.c
rename to libgit/dir.c
diff --git a/editor.c b/libgit/editor.c
similarity index 100%
rename from editor.c
rename to libgit/editor.c
diff --git a/entry.c b/libgit/entry.c
similarity index 100%
rename from entry.c
rename to libgit/entry.c
diff --git a/environment.c b/libgit/environment.c
similarity index 100%
rename from environment.c
rename to libgit/environment.c
diff --git a/exec_cmd.c b/libgit/exec_cmd.c
similarity index 100%
rename from exec_cmd.c
rename to libgit/exec_cmd.c
diff --git a/fsck.c b/libgit/fsck.c
similarity index 100%
rename from fsck.c
rename to libgit/fsck.c
diff --git a/graph.c b/libgit/graph.c
similarity index 100%
rename from graph.c
rename to libgit/graph.c
diff --git a/grep.c b/libgit/grep.c
similarity index 100%
rename from grep.c
rename to libgit/grep.c
diff --git a/hash.c b/libgit/hash.c
similarity index 100%
rename from hash.c
rename to libgit/hash.c
diff --git a/help.c b/libgit/help.c
similarity index 100%
rename from help.c
rename to libgit/help.c
diff --git a/hex.c b/libgit/hex.c
similarity index 100%
rename from hex.c
rename to libgit/hex.c
diff --git a/ident.c b/libgit/ident.c
similarity index 100%
rename from ident.c
rename to libgit/ident.c
diff --git a/levenshtein.c b/libgit/levenshtein.c
similarity index 100%
rename from levenshtein.c
rename to libgit/levenshtein.c
diff --git a/list-objects.c b/libgit/list-objects.c
similarity index 100%
rename from list-objects.c
rename to libgit/list-objects.c
diff --git a/ll-merge.c b/libgit/ll-merge.c
similarity index 100%
rename from ll-merge.c
rename to libgit/ll-merge.c
diff --git a/lockfile.c b/libgit/lockfile.c
similarity index 100%
rename from lockfile.c
rename to libgit/lockfile.c
diff --git a/log-tree.c b/libgit/log-tree.c
similarity index 100%
rename from log-tree.c
rename to libgit/log-tree.c
diff --git a/mailmap.c b/libgit/mailmap.c
similarity index 100%
rename from mailmap.c
rename to libgit/mailmap.c
diff --git a/match-trees.c b/libgit/match-trees.c
similarity index 100%
rename from match-trees.c
rename to libgit/match-trees.c
diff --git a/merge-file.c b/libgit/merge-file.c
similarity index 100%
rename from merge-file.c
rename to libgit/merge-file.c
diff --git a/merge-recursive.c b/libgit/merge-recursive.c
similarity index 100%
rename from merge-recursive.c
rename to libgit/merge-recursive.c
diff --git a/name-hash.c b/libgit/name-hash.c
similarity index 100%
rename from name-hash.c
rename to libgit/name-hash.c
diff --git a/notes-cache.c b/libgit/notes-cache.c
similarity index 100%
rename from notes-cache.c
rename to libgit/notes-cache.c
diff --git a/notes-merge.c b/libgit/notes-merge.c
similarity index 100%
rename from notes-merge.c
rename to libgit/notes-merge.c
diff --git a/notes.c b/libgit/notes.c
similarity index 100%
rename from notes.c
rename to libgit/notes.c
diff --git a/object.c b/libgit/object.c
similarity index 100%
rename from object.c
rename to libgit/object.c
diff --git a/pack-check.c b/libgit/pack-check.c
similarity index 100%
rename from pack-check.c
rename to libgit/pack-check.c
diff --git a/pack-refs.c b/libgit/pack-refs.c
similarity index 100%
rename from pack-refs.c
rename to libgit/pack-refs.c
diff --git a/pack-revindex.c b/libgit/pack-revindex.c
similarity index 100%
rename from pack-revindex.c
rename to libgit/pack-revindex.c
diff --git a/pack-write.c b/libgit/pack-write.c
similarity index 100%
rename from pack-write.c
rename to libgit/pack-write.c
diff --git a/pager.c b/libgit/pager.c
similarity index 100%
rename from pager.c
rename to libgit/pager.c
diff --git a/parse-options.c b/libgit/parse-options.c
similarity index 100%
rename from parse-options.c
rename to libgit/parse-options.c
diff --git a/patch-delta.c b/libgit/patch-delta.c
similarity index 100%
rename from patch-delta.c
rename to libgit/patch-delta.c
diff --git a/patch-ids.c b/libgit/patch-ids.c
similarity index 100%
rename from patch-ids.c
rename to libgit/patch-ids.c
diff --git a/path.c b/libgit/path.c
similarity index 100%
rename from path.c
rename to libgit/path.c
diff --git a/pkt-line.c b/libgit/pkt-line.c
similarity index 100%
rename from pkt-line.c
rename to libgit/pkt-line.c
diff --git a/preload-index.c b/libgit/preload-index.c
similarity index 100%
rename from preload-index.c
rename to libgit/preload-index.c
diff --git a/pretty.c b/libgit/pretty.c
similarity index 100%
rename from pretty.c
rename to libgit/pretty.c
diff --git a/progress.c b/libgit/progress.c
similarity index 100%
rename from progress.c
rename to libgit/progress.c
diff --git a/quote.c b/libgit/quote.c
similarity index 100%
rename from quote.c
rename to libgit/quote.c
diff --git a/reachable.c b/libgit/reachable.c
similarity index 100%
rename from reachable.c
rename to libgit/reachable.c
diff --git a/read-cache.c b/libgit/read-cache.c
similarity index 100%
rename from read-cache.c
rename to libgit/read-cache.c
diff --git a/reflog-walk.c b/libgit/reflog-walk.c
similarity index 100%
rename from reflog-walk.c
rename to libgit/reflog-walk.c
diff --git a/refs.c b/libgit/refs.c
similarity index 100%
rename from refs.c
rename to libgit/refs.c
diff --git a/remote.c b/libgit/remote.c
similarity index 100%
rename from remote.c
rename to libgit/remote.c
diff --git a/replace_object.c b/libgit/replace_object.c
similarity index 100%
rename from replace_object.c
rename to libgit/replace_object.c
diff --git a/rerere.c b/libgit/rerere.c
similarity index 100%
rename from rerere.c
rename to libgit/rerere.c
diff --git a/resolve-undo.c b/libgit/resolve-undo.c
similarity index 100%
rename from resolve-undo.c
rename to libgit/resolve-undo.c
diff --git a/revision.c b/libgit/revision.c
similarity index 100%
rename from revision.c
rename to libgit/revision.c
diff --git a/run-command.c b/libgit/run-command.c
similarity index 100%
rename from run-command.c
rename to libgit/run-command.c
diff --git a/server-info.c b/libgit/server-info.c
similarity index 100%
rename from server-info.c
rename to libgit/server-info.c
diff --git a/setup.c b/libgit/setup.c
similarity index 100%
rename from setup.c
rename to libgit/setup.c
diff --git a/sha1-lookup.c b/libgit/sha1-lookup.c
similarity index 100%
rename from sha1-lookup.c
rename to libgit/sha1-lookup.c
diff --git a/sha1_file.c b/libgit/sha1_file.c
similarity index 100%
rename from sha1_file.c
rename to libgit/sha1_file.c
diff --git a/sha1_name.c b/libgit/sha1_name.c
similarity index 100%
rename from sha1_name.c
rename to libgit/sha1_name.c
diff --git a/shallow.c b/libgit/shallow.c
similarity index 100%
rename from shallow.c
rename to libgit/shallow.c
diff --git a/sideband.c b/libgit/sideband.c
similarity index 100%
rename from sideband.c
rename to libgit/sideband.c
diff --git a/sigchain.c b/libgit/sigchain.c
similarity index 100%
rename from sigchain.c
rename to libgit/sigchain.c
diff --git a/strbuf.c b/libgit/strbuf.c
similarity index 100%
rename from strbuf.c
rename to libgit/strbuf.c
diff --git a/string-list.c b/libgit/string-list.c
similarity index 100%
rename from string-list.c
rename to libgit/string-list.c
diff --git a/submodule.c b/libgit/submodule.c
similarity index 100%
rename from submodule.c
rename to libgit/submodule.c
diff --git a/symlinks.c b/libgit/symlinks.c
similarity index 100%
rename from symlinks.c
rename to libgit/symlinks.c
diff --git a/tag.c b/libgit/tag.c
similarity index 100%
rename from tag.c
rename to libgit/tag.c
diff --git a/thread-utils.c b/libgit/thread-utils.c
similarity index 100%
rename from thread-utils.c
rename to libgit/thread-utils.c
diff --git a/trace.c b/libgit/trace.c
similarity index 100%
rename from trace.c
rename to libgit/trace.c
diff --git a/transport-helper.c b/libgit/transport-helper.c
similarity index 100%
rename from transport-helper.c
rename to libgit/transport-helper.c
diff --git a/transport.c b/libgit/transport.c
similarity index 100%
rename from transport.c
rename to libgit/transport.c
diff --git a/tree-diff.c b/libgit/tree-diff.c
similarity index 100%
rename from tree-diff.c
rename to libgit/tree-diff.c
diff --git a/tree-walk.c b/libgit/tree-walk.c
similarity index 100%
rename from tree-walk.c
rename to libgit/tree-walk.c
diff --git a/tree.c b/libgit/tree.c
similarity index 100%
rename from tree.c
rename to libgit/tree.c
diff --git a/unpack-trees.c b/libgit/unpack-trees.c
similarity index 100%
rename from unpack-trees.c
rename to libgit/unpack-trees.c
diff --git a/url.c b/libgit/url.c
similarity index 100%
rename from url.c
rename to libgit/url.c
diff --git a/usage.c b/libgit/usage.c
similarity index 100%
rename from usage.c
rename to libgit/usage.c
diff --git a/userdiff.c b/libgit/userdiff.c
similarity index 100%
rename from userdiff.c
rename to libgit/userdiff.c
diff --git a/utf8.c b/libgit/utf8.c
similarity index 100%
rename from utf8.c
rename to libgit/utf8.c
diff --git a/walker.c b/libgit/walker.c
similarity index 100%
rename from walker.c
rename to libgit/walker.c
diff --git a/wrapper.c b/libgit/wrapper.c
similarity index 100%
rename from wrapper.c
rename to libgit/wrapper.c
diff --git a/write_or_die.c b/libgit/write_or_die.c
similarity index 100%
rename from write_or_die.c
rename to libgit/write_or_die.c
diff --git a/ws.c b/libgit/ws.c
similarity index 100%
rename from ws.c
rename to libgit/ws.c
diff --git a/wt-status.c b/libgit/wt-status.c
similarity index 100%
rename from wt-status.c
rename to libgit/wt-status.c
diff --git a/xdiff-interface.c b/libgit/xdiff-interface.c
similarity index 100%
rename from xdiff-interface.c
rename to libgit/xdiff-interface.c
diff --git a/zlib.c b/libgit/zlib.c
similarity index 100%
rename from zlib.c
rename to libgit/zlib.c
-- 
1.7.4.1
