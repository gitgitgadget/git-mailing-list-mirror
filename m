Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F650347507
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332215; cv=none; b=WrGo+zLUx0j1TCCS7tLegXOrBk0X+8zqcCpQagE6OLwJHHRWrr13JF+6TVN8svhRhQCODKKkpUlIxivhjX8TBXWvGfdu1TOuFVEw4jtaWX84+EuVPqeYsUPjf3vvDnEN2haG7uoA9CyyPOuWvcsRCnCI/i3PMV05eW4VSMnvq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332215; c=relaxed/simple;
	bh=9rTKenrLdvqMEF8PyehPuyoUNV4PUzaUef1YOGKLrHI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aZQO2PwcztJgGLJiRB/YUlvvrm7u3fNpBoOVb9V7ra752ctRBtTBz08SQMvMB45bY7WzhKRHTfhAxfIqFVLSe03b+SONsE7qyxKLAk8YpJ7s5A78YviSoNQ/3cU8kBRojNvkBvFipHV1awDBcvCTBr0ffFYZ7lwLGqluouCkp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcJb52Vd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcJb52Vd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d560ede296so115335185a.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332213; x=1775937013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dawH4QE158lj4sRDGtHrx0oqYiK6oDsVS2ww0T9lIw=;
        b=mcJb52VddExBvNmzU375bB6bSopf256fzJhj3Tj2y/dh2Cvlr0Tq5hAXJxIOBt1J9l
         db8QTfMOMYKljVcwRdF5wBZdBqOrfCehP5rKhdXwxgY2vmTRhCiy5vkSFr/fLbLIMc9M
         cxZaA8VT1ek0sKfeQ6MODfQyjJdtqmazi+aeXrN5Fd0smnnXGT1LpREPaqBb9/9A/law
         Ou/krl3FwHg1g9LdIHhrpYAvKgwnKpk2eW+TAukWa5jaWmqOTpODBUDLJyTGXyutEOgs
         65ZnpVnlQ7ksNuVHJNjdSdiqpTAZvIPBap8A8SskmzIE5AUtjnCEpAC2pnMctbXY9PKw
         WYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332213; x=1775937013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dawH4QE158lj4sRDGtHrx0oqYiK6oDsVS2ww0T9lIw=;
        b=X9ojfogDr+q0xpo5BgathEoQXTkL0SNy6gx8WUSjc53D3LzIjgcoh5vax+TaibKcz0
         OD/wG5f9I/gMiqObSPQlYk8RAjZCFZlFgMhd8/cJnvbzWd5jKq/FTZH8I1H/zMlefI54
         +t8BwBlcU8dU53vyBNmr8QQ9mvOvfgr6w+1Yr8F03jzQFy6pr6qvt9zlvCR29GnnqIPo
         8zFVTqJddfWX1N7GANliMWngDRNpPEVfNUB4XNfJbSU3D8wXYiwTwRS5sVc5YPlLgAYy
         yLor54DEjr7mUvx+a1HVwpM+KaQ9A3KSQNOW1fcwS6/Y7rqVn8jNdSb470cd09BYwjHC
         1ymg==
X-Gm-Message-State: AOJu0Yw/F+fE4E6olYlrhQI62IejuZxCLtvFt/+sE3rLSuETzDAJyvks
	jQKk9d2XhU2fNEWyUcEbT1xGyqgLBCF1slBx2M2J6BnmwoxBrqDTEPG12Q3fKoFc
X-Gm-Gg: AeBDietH9xuWQ/SkfEMrRp8OOTS5Kbm6H0nOsU12iSRDKmL5cVXbKWAWEi8AEHR9Q4e
	xWMBTJGEtD3kn+oQWQccqgDssCl+vLH+KMTYaNB2usTFL4iRVS9BE/0hizg1vhYpRgjlwVx/cbL
	mukmKntXkgspgDpjuYSTTEj9NZGIiFcR0yWEkW/+nLQ6wwqqvEDs1D5LncMtRpdPTLHHLfxrcFr
	8Mg948pPTEGGAXITI8aFpA/qYGDv3Gu2b0aUPUIahixZZW0h9KRWVcZCJiuOxpTxZnc4zRElTwp
	HiMTrHjn3vgTJ+j0QE/45ks0jiK6dwL4NBvIdzedrFJgK8GranXgwZumHAsogqiIbFCdwopfRwA
	CM25uglzEaNhETSme1eSVO4E1v+B5ZtYeGGOpt2SsuhKwYCwq9DX6LnfJpF3msZH1x9ttyXTSe0
	ETLB0ZbR4DTNYS94mTnrDTb+5NKlY=
X-Received: by 2002:a05:620a:319d:b0:8cd:b90f:fc14 with SMTP id af79cd13be357-8d41e53aebamr1117522585a.61.1775332212915;
        Sat, 04 Apr 2026 12:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5a6764esm738064585a.13.2026.04.04.12.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:12 -0700 (PDT)
Message-Id: <c8789bd5423cec3a52dea88b78a7ca541ab9db06.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:52 +0000
Subject: [PATCH v2 12/17] t5540/t5541: avoid accessing a bare repository via
 `-C <dir>`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the `test_http_push_nonff` function both of these test scripts
call, there were two Git invocations that assume that bare repositories
will always be discovered when the current working directory is inside
one. This is unlikely to be true forever because at some stage, the
`safe.bareRepository` config is prone to be modified to be safe by
default.

So let's be safe and specify the bare repository explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-httpd.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 4c76e813e3..f15158b2c5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -259,7 +259,7 @@ test_http_push_nonff () {
 
 	test_expect_success 'non-fast-forward push fails' '
 		cd "$REMOTE_REPO" &&
-		HEAD=$(git rev-parse --verify HEAD) &&
+		HEAD=$(git --git-dir=. rev-parse --verify HEAD) &&
 
 		cd "$LOCAL_REPO" &&
 		git checkout $BRANCH &&
@@ -270,7 +270,7 @@ test_http_push_nonff () {
 		(
 			cd "$REMOTE_REPO" &&
 			echo "$HEAD" >expect &&
-			git rev-parse --verify HEAD >actual &&
+			git --git-dir=. rev-parse --verify HEAD >actual &&
 			test_cmp expect actual
 		)
 	'
@@ -284,18 +284,16 @@ test_http_push_nonff () {
 	'
 
 	test_expect_${EXPECT_CAS_RESULT} 'force with lease aka cas' '
-		HEAD=$(	cd "$REMOTE_REPO" && git rev-parse --verify HEAD ) &&
+		HEAD=$(git --git-dir="$REMOTE_REPO" rev-parse --verify HEAD) &&
 		test_when_finished '\''
-			(cd "$REMOTE_REPO" && git update-ref HEAD "$HEAD")
+			git --git-dir="$REMOTE_REPO" update-ref HEAD "$HEAD"
 		'\'' &&
 		(
 			cd "$LOCAL_REPO" &&
 			git push -v --force-with-lease=$BRANCH:$HEAD origin
 		) &&
 		git rev-parse --verify "$BRANCH" >expect &&
-		(
-			cd "$REMOTE_REPO" && git rev-parse --verify HEAD
-		) >actual &&
+		git --git-dir="$REMOTE_REPO" rev-parse --verify HEAD >actual &&
 		test_cmp expect actual
 	'
 }
-- 
gitgitgadget

