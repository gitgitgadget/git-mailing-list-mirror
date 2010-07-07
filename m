From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] merge-recursive: use "up-to-date" instead of "uptodate" in error message for consistency
Date: Wed,  7 Jul 2010 09:54:08 +0200
Message-ID: <9aea70210996b395f5fc04ae48a372f9b51ba182.1278489069.git.nicolas.s.dev@gmx.fr>
References: <7vbpajzro3.fsf@alter.siamese.dyndns.org>
Cc: <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 09:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWPSx-00075z-H2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 09:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab0GGHyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 03:54:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42237 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0GGHyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 03:54:40 -0400
Received: by wyf23 with SMTP id 23so3011569wyf.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=aoYiZVNJGpSVzZgx3E5TH+KG0AJGzdhU8n466UKGrw0=;
        b=hae1BSm9GKQuAcHi1L8q8IrzfnkJPnXKgd1M4AQmwRGW/hGD7i5q/qaJ/oV6HUOTfv
         29MsD6XBo/+NFgCte8GObno2P/T7nMOhbBaYJzSzjjzBGOePJKzSkv/ziqdJqnyW4R/x
         6ibGqfeI/JRfoth85TxdZJ5N+gsDuD7zi3sxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=HE19xwW5wTPQ3SsMjjlrieII2raGMUoQ7EQ6QZBgRu3VOHCId0VufL7IsNduCRlcCW
         ZKfW+wN9Hc0NXEPhmljn7jS6b080ZldhbA9o+rqmLZFXYmHaZ5ySIEUwaPubekiXhEAk
         3AfwDb6koBqZdIggB9sZ3IVwkeXQnS48udqac=
Received: by 10.216.170.129 with SMTP id p1mr539499wel.92.1278489278976;
        Wed, 07 Jul 2010 00:54:38 -0700 (PDT)
Received: from localhost (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id n18sm248930wej.14.2010.07.07.00.54.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 00:54:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.214.g95a9e
In-Reply-To: <7vbpajzro3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150456>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

The 07/07/10, Junio C Hamano wrote:

> The "struct unpack_trees_error_msgs" mechanism was introduced so that we
> can change the Porcelain level messages without breaking the plumbing API,
> which these messages are part of.  Please see 8ccba00 (unpack-trees: allow
> Porcelain to give different error messages, 2008-05-17) and fadd069
> (merge-recursive: give less scary messages when merge did not start,
> 2009-09-07) for backstory.

Oh, thanks. I was unaware of this mechanism and didn't care about what I was
touching.

 Documentation/git-checkout.txt |    2 +-
 merge-recursive.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 261dd90..c04eceb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -263,7 +263,7 @@ the above checkout would fail like this:
 +
 ------------
 $ git checkout mytopic
-fatal: Entry 'frotz' not uptodate. Cannot merge.
+fatal: Entry 'frotz' not up-to-date. Cannot merge.
 ------------
 +
 You can give the `-m` flag to the command, which would try a
diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..fb6aa4a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,7 +1214,7 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(o, 0, "Already uptodate!");
+		output(o, 0, "Already up-to-date!");
 		*result = head;
 		return 1;
 	}
-- 
1.7.2.rc1.214.g95a9e
