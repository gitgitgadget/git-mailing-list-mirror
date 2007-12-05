From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/6] parseopt: add flag to stop on first non option
Date: Wed, 5 Dec 2007 19:01:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051900530.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzVP-0001Bp-Hq
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXLETBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLETBa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:01:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:51427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751850AbXLETB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:01:29 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:01:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 05 Dec 2007 20:01:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5ov5DUuS5VouFNkKmZpdXUinhXBY/WYgAEiTsm0
	xpyeLuMMipsAqr
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051858270.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67174>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This allows "git remote --option command --command-option".

 parse-options.c |    2 ++
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e12b428..6df1230 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -229,6 +229,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
 		const char *arg = args.argv[0];
 
 		if (*arg != '-' || !arg[1]) {
+			if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
+				break;
 			argv[j++] = args.argv[0];
 			continue;
 		}
diff --git a/parse-options.h b/parse-options.h
index 102ac31..0d40cd2 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,6 +18,7 @@ enum parse_opt_type {
 
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
+	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 };
 
 enum parse_opt_option_flags {
-- 
1.5.3.7.2157.g9598e
