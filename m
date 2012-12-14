From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH 1/2] Make lock local to fetch_pack
Date: Fri, 14 Dec 2012 10:38:19 -0800
Message-ID: <1355510300-31541-2-git-send-email-kraai@ftbfs.org>
References: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 19:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tja9y-0007Wd-A0
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 19:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab2LNSik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 13:38:40 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57376 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756735Ab2LNSij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 13:38:39 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tja9d-0008Df-M5; Fri, 14 Dec 2012 10:38:37 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211496>

From: Matt Kraai <matt.kraai@amo.abbott.com>

lock is only used by fetch_pack, so move it into that function.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 fetch-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 099ff4d..9d9762d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -874,8 +874,6 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static struct lock_file lock;
-
 static void fetch_pack_setup(void)
 {
 	static int did_setup;
@@ -896,6 +894,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct string_list *sought,
 		       char **pack_lockfile)
 {
+	static struct lock_file lock;
 	struct stat st;
 	struct ref *ref_cpy;
 
-- 
1.8.1-rc1
