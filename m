From: davi.reis@gmail.com
Subject: [PATCH 1/2] Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Thu,  9 Sep 2010 11:21:53 -0700
Message-ID: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
Cc: Davi Reis <davi@davi-macbookpro.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 20:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otlmq-0005nD-KQ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0IISXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:23:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55707 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab0IISXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:23:46 -0400
Received: by gyd8 with SMTP id 8so778567gyd.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RWEClpNb2YYhGvDRWF7cxhhHnEFQL4ANXv2RMchRmM0=;
        b=te5g2Ms50pcBZhf//sorr6zoSH+YilzNyoKBFk3BpAm/h6+KRfdeXy+m0bWFihHqJ9
         RBCjqza/oKTaWriP0rqh7bbZkA1VViJHpum2OAygEqPb8+asgvMOqSWv9VxMEEc+1WV1
         n2LxVxg1p8O1ErwaaSet4i0FmauULlx2OlNgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wzuB0NU4FiaV1OSizICqSP/kkA/5b1Uoyln8Z9DCdVi4urxqR2IF84vESIaejWUHy5
         HQI6tuDxfdtMRZA0ddRSW2nqfhfNZqNnsteJufLFbgic11Eh2fapfvlZZnKwWRfCN4MP
         RNHIwlNP5jjvnqPSkCVpTnycQPDLoOlwOuvMQ=
Received: by 10.150.215.2 with SMTP id n2mr422117ybg.19.1284056625387;
        Thu, 09 Sep 2010 11:23:45 -0700 (PDT)
Received: from localhost.localdomain (dhcp-172-19-8-195.mtv.corp.google.com [172.19.8.195])
        by mx.google.com with ESMTPS id x3sm7858350ybl.22.2010.09.09.11.23.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 11:23:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155870>

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
