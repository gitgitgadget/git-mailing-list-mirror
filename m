Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093741E6B5
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647933; cv=none; b=sBY1S4Sm78RahLD9xHaTWN/Hb5bZaFpPDcURZ/9NKAW5f4a+QpD150ubordrXJjdq4Y/QtRts9z/k7OmUVU+h0NyXUaN+On1AQAEtpXLns/vniUR3QxrEObv43Cc7TFLAGgbBuQv+QGQppx7ycNYsZNmd9sYlqKXjpW3S/26n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647933; c=relaxed/simple;
	bh=62piJ6AlyF+gg+rP1lxaJl6FNcaVpLS7cNMkuREgAjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVGx9vzZWr47JOQ5XX/sGIQn/4Czjem0fGMqg0QtCed0ZB7I+zVfCooAXedSOoG7lQBPgJUjV/EF6L6FBo+jUjUi7LL8brkxpjjXrsb3h333dPNVPyKZ8ArWhqWixfW9pq84D+/yY1JikrlC9VfQnDY+CyWT8vuZM5dF+4O4L1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU5FXiQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU5FXiQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30881F00A3A;
	Thu, 13 Aug 2026 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647931;
	bh=Xk366yZjOgAOYazcUVhvAacHHI8MdmFofAbPWvG2uac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DU5FXiQdWzvylutD4ouYm9wR6OA23LLDVe/ylFs7oDUGds/5qONMY+RtFDWSW4luG
	 ZHGBR/IRqJRSmoVrmb7H7cL9lcP3dfIIwSbFfBMoKCclILCjvI9O/fmejs2d8yxH/v
	 XD2zEW/ySq9nRMxrxtG6f12HzcGsSbAC7+4nsWTa/u2TCzb+xH/pqVEsbHp0kAJ55l
	 c4rq23sWjndhf7OSnRx5op+eNecDGzTKc+Doexpj2+8Q6DMolhBRKU5TdQol1FVuJn
	 rkSzM1lAzuxODKTepYec+1zhk/rSGXqmsBjjBpuNnnLgpqzl7imQMS2TpA3hnx08/f
	 iO/RYrfe9704A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 21:05:04 +0200
Subject: [PATCH v3 3/4] completion: complete 'git history --update-refs'
 values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-history_autocompletion-v3-3-69eed1cea93a@kernel.org>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=62piJ6AlyF+gg+rP1lxaJl6FNcaVpLS7cNMkuREgAjc=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFl1okVSXYwMbyu3xUotDc1rSZurljWFtfjZbompzrdDB
 fiCDTQ7JrIwiHExWIopsiwr5+RW6Cj0Djv01xJmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DME
 MnSMGLg4BWCqU5kZ/kowql5r4JQ+3e129MfW6HfiG59MdWfJkdgsZRVYG7vE+hQjw7S8RdcVLCP
 5EnMc713w4XWJncu0ppNJNLiR44iUVUUxHwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The "--update-refs" option accepts either "branches" or "head".
Complete these values for the documented

  --update-refs=<value>

form.

While parse-options also accepts the split

  --update-refs <value>

form, it is not documented. Omit it from completion as a trade-off for
code simplicity.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - Complete only the documented stuck form.

Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash | 5 +++++
 t/t9902-completion.sh                  | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7f3cabd595..19600940dc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2178,6 +2178,11 @@ _git_history ()
 			esac
 			return
 			;;
+		--update-refs=*)
+			__gitcomp "branches head" "" \
+				"${cur##--update-refs=}"
+			return
+			;;
 		--*)
 			__gitcomp_builtin "history_$subcommand"
 			return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 851be383e1..b225dd3800 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3131,7 +3131,10 @@ test_expect_success 'git history subcommand options' '
 	test_completion "git history fixup --empty=ke" "keep " &&
 	test_completion "git history fixup --empty=drop" "drop " &&
 	test_completion "git history drop --empty=ab" "abort " &&
-	test_completion "git history reword --empty=ke" ""
+	test_completion "git history reword --empty=ke" "" &&
+	test_completion "git history fixup --update-refs=branch" "branches " &&
+	test_completion "git history split --update-refs=he" "head " &&
+	test_completion "git history reword main -- --update-refs=he" ""
 '
 
 test_expect_success 'git history revisions' '

-- 
2.54.0

