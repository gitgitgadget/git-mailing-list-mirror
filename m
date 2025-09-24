Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A0146588
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691341; cv=none; b=Y8yP+tkupez2p28FYF2KHcvvXSRrc1JNwTZJiVM8RT+wdkYo/718EKgzGi652Jyy37n/koGKp4ECY7Ca+BeWcLgEn6irK8vTdpjZyB4hwRBX9cJINVoEMg+xt3/9um8cdppODYT0SM15BRccf9coRV1xRydwdA1c94VHjEHNHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691341; c=relaxed/simple;
	bh=MpK+Ex+78TtANiplkRVvrRW0Kt1tYbawKnH7h5BLQzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocsuPM2A8k7GK1mGDHt1cbnnHBs5KQS5dFXlN2saPcmJTr7ChC1YXPHsEe9hrM6xuGkPewRLPl5aKnZs1T0d+XW9sUoZj1ihMjDudW+zAxsTshDMFVge2bY3yT2ivc1OzUrQWD9yZmxWMhMS0BMvIpcvzvrNyPykmmCO/HqzrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PGseEgtW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PGseEgtW"
Received: (qmail 12500 invoked by uid 109); 24 Sep 2025 05:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=MpK+Ex+78TtANiplkRVvrRW0Kt1tYbawKnH7h5BLQzg=; b=PGseEgtWtNazpY8mhROhMTNr0FqJa7+FwGGT+2sTtdwQbSq+7Xn3V+kkgRYS5Qp1n79RFLTGX1/Zk2iq9Kb0RIMmrspvSWK/vRSxMyb+xt5qiWuAM5aExKhFuKzDf5dE1dzyj+JugLr2f1OaC7GgbXY4MwxcztiUrcn8qxbxV864VrWhSh7qCJ5++sSGNOIqqahTBoI7EcDI/Cb+SXElrLbFSR/XBLJ1ZwAVPRMcHx8DWcJhyPePUYunm0a3t9j9wMGTU3ncSkPYWcLRKnARUlfjMLJ6/LMuxyaY0so45dPYXNDrtq7owb+5qMx54ztMs/d+ihn+troacQ/e7Ig8KQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Sep 2025 05:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19179 invoked by uid 111); 24 Sep 2025 05:22:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Sep 2025 01:22:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Sep 2025 01:22:16 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
Message-ID: <20250924052216.GB1173044@coredump.intra.peff.net>
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>

On Tue, Sep 23, 2025 at 05:15:46PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:

> In git log it uses a 1-based index for the date instead of a 0 based index.
> So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say "Fri Sep 18
> 14:23:24 2025 -0400"

Are you proposing that the first day of September is the 0th? You might
be able to do that with locale support and using strftime's %c option,
but I'm not sure how powerful locales are (or how one even defines
them).

> (or "Friday 2025-8-18 14:23:24 (-4:00.00)"  to get a
> better format)

If you just care about the format, check out the --date option in
git-log's manpage. Especially the "format:" specifier, which relies on
strftime, like:

  git log --date=format:'%A %Y-%m-%d %H:%M:%S (%z)'

-Peff
