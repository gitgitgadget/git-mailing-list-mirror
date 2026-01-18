Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA538500967
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768711026; cv=none; b=h2CH02zx40Y3NEKk+Ms7RN0TVfYNaJpHlnLS1iHD4IX54AyT1euKJB5DSnvzNnkTF/w8DjTaEYjvkws3f4AVt1dq3MVKy4SPKyZZHJSfcnwzsXikc61vzIONEgs2IqtSyLVhP1oTPS7yJWXPtyL7cDPZFmpZww3aua/0OtgGhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768711026; c=relaxed/simple;
	bh=ZnLu3WmVDdmIDbwf0xftsJFxXJq5Rp/sQI5uPC+DqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m48oIh9D0D2R9VpYfsMPxgAcYalPX0koJnfg+PDxwiwktOspMoMhEFNPAdugnrhiAX1C+lFYTHUcSUbAnJxgyqlOPEVEQcGhVI9rMeU52FYo1F/5Q8jvg0/hYMIizo8v3omBgDoW39SIVmpzbg4sQ/DaQZDoL2Ft/3uojObYdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzZzC00l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzZzC00l"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a31d7107faso3946205ad.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 20:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768711024; x=1769315824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cblhygt0SuoSyVpQ7XlyoqluxJTRoo6XCGe13x+91c=;
        b=EzZzC00luy/TA5uZE3ajQvIgl7rz4XMOn3UPvlDE98zFdNLU/BgPvQRtDU+bulfKyY
         AxhTQeJgV2wa4uTIO/kV/AizIcNQ54lHtygGo7u+2EKl+FdHuky/S5P3ZNmWFQeyVSo6
         xdFckJ9JunOEOreDgsgt5Aquoi0ba0TPx19YST1dDF7dCAA9XrqTKFOWwMnK0b6DFFMj
         7lZCK1YuMWrf+lHVfqXoqyJKtKtcn9vf0QOqozBXr2hlCbireCoirzCOPrzv/4iZYEkR
         OtSCEkvVU3BBFXw7tZsmUFF48NialDR+RbQs2Mdv0sGGxoKncQqpcoKnTZbOiICzqqxG
         TIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768711024; x=1769315824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Cblhygt0SuoSyVpQ7XlyoqluxJTRoo6XCGe13x+91c=;
        b=u5itrDn339hSxgyinYGcGMdXF1Rq315lbb/+W09yo3Thu+Egu9/aybdb6wHo4slHIZ
         KIcGHKB3DcI7EloELAWgjDGB/Pu+u/7d+oo7LeHMzmL9t+AxxVr5jz3V85g5fyrR/0YM
         9c0RD1N3++x49ThzM4Lsu0Z1LwwWSEZ73n1QuZqrqt8KjXQLS7FIkIkxRwfDRmHUGkgj
         kxK64AM6I+rKyJoJ6Qw0xyeRIlaEZspNSInT1A9ADAY7kgYYYNagqYen5UdO4nl5sKeF
         Xl3Q9fbSsjKGFtyJfnTR6YMWBABM3+5cj6Uzrmx7AEQMBC5PefYu9lrXPYkGzRZURtBB
         P95A==
X-Gm-Message-State: AOJu0Ywuc0PmLUXvxDvnXJJW0K4GwFVh300NCVoKOgV2RkKzSrChQ3DJ
	+1r97UaFyy32QHyI4kNoLAC6lY85xtipvInwTQUjUAHwStQo43w3+Cq0QwLZeJDGcZ4=
X-Gm-Gg: AY/fxX7brKNx/SVtGcumHXOmfkrQM+IXR4PMIJvJfrDSjPzZ5OjtM0rArHdsbAWV015
	dMYa63Q2I+rPblpqLr4FMN46Xu3rB00tjgQg5dKgwNMsL7Uf4oaGAldp4mIkBQwENct9sl72NFw
	BFj91VnGW4HlYCDEhcdKISQZQMZMbIDqwu17nI4egaIqh0KJnVAMUxSl2ukjIePl2QlijIfvR5Z
	+38h/B/MvolUYQjJSIfQQI/BgHFIoNTHDV63SHVD9oz6hE5nuQScl8GLqk5Ql6C4snA4VVzqiEi
	exuthWQdJ9yqCWaasojTOqyzRbuhgaT/KLuYB1Dhrsit3Uxsz0sfV5UqGaGzHYwdUxn671yy8U3
	S48Eufo+S6GY9EyeuGfYvOkEa62CFUUsBPlT5J1Z7TRB81xJ60HG4GB/P0szjjGl/nECdXi8FPZ
	SiBmSCQW8rc93W4WcGYn3epMkotp8=
X-Received: by 2002:a05:6a20:12c5:b0:35d:fce2:cb28 with SMTP id adf61e73a8af0-38dfe9ca3e3mr5738083637.8.1768711023788;
        Sat, 17 Jan 2026 20:37:03 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c3721sm5684683b3a.23.2026.01.17.20.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 20:37:03 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH GSoC v2] t2203: avoid masking exit codes in git status
Date: Sun, 18 Jan 2026 12:35:37 +0800
Message-ID: <20260118043537.338769-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260117175847.334666-1-a3205153416@gmail.com>
References: <20260117175847.334666-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test script t2203-add-intent.sh uses the pattern
`git status | grep -v` in multiple places. This pipeline
masks the exit code of `git status`.

Update the tests to use `git status -uno >actual`.
This excludes untracked files from the output entirely,
removing the need for filtering with `grep` and allowing us
to drop the pipeline, ensuring any crash in `git status`
is caught immediately.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 t/t2203-add-intent.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 192ad14b5f..5bdd12c91f 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -16,7 +16,7 @@ test_expect_success 'intent to add' '
 '
 
 test_expect_success 'git status' '
-	git status --porcelain | grep -v actual >actual &&
+	git status --porcelain -uno >actual &&
 	cat >expect <<-\EOF &&
 	DA 1.t
 	A  elif
@@ -26,7 +26,7 @@ test_expect_success 'git status' '
 '
 
 test_expect_success 'git status with porcelain v2' '
-	git status --porcelain=v2 | grep -v "^?" >actual &&
+	git status --porcelain=v2 -uno >actual &&
 	nam1=$(echo 1 | git hash-object --stdin) &&
 	nam2=$(git hash-object elif) &&
 	cat >expect <<-EOF &&
@@ -171,17 +171,17 @@ test_expect_success 'rename detection finds the right names' '
 		mv first third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status -uno >actual.1 &&
 		test_grep "renamed: *first -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain -uno >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		 R first -> third
 		EOF
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 -uno >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
@@ -211,11 +211,11 @@ test_expect_success 'double rename detection in status' '
 		mv second third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status -uno >actual.1 &&
 		test_grep "renamed: *first -> second" actual.1 &&
 		test_grep "renamed: *second -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain -uno >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		R  first -> second
 		 R second -> third
@@ -223,7 +223,7 @@ test_expect_success 'double rename detection in status' '
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 -uno >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	second

base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
-- 
2.43.0

