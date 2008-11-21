From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/4] builtin-clone: use strbuf in guess_dir_name()
Date: Fri, 21 Nov 2008 01:44:59 +0100
Message-ID: <33c4500c44cb27b1bfb3ec5584c0665b0dbd7c73.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
 <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K8x-0007H5-Rc
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbYKUAnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbYKUAnw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:52 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47487 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbYKUAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:51 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id C559B446CD0;
	Fri, 21 Nov 2008 01:43:48 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C5E9F148F6; Fri, 21 Nov 2008 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101487>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-clone.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index da21cab..52b1242 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -134,9 +134,9 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	}
 
 	if (is_bare) {
-		char *result = xmalloc(end - start + 5);
-		sprintf(result, "%.*s.git", (int)(end - start), start);
-		return result;
+		struct strbuf result = STRBUF_INIT;
+		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
+		return strbuf_detach(&result, 0);
 	}
 
 	return xstrndup(start, end - start);
-- 
1.6.0.4
