Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894F27780B
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225967; cv=none; b=kPMTVdUAVDA0n7TXHhZ3TNh1z0IvCcSW51v9NxKT4+V5xYMMDxt3Zbd7LX6bGcN7geef4KlJ4sn3R1sfVezK19CTTWJ2/SCRlX/yFMw6isO1lTN8zbaosGOyDR16H/Mtb7yudpuxbRKQ0zEPEU32nom41dsqg9W91V53zTLlDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225967; c=relaxed/simple;
	bh=jWi5QUBe35ZtkC0/AdK3L6ZzuR59Zu0X9jsA0m2+86o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/4SYeOkNpr5js8N90wb5HgYFQJNdHrWXGVYhUpPfGKmeg3kAQN3isBk15AgiWCKVyjyTD3gyHBVoHZcFuJTc8pz7HzepyQuMHg4VWrMR3ZnvJYQkzxHC3JJZspJJT1MzwqiRkITjxaFM177wI5MKXxRaoPG+cx1h05mdaw/O9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtD+I1b7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtD+I1b7"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so5922808b3a.3
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744225964; x=1744830764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxdxi/3rwpgQVq1j60vYuMkU/AMmHtv2y9ycNnvzDgk=;
        b=PtD+I1b72X4fikrtVnCyLvNTfBlWjiMzJ7sIyLS+oJQa6o1LjpqiRupRWMoBo8nDOv
         RK4NpZTYTcPtwrZEkbIXMYIfErLi8xZ9ehDXanzDlN2AFCF3zKb5UGPuLwBiaO2T67sG
         GpLHD8kWJEwFxW7Gz1nL7soT0FK6tnIxRgtjrZurQ4Fz/dIRTtr0hOYojM73XwxlRE2r
         nnQsWiOJbl/FDWeL/aaeIiItFEhMjzn13YOG03OMrfHt3jQVlZyxALql0lW56cK8u7BP
         zg7q1VNDoq0f1N7/Z3C8fX/GE4noWTCRgjZhAT8hjTB00qlEdTxkZFylVHC7lVWoRFNw
         FRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225964; x=1744830764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxdxi/3rwpgQVq1j60vYuMkU/AMmHtv2y9ycNnvzDgk=;
        b=TymQZ81eYFOH6pkHZ2F/kPdM1Nq/3705/6DbkSvPiJcfnrwrs9iJM4K9FGNy+6dTkO
         55PRaOvRakhgAOiu6OORYIKIzjjp377yghn1ITsqrytSdToocbLjERNTVJMG7R/EX5um
         0nyFficYGEz0VCwtJOM2vhYgZt8aKBO9+osdJ/zkXB5NFCvf4vjDV/yAePXu5O14zeWc
         CXxoMjUYNGL712lGwBb+PpIge2EkVgvHOHA1NfotioeAvlh5zE7ZUT1lcmqJ4HOg7WiB
         IB475M4cZclp11dLTnwhtRDzhL+a6GfvIQiS77Ze0CyStnuu8RwoeqwkQHzzNxVBOnMD
         fl1Q==
X-Gm-Message-State: AOJu0YxURCi8z8NF6eyiUuG3pj81VlUz5ca/h8hxq0U7KC9XeXZ88wDD
	wE/rkZoc0YZcg7tQfqUfn7wWTSXe4CXY3ovKmMzvW2J5LH/hMBn5
X-Gm-Gg: ASbGncvZf5N/J3bPgULS4VWpS5V8irhECqtPoDiH6BBw8kUrlFajduSBCJvcYwwTmGs
	lblaChSca9BPkOAI1D1zSwh0dB8sa35krOgQCPH2Z46aVFfvXykDuCI1mGkvW71bFim4Tyek1ar
	xZLVclze/i0jdMSfrFjlrc2lrtcfKMhmIRMN+RJyNiz1VMl0vcFl4sYg2s01xM0iRVOtueY5LqJ
	BNoNhWAGjkGh/zA3yyjz78EeQKfnEzqUvs2+UabaiKoVxlExW041h+QrkAsBIbiVv6WfMH+n3/z
	Ka06N52buiScUMfoDRdkEEPgkOtTnD0sw6Kok7izjz9Qw+HX8TnCeBa1s8WD
X-Google-Smtp-Source: AGHT+IFAUwmswp5NYmfaub//nZX8SHMceq0gLmRFVa6TeERm8YemtdrTLEUPIY8xxI7OkYYGQqbLyA==
X-Received: by 2002:a05:6a00:22c2:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73bbee10d34mr73848b3a.3.1744225964516;
        Wed, 09 Apr 2025 12:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c3b:674d:f69c:9806:a3f:9fca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4f768sm1772146b3a.142.2025.04.09.12.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:12:43 -0700 (PDT)
From: Subhaditya Nath <sn03.general@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	sn03.general@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH] t7422: fix extra printf argument, eliminate loops
Date: Thu, 10 Apr 2025 00:41:11 +0530
Message-ID: <20250409191139.29644-2-sn03.general@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409191139.29644-1-sn03.general@gmail.com>
References: <xmqqr021qkeh.fsf@gitster.g>
 <20250409191139.29644-1-sn03.general@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The POSIX man page of printf(1) mentions -
> If the format operand contains no conversion specifications and
> argument operands are present, the results are unspecified.

In practice, this means some printf implementations throw an error
when provided with extra operands, thereby causing the test to fail
erroneously. This commit fixes that issue.

This commit also eliminates the for-loops surrounding said printf
statements in favour of the built-in functionality of printf to consume
all arguments by reusing the format operand as-often-as-necessary.

This behaviour is mentioned in the POSIX man page of printf(1) under the
section titled "EXTENDED DESCRIPTION" like so -

    8. For each conversion specification that consumes an argument, the
       next argument operand shall be evaluated and converted to the
       appropriate type for the conversion as specified below.

    9. The format operand shall be reused as often as necessary to
       satisfy the argument operands.  [...]

Signed-off-by: Subhaditya Nath <sn03.general@gmail.com>
---
 t/t7422-submodule-output.sh | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index 023a5cbdc4..94a14f1c31 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -178,19 +178,13 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 		test_commit initial &&
 
 		COMMIT=$(git rev-parse HEAD) &&
-		for i in $(test_seq 2000)
-		do
-			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
-			return 1
-		done >gitmodules &&
+		printf "[submodule \"sm-%d\"]\npath = recursive-submodule-path-%d\n" \
+			$(test_seq 2000 | sed p) >gitmodules &&
 		BLOB=$(git hash-object -w --stdin <gitmodules) &&
 
 		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
-		for i in $(test_seq 2000)
-		do
-			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
-			return 1
-		done >>tree &&
+		printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" \
+			$(test_seq 2000) >>tree &&
 		TREE=$(git mktree <tree) &&
 
 		COMMIT=$(git commit-tree "$TREE") &&
-- 
2.48.1

