From: thadh@google.com
Subject: [PATCH] Allow git config files to use keys containing the hyphen character '-'
Date: Fri, 28 Mar 2008 16:15:33 -0700
Message-ID: <1206746133-25974-1-git-send-email-thadh@google.com>
Cc: thadh@google.com, Thad Hughes <thadh@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 00:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfNo6-0003T8-DL
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 00:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYC1XPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYC1XPk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 19:15:40 -0400
Received: from smtp-out.google.com ([216.239.33.17]:46877 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbYC1XPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 19:15:39 -0400
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id m2SNFZfE012702
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 23:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1206746136; bh=6qeQL1LsvHPX2el5/0QCbxt/qHk=;
	h=DomainKey-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	b=q81Iw3yT3AMkjmmBNpVUY/gN75AN/od2TBWfglMVIOX33EVx5/yIuukLUDZ11YCkn
	JwOo+ZxLW1rY2lfzpo7Bg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer;
	b=WULWPN4F0lgVFgwqvZc9/+GPPq+NgA2JRfZDn9ixd09wRx5Rak5EBROj//hZxI+rs
	4zn+MZRz9kOz/FrHshlTw==
Received: from localhost (thad.corp.google.com [172.18.101.2])
	by zps18.corp.google.com with ESMTP id m2SNFXe9029873;
	Fri, 28 Mar 2008 16:15:33 -0700
Received: by localhost (Postfix, from userid 56997)
	id 2CA7E3970A6; Fri, 28 Mar 2008 16:15:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2.156.ge3c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78444>

From: Thad Hughes <thadh@thad.corp.google.com>

---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 78ceba7..42b2c5d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -496,7 +496,10 @@ public class RepositoryConfig {
 					}
 				}
 				break;
-			} else if (Character.isLetterOrDigit((char) c)) {
+			} else if (Character.isLetterOrDigit((char) c) || c == '-') {
+				// From the git-config man page: 
+				//     The variable names are case-insensitive and only 
+				//     alphanumeric characters and - are allowed.
 				name.append((char) c);
 			} else if ('\n' == c) {
 				r.reset();
-- 
1.5.4.2.156.ge3c5
