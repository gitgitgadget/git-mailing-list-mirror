From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Mark http-fetch without -a as deprecated
Date: Mon, 22 Aug 2011 20:51:43 -0400
Message-ID: <1314060703-24265-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 23 02:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvfDc-0003Ea-5m
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 02:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab1HWAvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 20:51:48 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:38960 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab1HWAvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 20:51:47 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:58105 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QvfDW-0005eq-Re; Mon, 22 Aug 2011 20:51:46 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QvfDW-0006Js-Qq; Mon, 22 Aug 2011 20:51:46 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179907>

As the use of http-fetch without -a can create an object store that is
invalid to the point where it cannot even be fsck'd, mark it as
deprecated.  A future release should change the default and then
remove the option entirely.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 http-fetch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 3af4c71..003ddb7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -56,6 +56,9 @@ int main(int argc, const char **argv)
 		commits = 1;
 	}
 
+	if (get_all == 0)
+	  warning("http-fetch: use without -a is deprecated; -a will become the default in a future release");
+
 	if (argv[arg])
 		str_end_url_with_slash(argv[arg], &url);
 
-- 
1.7.4.1
