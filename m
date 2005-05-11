From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix cg-commit to handle files with leading '-'
Date: Wed, 11 May 2005 02:55:25 +0200
Message-ID: <20050511005525.GB3055@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 02:48:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVfOW-00034a-QE
	for gcvg-git@gmane.org; Wed, 11 May 2005 02:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEKAzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 20:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVEKAze
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 20:55:34 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:4830 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261863AbVEKAz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 20:55:26 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 833D16E12E6; Wed, 11 May 2005 02:55:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 370126E0E7D; Wed, 11 May 2005 02:55:22 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 77C0B61FDE; Wed, 11 May 2005 02:55:25 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pasky,

cg-commit dies with "update-cache failed" message when adding files
beginning with a '-' because the '--' arg is missing.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

-- 
Jonas Fonseca

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-cg-commit.patch"

Index: cg-commit
===================================================================
--- 673ad20e23591a8e5bdf18a755a5dea1755b7bf6/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -140,13 +140,13 @@
 
 if [ ! "$ignorecache" ]; then
 	if [ "$customfiles" ]; then
-		git-update-cache --add --remove "${commitfiles[@]}" \
+		git-update-cache --add --remove -- "${commitfiles[@]}" \
 			|| die "update-cache failed"
 		export GIT_INDEX_FILE=$(mktemp -t gitci.XXXXXX)
 		git-read-tree HEAD
 	fi
 	# TODO: Do the proper separation of adds, removes, and changes.
-	git-update-cache --add --remove "${commitfiles[@]}" \
+	git-update-cache --add --remove -- "${commitfiles[@]}" \
 		|| die "update-cache failed"
 fi
 

--xHFwDpU9dbj6ez1V--
