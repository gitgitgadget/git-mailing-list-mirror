Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10836C0D6
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336329; cv=none; b=Pr2NzGOzNXGjh2h+Ix4wUyD7+Vb5BcLyc31dTKZ+PappIwvd464Iiz4l5GijCX4BYdrJ3PNjcBatQQR+2p8rbTht0LnKvE7y9sgCNACWFmE4DFI0rzwfXGpNMUMhKV0lrXVZPEfVm28vw4fxz1L1nGcC/WOFhnqLzRrRWXian0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336329; c=relaxed/simple;
	bh=R9R5E6NkE5236hSDLECTcnGSPUvhNNyZXvn1MIgwnFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oaGnvDLUMkJxqR20c6FV7E5ViqdRsYRfCYwwtudMgrUeu4uyjjGREHARE++77kowICWxtmFl10DVfPAW1LASTKiqm80ra7rhOLEI6iA7gIazHqGNEILo0unGrkEzHijSjdBf4obGC880sYovztizmxBID16HAbPByv+t1MfLbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kWtO1agY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0njFKLvu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kWtO1agY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0njFKLvu"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id CCB5F1D001DB;
	Thu, 12 Mar 2026 13:25:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 13:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773336327; x=1773422727; bh=2a0AtBqy4E
	dnVswTMhTXYZQrtTvtckqnxFK5igv/Na0=; b=kWtO1agY3KFP+sbw0mZjFU76VJ
	SxMYjMqrHPLfp5wfd4A+KTpyEJDa8vvQYbL4TPF50FQo1eOzeKSAmy1wsSrrG0Av
	p8Vd03JgloH8lHQAo11MsGf1aQzu/3Db46pzdREA6cjENr9VVSvq0vNw3/9J7hcK
	F4lHMkT3OML9cBKV1HJxlPGz29DsLMClPCXVNsQAzBC2u5OEAWf1d6mjlPjOYS0M
	VGcz7f9xPjPXAU0hW26Fx10w5jeUTDiqxRtk/mHnMWyyUuHnVMcGVDKJZpUyCTky
	oKL4JFCd7hMxbqrVEkCw6i/5+pxpnkBoguBaevDrdDV5mZeTDCF2wTjSX22g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773336327; x=1773422727; bh=2a0AtBqy4EdnVswTMhTXYZQrtTvtckqnxFK
	5igv/Na0=; b=0njFKLvuVaoQQipNxHnNDzEpPqrhzLyMAeTYl/mfjar+Q/3CCg+
	N3K+0fO7UpL7ubDMyWLZJcankodagtwwvAECNVI/L5luejOxIdQC7iu0Y+tyCZCv
	6DFlTlwqyMG/D/FWX47GRaxIsiILgCdHH/W94xJfjnL9XzMm1j6ff7n0sSmSZCGd
	CBy1aiXgdVJoAv1c/OFk02XiqGgGWdRWiSEyszyROQUYMZsWyyGBv+zbv7GtRjk1
	S50AzbXTJRkQ3XDEG6FqH4RNCoAoKVV9Mo3BbLZFBBEkzwyzaH3joQPPYzwRPgvB
	0qOFU3x6Q04tJEMOWvdvXnVEnJUue6MfLzg==
X-ME-Sender: <xms:B_eyaZnAzeRUKHEmZR1Ync_pdXPPUJMW53dVBJdOxsfYEuX7gSbVZQ>
    <xme:B_eyaYi4IXmBE-j0HqT1lfUnbkHvcuhb8XicQYrt56Q1ePuYPUx3fEFH3MNQo5vE9
    5IgmWG2QciRMK21IUog8nvCIDplqBJDNtjXDhZ9bMUie8lO2cJ0>
X-ME-Received: <xmr:B_eyaZccSTV64-PXRrZTqYa5ZbBLzOEVnGDiBx5yOu9G39dtuJB3H8bCdzWqdI8W2Cip_G-PU-ucHiSBAEDcpI2rdUzgckdLAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B_eyaQhG8pAb3gqNdg9WU7MMqbG1Bb8PZ2CXcCE2hmzuLIIHsG0eiw>
    <xmx:B_eyaZzQ6EeFabYxIJ7SC8hHzziysZ4FOXAEgZ_tF5oUvxMMAdzZvw>
    <xmx:B_eyaUMZjfAG4GykD3pvwHEY6WUoItBBxqrR4kO8sMpEUV7urx0EvQ>
    <xmx:B_eyaSVqkqKx3ocuYEndhPrYaa8NGgxkFRaVrIZ4VtlIqPl-oXtHiA>
    <xmx:B_eyaQXgbpV4NE71Pr646dH03I_1iZTlPNKEBQC6nn6BLAZx2nYKnMrO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:25:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
In-Reply-To: <abLw6vUUh36zFK4n@exploit2> (Mirko Faina's message of "Thu, 12
	Mar 2026 18:18:23 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
	<xmqq5x71gfci.fsf@gitster.g> <abLw6vUUh36zFK4n@exploit2>
Date: Thu, 12 Mar 2026 10:25:25 -0700
Message-ID: <xmqqjyvhez96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> future developers to introduce something other than "shortlog", no?
>> If the version of Git in 'next' supports "longlog" and user gives
>
> Not really, anyone can introduce new formats, it's just an additional if
> statement.
>
>> "--cover-letter-format=longlog" to their version that does not yet
>> support it, it would be mistaken by the version of the code here as
>> a "log:longlog" without any placeholder that shows a fixed string
>> "longlog" for each commit in the series?  We'd rather want such an
>> input to cause failure, no?
>
> Isn't that the same for any feature that is in next but not merged in
> master yet? I wouldn't expect subcommands of history not yet merged in
> master to work either if I'm using a version built from master. This is
> an issue with the user and I don't think it's grounds for any issue.

Or misspelt "chrnological".  What are we gaining by removing it,
which would rob safe extensibility (aka "future-proofing") and typo
detection?

It is a bad idea to drop "log:", period.
