From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 3/5] pull: take advantage of eval_gettextln
Date: Sun,  7 Aug 2011 21:58:15 +1000
Message-ID: <1312718297-10999-4-git-send-email-jon.seymour@gmail.com>
References: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq20F-0007uK-Nw
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1HGL6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 07:58:40 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53879 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1HGL6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:38 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6636287pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PtphTYFZHShDcJUA0XCjP9P0jTnxl6c6TQPuBVjikMA=;
        b=uT9DtntcDncYgwf/UbE8/Feu2eMPywcc6UD+3Uz1DtZc1M0uG5fvk80rX25rZ85gt6
         BBVzfaOl3IWPw2VaI1kpX5jQ2S5vYepdWFmjHOZ7yYh1rwZ4vW44EajofAb2M7nrSO5+
         jXHVd7kS09tWruV4MnoqCVdZ1+RH8ePI5yOsE=
Received: by 10.142.221.2 with SMTP id t2mr4613050wfg.334.1312718318398;
        Sun, 07 Aug 2011 04:58:38 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178905>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-pull.sh |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a10b129..d3ffd8f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -217,12 +217,9 @@ then
 	# $orig_head commit, but we are merging into $curr_head.
 	# First update the working tree to match $curr_head.
 
-	(
-		eval_gettext "Warning: fetch updated the current branch head.
+	eval_gettextln "Warning: fetch updated the current branch head.
 Warning: fast-forwarding your working tree from
-Warning: commit \$orig_head." &&
-		echo
-	) >&2
+Warning: commit \$orig_head." >&2
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
 		die "$(eval_gettext "Cannot fast-forward your working tree.
-- 
1.7.6.363.g9b380.dirty
