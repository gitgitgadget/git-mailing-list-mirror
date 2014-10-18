From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] revision: remove definition of unused 'add_object' function
Date: Sat, 18 Oct 2014 22:36:12 +0100
Message-ID: <5442DD4C.9050908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 23:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfbg4-0006v1-Ix
	for gcvg-git-2@plane.gmane.org; Sat, 18 Oct 2014 23:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbaJRVgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 17:36:40 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52629 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbaJRVgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 17:36:40 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 87F86400AFD
	for <git@vger.kernel.org>; Sat, 18 Oct 2014 22:36:30 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 5CF44AC40BF;
	Sat, 18 Oct 2014 22:36:20 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 0DAD0AC40BD;
	Sat, 18 Oct 2014 22:36:20 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Sat, 18 Oct 2014 22:36:19 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

I noticed that your 'jk/prune-mtime' branch removes the last caller
of the add_object() function; specifically commit 5f78a431a
("reachable: use traverse_commit_list instead of custom walk", 15-10-2014).

If you need to re-roll those patches, could you please squash this
patch into the above commit. (unless you have plans to add some new
callers, of course! ;-) ).

Thanks!

ATB,
Ramsay Jones

 revision.c | 10 ----------
 revision.h |  5 -----
 2 files changed, 15 deletions(-)

diff --git a/revision.c b/revision.c
index 1316fe0..7bdf760 100644
--- a/revision.c
+++ b/revision.c
@@ -87,16 +87,6 @@ void show_object_with_name(FILE *out, struct object *obj,
 	fputc('\n', out);
 }
 
-void add_object(struct object *obj,
-		struct object_array *p,
-		struct name_path *path,
-		const char *name)
-{
-	char *pn = path_name(path, name);
-	add_object_array(obj, pn, p);
-	free(pn);
-}
-
 static void mark_blob_uninteresting(struct blob *blob)
 {
 	if (!blob)
diff --git a/revision.h b/revision.h
index 9ab6755..b90f907 100644
--- a/revision.h
+++ b/revision.h
@@ -282,11 +282,6 @@ char *path_name(const struct name_path *path, const char *name);
 extern void show_object_with_name(FILE *, struct object *,
 				  const struct name_path *, const char *);
 
-extern void add_object(struct object *obj,
-		       struct object_array *p,
-		       struct name_path *path,
-		       const char *name);
-
 extern void add_pending_object(struct rev_info *revs,
 			       struct object *obj, const char *name);
 extern void add_pending_sha1(struct rev_info *revs,
-- 
2.1.0
