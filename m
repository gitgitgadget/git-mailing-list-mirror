Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E31DDC30
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891385; cv=none; b=WPq2HxfghD7yzfLsSkNYqRSriMSOnH08bqzNwaQOAAXIE1tSFqXxeHfICG7voedJHDyDFxV6wsjBLmQRCJI6iQcSJ62rz3VC7EhIIvxeFU20yNinqW/mte2mSfTFSvgKzR4gdpS9dbNfypUNQwaaZ7IPVBGwloWJPaV6onJHI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891385; c=relaxed/simple;
	bh=L4lxolB2tYaHNy7VDTe/eONuYsbby63x2s2HxKaWjHM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nfqrjDJtK6tl6qzQNvx9WtOJIsNsaBOssUdq+MY33qKP74DGH/eL2qk7cSRd3UL4z7+5EIm2f9fOqzWpY4xkuxMolgjgu3h7Jlc3zSF1rkSXLy4Hk5RUjtICbTwJNJ9JqdyyE3MoGL2+nl15HTvIxLKh9HrJdE74DZlI/rzHW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR73iB0Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR73iB0Y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf257158fso21473335e9.2
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891382; x=1744496182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=fR73iB0Y7ctZXhsAb6m6AnjxraaKkbqrqhVYqh2j+8vWR3NvTuxOrUvz1y/oBjC7H6
         wIs5PplUAwnYMJn9rg+TqNM/ppRDar3CVboJBpUb3gv33CbCXrYBbu6GbJO4/9goomi5
         3Va1CuOXXyOUYiDaqXvoEungfTViPurAE9O/DiF6udLcr1xP58TOeRtFNesc9xySuFUt
         rMGSSN93dToq8GRGfdmFoeLZxI4SnTiCqklplqYlfDs2T6LNt3sqMrS9yMDy00QGMvnR
         UjUGctuyf6QwxMF+cjeZUatf34Ghc2BLIRFH6G1R8Vwi4CD9cYGNxvsZ54IFXIr7Tf1l
         f0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891382; x=1744496182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=WDC+RUzmUcCwGq+VQC9GYCk+zyTPngNFlQRMPVtH+u4n1L3+FCypWjO5bHF5IvAjUo
         K59/VtzoqwFofjLdby4rNrEb8AY2okNTozHiGHb/s0GpcTqIyapQ7KvFuLNfDebVnlKH
         1WatFybZETvSflAxDMAFBnzD+Bh0jPhyqSo5qHpQQrj4VMRBYr6fEiFrmbudCAsCVuK8
         +s/zStbZgdgYWmRbRqk0bUOxOBB9/IhlffNiISEPU7sihFVbLCiTV04uImO0uDTotk2w
         59CVvc/2jvhg0s2MWbdr9dN2CAIQ72MAhx9gt+m9g3iY53xiJkMPAdA2+bgrBSw5wnRV
         gKOg==
X-Gm-Message-State: AOJu0YyorJGcYAyDX5q4rTqXTRfSJgGXPpVyrGS9Sy2YyqskYqetDcm+
	Y4ziYQy+A4zdKBHCTq0Rojv9l2mFhHQJ1caXjFzhRPH48O2XJxST6XsklA==
X-Gm-Gg: ASbGncuGe0lGBaHIXqJ4km/H9uMX1bzgFAACOk6Z4zt0eKf5XKjIi92VU4fG9zGwfK4
	C/UYP1mLGzrIMGM01mT5B2blTtFoodY0NmOYifqxediG/7ZHhBLHa3rRhvOyHsFOK9dONVT+iTh
	oW7UznOndcJ3uxP09TAjurhGduxrrcNt2u5ZH49uXpQKm4OdxVyDGqslnH1WNvB1Syc7cRM7q1l
	pB2udC/g2dwE/FaFIn9lKBcvrVMghhXjIVSjO6GsRt3tZ+qCJXjyeR6RR8etR2l7mcvVxlGnfUw
	bhogv+bd4NlkCHaSSOv5C6WAMUpw54Tb/GVygkAEwdbmSFJNO76eoiqc
X-Google-Smtp-Source: AGHT+IF5RzRcOGerosnz93+aLH/+3bdLj74izOj/w8Tk67rFgmRgGMoP7NoOx3VPfLQgU5PmpT2pVg==
X-Received: by 2002:a05:600c:3586:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43ecf86a99emr76908525e9.13.1743891381488;
        Sat, 05 Apr 2025 15:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b18easm86678845e9.38.2025.04.05.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:20 -0700 (PDT)
Message-Id: <6203589ac17be5571a175e92326f688c118313db.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:10 +0000
Subject: [PATCH v2 4/8] sequencer: switch non-recursive merges over to ort
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The do_recursive_merge() function, which is somewhat misleadingly named
since its purpose in life is to do a *non*-recursive merge, had code to
allow either using the recursive or ort backends.  The default has been
ort for a very long time, let's just remove the code path for allowing
the recursive backend to be selected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..b5d91fd3515 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -781,28 +781,19 @@ static int do_recursive_merge(struct repository *r,
 	for (i = 0; i < opts->xopts.nr; i++)
 		parse_merge_opt(&o, opts->xopts.v[i]);
 
-	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
-		memset(&result, 0, sizeof(result));
-		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
-					    &result);
-		show_output = !is_rebase_i(opts) || !result.clean;
-		/*
-		 * TODO: merge_switch_to_result will update index/working tree;
-		 * we only really want to do that if !result.clean || this is
-		 * the final patch to be picked.  But determining this is the
-		 * final patch would take some work, and "head_tree" would need
-		 * to be replace with the tree the index matched before we
-		 * started doing any picks.
-		 */
-		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
-		clean = result.clean;
-	} else {
-		ensure_full_index(r->index);
-		clean = merge_trees(&o, head_tree, next_tree, base_tree);
-		if (is_rebase_i(opts) && clean <= 0)
-			fputs(o.obuf.buf, stdout);
-		strbuf_release(&o.obuf);
-	}
+	memset(&result, 0, sizeof(result));
+	merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree, &result);
+	show_output = !is_rebase_i(opts) || !result.clean;
+	/*
+	 * TODO: merge_switch_to_result will update index/working tree;
+	 * we only really want to do that if !result.clean || this is
+	 * the final patch to be picked.  But determining this is the
+	 * final patch would take some work, and "head_tree" would need
+	 * to be replace with the tree the index matched before we
+	 * started doing any picks.
+	 */
+	merge_switch_to_result(&o, head_tree, &result, 1, show_output);
+	clean = result.clean;
 	if (clean < 0) {
 		rollback_lock_file(&index_lock);
 		return clean;
-- 
gitgitgadget

