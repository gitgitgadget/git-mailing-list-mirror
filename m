From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] octopus: remove dead code
Date: Fri, 11 Dec 2009 16:38:59 -0800
Message-ID: <1260578339-30750-3-git-send-email-bebarino@gmail.com>
References: <87zl5p1gsp.fsf@jondo.cante.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 01:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJG1B-00075L-2Z
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 01:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761506AbZLLAjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761455AbZLLAjF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 19:39:05 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39394 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460AbZLLAjC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 19:39:02 -0500
Received: by yxe17 with SMTP id 17so1303739yxe.33
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 16:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OyTNyynrWBXi6Q4ac60plVuoO3AhrxkGwgqbyi5sltU=;
        b=kUqjoUlxkrDKJTavRh4HPMv3l4rOAP2cMbABFhkiRCyjIb45wAk8hQnpbeA4PByGMm
         li1JAErVSonc7m62vYhRRUc2+KaGqF2WgQ+edkNH+JuJxtXgA6fCo0ndD98iTSI9ydVB
         VxYPy4iLJvBVCR7IRQVAyG3OdMjnekhbkKjig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qebkYssWVh3SsslpY9wwA3xuB6VEb5x9rIC63OS1YOZakIwPbF3EmtKCyidHVfVLAK
         894OOOQLKIhV/6/rR5tl94clJ2U9q8H08aJiBTv4EglQv9OTbFdUiOf+rdLkmWXCYady
         JsouRJQvJGRktU2ggKKNgFFbI/CXxBofY8AlI=
Received: by 10.150.174.33 with SMTP id w33mr3648029ybe.2.1260578347989;
        Fri, 11 Dec 2009 16:39:07 -0800 (PST)
Received: from localhost (cpe-72-129-49-143.socal.res.rr.com [72.129.49.143])
        by mx.google.com with ESMTPS id 20sm1522596iwn.9.2009.12.11.16.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 16:39:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.45.g9aadbb
In-Reply-To: <87zl5p1gsp.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135110>

MSG, PARENT, and CNT are never used, just assigned to.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I don't know if this is wanted. Looks like maybe they're used
as simple debug aides?

 git-merge-octopus.sh |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 99b6f8a..3cb0b31 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -44,9 +44,8 @@ esac
 # MRC is the current "merge reference commit"
 # MRT is the current "merge result tree"
 
-MRC=$(git rev-parse --verify -q $head) MSG= PARENT="-p $head"
+MRC=$(git rev-parse --verify -q $head)
 MRT=$(git write-tree)
-CNT=1 ;# counting our head
 NON_FF_MERGE=0
 OCTOPUS_FAILURE=0
 for SHA1 in $remotes
@@ -72,9 +71,6 @@ do
 		;;
 	esac
 
-	CNT=`expr $CNT + 1`
-	PARENT="$PARENT -p $SHA1"
-
 	if test "$common,$NON_FF_MERGE" = "$MRC,0"
 	then
 		# The first head being merged was a fast-forward.
-- 
1.6.6.rc1.45.g9aadbb
