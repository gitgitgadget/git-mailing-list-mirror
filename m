Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431419DF55
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902261; cv=none; b=kOvIrW8j6vTCLc4UYBHhj+ZjRUAzTWXBGQQVTYV5Zh8vcRpbZbLCMVIA0p4tLJuDH5eP8hBwUScv73iVtkUOhAh866pbPFKSvOK+7DKpl1NzhQcQ5kO1gQ/6gmxabJH4cdf1zH2dxAQUT7Pvl9b20M7dvMbDs1nj2cmUYaS5DIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902261; c=relaxed/simple;
	bh=ed0Hz4yRSTzI2NrRg5vPaxEfQq7q5dYMaS0/wSr/S4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M9WNEcu1wE5dyal1Y5BzovYwxUhbpIIDGPLkrfManOVzcXXSth7JwdiLzSz2bJ4TskbWeh6SLn5Sm9hy/91zE5yGO9fYkCl+jPXLZrE7nfnQRDxSzWwyTrXPAtGylGCmeJ4DtD8RFMjA/jjO0It6+rk8tBVCGo7w/vFZ1GBiUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=T4bYW6xH; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="T4bYW6xH"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-667971437d6so656788d50.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785902259; x=1786507059; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9dwEuCdEpzWUSYA56ABtiLbWQ0L3YHqbEvILZ4SK+g=;
        b=T4bYW6xH+HrPCn8ctvF4QyI6A8fAdt7wD14trxAwWY1cJmeayeASi4ScGfvZxGCJKR
         W3btwnMUW7xiq55w2xThPKo6+cIMmb31SnwyNpWt1ub0M4VBG6T0sBkKNT1xDKn0kkEn
         FNuKNbrEc1u/ElkKZiwSS0IQW/BQ5QSDE17b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902259; x=1786507059;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S9dwEuCdEpzWUSYA56ABtiLbWQ0L3YHqbEvILZ4SK+g=;
        b=biYy73Jii8OMZsJKvZwR7wGV+x2JVoDGUM9RpUWQVAL2At3vBmDU3s5+dJm3OAHlK8
         LXkhH8/h2kBoTiItA9531M4Wg7kVWQwlkRDcZ1M+C4ktJ/Xd5XdJTlRgsyOEfaiCYGDM
         MGpsAafhGF+j4C6C9Di0sQ+2tlnWtMywTvA5nzi5uqRau2lMxt1yFgarjhL0lnU1vM1m
         cLGnbadD4zUYC7mEHifSDCjA/fAS2JpxM4RaRf+1FiIFZ9/jCVyc6wdTzmsgF3fT0NF+
         GgaGYXSSpicfvfIDvBBzy4sxlWJzhciwYT5GmjjlEjcfbfqaYDrShjU1v2KoPt/m8eKn
         nlcw==
X-Gm-Message-State: AOJu0YxyKuAHhExFqokimL7EV636WbM13RlsgeeMtYb2BwJxu5hYHzH2
	PcV06zklK9m9Rztm4Y15D6WrVF4X9lVtpYWh6XHpwDuiX1jaCxs/EzOKwf2oE0xRqa/nnjnbPhO
	HA2UIELo=
X-Gm-Gg: AR+sD10zZCDvjaA3/kXwvv+cSjSfCpzckHKc4iQ0qA1AIOK67xEGNQwYoJNhrDkM/nh
	2d4EivkCMuY3dO7TX2kAWJCdtyN2BETTEJEeoCaw1Fp43BNHrbuuYvTQkvxpsEPk2e0LseivOPh
	JprsRrbhHHTEz0YC6qEcDBRTRUAWg9mrwu5MEa6ukTziXbL3fbwu9tPVf8d5Rm5XPu1GBIrIFET
	fsJEVNdDYQHHlUIMQ7LdUtmBdnTztDh+HkVFJPCiRdMY14CKjc4o4YLT0aw1UnNIeZqcnywy5jA
	4RQBTqhNEkJbw4/5jRJYl9oRxARv2pNBqDPypdK6hC0zmQDL/RP0miaj9K58QQrvWqsnQyWnpmd
	n4NgWuOzmNmT2ZUGDKSVMHGzH8w57ZHw6XrzlO1vipBjta/lXb1z0tBhRg7TeTKGtpm6OnCNVha
	fEBJOMk5AmieyRLiOBfJeYjpqTppohgMmhuSkk2221xjrG2N6wbhQx4YjQkrGx3GwdYCmFZygBN
	P0CvRc8+nSx7o5kysUcyEAfI/A+zxRQnW3Hqf2Jd8i8Na1wy0sVi5K5
X-Received: by 2002:a53:b009:0:b0:667:e855:ec85 with SMTP id 956f58d0204a3-6699a8886admr1760613d50.12.1785902259126;
        Tue, 04 Aug 2026 20:57:39 -0700 (PDT)
Received: from com-79390 ([199.47.143.8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669913aeb1csm2109587d50.5.2026.08.04.20.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:57:38 -0700 (PDT)
Date: Tue, 4 Aug 2026 20:57:32 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Ted Nyman <tnyman@openai.com>
Subject: [PATCH 0/2] maintenance: handle geometric repack tasks with promisor
 pack(s)
Message-ID: <cover.1785902237.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The geometric-repack maintenance task predates support for keeping
promisor packs in their own geometric progression. After that support
was added in dcc9c7ef47 (builtin/repack: handle promisor packs with
geometric repacking, 2026-01-05), the maintenance task still made two
decisions from the ordinary-pack progression alone:

 - whether an explicit run should use `--geometric` or its
   all-into-one fallback; and

 - whether `--auto` sees enough work to run the task at all.

That can make partial clones rewrite more than necessary. If the
ordinary packs would all be rolled up, the task can choose the
all-into-one path even when the promisor progression would leave a
large pack alone. Likewise, an all-promisor repository can have a
promisor rollup ready while `--auto` sees neither an ordinary split
nor enough loose objects and skips the task.

The first patch makes the repack-mode choice consider both
progressions. It keeps the all-into-one fallback only when neither
progression leaves a pack above its split, so the fallback does not
rewrite packs that geometric repack would have kept.

The second patch makes the `--auto` condition consider
`geometry.promisor_split` alongside `geometry.split`. A non-zero split
on either side means that geometric repack can combine at least two
packs.

Both tests build three promisor packs whose object counts cause the two
smaller packs to roll up while leaving the large pack intact. The
`--auto` test uses a high loose-object threshold, so the promisor split
is the only reason the task runs.

Thanks in advance for your review!

Taylor Blau (2):
  maintenance: account for promisor pack geometry
  maintenance: trigger --auto for promisor rollups

 builtin/gc.c                  |  5 +--
 t/t5331-pack-objects-stdin.sh |  3 +-
 t/t7900-maintenance.sh        | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
-- 
2.55.0.483.gdc2fffc37c
