From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-clone.txt: remove the restriction on pushing from a shallow clone
Date: Fri, 12 Jul 2013 12:37:42 +0700
Message-ID: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 07:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxW3H-0000uP-Ic
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 07:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3GLFhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 01:37:51 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:42358 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3GLFhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 01:37:50 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so8678477pbc.24
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SFuUmbEUEF+oddZku8nlabgPLLdFeIeACIHEkfOnakI=;
        b=r3YzYUQ7xHm7Bd+uMRAAbls6DZNkyC37iskZ8eznE0itLrvZfJ9U6/pT83AJkePOH+
         GizySylY2mJR2qhRTxbNS6BgXrd91e1ykJI4zkWT4ASty+V+Tx1WQE3YcRBfg9WtpCrJ
         dKq5YBVFpnzJoNi/S67F/aQhrur+kKynX3QwcTgZGNgQ/bT9f9OiC9ByrCcvrqy17h94
         X8rrh2gZXdh/Zr0AD4ZksFNIs5V6/eI3cS3ezkLWG/O36l5xQQ3wuVZuRaecJWbjiHYW
         sKK0ZuYNFb2ymeSu1wuKfXC4EIh3u+aD3OvqoXTK6LCOfso5aiqr47JdW8Nq/D58EiS+
         SN/g==
X-Received: by 10.68.189.101 with SMTP id gh5mr40450799pbc.86.1373607469827;
        Thu, 11 Jul 2013 22:37:49 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ne6sm38873051pbc.28.2013.07.11.22.37.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 22:37:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 12 Jul 2013 12:37:44 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230159>

The document says one cannot push from a shallow clone. But that is
not true (maybe it was at some point in the past). The client does not
stop such a push nor does it give any indication to the receiver that
this is a shallow push. If the receiver accepts it, it's in.

Since 52fed6e (receive-pack: check connectivity before concluding "git
push" - 2011-09-02), receive-pack is prepared to deal with broken
push, a shallow push can't cause any corruption. Update the document
to reflect that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..85769b8 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -182,11 +182,13 @@ objects from the source repository into a pack in=
 the cloned repository.
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
-	are only interested in the recent history of a large project
-	with a long history, and would want to send in fixes
-	as patches.
+	number of limitations (you cannot clone or fetch from it, nor
+	push into it), but is adequate if you are only interested in
+	the recent history of a large project with a long history.
++
+Pushing from a shallow clone should be avoided if the git version on
+the receiver end is older than v1.7.10, or any other git
+implementation that does not perform connectivity check.
=20
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
--=20
1.8.2.82.gc24b958
