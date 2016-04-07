From: David Turner <dturner@twopensource.com>
Subject: [PATCH 19/24] cmd_merge(): remove unneeded flag variable
Date: Thu,  7 Apr 2016 15:03:06 -0400
Message-ID: <1460055791-23313-20-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEb-0007wR-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361AbcDGTEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:33 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33646 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbcDGTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:41 -0400
Received: by mail-qk0-f180.google.com with SMTP id k135so31092742qke.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6jE/4hLjtr6xSfX46NGmOeC4+pZMMAyzLqbZ5cw3Xa4=;
        b=1O6pHYzHwdrf6yB5tpb++kjbnRAYZfhConN24b90tRsiUSuspy2E9OT1FTpp+cjCFF
         img/IH0+dhnsplNY++hKFZdjpe0hiI6wJjr5boXyscKElo09a22r+qQ6Z/YkRltWbyWr
         0d56WRcDfl5tsoXLlOqcALhKsXh1jf1M2NkToxSefEsxNpJV5ZEl9A2dQfiBLtGp5hBK
         fpFSHbaEyvLCXi6DoNzzKWuodIC0+JVabwFHWbKpyGy7q+3E5kfqIG44zzyhTwperepF
         YzVOkEfIMeSf7dyh8qYJeRNfbqGOE7xuPPLZ/HsmofuBnHqD9deE513ITfnu2E2yenFJ
         cB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6jE/4hLjtr6xSfX46NGmOeC4+pZMMAyzLqbZ5cw3Xa4=;
        b=LWLA9jJOiFVw9AgukQUKsW10dlt9X4dnUdiQON00/Ke8b6cQa7FrglESBi/sCkoPBP
         44v0HbjQHog3Hwc8WVXLz+Gq39oDRrgzUxQW2unalQuxfvDLUecnGsLlh6xJXG8ax/BJ
         u9Zih5z7tS59C0wHdIec1IY5qQbUrfV1g7j8CQ6qspG72svETJsyOdax9N36Te7w6SLz
         OcHrn1ulAD2jABsKCJqPmEU/53ewbGVdrkckJCP7a2/1cfwAWJ90G7mC9dAPfcTmy6Dr
         yTu/fthon7YTUJSFd7qlKFE+wLR9ewnpNrgQZGg96ykkcGSlfqlIDdnJriVPR+ywKE+8
         JOXA==
X-Gm-Message-State: AD7BkJLEnqaOxoE6rzhZK0AYtXPS3PtV+j4q6zIchLDEChVDyF1WpYKum9jp0A6S2AiqVQ==
X-Received: by 10.55.217.22 with SMTP id u22mr6020121qki.63.1460055820671;
        Thu, 07 Apr 2016 12:03:40 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290975>

From: Michael Haggerty <mhagger@alum.mit.edu>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..c90ee51 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1165,7 +1165,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *head_arg;
-	int flag, i, ret = 0, head_subsumed;
+	int i, ret = 0, head_subsumed;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
@@ -1179,7 +1179,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, &flag);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, NULL);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
-- 
2.4.2.767.g62658d5-twtrsrc
