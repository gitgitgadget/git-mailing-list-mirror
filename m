Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430761FFE
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773460054; cv=none; b=EMBcSl11eIT3JQSgp2FYNjyB3HFw3WO2Iam6EzAOtmwYKdHGBIzabhx4qCC58RqqOagbSGa3hhTfsAInNlaBeeuAcV1jbK8WREpAEkMGSjtGZESymXKMhMmqgTIJ6c/+VhR8ppTo/FpyJpjj3Jh2CxbOoDp20Tun47Zpsxg9mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773460054; c=relaxed/simple;
	bh=j8HpGXrHEKG0AK4bKEC9COQRhz5YJh4asXmGkWL5ANM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmgWf3g2bqPqL4VJVVNm5rguVgDjEN2TFoUrJjJgmxgnZ+LDn/YN3uftAN+3jJa3Tf3tBQKGppWa0v3ZySiJs7FwdNmYOVWJ4/rmBdYs6xefxYqUPIsuWUiJuA9IJaymWFvnFANgzjt46In4IrgiG1qCN0i61Fc1MYXlcnMxqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4kiG0KK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4kiG0KK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1063729a12.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773460052; x=1774064852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XA+5DHyVOxg9GjJMbR3MbvDn0aQv8w3uW6lquIVtcVI=;
        b=M4kiG0KKETHsKXDf4rQaaJlw+ePFiGeoMa4saxYDYtHaDPCrPPqRahfpXh9TXizmN0
         uJS4Kg9xtJ+X34LdvHEgQXD6VEREP+utzJ+vN4kNM6recWgXduN8c3rkAoM2jp3R+h7/
         8jMgtEpfgINnBuX/+880Yr//Aydgq/x5fS9Al9SsmTFO2oxEnN1bf3uKhSP0OaQHusWZ
         bZDYD6Hmrv24m1wD3Yvd3wRaWIDpZbxAFYkUHm7+0bdo8SKHYM2xUbMYMprXmwrQIeih
         +QRlbQ6HQ4Otnfelb6xODqn/CF8kbtRu/IWGS+4jsw+6Dy3RrxolSLX2240LoyHSP/qm
         cu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773460052; x=1774064852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA+5DHyVOxg9GjJMbR3MbvDn0aQv8w3uW6lquIVtcVI=;
        b=BZpdvL2xHq7oo5VRMr8CEiVcQb+gjGsR4l3WegEEyggT0xIeRPDxhnTefwwlch1chd
         3rrHQ7yVhBuIjK2JIa70tzO7lKBRAVJky4AT3SljjdCyrozGHFKXXg4nqIayqeQbG4HP
         ECEYIEcBTlM/7DxFjN+DCosgBXqxk7sxkUoyZNNDBLMTvvo6hmsrm5JID8YaexfKJWlc
         ku/4iak2OexL6KFJllBHdwwoimu9+td0rAFzfkInJp6+om6nRlUWIuiLKN/zPizJzuAH
         iG9vLtbYXUVupnmYyzbGTkDSeU1HwDzM53rsbt04TcTudDcpEEgMe8K2kzjQUPxvOp2a
         rGuw==
X-Gm-Message-State: AOJu0Yzf95acbHc8Pmgt48EF6kcOh0yBza8QujeBQOWeTrL1MqiEbdxw
	D4RPlbPpuPptOJml9sVqklEagDj4qIoALU/5J0RAW9/3H7g4v4hUOchdCSu5HB2W+8c=
X-Gm-Gg: ATEYQzzqD3GVe5D5gT74+SWFwFezxpk9mW2v0qiHjzuxU4+Q3LmvTmtBG0lr+oE70FB
	//A7bxxEAfCBan/Vfc1nwFK2MvgpXUF/rj01dL8aht/wh0HURqwcSt6+uO62ESbhOlewnCEsj01
	qLez2NuuxFTxi2ajqu3Jhhd++j79+wKx5Wo4TUxA4RQPxdYUwcaoM6XeidDsmC6n/Y/zqagoTbk
	0r/zNO0ALdam0arTwxxI7quO7laWHvh1b1jlxPfH2GRVipc24Za9NyewzLhzDoONt4P0JbtDv37
	RkPoEI9vfKJjLsNddoCTfTMZQ33TTPzZb/saa5g+r6Wt/e/z+7VsW8yb7iD8jSpuJ5UKqkN7O2d
	yN/gxnfcLt7SnPKvCum9oPDpxlYJWFeZP5cqio0pkyeU1AZ++eK69ZLJMakolJjAgHZ+zirfuVZ
	wtoM/GmF+aC37RJjB3MBJGvOhNATrBIUL3aLBtzubzAZk484tpQdCuw71L6BWrRByDzbp8Bl6bR
	JpT
X-Received: by 2002:a17:902:ffd0:b0:2ae:3f3f:67b8 with SMTP id d9443c01a7336-2aeca9a1751mr53691985ad.15.1773460052231;
        Fri, 13 Mar 2026 20:47:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cd6:7137:9d5b:f334:52e7:a47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd1fsm48946775ad.47.2026.03.13.20.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:47:31 -0700 (PDT)
From: Ritesh Singh Jadoun <riteshjd75@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ritesh Singh Jadoun <riteshjd75@gmail.com>
Subject: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
Date: Sat, 14 Mar 2026 09:16:17 +0530
Message-ID: <20260314034617.1261-1-riteshjd75@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pack-refs tests currently use raw 'test -f' checks with negation.
Update them to use Git's standard helper function test_path_is_missing
for clearer failure reporting.

Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
---
 t/pack-refs-tests.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index dca0c77ca1..3cc4906f05 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test_path_is_file .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
@@ -113,14 +113,14 @@ test_expect_success 'test excluded refs are not packed' '
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
 	test_path_is_file .git/refs/heads/dont_pack1 &&
 	test_path_is_file .git/refs/heads/dont_pack2 &&
-	! test_path_is_file .git/refs/heads/pack_this'
+	test_path_is_missing .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test_path_is_file .git/refs/heads/dont_pack3 &&
-	! test_path_is_file .git/refs/heads/dont_pack4'
+	test_path_is_missing .git/refs/heads/dont_pack3 &&
+	test_path_is_missing .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
@@ -128,8 +128,8 @@ test_expect_success 'test only included refs are packed' '
 	git tag dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack_this*" &&
 	test_path_is_file .git/refs/tags/dont_pack5 &&
-	! test_path_is_file .git/refs/heads/pack_this1 &&
-	! test_path_is_file .git/refs/heads/pack_this2'
+	test_path_is_missing .git/refs/heads/pack_this1 &&
+	test_path_is_missing .git/refs/heads/pack_this2'
 
 test_expect_success 'test --no-include refs clears included refs' '
 	git branch pack1 &&
@@ -147,7 +147,7 @@ test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git ${pack_refs} --all --prune &&
 	git update-ref refs/heads/q refs/heads/q &&
-	! test_path_is_file .git/refs/heads/q
+	test_path_is_missing .git/refs/heads/q
 '
 
 test_expect_success 'pack, prune and repack' '
-- 
2.46.0.windows.1

