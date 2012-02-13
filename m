From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/tag.c: Fix a sparse warning
Date: Mon, 13 Feb 2012 18:24:41 +0000
Message-ID: <4F395569.8030106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tmgrennan@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx0bt-0007JY-1s
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab2BMS0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 13:26:40 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:56022 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755515Ab2BMS0j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 13:26:39 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Rx0bl-00024H-k2; Mon, 13 Feb 2012 18:26:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190643>


In particular, sparse complains as follows:

        SP builtin/tag.c
    builtin/tag.c:411:5: warning: symbol 'parse_opt_points_at' was \
        not declared. Should it be static?

In order to suppress the warning, since the parse_opt_points_at()
function does not need to be an external symbol, we simply add the
static modifier to the function definition.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

 builtin/tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 8cfaaf8..fe7e5e5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -408,7 +408,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-int parse_opt_points_at(const struct option *opt __attribute__ ((unused)),
+static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
 			const char *arg, int unset)
 {
 	unsigned char sha1[20];
-- 
1.7.9
