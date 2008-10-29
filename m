From: Jeff King <peff@peff.net>
Subject: [PATCH] increase git el1T3nEss
Date: Wed, 29 Oct 2008 13:06:31 -0400
Message-ID: <20081029170631.GA12078@sigill.intra.peff.net>
References: <1225257832-29086-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>, Sam Vilain <sam@vilain.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:08:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEWN-00085H-HL
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 18:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbYJ2RGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYJ2RGg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 13:06:36 -0400
Received: from peff.net ([208.65.91.99]:1430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbYJ2RGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 13:06:35 -0400
Received: (qmail 29526 invoked by uid 111); 29 Oct 2008 17:06:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 13:06:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 13:06:31 -0400
Content-Disposition: inline
In-Reply-To: <1225257832-29086-1-git-send-email-pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99383>

The uptake of git by script kiddies has been disappointingly
minimal. Let's make it more palatable by allowing mixed-case
and l33t-speak commands.

Signed-off-by: Jeff King <peff@peff.net>
---
This commit was made by "git c0mM1t".

 git.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 89feb0b..fd0ca67 100644
--- a/git.c
+++ b/git.c
@@ -261,6 +261,31 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	return 0;
 }
 
+static char deelite(char in) {
+	if (isalpha(in))
+		return tolower(in);
+	switch (in) {
+	case '0': return 'o';
+	case '1': return 'i';
+	case '3': return 'e';
+	case '5': return 's';
+	case '7': return 'l';
+	}
+	return in;
+}
+
+static int elitecmp(const char *a, const char *b) {
+	while (1) {
+		char ca = deelite(*a), cb = deelite(*b);
+		if (ca != cb)
+			return ca < cb ? -1 : 1;
+		if (!ca)
+			return 0;
+		a++;
+		b++;
+	}
+}
+
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
@@ -381,7 +406,7 @@ static void handle_internal_command(int argc, const char **argv)
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
-		if (strcmp(p->cmd, cmd))
+		if (elitecmp(p->cmd, cmd))
 			continue;
 		exit(run_command(p, argc, argv));
 	}
-- 
1.6.0.3.764.ge6f2.dirty
