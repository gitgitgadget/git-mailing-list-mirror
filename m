From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 23/23] contrib/subtree: Fix order of case switches so default case is last
Date: Sun, 10 Mar 2013 23:41:31 +0000
Message-ID: <1362958891-26941-24-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nate Jones" <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpwN-0005Ly-S4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab3CJXpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:42 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:65463 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3CJXpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:42 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so608865wid.5
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=vZjPPQkY6PEteG/JvxZpv/uH8UK5oPrJZvBP+O1ra0k=;
        b=Ukfw/6aX0ZKLUGUHEqqco07BwbfUX3XTwS0HByLWSrPTYjVIlYrdGrEkH1Ntcz0QGJ
         ZARbY36yKAnCU63gBygKKGqJI6P9agaykMQxv64wgSN8oAPljFVlZRec4+Pcsd16Q2qQ
         ezmK+IZ1Qm72SIYK/GiBX+2gA9TfNnY0jS7FYm6wpjx/amA5gG17lvIoRjMY1nlzIv5s
         +TzFqJY0tDfIyLk1kmui636D0jJmeY4K/h3GtV4kUYl26bFm9yL3yNB4gdAA3ffTNpoC
         6GYkVCXyBt8OZWdUfUDDOK+rweHoPoRpoZMCpaUrjwjxi6Uf5q+53GolwmAF4QEi7rr+
         iqxQ==
X-Received: by 10.180.97.233 with SMTP id ed9mr9035418wib.32.1362959140126;
        Sun, 10 Mar 2013 16:45:40 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnTpq0R77JmoiYEHtL+ZjF4za2DNhL2Nn4OEg+NutneybxrBH9G/SMmMyh6fp44hwlwZ7ix
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217841>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index aaee6ae..fb6f044 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -113,9 +113,9 @@ prefix="${prefix%/}";
 command="$1"
 shift
 case "$command" in
-    add|merge|pull|from-submodule|pull-all|push-all|prune) default= ;;
+	add|merge|pull|pull-all|push-all|from-submodule|prune) default= ;;
+	split|push|diff|list) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
-    split|push|diff|list) default="--default HEAD" ;;
 esac
 
 if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" -a "$command" != "list" -a "$command" != "prune" ]; then
-- 
1.8.2.rc1
