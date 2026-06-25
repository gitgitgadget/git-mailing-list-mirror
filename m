Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98830E0E4
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413477; cv=none; b=jC+NdAsh5LBVPOclNuUXiHvi6I51hjLxNVSevl+xC7LS9pg/2to3pyqfoPUVpc61DCHoP8bbT7L7zshqdqziU/IZEiTotpP+5tAx7Ym/U9ApjSyMRz5Y5wFwTWd40reAjx2wv9HxY+BXGsYb2+mv6IGR/3qEsMTk0yPt5IuPXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413477; c=relaxed/simple;
	bh=SwFQe42NjUPhLjlrTP/hSejf/EsTn1n5XbOhjKWB5ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJZpwJiR37x6lQR5CH5sq5qd4udqsMhvuU7LLUnWcnEqHvAlb/o7BpUVoMOXYy8kM2vw9aS6rVUjGzPzK3JWxMkVukUfptE+JeWZWKxMfOcqPIeUzB5uY1Rn1gSH4lWXd3aWFqysygv73pFTm9K0ywGaVPcP6sZOAyH7Ot958HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TD8zG64+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvvKqRbR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TD8zG64+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvvKqRbR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BEAF14000DA;
	Thu, 25 Jun 2026 14:51:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 14:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782413475; x=1782499875; bh=iDyRBNZ+4h
	hov56c0cT84SiukIcjMugh9qgU7mbb+6I=; b=TD8zG64+21DdhPC2O9ZFnjaHGh
	qS78/v5VXPDCPwHMF0UF7v0mto1l62iABTcNrhSoib/Jk+RavGSfmtVXhrXctlo6
	GHSdh+bVfzGMxuiIbqnXp6bJmltbOgbe4nJOoBzfqAzUh6+FHlwdW4710nobmm1z
	Ef3IvmGPOAiVHxyw/U8CIE0GBPUas5Dve/NpQuFBgawrDU9qhcZczJiDW8HCse4w
	jTxKKL+v/2Z+GCAfPXR1jaK0gdRnDwwr+c4PQFIlnIxYTj84lhEVyWio7BNWG5u1
	wCiRUJxSsNhu4LkEa9QxTTcQg1Y6jxnm22+C0+Xuk0pceO7jBATOZEP2bBvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782413475; x=1782499875; bh=iDyRBNZ+4hhov56c0cT84SiukIcjMugh9qg
	U7mbb+6I=; b=jvvKqRbRK602HeNix1Nxgs6kkSmVyWoLeiX5AG5ZTXs6Id5HWPW
	YDfGR9CMCdEUjObPl1tcFnwiZ7vrh23KUdaC0RXwOIBBnePAipFj2sjx4U02BCoR
	47qAoVwrKqPcMk8KUS7vV+g3yBO/ITa2zN9Rk/0RRrfWJB4/wSSTTCK4maOfDd86
	l32KQ4GTXDpDhCOK/EhJPX8QW4JQcjVYFyThZyTU1zYMPrQ8XMBQsIHOY/WJvLpk
	SHy0LM8SNcbS9GKMFiIo/ScGbYClr09VeLe03cYZ/gbHrqNUqrmL27ZO+Djtg4Pb
	AQMN2JHESVc1qd1uZS9rZwdVKJpBuhEKStQ==
X-ME-Sender: <xms:o3g9aqOkx8ZKAXzZSjUTuqbYNjtO-ulMZgfhMcUpIeStafMKFfPXwg>
    <xme:o3g9av1xXDzqcQ1uWGYLtg3mk-ojirdX93WSXFSD6AlzZzOE59883CRTRZBCiP8sW
    S-Wk-xCs6H9Q66vjtk1gulV9si_sp0mgduM8hFyFWU-SLYxo0Wzp3Y>
X-ME-Received: <xmr:o3g9aplpFOBvlrZXnOTTRHPchx8NEcHtMIr6sVOmpRg_4wzkj0c2oiU9FObpFHMYGAM0CnhRjPS7iWZCT5Zdf6PC2uLIEcRM9Hi0bXgjtBMkecvgN0HBI4I>
X-ME-Proxy-Cause: dmFkZTF2AJd2811jfObMekcm4NHMVEorSxHiB4DFEt+NGnu6OOBsnSNhB2t3v1gJR7GSYD
    ujtVLAi8J8ZLa699cehT0eJRKbtdj++d9UuHLrWF+zD4v2iuiJ7XK+K5RXkeTr+9Nu90X4
    9G095K9n5+ZjXanDF/CCfyHDnM9jpmXd2RGYmiSKNS4Qmgm9+q5Y0EFEzm9VB7PvrOwgiO
    QSsu6DRqnwhtiC/WRwvI9l/97WC2baCtEf7gzkYdOSO5l5EEA+oam6O67iz1FK5uHlDyvU
    knNnSD3Yp4/2UuGhR9F3iuRo5xvgxX1dKkJz6+Ot5fYEbNLe+XtAPw/iqsxUb97HqixqT4
    mpejUjUMB+eunDX0C4Y0IJgXBQF3VJGnO4TPcPiWhfqT7/TedQktLJEaFbO8xmlKLIi4P6
    zmLeN5MsZBdBcnO9DMEbSYNEnfTZFPIY1MD9ibH2k51D6XhxsfOBedtoBLfVYjwgUTIZWl
    wBTLGjls2A6ddzTK23/JEt40XFPWcQHOAnvergkxt28aZPI5FNDA1fEacIwXJ0pRVUirYW
    enhv8jH9Q2aNNqw9MHchM977mKJLxLQOW0nyw1qz+V5FNdyxMNmxx6n+8kDHAoSSaYK9A+
    d92jaesDcVqQb4PeSaFtZZ/qE2/ZFzHYDQC8AnVj0jKidqQ+h73b7h7nclZQ
X-ME-Proxy: <xmx:o3g9amWWPUzXX081XAWlj89JABTeBTfYNwjZHw15Wec7MimWIcDzZQ>
    <xmx:o3g9avuDiTvLQHHEow2KX-HXEjDvsIHkZcQtju0G88vng2uZGBsBJw>
    <xmx:o3g9apYNgT_cKnHs5ruKrNdbZbjEiV3BWAmkn39bcuIQxlETN71AiQ>
    <xmx:o3g9auXUqOw0UoXptCRoxtlHxMVk9OqjkUC5shB50GMEb-vx0YXgSA>
    <xmx:o3g9atkITWSLCC9Lem7CMdL3AwQ9Wvvqq9ESndXCKTyrBS3mfkiIPgnq>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 14:51:14 -0400 (EDT)
Date: Thu, 25 Jun 2026 14:51:12 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4216: fix no-op test that breaks TAP output
Message-ID: <20260625185112.jjH0K9LI@teonanacatl.net>
References: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
 <ajVMZpjTKiXc7TRe@nand.local>
 <xmqqa4sqlchz.fsf@gitster.g>
 <ajjBmi39IFJW5p5V@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajjBmi39IFJW5p5V@pks.im>

Patrick Steinhardt wrote:
> On Fri, Jun 19, 2026 at 09:29:44AM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>>> Given this and the above, I would probably err on the side of
>>> designating this as 'test_lazy_prereq' or otherwise silencing the output
>>> of 'test_cmp' so that this does not taint the TAP output.
>> 
>> We can argue the merit and demerit with a good log message.  The
>> central issue at hand is how precious 52a9 in the script lost by
>> this patch is (in other words, are we checking more than "is our
>> char signed or unsigned?").
> 
> Ultimately, I don't mind much which way we go. But if we want to retain
> this, would you mind sending a rewritten v2, Taylor? I feel like you're
> in a better position to argue why we should retain it.

Is this something which can be merged before 2.55.0 final?
It's certainly not a grave issue, but it is a new test
failure for anyone who diligently runs the test suite on
many (most?) non-x86 architectures.  It seems a shame to
punish those folks. :)

FWIW, Tested-by: Todd Zullinger <tmz@pobox.com>

I tested the earlier test_lazy_prereq version as well.

-- 
Todd
