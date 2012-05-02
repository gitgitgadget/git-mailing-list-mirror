From: mhagger@alum.mit.edu
Subject: [PATCH 1/2] cmd_fetch_pack(): declare dest to be const
Date: Wed,  2 May 2012 12:40:58 +0200
Message-ID: <1335955259-15309-2-git-send-email-mhagger@alum.mit.edu>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 12:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPWzl-0006EL-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 12:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab2EBKlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 06:41:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37027 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2EBKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 06:41:11 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q42Af4FX009926;
	Wed, 2 May 2012 12:41:08 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196798>

From: Michael Haggerty <mhagger@alum.mit.edu>

There is no need for it to be non-const, and this avoids the need
for casting away constness of argv elements.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 10db15b..7e9d62f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -901,7 +901,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
 	struct ref *ref = NULL;
-	char *dest = NULL, **heads;
+	const char *dest = NULL;
+	char **heads;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -971,7 +972,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			}
 			usage(fetch_pack_usage);
 		}
-		dest = (char *)arg;
+		dest = arg;
 		heads = (char **)(argv + i + 1);
 		nr_heads = argc - i - 1;
 		break;
@@ -1018,7 +1019,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, (char *)dest, args.uploadpack,
+		conn = git_connect(fd, dest, args.uploadpack,
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-- 
1.7.10
