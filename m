From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 5/9] http-backend: use end_url_with_slash()
Date: Thu, 25 Nov 2010 16:21:06 +0800
Message-ID: <1290673270-4284-6-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
 <1290673270-4284-5-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX6n-00009U-Uv
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab0KYIXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:23:08 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0KYIXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:23:07 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M2Zwk6dY/jukge8xuRV/Uh4Rn+BU/CNKv8a7f3LWQFk=;
        b=cmz1lDA0hRXorr9GfUUtP9gQpPkSNoJGCWhLvFirAeV4RT0xVrAES9YAeynDgF1Qg3
         zr3Ut/QOgfCZEKplfIsDx8Pr3zOSrbOFO5rz7K7ivKz7o9bSSM5vNy6ViaGZtNDvhbH0
         D4G7FtGV805zb9vhJn7KN6cQM5W2bEbZhXtP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uhvsx7c/u61ZXI7GrqS/JmAyAZRPMK/oL2UyNTeeaX+81E945g4nUvxDAqNPCa6sBa
         DZ/GG1WUJthpgGfkMg6O9dobCcsw+LIVqL2NKRLX3Bv1EIkxDB9e6uraTrOaD3TD++vi
         agmpr69WGEIhzu/er83kc3OC8bxNJlooWvnFY=
Received: by 10.231.32.66 with SMTP id b2mr348606ibd.27.1290673386864;
        Thu, 25 Nov 2010 00:23:06 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.22.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:23:05 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162110>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-backend.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 14c90c2..8501504 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -510,9 +510,7 @@ static char* getdir(void)
 			die("GIT_PROJECT_ROOT is set but PATH_INFO is not");
 		if (daemon_avoid_alias(pathinfo))
 			die("'%s': aliased", pathinfo);
-		strbuf_addstr(&buf, root);
-		if (buf.buf[buf.len - 1] != '/')
-			strbuf_addch(&buf, '/');
+		end_url_with_slash(&buf, root);
 		if (pathinfo[0] == '/')
 			pathinfo++;
 		strbuf_addstr(&buf, pathinfo);
-- 
1.7.3.2.495.gc7b3f
