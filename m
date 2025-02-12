Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBB1E7C0B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330845; cv=none; b=ZfE4U/t2IuOWDzqKWuTSK1szaQTSFW2iBE3I7LJtPwBMjT6ngYuQZGzUw631fEwGKtwtCkEM4D6mau1zAN51eMk/f68VU1m5Pu0MHGKjqvk79wMlPskFa5nPMSEV2ovF3/+ob4i2sO1IV7bUN9ZoIyzsD6vqqJYiqIda5diqhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330845; c=relaxed/simple;
	bh=1k6sZFd5SlI1tRrsIV2iTwLP+8Q3ipcVpAKF+jzh+uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYeo9DQE53HQMkxQiUFdvg+2tlxY0ogQr2IoISkjODNLFCLb6Xj9/HTmfquwHsoHHbtjaaT6bVWpUbhgZtkQs08IRYYbhGjNuJos2hHqID3Gha14uUMkOwKM9Qr15Zn8w4SiHYmxBOO3XcK2EdAjMfDEXFZaZFXYgJXfOs+P7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae92/Vqu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae92/Vqu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f62cc4088so76171905ad.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330843; x=1739935643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yLM0t6bi/COjCWc8nMIU3KttU+/DAqFPI83g6CJ4i4=;
        b=Ae92/Vqujx02Z8ocWVE4lRfkyU5CJcObmekNcAUzF062jWhd71xpweLpL1AON7TOM4
         rhbhN87WTF1W7iuFB/4aHMK5dILDFz9hTaNE2fi6Qha8fwt/yv8JkzzL1SYESwYxlhAG
         f2OGdpsCiOLJk9r9T/9Z8Ox47dagKt7JWNniKruRqXdVpnNncG55KicDqwdsFeDKGpF1
         g1V2bZ5KZHI0DbuaC1OBeSVUEr0CXuMfmb2t3gctSkoLVMyZGaw12noen+srQyxrr5Ff
         5H1/Xg0IY9B7KFecggICSxB8VpMEHzBt2nV6AiX04zqlGHZ8p4vXbMXxdrVPOHQS5jgs
         LsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330843; x=1739935643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yLM0t6bi/COjCWc8nMIU3KttU+/DAqFPI83g6CJ4i4=;
        b=R9iV6VqLpGU0ZpWuPnuyHp51W33I9rZGFM30ji5R7zPgKHVZMyJB0DFLPj33trWLX5
         HQhCs/4POLOmodWsC/TJVJrmdYj4oeV7dJ+Vid0LbLH+HuHlT8eRbhMyd+1xH6Se3w2y
         48zrpOP8jvjAsZcQ/TBvuaL3S946OU4I9GWuZs7Ol3tOIFUNCnRXfqt8IF55ZtkBijUr
         ronSRStz42vZoLva4QP6XveQwJVgrYvQOXejwA9Vkd9kIOkD5ySHKYscoDI3Cqd8vY6H
         RxEQzOoIXpiuGuXANGr7aCk+aRrA9FunduBGQzsDJT+k3NYkkL0kNZ5cvQYQyL+YRmPA
         q3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV4CgsatyEnvkpoBvLwaypdinutZQV3S8WMGvgKUluZTGNtf3CMkjijfRuiFuwzQPvN0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRkyYlYLPNSBpxNgTuEdSEru6DuPrMYuPz827Z+2QvbROXu2x
	YJtnXsOK8TCDr4Sw9u7kHtM0sGC9e3/ZJe8XTxAsIpOgzsif/lJuUmG27qTeEVQ=
X-Gm-Gg: ASbGncsa9pR4BWr6SrpCKKEeKmlQ5nfEZ9uUGNJFdZjE3q4Q/gP9WPn/ha86h3Nufw0
	e2RJRu21j0McBkjLea1jYdy4ODYwhRfDWPMh0OO+mrbw3WcugnsGCxFEqx6hV6BittWGUDkPkUO
	XDza7C3juEM0+qtUOspRxQHkY0anAPxVFXkxNXOZs4hQQ7gx2psRZaa+9EJILsi/a/chmKupw2f
	ubcmHEU1EgFhFfQH7bEEfNsNARkcSKDj0MiD+IG1RiJfzT2ZpakSsk/z9J2LM3zkieHzmM0P6Lx
	INzjRltnKbj/jbo8NwbQn+e52QMm4WlqNPZii1g=
X-Google-Smtp-Source: AGHT+IGxvxvChSCF+EodxS7ZWkAiq4e7NNvt2Bn9FEbHB7ZsBeQumRDJ/OV6p/KR8ocv2mkLNjRdSA==
X-Received: by 2002:a05:6a00:2e84:b0:730:888a:252e with SMTP id d2e1a72fcca58-7322c411a33mr2355622b3a.17.1739330842570;
        Tue, 11 Feb 2025 19:27:22 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:21 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 08/10] diff: test: Use --patch-{grep,modifies} over -G/-S
Date: Tue, 11 Feb 2025 19:26:52 -0800
Message-ID: <20250212032657.1807939-9-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Long argument names are easier to read, compared to short ones.  So
while short arguments are great when you want to type a command quickly,
tests are more readable if we use long argument names.

There are still test that verify that both short and long arguments work
interchangeably when parsing the arguments.

Tests where the focus is not on the argument names are updated to use
long argument names.
---
 t/t4062-diff-pickaxe.sh |  8 +++---
 t/t4209-log-pickaxe.sh  | 62 ++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 8ad3d7..805e0f 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -16,13 +16,13 @@ test_expect_success setup '
 '
 
 # OpenBSD only supports up to 255 repetitions, so repeat twice for 64*64=4096.
-test_expect_success '-G matches' '
-	git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
+test_expect_success '--patch-grep matches' '
+	git diff --name-only --patch-grep "^(0{64}){64}$" HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
-test_expect_success '-S --pickaxe-regex' '
-	git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
+test_expect_success '--patch-modifies --pickaxe-regex' '
+	git diff --name-only --patch-modifies 0 --pickaxe-regex HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index ab14b..5f4d6 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
+test_description='log --grep/--author/--regexp-ignore-case/--patch-{modifies,grep}'
 
 . ./test-lib.sh
 
@@ -142,15 +142,15 @@ test_log_icase	expect_nomatch	--patch-grep pickle
 test_log_icase	expect_second	-G picked
 test_log_icase	expect_second	--patch-grep picked
 
-test_expect_success 'log -G --textconv (missing textconv tool)' '
+test_expect_success 'log --patch-grep --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Gfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --patch-grep foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -G --no-textconv (missing textconv tool)' '
+test_expect_success 'log --patch-grep --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Gfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --patch-grep foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
@@ -173,20 +173,20 @@ test_log_icase	expect_second	--patch-modifies p.cked --pickaxe-regex
 test_log_icase	expect_nomatch	-S p.ckle --pickaxe-regex
 test_log_icase	expect_nomatch	--patch-modifies p.ckle --pickaxe-regex
 
-test_expect_success 'log -S --textconv (missing textconv tool)' '
+test_expect_success 'log --patch-modifies --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --patch-modifies foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -S --no-textconv (missing textconv tool)' '
+test_expect_success 'log --patch-modifies --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --patch-modifies foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
-test_expect_success 'setup log -[GS] plain & regex' '
+test_expect_success 'setup log --patch{-modifies,-grep} plain & regex' '
 	test_create_repo GS-plain &&
 	test_commit -C GS-plain --append A data.txt "a" &&
 	test_commit -C GS-plain --append B data.txt "a a" &&
@@ -201,31 +201,31 @@ test_expect_success 'setup log -[GS] plain & regex' '
 	git -C GS-plain log >full-log
 '
 
-test_expect_success 'log -G trims diff new/old [-+]' '
-	git -C GS-plain log -G"[+-]a" >log &&
+test_expect_success 'log --patch-grep trims diff new/old [-+]' '
+	git -C GS-plain log --patch-grep "[+-]a" >log &&
 	test_must_be_empty log &&
-	git -C GS-plain log -G"^a" >log &&
+	git -C GS-plain log --patch-grep "^a" >log &&
 	test_cmp log A-to-B-then-E-log
 '
 
-test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
-	git -C GS-plain log -S"a" >log &&
+test_expect_success 'log --patch-modifies <pat> is not a regex, but --patch-modifies <pat> --pickaxe-regex is' '
+	git -C GS-plain log --patch-modifies "a" >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[a]" >log &&
+	git -C GS-plain log --patch-modifies "[a]" >log &&
 	test_must_be_empty log &&
 
-	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	git -C GS-plain log --patch-modifies "[a]" --pickaxe-regex >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[b]" >log &&
+	git -C GS-plain log --patch-modifies "[b]" >log &&
 	test_cmp log D-then-E-log &&
 
-	git -C GS-plain log -S"[b]" --pickaxe-regex >log &&
+	git -C GS-plain log --patch-modifies "[b]" --pickaxe-regex >log &&
 	test_cmp log C-to-D-then-E-log
 '
 
-test_expect_success 'setup log -[GS] binary & --text' '
+test_expect_success 'setup log --patch{-modifies,-grep} binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
 	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
@@ -233,36 +233,36 @@ test_expect_success 'setup log -[GS] binary & --text' '
 	git -C GS-bin-txt log >full-log
 '
 
-test_expect_success 'log -G ignores binary files' '
-	git -C GS-bin-txt log -Ga >log &&
+test_expect_success 'log --patch-grep ignores binary files' '
+	git -C GS-bin-txt log --patch-grep a >log &&
 	test_must_be_empty log
 '
 
-test_expect_success 'log -G looks into binary files with -a' '
-	git -C GS-bin-txt log -a -Ga >log &&
+test_expect_success 'log --patch-grep looks into binary files with -a' '
+	git -C GS-bin-txt log -a --patch-grep a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -G looks into binary files with textconv filter' '
+test_expect_success 'log --patch-grep looks into binary files with textconv filter' '
 	test_when_finished "rm GS-bin-txt/.gitattributes" &&
 	(
 		cd GS-bin-txt &&
 		echo "* diff=bin" >.gitattributes &&
-		git -c diff.bin.textconv=cat log -Ga >../log
+		git -c diff.bin.textconv=cat log --patch-grep a >../log
 	) &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S looks into binary files' '
-	git -C GS-bin-txt log -Sa >log &&
+test_expect_success 'log --patch-modifies looks into binary files' '
+	git -C GS-bin-txt log --patch-modifies a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S --pickaxe-regex looks into binary files' '
-	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
+test_expect_success 'log --patch-modifies --pickaxe-regex looks into binary files' '
+	git -C GS-bin-txt log --pickaxe-regex --patch-modifies a >log &&
 	test_cmp log full-log &&
 
-	git -C GS-bin-txt log --pickaxe-regex -S"[a]" >log &&
+	git -C GS-bin-txt log --pickaxe-regex --patch-modifies "[a]" >log &&
 	test_cmp log full-log
 '
 
-- 
2.45.2

