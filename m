From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] fix usage string for git grep
Date: Sun, 20 Jul 2008 14:13:08 -0500 (CDT)
Message-ID: <20080720141308.BIU48280@m4500-01.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 21:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKeMG-00043r-0n
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 21:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYGTTNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYGTTNN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 15:13:13 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:33847 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYGTTNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 15:13:12 -0400
Received: from m4500-01.uchicago.edu (m4500-01.uchicago.edu [128.135.249.211])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6KJDEjv016594
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 14:13:14 -0500
Received: (from m4500-01.uchicago.edu [128.135.249.215])
	by m4500-01.uchicago.edu (MOS 3.8.5-GA)
	with HTTP/1.1 id BIU48280 (AUTH jrnieder@uchicago.edu);
	Sun, 20 Jul 2008 14:13:08 -0500 (CDT)
X-Mailer: Mirapoint Webmail Direct 3.8.5-GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89218>

Without this patch, git-grep gives confusing usage information:

	$ git grep --confused
	usage: git grep <option>* <rev>* [-e] <pattern> [<path>...]
	$ git grep HEAD pattern
	fatal: ambiguous argument 'pattern': unknown revision or path no
	t in the working tree.
	Use '--' to separate paths from revisions

So put <pattern> before the <rev>s, in accordance with actual correct
usage.  While we're changing the usage string, we might as well include
the "--" separating revisions and paths, too.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	Thanks!

 builtin-grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 7bf6a71..631129d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -498,7 +498,7 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 }
 
 static const char builtin_grep_usage[] =
-"git grep <option>* <rev>* [-e] <pattern> [<path>...]";
+"git grep <option>* [-e] <pattern> <rev>* [[--] <path>...]";
 
 static const char emsg_invalid_context_len[] =
 "%s: invalid context length argument";
-- 
1.5.6.4.441.g4b4e9
