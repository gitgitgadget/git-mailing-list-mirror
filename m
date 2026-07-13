Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3F43B4AA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951369; cv=none; b=qAs9EuKFLhD9eFeGyTHoTcZf+OPEOVVqvlyOqq2csOnG2LwNpVLUVINzWVrvXrFdsNZwJajWieR9Gdm5FQBgNtlMSGaNJBrG+zs1qOow7T9OzpscGOjmnyOKBeOAseYlRVWIaNe6awhulkCFUODI426MIMOpkrskyL3Ihh3IXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951369; c=relaxed/simple;
	bh=cpTOCeHI8vdeEbJ01YPCvBOjBH85dXHJbuH7eNngzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umDURBt4eMx6intOd0Uxx1O/UH8YDADvzGT8ES36e2wa9fzS60dL1w8KDn3Chf02j+zm6WFUgTOBYjdtpnGaZgdY/NqHj091qakLGyp9IYKLJr1rk/DZbkfw97+26P8NVaHOZTJvlSQuxUGVRc2Qw6ddRbnqNp37YRl0oCeshmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkR5lKOu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkR5lKOu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so2737254a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951368; x=1784556168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTlaRlwYlfrOS8HtUTGgg9fMr4DWH88aFktSFFhnZMY=;
        b=hkR5lKOuJWORHviltiuxXtXT+owahQVAn0KEK2DYhZ9/S1AaU3Z125OVxHpZafOnhs
         XXiSO3MwfWx913dTVKZbEtQS+EYvjWRgrXmnmxLVJpKjvJBzf8hxoFHwK4yoorEYsZSY
         WZ9WmOjXmH9O1LppVW5ugS1ZiI7b3c7G153jl3ye0DicRyNN21EL9o7MNBekkz67jUBH
         4D1B501H/oh6jkAmYPiO9RpeRwW5NQFR4ydB8Jf/OadT0KYydrHBthNr5hOSu4vY7/mO
         P8UEs4B64uW9drcIw08JlT7JRWhqlLQQRXHUJfSj/A4kXKHjeHTeZCyLOr9Mo5scS1h8
         s3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951368; x=1784556168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTlaRlwYlfrOS8HtUTGgg9fMr4DWH88aFktSFFhnZMY=;
        b=lRTO3xvTC9Rs+cNWVKD+3gSi0Nt3Lrvvt6X7N8HJP3s1QkerpDtWSkU1OxGr0/HY8G
         PVlQ3qlXYGo3aJIijRSwrOS+yonOSNJW10lvC1QOItQ8PW656FZA/oKAIykQ9asY0qAY
         sBSyevThyfIp8i+PEXwdzvbs4RWNKOiTmjIv7w7JbHZJ5J1qM3xG5ZwL7pjjl0XdFh3E
         AV+YbqHjYlUGVKqBNF2iQ8tnNsOaW4Au8aezwQuV8T49yRD6qXthtMvaCNa88i0xIv88
         1HrKbHt5GT7M2GZuY5LR9XH+YbJB33Y34LozNvAK5SUdRvqJWajHJmHQ0oMSz65osffn
         pDpw==
X-Gm-Message-State: AOJu0YyWyarjVnNTMy6F8nhj0fSZwPFS+zEKsnKpoNnn1AM9Nbek35qw
	O0KLPj2ICK/ZfLP5uMbr+/apqgvGGriSf21IytjdGQVKuRw+9n4/w5BfgVHim+I4
X-Gm-Gg: AfdE7cmEZZx0oALH4QzPTqp4/tSwWxVQiIW96ZgxLDUk6CWYG+t7El5rNTDBFABCIRS
	JHhKjuWaDkdTlQC+7b3F3gK3jcQnLpD6evGASgG33JA4dZBPtkmRT5CyLgeLjjHUUN1sACtQiZX
	OUyi1K6/F2RmIOKfsBRXqJ4FwRgM6tStEIFmCWwRZmHvaQ/cbmmw3bqn+OsKmAJ0DvM3qi2JFuo
	38YdBJw7N+/HQexT/DNkO5Yi6JLjrc+FOZsTH0IwqeeUVqIdvtSeCETZjStC9PrfqxiyEa6EG/v
	X7VAjmqWam7T951SI6V4RgHkjCtvQi9c9fcqpQY5VXT6xFrL0NRYAY1qXaEzaVsLuNJXyLeXBpa
	ufAwcMN1GqHP0qcwpfC2XO8zl4iYwOT8SWWgkal3Wv4+9NuAiG1HLw8etKT2IidMO6+N+vZgPPl
	wAzzjt5ATOYBu33FuAEIvoK4EzQRMX2inNTpBaByD8oMjYxg==
X-Received: by 2002:a05:6a20:5484:b0:3bf:e449:332a with SMTP id adf61e73a8af0-3c110009ba4mr10483906637.3.1783951367626;
        Mon, 13 Jul 2026 07:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c10:3a1b:ac91:58ec:550:f309])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm19600646c88.15.2026.07.13.07.02.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 07:02:47 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t1100: move creation of expected output into setup test
Date: Mon, 13 Jul 2026 19:31:41 +0530
Message-ID: <20260713140142.27898-3-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713140142.27898-1-diy2903@gmail.com>
References: <20260713140142.27898-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "expected" file was created at the top level of the script, outside
of any test. Code that runs outside of a test is not protected by the
test harness: a failure there is not reported as a test failure and is
easy to miss.

Move the here-doc that creates "expected" into the existing setup test
("test preparation: write empty tree"), using a "<<-" here-doc so its
body can be indented along with the rest of the test.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index fabe5a97cb..b434d1848e 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -14,15 +14,14 @@ Also make sure that command line parser understands the normal
 
 . ./test-lib.sh
 
-cat >expected <<EOF
-tree $EMPTY_TREE
-author Author Name <author@email> 1117148400 +0000
-committer Committer Name <committer@email> 1117150200 +0000
-
-comment text
-EOF
-
 test_expect_success 'test preparation: write empty tree' '
+	cat >expected <<-EOF &&
+	tree $EMPTY_TREE
+	author Author Name <author@email> 1117148400 +0000
+	committer Committer Name <committer@email> 1117150200 +0000
+
+	comment text
+	EOF
 	git write-tree >treeid
 '
 
-- 
2.52.0

