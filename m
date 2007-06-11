From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 3/5] Rename sections from "module" to "submodule" in .gitmodules
Date: Mon, 11 Jun 2007 02:01:55 +0200
Message-ID: <op.ttqc1huz9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXJp-0000Tk-08
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760504AbXFJX72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761073AbXFJX72
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:59:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:20198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760504AbXFJX71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 19:59:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357493ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 16:59:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=rwk51qLAU/5q8KVMGxdY6cXqWaL9/r4NHXDKHP+mnWBEjx3RofBA29BCykeNnXsy1BQZjwkCgtd82Ax6JmTvl8PGOq1h2ijczu6vvM5kB8QNJcMGZ8sWWamGKQBMrDnIWWiHwoQ4wy9hjYPFwmYIU5yA1Uc7oi0GIBzy+GAFdzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=JM0eKRoqBjMADwa8ey/rEoaHR8FOTlOSG2z03v2m1Hnvax4Ba1VatwoqYWJTBq1GhZxvZ04CrDd3Zewfr8c0yiaZPfTTcAI29g4s/HOyUMUIIbUY+vGGscjnYlp9tG1MUdgqxu8CnvdUbQyydLTSAOzFimA1qTyRO7MN7CQOQI8=
Received: by 10.67.32.19 with SMTP id k19mr4692026ugj.1181519967136;
        Sun, 10 Jun 2007 16:59:27 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id b36sm12475377ika.2007.06.10.16.59.25
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 16:59:26 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49798>

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
