Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0023B28D
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959608; cv=none; b=H5TGg2NnXdOeGtl/pSz3iwyPLXebLhB40N5wri/XBfOfNwfMO5X1z4CZ8iZ2jW2GYK2zCsbnpgQvX0PAVfgznnwhyZLYYW1nrsv9y1P/MjaR5kKaqK+ruklAFErwG/N7fy5OWHXVPfeAn8aW3SE2jtEfJGQ7QXgDdENt7Wvj4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959608; c=relaxed/simple;
	bh=XLeTMQ+wRNy/h7uMOeKg3J0G8mZce3uw/LyJvGC7FiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1j4dsKGmkDxi3Rx/db/d+kWaAfuKvCyF6/8sxNIJxiW+4KMgpPusTvDjSyydvC78rZ/JKpihPpbuJZi3WgpCifP0SbNUfTXUpd7VG2jSRsLl3nxH+6FOUy7z7wh84vcnnlEvTOoOUyW0RiS3YdwhpkDp/DhcQiWpsSicU5HLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oZ0IcRv1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oZ0IcRv1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3bae8d3eso574407785a.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959603; x=1772564403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxKjkdpZs8Lxp+keCzEt9HNbX5yQiwuW/38xtJSV7yg=;
        b=oZ0IcRv1S1KMB2SIeN6QABO0x7Epxv+6Mk7j8wBhusDaO7+6508hj6gUvA4jJcf9Kf
         QOK7pgKn6p4QMozqUU5u/ycA/AFSZF16zs9tsTPXDuG9mtTHiKukpBNtxjkxUF8EfyfU
         5aGXSoKVwN928SEGGbbzrz5ftTRltP626CIfQAByTIvX/MsjjxqDBwbNuMQHax93CpMU
         3lMd84wgXOO4GCDqjPI65spSgxRMfqI9622nUlUEmh9iYUULbdmkkIt/9J70y89l7/bk
         44hRWDuY3zyAHeyNPWvoknhHJkB71+eGTCfGYvi//tpNPqukwbydYXrn405QBjmAKPJH
         QSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959603; x=1772564403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxKjkdpZs8Lxp+keCzEt9HNbX5yQiwuW/38xtJSV7yg=;
        b=js7SH6MrbhQLoNN/pdwNga8vMEIkZUXz3Ug9MQh++Z1+f2C6E5sDM+8ukpG7bS8B/i
         UnEF6Dn1RGi7YfX+eXdN0b0vZg7qysOZ2vNntY9fEZKF2+tFnraSbahMURbMktRlcTVQ
         eSEx1LAyYivCLiN3a2W44QEwSvdnPDc6xKKPhrM7IqUxHh/JeLo+1jv8W9HKEptyHPAm
         cQ/Sw6/vJnfa9lzSgQ5v13CQUP9Yn2VlfWYRlwuzsAvszdrWF3+pRmqji6kUgGF8qAof
         GpQtixT+p/KhF1qkUdfVfk6jAQQyZyVsE1FI3zUUVtvrMetxWRHFZJBVa84w7GkzbB4g
         JcIw==
X-Gm-Message-State: AOJu0YyMzPq3S5gnXBW9iXEGwGGSEY2m0mfZuxrkAFjcN+saWenCFE7L
	ENctYzxEV7Vo6uNcaSfcDXJzV/DrLYGBRbn6WJjvxqIJpD4teHzIaql7vxblhH1qhF9gdRs0SCF
	RJrqq2JIF6w==
X-Gm-Gg: AZuq6aKv2n+fxNNk+0nd9n0Za6qlr0HYnBjppcz3OaOcQkFtRga30/fq/6Jx8gCIZkg
	hntbWNm0M78MnaH8NRvneDJW67TB8sJ50QaHps/nelGoFSPWvlmRfZh2UMFmprXYkX2kjPAZ+WV
	10Mk4ja9SNEdD9ms5tCq5iXbePwpNxV2+6bDbaVmIE/rKGD74scOyi7ZBvIPXpDC88z/ekggKvB
	jmdmKFmvBqevp5C8N+esJF+ZD8cpCO8Yoc0GQY+piLjclmdbdmnhYg2vpYZ6oibEsEC6t0mHwhs
	5R516LI+3z/09wvh3qFfhLaZQaXCGRUSs8MhrJbi4+u58+d9bupo+UHwbdNmluLbLy3FPdZwt9o
	pK5cBK02eXUGlk/G0YAPDdnv1wnpeSsG2mroTYvqzD+wGyMk6yTywnPAKRNc8sCUA4sSvineWJu
	ZZv+9Dib7NUXL1b51mcLT9Ka1Bz6GLinR1wAPoBf99QcEO8wDuTuJ06ldiMN9U3NPDLUoWEHrJZ
	6NiLUhEx9tdpcMH/ihlgnqmP8/d6Z03zh8mkzLf
X-Received: by 2002:a05:620a:4495:b0:8cb:49e8:d460 with SMTP id af79cd13be357-8cb8c9cde0amr1650797185a.5.1771959603100;
        Tue, 24 Feb 2026 11:00:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046291sm1050451185a.6.2026.02.24.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:02 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:00 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/17] t/t5319-multi-pack-index.sh: fix copy-and-paste
 error in t5319.39
Message-ID: <06a96e16c371bcc04bf40c7c339781771e57df8d.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Commit d4bf1d88b90 (multi-pack-index: verify missing pack, 2018-09-13)
adds a new test to the MIDX test script to test how we handle missing
packs.

While the commit itself describes the test as "verify missing pack[s]",
the test itself is actually called "verify packnames out of order",
despite that not being what it tests.

Likely this was a copy-and-paste of the test immediately above it of the
same name. Correct this by renaming the test to match the commit
message.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e76..efeab4d22b7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -517,7 +517,7 @@ test_expect_success 'verify packnames out of order' '
 		"pack names out of order"
 '
 
-test_expect_success 'verify packnames out of order' '
+test_expect_success 'verify missing pack' '
 	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
 		"failed to load pack"
 '
-- 
2.53.0.171.gde83996e422

