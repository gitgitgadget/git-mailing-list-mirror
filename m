From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Trivial fix: Display a more friendly message with git-shell.
Date: Sun, 20 Sep 2009 13:11:12 -0400
Message-ID: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 19:11:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpPwo-0000Td-Ip
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 19:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbZITRLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 13:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZITRLZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 13:11:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:7116 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbZITRLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 13:11:25 -0400
Received: by qw-out-2122.google.com with SMTP id 5so780597qwd.37
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=i0hwkywrcHqVBAJaiDqwQOOxec0lmZ4S/BK3NDBMUsw=;
        b=eJ0zzWmz6tHT9Eykidu35/j+1QFYIT0EQSV4vr9an49JuZ1ilKZEP/Dq/ykTA3t+zp
         4rzjAUQB4dAYE6LGFOP9oMAX1YjlTU3WO4KBZcpzF/VKYzMOWug/YnX5+EIX3ZGMv5AR
         FyIhuniVF7DwNKMYWO0r5lOVXm4M+5BT1SoHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QYoUMzLHce+e9JaiWK3sba+0/irWQGQjQLtTaw61/TbBED3yBjrAUioUWjusvK4tvQ
         7NnsuF3wDVqAoc3r0j+VVBbajcPjyy5fLPWZk+raDInMN7tWgcyM99xmrY9WYEA993A5
         IGaf6lKVQRQAIBX4wEcrWE/vAbuHOvm1QChO4=
Received: by 10.224.118.140 with SMTP id v12mr2793887qaq.360.1253466688795;
        Sun, 20 Sep 2009 10:11:28 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 6sm5676760qwd.23.2009.09.20.10.11.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 10:11:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.37.gf5c31.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128850>

Instead of simply die without give a helpful message, displays the usage
string that shows to the user how it can be used.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 shell.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/shell.c b/shell.c
index e4864e0..aa7f47e 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+static const char shell_usage[] = "git shell -c <command> <argument>";
+
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
@@ -74,7 +76,7 @@ int main(int argc, char **argv)
 	 * where "cmd" is a very limited subset of git commands.
 	 */
 	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+		usage(shell_usage);
 
 	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
-- 
1.6.5.rc1.37.gf5c31.dirty
