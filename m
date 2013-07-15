From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/9] mailmap: debug: fix malformed fprintf() format directive
Date: Mon, 15 Jul 2013 02:54:10 -0400
Message-ID: <1373871253-96480-7-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgU-00043H-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab3GOGyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:52 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:59953 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:49 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so25034636iet.37
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NevuXOInpYGxX3NfKboyw9+kfPg0QXUg6XHtI+8w0m0=;
        b=Dsj83mzehVERXYpVE8QXcFDTVpNIOh1IBf+YxzP71auyqhlHm52LW3uxoMQ9wvYpSf
         c5nD2ERPQTbTgVlv6NNhFsjhq8ubHEaQ5B64aIOnBYW4SIVdgyGUdx0+MuCDqg6SiQGy
         wD+KmIpib2DNNv2Pn6pLY2M7UccWI3QCK8xikOY6jBYiuKluxr8jkc2kuWSqTqJVN72x
         OGlWVAXwTZKCp9zzj12eQEoyNK0KqAy9bW7jSvBpgERbCWHzzK4WykCepnNcl7KAK3Mw
         bi/zOh7BSwqoZAln9yPl/dwcB8vS18DGigH0AkCqXFq9x+36pgva/R1TfESN5WH3atZv
         /wTg==
X-Received: by 10.42.131.73 with SMTP id y9mr16878644ics.22.1373871289376;
        Sun, 14 Jul 2013 23:54:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230432>

Resolve segmentation fault due to size_t variable being consumed
by '%s'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 0516354..62d998a 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -337,7 +337,7 @@ int map_user(struct string_list *map,
 				*name = mi->name;
 				*namelen = strlen(*name);
 		}
-		debug_mm("map_user:  to '%.*s' <.*%s>\n", *namelen, *name,
+		debug_mm("map_user:  to '%.*s' <%.*s>\n", *namelen, *name,
 				 *emaillen, *email);
 		return 1;
 	}
-- 
1.8.3.2.804.g0da7a53
