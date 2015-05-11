From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/4] t/lib-git-svn: check same httpd module dirs as lib-httpd
Date: Mon, 11 May 2015 13:54:18 +0200
Message-ID: <9b17de0c04230ecf2a72d8669891eaee2ffda053.1431344881.git.git@drmicha.warpmail.net>
References: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrmIB-0004D7-H3
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 13:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbEKLyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 07:54:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54016 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753843AbbEKLyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 07:54:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A3432099B
	for <git@vger.kernel.org>; Mon, 11 May 2015 07:54:24 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 11 May 2015 07:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:in-reply-to:message-id:references
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=V1MiH
	2mIjTvwQXandwbpKgNFtKE=; b=pKvwGTav2dufwwlZr/bsS2UOd5HC6TrvFnLYA
	I2TGlfOVIfevW7PHQT8mJwf8aJF/nExKd4R+x7ZvETc5sRwBvkPoA0pijUlLCSqM
	V42aG2vwo6LwFFwr2pzwF7Upp+9dlG+8xRpu97Z1BTWntNR7xs2mg+mRSnQKv0Zi
	2kS3yY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
	:message-id:references:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=V1MiH2mIjTvwQXandwbpKgNFtKE=; b=W7ToA
	EVFarcvksjKpwYbxZTS8TYMhtt9iKqIBrWEda+KM/d8+HO5XW3uTft2Qc2atsb/E
	GxZOTnvsJcYredYSvX85LVa48EqL+/h+UWineMZlm/qP2ZyrahppcHEHgXQl3oFz
	9XMSfyIpyfQdXquQwKC51/p8GQkt+qDk8+wYBE=
X-Sasl-enc: ZZo4DR8n+BJTICG4c2G4ahs84BkTTzn/HQxtKk+hsrEy 1431345264
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 37B03C00013;
	Mon, 11 May 2015 07:54:24 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
In-Reply-To: <cover.1431344881.git.git@drmicha.warpmail.net>
References: <cover.1431344881.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268772>

Currently, lib-git-svn checks a proper subset of the paths that
lib-httpd checks for apache modules.

Make it check the same set so that apache is run by one when it is run
by the other (provided ports have been set and there are no other
configuration issues).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
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
2.4.0.rc3.332.g886447c
