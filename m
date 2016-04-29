From: Mike Hommey <mh@glandium.org>
Subject: [RFC PATCH 1/3] connect: make parse_connect_url public
Date: Fri, 29 Apr 2016 09:43:43 +0900
Message-ID: <1461890625-23222-1-git-send-email-mh@glandium.org>
References: <20160428232936.GA8663@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 02:44:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avwXM-0000Q1-0b
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 02:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbcD2Anx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 20:43:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41654 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbcD2Anv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 20:43:51 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avwX3-00063G-Qh; Fri, 29 Apr 2016 09:43:45 +0900
X-Mailer: git-send-email 2.8.1.8.gc23d642.dirty
In-Reply-To: <20160428232936.GA8663@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292964>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 11 ++---------
 connect.h |  9 +++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index c53f3f1..29569b3 100644
--- a/connect.c
+++ b/connect.c
@@ -231,13 +231,6 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-enum protocol {
-	PROTO_LOCAL = 1,
-	PROTO_FILE,
-	PROTO_SSH,
-	PROTO_GIT
-};
-
 int url_is_local_not_ssh(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -591,8 +584,8 @@ static char *get_port(char *host)
  * Extract protocol and relevant parts from the specified connection URL.
  * The caller must free() the returned strings.
  */
-static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_path)
+enum protocol parse_connect_url(const char *url_orig, char **ret_host,
+				char **ret_path)
 {
 	char *url;
 	char *host, *path;
diff --git a/connect.h b/connect.h
index 01f14cd..dede6e8 100644
--- a/connect.h
+++ b/connect.h
@@ -1,6 +1,15 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
+enum protocol {
+	PROTO_LOCAL = 1,
+	PROTO_FILE,
+	PROTO_SSH,
+	PROTO_GIT
+};
+enum protocol parse_connect_url(const char *url_orig, char **ret_host,
+				char **ret_path);
+
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
-- 
2.8.1.8.gc23d642.dirty
