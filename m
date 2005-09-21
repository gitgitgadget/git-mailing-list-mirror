From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 6/8] fetch.c: Remove redundant test of TO_SCAN in process()
Date: Wed, 21 Sep 2005 20:19:05 +0400 (MSD)
Message-ID: <20050921161905.B5462E01C96@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JO-0006Bd-Fa
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIUQTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIUQTH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:07 -0400
Received: from mivlgu.ru ([81.18.140.87]:3206 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751124AbVIUQTG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:06 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id B5462E01C96; Wed, 21 Sep 2005 20:19:05 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9053>

If the SEEN flag was not set, the TO_SCAN flag cannot be set,
therefore testing it is pointless.

---

 fetch.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

6f33848a2f4aecd061d9499dfc88824235572695
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -136,8 +136,6 @@ static int process(struct object *obj)
 	if (has_sha1_file(obj->sha1)) {
 		parse_object(obj->sha1);
 		/* We already have it, so we should scan it now. */
-		if (obj->flags & TO_SCAN)
-			return 0;
 		obj->flags |= TO_SCAN;
 	} else {
 		if (obj->flags & COMPLETE)
