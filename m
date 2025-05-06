Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3D27FD52
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549639; cv=none; b=RJyNknbjMQ+EfnUieDzLYzD1roG80rHBdvr5zf/HP4AYV/8ZUSAd0mUFHKcX5bg1VsHWxu8gi/1szDsBerpoMHaHZV93BRBkbECfboImY7GwRntPb7onv9S+U2gvBUQ13yaYgpy8Tp/lP7AroWwJLjvqtTfMq5QxMxWbgX0J5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549639; c=relaxed/simple;
	bh=FW8phX77BveW7DmBEJzIF5Gpz4MHQcSDXCeUklJyNco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akzdIM8dhWxcOAR3YNzefYZRWXr5wa7BCkVSujhQ6dqHL+kOyCAz2zD0mR+15P3bX5RFm8MBvkVMUiLswPvVgaXkHtqrmmO/Lo6T+UY8Sr7fxFnYS11QBDsaLxvZt33lwpAQWwXhYiixCwILVVN2f/kdClDw5s5Q6b9I5lbsYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWr8cVyq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWr8cVyq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso6322109b3a.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549637; x=1747154437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaJl+2LKPp08Xe4xefzmtDJ+no6VSTIcrYxLTOVHamk=;
        b=FWr8cVyqM6Fz1+LxEUTK6kFTJBT3tIKYgkQl6ErzH8sgtF+p2ffCRmr6QAOIVxMr6B
         lxBYWxX0T4KSvGscutt9txs/N+Wau5eKhRKeX2jUgVaQkzceEtKm83uEmmeWvKPibXNi
         TCx3Uq+UclOfkEFzeKr5IBtqGTAz1w3weiemfZm69cBKeiYG5PUGGTblMk2Hx/aVhv76
         e5RA/+cEgH0pGWNvrLslm5M0/U+5ckvmgAINliw3CD+epSY3O0X7igN2R8m2gX2fefEy
         2TJVAoDg35cG4bFqiUQe8uN2F6fy23BqF9WnG0dmZzQQun8UCxvQbuz4UKiXBq5SH5WO
         25jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549637; x=1747154437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaJl+2LKPp08Xe4xefzmtDJ+no6VSTIcrYxLTOVHamk=;
        b=kccB9rjzC9PoGNT7ivqlhoNnJzXBwj7z3V161XlQ0bfS9DzGJtYRSRHeaRp6/EQhJ5
         XK1JZJTl8s9lh5kLR5kyHR/oecNvh+TgTOEcZQ77TqObCjAEwPjIdnbtB0XCVbSB48om
         YJQ4IYKD86qKSstAbSSM0pGGg0iMu0oTGidLVTn5Q/45bIjleA9bNxz/nyRK3e/vebnC
         RcEq1mjXlj3mbAK/egaEuXOc17ksK1Tofu9DgeSpIl1rQhhvjz9Z22W3V/IfDlxiscHS
         2qfTGK/tovkkd+q7nm6rM0YYmTSyQjukMvdcc7VngQBuDbxImkr+ZtiD287HZnWVd5ls
         QQcA==
X-Gm-Message-State: AOJu0YwJ2vfMRypdGfQBUWWk17ui61r9lNmM5a2JtORJwBLJjO7EPIKF
	O5eQDdAp65pfMM3k7mE8Q5gVJjyeDnvvwgxIryVqNU4/1yu4OXs2iKyRydub
X-Gm-Gg: ASbGncvf+iIGTj7Jstro8qv0/mbAsaonv0MUIB/Iwyd81M0mimTwR4WQLOc3jMUz0nn
	1p+dqOTc3DvqZrjut5UCB6KM/L1EToljDws9Vo9Whg8AFt2kSW6hWJXMkT9pD/1O00pDFngW4T4
	rfz6uSiIP00VIvraHywdhnUb3OY0gVWC9vnEKkbcXiLpTOikolQXp9J4nMIGd9ST6OFsAtP16s0
	r/03ufa8oWDGdDb81/+1m8na2GEz5GhlFyFYUMzoPpGPK+5j+NdoYXIj/uzlQLGXLlOq/rFacU3
	W+Lc4B8NNq+OvCkkqJVnu5PD55+cvfkL5WqL6FUkurQ62gw=
X-Google-Smtp-Source: AGHT+IGYiMbIekphlLc/OU16nGA1H9lpOU/6pg/uqkQOpWGilSgwYNN74VR4KuOLdF9Ox3o5Pn1Gsg==
X-Received: by 2002:a05:6a00:f0b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-7409ba00eaamr463369b3a.4.1746549636690;
        Tue, 06 May 2025 09:40:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-740590207e3sm9430971b3a.94.2025.05.06.09.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:40:35 -0700 (PDT)
Date: Wed, 7 May 2025 00:41:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/4] packed-backend: skip checking consistency of empty
 packed-refs file
Message-ID: <aBo7nBOl18WWYIsA@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBo7OiCKHTyT4DzH@ArchLinux>

In "load_contents", when the "packed-refs" is empty, we will just return
the snapshot. However, we would report an error to the user when
checking the consistency of the empty "packed-refs".

We should align with the runtime behavior. As what "load_contents" does,
let's check whether the file size is zero and if so, we will skip
checking the consistency and simply return.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    |  3 +++
 t/t0602-reffiles-fsck.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3ad1ed0787..0dd6c6677b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2103,6 +2103,9 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!st.st_size)
+		goto cleanup;
+
 	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
 		ret = error_errno(_("unable to read '%s'"), refs->path);
 		goto cleanup;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9d1dc2144c..0a9e9ccc55 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -647,6 +647,19 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'empty packed-refs should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		touch .git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success 'packed-refs header should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

