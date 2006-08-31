From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/3] git-tar-tree.c: no need to be in a git repo when using --remote
Date: Thu, 31 Aug 2006 14:35:23 +0200
Message-ID: <11570277232555-git-send-email-vagabon.xyz@gmail.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 31 14:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIllb-0003S9-BR
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHaMf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWHaMf2
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:35:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:47211 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751635AbWHaMf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 08:35:26 -0400
Received: by nf-out-0910.google.com with SMTP id x30so387463nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 05:35:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iSYv+tpF8nEIZyk2exs0FGST+egLCkZDd094m6qU6jvO78Yd/TWZBOkGFezaQklVpbee6HZiOTQ2MGpBCpb071wrCRsYjQorGrymeKeYzYWdz7nOcawf17rIl8U6Fl/eHO+iWekPAvisqx8OTYV5QAyy1v+6ARycfXCj+O3zyFQ=
Received: by 10.49.94.20 with SMTP id w20mr1239250nfl;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id n23sm1548108nfc.2006.08.31.05.35.24;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0E23723F770; Thu, 31 Aug 2006 14:35:24 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26256>

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 builtin-tar-tree.c |    2 ++
 git.c              |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 61a4135..ad1a8a6 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -390,6 +390,8 @@ int cmd_tar_tree(int argc, const char **
 		usage(tar_tree_usage);
 	if (!strncmp("--remote=", argv[1], 9))
 		return remote_tar(argc, argv);
+	if (prefix == NULL)
+		prefix = setup_git_directory();
 	return generate_tar(argc, argv, prefix);
 }
 
diff --git a/git.c b/git.c
index bd07289..c323d30 100644
--- a/git.c
+++ b/git.c
@@ -262,7 +262,7 @@ static void handle_internal_command(int 
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree, RUN_SETUP },
+		{ "tar-tree", cmd_tar_tree },
 		{ "zip-tree", cmd_zip_tree, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
-- 
1.4.2
