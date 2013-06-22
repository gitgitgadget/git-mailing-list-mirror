From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 03/14] t/t5505-remote: use test_path_is_missing
Date: Sat, 22 Jun 2013 13:28:10 +0530
Message-ID: <1371887901-5659-4-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:01:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIle-0007xk-M2
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423704Ab3FVIBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:49 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:35431 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3FVIBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:48 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so8817738pbb.20
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CJ9kehBTYCCZC2psKvEN630L+38mbFon8uyrc6AqSfU=;
        b=NI+b4W8HJOiW2ladeWWnXTUhMHJzKe4heZLHx7c+GFmopuqyYdAZfGw1Mr8MDBmNu/
         NP/SJxkKj/sS/y3F6oLy85mJ/yqj5oDxP2up5E/GMP6uK97+UJQZE3lkOELA3TfaGvye
         3XXgFHFOtVV0mrymCuG1OM2M7LJh5t+zPRfcFLECYfCjB/tHY9gZf+7K19d1HLdxXyfx
         XdgbglqSERiK7RkcddvKVbNhSf12R0O3Yd+UwbcXRB5Wpk3t6hDujGY7oswkIFaNMa6c
         SEWAMoOkcsSyzXZAOfykr4WFDq8cLQvBh+gyCq79S5RPNTOVG0wrzFhjIf/8q7859JWj
         U2pQ==
X-Received: by 10.66.197.227 with SMTP id ix3mr19704280pac.105.1371888107591;
        Sat, 22 Jun 2013 01:01:47 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228679>

Replace instances of ! test -f with test_path_is_missing.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 74ddd77..d688662 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -747,7 +747,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		mkdir -p .git/remotes &&
 		cat ../remotes_origin >.git/remotes/origin &&
 		git remote rename origin origin &&
-		! test -f .git/remotes/origin &&
+		test_path_is_missing .git/remotes/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
 		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
@@ -762,7 +762,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 		git remote rm origin &&
 		echo "$origin_url" >.git/branches/origin &&
 		git remote rename origin origin &&
-		! test -f .git/branches/origin &&
+		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "$origin_url" &&
 		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
 		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
-- 
1.8.3.1.498.gacf2885
