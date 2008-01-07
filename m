From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH 1/5] Add streq() to compat-util
Date: Mon,  7 Jan 2008 06:47:31 +0100
Message-ID: <1199684855-14246-1-git-send-email-ct@pipapo.org>
Cc: gitster@pobox.com, Christian Thaeter <ct@pipapo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 06:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBkqI-0006Yg-Km
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYAGFrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYAGFrl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:47:41 -0500
Received: from pipapo.org ([217.140.77.75]:1098 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199AbYAGFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:47:40 -0500
Received: from localhost (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with SMTP id 8077D34F59E32;
	Mon,  7 Jan 2008 06:47:36 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Mon, 07 Jan 2008 06:47:35 +0100
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69763>

streq() compares strings for equality, it differs from strcmp() in that
it can handle NULL pointers and that it short-circruits if a==b.

returns 1 if the strings are equal (or both are NULL) and 0 when not.

Signed-off-by: Christian Thaeter <ct@pipapo.org>
---
Here comes a series of patches to reinit libgit with subsequent
setup_git_directory() calls. So far, this only suffices for simple
tasks like scanning a list of repositories (buiding the start page
of a repository browser). There are still a lot of things not
fixed yet (grep for '\tstatic', object & graft cache etc.).
Nevertheless, it works for me so far.

 git-compat-util.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..759e94c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -424,4 +424,13 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+static inline int streq(const char *a, const char* b)
+{
+	if (a == b)
+		return 1;
+	if (a && b)
+		return !strcmp(a, b);
+	return 0;
+}
+
 #endif
-- 
1.5.3.7
