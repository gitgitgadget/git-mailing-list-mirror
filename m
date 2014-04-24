From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 1/9] diff: add a config option to control orderfile
Date: Thu, 24 Apr 2014 12:30:51 +0300
Message-ID: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 12:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGlV-0007NP-N1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 12:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbaDXKTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 06:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62531 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbaDXKTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:04 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OAIg2J001985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 24 Apr 2014 06:18:44 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3O9U5W7030081;
	Thu, 24 Apr 2014 05:30:06 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246960>

I always want my diffs to show header files first,
then .c files, then the rest. Make it possible to
set orderfile though a config option to achieve this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index b79432b..6bcb26b 100644
--- a/diff.c
+++ b/diff.c
@@ -264,6 +264,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.orderfile"))
+		return git_config_string(&default_diff_options.orderfile, var, value);
+
 	if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
-- 
MST
