Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C851E43B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684447; cv=none; b=kDozFT0sXix6j0ma0zrElufEgYHtbgsk7cXMPC+k0gDYP5N2Lkgd7D/5cjhpPExKJkTUpTlMYNDX5o3Kzj0qQp3Q1biWBJuBsH4M4izUlMzHftzbUMHDU5Y6yMJhdrE1Gh35uD9s61vDW66uSfKUC1YfYnMgczPToSvabmHX0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684447; c=relaxed/simple;
	bh=BHWI28YWStIE8dSCTR9DtKWdlXafeqW+jXMSDGDxszE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyFtCPicvwIDJ5r/MeCyv8eLebfRTNBJDWolbNvcJqCmQuMOE56StDxjg6e9D6x1ga5trm0/HGqBQui2nBdrzVuFSSpX0Zo3kIWL+BwWkB1I7+4WJ3OxuEedBNjTH+TNXfu4suAyCc0m5xIi5xpld1l1+CaYYnFrkYibgGZ7op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwg6V7h6; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwg6V7h6"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672c2880f58so3961102d50.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684444; x=1791289244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JoVw/rPmyxkupEvBGLCi2IJxs99qLOm131O9+Ab4loI=;
        b=Gwg6V7h6wwuuB/S6aTd9BjRC54QqB3dT2gVJc1DxEcIfvbqoMWGg1gfPMzOOg+CQW9
         38YLZWMPhCodyuAy0aX6UmFFArYdpxYyWUjMPgZY6GM+hC11rBFjnwEQHQm2/SdVI3jX
         QT4hRFbnyeTtWwBaH+eicfTcE5PsXPZ83PcdlSiVVZGN/FCMpoB0eA7ZoEZtqfwxzwD5
         2eqOuQW2wlKMVFiEY9jikq3lkT+aMD3Ivxx/ndlzTstztF6sEqAss35zoz+vrD+Ap8Sw
         fL3dCQgm2DryYKKLcqMuXrfGyiyts9daMVVHcYHGSpkjBuHz7AsiaPqELrR+fT900MlH
         qJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684444; x=1791289244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JoVw/rPmyxkupEvBGLCi2IJxs99qLOm131O9+Ab4loI=;
        b=eaCzpctPaIZPDYqA8JFOobs2BcM4Xc5rwpKrumAT5d6HrSS/M+9/moFzA7vLICawqR
         r7ah2aN9QEn9UXr/2y8I7aQ0Ghds9rR1CnvOZMyJbWLFle/3P8y53iPlo+4sj+Pucd+P
         PWy25jLPFy4GvqVFxuxbnXi1+xOHw4krT72kZSAITfO31Z1d7hPt9H20uZhj65LyVfp9
         bfJVkNRwlptx4Yics6VCZYApmUtumJBwkKuff6Tlj0vjdnN/epJpmNa14NtTkzumLnwC
         K6b5vG+qRH0TRQNHYpFfnJ2iUzyRtJGt9K1EQ/Dt5Tw95muhfCGHlssCDa1WlxNXpILB
         c0KQ==
X-Gm-Message-State: AFq9FYKpAYJpPwXG44QGis29MPU/ypgs3YyrksVzUvnCj4iRx+C5+vW4
	dC+x8gyw9EM0OUo8bAdv9BVVVSWILtXLuDeRHs0YG18Iq0fvS40r3KRs29Gbl55d
X-Gm-Gg: AYBFou3+IKIzxcszacnK1cZCrGtUxp18fOfLyMbUeUeA3mkld4tegXcEmNLV4eXBMY5
	tNBjpPtlA1dJcGWg5eu55VleqfEUlrhc9Re4rfMdXSNA3vAk0LK1CHAQDiRuhnTgCLaP+BiSBMg
	XZ2hgVIK7jAnyds4vZNpQjjoRy8DZYMjz4AH1QhOD29CfjHfUUv9+hdFlSlj4yyz7Sf2+nDz+Eq
	NnDyCg5106+N2/PFkKyGYPUVflmTE4BxvMZYzjSRrvyjkjx1Zr9wn8L8wOn1e3Zzd5gEhAN+SBM
	K5Eu0ZTsZXsypnM/AxGlcZXfVQCwe2lt2A5uVWcf+WmW93Knh0RycW0Hpz7OXtHonHWXFKUUNEp
	aZ3xnRFNAlr14EzcTnjOOIACRnetcb2tX2xwHK1CsUSBoed6u4amm4oI1KQc1a616KEUrluNH7z
	RNqDl8UFU2d8th8OwZyKJjvvsnG8KXr8xqhnsDJ0VpxlVhHEB5rUj5BCN0w/q5wzWZVqoN2SvI2
	Aow1JNYfcilWdzS920t7bQ7aeK/AdIxmdhI5OevN3NM9pNb+lZ96269yRWHrupg8x2V7iN7wb3I
	5iZ2nl0YpLOrFOTUamJSLg==
X-Received: by 2002:a05:690e:1685:b0:671:1a7f:f74b with SMTP id 956f58d0204a3-672ed42dbddmr8179585d50.63.1790684444155;
        Tue, 29 Sep 2026 05:20:44 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:42 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Victoria Dye <vdye@github.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/5] t3903: test failed "stash apply --index"
Date: Tue, 29 Sep 2026 08:18:29 -0400
Message-ID: <7b0b317ce061d672ef143b1628a2d0097a878c87.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
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

