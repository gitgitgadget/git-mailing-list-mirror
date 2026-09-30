Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F5469859
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803557; cv=none; b=HexMiqIK4Qp6btMwHIfrL+prsnSA2kmZaBtPu/NJyZMSm1V+XSpEeQm7t7c7GgmpadI/Zs4U3y7gJBX25n3YZaQOX0YjyyBSHD9A/1/FMn7rMuuQkTdUlRbxxIl9dULsQdLmgEKSHECEkhPat+7EEAHdEcUNoLaAVUjRHBJ7nlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803557; c=relaxed/simple;
	bh=BHWI28YWStIE8dSCTR9DtKWdlXafeqW+jXMSDGDxszE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKrtmah0gtF0mC05ZBG6QvjqNLv/L+gC630xN6YLn+b6L7JwCDxuSZqGGGckRrt8/MawnthvEtKhERX6Jjtl80CAQotTa0PQbpCe2Z9vexGt5FAMQZDST9Ewga+p3YP3CJPDp5eKtxfHUOE1ZpB8K+S20i4bW/quvC9rV+E1dIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYFUsaMq; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYFUsaMq"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso6599411d50.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803551; x=1791408351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoVw/rPmyxkupEvBGLCi2IJxs99qLOm131O9+Ab4loI=;
        b=jYFUsaMqMsH0aM7y8ZJxJxwMC/5Xex/5fG7IUhoAqDDEnj3ysN66B001T5rC5csvRF
         fFaDD2COAg+CHsA7sOelE53XJx8Iaqqm+ltaMSpVpjgCo33eqa71MXTlvvN7Zn1H9rqc
         sqG9nTijopZu/YpOt8ltDx6bjz4930A20A3C3yskgaPpjsrvSQ3lJiF4BHUI2Q/tyTvk
         T93a8TdBxhhB+xiDlV5/29QoNwUvqzR5FkCPM9OQShuUjdLtvNGr4AL6EmbV9cTaTqil
         ArXHddn0x57xNGjXpFZzruYcg1TXZda5Bf4qLWaDvPH+p3INJlrd409ymG+Tz68a/Y2W
         DNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803551; x=1791408351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoVw/rPmyxkupEvBGLCi2IJxs99qLOm131O9+Ab4loI=;
        b=R38dMSIyu8ngi55pPBGsgsW9rrVy0eboTXDJJtAokWYnBBvncJIRwUR1xrGF5L9cRT
         Knc/6iY35WlLdVBe2zs8K6/yFBd6zMbRwl6N3zLX2C9yBKWM/FEqwuTySdqVpFOQP1wY
         guEVtO2zQPvQZZ93/AJD9++13CG7CR7tuPJ87wMiE+Orz2RhmNEVdBplkphd9Gw/HidP
         jAuYJWVs+nR5HLvYn7u4JHXO5UhwuliBvJTajQNxT+B+n+FensE53yLSSeQY/5OyXAG1
         cKoUg0EMdkCenDHGBkPb1CvYZ9l6m8xRgDOzYQkvsPN7zcPyTd4IJiC982fc9p7puhSw
         cFQA==
X-Gm-Message-State: AFq9FYJ+gFPiMy6p8oRDcYw18n4UEyg3GENcc0ZC1x32ND66hBIJQs4D
	tDvilzxSGlR3vdWi5adeWzFMlYhC/qMub7UKhuxWh+di9gHN6KuOs84v/n9DB/MF
X-Gm-Gg: AYBFou3vyX/aAaGDQrK9UnAlKyMGBYYqOQmAZZxnkknv/R1AvyCY8NTadCaJFYVBCa4
	f8glJDQqIs8F6Y2TWpwCSnOxXbX1VlFWNW8byYpZ3YV/6RXw5GV840fPox/0tJ+dwJGI7j0WbQq
	HWBLvYXy/j6A6tCzPxsxFpYUufaTCKURXidYWZgShp5pkHyo4h9MkaMy6R2xynKXh+J31O+I1vH
	aENYcDxOAZzstae2fU3COn1U9i+pbs/zRpRmlktFbJ6ZejqP6NcxRuDk2EcX41jyL+w+cYal1Fv
	/Spxe/JbrxDMFw2Syve2/bk1HVbu+sIXBz8zWwXi5dc5wBuPQfIxo89m1e/b+jzsY1fDLvzVBwS
	g9Qo20vA9umk9ydhhF6Xg1ljVQlY9GGEQNi5DerTlOhMqByrUCu+NSYudm/2A6eebQPY8B9+n/q
	ND9BtHuYEaEBto8I275034LD+ogGaBElNUkapC9ZsLgkVTK3gtknEQHvOO1gA6mrwwn8KYyntBG
	b3Bzt9inCdlu0ULo9vli+QkCbOzKXCRNMEN86L1GizYoMw7wK5k6PKmF/0XUh1sJsuCKJlD6OvB
	cO71fLRkJpvj1fSorqZisQ==
X-Received: by 2002:a05:690e:441b:b0:66f:c1bc:409d with SMTP id 956f58d0204a3-676834995c5mr1055820d50.96.1790803551541;
        Wed, 30 Sep 2026 14:25:51 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm264063d50.20.2026.09.30.14.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:25:51 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 3/4] t3903: test failed "stash apply --index"
Date: Wed, 30 Sep 2026 17:24:40 -0400
Message-ID: <ee28d0a8406a7e03eed1251e9aac307c4e014116.1790803471.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790803471.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790803471.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will refactor index handling for applied stashes, so
let's make sure we cover conflicted index merging, too.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 t/t3903-stash.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 721158606f..70af58e161 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -374,6 +374,27 @@ setup_stash() {
 	test_cmp expect actual
 '
 
+test_expect_success 'stash apply --index leaves everything untouched on failure' '
+	git reset --hard &&
+	echo test >other-file &&
+	git add other-file &&
+	git stash &&
+	echo unrelated >file &&
+	echo unrelated >another-file &&
+	git add another-file &&
+	echo conflict >other-file &&
+	git add other-file &&
+	git diff-files -p >expect &&
+	git diff-index --cached HEAD >expect-index &&
+
+	test_must_fail git stash apply --index 2>err &&
+	test_grep "conflicts in index. Try without --index" err &&
+	git diff-files -p >actual &&
+	test_cmp expect actual &&
+	git diff-index --cached HEAD >actual-index &&
+	test_cmp expect-index actual-index
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

