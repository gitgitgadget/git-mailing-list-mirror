Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F179D4
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK/PScxA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d542701796so9026175ad.1
        for <git@vger.kernel.org>; Mon, 08 Jan 2024 22:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780600; x=1705385400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca2kQ3kJp21oTxrgP8Bu2taXSfqZrs6WOSlykmaWYSc=;
        b=lK/PScxAVyF6dud32R1COGyuxUy1at3x5bKJHhpayWQezVjgxDYiuV3GBUgiGWg63d
         jB5e2Jk00ZR01O4C1VMijhR+1Thl8qhYO6O26zdvx8RHSVDdzMI+hGT5lteVhOl9n5tA
         od2T/9S0R9ofekIvD3YFCkt9QQ5sMeIjhoK4TpH20YY3PLMaA2PXbNzHdHeTaFSsJwKr
         ObWDrpe6yAeFr44RVpB1YVVYp/Ke8z8tiiFizk/M8zLa5hqiB6gHUqPBwKptyaqZgvRV
         w8xsd8DCqRhlQyJlF5Kh5H0cfkFZRgxsjtUtseFESYbn3/PZCl3AGlrN0cKnIYXz8p/i
         BbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780600; x=1705385400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca2kQ3kJp21oTxrgP8Bu2taXSfqZrs6WOSlykmaWYSc=;
        b=Phroh5hhTplzytYRCj2uczQVN+ALcZeCQLlmUjANDUgd6f18+Ia2xx60QvE+4Y3Dbn
         DmpPEMjmfNfB/f+IvMK6pGdsWcV9JTv3p0aXrMYYFyve/Z4A0+q0xw860pvDUncqIz55
         4Sp+WZt9jtgEKDgFJJ7oOZXqNAtVlT+WGJk9jov0qofZftTJheQyI8eLAo32I3f9segV
         tdVOVeEP4Rw27CKmEJwvfd1zk9vmXL3lI5epdMdTUKTtgdvF+qWIZIZd9tyUehiUbrLF
         72Jt0DFTIPy34Mu83lG6Na2CRLfe4YBSst6siSuVnUmDAe/mVbd95sy/HgK1QGowF3W8
         Txpg==
X-Gm-Message-State: AOJu0YxVlyg936cNdcicCkXEsvfpSdijNcvnM2DHqQNAyPQk5St+DQQr
	DOsH3B6Ff9n6JqQotm9ZhAGQOYzOdQ+SUPVcCCk=
X-Google-Smtp-Source: AGHT+IHMmO3+1vZA4q/yQbIRr5lITl9IoSl84BuOxFx9qcKZ+avcSEf00cz8SC4QpgkIYzdGFfM+pg==
X-Received: by 2002:a17:902:b7c4:b0:1d4:3ef:2810 with SMTP id v4-20020a170902b7c400b001d403ef2810mr2749107plz.107.1704780599684;
        Mon, 08 Jan 2024 22:09:59 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709028d9400b001d05456394csm896020plo.28.2024.01.08.22.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 22:09:59 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 1/2] t7501: Add tests for various index usages, -i and -o, of commit command.
Date: Tue,  9 Jan 2024 11:34:13 +0530
Message-ID: <20240109060417.1144647-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds tests for -i and -o flags of the commit command. It
includes testing -i with and without staged changes, testing -o with and
without staged changes, and testing -i and -o together.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..71dc52ce3a 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -76,6 +76,96 @@ test_expect_success 'nothing to commit' '
 	test_must_fail git commit -m initial
 '
 
+test_expect_success 'commit with -i fails with untracked files' '
+	test_when_finished "rm -rf testdir" &&
+	git init testdir &&
+	echo content >testdir/file.txt &&
+	test_must_fail git -C testdir commit -i file.txt -m initial
+'
+
+test_expect_success 'commit with -i' '
+	echo content >bar &&
+	git add bar &&
+	git commit -m "bar" &&
+
+	echo content2 >bar &&
+	git commit -i bar -m "bar second"
+'
+
+test_expect_success 'commit with -i multiple files' '
+	test_when_finished "git reset --hard" &&
+	echo content >bar &&
+	echo content >baz &&
+	echo content >saz &&
+	git add bar baz saz &&
+	git commit -m "bar baz saz" &&
+
+	echo content2 >bar &&
+	echo content2 >baz &&
+	echo content2 >saz &&
+	git commit -i bar saz -m "bar" &&
+	git diff --name-only >remaining &&
+	test_grep "baz" remaining
+'
+
+test_expect_success 'commit with -i includes staged changes' '
+	test_when_finished "git reset --hard" &&
+	echo content >bar &&
+	git add bar &&
+	git commit -m "bar" &&
+
+	echo content2 >bar &&
+	echo content2 >baz &&
+	git add baz &&
+	git commit -i bar -m "bar baz" &&
+	git diff --name-only >remaining &&
+	test_must_be_empty remaining &&
+	git diff --name-only --staged >remaining &&
+	test_must_be_empty remaining
+'
+
+test_expect_success 'commit with -o' '
+	echo content >bar &&
+	git add bar &&
+	git commit -m "bar" &&
+	echo content2 >bar &&
+	git commit -o bar -m "bar again"
+'
+
+test_expect_success 'commit with -o fails with untracked files' '
+	test_when_finished "rm -rf testdir" &&
+	git init testdir &&
+	echo content >testdir/bar &&
+	test_must_fail git -C testdir commit -o bar -m "bar"
+'
+
+test_expect_success 'commit with -o exludes staged changes' '
+	test_when_finished "git reset --hard" &&
+	echo content >bar &&
+	echo content >baz &&
+	git add . &&
+	git commit -m "bar baz" &&
+
+	echo content2 >bar &&
+	echo content2 >baz &&
+	git add baz &&
+	git commit -o bar -m "bar" &&
+	git diff --name-only --staged >actual &&
+	test_grep "baz" actual
+'
+
+test_expect_success 'commit with both -i and -o fails' '
+	test_when_finished "git reset --hard" &&
+	echo content >bar &&
+	echo content >baz &&
+	git add . &&
+	git commit -m "bar baz" &&
+
+	echo content2 >bar &&
+	echo content2 >baz &&
+	test_must_fail git commit -i baz -o bar -m "bar"
+'
+
 test_expect_success '--dry-run fails with nothing to commit' '
 	test_must_fail git commit -m initial --dry-run
 '
-- 
2.43.0

