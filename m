From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] git_connect: change return type to pid_t
Date: Wed, 13 Sep 2006 10:32:00 +0200
Message-ID: <4507C200.1060104@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<45053BA2.6050502@innova-card.com>	<7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>	<45066CFD.5040202@innova-card.com> <450673B7.8050704@innova-card.com>	<4506771D.9040605@innova-card.com> <7vd5a0bcdf.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 10:31:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNQ9r-0006hX-5e
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 10:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWIMIbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 04:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWIMIbn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 04:31:43 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:21578 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751700AbWIMIbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 04:31:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so3063031pyg
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 01:31:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qnlfly35Yc1FJ9g6IO+NLBoY1+iZ5MPl3OiFlJCOzazJkBzpXFF2MbApzWYRFfZMzma7dvvFC1lG1uI6vrtvovvkcM7ud1Nz8bmQRycs4OWZw++v/UhgNccPnstbvLRAo9qA8IUBQBm86LXE8OviYCePRXJjTVGiuPMq/q8UN4Q=
Received: by 10.64.149.15 with SMTP id w15mr5145319qbd;
        Wed, 13 Sep 2006 01:31:39 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id q19sm7110303qbq.2006.09.13.01.31.37;
        Wed, 13 Sep 2006 01:31:38 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5a0bcdf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26908>

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---

 For now I let this function die if an error has occured.
 Current users wouldn't do anything usefull with a negative
 value except exiting.

 cache.h   |    2 +-
 connect.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index ac51ed1..57db7c9 100644
--- a/cache.h
+++ b/cache.h
@@ -359,7 +359,7 @@ #define REF_NORMAL	(1u << 0)
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
-extern int git_connect(int fd[2], char *url, const char *prog);
+extern pid_t git_connect(int fd[2], char *url, const char *prog);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
diff --git a/connect.c b/connect.c
index e6efff9..4bf7914 100644
--- a/connect.c
+++ b/connect.c
@@ -602,7 +602,7 @@ static void git_proxy_connect(int fd[2],
 /*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
-int git_connect(int fd[2], char *url, const char *prog)
+pid_t git_connect(int fd[2], char *url, const char *prog)
 {
 	char command[1024];
 	char *host, *path = url;
-- 
1.4.2
