Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA51362
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628352; cv=none; b=Z6jryC1NC5jnohuBb0wSKHy/H0gvoSm8JWAUu4D1U5hJfNDUdZZzmSR18SZ5a7zxBKh8t6l4y6ojNiACF55u56A53qLT8k1BbvTAgzYQRh+cIBhfmM5JDuvW7eASrP511SpK4oxJKFEthSQ2ZiGD89QwFL3P1g6Ojkm0L+UevDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628352; c=relaxed/simple;
	bh=R0Eg9KFUaMy5upvRnKYwY0wB/0XZ3peKspnsmlLn5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTwrN0szXexzPczXySgCi0U520Aj69nnb9WOhwO2yiKaF1R4fM8NMouxDMopgyYpr4rX6t32fuc5UG9rDAPzXz2FwCnk0uoJmrn/jKb9HHcvk/PwZsTqAz2uoy2+qkV9HHuC2Mrp13ssf/5pbj/OD/AG6xeIlemhUZ67XQTUjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsvID1Tz; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsvID1Tz"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dddf7ea893so152043a34.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705628349; x=1706233149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FhpJA4NO6o88Z/+2KzRbYdKKdvPbYMuUavaFGLkLmM=;
        b=JsvID1TzwgSaWiwy36yeGUs7KhiEztQM5cOc8gHz5I8WKzozW0CBSLQY6qvoogsK8Y
         lu6ZMH2WQnN0lkZCBwL6b8pQjmRudxnuaVlgNA4hlUYD32K4keRDTg4kIUK7CewNGkCt
         WhamRnZ2UPg2HYi8adnNGg6S9Z51+zbvF4fVcBDebHY97AwC6YsBwLdJhZnShOGv6GX+
         0bIcg01mkPlnUruPl5qY/WrfIRZG4lr1R3aYIcMRXMnW3dep6XSSX0vub/5WibRAVjYt
         Mnsx06h9oQDbfI+gP/8H+ZhBchlaQqPXl5tMHY6ccPY/Pnk/XP/ZzMZHsNouWXMJmNCm
         Wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628349; x=1706233149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FhpJA4NO6o88Z/+2KzRbYdKKdvPbYMuUavaFGLkLmM=;
        b=n1+KkAwtbwhC6ut/UMYw3uCV6tHn2MMtoQ8AQFDaazTE0Y5hbCUF/CZGiNYu/gHbDA
         Ul+6m2WjTstdPHWe3dygQzEljGTZXLOVILtAFaASEFa3hK385Lp64UOa/J5U0aC0ydi0
         RcPaM4RIMC5F4ZCmTWEBW/HkitikNe84jz+8aMlSZGj1nCJLYgWWIMiIx/f0XSk8+WG2
         EZDKn0kVY8LV9VUhIn5QewiOL3/H1m90M07Vitna8S8vX0TiALnmjQwfkM1dv5LY++s8
         rLblNftIk0yq5oVsgmtqQKr1v/QC9Y/eMY2rHwTu36ME9/Td+X0BT4aUwMQZT9HBfjRO
         cvNQ==
X-Gm-Message-State: AOJu0YxgxWrB/jQugOECaLYgYAoOq1UHuAtWcOfeS+CdXjC0c9yxHeRn
	uWRguUfih0G0dtzGopPdcMUlsnZXTU2AWJY/m2GoRJLOaxQfYdpfqHwfYy6H3g4=
X-Google-Smtp-Source: AGHT+IG/ZhIlRo3aLIDh7zKXUDNMDUr9sC5C8BFNGryqbIjCTxfOFHN3oDoN9q7NAoOQfFn2EV6RuA==
X-Received: by 2002:a05:6830:20cf:b0:6dd:dd86:ad9c with SMTP id z15-20020a05683020cf00b006dddd86ad9cmr1533354otq.76.1705628349375;
        Thu, 18 Jan 2024 17:39:09 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id 200-20020a6302d1000000b005bdbe9a597fsm2242965pgc.57.2024.01.18.17.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:39:08 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 2/2] t0024: style fix
Date: Fri, 19 Jan 2024 07:06:32 +0530
Message-ID: <20240119013745.2476045-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119013745.2476045-1-shyamthakkar001@gmail.com>
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
 <20240119013745.2476045-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t0024 has multiple command invocations on a single line, which
goes against the style described in CodingGuidelines, thus fix
that.

Also, use the -C flag to give the destination when using $TAR,
therefore, not requiring a subshell.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index fa4da7c2b3..9967a646d1 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -20,7 +20,8 @@ test_expect_success setup '
 test_expect_success 'tar archive' '
 
 	git archive --format=tar HEAD >test.tar &&
-	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
+	mkdir untarred &&
+	"$TAR" Cxf untarred test.tar &&
 
 	test_cmp sample untarred/sample
 
@@ -30,7 +31,11 @@ test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
-	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
+	mkdir unzipped &&
+	(
+		cd unzipped &&
+		"$GIT_UNZIP" ../test.zip
+	) &&
 
 	test_cmp sample unzipped/sample
 
-- 
2.43.0

