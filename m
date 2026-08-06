Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665E4E3793
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048074; cv=none; b=IooKJUvuum8biXEuXA/YASmzTxVsEBUDTYFXjaCXo5cK+vAdrY6Xy1UuI5Mqx6tpR8SJYT+lHfB6EFnoKMtdYKbYUfgIr6Sryt5w4dbWMXWOOA0egU/XaYF7u54n2mM+/H7fc79Soz1pHVBWYFoA0gpBmKuu0U601F+cZg6jJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048074; c=relaxed/simple;
	bh=XbaDv4UFh1f+ENCRu36XoLN7B2yRe4eQcsIo1KVCzjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbHKRbnUkPUiTpb1TbS6+eLzHqyrr3kGNVfK2ue8SydoVhIq6Ez1jNqCJibiadJCMVTnMZgP9buGrgiBs8wJwuRNyvLkquLw259auV/aSeryfnpS2/TOBo5lPY/jDMd4zkml6paDAsMJBdRomOkkkePHthE95RW6uaOzkNyCIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFGtCuwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFGtCuwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0741F00A3D;
	Thu,  6 Aug 2026 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048072;
	bh=jrb21gWK+mxYrmBtRXYf6rHUS+YsBpkb6qwakJpT4kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kFGtCuwf926s3xI1YzfZ3mpj3DjWEEbnQp8gfJoCCSlBxlmMnmBI4i8rk7VPG9bcV
	 62NVAlm/DHi4FF0q7MVnkVgwALW3wOcgGaytplAohcVJczKYcvOljeMszj9n8/Y2/H
	 JUx/SDKR4EWJnmg88ZUUT3Nz2f8C8HJ9o09oMLyQ95VTHrR58aWn7vG5JPOgKYjaxD
	 L445qBN3LXvFh5/64sjVUKJ+xvrPZuoB2z+q+t2aktRHGeWWZwWp4Zxd67ksHsS9rL
	 oVL3GXdlhyQJ+AtZgRmHBXqQiAyuwhc6t7SENffSRpEN3FEkE0lvV7C50jzOkBJlbd
	 0T+4LehN1h6Fw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 06 Aug 2026 22:27:38 +0200
Subject: [PATCH v2 3/4] completion: complete 'git history --update-refs'
 values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-history_autocompletion-v2-3-7e60f52a1c20@kernel.org>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=XbaDv4UFh1f+ENCRu36XoLN7B2yRe4eQcsIo1KVCzjk=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkl7xwuxS5niDq3yeHVnrT5as1mUf+WKak6irJtXJzj7
 /TE7O3vjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdIwYuTgGYaoOfDP9Mlmb3fzE+9or36fo0hm1pU9y/J3id/eXIvGh7Sld5RRg3w//Mpn0vXXY
 Jv8mouP3ooKbIAzeelQGP8rsnerr8MRbZ+psRAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The "--update-refs" option accepts either "branches" or "head".
Complete these values.

Although the synopsis only documents the:

  --update-refs=<value>

form, parse-options also accepts the value as a separate argument:

  --update-refs <value>

Support both forms to follow the parser.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash | 5 +++++
 t/t9902-completion.sh                  | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe5223b8ec..6f1ba96763 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2181,6 +2181,11 @@ _git_history ()
 				;;
 			esac
 			;;
+		--update-refs,*|*,--update-refs=*)
+			__gitcomp "branches head" "" \
+				"${cur##--update-refs=}"
+			return
+			;;
 		*,--*)
 			__gitcomp_builtin "history_$subcommand"
 			return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 52a036a1ad..ea86ecc08f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3129,7 +3129,11 @@ test_expect_success 'git history subcommand options' '
 	test_completion "git history reword main -- --d" "" &&
 	test_completion "git history fixup --empty=ke" "keep " &&
 	test_completion "git history drop --empty ab" "abort " &&
-	test_completion "git history reword --empty=ke" ""
+	test_completion "git history reword --empty=ke" "" &&
+	test_completion "git history fixup --update-refs=he" "head " &&
+	test_completion "git history split --update-refs he" "head " &&
+	test_completion "git history reword main -- --update-refs=he" "" &&
+	test_completion "git history reword main -- --update-refs he" ""
 '
 
 test_expect_success 'git history revisions' '

-- 
2.54.0

