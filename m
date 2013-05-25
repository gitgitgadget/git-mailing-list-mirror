From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/9] transport-helper: add 'force' to 'export' helpers
Date: Fri, 24 May 2013 21:47:33 -0500
Message-ID: <1369450060-19011-3-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Yk-0005Gs-Ni
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab3EYCuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:13 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:42463 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab3EYCuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:12 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so6324759obc.11
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PESIdR3QqY3mwptikwDQ6XdYIw5Uj0sdlWJRhSS846k=;
        b=W1vxMXq+AFKpSVSK9TLHKYkAq+ulzGv5ed8hS0KwZIYkNTCUItrp3YH/qrY2c6zLgR
         4KCz1lSyQe+podv4PSe3lrPpir1XBOg3gTNDKJEKaKT5ucdSx+Sg/eZhtvOCKpRh3YBD
         PWNm/C2R6bWZmrppoxhTqFiLdLKPTia0zHE0gUfEzJh50ld/wrDvQEh7Qy/V7npHerzp
         gPEFjudkUQ/+KcDPkzw1gjPJlQjW8TgslhOe7O5wqg0YVVaxl8Qx4SRCOnFl16fqW/im
         HbrNXNrVgZKmmawzP9nKWAwgytdZeqkX9ysYPmNt9ah/DG2WEAQO4xDpn/yPdvdx+sGv
         Woag==
X-Received: by 10.182.165.131 with SMTP id yy3mr13600260obb.36.1369450163822;
        Fri, 24 May 2013 19:49:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20119986obi.8.2013.05.24.19.49.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:49:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225477>

Otherwise they cannot know when to force the push or not (other than
hacks).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 85c951f..22f31a2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -814,6 +814,9 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE)
+		set_helper_option(transport, "force", "true");
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.3.rc3.312.g47657de
