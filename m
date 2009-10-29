From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 18/26] http-backend: use mod_alias instead of mod_rewrite
Date: Wed, 28 Oct 2009 17:00:40 -0700
Message-ID: <1256774448-7625-19-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISn-0000kN-7G
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZJ2ABH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbZJ2ABF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:05 -0400
Received: from george.spearce.org ([209.20.77.23]:36255 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbZJ2AA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DB85638222; Thu, 29 Oct 2009 00:01:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 41F2B381D3;
	Thu, 29 Oct 2009 00:00:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131526>

From: Mark Lodato <lodatom@gmail.com>

In the git-http-backend documentation, use mod_alias exlusively, instead
of using a combination of mod_alias and mod_rewrite.  This makes the
example slightly shorted and a bit more clear.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 0b5e951..e67519d 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -98,13 +98,9 @@ Accelerated static Apache 2.x::
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
 
-ScriptAlias /git/        /usr/libexec/git-core/git-http-backend/
-Alias       /git_static/ /var/www/git/
-
-RewriteEngine on
-RewriteRule ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$    /git_static/$1 [PT]
-RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.pack)$ /git_static/$1 [PT]
-RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.idx)$  /git_static/$1 [PT]
+AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
+AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
+ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 
 
-- 
1.6.5.2.181.gd6f41
