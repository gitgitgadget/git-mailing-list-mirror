From: David Rientjes <rientjes@google.com>
Subject: PATCH [12/28] makes generate_tar void
Date: Mon, 14 Aug 2006 13:29:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141328190.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:29:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj48-00086K-1t
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWHNU3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWHNU3h
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:29:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:52371 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932723AbWHNU3g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:29:36 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7EKT8ui014173
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:29:08 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=far9IAR2L6f3ZSaG2K4HmIiqn3LGrXgx/Qm9kV5TkoODnIYVhBvdYDhxNAxCMmCZf
	CF1AiAXvDKisxu+RskcjQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7EKT6f0005903
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:29:06 -0700
Received: by localhost (Postfix, from userid 24081)
	id C964487D71; Mon, 14 Aug 2006 13:29:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id C6F2687D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:29:06 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25392>

Makes generate_tar void and removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-tar-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 215892b..42230f6 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -308,7 +308,7 @@ int git_tar_config(const char *var, cons
 	return git_default_config(var, value);
 }
 
-static int generate_tar(int argc, const char **argv, const char *prefix)
+static void generate_tar(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20], tree_sha1[20];
 	struct commit *commit;
@@ -354,7 +354,6 @@ static int generate_tar(int argc, const 
 	write_trailer();
 	free(buffer);
 	free(current_path.buf);
-	return 0;
 }
 
 static const char *exec = "git-upload-tar";
@@ -409,7 +408,8 @@ int cmd_tar_tree(int argc, const char **
 		usage(tar_tree_usage);
 	if (!strncmp("--remote=", argv[1], 9))
 		return remote_tar(argc, argv);
-	return generate_tar(argc, argv, prefix);
+	generate_tar(argc, argv, prefix);
+	return 0;
 }
 
 /* ustar header + extended global header content */
-- 
1.4.2.g89bb-dirty
