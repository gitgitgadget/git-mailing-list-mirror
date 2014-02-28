From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] help.c: rename function "pretty_print_string_list"
Date: Fri, 28 Feb 2014 20:27:29 +0100
Message-ID: <1393615649-29248-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 20:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJT6B-0005UD-My
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaB1T1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:27:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54807 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaB1T1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:27:33 -0500
Received: by mail-ee0-f46.google.com with SMTP id d49so2476010eek.19
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=f9CqvlPSO6v3qbbJpovhjFNjrKZp6zoVIv+Gb71Db5Y=;
        b=Kew5YqbtXF2nC7L6Bk+2puaGiBBsVIV5d5QnNTN1DSQs3ULwJEtEjTEQ6oY7d5uOWU
         dlwwHpNwujo5MwTtZZ/4rBTQQCBjXZja5TCVNksX1O/M1f4VzWGsGmzc63hRzzhGJB62
         3s874iC0X2TD2lxjkI6KmH2tSJ3HFC+92jkdJEuo5l3a8mfc0qS3hj8i8pGv8rF9/HL5
         LLApodyswbH5eQLUbgOXC+TxY3wdEA5NHjRNElmO02Hgy5U3KQD9kN+2hjDRAgZpYV14
         nL2Z+3xJItj4eRiuZ/Mxoq7qOTeIbdy7mTPsN2YxPupGVYyI3KyNK/l7aLeO+TQg+n7c
         zsHQ==
X-Received: by 10.15.21.2 with SMTP id c2mr23367370eeu.77.1393615651849;
        Fri, 28 Feb 2014 11:27:31 -0800 (PST)
Received: from localhost (dslb-178-008-120-172.pools.arcor-ip.net. [178.8.120.172])
        by mx.google.com with ESMTPSA id m8sm14069935eef.14.2014.02.28.11.27.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 11:27:31 -0800 (PST)
X-Mailer: git-send-email 1.9.0.164.g473e143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243006>

The part "string_list" of the name of function
"pretty_print_string_list" is just an implementation
detail. The function pretty-prints command names so
rename it to "pretty_print_cmdnames".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Just noticed this while digging through Git codebase.

 help.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index df7d16d..b266b09 100644
--- a/help.c
+++ b/help.c
@@ -78,8 +78,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	cmds->cnt = cj;
 }
 
-static void pretty_print_string_list(struct cmdnames *cmds,
-				     unsigned int colopts)
+static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
 {
 	struct string_list list = STRING_LIST_INIT_NODUP;
 	struct column_options copts;
@@ -209,14 +208,14 @@ void list_commands(unsigned int colopts,
 		const char *exec_path = git_exec_path();
 		printf_ln(_("available git commands in '%s'"), exec_path);
 		putchar('\n');
-		pretty_print_string_list(main_cmds, colopts);
+		pretty_print_cmdnames(main_cmds, colopts);
 		putchar('\n');
 	}
 
 	if (other_cmds->cnt) {
 		printf_ln(_("git commands available from elsewhere on your $PATH"));
 		putchar('\n');
-		pretty_print_string_list(other_cmds, colopts);
+		pretty_print_cmdnames(other_cmds, colopts);
 		putchar('\n');
 	}
 }
-- 
1.9.0.164.g473e143
