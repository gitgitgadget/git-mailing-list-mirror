Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB942E36EB
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186879; cv=none; b=HnpALWTi/HnO8JECopDNqqpqmskMkgTg1zc64VOhaZQ4XqU0AaJRxbt6GOVDVwzGrKY1cu/Cey7nIr2Dk2nf8DgdpLT2FAWGI85PkHTTkTXFuqxlWZh/I9IIXVB2oAWiLGzUReyL20NFwQ/SathSc+jUMWpWc6b+CmnKF0NEzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186879; c=relaxed/simple;
	bh=20XzMBMTmgqm51DL1Ul97aGUhfPz8N0JThCXaEms4uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmTDzIxxpz3v9ZC9L6FNYT5Ng0uk7h0Hm0xEqIhNsdYg2RIo5tHDsG34JW1NTiysJm0ZX/WDxAJx2lVbEFnuxzQZhrG5E/9uZ3rMctbgo7bgHlLSacEyZtN0hS/KgvUEb5Q4zGc0bU29sNppDPEbN4rggEpWHASMONR5MKJBx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbBzBhHo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbBzBhHo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76aea119891so3975542b3a.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754186877; x=1754791677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7vOveSQq6KyRX02Ut/GY43bicdHBegEmWfe1V6fTN8=;
        b=dbBzBhHocxuY2lYcGrVkFOggfhiCfTPSwzqQO9P7wUNFxTp39CwfRO2HXRfoSDOYek
         o6ZAXutvVSNrRlnjyD0PBhitMDJ9VYPJzUrfX0aqEic4DpJXjtgotYskKZqlSugEbiZN
         YJvygiZUVj/PdRTm1Okc7PZL9zSCYs/teW0Bva8MfbKslO0V47USp0TkLmJXz2AgRCTD
         23aD8zNlRIau9ZNNM94JKn4gp8VSszLjoHJX8yIb+2cuNeS+VOT7cHv0eMZsXhIU+/BJ
         aUsQEScg52DXb/1wd0ELZKomU1upECjTkQqsqau5PHl0M1ZvkJaYUxUCCLuitKpAosZB
         U+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754186877; x=1754791677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7vOveSQq6KyRX02Ut/GY43bicdHBegEmWfe1V6fTN8=;
        b=mOcRBkk6LRnBtSGfghSWrzvcsAihWDSHPPa4CQ+0xWekpGtMgmSeKlqnhD+ePz7igD
         3HKtHMRya+RESoJAouwZrxS+usbmprjMxV9rcK9fmTwbEOvhnZs6jfKubkbT2m07tTQp
         mamlPxMUu1h0AmR2GqsryJfiEhwSJT37jr04Q+KSgR6tSowsdM+B5i8dUp2a8eo2cWzV
         E2gzgMXPgdzDTMwRGQ7QHZQx3UqysRvMXAleDMgG4N6nQnbYRQXK39KVearXDWr99vy8
         upXHzLYB7kucLqv0eY8sUQo8LUhJEp/5X20943yN2b0kL1hxqLAsohNQAUHvoXqgqeoL
         2c1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ahxm9j0UcHfmIy+2zCuT0+d+0JIp20VocSa3xSKNUiFc45bl3WdXHAOjUzCAKPKIpes=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBOkf0q8wurrQPNk8TrIFOI0Y90zNKR2Q8xNgjuTiZWvPOy9A
	N+9lqkt5OphU+0ToKo8yObqquoaH2dclS0Xyq7zdgkh3ZBotMvh+Sg24AsD7vIlpYxk=
X-Gm-Gg: ASbGncsY5De1Ub82ktzWQi/bUWsamZ4YQH/+Qe4gGx5ALKqBuT6lHijT+/tgof7ifk4
	G31cC5caKjR+Xo+EkV8CL6d+JAKLkYZdrrthyRlKIyXejZmxP6+3w2US0/hGg5NIimeNkypfYaV
	cYCAMIDc04yRKzdYY2aRgD37VC3bd8zVlXuJuiFBgLPz1CQ3BHNhaSsP5mS9d9yJ9q82b+8KBDV
	Ux+FIV9DNGqub5EaSR1izdcDGXSp36x9Qu670JTnLuiEj49xp2vO1bJJ1tehFN544G1c9SfHLWf
	4TDp7jNZC12MUt+UwL1F9M9H2jtoOWv0j5BFHxn7RBd3R04SobAe6GeEV0vdfrZov5x0uW59wA0
	y7PcdsyawroYmgJsmicfKih3FsIAuNJGkqXhGda0p2dFBDvGd3WI=
X-Google-Smtp-Source: AGHT+IHBFigLkZVvFZ3g+7wZG9qEhqlrWn2ETl0vUqGHWhO97LySnibfDTklaBE29WNrlcz59POI3w==
X-Received: by 2002:a05:6a20:2443:b0:225:9ac1:7c6b with SMTP id adf61e73a8af0-23dd7ab0b0fmr20646941637.4.1754186877343;
        Sat, 02 Aug 2025 19:07:57 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f530sm6466535a12.1.2025.08.02.19.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:07:57 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: ben.knoble@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH V5 2/3] t5200: move `update-server-info -h` test from t1517
Date: Sun,  3 Aug 2025 07:37:43 +0530
Message-ID: <20250803020744.1037392-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t1517 is now focused on testing subcommands outside a repository.
Move the in-repo `-h` test for `update-server-info` to t5200,
which covers this command.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh       | 6 +-----
 t/t5200-update-server-info.sh | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 4a827b96f0..3623272db3 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,17 +107,13 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'update-server-info does not crash with -h' '
-	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage
-'
-
 test_expect_success 'prune does not crash with -h' '
 	test_expect_code 129 git prune -h >usage &&
 	test_grep "[Uu]sage: git prune " usage &&
 	test_expect_code 129 nongit git prune -h >usage &&
 	test_grep "[Uu]sage: git prune " usage
 '
+
 for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index 8365907055..a551e955b5 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -46,4 +46,9 @@ test_expect_success 'midx does not create duplicate pack entries' '
 	test_must_be_empty dups
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
-- 
2.50.1

