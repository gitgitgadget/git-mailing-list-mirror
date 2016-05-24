From: Yong Bakos <junk@humanoriented.com>
Subject: [PATCH] transport, send-pack: append period to up-to-date message
Date: Tue, 24 May 2016 14:51:44 -0600
Message-ID: <1464123104-45513-1-git-send-email-junk@humanoriented.com>
Cc: Yong Bakos <junk@humanoriented.com>, barkalow@iabervon.org,
	Yong Bakos <ybakos@humanoriented.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 23:08:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5JYd-0004RO-RM
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 23:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbcEXVIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 17:08:01 -0400
Received: from outmail149057.authsmtp.net ([62.13.149.57]:60574 "EHLO
	outmail149057.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752427AbcEXVIA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 17:08:00 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 May 2016 17:07:59 EDT
Received: from mail-c247.authsmtp.com (mail-c247.authsmtp.com [62.13.128.247])
	by punt20.authsmtp.com (8.14.2/8.14.2/) with ESMTP id u4OKqGxu015920;
	Tue, 24 May 2016 21:52:16 +0100 (BST)
Received: from hades-fedora-localdomain.localdomain (cpe-76-184-32-111.tx.res.rr.com [76.184.32.111])
	(authenticated bits=0)
	by mail.authsmtp.com (8.14.2/8.14.2/) with ESMTP id u4OKqA99038749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2016 21:52:12 +0100 (BST)
X-Mailer: git-send-email 2.7.2
X-Server-Quench: 642319df-21f1-11e6-bcde-0015176ca198
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCdxaQoTA1ZXUQIZ IiMZCSZGTh8kKxtQ DBNFJgxfNl8UURhQ KkJXbgYSJgdAAnRQ SnkJW1VSQF9wU2Z3 YQtSIwJbfEtGWxtp UlZIQ1NNFgBqBAMA SFsaLWIzBgxPeH14 YkJrEHVSXkw0c0J/ QU9dQTsbZ2Y2aX0e URVealEHJFZXfh9E b1F4UiBcYGwPKBEA NjMYHwV5IS9WLj9N RRsRaRoJTEAHWyY1 TBNQVTw3BUADS20r IgYnLVJUAEFZL113 LVxkVVsEPlcXBxZF Fk5AaAAA
X-Authentic-SMTP: 61633239323630.1038:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 76.184.32.111/2525
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295533>

Appending a period to "Everything up-to-date" makes the output message
consistent with similar output in builtin/merge.c.

Signed-off-by: Yong Bakos <ybakos@humanoriented.com>
---
 builtin/send-pack.c | 2 +-
 transport.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1ff5a67..67d9304 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -294,7 +294,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}

 	if (!ret && !transport_refs_pushed(remote_refs))
-		fprintf(stderr, "Everything up-to-date\n");
+		fprintf(stderr, "Everything up-to-date.\n");

 	return ret;
 }
diff --git a/transport.c b/transport.c
index 095e61f..53d5405 100644
--- a/transport.c
+++ b/transport.c
@@ -942,7 +942,7 @@ int transport_push(struct transport *transport,
 		if (porcelain && !push_ret)
 			puts("Done");
 		else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
+			fprintf(stderr, "Everything up-to-date.\n");

 		return ret;
 	}
--
2.7.2
