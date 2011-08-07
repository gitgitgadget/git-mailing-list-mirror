From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 4/5] stash: take advantage of eval_gettextln
Date: Sun,  7 Aug 2011 21:58:16 +1000
Message-ID: <1312718297-10999-5-git-send-email-jon.seymour@gmail.com>
References: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:58:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq20G-0007uK-93
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab1HGL6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 07:58:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53879 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1HGL6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:41 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6636287pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2oeFm1WyruMszDbDr/TGrgLrAg0vXbgUABoy0JhsxCw=;
        b=vOBd6KfG6Pv0bFRN6odC7DkOwNL5Si45hCIuYikQEcil38VlpS/3n0F+IZG9z3wwlo
         vlW0OcjyZTpCVDruiI54UZsJS0BE5wyZHbQG7yVVUjHzxsWcBsEptVmgsIBnQachM122
         ye/wuZB+Lv+nPivF1psWaIX32BvLv2OayvNcc=
Received: by 10.142.225.11 with SMTP id x11mr4393172wfg.221.1312718321489;
        Sun, 07 Aug 2011 04:58:41 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
In-Reply-To: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178906>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f4e6f05..31dec0a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -198,8 +198,8 @@ save_stash () {
 			#    $ git stash save --blah-blah 2>&1 | head -n 2
 			#    error: unknown option for 'stash save': --blah-blah
 			#           To provide a message, use git stash save -- '--blah-blah'
-			eval_gettext "$("error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'")"; echo
+			eval_gettextln "$("error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'")"
 			usage
 			;;
 		*)
@@ -470,10 +470,7 @@ apply_stash () {
 		status=$?
 		if test -n "$INDEX_OPTION"
 		then
-			(
-				gettext "Index was not unstashed." &&
-				echo
-			) >&2
+			gettextln "Index was not unstashed." >&2
 		fi
 		exit $status
 	fi
-- 
1.7.6.363.g9b380.dirty
