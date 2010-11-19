From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/6] http-backend: use end_url_with_slash()
Date: Fri, 19 Nov 2010 20:46:28 +0800
Message-ID: <1290170790-2200-5-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
 <1290170790-2200-3-git-send-email-rctay89@gmail.com>
 <1290170790-2200-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN4-0001C8-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0KSMrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:47:06 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47695 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0KSMrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:47:03 -0500
Received: by mail-pv0-f174.google.com with SMTP id 1so687011pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gf89cPdK2+uiJGx4K7kwVWUZacrDw1y8DbedscN/Qf4=;
        b=QGXmrprUX16pQMJU1syRUoNa+I5fg9sz9ZO+1jqNklD9tpRObtXHEOzHSIuTO9FZ2i
         7FOg+efc8iMg3VDdW8/BYHNu/uxsqH7niaY+9C0+GIwXYigslOdUiq4YWpF6QT6nvf0c
         ZaT5GJIyeiG9HFybslWDrDF9wD/1mXLQg6uYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h/FT2AnB+rXZGG4AjeO65quQonLedRkIogdHGX4wd6r2X3wnBpyL8rnHQX7I9+SXtA
         StpXTjjBxqkU61PFdW9C7Mb2+LJPaVkbPqty6cYqORod2tE+gXaC8oDK1KHHZfqURAzP
         DozUe47Xt91YabcC3hZi2+CoECFeINIaZZW3Y=
Received: by 10.142.172.13 with SMTP id u13mr1642323wfe.403.1290170823519;
        Fri, 19 Nov 2010 04:47:03 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.47.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:47:02 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161748>

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
1.7.3.67.g2a10b
