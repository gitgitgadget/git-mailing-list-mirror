From: David Rientjes <rientjes@google.com>
Subject: [PATCH 19/28] makes finish_pack void
Date: Mon, 14 Aug 2006 13:35:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141334170.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:35:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj9j-000101-9O
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWHNUfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWHNUfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:35:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2199 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932732AbWHNUfH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:35:07 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7EKZ6MY003284
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:06 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=rniCtPmK1zKTp5wQG76ea57noGNqEzptIB7xiEoDEfib68ecL5q/33FSaIBZz5oTf
	kHxBBZhRtswD2UBcvtPLQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7EKZ5jt003083
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:05 -0700
Received: by localhost (Postfix, from userid 24081)
	id 21E6687D71; Mon, 14 Aug 2006 13:35:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 1E40187D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:05 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25400>

Makes finish_pack void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 fetch-clone.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-clone.c b/fetch-clone.c
index 5e84c46..72750c4 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -4,7 +4,7 @@ #include "pkt-line.h"
 #include <sys/wait.h>
 #include <sys/time.h>
 
-static int finish_pack(const char *pack_tmp_name, const char *me)
+static void finish_pack(const char *pack_tmp_name, const char *me)
 {
 	int pipe_fd[2];
 	pid_t pid;
@@ -87,7 +87,6 @@ static int finish_pack(const char *pack_
 		 "%s/pack/pack-%s.idx", get_object_directory(), hash);
 	move_temp_to_file(idx, final);
 	chmod(final, 0444);
-	return 0;
 
  error_die:
 	unlink(idx);
@@ -297,5 +296,6 @@ int receive_keep_pack(int xd[2], const c
 		}
 	}
 	close(ofd);
-	return finish_pack(tmpfile, me);
+	finish_pack(tmpfile, me);
+	return 0;
 }
-- 
1.4.2.g89bb-dirty
