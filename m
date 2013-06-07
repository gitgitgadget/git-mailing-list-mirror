From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] submodule: remove unnecessary check
Date: Fri,  7 Jun 2013 15:32:23 -0500
Message-ID: <1370637143-21336-4-git-send-email-felipe.contreras@gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:34:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3Mj-0006ZG-JD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab3FGUe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:34:26 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32957 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab3FGUeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:34:25 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so7134596obc.27
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C+ZGMfN6TBXb99d8W9j9Spvu09azkzdIZOjIWE/EvY8=;
        b=u5iPHS8jHRe8etOEJNr8cHBEziIgYlNk56WXLLpkqQwOHDEfesLnMt2uyz6tP+2sr7
         YrGZag1JHEqbizkMLlfjnfdbw+ZrGJC0grhaqWmOzo/rzUUhYB5ZV4hhP0GsPHDHmM0A
         G3cGCsLZhW2YKpAemymzhCH1g7iixIjoT3L0zpVQQxns3A1mx8np/fN5c9JVVd/oNPhr
         uQNEYRazqjDDc8zCjv1yRz1ygyp5mB84c0ypJFGZk8hR2EKsm5e5Wj23GCsNe0Qb25pY
         TI5qvTMKMZy5aa8dZBdwImXEgxySE1RYZ7vzpKlgSsk2RbnItxhx/lnFx2SwkW6cwbON
         2qGw==
X-Received: by 10.60.79.198 with SMTP id l6mr281408oex.47.1370637264692;
        Fri, 07 Jun 2013 13:34:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm558228obl.1.2013.06.07.13.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 13:34:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226701>

read_cache() already does that check.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 submodule.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index ad476ce..8685424 100644
--- a/submodule.c
+++ b/submodule.c
@@ -603,9 +603,8 @@ int fetch_populated_submodules(const struct argv_array *options,
 	if (!work_tree)
 		goto out;
 
-	if (!the_index.initialized)
-		if (read_cache() < 0)
-			die("index file corrupt");
+	if (read_cache() < 0)
+		die("index file corrupt");
 
 	argv_array_push(&argv, "fetch");
 	for (i = 0; i < options->argc; i++)
-- 
1.8.3.698.g079b096
