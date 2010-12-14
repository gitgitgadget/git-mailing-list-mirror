From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin/rm.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Mon, 13 Dec 2010 23:48:10 -0200
Message-ID: <ffd7b63f3ef5e409775a0d730691efdaf4e41592.1292291262.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 02:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSK0Y-0003Dh-Vy
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 02:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758974Ab0LNBsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 20:48:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52790 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932Ab0LNBsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 20:48:45 -0500
Received: by gyb11 with SMTP id 11so59937gyb.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 17:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=d74x8x9zM+8lv6Re61XB1LoWMhneedrkMoJocoaT02g=;
        b=UB4PXFmg9u+fgYTHC9Ev3Z6/jgxK3e6ijqlLIML8H6UDx/qqilhg6pqeftAAYA6fM6
         k192jOGIhSYXsVpzPpA+eP63NdEZ73nMJvjFRgATIwIH/KjusS84mMMxPeMIzoVqMyBZ
         sF/8gMTzhI2WVO2uFvmUhTrkKJbZ2hdUrn51c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=LmHc/QR5bK/YSpx3XHieSjomZAV9iVueaYP6Bsd1AwBWPMDTnsndjg3iMQgJeJX/WJ
         OOLK8Bg5ZlCGH2kw6Y2Wdl2LdwqkAGiUiPaRn2LAbUSAvZd6qwruXHJLYj0VtyxdiBGn
         bi4l3PDdzrWi1r9VCqMBlmfwYYFaNN0IWyCKA=
Received: by 10.150.138.2 with SMTP id l2mr7028477ybd.261.1292291324131;
        Mon, 13 Dec 2010 17:48:44 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id v39sm2888047yba.19.2010.12.13.17.48.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 17:48:43 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163609>

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
