From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] t/lib-git-svn: check same httpd module dirs as lib-httpd
Date: Wed,  8 Apr 2015 17:05:25 +0200
Message-ID: <42794bef0424d21c3ee1003e21a98fd65ed194cf.1428505184.git.git@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfrXt-0005LC-GC
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 17:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbbDHPFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 11:05:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44444 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754386AbbDHPFa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 11:05:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 85BBF20C10
	for <git@vger.kernel.org>; Wed,  8 Apr 2015 11:05:26 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 08 Apr 2015 11:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=MZOXmdjCZWq0w1qo/PN/6Cy7lVw
	=; b=oF0ZmS7/lgJVTQuiIqiO4YVxVuYqE23H0F5VU/plx32PoGzIE9ehbtiebt8
	w1o2OI32W2dWCGz26hhy588Sd3wRbt+Z6R14I9WvJlNoobc/vLcqq4po5wps29Y3
	5SHY4PS0q8NPnXCoUzJn86qgcFNV1UA03y5hL57z0EuMkRXc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MZOX
	mdjCZWq0w1qo/PN/6Cy7lVw=; b=Na+vW+Bteyr57AUMVfbexlD6qceIhWwyrTLR
	hitu1Hk/1Nn1Ry6pvNQM5z+n5UB90u+sqR8KNt6tKuvYS7lDsDxi18mtPYljj6YA
	LtrtrKxoob/NiceJlT08CkyAQLRk+ea38G9dPJ94WdopnDcZS3entecWNxTLOtkR
	mu1nw0g=
X-Sasl-enc: Y20uZyM+PzAyMePBC7nteH01FfvWQ+++JmE9Id9ohV72 1428505530
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1D03EC0001C;
	Wed,  8 Apr 2015 11:05:30 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc1.221.gf7021fb
In-Reply-To: <cover.1428505184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266961>

Currently, lib-git-svn checks a proper subset of the paths that
lib-httpd checks for apache modules.

Make it check the same set so that apache is run by one when it is run
by the other (provide ports have been set).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Again, I'm wondering how many are running these tests.
    They would not run on a 64bit system with redhat type fs layout.

 t/lib-git-svn.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index b0ec12f..2a0ef07 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -87,8 +87,10 @@ prepare_httpd () {
 	fi
 	for d in \
 		"$SVN_HTTPD_MODULE_PATH" \
-		/usr/lib/apache2/modules \
 		/usr/libexec/apache2 \
+		/usr/lib/apache2/modules \
+		/usr/lib64/httpd/modules \
+		/usr/lib/httpd/modules \
 	; do
 		if test -d "$d"
 		then
-- 
2.4.0.rc1.221.gf7021fb
