Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418D2749F2
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762034261; cv=none; b=bXZOu8vnHjFHxd6slJkdhqpyjLmQ7pRbWWbetsc1flaPRDpazqkxn1O6RrQnzrzb1kaz4WeoOFbNaRxI3vKj7pWJCzfADjccAxtFRFom5KQP0X1x9iWGIUo0epH/q98xmLd/e9Pr+N1E11p5/5tEW51+ObVq+wR2+96W0Lw8trQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762034261; c=relaxed/simple;
	bh=umP8Xttt2i0w5mytegOPtCF6mncpmH8Q3T0A2P6b57M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZjhFuwtNC9nFI0Z8aa0p0EwDM+n0E9IQb0Tbk5EPrG8fSXoIRLnxV3NOjm4FbOJiwiBAVeOwKInuxOBLKJF8zQfDC4/naEoe/Vs2bYM+n/FEHgiTXNXMSvXaiTCuw5c0iXmXx9VVF0lu9RYRzLZngL6wnwmNKEau5LzME9v6e+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbZhmM7w; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbZhmM7w"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4330d78f935so19074615ab.2
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762034259; x=1762639059; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovjc0x6hy6GDLiO0T8l+I3/dxbdgB3kEwMVSxZbqjNA=;
        b=IbZhmM7wylfoOgWsR8+ulpoGTPT8tXDcI/k43VCbwxrbkx71lX3s5Wl/CE2bbfeIzC
         HxYproiqaz8EjbTAHp1rx6K9IoONCsikeXsSqVGvjUiWmCYUYMVvOGWwRj6W6wHeBl7w
         No0kyxHLPxCHJINkJxEA3/UknVklpXjpVvkpRrzaqqu2moYu5QU40fOSjTzh15wUR169
         vtG9AzUSW4sUwbvdaUKyDmt8XdfkfAfVQYpJ8tAkP09MU/UsLDRfnb94z9WuePIOUE0U
         cr7r5EnHfPse6OGhhh2rxeUCvoG/oKYFnjYmJUKRfQDIW3ilD0hr/rN8/i0tw0Lq7PS1
         8mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762034259; x=1762639059;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovjc0x6hy6GDLiO0T8l+I3/dxbdgB3kEwMVSxZbqjNA=;
        b=r3auaAp+KT2oPPjizK5cdoufYE7F6eMx6GNbAnRZmMBO2gWe5O99Ra986eodolCwGh
         E9Dn9kUT+mmsXp3oQa90tNoY7bYvREwwMXXwVehgooYX8V4/kRlNRBj1eC7uyseMy+AO
         PPwTvORHCHcTS6KCLe0DgehrPdJTBlK55DhsGSzJr+JbJBbd9I2SthqRvH+SOrqdqsef
         Hu4xWBmiTA8r44L1glLr79RcebO7lP7ZVri6ib7WTRnArQcxVlwYniYXSZUyEIudNv7I
         ipH4GQgIaQrkJmxqogNVC6h7Aw+UD0q7v8dAA/87SwhIFbsrAEaSEnVBxjaA3lgCLsKd
         1UjQ==
X-Gm-Message-State: AOJu0Yxh6jDHornRqKGUnT8bp6Nn4MjsEz+9raO6vmJVX6HTlEDycHRJ
	S60cICJgcwidfAgkGMNTcUsXwZM6JPtH0FPn8zWdtt12llSj27IxGMMl4T9eyg==
X-Gm-Gg: ASbGnct3jvU4XYRGGuIVOQZMlN4WVeKqMYUIaVDtcJvKejBLOjMn+MTs0KzVp3TqFsB
	Mnw4iROfSg+WGF+iQLRiaBGbKZa7tzgPltPxkB9x9pdUUDeFeCQzRXTO17DKDqKD7T81geKP75E
	uOaYPllCX2GQAsoKz2Ra18Aa5KNMgr5YZWeVipjicg9sMUbFuY8HwVrn0U5PoOgn5iHG4eLCzQS
	dlxMfLJIBxR5Lz0rldTO15m4iaHLUOG5xc+63ERBfCmtqy6oFGV3NNJpkzEOVyRUAq3dcUjx3HH
	tomtIKG2Z94A5yvHmDA8dagQ45b1zRFpeSfyrLKAg0LBaKSpCC+61S1St8EcdirrbiS0YyG85IL
	PnPotksm/3+8h+i8C5dhWEE2Dh5eJ9Alm2iMTDaRlsuB0dkb70Dk0ziDu7TupbZr2qvmi8pxt2G
	bfIKCGhYV9g2+P
X-Google-Smtp-Source: AGHT+IEXDSkhtfiohBS0WhKsU8f29ME0ksi/6LnHFQbiKCT77AtfHaU8tkpZ3edyEbolnymqOOJA3Q==
X-Received: by 2002:a05:6e02:1608:b0:433:283c:bab with SMTP id e9e14a558f8ab-433283c0cbdmr13579795ab.19.1762034258795;
        Sat, 01 Nov 2025 14:57:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.96])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a615e5f3sm2070673173.61.2025.11.01.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 14:57:37 -0700 (PDT)
Message-Id: <e81a5d2bd23add19e04184f6b37910bc89a514a5.1762034252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
	<pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Nov 2025 21:57:31 +0000
Subject: [PATCH v4 1/2] xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The XDF_DIFF_ALGORITHM_MASK bit mask only includes bits for the patience
and histogram diffs, not for the minimal one. This means that when
reseting the diff algorithm to the default one, one needs to separately
clear the bit for the minimal diff. There are places in the code that fail
to do that: merge-ort.c and builtin/merge-file.c.

Add the XDF_NEED_MINIMAL bit to the bit mask, and remove the separate
clearing of this bit in the places where it hasn't been forgotten.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
 diff.c        | 2 --
 merge-ort.c   | 2 --
 xdiff/xdiff.h | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..6ce3591c5b 100644
--- a/diff.c
+++ b/diff.c
@@ -3526,8 +3526,6 @@ static int set_diff_algorithm(struct diff_options *opts,
 	if (value < 0)
 		return -1;
 
-	/* clear out previous settings */
-	DIFF_XDL_CLR(opts, NEED_MINIMAL);
 	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 	opts->xdl_opts |= value;
 
diff --git a/merge-ort.c b/merge-ort.c
index 29858074f9..9b2b0fce7e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5495,8 +5495,6 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 		long value = parse_algorithm_value(arg);
 		if (value < 0)
 			return -1;
-		/* clear out previous settings */
-		DIFF_XDL_CLR(opt, NEED_MINIMAL);
 		opt->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 		opt->xdl_opts |= value;
 	}
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2cecde5afe..dc370712e9 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -43,7 +43,7 @@ extern "C" {
 
 #define XDF_PATIENCE_DIFF (1 << 14)
 #define XDF_HISTOGRAM_DIFF (1 << 15)
-#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
+#define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF | XDF_NEED_MINIMAL)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
 #define XDF_INDENT_HEURISTIC (1 << 23)
-- 
gitgitgadget

