Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C08281523
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902085; cv=none; b=DSBLAZx6WzWKnH58XZK3GiVlhfDp9W2i96R8VuKWZLkylycLvHEkA/lrtvtDGYmJOSGf0fXCazOroet6fPqET2oHb8S+TVcsIOIXCldMpCpyZB84l72wIycAzP6LVc4ZzJcAlTzVTB7QzuHEAsLrC888X2h+KMyOog31LZmbjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902085; c=relaxed/simple;
	bh=Uo8W1dUHZCkKbfJ8Gl2aoB+4AufGI3R2byke5yzgWL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrS0LuRwI4QoFvRoTuvUkifhhzxPnE5FntmZkl8WjQYTI5ndfT1KrccYr10x5u49bxRIl5ZfUH7EN6Cd7ezs8N7XhOyhF8I3recwKWfyF8GGRp09zWJDRrSk3cXFP5LG/mEIspzzeqqYkb0k7LwFgFV4mzIMtAKTZurrce2dKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC7UWqMZ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC7UWqMZ"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7297c3ce7aso2572369276.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902082; x=1747506882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfc4zsCCGBQJkvU2IsQGyU8NyZZkq7uzkMm+dOtVozE=;
        b=fC7UWqMZsqmpYxBo4evpIlAWshG9UUvzzEmGWkSUuc9K2rqQ1sjy8lyhxFM1yKyOqf
         cUYAtvS8YH6P9mc/ETZqO7vVjhE6HnaP723sjkFYi0zAC7VAHagGR+ZmCgCnErFt+OP0
         5nMcnFpmr9yyGxh7C9tMnIHx11NXYfU/oW1EuR84jSBRcjkkz6iB6nBPBKVbEZ/KXVpg
         KwZnY/B4cJAEvNlmof/7LDtm5/NHMdXDkO18PVP5XrH7FHabB97v8Eat18pxXKPRHeZx
         fU8LIqbp/CPUIq/SOB9k0ojm1qS3lw2IWXWuvKXX1MTjz09yhrtjALnr8jNpZ0lvPTjd
         UgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902082; x=1747506882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zfc4zsCCGBQJkvU2IsQGyU8NyZZkq7uzkMm+dOtVozE=;
        b=c8c0+E0YgP+r822shmrgpDHkTYMaj4S2g5JaY65DdPUyvUJ0KmF+wnN+YppIDrbG3R
         NeHwWQA7jDIA3IgX7Lk+SifdHzC4dU50IVXY7gBajhtoG8xoCI+aSNzkyuMc6ZyeZaU4
         DQoiToIBcbqD4IGLzsnRbqpDKsVwhD25uZjLXbtbSebVMHucVrGwZpZ8HLFZaLPtNY8W
         M2DoqxJcVt3BgCti/bAXCDNP7lGJmFL+YfHGWR3EYyLRFjQwQQd+kfg6edvz+oEAGZoW
         ZXsXPPrAfxOQwiBkTvtr172alNYcpBil0UEDuamQ4b5Cj4H1AONdiP2PK6aShwlTlK0R
         uEFA==
X-Gm-Message-State: AOJu0YyDUPZrsLr2XiFSwMFEEpiilX6R2ahgN5Koe27cwegRDx6UjFfA
	ZDu5lID0gSQf8hbm0BJ9pTcpJVEeF0pA7ANzqVdc5uuJFONBoe5zDR9qZkCX
X-Gm-Gg: ASbGncugvaZbvjjCzaw4FCaPO85ZBCEZRMdk9Nqd+dESFb0Op8YFZ/YxE6p+ceHBDVk
	dR0G0/cOXJXWK7I60ssw1uKVsyOdYjKVhASWw1Si+zNXpPSub0DAY2Cr6eC2/7fEVSHrBKuUUwl
	6ti6llh9ZTo0Ak+8JIin4lUAU7pgQ/H6ph0fdKRrKp3YqLg0z7rTt07gSRbbRyeoz/rKKmCPBrE
	STxqggvbjRa8DWTAAAEzcU7vhfTS1W+gWGB7NuwxcDUeNj0wV1JRa4LMHpGdLVolTtT8zX/zRfe
	hnTTBR39VEb3uopFJz15rW7u25XUbANQijEz9snmhwDbura8cOgRMDKZmfnHbBYpC5OlXfZJZpK
	+cVpNWYns8vr0P8/mu7u7rtnH
X-Google-Smtp-Source: AGHT+IG9kkb/AD1w53foMwvhax+UIARAavJRKVPdTw5l+dTObOa44dFh+yZuUq/6o9zmVnAxbzDZUg==
X-Received: by 2002:a05:6902:138d:b0:e73:1812:88ec with SMTP id 3f1490d57ef6-e78fdc947f2mr9889715276.11.1746902082236;
        Sat, 10 May 2025 11:34:42 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:41 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] t3905: adjust stash -u tests for breaking changes
Date: Sat, 10 May 2025 14:33:43 -0400
Message-ID: <20250510183358.36806-9-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like previous commits, adjust the expected results of application of
stashes with --no-index as needed, with <pathspec> tests typically
requiring --no-index.

One test (stash pop after save --include-untracked leaves files
untracked again) requires an extra cleanup step: subsequent tests
("stash save -u dirty index" and company) are not expecting "file" to be
dirty in the index, but after "stash pop" it will be. Clean up after
ourselves rather than adjusting later tests.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 39 ++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 7704709054..ee6cea49c8 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -89,7 +89,7 @@
 	git clean --force --quiet
 '
 
-test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
+test_expect_success !WITH_BREAKING_CHANGES 'stash pop after save --include-untracked leaves files untracked again' '
 	cat >expect <<-EOF &&
 	 M file
 	?? HEAD
@@ -108,6 +108,26 @@
 	test_cmp untracked_expect untracked/untracked
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'stash pop after save --include-untracked leaves files untracked again' '
+	cat >expect <<-EOF &&
+	MM file
+	?? HEAD
+	?? actual
+	?? expect
+	?? file2
+	?? untracked/
+	EOF
+
+	git stash pop &&
+	test_when_finished "git restore --staged file" &&
+	git status --porcelain >actual &&
+	test_cmp expect actual &&
+	echo 1 >expect_file2 &&
+	test_cmp expect_file2 file2 &&
+	echo untracked >untracked_expect &&
+	test_cmp untracked_expect untracked/untracked
+'
+
 test_expect_success 'clean up untracked/ directory to prepare for next tests' '
 	git clean --force --quiet -d
 '
@@ -206,7 +226,7 @@
 	test_path_is_file foo
 '
 
-test_expect_success 'stash push with $IFS character' '
+test_expect_success !WITH_BREAKING_CHANGES 'stash push with $IFS character' '
 	>"foo bar" &&
 	>foo &&
 	>bar &&
@@ -221,6 +241,21 @@
 	test_path_is_file bar
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'stash push with $IFS character' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push --include-untracked -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash previously ignored file' '
 	cat >.gitignore <<-EOF &&
 	ignored
-- 
2.48.1

