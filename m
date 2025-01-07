Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B9B78F59
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241590; cv=none; b=t6aLks8PtGKtiT9/m+1dnJO2HqBAtzewH8Jfw11xkbpYRsBImzOAVdETcg0yxmNR85iuEIKUCg9UgZsd8HgRbqTfuKpwAuEO9zUU513qqtoihH46389w9ZK4fP6SyBfRZwM/EcGsFnDY4ILTYbBc/TB8V+dAfFBj/kSOExAvueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241590; c=relaxed/simple;
	bh=NkoQK+QCii+rnf3QfZutXuehA9HqA183Ya+CcE0e8+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx0AvkY3FbeT9myCNsZsRLvMxnZ6YSDTJJoBO2u1nUfLd/v6YU2wdvMV+fi4nslHbCENmTkIAwdOF/VZkCeuJUnMwstu78R0uwD6Tqd6vRtdXci6Shzi/mtkYboSd6EJ3WKCg73zWhzOYLTP/+S535Uib/nyTGVvL9DUuR6+kS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgnk4xJX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgnk4xJX"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaef00ab172so1721907066b.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736241585; x=1736846385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsDSC77s2YXZmScy1C1PkLpjbOKPlvmfcgE0bfl0HdE=;
        b=Tgnk4xJXKDWmI3iqsCkeVYVq8zU3Ewu3pRWuwzRvj31emI0MhLcTXMP2tM9t8EHf7v
         b1y43JDgnpQUMCxabt+c+SnVGNFGamcpn9cK8oJ5WuPUAAnH/tTtE1x9r7F/aboh7our
         cPC2wHBvXgLRE5MoBoynbRM1fmj6Yj9DRtduYyQhwpoXPBur3X10uuSYqIyDjFqfc+1z
         m1EDsgrkNg/K9iOvZ35mgXhneKnRgrcDM6y2FCsZslaEb+rGZ0wj8LT2F+rJLxA5F/ZJ
         P5wuT7TrsHsXyxPyJK7wbtB30lHDvAWfjVdJ2eu08S60rpaN4hDQgGN1ija5lgXi+dRa
         1iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241585; x=1736846385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsDSC77s2YXZmScy1C1PkLpjbOKPlvmfcgE0bfl0HdE=;
        b=YzGaDIPljewtyJlPEi95yE0wUmsgBRPr8aU/lkgiTlvaw+MsVMrhSiHXVIiaPxqs3r
         Z2z4gI0OfRBcPf4SQdyE4f8EFu5+CwQJdpqfY/rOSFDTwNIIuiHS9Qh4fZ5jGfCcutS+
         ErIuJvVlSedU3M1je6oC+XVdwz5a4oppxQShnGbq4vJe6Ub/kjWsBgJDcVhFklpTWckq
         QI7blGg/NAuKc8qzHGQ3jPaAT24oHUikDeDMNGWhGMyub11eiaQUbRB/pK2hHNFEwFPr
         bufmpCpjZIiUj3Ptfp3cJY78KT2j8ZTolu0b06XX/iOeHNpsvYw96ryRZzc2e68yjQhp
         dgPQ==
X-Gm-Message-State: AOJu0YzjT6vBIoYSYLPT4m8xbHC/RVC+NmFDisAR2xx+o8xz3+6iWlC+
	l+VAd+p5yykA3Kv4c98EBUrrMHVMmSS5AOEf8X2bkURd9cu4y8wgyS890zqfbgAhXw==
X-Gm-Gg: ASbGnctmjKYrgdsgl/3Y4iQEHNNj5zJnqO09LCS6CFSoUdda5XyUAFSChDmlh1CTw4x
	+NliH+VgoVw82C4xMkDXcAtuscJWrdhwGRtgM1WbLHrKfI16TFpMvGcV1mscHcKs0wBqQM4pF5s
	VM3NqXVLbC7hzXsUQkQ/j/X1lowJGM9HHb1IApMA7SPm0phrf0LSxifZK9RU8VI1Nrbq4fSiF+9
	XXu3AEdC2i7C1ozZ5FFD5Fr/U221uJMIpfoWNHL+GdiPJpSFV5bk3s7b3A4iSYB/CDdNz0=
X-Google-Smtp-Source: AGHT+IG+WyaxmifxfnwLSboMT1d3MZKwZ8AfMdjaG5nXBejkUsildA3w9mookIKpGfhWJ06aQdJLCA==
X-Received: by 2002:a05:6402:2550:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5d81de06532mr149724218a12.24.1736241584823;
        Tue, 07 Jan 2025 01:19:44 -0800 (PST)
Received: from localhost.localdomain ([154.118.62.160])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f06deb8sm2337222566b.190.2025.01.07.01.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:19:44 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/2] t/unit-tests: match functions signature with trailing code
Date: Tue,  7 Jan 2025 10:19:31 +0100
Message-ID: <20250107091932.126673-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250107091932.126673-1-kuforiji98@gmail.com>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `generate-clar-decls.sh` script extracts signatures of test
functions from our unit tests, which will later get used by the clar to
automatically wire up tests. The sed command only matches lines that
ended immediately after `void)`, causing it to miss declarations with
additional content such as comments or annotations.

Relax the regular expression by making it match lines with trailing data
after the function signature. This ensures that all valid function
declarations are captured and formatted as `extern` declarations
regardless of their formatting style, improving the robustness of the
script when parsing `$suite` files.

This will be used in subsequent commits to match and capture the
function signature correctly, regardless of any trailing content.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/generate-clar-decls.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 3b315c64b3..02e45cf0ba 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -14,6 +14,6 @@ do
 	suite_name=$(basename "$suite")
 	suite_name=${suite_name%.c}
 	suite_name=${suite_name#u-}
-	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
+	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\).*/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"
--
2.34.1

