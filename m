From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/22] remote: use xstrdup() instead of strdup()
Date: Thu, 15 Sep 2011 23:10:37 +0200
Message-ID: <1316121043-29367-17-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JKk-00010Q-A8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935015Ab1IOVSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:18:54 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40179 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934995Ab1IOVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:18:52 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8z-00019o-84; Thu, 15 Sep 2011 23:06:49 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181511>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c           |    2 +-
 transport-helper.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 6fcf809..e52aa9b 100644
--- a/remote.c
+++ b/remote.c
@@ -815,7 +815,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 						    refspec->dst, &ret))
 				return ret;
 		} else if (!strcmp(refspec->src, name))
-			return strdup(refspec->dst);
+			return xstrdup(refspec->dst);
 	}
 	return NULL;
 }
diff --git a/transport-helper.c b/transport-helper.c
index 4eab844..0713126 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -183,7 +183,7 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
+			refspecs[refspec_nr++] = xstrdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (!prefixcmp(capname, "export-marks ")) {
@@ -445,7 +445,7 @@ static int fetch_with_import(struct transport *transport,
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
 		else
-			private = strdup(posn->name);
+			private = xstrdup(posn->name);
 		read_ref(private, posn->old_sha1);
 		free(private);
 	}
-- 
1.7.6.8.gd2879
