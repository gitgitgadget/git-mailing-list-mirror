Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA7378833
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664632; cv=none; b=NSZRcgEUVu1KfKtfbqv0Gv6Ow9GH311Pyxe8s8tv8PF78wJNJail7Mqg0hJTpIDD+xPeo4ShFKP3haM4P+FVnBX7YBDpmwQvMiemSKeao4bAySRXOExdyn6r1ZNv6XoET5VkE+hmVHKyVSsXwo7C+d+rcwDrX2kiQwt3ueF0UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664632; c=relaxed/simple;
	bh=aD+Dy8w1Vbqnbqal0lp2aqOkPsvS3pn3dBfpnrc/25k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ImPg5VfeBc7s9TAkCKa3aYNUAF0N9oTelVP4fFmEsvwM8dXsRI6jcNgs3xitvIud8Asde/ek9XYuTTh0X9EgAzJINu0+0rAGAWsk/1uSOXGvNZQtfQe20yYbrUS7xA4zxeS1Z1w7P/EU2E9CCy+QZH0zdEHOWoiz0UmsfiBtJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXwgvNDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRojBpl7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXwgvNDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRojBpl7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E57BE1D00192;
	Wed,  4 Mar 2026 17:50:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 17:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772664630; x=1772751030; bh=gMvJN272Ss
	S64j9OagsufoMLL1MFpiNtfTxEwMRw+4o=; b=VXwgvNDaEhM9tFwbpsCMhGy45U
	09axvFKKjby+u51UQfCeSJx+YSWhlOl4ymFcTWbWJ9tGoOlWhw136Oaf+x+INU7T
	GS1WLIY4Ot/Tha1q7E1cH1woRmI135Aor99jKLW5KV2u0rWndSFW6npFdNkWyqol
	F5aMR6HkbiMCJhsNijJUi00OODQpgw/uHcestS+KfuX7y0ZOnPel4Khds0+V51Vk
	z35JU9t+SiOebASSEvdsh9+7XPTbfnizjji1X07K3iAkk1HLrCl2YiqZG2TdjRga
	UQArPVM7yAaxS2VCdRaYq2TKctCPrTuM6SH1q4ZpmsSkwM1XGPko4ycRU+rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772664630; x=1772751030; bh=gMvJN272SsS64j9OagsufoMLL1MFpiNtfTx
	EwMRw+4o=; b=fRojBpl79H+RTtkAWGQwzLBlCDjYEAFfnQRRIoNJuNRLH+8ynMh
	J24MK5qVUMJ/Z+/mPo5TNiHSffQgYk2Yzk96gD9or2fUvlrpcORGi89xAD3zBTnP
	bfkS5OiNNvYXbjBt7qngYjHG7v22KJFYizbrgw9QetIr9poCJ4DtKc+hn0ON0k1f
	C5npAuhLiidoXBZeqWrbcHisYinAL9PPoIdJJt3AKbuVQy2MbsXYk+RgP84aE4j0
	J2N5MvrVT22BnvBmBmVnwNasgJ2XQQn+DoLFvrVIZEJrWdrgiUy8H3OpmVyBqfaj
	YScLpfKR2FD3vRSZ9WWBJuwk2uijWUBL6lA==
X-ME-Sender: <xms:NreoaVo5dFEjMUtpU54TVqQufc6InBKwhD18jSHvwtv6SrKuqQUYNA>
    <xme:NreoabWIbPw3__dBQ1nN81_CtOLuZoQemn7M7jtxcvvmxN_cMa1rcbg2zI6IyqiKC
    NfMwY1lcQWvIvhtjsk-PMFz1QpFJV5LWrr0sunpfXsCldo48G9zMQ>
X-ME-Received: <xmr:NreoacAtqELLinfmnU0V4ppETU3dg_P0Qw_vjPUFYfEheGHQe3d-p-lW1L9M_TVVYbCq8WKt5e0DYmFBa-NJAaNhaU9W3N-9vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:NreoaX1qowvgEjfJFy8X1w5V_fftR1jn_SxP2v5sV9jpFWXOvwBRYw>
    <xmx:NreoaW108r1AZL3GHS-RhwKypy9fy3yDVf3aKsdRR80gbpl7jFfq3A>
    <xmx:NreoaUCfgR5oNGFn6RV6cbL2cnWdVzfzP6ZnjUiSvA_pS4vX60APtg>
    <xmx:Nreoad7ETM_arzwGpJqEDbTHQFJSbt3n8kT9BXiPKuk9mifjT9hTfA>
    <xmx:NreoaeF2DkSGV76XoJrZlckDANN43Z_qgzZ4xxBj5_0fviTAeZyR3_3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:50:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <00f6d468-7d00-4edc-886d-723322420539@gmail.com> (Tian Yuchen's
	message of "Thu, 5 Mar 2026 02:41:46 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g> <xmqqjyvu42pw.fsf@gitster.g>
	<460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
	<xmqqo6l49mrt.fsf@gitster.g>
	<99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
	<xmqqfr6fa63h.fsf@gitster.g>
	<fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
	<xmqqcy1j8o5r.fsf@gitster.g>
	<00f6d468-7d00-4edc-886d-723322420539@gmail.com>
Date: Wed, 04 Mar 2026 14:50:28 -0800
Message-ID: <xmqqbjh35hvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Maybe, but my main concern was that adding 'die()' in 
> 'setup_git_directory_gently_1()' might not be the best choice. 
> Considering the implementations of the preceding functions, I though 
> locating 'die()' in 'setup_explicit_git_dir()' might be a better choice? 

You may be right.  I didn't take a careful enough look to comment.

> By the way, I noticed there's a '(read_gitfile(path))' macro that 
> expands to 'read_gitfile(path, NULL)'. I was planning to pass 
> 'error_code' here, essentially moving the logic from the original 
> 'setup_git_directory_gently_1()' to this location, where the former 
> would only be responsible for returning the error status... The changes 
> would be a bit too extensive if I did it that way.

True.  It would be a lot more invasive change.  I do not know if it
is worth our time _right_ _now_, or if it is better to be left for
future iterations.
