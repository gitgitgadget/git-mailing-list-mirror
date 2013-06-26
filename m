From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 4/5] git-prompt.sh: do not print duplicate clean color code
Date: Wed, 26 Jun 2013 00:05:16 -0300
Message-ID: <6dc7fc8c8033186b296616238481a86946ee36f0.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, "Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 05:08:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urg6B-00065O-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 05:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3FZDIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 23:08:43 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:54339 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab3FZDIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 23:08:43 -0400
Received: by mail-yh0-f48.google.com with SMTP id z12so6129829yhz.21
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 20:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=cP52k/swLo6U4lg/hBF7S8ofQxpCz8Nv3D9Dc9o8ijQ=;
        b=S2ATC/yP+7OH1oAkxTFsQM7UncfuWXLPaGbxBxULUV7NOFeV9RR1/jIDtnc73aqa38
         ivRm286Hs9VZnxw9kPSh81l8SBvN2zjiQ1/daIcxngq8AKt2EBLR6cZFIXgVoFi4trW1
         xba6wLAiTjQdrMF7+ic815YFZkPocroDanBZyUrcXiEEywMxPmIezTa/K4qGdnanh2Xu
         sk8PlCw7he/r7bRsBf9r3nr4zN8O9k0WZNzvECVlCIZg86YLKt5c+1DrOXqV/YqdTVZL
         BdVxRLipb0wh9TBtEq1xygSjGnVXSOupu1HZsopMBlJz7+hXVrwXpgvOjIgD7lZNieir
         Eeyw==
X-Received: by 10.236.182.167 with SMTP id o27mr987057yhm.153.1372216122808;
        Tue, 25 Jun 2013 20:08:42 -0700 (PDT)
Received: from localhost.localdomain (200.175.80.235.dynamic.adsl.gvt.net.br. [200.175.80.235])
        by mx.google.com with ESMTPSA id y70sm42415518yhe.15.2013.06.25.20.08.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 20:08:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.590.g42a98dd
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com>
References: <cover.1372211661.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229025>

Do not print a duplicate clean color code when there
is no other indicators other than the current branch
in colored prompt.

Acked-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
---
1	1	contrib/completion/git-prompt.sh
4	4	t/t9903-bash-prompt.sh
 contrib/completion/git-prompt.sh | 2 +-
 t/t9903-bash-prompt.sh           | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index fdedb45..545518a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -253,8 +253,8 @@ __git_ps1_colorize_gitstring ()
 		branch_color=3D"$bad_color"
 	fi
 	c=3D"$branch_color$c"
-	b=3D"$b$c_clear"
=20
+	z=3D"$c_clear$z"
 	if [ "$w" =3D "*" ]; then
 		w=3D"$bad_color$w"
 	fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f250dfc..5cd138e 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -551,7 +551,7 @@ test_expect_success 'prompt - pc mode' '
 '
=20
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}master${c_clear}${c_clear}):AFTER" >expect=
ed &&
+	printf "BEFORE: (${c_green}master${c_clear}):AFTER" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=3Dy &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
@@ -561,7 +561,7 @@ test_expect_success 'prompt - bash color pc mode - =
branch name' '
 '
=20
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}(%s...)${c_clear}${c_clear}):AFTER" $(git lo=
g -1 --format=3D"%h" b1^) >expected &&
+	printf "BEFORE: (${c_red}(%s...)${c_clear}):AFTER" $(git log -1 --for=
mat=3D"%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
@@ -627,7 +627,7 @@ test_expect_success 'prompt - bash color pc mode - =
dirty status indicator - befo
 '
=20
 test_expect_success 'prompt - bash color pc mode - inside .git directo=
ry' '
-	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}${c_clear}):AFTER" >expe=
cted &&
+	printf "BEFORE: (${c_green}GIT_DIR!${c_clear}):AFTER" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -666,7 +666,7 @@ test_expect_success 'prompt - bash color pc mode - =
untracked files status indica
 '
=20
 test_expect_success 'prompt - zsh color pc mode' '
-	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=3D5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=3Dy &&
--=20
1.8.3.1.590.g42a98dd
