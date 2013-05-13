From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/10] remote-hg: disable forced push by default
Date: Mon, 13 May 2013 18:11:56 -0500
Message-ID: <1368486720-2716-7-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xF-0007WF-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab3EMXOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:38 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:54721 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3EMXOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:36 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so8294987oag.16
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/NpKgwsD+O6m92vl7SzqSuwaOWqb4TuhYrPJMkeDFZw=;
        b=oqk9wNmMG4678yTnGkuenAgKMdbTL6nVD8P4ylu6FDQonfLrqrAMFusRR6QiIV5we/
         6BEyfnxEX+deYMFGW9pbhuELrIDGJXxg4z4k3tRiBBUDa3h7rIqNFmgF5+8UGSUlpNK9
         rkXS5ajB5utjuGVLn0u3TTempWXovPSWZUhWMpHPc0pYJdPoKjD5aud6L3pmQgPtrvIt
         QNQkYTL539MwGYyNEvF5msw0XRWQRqhQAaB2UPq+exv22cvRLgljGCynFcizhCfQYlrn
         DjjSY0ZJqzer11/3vaR0+twWbSn3raNJiRSFniwUT+e8jGlPEl9UyXMSrypeQWsNPLzt
         Qr8A==
X-Received: by 10.60.65.100 with SMTP id w4mr14939661oes.79.1368486876047;
        Mon, 13 May 2013 16:14:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm18806234obg.3.2013.05.13.16.14.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224224>

In certain situations we might end up pushing garbage revisions (e.g. in
a rebase), and the patches to deal with that haven't been merged yet.

So let's disable forced pushes by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3cf9b4c..53412dd 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -914,7 +914,7 @@ def main(args):
 
     hg_git_compat = get_config_bool('remote-hg.hg-git-compat')
     track_branches = get_config_bool('remote-hg.track-branches', True)
-    force_push = get_config_bool('remote-hg.force-push', True)
+    force_push = get_config_bool('remote-hg.force-push')
 
     if hg_git_compat:
         mode = 'hg'
-- 
1.8.3.rc1.579.g184e698
