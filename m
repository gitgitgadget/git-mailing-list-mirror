Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3143AA4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387460; cv=none; b=BE1VGS8vnLqkTOfWnDB7CT8kyCG7M0IYCYa+oFIRnGkmy7Hv5/Lp+0ZKq+a1uuLG0lwNTknJtLxGQeu5zeSauZLmBtP3VDgLj9z4Sm4bn3GSzkaj8ybqO5UrmMOErT9P1O7wMjH6KYjvN4hWXK8Z91xX1PhWMXafCMRlu/bCU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387460; c=relaxed/simple;
	bh=hngW9f5PCB5r0JkmwM9tBfaMb2cL9qU8+ITQAQPkyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q2kvHgiztCyNDaEEwAZQ6TqpfYl3G7Vrt1X2kPtwVEw70H7zIjLcaau7wv63Zz1mGrgJnOFDJSLlWDJKHj1qb/WIqdnoPmT2LIHmbFnEeAALC9PJV7dwDd1zg3iHbvf0zZu08KdRC3VLU/t/RlECeAdtCRpi9G02yhK63592n90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Pn6pGbJ9; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Pn6pGbJ9"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a2290b48eso365174985a.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387457; x=1711992257; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trccme5/7MJr/nM+75dvkRpNcmwhGy6uHZgBzY+Fg0U=;
        b=Pn6pGbJ9z4pcWYo7FTGo672AhvTZjK/fj7i0o5ZW4mfFlxVjw8w43oOros+Gpniyyb
         H1s+SojBgQukgfAuuQtqLKReHBCcuce3aFzC6x1H7aPWnOgHom5hSWoXuBDpbWnnKinw
         mtk1Xxu3Z3ciBAPYnB21k/SowUdAb8GwZzywimKbeFBWqN6zH3CjFImFbuNSUk2PD0ut
         L7Dy1UA97+lRICtnB4XDYhXmwJ2E7zKyeolOhhhURamVKS3E6xWTclCLW9OmaNidcDCy
         JPTMTbVxXxtHo0/7XBGOPicATAaRNiVOje30s+EHrZYLzLrb3+DRbl4TH2Lu0ivjvm8A
         ajUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387457; x=1711992257;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trccme5/7MJr/nM+75dvkRpNcmwhGy6uHZgBzY+Fg0U=;
        b=cFm3yTI0w96XzUYA218w5uk3IxWn+NzPqisbuoz6sPxHLsb0yA3Oq6feNe8t2Pogy2
         xQChI4Qkm1kV9gLE+7AzvgGDoUcmAem76jtpEPobq012zh9UPNBX6Rsn1O9go2S6XsCs
         IUKS3UOeJRICIFIPQPIHdks+A/JEN3tJzshalsqa0IndKV4f0mb3CwaJmvGyXXW5tbFy
         V/2BjErxiLXFF0EuT2988mOSMBNczejwHnpdEURU4dfQotVdLW/63I+BYHmklg+RmvAf
         TpKTVIk9QTHX8Aro8R0YyQSpP6mdC05eDFyHCicfD2SeUPUaqMJRS9SCwOu3lRfIhUkL
         uLfA==
X-Gm-Message-State: AOJu0YwPpbaq1tfa+ztn1tqhvdHpAg/nTK58cZIKG5qF+QGzxLRjEGJQ
	EBoMNCdZ1YmQrej7u8IoNR3gllssGjvWnxkZL+ILojfRYN+ulqR+buw2HMpZXfa65EttCy315fl
	AVvg=
X-Google-Smtp-Source: AGHT+IHSWpCYUf4Ct7yLbxxva/m6D2/KFw/VLrUE0sl8MIklOYTSOegYN5D+nV9xvqJwvo5wKPu+wg==
X-Received: by 2002:ad4:5fc5:0:b0:696:7fbb:d3e4 with SMTP id jq5-20020ad45fc5000000b006967fbbd3e4mr7343928qvb.55.1711387456979;
        Mon, 25 Mar 2024 10:24:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020a05621420a800b0069680936f00sm2431715qvd.10.2024.03.25.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:16 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/11] midx: split MIDX writing routines into midx-write.c,
 cleanup
Message-ID: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a small-ish series that I worked on to split the functions from
midx.c which are responsible for writing MIDX files into a separate
compilation unit, midx-write.c.

This is done for a couple of reasons:

  - It reduces the size of midx.c, which is already quite large, thus
    making it easier to read.

  - It more clearly separates responsibility between the two, similar to
    the division between pack-bitmap.c, and pack-bitmap-write.c.

Most importantly, it makes midx.c easier to read in preparation for
future changes that I hope to make to midx.c in order to support
incremental MIDXs in a repository.

The series is structured as follows:

  - The first seven patches move all writing-related functions from
    midx.c to their new home in midx-write.c.

  - The remaining four patches rewrite `git multi-pack-index repack` in
    terms of `git pack-objects --stdin-packs`, yielding more
    tightly-packed output as a result of the supplemental traversal
    performed by `--stdin-packs`.

The first seven are the main goal of this series, and the remaining four
could be queued separately, depending on how folks feel about them.

Thanks in advance for your review!

Taylor Blau (11):
  midx-write: initial commit
  midx: extern a pair of shared functions
  midx: move `midx_repack` (and related functions) to midx-write.c
  midx: move `expire_midx_packs` to midx-write.c
  midx: move `write_midx_file_only` to midx-write.c
  midx: move `write_midx_file` to midx-write.c
  midx: move `write_midx_internal` (and related functions) to
    midx-write.c
  midx-write.c: avoid directly managed temporary strbuf
  midx-write.c: factor out common want_included_pack() routine
  midx-write.c: check count of packs to repack after grouping
  midx-write.c: use `--stdin-packs` when repacking

 Makefile     |    1 +
 midx-write.c | 1525 ++++++++++++++++++++++++++++++++++++++++++++++++
 midx.c       | 1558 +-------------------------------------------------
 midx.h       |   19 +
 4 files changed, 1559 insertions(+), 1544 deletions(-)
 create mode 100644 midx-write.c


base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
-- 
2.44.0.290.g736be63234b
