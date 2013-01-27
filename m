From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/4] mergetool--lib: Improve the help text in guess_merge_tool()
Date: Sun, 27 Jan 2013 13:24:44 -0800
Message-ID: <1359321886-80523-3-git-send-email-davvid@gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZj6-0004lG-HG
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab3A0VY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:24:57 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65417 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab3A0VYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:24:55 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so3311096iad.33
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sa/DgReQl9u6y4r2zqNtssguPsF6Co7YAbV7mFcXYFs=;
        b=zu3DHNIGfzlsB7D462OR9K4f3EvDbrRyaOyZ+Bu1TxXlGPWgXpK+H8Eb+B4NoTOG1R
         gTgc+Xl4CzcjbovJnfZ6qK51PV7HfuMZCnJZzFDpze4xa0Wt0i/Lxr3TFocBUrpXpaxI
         oscmzjhTp+Gmx7i4A9147gzlp8WL8OACUC5UQuRFzM0kd0DtV1gixN8nktppD7QjZD4l
         FMaA/khTol0ewSvofNNNaBOlgMv/4/DghSDUjIUqkt1dK5p5txBJJRh5GdngmcZ6Fb1l
         CKxkLDsfQyOZ4GgxL10VHuquXzFeOxJvbeqCk8VsmUlRTRsKZkhJRBLg/z+qVyxjCtIY
         qUCw==
X-Received: by 10.50.53.161 with SMTP id c1mr3422463igp.95.1359321894325;
        Sun, 27 Jan 2013 13:24:54 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mj6sm4503782igc.9.2013.01.27.13.24.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 13:24:53 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.gf25ae33
In-Reply-To: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214735>

This code path is only activated when the user does not have a valid
configured tool.  Add a message to guide new users towards configuring a
default tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9a5aae9..cf52423 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -240,7 +240,14 @@ show_tool_help () {
 
 guess_merge_tool () {
 	list_merge_tool_candidates
-	echo >&2 "merge tool candidates: $tools"
+	msg="\
+
+This message is displayed because '$TOOL_MODE.tool' is not configured.
+See 'git ${TOOL_MODE}tool --tool-help' or 'git help config' for more details.
+'git ${TOOL_MODE}tool' will now attempt to use one of the following tools:
+$tools
+"
+	printf "$msg" >&2
 
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $tools
-- 
1.8.0.13.gf25ae33
