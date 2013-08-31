From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] diff: add a config option to control orderfile
Date: Sat, 31 Aug 2013 22:44:25 +0300
Message-ID: <20130831194425.GA14706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 21:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFr3z-0005i7-IZ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab3HaTmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab3HaTmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:42:23 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7VJgN0u002381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:23 -0400
Received: from redhat.com (vpn1-7-65.ams2.redhat.com [10.36.7.65])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r7VJgLoo006020
	for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:22 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233546>

I always want my diffs to show header files first,
then .c files, then the rest. Make it possible to
set orderfile though a config option to achieve this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index 208094f..cca0767 100644
--- a/diff.c
+++ b/diff.c
@@ -264,6 +264,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+        if (!strcmp(var, "diff.orderfile"))
+                return git_config_string(&default_diff_options.orderfile, var, value);
+
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
-- 
MST
