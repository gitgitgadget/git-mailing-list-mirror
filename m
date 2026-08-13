Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7941D200
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647930; cv=none; b=blMisUEyoFmbGMCO9zCfHI6x+lcrAzfzddLwyJycW4vNBPiEAioTZR3/OYyBDuRbFsTr3K8o8gohB7jbCYHlQICpV9PwWaaSe6wFOyUXWHlqdqfWnLtAQlG5SHvIW8uNnbhKD0F1Kndix2UsEgsXKWlYVT+lcmX2B0+7PtpZ+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647930; c=relaxed/simple;
	bh=NQSkMAh0IQii2IRj2OcUH6TgVJwAkByk+nwUcI6SzDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjFUgicuyimPkPUQNu25E918szJIBbkiTcFP1G+y0rcezR4iVSNK6OzPvAqZMDSdEpT0syGWIGSiTZu2NeogNnCbfxlsABA7cRXCD2HKaVp/8yQwhAfBuQYk0N85v0o8k8ng5/lofVKULTiFKMiGHVvEQhRoTeEqedJotNzYH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR+iESHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR+iESHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEDC1F000E9;
	Thu, 13 Aug 2026 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647929;
	bh=FvsM+scpHooUPNA/FeZyLuwxvXlXugsaCGx365NKV1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bR+iESHJntmQ/JSHR3D4vFkSl+W3AzPElkpr5cw8R3DILXmZ/eTa138qjHri3wGQ8
	 KSkTTBxbSotbsA/JS1jJX/qRh6dE39c7LftM44QZW0D5GsyYDtG3FcVyez6YLU7hks
	 Xy+4/920fhnUZbuf0IJTz30rf0WkdwjGp7ZhwCtXAUZSSglxmkO44hQrzK4Ajm1/5o
	 NJVZd4pH7xuiU8mMRnnetSL5wGotpxmzdR/V+nXapaGfKwM8iOPxtup9LEaoM0vKUE
	 7WhTP+DuEOpftDxfkaWCFzP9I49kROcyQzXElFoNQRuY/yTmS8Du4X43AHarIMXTuC
	 8QC/p/VQ341vQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 21:05:03 +0200
Subject: [PATCH v3 2/4] completion: complete 'git history --empty' values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-history_autocompletion-v3-2-69eed1cea93a@kernel.org>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=NQSkMAh0IQii2IRj2OcUH6TgVJwAkByk+nwUcI6SzDc=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFl1okXutes1g0pVNPLuaizleDC741xf5Uul3F0LixmbE
 vpsEt50TGRhEONisBRTZFlWzsmt0FHoHXboryXMHFYmkCHSIg0MQMDCwJebmFdqpGOkZ6ptqGcI
 ZOgYMXBxCsBU891h+J8noPbixw4B01MrTke12whK+1rblp1neCeQP1k18tjJoy8ZGZ72FO6Zxbt
 w+fK+hDnfxJ6eW/9kv4aB9WcRHh+bS9vC+PgA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The "--empty" option accepts "drop", "keep", or "abort" for the "drop"
and "fixup" subcommands. Complete these values for the documented

  --empty=<value>

form.

While parse-options also accepts the split

  --empty <value>

form, it is not documented. Omit it from completion as a trade-off for
code simplicity.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - Complete only the documented stuck form.

Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash | 9 +++++++++
 t/t9902-completion.sh                  | 6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1727768487..7f3cabd595 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2169,6 +2169,15 @@ _git_history ()
 
 	if ! __git_has_doubledash; then
 		case "$cur" in
+		--empty=*)
+			case "$subcommand" in
+			drop|fixup)
+				__gitcomp "drop keep abort" "" \
+					"${cur##--empty=}"
+				;;
+			esac
+			return
+			;;
 		--*)
 			__gitcomp_builtin "history_$subcommand"
 			return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d0d8f2ba4a..851be383e1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3127,7 +3127,11 @@ test_expect_success 'git history subcommand options' '
 	test_completion "git history fixup --ree" "--reedit-message " &&
 	test_completion "git history split --upd" "--update-refs=" &&
 	test_completion "git history split main --dry" "--dry-run " &&
-	test_completion "git history reword main -- --d" ""
+	test_completion "git history reword main -- --d" "" &&
+	test_completion "git history fixup --empty=ke" "keep " &&
+	test_completion "git history fixup --empty=drop" "drop " &&
+	test_completion "git history drop --empty=ab" "abort " &&
+	test_completion "git history reword --empty=ke" ""
 '
 
 test_expect_success 'git history revisions' '

-- 
2.54.0

