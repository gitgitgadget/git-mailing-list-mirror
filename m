From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/4] server info: Add HEAD to info/refs
Date: Fri, 27 Apr 2007 04:06:08 +0200
Message-ID: <20070427020608.22991.29273.stgit@rover>
References: <20070427020601.22991.13792.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 04:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhGAa-0005sB-Ua
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 04:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbXD0C0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 22:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbXD0C0g
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 22:26:36 -0400
Received: from rover.dkm.cz ([62.24.64.27]:50258 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422AbXD0C0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 22:26:34 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id A68478BE12;
	Fri, 27 Apr 2007 04:06:08 +0200 (CEST)
In-Reply-To: <20070427020601.22991.13792.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45672>

For some reason, HEAD was not listed in info/refs until now, which means
that git-ls-remote does not return it for dumb transports while the native
transports show it. It would be nice to have it because of git-mirror and
possibly other nifty stuff.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 server-info.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/server-info.c b/server-info.c
index f9be5a7..6cddb11 100644
--- a/server-info.c
+++ b/server-info.c
@@ -36,6 +36,7 @@ static int update_info_refs(int force)
 	info_ref_fp = fopen(path1, "w");
 	if (!info_ref_fp)
 		return error("unable to update %s", path0);
+	head_ref(add_info_ref, NULL);
 	for_each_ref(add_info_ref, NULL);
 	fclose(info_ref_fp);
 	rename(path1, path0);
