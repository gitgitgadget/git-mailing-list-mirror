Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8C15958A
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686654; cv=none; b=BuTZgkswWGM7ixI1avd2bIlCToZaiO7/2hXCfw+TfJ6BFLmIt+ItUWBbql4QSIaxCzUv5lgz1sIrl+l+xdG2E4mRxNfhPFiLbYoOfRjOkYEtc/UpUUGblOVWLzYeUAYnl3oP1CQNcN+Fzw+f1n/uoTgdmpFXw2CmZI6QnU8kzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686654; c=relaxed/simple;
	bh=dsalWAx03TwmHNKuDDxxXM6DZF3G7lGrB7wXLyX6BuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjGs3oPluZz4B2fXe8QCAvRdrojpifBulrvRoX809FLrNDb4Pl94RujR1Il7ZZQeaOaPgikGT/mwbKgaMgX3xsb2P84WznhFmmQiL23Ri7bMDYwTnHsSzojiyjbcSqbdWChAWL9AR3dItqaTXXX0BG5ekorMFHXIRN94JNEAB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmzUDd+R; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmzUDd+R"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso624065e87.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686651; x=1721291451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JHGziRgakNVZ5DwXy91iJK9uggV/+EZQns1CJL4VNw=;
        b=VmzUDd+R+CmJvltfM/O7AaV61sT64QQuNuK363RyaCRbUwwuthavn0lH97ARb5GPYv
         /sa+ZR6xQhaMSpMHvHnYNfB4ud/14+Hvpw7gd/xa7XrvfaDGxc2o7dQE9uuLESFujkC7
         CV5TONrjiXGIXscFpvxijTQU5s9woZqyMizQdmLvl8l9otgxjTZmm6RlsxOMccvdpg8w
         mJ6B7cG9YvVJWdF1W8kLEhrdmxCLfwAXtaGG88BbqfabkEfdN7CExOxR9genhPZkZbtp
         hprFH43FjrbcpcVj7gZ5fZQvag+05SjUSozLZj4O22NlGlZQ5E61MSf/w5CrOTiosKW2
         uBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686651; x=1721291451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JHGziRgakNVZ5DwXy91iJK9uggV/+EZQns1CJL4VNw=;
        b=bUfCh0jJ+vlwq4la1F+jnIf9B2OXDJbxb/vdPGk0qa7U5qldXTYnNqoh5Y9PrIAnvg
         1aS+7PKxrwTBkCr7pQ4nbwYVR0xvBqz95hQpI5Ic3AFMot5410T3/XQ/Agd5D2b0ixYa
         Mj3UlBgViexgd7DTuR493t0+4VmEG/FKWLdaWBBETdnjGI5CFB+GEbZ+bW8uRlSSxWae
         Rlp1f0kDRNqRGNVGR73YT0i4wRlaqY2/4Tk8EbAA6vOYu1vlREROQ6EMMjYfITjD1FWc
         0cE36HUF/yZjUd8vjM3bQPbWfKEux5H3wJYMtmmRHOEnrdF7hA2sZL/c7RgNvDmCWzAv
         uKZA==
X-Forwarded-Encrypted: i=1; AJvYcCXre/wVgwQNoICYGVZ3mzWJEt2zWovi8SH7XSHrsR5l7c5CISk8dSFNSMSodOEvQDkNZVVLRrytC91nIKtMKFBFFdQl
X-Gm-Message-State: AOJu0YxYFIDafohPD4iq+5d4N5WssHk4GmntuYXJBI5b6E1J6UplNKic
	KscenRzs9simhxiQ/k1chkqw5SJsxN1LG2y8qJsQ12RCvFyAkwix
X-Google-Smtp-Source: AGHT+IEipRBLBbBPAPaSRkGUZgPBXcZsTL3hjd4VmZUJie00718QNJNQyb0XUAa+8F+6oVf7/RHdTA==
X-Received: by 2002:a05:6512:3f14:b0:52c:df55:e11a with SMTP id 2adb3069b0e04-52eb9990a43mr6197014e87.9.1720686650820;
        Thu, 11 Jul 2024 01:30:50 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 4/8] clang-format: replace deprecated option with 'SpacesInParens'
Date: Thu, 11 Jul 2024 10:30:39 +0200
Message-ID: <20240711083043.1732288-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated options 'SpacesInParentheses' and
'SpaceInEmptyParentheses' with the newer 'SpacesInParens' option. The
usage is the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.clang-format b/.clang-format
index 4c9751a9db..914254a29b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -134,8 +134,6 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
-# Don't insert spaces inside empty '()'
-SpaceInEmptyParentheses: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
@@ -149,9 +147,10 @@ SpacesInCStyleCastParentheses: false
 # var arr = [1, 2, 3];    not    var arr = [ 1, 2, 3 ];
 SpacesInContainerLiterals: false
 
-# Don't insert spaces after '(' or before ')'
-# f(arg);    not    f( arg );
-SpacesInParentheses: false
+SpacesInParens: Custom
+SpacesInParensOptions:
+  # Don't insert spaces inside empty '()'
+  InEmptyParentheses: false
 
 # Don't insert spaces after '[' or before ']'
 # int a[5];    not    int a[ 5 ];
-- 
2.45.1

