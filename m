From: ted@tedpavlic.com
Subject: [StGit PATCH 2/2] Make bash completion fail to bashdefault before default completion.
Date: Mon, 19 Jan 2009 19:46:13 -0500
Message-ID: <1232412373-10836-2-git-send-email-ted@tedpavlic.com>
References: <1232412373-10836-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 20 01:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4ma-00022g-6k
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760791AbZATAqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760291AbZATAqV
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:46:21 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:46805 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760170AbZATAqU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 19:46:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id C8C3E80D8039;
	Mon, 19 Jan 2009 19:40:26 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbEq5K7ALhdf; Mon, 19 Jan 2009 19:40:26 -0500 (EST)
Received: from localhost.localdomain (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 755F980D8035;
	Mon, 19 Jan 2009 19:40:26 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
In-Reply-To: <1232412373-10836-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106421>

From: Ted Pavlic <ted@tedpavlic.com>

If "-o bashdefault" isn't possible, use old "-o default" only.

(this patch inspired by similar mechanism in Mercurial bash completion
script)

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 stgit/completion.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/completion.py b/stgit/completion.py
index b3fd282..56e81c2 100644
--- a/stgit/completion.py
+++ b/stgit/completion.py
@@ -129,7 +129,8 @@ def main_switch(commands):
         'esac')
 
 def install():
-    return ['complete -o default -F _stg stg']
+    return ['complete -o bashdefault -o default -F _stg stg 2>/dev/null \\', [
+            'complete -o default -F _stg stg' ] ]
 
 def write_completion(f):
     commands = stgit.commands.get_commands(allow_cached = False)
-- 
1.6.1.87.g15624
