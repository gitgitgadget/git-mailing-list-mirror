Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8A13B7A3
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774206969; cv=none; b=H5P2V71V2RyQap/aFBhd91CIPK2/4DEgxUJBKUIZBTKJBREcDkfn7GfcImKtYzZi1YMLw/RlAQJJ61xWT0PbrvI+xYMy5qJWAkHN/t7HY5W91DU1156nbz9vOiEKIVOr1BIWF1kh1d7wRiAc/AvUZs2XPmD1B+xAqHc3G6sjLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774206969; c=relaxed/simple;
	bh=wjTnzHhxI8ORTiGBq0w1H0TPVA9Id0sPpyYZlu0gd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhnMK+b+x4bidcA3KT9ZZMEo3Uu6BgmzOQBw0l6mXfqF6YgIkrxnwWjeaew/Q9oGEYE6CR5rLy70CjQauqhEUyPGTPlREC0MB2sPBtsGcgDSa6EU47uqQ0lOthMmLJBavi9TGxdsQqLMwVoLKI51LqzB0s8s+bWoxkfVxEv3/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW1mT4Tq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW1mT4Tq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so17462725e9.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774206966; x=1774811766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLZNSzhpvZ8Sty3PZgGyAK7E2oIgq9PkpWVZmENSdUQ=;
        b=EW1mT4TqAy1Os5juVU0w9zCjVShdfOOvV5rfQsdOfzdcoe9FsNRAA8HOIhBavLHpT5
         MqGbElcRAVE+N+vvMXa6gKKW/Ndxmz5f3mRwZDWp+Xv3F/M30xEat5u2LMmk/w4N3F+y
         P93OhVjxQZrHAmHxHx6QcNRzi1Lki+a03DheHbSCwmkD3+c8QAaLQITCqRbCbOY3qQsT
         1dP6sqrVAuZSzSa5dxy7UsD5whwclPC/sg+5G0fazLCDhvLy270Ltkot3ULSUQ9PtUnb
         RZmd09q89sSiJiRrb41vn6BzRLgl+OFh1x65m7u0Kl9sMI0pO3i4ZjkebOSoC6nlOuCn
         I0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774206966; x=1774811766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLZNSzhpvZ8Sty3PZgGyAK7E2oIgq9PkpWVZmENSdUQ=;
        b=P/PuMfIgNXfI2x2khqQyfTkYspx6u0HGFJ4w/hbZqUBpGp8nQ1fTrUy4dRMtSRv14V
         EA+fih1J+gM04xtchLgm6oWfCJP18DRpioqY4j+8qUCRKmcexOhf4HoVFOuoMrLB5tDI
         jcbxA8qmhqwQQDUNn9/jiaoXYbUPTlmgKYwqIUGLRuw2lZXy76YFoIFgSvsABOFTi5QZ
         HhUWMuJXwiT8XA8awLsRO4R10MINUIcDA7NTrr5LGJhRMBIqQD7smDDwtGxchSPd3432
         yXA0g96EYxsw9Av46LjswAkBw/L7y/FDhoSiUdtffn3j75m09QZ3k7MIdd52dYee9n09
         dKkw==
X-Gm-Message-State: AOJu0Yx0AjIBPswcP8crELe7l8ZIHQkirHuQU3Zl8rSbtWh4ZRphZPYa
	sw/5xI2/mO4OpZHQJkz0AKVssLgQ1JNFL6mFMXxRtB06N/kP9bqNQosxPWPjxrRNvuQ=
X-Gm-Gg: ATEYQzx3QwMOEGARwcMN27N/H8Y6G34ejjHH7lzucojLCWXh5dmoV4SF7AwdpyvV55y
	cGsnivEjJc6iIlPSxaYfs4ChaMEC90i2b7Pu4cz5lvRToYixdka6SnFCCuMVk8yd4c+s7JPqfUy
	7If+m7beH2B6Q7DDrVKuK9+KieeQnK0i47foodbAvLgdGWETLB285Fq1jXMdN1MRVN0Ziu5Rs/U
	NxwNscq9F0WjUzZrN+ixagCi+rIYJzE6VWp1y9xtyvK+rUYy7nUGLuYuFcr1Rmr6e9/qF/+fhRB
	/KzOMU16Km4ovgGkvwbnO2oCSQWJ3T9yeOBTfJ3n4IGsldC974TCZ8/kqMFyqCtSGKmdNIaE64u
	NXb7mS+uSEvuN83mwB6v/tAucz6OGZWNG1p6f4EQW9ETZv5FeY9ezQDEpmt9PsUOeQC6fcHAa/m
	63O1rtT611RnBQ47mUlbdNmyCABXXHpLcf
X-Received: by 2002:a05:600c:a112:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-486febb5904mr103969715e9.7.1774206966299;
        Sun, 22 Mar 2026 12:16:06 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm492854355e9.9.2026.03.22.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:16:05 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:16:03 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v2 0/4] preserve promisor files content after repack
Message-ID: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

Finally, I added a test to "t7700-repack.sh" that checks if the content
of .promisor files are correctly copied into the first .promisor file
created by a repack.


V2 DIFF:
 * changed how the `copy_all_promisor_files()` function works, so that it
   reads `dest` into a `strset` in its entirety before entering the
   `repo_for_each_pack()` loop, and then checks the `strset` for
   existence using `strset_add()` (as suggested by Eric Sunshine)
 * correctly release `strbuf`s
 * added test


LorenzoPegorari (4):
  pack-write: add explanation to promisor file content
  pack-write: add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack
  t7700: test for promisor file content after repack

 Documentation/git-repack.adoc |  4 +-
 pack-write.c                  | 70 +++++++++++++++++++++++++++++++++++
 pack.h                        |  1 +
 repack-promisor.c             | 23 ++++++++----
 t/t7700-repack.sh             | 12 ++++++
 5 files changed, 100 insertions(+), 10 deletions(-)

Range-diff against v1:
1:  9bba49563e = 1:  fec0c24897 pack-write: add explanation to promisor file content
2:  3c0702f81b < -:  ---------- pack-write: add helper to fill promisor file after repack
-:  ---------- > 2:  0bb031e744 pack-write: add helper to fill promisor file after repack
3:  6967066fe3 = 3:  3dab969a39 repack-promisor: preserve content of promisor files after repack
-:  ---------- > 4:  cb642d8225 t7700: test for promisor file content after repack
-- 
2.43.0
