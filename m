From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: configure submodule.<name>.path on add and init
Date: Mon, 24 Sep 2012 21:32:30 +0200
Message-ID: <1348515150-20284-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 21:32:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEOd-00005A-0S
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832Ab2IXTci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:32:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41716 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab2IXTch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:32:37 -0400
Received: by wibhr14 with SMTP id hr14so5334454wib.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IbWx2DhfSiaK6JyyUDYLC+C+PS5Wyds583MAW1xgmK0=;
        b=uJtb8CfLZIfcLwJ7SCkhsxXs7Xn/A4cqPm3EtqcWKxaxSnqwC9r9sn+o0b9mfOrXUr
         /3yW+qt0QZrJn3+Q4qKLExpTyoYUtjH3LyYu2O1EjUjx3VbTx/MyiEPTFej2nkd0zKX4
         1l5VoRW4a0cZKIgJd04FQbMRcpov9EjHKggYB6orQO+25jaB7Xiu5Nd9VzTg83AQju/c
         IsJKemCFyNB56+BHfBm1V15q80w6RBFLewVtMeNFqhjGmGB6jUInz9oPnW1/JvVTt8+G
         +2awgNsfMNidL1kucuKcNWklwa69wJF6Zpc61q9jwTTtD5RujBBsptk1zxt4gCfZnhLF
         Tt2Q==
Received: by 10.216.213.29 with SMTP id z29mr8314204weo.8.1348515156261;
        Mon, 24 Sep 2012 12:32:36 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-228-252-129.inter.net.il. [84.228.252.129])
        by mx.google.com with ESMTPS id ga2sm6430311wib.2.2012.09.24.12.32.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 12:32:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206317>

In order to read diff options for a submodule, its path must be configured

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 git-submodule.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3e2045e..af9c003 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -359,6 +359,7 @@ Use -f if you really want to add it." >&2
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
+	git config submodule."$sm_path".path "$sm_path"
 	git config submodule."$sm_path".url "$realrepo"
 
 	git add $force "$sm_path" ||
@@ -476,6 +477,7 @@ cmd_init()
 				url=$(resolve_relative_url "$url") || exit
 				;;
 			esac
+			git config submodule."$name".path "$name" &&
 			git config submodule."$name".url "$url" ||
 			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
 
-- 
1.7.10.4
