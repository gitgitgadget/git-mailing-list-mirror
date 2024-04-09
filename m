Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAB131BCF
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676451; cv=none; b=T9v0NAdvve/sK9ama2nH9e2HqkcUGEF6m0IWG+FMAAUn7hsUqwd9DYYjkbf6IRCge7bOY8F95OGurD409idFhBstW5NBTuFwQocIwQ0zzjEG9X/wj636zhWsxcdZ04Ll6mwwBcqcx8Dby3Oe0lm1G6lNft9Pk+6wkTH/y2RStSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676451; c=relaxed/simple;
	bh=Z3sYYijTxa+GwnpoP+l+4vyWeDXaFCqxMuFhMbymduc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lhslkfUR+LONXSk0fncZuhbmHNG1mAPHU3OPUMAcCMXg3ndKGAcnMXVCWXoCWG+1bJY4E3inuv9upFXa1ac0+Gn7pZwRIJg6wXU4P29cSNxXJJZGS1mPI4FuOCAb/03FN5NQwvL6vGKmv/m+yQWS4ak6EzBz1iN+vpGamVGOv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMaKCJVV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMaKCJVV"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d715638540so68718751fa.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676447; x=1713281247; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xijI6kamVk/h1DZUuNsIQ0lYH7wQTTd+kWE1Ogpl/xY=;
        b=gMaKCJVVGyt3vMFdIHkmOoLuDrDRwVer07qsOyorHQg4G1BynEKjaAYDqoUigoaX/X
         kpDCTJvrxUeSXKAZ+geitnUMb05/MRbHd04F1S7PBPBoDLFIiVESnLHJFudEfawmPfnW
         6Faa7tAVebifSwL7Z8sEdFiIkKKsv9NrlNWddFXzTdPBf4kyTHdJVXdvMz8s6E6iNqzS
         7s/rt4MyK2XdFQ6WbWQ5Gl1XCkjUxuZt9kjp80oh67UqHHEn5LYLFY0wCbJXzFD7MGCW
         KYodYGBsgJCAREB55uMdgmgfLcSkm66cMu8mM7Ew9rEBZ20izx5OoCeF2rFVxgg8/t8K
         BWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676447; x=1713281247;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xijI6kamVk/h1DZUuNsIQ0lYH7wQTTd+kWE1Ogpl/xY=;
        b=d7ZmKfWiUVbpxpwIxxRwWgoyxbLduvGlYKPR6WVY1qt1SH4F2GHAkO1N6tp6D+jgs3
         I2MjnOWTdM6Sq4xPvvZCm/79tdMVmqRiX4EYlscnE9AjvvwGDMm3UNnefkjUV7Mnjsp9
         b5rPjdE/i/ps84BJSlkmJrWi3tRyqHZ5GXvhRVpIofic9tcxIyAEMZW5qh1Jq39oxBIR
         mLIfb6Z2YkaIsz9PQBxr7Xud1Qfdota/fgDP8n1bJvXnkNBDN8fA4irELCuM1ijoij36
         pFwN5/9ysZEWmYTkYmwwBVF9cQl4sjksEEeyyE0/SG6UZ2H9ufOLXtt6urBbmvAlK8bR
         Yz/Q==
X-Gm-Message-State: AOJu0Yw7NDBzXBrx0kwARNF7l+BlBtVbyyCG6Nv112WkcMmbKmmYroJJ
	wv1PWMb3rEt1QFlp2ziatmUx6EDzMyEfi1CTPh0HNmn7sSS45SmzuxDsrj9W
X-Google-Smtp-Source: AGHT+IHyRwy2mZ82KP8BJ11QJHCkNqlhl7POWeIAWXN3Y7SUpdTGjXjKEIHIOmACbGyxGflV0TXS/w==
X-Received: by 2002:a2e:bc11:0:b0:2d8:901f:7f50 with SMTP id b17-20020a2ebc11000000b002d8901f7f50mr145721ljf.9.1712676446706;
        Tue, 09 Apr 2024 08:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b0041690a1c9desm5295981wms.30.2024.04.09.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:27:26 -0700 (PDT)
Message-Id: <35d4178d106daf4bd1407b1fc8ba6029a6dce288.1712676444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 15:27:22 +0000
Subject: [PATCH 1/3] t3428: modernize test setup
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Perform the setup in a dedicated test so the later tests can be run
independently. Also avoid running git upstream of a pipe and take
advantage of test_commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3428-rebase-signoff.sh | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index e1b1e947647..975b859ce09 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -8,37 +8,37 @@ This test runs git rebase --signoff and make sure that it works.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# A simple file to commit
-cat >file <<EOF
-a
-EOF
+test_expect_success 'setup' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+
+	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
 
-# Expected commit message for initial commit after rebase --signoff
-cat >expected-initial-signed <<EOF
-Initial empty commit
+	# Expected commit message for initial commit after rebase --signoff
+	cat >expected-initial-signed <<-EOF &&
+	Initial empty commit
 
-Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
-EOF
+	Signed-off-by: $ident
+	EOF
 
-# Expected commit message after rebase --signoff
-cat >expected-signed <<EOF
-first
+	# Expected commit message after rebase --signoff
+	cat >expected-signed <<-EOF &&
+	first
 
-Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
-EOF
+	Signed-off-by: $ident
+	EOF
 
-# Expected commit message after rebase without --signoff (or with --no-signoff)
-cat >expected-unsigned <<EOF
-first
-EOF
+	# Expected commit message after rebase without --signoff (or with --no-signoff)
+	cat >expected-unsigned <<-EOF &&
+	first
+	EOF
 
+	git config alias.rbs "rebase --signoff"
+'
 
 # We configure an alias to do the rebase --signoff so that
 # on the next subtest we can show that --no-signoff overrides the alias
 test_expect_success 'rebase --signoff adds a sign-off line' '
-	git commit --allow-empty -m "Initial empty commit" &&
-	git add file && git commit -m first &&
-	git config alias.rbs "rebase --signoff" &&
 	git rbs HEAD^ &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
 	test_cmp expected-signed actual
-- 
gitgitgadget

