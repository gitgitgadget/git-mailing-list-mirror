From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] make t8001 work on Mac OS X again
Date: Tue, 6 Mar 2007 19:48:59 -0500
Message-ID: <20070307004859.GA26262@spearce.org>
References: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com> <20070307001410.GA26050@spearce.org>
Mime-Version: 1.0
Content-Type: text/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOkLA-00085v-6l
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbXCGAtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 19:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbXCGAtI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:49:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161062AbXCGAtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:49:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOkKp-00085Z-VC; Tue, 06 Mar 2007 19:48:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5996420FBAE; Tue,  6 Mar 2007 19:49:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070307001410.GA26050@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41628>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

It has a broken sed which adds a newline to the last line, if it does
not end with one.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---

	From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
	> Does this work for you?

	Yes.  ;-)

 t/annotate-tests.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 87403da..cacb273 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -114,7 +114,8 @@ test_expect_success \
 test_expect_success \
     'some edit' \
     'mv file file.orig &&
-    sed -e "s/^3A/99/" -e "/^1A/d" < file.orig > file &&
+    sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" < file.orig > file &&
+    echo "incomplete" | tr -d "\\012" >>file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
 test_expect_success \
