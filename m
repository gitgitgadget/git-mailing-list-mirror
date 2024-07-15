Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF6187547
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035861; cv=none; b=uI4FA7UnCSlVS1ehLjLW+VElvOjGdO4j4r6OJ09jgK2NWDaydztsn+lYXs/mqtbCqRJ3jQKhagyEkDvt1EbmZ6JtfxHT+1TKCSPW9IdHNaMxd7EzQtXM86ygyZKVDiKsHEwobKUa5add5d1HjmX1DM8FZgPBPMe0Hu9LspWim4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035861; c=relaxed/simple;
	bh=VVCxXD2hxorjLBe9Co7S05O/TjJtj1HOFXn3xB6ZwhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkNaahdk4cxI+q2aPQA1zSl7LRRITvwINDPXMPIquRra+1ATrIV5vwtzn94LYGMt1+bXRthc/kRbABe6v40vIVeugLDtEHT2ATbSRvYUE7L3jCl2wpTJYXhjoHWPitD2mdzMw7fpq+g7bRZiJpZQCj9O3qKLVB2c45qSWh2v2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACe8WaF6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACe8WaF6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36798779d75so3609971f8f.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035858; x=1721640658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZRZYfl2KGV+PSxMIaK6VpG3xzcTlVcXvPjDnYD2/PY=;
        b=ACe8WaF64BTQVvlGIcd0bhLyn5NV95qbYZZs4E6tl5ZEQekIz6IZiYnO4xW4fel/0Z
         Y9Bm3OZrK6uol7FuTuKLOHZUI+H8Ii9+9Ooujg0tieVh1f3z0iFeanSkNJMylqK5Smrr
         KK0YjYD+74SZqWV9tHbLbgp+K9fcKv6zrLNzmCX+h3NgXfA9bmOSBGXOQBRT/R3U9cOa
         lJUsA/319xt8UNm72w8llgF2SN+y+uxyGC3XseYhuuyuYIVplZnzL+jvSDKYrCWKy5RP
         il/GTLKVPPwfKgM2uUDABoWVHqXjLvZ7ZXPmk4ldHWXJDCzL0mM39TpVXicOfwWKqM51
         ExWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035858; x=1721640658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZRZYfl2KGV+PSxMIaK6VpG3xzcTlVcXvPjDnYD2/PY=;
        b=TRXtlCx0BcMZrowpnQHBp7931NSSUTpPuGYOQVTd2yGkmHaA2bm8ARyf7iJN2LZBO/
         L9i8ovGkMedVs2pV7V8i8GxtbKGe+hUdXlzHaVs4KwntesvLVy1+55PgnO0yE0Qef8ZB
         vO8YqaTbNQ8Lfyy3DJcNDthn8CKAxTJewflh2zPW/9tzYpzHlU2iHPg4JPHiap1Lq7DV
         KhV/sjxzdQRC6A9un+LPkTCpnR0/5XYmHgQKmzTSFWlr5VKKm0qJQlmmM57BdlVjYxWy
         zUXMQFl463NJ8ld2aYv5e7xBFA/mO4v1pP8eF+x4GMbkJrdnO8MAlNQeZm5AjaWnFbhv
         9q6g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQJX+AHrL4k8PcZ7D/c6UNtPC+XBAbvira7MUgq2mQB28Bew2/Q2EUHzA2FyJjnsSBe7zHavUoSgsmzDXza+khNar
X-Gm-Message-State: AOJu0Yx8AV8qrJZq/r1OscKcPxdubVbOZsYRZc6ljxo0/bGsaI9a86ri
	w8EJVgkQzsR/3+JHCGa1uSERb452ZiasXXR1GRNj0Srx4Z4b2TUapBVZJC9L
X-Google-Smtp-Source: AGHT+IGHDXBioTc9AGnGVqYVHilflgc6RT/4GdTGFQhce8dliGFgIsg+Fqkeq3P1v10LrceTy50Y2A==
X-Received: by 2002:adf:f803:0:b0:35f:16c9:a5bd with SMTP id ffacd0b85a97d-367cea73618mr15411425f8f.23.1721035857988;
        Mon, 15 Jul 2024 02:30:57 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
Date: Mon, 15 Jul 2024 11:30:47 +0200
Message-ID: <20240715093047.49321-9-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For 'clang-format' setting  'RemoveBracesLLVM' to 'true', adds a check
to ensure we avoid curly braces for single-statement bodies in
conditional blocks.

However, the option does come with two warnings [1]:

    This option will be renamed and expanded to support other styles.

and

    Setting this option to true could lead to incorrect code formatting
    due to clang-format’s lack of complete semantic information. As
    such, extra care should be taken to review code changes made by
    this option.

The latter seems to be of concern. While we want to experiment with the
rule, adding it to the in-tree '.clang-format' could affect end-users.
Let's only add it to the CI jobs for now. With time, we can evaluate
its efficacy and decide if we want to add it to '.clang-format' or
retract it entirely.

A more ideal solution would be if 'clang-format' allowed us to append
rules to the existing '.clang-format' when invoked. But such an option
does not exist. Since modifying the in-tree '.clang-format' is only done
on the CI job for style-check and doesn't affect any other jobs and is
not persisted in any ways, this hack should be okay.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ci/run-style-check.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 76dd37d22b..16b593fa1b 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,4 +5,17 @@
 
 baseCommit=$1
 
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+#
+# As this rule comes with a warning [1], we want to experiment with it
+# before adding it in-tree. since the CI job for the style check is allowed
+# to fail, appending the rule here allows us to validate its efficacy.
+# While also ensuring that end-users are not affected directly.
+#
+# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
+echo "RemoveBracesLLVM: true" >>.clang-format
+
 git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.2

