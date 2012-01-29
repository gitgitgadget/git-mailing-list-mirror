From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 01:41:18 +0200
Message-ID: <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreNt-00089H-8x
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab2A2Xl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:41:59 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56395 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2A2Xl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:41:58 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so2968108wic.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KC8acxjXfIyPyH3WKDzqyG973tb8NG8XRvp0UHuFGE0=;
        b=DXVztfnVVcPGrJTWMP+dyNln/t5zzrlVTzxfRXTcYC89Sot9nrR2f6MTjmc1rQZ4h9
         QHuA9OlkLioOzDucymoPfAcdVv+AQsOQFh0GYaaNJm4X1Nyg/iE2zSbmKhiqW99KgySv
         3D6OjgY6HnqnZVwSLVNjTc9iiGkPnBLpfxBlQ=
Received: by 10.180.101.200 with SMTP id fi8mr4140293wib.20.1327880517962;
        Sun, 29 Jan 2012 15:41:57 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id j16sm46674078wie.4.2012.01.29.15.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 15:41:57 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189305>

We don't need to check for GIT_DIR/remotes, right? This was removed long
time ago.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7051c7a..f7278b5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -643,13 +643,7 @@ __git_refs_remotes ()
 
 __git_remotes ()
 {
-	local i ngoff IFS=$'\n' d="$(__gitdir)"
-	__git_shopt -q nullglob || ngoff=1
-	__git_shopt -s nullglob
-	for i in "$d/remotes"/*; do
-		echo ${i#$d/remotes/}
-	done
-	[ "$ngoff" ] && __git_shopt -u nullglob
+	local i IFS=$'\n' d="$(__gitdir)"
 	for i in $(git --git-dir="$d" config --get-regexp 'remote\..*\.url' 2>/dev/null); do
 		i="${i#remote.}"
 		echo "${i/.url*/}"
-- 
1.7.8.3
