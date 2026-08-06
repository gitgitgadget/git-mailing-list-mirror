Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FA4DA551
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048071; cv=none; b=RhwFfB9SP4E6A5NqTT3U38GvYRJByOgO5nWZjwA2xniDs48ddjM79tJYpiKh52uOXgXiQk8/3yN8oX1QxmQJsQLxUAbwqZK/YEXQKbDCglu4OQ7hfast5H2eUmSjHLRCVmT4v/+f61owibgqDUWTfGpZ/2VUETlF8GKK+icxTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048071; c=relaxed/simple;
	bh=GBLbKoaigj9fdOGgp1pJOo62R6b+4Qy7VUDONu/0YZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfCUjSPGKZBXYEdc+7N0Npp3DeanzmB7sOnY/ISumIYxzainwBL/8nzmWFxq+7sapEUWSQuow+TTUsNOCZQ0iLhTDg9uuJFPb36RRoRan4FmN64NeLP3gShzhGPCoCTC9Si8e2aNWeBEwgEOlqiQiD9ltJ6qkbinFytRvn2Dsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbXA/cWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbXA/cWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30401F00A3A;
	Thu,  6 Aug 2026 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048070;
	bh=6Um9p5U4v272qNuhjfP0yCw4srzd24Iq5biKGBHyiSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CbXA/cWzR560ROKVC3VRVoOGdWpGj6L4OSQ6r/fFpbs4XiJ7MdsKJwWWTO2vrLRqw
	 8ecuFGHvvQn1m8q6QWvhIDo46WZY87OvaRt2QYdv4IpuiYXJW8JSu4sxQSl+573XRY
	 gMUpNE04WJzxhsg7ztUgr0Zmen70jlVeDPrrkkHJu3mqWYCWaSoVDq84zFhu6ZKogw
	 /SEK2102z/atD4exuFArAYRbRzeuO7v26RHPkXTrFO6sT1l/JCBrhBN5DyHh7hTX3B
	 xYh/LnxL9nTOzNGg7eNGfAt0XEfXIA2fy6zkYs6K359TACl6R8YYh7csSrrEDWemmD
	 mRLhXzfdQGI9A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 06 Aug 2026 22:27:37 +0200
Subject: [PATCH v2 2/4] completion: complete 'git history --empty' values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=GBLbKoaigj9fdOGgp1pJOo62R6b+4Qy7VUDONu/0YZA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkl7xzOWojHbX0tuXTZOuXPT+orKsribIOe8wXU/zoxt
 XWmzMbrHRNZGMS4GCzFFFmWlXNyK3QUeocd+msJM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RgxcnAIw1SwejAyzLtuYsLEEPEiTq9Q4pL5A7I1ed9W/04k/8mVdZ+42DjrIyHBEmmmdJXf
 Jc+OlUtv3P1SY8PPR5JPiz14a/DglUGj84B4vAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The "--empty" option accepts "drop", "keep", or "abort" for the "drop"
and "fixup" subcommands. Complete these values.

Although the synopsis only documents the:

  --empty=<value>

form, parse-options also accepts the value as a separate argument:

  --empty <value>

Support both forms to follow the parser.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash | 13 +++++++++++--
 t/t9902-completion.sh                  |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7372e2919b..fe5223b8ec 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2171,8 +2171,17 @@ _git_history ()
 	fi
 
 	if ! __git_has_doubledash; then
-		case "$cur" in
-		--*)
+		case "$prev,$cur" in
+		--empty,*|*,--empty=*)
+			case "$subcommand" in
+			drop|fixup)
+				__gitcomp "drop keep abort" "" \
+					"${cur##--empty=}"
+				return
+				;;
+			esac
+			;;
+		*,--*)
 			__gitcomp_builtin "history_$subcommand"
 			return
 			;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5ccb38c751..52a036a1ad 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3126,7 +3126,10 @@ test_expect_success 'git history subcommand options' '
 	test_completion "git history fixup --ree" "--reedit-message " &&
 	test_completion "git history split --upd" "--update-refs=" &&
 	test_completion "git history split main --dry" "--dry-run " &&
-	test_completion "git history reword main -- --d" ""
+	test_completion "git history reword main -- --d" "" &&
+	test_completion "git history fixup --empty=ke" "keep " &&
+	test_completion "git history drop --empty ab" "abort " &&
+	test_completion "git history reword --empty=ke" ""
 '
 
 test_expect_success 'git history revisions' '

-- 
2.54.0

