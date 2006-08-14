From: David Rientjes <rientjes@google.com>
Subject: [PATCH 23/28] makes peek_remote void
Date: Mon, 14 Aug 2006 13:37:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141337060.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjC5-0001Wh-8j
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWHNUhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWHNUhu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:37:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35736 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964845AbWHNUht
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:37:49 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7EKblhh028931
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:47 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ji80DyV/jlphK5xWIFbIXsvXUXUNixT7pgO7ArRSGcUS99l6+BmoSDuSPrzUhNIhq
	ffGKvfDqtT3RXYFJhK20w==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps76.corp.google.com with ESMTP id k7EKbhQk029927
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:43 -0700
Received: by localhost (Postfix, from userid 24081)
	id 10B8287D71; Mon, 14 Aug 2006 13:37:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id BDB0187D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:37:41 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25404>

Makes peek_remote void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 peek-remote.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/peek-remote.c b/peek-remote.c
index 2b30980..b093461 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -7,7 +7,7 @@ static const char peek_remote_usage[] =
 "git-peek-remote [--exec=upload-pack] [host:]directory";
 static const char *exec = "git-upload-pack";
 
-static int peek_remote(int fd[2], unsigned flags)
+static void peek_remote(int fd[2], unsigned flags)
 {
 	struct ref *ref;
 
@@ -18,12 +18,11 @@ static int peek_remote(int fd[2], unsign
 		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
 		ref = ref->next;
 	}
-	return 0;
 }
 
 int main(int argc, char **argv)
 {
-	int i, ret;
+	int i;
 	char *dest = NULL;
 	int fd[2];
 	pid_t pid;
@@ -64,9 +63,9 @@ int main(int argc, char **argv)
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = peek_remote(fd, flags);
+	peek_remote(fd, flags);
 	close(fd[0]);
 	close(fd[1]);
 	finish_connect(pid);
-	return ret;
+	return 0;
 }
-- 
1.4.2.g89bb-dirty
