Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE59135A67
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676452; cv=none; b=gflzC5rlbPLhdmBIFGW03dmhLymrjDQu5OzLNt82QM2uYTyPr3dyFxDOoUk1ZLvCf4P005nf1kp4KR/c3Z4GgQ1FfpN1hqqLVgEfM2QIPzOFVgSMzN91O0pSyxgScmdMLN2dOorvgSI/ZS5gthoT3v5K2FMxMsgN4lVuzmCRU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676452; c=relaxed/simple;
	bh=M1n+9PQ5yXVzKdBGNcIkxxZJYQtGJwNks/tEN7cF9a4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KFzF+sQuzmYswQPHRjOey6rof3FypePDYZvxW0DKBlIqV3wHXiSOFh3fUtyWAsAWjKdj0S1N1DeyTNFMcwUx4e9NnU0H4EQWfIR4dGZClAESA6Xztel7xDG8i0+2QkVMCBWEr+IK1ziI9FR8DhIKshCerZpRQnnidtfLQ+OGD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPZ8+pI3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPZ8+pI3"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d718ee7344so66631021fa.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676448; x=1713281248; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgaQiAtaj7gZ8OzahGDQGjPM8jvy3RoAAcZTzCwC9jQ=;
        b=WPZ8+pI3KJBrCqYapkRIkBkM31wcx+POsuokPJDXgUvQvv5OSzPy4WKOb1+r/pIbYG
         AN6tSBzg6A4MxRNkH1AIXEZOhdtaJ+xW8OhhzHk8+X0P2rwJnDAOZHPG131aopEmr1nB
         hAZynsbncW/BL81yvsUDqlzQnM8rMt93+CLASWVCbU3konDHGxdr8dKMBcEWwUm9WtxQ
         VxC1PF31RvR0xnJg0qtnQaNonjF6aqRzfYg7LUJDuDi62fHko2HIICBdFl+wUmuQEKfL
         d0u7LylVBcexfdys+OWBJnZOz7MDzRhVYM22FF7XwyfLn1ThKgjicUnbxIDTv4mHO1Rm
         khow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676448; x=1713281248;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgaQiAtaj7gZ8OzahGDQGjPM8jvy3RoAAcZTzCwC9jQ=;
        b=F7LCw3uhe37trpHx18shn80PAGCHWOHBdBfTTuwnGyQ5CyPF8mqhCQn434EXNT24k6
         35ja08ULAzDmzS7UdzSscXEeNWy+FigdzcwunCP9+EDl62uoeBA1aCB0uPGnX0XKbm9E
         Wirfu99mryadPWIT0YJ5awqKWHBSXNJKLDpSXCQI2HDU4O6+cn8p34MnTuszXF491Yr5
         BFYrgIQJTgiyj10S4f7sQrIyNM4aq3axTo8ZK3T2azjINIrNduLVPTrv3uD4KUKjLRwL
         QlbvrJzTloLZ1oYHtxAvc9XhTqw/P2cajW5VSv6ztbFwID2GBkaVcb27NeGQC73kzNcw
         gn4A==
X-Gm-Message-State: AOJu0YyjYiOR0mATeL3UR/AF1HcIrQ2MUtpgRi2dsQj7NJLwxj9wRZtK
	L4cBW4HDldpQ6SmTSarnQN+d+zd6UcnHr50CyKncmTM9dza/cONwZKrnM1wz
X-Google-Smtp-Source: AGHT+IFj946tMsJ4Td9sod+WLkDRkFjyPHafQZUuEOvBe7fzHl8fJwgGFkohhUJBkRpncVNsiCf8Lw==
X-Received: by 2002:a05:651c:19a8:b0:2d8:60a4:d06 with SMTP id bx40-20020a05651c19a800b002d860a40d06mr139882ljb.40.1712676447474;
        Tue, 09 Apr 2024 08:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b004162d06768bsm18420437wmo.21.2024.04.09.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:27:27 -0700 (PDT)
Message-Id: <cbe355e6ae84414118badd5c98d302010f4e2a47.1712676444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 15:27:23 +0000
Subject: [PATCH 2/3] t3428: use test_commit_message
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

Using a helper function makes the tests shorter and avoids running "git
cat-file" upstream of a pipe.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3428-rebase-signoff.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 975b859ce09..133e54114f6 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -40,15 +40,13 @@ test_expect_success 'setup' '
 # on the next subtest we can show that --no-signoff overrides the alias
 test_expect_success 'rebase --signoff adds a sign-off line' '
 	git rbs HEAD^ &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
-	test_cmp expected-signed actual
+	test_commit_message HEAD expected-signed
 '
 
 test_expect_success 'rebase --no-signoff does not add a sign-off line' '
 	git commit --amend -m "first" &&
 	git rbs --no-signoff HEAD^ &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
-	test_cmp expected-unsigned actual
+	test_commit_message HEAD expected-unsigned
 '
 
 test_expect_success 'rebase --exec --signoff adds a sign-off line' '
@@ -56,30 +54,25 @@ test_expect_success 'rebase --exec --signoff adds a sign-off line' '
 	git commit --amend -m "first" &&
 	git rebase --exec "touch exec" --signoff HEAD^ &&
 	test_path_is_file exec &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	test_cmp expected-signed actual
+	test_commit_message HEAD expected-signed
 '
 
 test_expect_success 'rebase --root --signoff adds a sign-off line' '
 	git commit --amend -m "first" &&
 	git rebase --root --keep-empty --signoff &&
-	git cat-file commit HEAD^ | sed -e "1,/^\$/d" >actual &&
-	test_cmp expected-initial-signed actual &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	test_cmp expected-signed actual
+	test_commit_message HEAD^ expected-initial-signed &&
+	test_commit_message HEAD expected-signed
 '
 
 test_expect_success 'rebase -i --signoff fails' '
 	git commit --amend -m "first" &&
 	git rebase -i --signoff HEAD^ &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	test_cmp expected-signed actual
+	test_commit_message HEAD expected-signed
 '
 
 test_expect_success 'rebase -m --signoff fails' '
 	git commit --amend -m "first" &&
 	git rebase -m --signoff HEAD^ &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	test_cmp expected-signed actual
+	test_commit_message HEAD expected-signed
 '
 test_done
-- 
gitgitgadget

