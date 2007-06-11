From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/5] Rename sections from "module" to "submodule" in .gitmodules
Date: Mon, 11 Jun 2007 21:55:17 +0200
Message-ID: <11815917171856-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxpxa-0000VL-PH
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXFKTxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbXFKTxv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:53:51 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:48411 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbXFKTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:53:50 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJqhSY016670;
	Mon, 11 Jun 2007 21:52:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49879>

On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > Hmm, maybe I should just rename [module] to [submodule] right now? It
> > would be better forward compatible with the proposed extension, it
> > would 'harmonize' the section names used in .gitmodules and
> > .git/config, and it would offer a clean break from what's currently
> > supported in 'master'.
>
> Yes, the difference between '[submodule]' vs '[module]' in
> .git/config and .gitmodules confused me while looking at your
> latest patch series.  I am in favor of unifying them.  We would
> not be breaking any released version if we harmonize them now.

Here it is.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This seem to be a bad mail day for me. I'm resending this patch since
someone apparently ate the previous one :-(


 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4a6d64d..6c83c52 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -66,7 +66,7 @@ modules_init()
 		url=$(git-config submodule."$path".url)
 		test -z "$url" || continue
 
-		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
+		url=$(GIT_CONFIG=.gitmodules git-config submodule."$path".url)
 		test -z "$url" &&
 		die "No url found for submodule '$path' in .gitmodules"
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 74fafce..9f2d4f9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -40,7 +40,7 @@ test_expect_success 'Prepare submodule testing' '
 	git-add a lib z &&
 	git-commit -m "super commit 1" &&
 	mv lib .subrepo &&
-	GIT_CONFIG=.gitmodules git-config module.lib.url git://example.com/lib.git
+	GIT_CONFIG=.gitmodules git-config submodule.lib.url git://example.com/lib.git
 '
 
 test_expect_success 'status should only print one line' '
-- 
1.5.2.1.914.gbd3a7
