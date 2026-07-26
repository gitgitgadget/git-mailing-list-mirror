Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA221F09A5
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785060266; cv=none; b=GcrujHsuEdcbd2LiSItapTqETX9PbE2q4Z0o14/zG0XhDx8aGnucoc7f65wr+O1/iYfM0zazpIglsmXq4bC9Ov7LnR0q7y+HcrpPEwHEm2H7mAi1pTGIK9MWFKFDUEx3LU6nBpF1g0XdijH7XtacV+5R1xEYYIJD5d1RcZseseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785060266; c=relaxed/simple;
	bh=q46KIjaJZVrDT9yxTx1/qiGmkWAi2q3V8LjNFfVqvRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS2qlM+xwZCw+1/Shvv3DxJxmcfS53KuttG6rWKJRZYkcx9gR8RzeqfwfpxiH5uBDKhnhXLg8vo7A5yPhfEA4+2VGS4ZFFMgmYu2dYYiMa4ghuPqHKlTRRX4BIQU7l1fCkyAqlTliaoxxQQd3r1Vhej3TWpJdtpsUXgWLKpKK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GVQqBkNz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GVQqBkNz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca6bda96134so114436a12.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785060264; x=1785665064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q46KIjaJZVrDT9yxTx1/qiGmkWAi2q3V8LjNFfVqvRs=;
        b=GVQqBkNzDdOFkYhNABObmGU8BVBVcAJgz9YFfhS8lV0J6UJ3LyNqqC/M4w52GI8ils
         3xAsp3iTveGmb+J+CSWPufcI0USgkHQf/GBU2R60mZbpS/M3+Vm7EGd5w2HRhGIzN2bR
         /7tH2sjs7NU+d8FxihKbzkTSM5oHR9ExfZ0Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785060264; x=1785665064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q46KIjaJZVrDT9yxTx1/qiGmkWAi2q3V8LjNFfVqvRs=;
        b=ZPZEDTWzMYpjSFtJ7hvmeJIMrkwYRW9yfkwar6W0OSLZmj6X9OgJDOHAz1iP1hHVEG
         /kf+Zxg0WRRvqeVfYeWi7M/FN3b9kZCVflNpEpOPQwNqTW63eh8fAhAHLE2wQx9QPxa1
         cv6Xke0UEl7PWBl2MwQLZhXWKiXuNj5ZzIZ1XbkXKGgGJab4xeBmEn2e7cum5Ia2o7LW
         ojl7C2Q07yn3YGpAQ9O1950MGPg5krSSroKaEI7oIJroJfdGM87JDx+PuMQ+AyivWyPT
         T6J+wxuhw4sS6/CITokNUGoJ8Df/CoEBVOIOkoHi0YTJNNec6YUpvKLbACymz/GI1bOa
         217A==
X-Gm-Message-State: AOJu0Yxoo1INE4BFhZ3WsMXsg9CZeHazuCnbFqvdpVv6b1Ga4AHDaNGy
	YC752xxpbh+7XlE+xgh0TcMaLPo9zlo7gZ+TdBcFy1gDs4LAWHzYyEuSkeJuHcSIyfIuaS/C99w
	Sf8QpJxM=
X-Gm-Gg: AR+sD11nXCn5a1uZWkQ37IoZ8SNJ0Da1Ge0O7XdMeujN18odJJmbzq0TyCcZ9hH48Q6
	kFztIoPkYsHxzHAR6GKpg2wXsEt/z/dAIrwmHynO1rdaVvDDe8bV2EziA/uirYUB2UWSgj/WKr3
	9vFXXYIwpo0vwf1En9whW89EM5YcKoB1NbTZDXcaLIOehwRg90RFJe3AL3UivRWaYwjjRsKx73F
	5G11UtUBZxwQFlfRpEwifHPr85rpcVfADWQ1TKgHELUlHN4IspuxCYeBmAel2v1ySEu116dCd/G
	eY2R3oB7uMfmdTuJIN1fPlRf7U7FGAWFk8fUUlPGG5Z4k6wYgariMStNZ3DJvAb29HpsGzlA6Xv
	W2tW+2ksv4EgLAK7hyh43y6xDVreyfhhA/QLhOfJvOTS8CIKfjA+cXxdsSR3n9JJGQ0NBnFG0Q+
	3nrkmbRQ+4MKHxlN7/dBhzPeDJRIuNnkUjRVlOPmFeddLhN0Qbh7KGx/2RCkiNRuCCK50VEJrBP
	jxKJosomXYeuA==
X-Received: by 2002:a17:903:1a0b:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2cfde55fe1cmr36969015ad.0.1785060263640;
        Sun, 26 Jul 2026 03:04:23 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:50d4:8855:c7f5:b68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc4164ddsm18899967eec.9.2026.07.26.03.04.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 03:04:23 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] http: avoid concurrent appends to partial packs
Date: Sun, 26 Jul 2026 03:04:21 -0700
Message-ID: <20260726100421.12648-1-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726092027.GA3529827@coredump.intra.peff.net>
References: <20260726092027.GA3529827@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 05:20:27AM -0400, Jeff King wrote:
> I wonder if we still need this or not.

I think so, but wouldn't bet the farm on it. A concurrent downloader can
complete the staging file before another downloader issues its Range
request. That request then starts exactly at EOF, so the server can
respond with 416. The existing regression test exercises that case, and
we still need to let index-pack validate the completed local pack.

> More importantly, why don't we need to close tmpfile_fd anymore? We hand
> it off to run_command(), which will always close it. So I _think_ it was
> always wrong to close it ourselves here. If so, then could this hunk
> become a preparatory commit on its own?

You're right: run_command() already closes ip.in, so the old
close(tmpfile_fd) was a double-close. That cleanup is independent, and
I can pull it into a preparatory patch if that would make the series
easier to follow.

> That is...subtle as hell. I really wonder if it would be worth
> introducing the basic form of this (just opening once with O_RDWR) and
> then doing the Windows hackery on top as a separate commit.

I'm certainly not an expert on the Windows side, so I had to track this
down in the MinGW open() wrapper. The existing-file O_RDWR path includes
FILE_SHARE_DELETE, while creating a new file falls back to _wopen()
without it. The loop creates the file with O_EXCL if needed, closes that
descriptor, and retries through the existing-file path; a racing creator
that sees EEXIST also retries.

I kept those pieces together to avoid an intermediate state without the
required sharing behavior on MinGW, but I'm happy to split them if you
think it would be clearer.

> Hopefully this perl script (and the accompanying fifo monstrosities)
> can sit here for eternity un-looked-at by human eyes, just quietly
> doing their job until the heat death of the universe.

I thought you, of all people, might appreciate a little more Perl. ;-)

Thanks,
Ted
