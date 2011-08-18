From: Jeff King <peff@peff.net>
Subject: [PATCH 01/10] t7006: modernize calls to unset
Date: Wed, 17 Aug 2011 22:00:47 -0700
Message-ID: <20110818050044.GA2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtuiv-0006St-6L
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab1HRFAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:00:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35420
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1HRFAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:00:52 -0400
Received: (qmail 18199 invoked by uid 107); 18 Aug 2011 05:01:32 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:01:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:00:47 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179558>

These tests break &&-chaining to deal with broken "unset"
implementations. Instead, they should just use sane_unset.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7006-pager.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index ed7575d..c0a3135 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -402,7 +402,7 @@ test_core_pager_subdir    expect_success test_must_fail \
 					 'git -p apply </dev/null'
 
 test_expect_success TTY 'command-specific pager' '
-	unset PAGER GIT_PAGER;
+	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
 	git config --unset core.pager &&
@@ -412,7 +412,7 @@ test_expect_success TTY 'command-specific pager' '
 '
 
 test_expect_success TTY 'command-specific pager overrides core.pager' '
-	unset PAGER GIT_PAGER;
+	sane_unset PAGER GIT_PAGER &&
 	echo "foo:initial" >expect &&
 	>actual &&
 	git config core.pager "exit 1"
-- 
1.7.6.10.g62f04
