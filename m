From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 4/9] http-fetch: Actually watch the file descriptors of interest.
Date: Wed, 01 Feb 2006 11:44:33 +0000
Message-ID: <20060201114433.5042.22737.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPm-00055O-4J
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWBALof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBALof
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:35 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:5872 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1030255AbWBALoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:34 -0500
Received: (qmail 6548 invoked from network); 1 Feb 2006 11:44:33 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?RipeeQKXm3DWw6nWNmowSWEEr/tLYhI1?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:33 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15410>

From: Mark Wooding <mdw@distorted.org.uk>

Presumably this was just some kind of oversight.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 0a70e1c..521323c 100644
--- a/http.c
+++ b/http.c
@@ -425,6 +425,8 @@ void run_active_slot(struct active_reque
 			FD_ZERO(&excfds);
 			select_timeout.tv_sec = 0;
 			select_timeout.tv_usec = 50000;
+			curl_multi_fdset(curlm, &readfds, &writefds,
+					 &excfds, &max_fd);
 			select(max_fd, &readfds, &writefds,
 			       &excfds, &select_timeout);
 		}
