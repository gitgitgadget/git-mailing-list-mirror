From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/47] remote-hg: disable forced push by default
Date: Mon, 13 May 2013 23:36:29 -0500
Message-ID: <1368506230-19614-7-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70x-0003o1-JC
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab3ENEi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:59 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43006 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:59 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so95952obb.17
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/NpKgwsD+O6m92vl7SzqSuwaOWqb4TuhYrPJMkeDFZw=;
        b=vZJus63wSlXpG4Iv2TxxNcUrICWyDwryuti9h+r925dI+tccb+f0inP7O4iPj7H1tK
         HJnCVaVObSVb8Kh69cbqwkqL7Aur7TZkl9oE0pBfUt8JmTFEo2c8orGEYjsUj2iXEy9n
         1akWwMlv26N5lhHnpYqmsM1ckZlNJOEFMD78MRiNoiWFzY5xJqfRKM82nrlpRTeEYSAi
         ZCK2WZVHMFjHYRlysWoDmsSOWcRP6ny07JRgMPdzhfyaaT94XlXb/bhR6+TC0jBYMs8s
         ffCSsQH8pRHe8oHpNj7tHukgXcj+OZHU/oF77XfAY3Hfud7/NCECCIx5Jk6Ri55pzng9
         WpCw==
X-Received: by 10.60.56.132 with SMTP id a4mr6620394oeq.113.1368506338530;
        Mon, 13 May 2013 21:38:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20532466oep.1.2013.05.13.21.38.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224241>

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
