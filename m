From: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
Subject: [PATCH] log-tree: use custom line terminator in line termination mode
Date: Mon, 30 Apr 2012 20:45:55 +0200
Message-ID: <1335811555-23564-1-git-send-email-jk@jk.gs>
References: <86ty01qez7.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 20:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvgq-0008Ch-5G
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab2D3SvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 14:51:11 -0400
Received: from zoidberg.org ([88.198.6.61]:60701 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab2D3SvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 14:51:11 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Apr 2012 14:51:11 EDT
Received: from perceptron.heapsort.bogus (xdsl-89-0-44-98.netcologne.de [::ffff:89.0.44.98])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Mon, 30 Apr 2012 20:46:05 +0200
  id 004010A2.4F9EDDED.00004686
X-Mailer: git-send-email 1.7.10.406.g0017
In-Reply-To: <86ty01qez7.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196591>

When using a custom format in line termination mode (as opposed to line
separation mode), the configured line terminator is not used, so things
like "git log --pretty=3Dtformat:%H -z" do not work properly.

Make it use the line terminator the user ordered.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 log-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 34c49e7..44f0268 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -682,7 +682,7 @@ void show_log(struct rev_info *opt)
 	if (opt->use_terminator) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
-		putchar('\n');
+		putchar(opt->diffopt.line_termination);
 	}
=20
 	strbuf_release(&msgbuf);
--=20
1.7.10
