Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325E2DC32B
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950635; cv=none; b=gI5Gn19rByM09xD1IEo6oyRQhNQsPx3N2klpmHkQmLcN8vWX8U2btbRPNiMxMNTl8JTFNZxyRWibln8oAfc1R02rfGeIfuAueng+6lsb5lTAPCUUnuu3OeAceN17FcfWpWQMLuRdeHCu+aHlbgCX19sBtUmUq4OH6DW39PqMCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950635; c=relaxed/simple;
	bh=R+A+D8GH1CUIBcO3tCzA+Ad1UgsCFblx3Z1vqb25XhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuiQ9KcWQBMzDACTs7hPJzxrLXQmvCngkKeZ+KnYu7J4w2ud9mkxzBGHvshpMGC//kvjNwP47/dBGJaYAWHgAZM2mi1YqqZiP5UNamAUlo1ImdiAefYJc5uu53HpT2DMygH1BjVUg1+ZkZSNcIRwpMw9m2WTU03oqtABm7yAlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPwhO4Hd; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPwhO4Hd"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e9033498768so4855945276.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950632; x=1755555432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6sg61P5rvK/gTVAaWv4CW8mnhptjH+Jhcx1zwrrTE8=;
        b=TPwhO4HdcsTqhiEpaI8SrzHwavu6xUuLTAxDhdxsfTyf8UypORnSBmmvb3ZbwAwwYK
         Jgcj80cnyax4Fpw0EOkhxSlsg1R+4qB4/k2ceM/aeVc1B9RhuuqETxEUmyR4TA948oIC
         hh/MXvlnZXk9xXo82clJkbPrurXCUW9t1PTO2ETzl9Nn7wcX8OFuefjGwNSEu1QHPiqS
         bzMpRkxwFHWD9tnzBUYJSiv+7sUVwu7JpYM3c6euAIKAlBjIb7h6QX3SLFsa430cSL4r
         kYiH0RSjdP5JX/a7AqHZrOp+N9XQbs+QWOlNZQMabytn1JzvUtswQFNoIcouW6W2WUmE
         Kk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950632; x=1755555432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6sg61P5rvK/gTVAaWv4CW8mnhptjH+Jhcx1zwrrTE8=;
        b=SJon40Y8LwRKV5nRP9ezS68Inszpr9g5VgtvFZRFxSFE8NfO2pe9Qig7PS5jwqsmov
         G9aphc35Wy1t0FzhMphlMTt15LF2ZgR+fhsqXkTcjzMWs5m9Vn8sGQlO6U4erqR61FhG
         z7XwmzpFN6yblh93/VoBH8ayLr410xQ8OUw408zXZ0e5XKC4njlvIIdDhHV84zBF8Z5r
         oVuv5y4FQUAopRm7xgSFikq2Bi2vznzgjR0/22oiTn3lTaKb2h+rkwICmn+s93KeHu07
         6I0b8+YMehRFNMk0axjN5FXmUkzWx6ikDqPdGWTc3ph8eqlfOZBbE0yyDNUzBlqqwiXf
         y5xA==
X-Gm-Message-State: AOJu0Yy84+WpKfKhJu9AF3fwrwYOprpIizdu+V1COsuJJ3fCjMTZcOc/
	HL3OGOgH2zhqBZIFcMWT67Bf4/ufJLn8YU93+0Wk2lUr5Ep4LbwebflDD3hZzE7m
X-Gm-Gg: ASbGnctuEKI9xZkRW3V+aylwUdVjOoZD+jVx/tHu5p41HqrmX/bhQBrzurm+JDV+3DV
	iV0VSXRW0W+U70hAYhoHO2dpVb3w+UvrYpQm3qjd8hX6TS101KbY2LxH8on35p6IcVBnFFx0lSW
	/PDGa79kHaIIvl1aXPqMmId/Lhl5apDFGzS+7kGFnYIxQKMxWoN6ADZzBuMZs5WSaYBrQiFFOzf
	g1sCkchjd3PQqBEOROg3qg4zTsJfW9iwhmKCU6guuT7ahNMkFWOcPQ/ncLmR+ygk87zZ4jmEvVk
	4GPd0l5YiNIBP44mGtGOklM9/x8ZHxYarL9WdjOuCOz4zFjf8WXw6bz04b5N+gl+mOu3czsdpnT
	V8TSY/ObsznGwcKb8aEFsxOdd0mMLq+t9+Vn4t8BgKwERwfTQP+iVlq/8FsKiv+FupuLg8xY=
X-Google-Smtp-Source: AGHT+IGMpnFFBlueaIPHSrS1+CYFFL07/6QAsnHaoUgeyE5H6lfQhDV8xNdrkjR3IK9/xN4PVgqCNw==
X-Received: by 2002:a05:6902:4206:b0:e8f:f792:c8b3 with SMTP id 3f1490d57ef6-e917a282f2fmr1845694276.45.1754950632244;
        Mon, 11 Aug 2025 15:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:7d40:489a:fc5:8804])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e917b3ec714sm176217276.11.2025.08.11.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:17:11 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/4] t7005: stop abusing --exec-path
Date: Mon, 11 Aug 2025 18:16:53 -0400
Message-ID: <20250811221706.67168-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want the editors in this test on PATH, so put them there.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 791e2a0e74..0a5861b7f0 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -65,7 +65,7 @@
 		;;
 	esac
 	test_expect_success "Using $i" '
-		git --exec-path=. commit --amend &&
+		PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
@@ -85,7 +85,7 @@
 		;;
 	esac
 	test_expect_success "Using $i (override)" '
-		git --exec-path=. commit --amend &&
+		PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
-- 
2.48.1

