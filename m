From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/44] request-pull: use appropriate ref
Date: Sat, 28 Sep 2013 17:03:30 -0500
Message-ID: <1380405849-13000-6-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iQ-0002qV-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab3I1WKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:14 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56372 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175Ab3I1WKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:11 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so4131017obc.21
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PlqNz3l14Dkpbl05XGI+rIe6nycrHG9WFlD8JgqhZOE=;
        b=xXqURpAgoVCvwWJuIjj9w8lwvvUJI1PlGCMo6PTt7VImh+va0BXzfl1cMYlHWEcAjw
         YpvGw03+uYrELGXHL8gR82EugB3C93h8l9DnpDuVeaIuu8DYda2vA7YyDNc7G86jq9XW
         ZUTLlG3Hr3nKDfsFbykh0c4cjOfjlLqomJi5F9hiWpsuO2lylO2hqqRcvqGmI8+2sa5X
         SYUfRRE7K4UtllcangG5XAYeBgfpKeinvDvRTy3y3OXoURmOaLdUVhOtRELL6pYXexWG
         1F12jDR6WypiC5xQNgo6buqhIs1M0r+AlPcEM/W4a3ESxDI95L08+2EOFZnVceRAMnLt
         fwUw==
X-Received: by 10.182.44.134 with SMTP id e6mr12488737obm.14.1380406211107;
        Sat, 28 Sep 2013 15:10:11 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm25480682oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235525>

"Are you sure you pushed 'HEAD'?" doesn't say anything helpful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 3c9a982..3e510ca 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -151,9 +151,10 @@ git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
 if test -z "$ref"
 then
+	short_headref=$(git rev-parse -q --verify --symbolic-full-name --abbrev-ref "$head")
 	echo "warn: No branch of $url is at:" >&2
 	git show -s --format='warn:   %h: %s' $headrev >&2
-	echo "warn: Are you sure you pushed '$head' there?" >&2
+	echo "warn: Are you sure you pushed '$short_headref' there?" >&2
 	status=1
 fi
 exit $status
-- 
1.8.4-fc
