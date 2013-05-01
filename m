From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: [PATCH 2/2] merge: use help_unknown_ref instead of die
Date: Wed,  1 May 2013 16:52:07 +0530
Message-ID: <1367407327-5216-3-git-send-email-vikrant.varma94@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Cc: Vikrant Varma <vikrant.varma94@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 13:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXV96-0004ps-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 13:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608Ab3EALYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 07:24:19 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:64092 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758356Ab3EALYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 07:24:17 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so631147dal.26
        for <git@vger.kernel.org>; Wed, 01 May 2013 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TG0GLISQ7l/NNOaVa6l8kHpYvvhXl+iExBwCbHb1TKw=;
        b=P40wXn3/Ie4han/2bq5hF2Lubgi17X2af7SBN+dbiRpYT2C4euTAHkXXk8OO+3vS2g
         KOptfHTSwj6pb37Suluky8+sP3Ue0cT5PksJRuWZhFZzDuDtW+DS8i1dS0SmGaJ2ylyI
         xIJThE13Sl6BIkU+9A6RawlY6tzvIJhrhySSdWwiEEOlb3jp3BZdPEcrjcQI85nUhqDs
         NCysvbcfvvPvcBr47zzjcXwW2KthOxcRzQzChGS56vBSbZmRXTS/w7RSfgJShoYEoaRk
         Ytxo+39ANtlbnIx47VAuDp4d1pMbkKxXm6DOsCdG5jk0RbF1CbFZKHyUMMHC9TgIg2aB
         /JBg==
X-Received: by 10.66.7.138 with SMTP id j10mr4299256paa.221.1367407457459;
        Wed, 01 May 2013 04:24:17 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-59.183.189.195.mtnl.net.in. [59.183.189.195])
        by mx.google.com with ESMTPSA id ea15sm3299675pad.16.2013.05.01.04.24.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 04:24:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3-rc0
In-Reply-To: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223088>

The previous patch added help_unknown_ref to print a more helpful error 
message when trying to merge a branch that doesn't exist, by printing a 
list of remote branches the user might have meant. Use it.

Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3e2daa3..0f1f39b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1053,8 +1053,8 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 		remotes = &commit_list_insert(head_commit, remotes)->next;
 	for (i = 0; i < argc; i++) {
 		struct commit *commit = get_merge_parent(argv[i]);
-		if (!commit)
-			die(_("%s - not something we can merge"), argv[i]);
+		if (!commit) 
+		        help_unknown_ref(argv[i]);		        
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
 	*remotes = NULL;
-- 
1.8.3-rc0
