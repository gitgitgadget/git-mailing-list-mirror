Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7726F9EC
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924336; cv=none; b=cIOk1HGLF4nFSxADH0iRNrxo3I4ZJHfVnmV+Yrk/Zp3+qe7jviQTCb6YrISHfTW0nxOS15tiT44BH+S6d9od4fsQc6p+47AQQpPVo/+Api8z+uXFwMs4XKG5BBlJOJkblfd2vD/nTZhPgkftc+20NuHHY3c3mNYeTapDO4X3IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924336; c=relaxed/simple;
	bh=cq4N7Oww3p21vNBbiJE+YQpKHEoc2izbDWZhf8Kk4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZE52ADAGxvAU4IztdoIYtxZlhO5TWqYLdYbRditsPIeJA9KZ4olLUyi4r72INitBxhxIgwP8inqD6bAAkcA9yM7xqZqM6Ff4le9bjW40v2hmQpXYoHbyIPf7l2WOw+0MQDFO8HcnRniaO3InwaUgTYgxCpNKmibv9Qu+ojFBSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HuH463Wz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HuH463Wz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ec399427so10367966d6.2
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744924332; x=1745529132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQ20NGV7Cqz+zk4NPa+Z2HFjfvc1Rj82QC3pyWm1t9g=;
        b=HuH463WzOnqY+ni4UFoVNlzqGQmmcJ356W8YcSlzGWFW5XvNjGSfjC9w0DiKdN+pa9
         BibsDqIIi/pQY0uLbQ7aRAKBKnKwPyaCp2f4Djg7qaD8Hkv5g+L//M5oWueXqTS4Sjy7
         7qg9DbCD6IOxzgGbbzAuftap7fDXICeu20/RXtkmRObRHW7xmMrwDj9V2wqfulh2TDT0
         iJv/EfRAPF+Us4OxHvYSngruYVxEnGdUbGR5hi64rs2PmWSQTqvmv9PFmXPQy0+l5Zgn
         5dh/tMe8EWHiCE0qhat5Wu3TXB0TgNa+kO8OLCKA53mOfALfwOkGq58c9YYE2jLcawCz
         cv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924332; x=1745529132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ20NGV7Cqz+zk4NPa+Z2HFjfvc1Rj82QC3pyWm1t9g=;
        b=A9XnBy17rgc/zyLM3YWylT16BjVcjHMnWxP3PnorWVttpX05WyeGTgvmx9HTIRiiHr
         N4ml6rpmSq5BhsAsHe/y21jYutZuzT4WQyaOO/luh57sLsuT7k9tEav3ynD1+HO84SYd
         gfi/9S/gAKxVg5Aq1PRfr1f9QOP9GioRmzHUOTPgu5dLMGSeNQqUuVOEXMGcKvUOKWiA
         FELPQE19sz1kKf1JbeB3RWUieE8d3wlDD3ZvHLNL40vO0KmEe2Ezp4O+UHbs/2ySYfso
         L5V9KxmsvCo9JFBY8i6N2j5TZzuyOEx/eHwrNFw273D8UV9Knuo4VOoDLO/q2H6Ac5wA
         tWZg==
X-Gm-Message-State: AOJu0YyQM+Z0807uzJZnLSYpJQmndELC71A49yi23xzdyMFzTS4gVoxU
	/VXNXjIi6hu+xRlHljXKDQIJETA6f67tD/cpPs4JVemPztHBz/F2KrUv+aAdDwlD2nJ8P38YsTJ
	SOnM=
X-Gm-Gg: ASbGncvYa71zJOpRRHoEVewT+1Ty3b3vvMG+ZfZ/nZnYg7e47SElb7Qp9DR8OO+IZk+
	8OWj2Os0gnLW5VWkzZq9b15mheWbBbKtwSjtNNIABtddoC3G9DwQ9I5sCELD7Mpj4IQvNTKB6yk
	ZGSZoHFHYWvEGFlD3fglRy1aYiWn1zDn9uPxPTwNMJlsnlM39pI51g4NZ70OtUkMOCsc4KQmLus
	ja+VS/BJifWkN33KIlZgS9ghflDS+aQC76op19cLh2WmlB+nhGzufe6Au/kjfeK8SbpcWec/PfU
	h8eEMOL3S4zm9bXZyUnVZPwhow4NdfVo4akMXvmFwvbOOFNTpT7v0BQ92NVQswX4XD8qrFP9cfF
	5MLfzVhy06ksXxFfRn+ErEog=
X-Google-Smtp-Source: AGHT+IF4NuiogRwVljXuWyq2klSvbYxPShjoYEUYSuebiq7bGOIXTjM+4W0/1uMlWemAkibuBgFhvQ==
X-Received: by 2002:a05:6214:d0c:b0:6e8:97d2:99a2 with SMTP id 6a1803df08f44-6f2c4699b3bmr7815896d6.39.1744924332355;
        Thu, 17 Apr 2025 14:12:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2c233besm3268426d6.118.2025.04.17.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:11 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] pack-bitmap: enable lookup tables by default, misc.
 cleanups
Message-ID: <cover.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a short series I extracted from a larger topic on reusing
"external"[^1] deltas during verbatim pack reuse.

As part of performance-testing that series, I realized that bitmap
lookup tables are not written by default. Since it has been a
significant period of time since their introduction, the first patch of
this series makes writing the lookup table extension the default
behavior. This is:

  * pack-bitmap: write lookup table extension by default

The next three patches clean up some t/perf scripts that were redundant
now that lookup tables are the default behavior. Those are:

  * p5312: removed duplicate performance test script
  * t/perf: avoid testing bitmaps without lookup table
  * t/perf/lib-bitmap.sh: avoid test_perf during setup

Thanks in advance for your review :-).

[^1]: The term I'm using to describe delta/base pairs which either (a)
are represented from different packs in a MIDX bitmap, or (b) the client
is known to already have the base.

Taylor Blau (4):
  pack-bitmap: write lookup table extension by default
  p5312: removed duplicate performance test script
  t/perf: avoid testing bitmaps without lookup table
  t/perf/lib-bitmap.sh: avoid test_perf during setup

 Documentation/config/pack.adoc       |   2 +-
 builtin/multi-pack-index.c           |   1 +
 builtin/pack-objects.c               |   2 +-
 t/perf/lib-bitmap.sh                 |   2 +-
 t/perf/p5310-pack-bitmaps.sh         |  47 +++++-------
 t/perf/p5311-pack-bitmaps-fetch.sh   |  76 +++++++++----------
 t/perf/p5312-pack-bitmaps-revs.sh    |  34 ---------
 t/perf/p5326-multi-pack-bitmaps.sh   | 107 ++++++++++++---------------
 t/perf/p5333-pseudo-merge-bitmaps.sh |   1 -
 9 files changed, 106 insertions(+), 166 deletions(-)
 delete mode 100755 t/perf/p5312-pack-bitmaps-revs.sh


base-commit: c152ae3ef50dc7bbbf5089571df5bba404a96e0d
-- 
2.49.0.226.g0e6cae136d
