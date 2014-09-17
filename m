From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] help: Fix size passed to qsort
Date: Wed, 17 Sep 2014 14:14:39 +0200
Message-ID: <1410956079-23513-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: pdebie@ai.rug.nl, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 14:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUE8G-0005MZ-DT
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 14:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaIQMOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 08:14:44 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:58004 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbaIQMOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 08:14:43 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so1322585wes.28
        for <git@vger.kernel.org>; Wed, 17 Sep 2014 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wx/s3m6rFeut01z5PNWOuZIuy+BQxDzLyrumhfkl9n0=;
        b=j3E6y2pkqbvVDBLdwRHRhaomJVQH7z/GIMuLs1Ex8bTaBGOU5X48D2rsccktzf2S/X
         NK5YK8nPRFMwmahcmAVDKVBHB9gXD2ijr75rygx9fUSwT/HMtE+Vp8SJgTJ6hIJ0jrYx
         nPHl8VvOEl3ktD1PyDTtthnv5+dLdV1XSDsNRn1FK1aLZ8hRqSi+iUjALTt21qociepH
         6/MDmjELOfPynfzkb2ypvfjX7WqV+93t6Xxoade+cnC6Td519CFDLhJiVrOPfWHysr/L
         Iq6uF35HHVOfga2lU3FGk+Zs3QAOgky1BWAaBay+/ZhGMTKnxWYO7ETzBqVx7WNVeG9Z
         5aLw==
X-Received: by 10.180.38.7 with SMTP id c7mr5089944wik.65.1410956082728;
        Wed, 17 Sep 2014 05:14:42 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id cw6sm21970615wjb.18.2014.09.17.05.14.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Sep 2014 05:14:41 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257221>

We actually want to have the size of one 'name' and not the size
of the names array.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 7af65e2..2072a87 100644
--- a/help.c
+++ b/help.c
@@ -305,7 +305,7 @@ const char *help_unknown_cmd(const char *cmd)
 	add_cmd_list(&main_cmds, &aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
 	qsort(main_cmds.names, main_cmds.cnt,
-	      sizeof(main_cmds.names), cmdname_compare);
+	      sizeof(*main_cmds.names), cmdname_compare);
 	uniq(&main_cmds);
 
 	/* This abuses cmdname->len for levenshtein distance */
-- 
2.1.0.238.gce1d3a9
