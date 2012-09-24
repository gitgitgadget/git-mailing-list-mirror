From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: configure submodule.<name>.path on add and init
Date: Mon, 24 Sep 2012 21:30:40 +0200
Message-ID: <1348515040-19986-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 21:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEMu-0007jZ-U5
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687Ab2IXTav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:30:51 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46835 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab2IXTau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:30:50 -0400
Received: by weyt9 with SMTP id t9so429597wey.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kZzXAJ7nBMUtbuZNGKxCf/rA5HEIex2IjXBQTtJNPEs=;
        b=0GzA9P4ZB8H22tbiNZSaB51X5kOlq+QLpMY6OE42cPXW3PPww/NgLlY5IZkJDS5PFz
         2hbH0EJWJX6ysPc0oRGGK8DJhjWdUv7hD0RO2LFN9GBrhsbqseQ/lQDQymGbm5+VXTDj
         uHlYHbQAx722mTWSnPQyECELFYqKCbFBXBiwRC6PNuiAXtORO9lp9RpDwVdxmL9MOVix
         A0oQhd6R/F5J3l9xPxdmPtEQLVcbmH1Cu4+yR6VzvYoo49RpzOrPaH/CoxtBONUsALVO
         Wee8WOImrXu9ssy4gb7a9EuZqPUWqy6UjCuc7LHxlYZymNj26jVRRw+jkSTQuo+ZtyBT
         EUyQ==
Received: by 10.216.209.150 with SMTP id s22mr6286465weo.49.1348515049740;
        Mon, 24 Sep 2012 12:30:49 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-228-252-129.inter.net.il. [84.228.252.129])
        by mx.google.com with ESMTPS id l5sm18379799wix.5.2012.09.24.12.30.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Sep 2012 12:30:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206316>

In order to read diff options for a submodule, its path must be configured
---
 git-submodule.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3e2045e..f97bb62 100755
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
+			git config submodule."$name".path "$name" ||
 			git config submodule."$name".url "$url" ||
 			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
 
-- 
1.7.10.4
