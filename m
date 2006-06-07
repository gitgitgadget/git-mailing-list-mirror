From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Off-by-one error in get_path_prefix(), found by Valgrind
Date: Wed, 07 Jun 2006 13:01:40 -0400
Message-ID: <20060607170140.13372.64613.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jun 07 19:02:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo1Pk-00058H-Vj
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 19:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWFGRBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 13:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFGRBu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 13:01:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32446 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932336AbWFGRBt
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 13:01:49 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fo1Pe-0004iZ-Ba
	for git@vger.kernel.org; Wed, 07 Jun 2006 13:01:47 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fo1PY-0003Tn-PO
	for git@vger.kernel.org; Wed, 07 Jun 2006 13:01:40 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21443>

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 builtin-tar-tree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 5f740cf..05da1f2 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -166,8 +166,8 @@ static unsigned int ustar_header_chksum(
 static int get_path_prefix(const struct strbuf *path, int maxlen)
 {
 	int i = path->len;
-	if (i > maxlen)
-		i = maxlen;
+	if (i >= maxlen)
+		i = maxlen - 1;
 	while (i > 0 && path->buf[i] != '/')
 		i--;
 	return i;
