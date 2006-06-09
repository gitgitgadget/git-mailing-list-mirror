From: SungHyun Nam <goweol@gmail.com>
Subject: [PATCH] git-rm: fix possible segfault
Date: Fri, 9 Jun 2006 11:10:44 +0900
Message-ID: <20060609111044.451c94b1@namsh.wimo.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 04:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoWSc-00068W-Pw
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 04:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWFICKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 22:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWFICKv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 22:10:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:15726 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751335AbWFICKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 22:10:50 -0400
Received: by nz-out-0102.google.com with SMTP id 16so479234nzp
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 19:10:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Y8RCz/jSMmSvQVEs9vEGb+P38A63AW3cc/kuD5aO0Bdr/WETKoLcc88gezCfbIKB2s8SP+Zpo+dUuEClY9ZOudyOUP3ArFxWNo9OGJwEA7iBeYa96KEGuFnWwh3Praitczt2uMq3E0Y6TNROXTvEmJF9EgiUXOjtFQ8lemt/YmY=
Received: by 10.37.2.14 with SMTP id e14mr3233112nzi;
        Thu, 08 Jun 2006 19:10:50 -0700 (PDT)
Received: from namsh.wimo.co.kr ( [218.147.190.238])
        by mx.gmail.com with ESMTP id j7sm1591469nzd.2006.06.08.19.10.48;
        Thu, 08 Jun 2006 19:10:50 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: sylpheed-claws
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21520>


Signed-off-by: SungHyun Nam <goweol@gmail.com>

---
 builtin-rm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index ef2f8b5..aeda415 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -83,6 +83,9 @@ int cmd_rm(int argc, const char **argv, 
 		}
 		die(builtin_rm_usage);
 	}
+	if (i >= argc)
+		usage(builtin_rm_usage);
+
 	pathspec = get_pathspec(prefix, argv + i);
 
 	seen = NULL;
-- 
1.4.0.rc1.gfd7e
