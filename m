From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/4] builtin-clone: fix a memory leak in cmd_clone()
Date: Fri, 21 Nov 2008 01:44:58 +0100
Message-ID: <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:45:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K8y-0007H5-H8
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbYKUAnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbYKUAnx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:53 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47490 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbYKUAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:51 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id CABCC446CD1;
	Fri, 21 Nov 2008 01:43:48 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AACDE148F5; Fri, 21 Nov 2008 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <cover.1227227976.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1227227976.git.vmiklos@frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101488>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-clone.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 8e1a1d3..da21cab 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -516,6 +516,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = transport_get_remote_refs(transport);
 		transport_fetch_refs(transport, refs);
 	}
+	free(dir);
 
 	clear_extra_refs();
 
-- 
1.6.0.4
