From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin/rm.c: Use ALLOG_GROW instead of alloc_nr and xrealloc.
Date: Mon, 13 Dec 2010 23:37:17 -0200
Message-ID: <a09428c75202974dc69b613ae3c2096d82e5a0ca.1292290546.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 02:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSJq0-0007pJ-5f
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 02:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934Ab0LNBhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 20:37:50 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:54215 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758901Ab0LNBhu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 20:37:50 -0500
Received: by gwb20 with SMTP id 20so80205gwb.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 17:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=d74x8x9zM+8lv6Re61XB1LoWMhneedrkMoJocoaT02g=;
        b=Zon5dU/SmHZJkup+qDbkYamP9Fa1cttw/fzUjZt9WFHtJqnLhrsRoYpvifPx4eZxU0
         RFf+CzTA7xybKfrD+H++5YIgN6przdaQpDz89RcVus/R1R/1c0yZzY0KFtei1sUO0QVr
         79AyLCxxkfDer40j2NkQ/qhoTEGcXSWOHXyA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=rNTc1q80Lzm3zbnce+YRJS/mi55rnwCREW0rSMac33/eyeQ2x8GSnjKiWKnu3Q105t
         WjqGKYPbjnUDnbwSiTNkrWadRP9d8T4mY+INIu0JNNAdfEfgHdQ6DZh9a1Z7Epya3oY8
         rT2NI09RCq8zl3jMjGuF9ZI11Is2OdvDK8yYw=
Received: by 10.90.157.7 with SMTP id f7mr5966382age.101.1292290669582;
        Mon, 13 Dec 2010 17:37:49 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id a76sm911922yhd.30.2010.12.13.17.37.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 17:37:48 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163608>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/rm.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index c7b7bb3..faeedfc 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -22,10 +22,7 @@ static struct {
 
 static void add_list(const char *name)
 {
-	if (list.nr >= list.alloc) {
-		list.alloc = alloc_nr(list.alloc);
-		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
-	}
+	ALLOC_GROW(list.name, list.nr + 1, list.alloc);
 	list.name[list.nr++] = name;
 }
 
-- 
1.7.3.2.343.g7d43d
