From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Disable implicit 'save' argument for 'git stash'
Date: Tue,  6 Nov 2007 18:26:45 -0600
Message-ID: <1194395205-27905-2-git-send-email-bdowning@lavos.net>
References: <20071106085134.GD4435@artemis.corp>
 <1194395205-27905-1-git-send-email-bdowning@lavos.net>
Cc: tsuna@lrde.epita.fr, aghilesk@gmail.com, git@vger.kernel.org,
	Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZoy-00020H-Ra
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 02:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXKGBex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 20:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbXKGBew
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 20:34:52 -0500
Received: from mxsf09.insightbb.com ([74.128.0.79]:20418 "EHLO
	mxsf09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbXKGBev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 20:34:51 -0500
X-IronPort-AV: E=Sophos;i="4.21,381,1188792000"; 
   d="scan'208";a="125611286"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO asav02.insightbb.com) ([74.134.249.24])
  by mxsf09.insightbb.com with ESMTP; 06 Nov 2007 20:34:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAE6lMEdKhvkY/2dsb2JhbACBW45u
X-IronPort-AV: E=Sophos;i="4.21,381,1188792000"; 
   d="scan'208";a="155810237"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 06 Nov 2007 20:34:51 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id B0614309F21; Tue,  6 Nov 2007 19:34:50 -0600 (CST)
X-Original-To: bdowning@lavos.net
Received: from somat1.somat.local (mail.somat.com [63.252.84.66])
	by mail.lavos.net (Postfix) with ESMTP id 6E52E309F21
	for <bdowning@lavos.net>; Tue,  6 Nov 2007 18:26:20 -0600 (CST)
Received: from silvara.lavos.net ([192.168.0.143]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 6 Nov 2007 18:26:19 -0600
Received: (nullmailer pid 27930 invoked by uid 1000);
	Wed, 07 Nov 2007 00:26:45 -0000
X-Mailer: git-send-email 1.5.3.5.1547.gf6d81-dirty
In-Reply-To: <1194395205-27905-1-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 07 Nov 2007 00:26:19.0429 (UTC) FILETIME=[D1283D50:01C820D4]
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Tue Nov  6 18:26:50 2007
X-DSPAM-Confidence: 0.7829
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 1000,4731064961921804284693
X-DSPAM-Factors: 27,
	$+git, 0.00010,
	References*bdowning+lavos, 0.00010,
	passed+for, 0.99990,
	is+deprecated, 0.00010,
	References*bdowning, 0.00010,
	100755, 0.00010,
	100755, 0.00010,
	git+reset, 0.00010,
	References*corp, 0.00010,
	To*Junio, 0.00010,
	*bdowning+silvara, 0.00010,
	sh+b, 0.00010,
	sh+b, 0.00010,
	Cc*com+git, 0.00010,
	'git, 0.00010,
	'git, 0.00010,
	Received*somat1.somat.local, 0.00010,
	Received*somat1.somat.local, 0.00010,
	Return-Path*bdowning+silvara, 0.00010,
	To*Hamano, 0.00010,
	*silvara, 0.00010,
	changes+is, 0.00010,
	To*gitster+pobox, 0.00010,
	deprecated+please, 0.00010,
	In-Reply-To*bdowning, 0.00010,
	To*Junio+C, 0.00010,
	X-Mailer*5+3, 0.00010
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63765>

Having 'git stash random stuff' actually stash changes is poor
user interface, due to the likelyhood of misspelling another legitimate
argument.  Require an explicit 'save' command instead.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
    This commit can be applied on top of the previous whenever it
    is decided "enough time" has passed for the hard behavior change
    of "git stash" to take place.

 git-stash.sh     |   16 +++++-----------
 t/t3903-stash.sh |    4 ++--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a8b854a..e900d40 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -219,17 +219,11 @@ create)
 help | usage)
 	usage
 	;;
-*)
-	if test $# -gt 0 && test "$1" = save
-	then
-		shift
-	else
-		cat >&2 <<EOF
-'git stash [message...]' is deprecated, please use
-'git stash save [message...]' instead.
-
-EOF
-	fi
+save)
+	shift
 	save_stash "$*" && git-reset --hard
 	;;
+*)
+	usage
+	;;
 esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index adfac4b..4896da0 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -73,13 +73,13 @@ test_expect_success 'unstashing in a subdirectory' '
 	git stash apply
 '
 
-test_expect_success 'stash with no args' '
+test_expect_failure 'stash with no args' '
 	echo 7 > file &&
 	test_tick &&
 	git stash
 '
 
-test_expect_success 'stash with bare message' '
+test_expect_failure 'stash with bare message' '
 	echo 8 > file &&
 	test_tick &&
 	git stash "a message"
-- 
1.5.3.5.1547.gf6d81-dirty
