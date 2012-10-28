From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/config.c: Fix a sparse warning
Date: Sun, 28 Oct 2012 21:05:25 +0000
Message-ID: <508D9E15.1040105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSa9M-0008AC-Oz
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab2J1VLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:11:53 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:36315 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755675Ab2J1VLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:11:52 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4F35918C504;
	Sun, 28 Oct 2012 21:11:50 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 9A7BF18C455;	Sun, 28 Oct 2012 21:11:49 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Sun, 28 Oct 2012 21:11:48 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208566>


Sparse issues an "Using plain integer as NULL pointer" warning while
checking a 'struct strbuf_list' initializer expression. The initial
field of the struct has pointer type, but the initializer expression
is given as '{0}'. In order to suppress the warning, we simply replace
the initializer with '{NULL}'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

I try to catch these types of warnings while the patches are still
in the pu branch. I don't know how I missed this one, but I don't
remember your 'jk/config-ignore-duplicates' branch being in pu.

Sorry about that.

ATB,
Ramsay Jones

 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index f881053..e796af4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -165,7 +165,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 static int get_value(const char *key_, const char *regex_)
 {
 	int ret = CONFIG_GENERIC_ERROR;
-	struct strbuf_list values = {0};
+	struct strbuf_list values = {NULL};
 	int i;
 
 	if (use_key_regexp) {
-- 
1.8.0
