From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/4] git-mergetool: don't hardcode 'mergetool' in show_tool_help
Date: Thu, 24 Jan 2013 19:55:15 +0000
Message-ID: <bbf604e6903a23c5c8e7b920b38175a39564f946.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 20:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySuc-0007ah-Im
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079Ab3AXT4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:56:00 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55654 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3AXTz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:55:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id B5A2F231D6;
	Thu, 24 Jan 2013 19:55:56 +0000 (GMT)
X-Quarantine-ID: <fzYm+takZUvA>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzYm+takZUvA; Thu, 24 Jan 2013 19:55:56 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id DE52F231F8;
	Thu, 24 Jan 2013 19:55:51 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1.364.gbbf604e.dirty
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk>
References: <cover.1359057056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214448>

When using show_tool_help from git-difftool we will want it to print
"git difftool" not "git mergetool" so use "git ${TOOL_MODE}tool".

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1748315..4c1e129 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -188,12 +188,14 @@ show_tool_help () {
 			unavailable="$unavailable$i$LF"
 		fi
 	done
+
+	cmd_name=${TOOL_MODE}tool
 	if test -n "$available"
 	then
-		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
 		echo "$available" | sort | sed -e 's/^/	/'
 	else
-		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
 	fi
 	if test -n "$unavailable"
 	then
-- 
1.8.1
