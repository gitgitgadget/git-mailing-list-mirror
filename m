From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] t/lib-httpd: load mod_unixd
Date: Wed,  8 Apr 2015 17:05:24 +0200
Message-ID: <53b238530469330255d13209c2df4f11ef5b2edc.1428505184.git.git@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:05:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfrY5-0005RB-OA
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbbDHPFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 11:05:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57332 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754241AbbDHPF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 11:05:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2987C20A48
	for <git@vger.kernel.org>; Wed,  8 Apr 2015 11:05:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 08 Apr 2015 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=orxRYUjUUN06PQbMcPpysDQk6BY
	=; b=J3w1zWfxGixcmLkpXUZLvRpPOzIVW1qSg9aKL6SFHRcRWZe6B1ewVbUkosH
	Na+CeFizHzo2zLmaO8k0GuH5KPKGGS65eFpNShk4WT2GxINZSw9MwA7u/1/+A3X4
	Mv5/ByOh338MTBaaXy4pFiB6kekZnjZlzAtt2Jc29tRmyJcE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=orxR
	YUjUUN06PQbMcPpysDQk6BY=; b=g9bZLchswqqDNFlvYPmOnUfE9kl7cpywbxGe
	7tNpHb2M8ZuqTWS0g+i4D2ucOjvbQW/g5qCobtSuL7rWGTQhu4APM+uKaFfq8lsf
	4RXwj1sm5FHRzWEfJ+gr5KRMD99OG5whbFaUZKvYvuz06EQSGIrrsniNBaawIQiA
	YbDZ9OI=
X-Sasl-enc: ZLsHFTMalzirtc6nMeoLGT2nTYi8MR9+bj/3VEfQT+yM 1428505528
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A7C996801A3;
	Wed,  8 Apr 2015 11:05:28 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc1.221.gf7021fb
In-Reply-To: <cover.1428505184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266963>

With the current config, apache 2.4.10 will not be started and the httpd
tests will not run.

Enable mod_unixd to make the httpd tests run.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Basically, this is required since the switch from 2.2 to 2.4.
    I'm wondering whether noone is running these tests, or other
    distros (than Fedora) use different default configs.

 t/lib-httpd/apache.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0b81a00..7b8e21c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -64,6 +64,9 @@ LockFile accept.lock
 <IfModule !mod_mpm_prefork.c>
 	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
 </IfModule>
+<IfModule !mod_unixd.c>
+	LoadModule unixd_module modules/mod_unixd.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
-- 
2.4.0.rc1.221.gf7021fb
