From: davi.reis@gmail.com
Subject: [PATCH] Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Wed,  8 Sep 2010 22:40:26 -0700
Message-ID: <1284010826-81989-2-git-send-email-davi.reis@gmail.com>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
Cc: Davi Reis <davi@davi-macbookpro.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 07:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtZtC-0000fJ-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 07:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab0IIFld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 01:41:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45499 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab0IIFlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 01:41:32 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so946225vws.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 22:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RWEClpNb2YYhGvDRWF7cxhhHnEFQL4ANXv2RMchRmM0=;
        b=h4iJ9sVOTeS4tlexyjuIFOgmC/ncAfDJMldZ5hse/pIaPIDdIpPMg1NWN0Xleds0zJ
         sU7iIBf1VxM7y6NS1u79POg5dLL5HTG+yP7Vgket07h1/3VuBpc6E2J28cOgn8yMxsEu
         5EB832D4UK860N16jvJtCabZUP8RrXJOaOr8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jvbmkkxGPYFRj4PJY9juxXXFDup/FHizq8T6pLYgbvfjTCDc9C5SoHl0t48TWpjw30
         UuxjYdwiFlAZNZJvHq7nTu969dOC9kvuhMkM4EGJAmUy4EhcQThonLoNISgaGDZmo3Uj
         ly6c5q5nSFH/CR2DYX/ashaopeRRuCbhDKxZo=
Received: by 10.220.128.204 with SMTP id l12mr403539vcs.102.1284010889980;
        Wed, 08 Sep 2010 22:41:29 -0700 (PDT)
Received: from localhost.localdomain ([12.108.175.130])
        by mx.google.com with ESMTPS id j34sm528321vcs.28.2010.09.08.22.41.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 22:41:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155842>

From: Davi Reis <davi@davi-macbookpro.local>

---
 builtin/ls-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..fa427e2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -52,6 +52,8 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 		speclen = strlen(spec);
 		if (speclen <= len)
 			continue;
+		if (spec[len] != 0 && spec[len] != '/')
+			continue;
 		if (memcmp(pathname, spec, len))
 			continue;
 		return 1;
-- 
1.7.2.2
