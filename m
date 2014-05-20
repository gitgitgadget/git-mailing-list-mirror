From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/19] contrib/examples/git-merge.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:17 -0700
Message-ID: <1400593832-6510-5-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRf-0000Bh-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaETNup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:45 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59444 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaETNun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:43 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so339300pad.39
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6J7JnZim1lSyyz0zVN+SGZb7BqaxlHZqHkpx0sgfzfI=;
        b=JbZPftxrkrKlmhVrWEQiTzuHyFCWUnwCWP8c0ukNfxKw+gu4uqzEh8ee91ZPbkjzVU
         oBAVpCF7hxjDNVhRnNdGkwXUl3+8fVklZ5YeqnS3Jjrs8enFT3tHLWiEJAqic6S9GzQe
         2IIm6cglgV4WWBJDE3qOEozGvvHH4briyTUSKcSEzkTJM6ULpSoXAjcAJh/ZZZf6/utg
         TW7LqD/ltqXyhf5fWDFPTv4C7mnR1f+aLYcXRA2IxiLZWTnNyGOg6aqIzSjk+1ixrRX4
         7QIOEFPaLSOWjZnI3guGH727A5Cjk259S0BktnXfJ3Ocd9yjJ8d+omT9vO0H1SZcwNzQ
         ZESg==
X-Received: by 10.68.163.100 with SMTP id yh4mr51466390pbb.122.1400593843297;
        Tue, 20 May 2014 06:50:43 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249664>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-merge.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 7e40f40..52f2aaf 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -161,7 +161,7 @@ merge_name () {
 			return
 		fi
 	fi
-	if test "$remote" = "FETCH_HEAD" -a -r "$GIT_DIR/FETCH_HEAD"
+	if test "$remote" = "FETCH_HEAD" && test -r "$GIT_DIR/FETCH_HEAD"
 	then
 		sed -e 's/	not-for-merge	/		/' -e 1q \
 			"$GIT_DIR/FETCH_HEAD"
@@ -527,7 +527,7 @@ do
 		git diff-files --name-only
 		git ls-files --unmerged
 	    } | wc -l`
-	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
+	    if test $best_cnt -le 0 || test $cnt -le $best_cnt
 	    then
 		best_strategy=$strategy
 		best_cnt=$cnt
-- 
1.7.10.4
