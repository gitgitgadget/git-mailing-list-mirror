From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] test-lib: preserve GIT_CURL_VERBOSE from the environment
Date: Wed, 21 May 2014 06:27:11 -0400
Message-ID: <20140521102710.GA30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3jz-00053E-35
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbaEUK1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:27:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:56401 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691AbaEUK1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:27:13 -0400
Received: (qmail 32350 invoked by uid 102); 21 May 2014 10:27:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:27:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:27:11 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249781>

Turning on this variable can be useful when debugging http
tests. It does break a few tests in t5541, but it is not
a variable that the user is likely to have enabled
accidentally.

Signed-off-by: Jeff King <peff@peff.net>
---
Not necessary for this series, but I found it helpful.

I took a look at making the tests in t5541 work with it, but it's a
little nasty (we have to separate the curl output from the regular
stderr). Unsetting GIT_CURL_VERBOSE for those tests would also be an
option. Or just dropping this patch is OK with me, too; it's really only
for debugging.

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c081668..f7e55b1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -91,6 +91,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		VALGRIND
 		UNZIP
 		PERF_
+		CURL_VERBOSE
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.0.0.rc1.436.g03cb729
