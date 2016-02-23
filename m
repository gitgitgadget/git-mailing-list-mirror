From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] tests: remove no-op full-svn-test target
Date: Tue, 23 Feb 2016 06:26:59 +0000
Message-ID: <20160223062659.GA7630@dcvr.yhbt.net>
References: <20160222030814.GA18817@dcvr.yhbt.net>
 <56CB30F3.40908@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:27:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6R7-0007LE-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbcBWG1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:27:00 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34862 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756930AbcBWG07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:26:59 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66874633811;
	Tue, 23 Feb 2016 06:26:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56CB30F3.40908@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287022>

git-svn has not supported GIT_SVN_NO_OPTIMIZE_COMMITS for
the "set-tree" sub-command in 9 years since commit 490f49ea5899
("git-svn: remove optimized commit stuff for set-tree").

So remove this target and TSVN variable to avoid confusion.

ref: http://mid.gmane.org/56C9B7B7.7030406@f2.dion.ne.jp

Helped-by: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  v2: remove TSVN, too.

  Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
  > The variable TSVN becomes unused by this removal. It should be removed
  > together, shouldn't it?

  Yes, thanks :)  I also noticed the contrib/subtree/t/Makefile
  has TSVN (and TGITWEB,) too, but I've left it alone for now.

 t/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 43b15e3..18e2b28 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -27,7 +27,6 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
 
@@ -77,11 +76,6 @@ aggregate-results:
 		echo "$$f"; \
 	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
-# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
-full-svn-test:
-	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
-
 gitweb-test:
 	$(MAKE) $(TGITWEB)
 
-- 
EW
