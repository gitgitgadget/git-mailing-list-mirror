From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin.h: Move two functions definitions to help.h.
Date: Mon, 30 Aug 2010 22:13:45 -0300
Message-ID: <1283217225-15794-1-git-send-email-tfransosi@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 03:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqFQG-0008Rp-1f
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 03:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab0HaBNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 21:13:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55388 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab0HaBNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 21:13:54 -0400
Received: by gyd8 with SMTP id 8so2236701gyd.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3wYPL076E5g9Q9dBSgvrtzsJY2atxzmLNBU6JJ286/c=;
        b=LWPzJMdmsyHFyaRWfWRbkgK94VLTgBcX2GQ7LJ7mk8P/EKsc8c57mqprXEiuDFyvbd
         dKhaW/WoCAEBKE3KPAFkx/RA6SCHN5v9I36NI3tv3t41+hzL2wMv58P571Lix3PBSRmB
         HnTFfNk0obfqjSyi/hQz7dz+cnQyJB5/8sy0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rP289bOratnOj9BBW/AnxhOpOWgimZEgXHL/o7N9lAK4XLfS1cgCtx1tJgQG0CVU9j
         dGCOWgTVMzCpqmssSKJWZTrRjzVl9yCzPzbshlczxliJtrTTlqZmLDqijACWeUT41afM
         Drg0f7wMXPH3sm0K4g7mh4ZgesxNiHWVxW8s8=
Received: by 10.150.148.17 with SMTP id v17mr1741353ybd.86.1283217233433;
        Mon, 30 Aug 2010 18:13:53 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id u42sm8232178yba.0.2010.08.30.18.13.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 18:13:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154874>

The two functions defined here are implemented in help.c, so makes more sense
to put the definition of those in help.h instead of in builtin.h.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin.h |    2 --
 help.h    |   19 +++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin.h b/builtin.h
index ed6ee26..0398d24 100644
--- a/builtin.h
+++ b/builtin.h
@@ -11,8 +11,6 @@ extern const char git_version_string[];
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
-extern void list_common_cmds_help(void);
-extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
diff --git a/help.h b/help.h
index 56bc154..208af70 100644
--- a/help.h
+++ b/help.h
@@ -16,14 +16,17 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-void load_command_list(const char *prefix,
-		struct cmdnames *main_cmds,
-		struct cmdnames *other_cmds);
-void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+extern void list_common_cmds_help(void);
+extern const char *help_unknown_cmd(const char *cmd);
+extern void load_command_list(const char *prefix,
+                              struct cmdnames *main_cmds,
+		              struct cmdnames *other_cmds);
+extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
-void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
-int is_in_cmdlist(struct cmdnames *c, const char *s);
-void list_commands(const char *title, struct cmdnames *main_cmds,
-		   struct cmdnames *other_cmds);
+extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
+extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
+extern void list_commands(const char *title,
+                          struct cmdnames *main_cmds,
+		          struct cmdnames *other_cmds);
 
 #endif /* HELP_H */
-- 
1.7.2.1.95.g3d045
