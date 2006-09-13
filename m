From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] Test return value of finish_connect()
Date: Wed, 13 Sep 2006 10:26:47 +0200
Message-ID: <4507C0C7.3030409@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<45053BA2.6050502@innova-card.com>	<7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>	<45066CFD.5040202@innova-card.com> <450673B7.8050704@innova-card.com>	<4506771D.9040605@innova-card.com> <7vd5a0bcdf.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 10:26:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNQ4o-0005n1-Jb
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 10:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWIMI0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 04:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWIMI0b
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 04:26:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:57763 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751700AbWIMI0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 04:26:31 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1653372nfa
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 01:26:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=PNZ9gMk4PiR2aZWUcTHbZdCrJ9BPXXV6ny5Bgv6y25PGEDA8UyS1HkTjObhSR414BjXbBz+qIBIU30wDNUd2cUnx6nJuMLZR2R8zxU3vZgZQAC8DnYTxVrmUPM5rKAhMAzZ9T8U7PfqntnGsgPOcFrpxhDnm1Zpcoo5MGMc6uRw=
Received: by 10.49.26.18 with SMTP id d18mr10660952nfj;
        Wed, 13 Sep 2006 01:26:29 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id v20sm16755745nfc.2006.09.13.01.26.28;
        Wed, 13 Sep 2006 01:26:28 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5a0bcdf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26907>

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 fetch-pack.c  |    4 ++--
 peek-remote.c |    4 ++--
 send-pack.c   |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1b2d6ee..e8708aa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -525,7 +525,7 @@ int main(int argc, char **argv)
 	ret = fetch_pack(fd, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	finish_connect(pid);
+	ret |= finish_connect(pid);
 
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
@@ -540,5 +540,5 @@ int main(int argc, char **argv)
 			}
 	}
 
-	return ret;
+	return !!ret;
 }
diff --git a/peek-remote.c b/peek-remote.c
index 87f1543..353da00 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -66,6 +66,6 @@ int main(int argc, char **argv)
 	ret = peek_remote(fd, flags);
 	close(fd[0]);
 	close(fd[1]);
-	finish_connect(pid);
-	return ret;
+	ret |= finish_connect(pid);
+	return !!ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 49be764..5bb123a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -443,6 +443,6 @@ int main(int argc, char **argv)
 	ret = send_pack(fd[0], fd[1], nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	finish_connect(pid);
-	return ret;
+	ret |= finish_connect(pid);
+	return !!ret;
 }
-- 
1.4.2
