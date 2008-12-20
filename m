From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] git-mergetool: properly handle "git mergetool -- filename"
Date: Fri, 19 Dec 2008 17:01:01 -0800
Message-ID: <593cce2ad8b4d21995b24f0186e846d98306ae60.1229734788.git.davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 20 02:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDqK4-00062v-Mv
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 02:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbYLTBGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYLTBGq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 20:06:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:59351 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbYLTBGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 20:06:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1156687rvb.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NvoiGXyCotCfA+0xq8N4hg6+/AxF3hYVAhvnFHntTWk=;
        b=hubGwJ0c78jylAfrt0h9Erw8hEiDrGibhn0wxC08s1Z9EaOV8MCw1dyI2HDPRmix6L
         Xu5BWRnqHRfR0YYk2SdOGoBHxMZCvXCb+vhi+ESiQhJds2fsFZh7ZySWu2XjlvrXEvMs
         im3vZ+lY+JgodO8RBKgsEDK8z1IgfdIB27yvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FMqqwcJTQGS683A6VW9mW//nJ6kc2pgqbIbhKvopOUHknNEyKRNYCy3d6EL5dXirUH
         7WsbWrFVYbQkdZ8eZsJi7VaM0DbhemATqy9Zw+op5RGlZ/EP/E/4HCrB1TMx3vXYXcho
         uZucKKOSFnaUSSMA0f9C1Pc0UP8Z5sNTxrG1c=
Received: by 10.141.48.6 with SMTP id a6mr1870790rvk.36.1229735203964;
        Fri, 19 Dec 2008 17:06:43 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g14sm1465251rvb.0.2008.12.19.17.06.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Dec 2008 17:06:43 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc3.38.gec9f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103617>

Like many git commands, git-mergetool allows "--" to signal
the end of option processing.  This adds a missing "shift"
statement so that this is correctly handled.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94187c3..d4078a6 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -296,6 +296,7 @@ do
 	    esac
 	    ;;
 	--)
+	    shift
 	    break
 	    ;;
 	-*)
-- 
1.6.1.rc3.38.gec9f0
