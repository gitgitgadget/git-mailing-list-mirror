Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B22D238A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261507; cv=none; b=CcTOfVxs7Az+QFu36ZQTpXf+SH4zGEsSsQAAnqug7gEfRRqm8Y/lHg+ZQmis9dNdRtY8AzIWlEgoHsCWalnOfrjmXfVnZwjF5e0izZsrU6aq1qbL1MPHu6J/nVn0P3k2P7EbGuCUIiNSqGdJ3baa8BRrQ8C8Ml7xr8cIqOHXm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261507; c=relaxed/simple;
	bh=sGAMB63tSY1wtW3cveGhrofrrl8vdCu7EEaHRbCCMBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhGMO5uPZHorWmS0F7M7zlijn/jIE0ozr85xA2HMnpXMWaxG4zZEdaKtGfUOy5kx/pfzDjm1ukBpLj5DzQJRYh4B4gLLG2AoU9dHi+HZjBef+cK76XvcUcqH/Kennyiglxz1rCmWKu5CRchw9UPPDd2wBQ4JnX5xhv/nYtaP4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=RaFp/tK5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="RaFp/tK5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-790948758c1so70458837b3.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768261504; x=1768866304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Givl1UgTqGELS1TbiHO0WkzJMa7/nIQ1ueE1vTv2GqI=;
        b=RaFp/tK5uzCAuvFGhU9og28wWptuegOCTxOk8olxiw0ikuspzacED4zzjOBWTQIRG+
         FCSg4IddA8qDmkkjaWBcmHOAT6aCh+I2sxFDKx2LS9hLVo90HMzEcISCw/YVDff78KYA
         4Lb9antPKfhSAB+9qap/1/pF9rrxPShOmTzvDoQWpnOzYRnMNqlOrvQFPpvnUMkRi+fG
         cCWJ52v0i+f6biI/Nf1Kkcm1e8cUbA69g5pKHpSQRCSHTpYqeORmJERLIx9C0rIQqs5x
         Gqk4UkxP1KN1PLGzNVsbp3jd6ziOHx/su0+XbYU303Ockzz/JMxGfqg010x/53zcvH7i
         wILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261504; x=1768866304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Givl1UgTqGELS1TbiHO0WkzJMa7/nIQ1ueE1vTv2GqI=;
        b=LMf1MJFk49X3wSEDekHwFEQHRJmlfFr06yt7G1j7p7smPA1P1XAok6OS2gpmaDBuWz
         6/e8LQZlQ8jbywc24qHDvKkoJlJm65UjQeAMPNI97g0Gbzvd12bZ3U6EU6Slrhg2E63/
         IDLuenIsIxVmCqZAA7vUXmxsHT4KFAe3KyYzP/D+3yZlkWciga8g4XiVzPhHen6iOYEn
         LizjS26N/XMRoaqaito8rN5JZ7Z+zu3DZF5trn7eQB9MKtjyiI/vjcNurp2SNFwO5O5x
         Qa41+eAf6YFcpEO4KpptEDNs3xXCLdyTR4LyrIM2RaxyUKokGbN+kNVUkicawydmbFZO
         riQg==
X-Gm-Message-State: AOJu0YxDaJ/OVN9PoAH//f2scjdeFjpkHDGW928HwIV4sNjqwwftiso8
	+onxBH+7CmNGFGPso5NNmFfcgQLWYvBDrICqY+c3EgwsdAUi1JRhtmtgyHf2/Of1bHPrB+NlX55
	TiAFBQelyCg==
X-Gm-Gg: AY/fxX5Wq6s87u4kYBgHOyqD9oTWplCHYCQBwsIuLoNy4bB8Y0q+FqsriYuDedDhpqi
	4XtTG0wfQpnyZQ7km4+HySY4rwWSEu+M9UvNmpL64517Bpjt6HmJlvmd48MWt/nC0dQFbBiVZo1
	d9q8AoRzC6wATQ+Yima/rD7Joaju0UzEZfOcmnjPmqF+OhAkfAUX7xUnajahL2Juq4WcPgrIb++
	4JchTCeIlgP0qi/1KJDwPWp5c9A1DMpyhCsvZUiHUbaxCM2zEPJMEB4Mn9Or9os1expCKNv23Xs
	lk8HcncAhwRK2fGWr6ejCSLGkajdwDhO9W8x5rxZqpcRvOgsbiRQjcC6PYy+2LpHtoMpe6+pcxx
	YBcumClnAKRpDrKtA/J3Vtvc7D+iJnf8BkPppjezH5TTR5PsCKg0vm4/kcsTSMvUUfRQ+s/ztKy
	HWs33KqQZlAfR6oLIbc8W/T0DPp6yMJOJuzS5UlcT4/uhxc8MGYK0Z1evfZG5CWH16ZSl04bZuZ
	a09MCVpI9LvzG5wJEQlvBfBZg+S
X-Google-Smtp-Source: AGHT+IGQPkUHZO9z5hGr2UqgDy/LDoAsvzfKYEn9VfynAx1zyzf7Ws86xYadLLxpKz2Nv6KzaaYQDQ==
X-Received: by 2002:a53:e042:0:b0:644:39d9:8c39 with SMTP id 956f58d0204a3-64716c909f9mr11154989d50.84.1768261504380;
        Mon, 12 Jan 2026 15:45:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2573sm8602872d50.21.2026.01.12.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:45:04 -0800 (PST)
Date: Mon, 12 Jan 2026 18:45:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t/t5319-multi-pack-index.sh: drop early 'test_done'
Message-ID: <9c5faa5932cdd9e570406bc85ba27f94195a4d3d.1768261435.git.me@ttaylorr.com>
References: <cover.1768261435.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768261435.git.me@ttaylorr.com>

In 6ce9d558ced (midx-write: skip rewriting MIDX with `--stdin-packs`
unless needed, 2025-12-10), an extra 'test_done' was added, causing the
test script to finish before having run all of its tests.

Dropping this extraneous 'test_done' exposes a bug from commit
6ce9d558ced that causes a subsequent test to fail. Mark that test with a
'test_expect_failure' for now, and the subsequent commit will explain
and fix the bug.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 794f8b5ab4e..b6622849db7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -415,8 +415,6 @@ test_expect_success 'up-to-date multi-pack-index is retained' '
 	)
 '
 
-test_done
-
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
@@ -565,7 +563,7 @@ test_expect_success 'git fsck suppresses MIDX output with --no-progress' '
 	! grep "Verifying object offsets" err
 '
 
-test_expect_success 'corrupt MIDX is not reused' '
+test_expect_failure 'corrupt MIDX is not reused' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" &&
 	git multi-pack-index write 2>err &&
-- 
2.52.0.437.gcc6f76a88cd

