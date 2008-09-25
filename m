From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] remote.c: make free_ref(), parse_push_refspec() and free_refspecs() static.
Date: Thu, 25 Sep 2008 18:41:00 +0900
Message-ID: <20080925184100.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 11:42:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KinN0-0006NZ-0R
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 11:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYIYJle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYIYJle
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 05:41:34 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43293 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbYIYJle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 05:41:34 -0400
Received: from f.earth.lavabit.com (f.earth.lavabit.com [192.168.111.15])
	by karen.lavabit.com (Postfix) with ESMTP id 36C0CC8A37;
	Thu, 25 Sep 2008 04:41:33 -0500 (CDT)
Received: from 2236.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id TIDIE2Z4CNW1; Thu, 25 Sep 2008 04:41:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tVrbyC4EGNj321RVzda9jwWrBGi/YEtUfYwFHLmVbmTiTlXwZ11us+ObY/c/KBX8F3CWzK1h0BJxSJXhxtBjHDBWdl8E/4FFo/rz1fsnEv4pCCNw03qqt8u9Vo7UegfqT3JtY7jC98mGoKTGCyl1mWnDhBCM119MpJ5j38vZ7vs=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96738>

These functions are not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 remote.c |    6 +++---
 remote.h |    2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 3f3c789..c45d96e 100644
--- a/remote.c
+++ b/remote.c
@@ -455,7 +455,7 @@ static int verify_refname(char *name, int is_glob)
  *          and dst pointers are always freeable pointers as well
  *          as the refspec pointer itself.
  */
-void free_refspecs(struct refspec *refspec, int nr_refspec)
+static void free_refspecs(struct refspec *refspec, int nr_refspec)
 {
 	int i;
 
@@ -613,7 +613,7 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
-struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
+static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
@@ -783,7 +783,7 @@ struct ref *copy_ref_list(const struct ref *ref)
 	return ret;
 }
 
-void free_ref(struct ref *ref)
+static void free_ref(struct ref *ref)
 {
 	if (!ref)
 		return;
diff --git a/remote.h b/remote.h
index 2601f6e..c6163ff 100644
--- a/remote.h
+++ b/remote.h
@@ -77,8 +77,6 @@ void ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
-struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
-void free_refspecs(struct refspec *refspec, int nr_refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int all);
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
