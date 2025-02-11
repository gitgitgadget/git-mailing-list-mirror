Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203381F130F
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263864; cv=none; b=CsNji4PfExMqzulXRzzVLOjthgxVOGeTYBvNEb/Y4HuAUCGG6kiomDFe0rjDkqv8a2GtA1r9VKBvkGUonntduyn0U86IMjQdlTPK2KuJEFWHxP4TrcC+2dwb+XWlbyd4uEopOnU7iXBr1jjAN55aThmFOKLTMEb5G6V6QYNzrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263864; c=relaxed/simple;
	bh=1k6sZFd5SlI1tRrsIV2iTwLP+8Q3ipcVpAKF+jzh+uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ/sn3FGZzP+J+sXFo+eSvdC7BkSGpOaxtivrwnlMdWdS5iTfdMdF16Vh3fbYwWDXJ4AW27hQc93SVvcf2rZeG/Kmgvd0zJN0F+uuAz8G9Kg1yW2vwcwbzJ6H2Pw0frFMJzwsCw/PPKS8MOLsTFTze8qyrNiMRCUEB3AD5s4yI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqt9s3Ku; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqt9s3Ku"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa488351ffso4073343a91.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263862; x=1739868662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yLM0t6bi/COjCWc8nMIU3KttU+/DAqFPI83g6CJ4i4=;
        b=eqt9s3KuXRqHX684/2CBEzdgi6zMSiu1jwhFTjRR6vdkDteQoWBz0fc9UO2NKN95up
         ohKEYbj2k3obKsKbU+SdgNCYR09VhDzMYj905oO1a0CeAMZG/go8VYdtyYDvfTkq4Jnb
         Hdw0Jd+5Ms6xa35uirBT6s3GWzVQT63A5hZFVUefTVHf/PLioAtASLXCpkp8jYgENlnh
         j3Ufuo6JdbTn+/Nm57eQUwa7TJ6Y1xPaogPhW0Ljhq6LMH3Ver8n4kcQAb1ZnFrmmJPJ
         U0frMIW9uN0bVeNfiPuhdI2ryVzX5ejhriAxK2y2EjoNIyY3WFbMn6SWyHy2y0by8wpO
         qO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263862; x=1739868662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yLM0t6bi/COjCWc8nMIU3KttU+/DAqFPI83g6CJ4i4=;
        b=O3WAXM5SR6+lh+KxlnAQd3CZAprI8T/4soAwJUIb5GsNLpGUde/LrWIS6eBJx1dB+f
         1yp6FlO1VLq1xhd2KMTFNRPgNtepZWk/69ARX05fFOdR5JovomZKC7Fs7Y2z0xDNOhla
         vmTW/CVowW7gAo1Oy/T7iK72BQt88zRRC5TeZjKRQL6nS+EmYOSfinGiTn/KiaAY2//W
         IPkUYTXIlZeaChh9r77uiMO2/TbAFVPhlXUN5eWqKFc5og0MafnMUupJKgowLdtPSxXU
         rntIBifObbPIxUkdLjDm8pZRCyM39IodhGOHHfIBiM7HBr3y7CZ6ydgmVk3X9V8BAkCo
         2UgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCxEmGPkalbHfdJyDW3RdZUFAHcFwNhTzK0HasGQ+i/EsQOL6XtKBxCbYE5CqLzgssqjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OUETAmUWC1OmXXF5+4sx3oz7QngavIbUfEo32TUkcHxMoe0j
	P6sGKWYP3zsYUGrr0xtIiVu8+3I5EPNuCTdyDGr8MBwsqHNjNQKCtF9K07Qr
X-Gm-Gg: ASbGncu0+HfUezLYhZQRIbaFCLtLSZ3+rLGwpg+1pQA+7O9xHlS/t2CKZ0OIU7oW1g6
	iTscpLRq8aT5w5WfSI/DWQVdHydkvIWDvgV9/w5W3LZ4kSTAOLjMGK6hOLcOrZSg1nowH1lHlHg
	1W6JjUWEQmz8wO0lGHqDd2VdMABiHCjrgdqu8GPMVrGBYlQ4KPX06VpFZ0Mw0bzoEjPqLbzJxvi
	l61sAIl1AZ1rSxbjroMg47XKf9ehskGa+47ge4qIQH+vGr11AJA2JZi+peheLHv8BRXXL4343MW
	eduw8uU7zVMpZXdQ4Sv26B8IJSnbENKJ/jLmNrU=
X-Google-Smtp-Source: AGHT+IFa7W+HVVOIfOgpPRVU6XXgCAWA8LRI0R4ri7jE0w9L6rOEVzjJKKbJaMhTFgAI8y7/Rh6dpg==
X-Received: by 2002:a17:90b:3143:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2fa243eef9bmr23269818a91.32.1739263862326;
        Tue, 11 Feb 2025 00:51:02 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:51:01 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 08/10] diff: test: Use --patch-{grep,modifies} over -G/-S
Date: Tue, 11 Feb 2025 00:50:20 -0800
Message-ID: <20250211085028.3923875-9-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
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

