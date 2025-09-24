Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE6313D68
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732791; cv=none; b=a6Q4GU73dVR4Rq0f/JOgsOy5YtTj3sB7eql4Az63dCi6b58tibSeWI/YJfuqp/w+XVH0Gi9bHHsFuUkV0HvG59mXTpLvRolfEs34XIQSirDRx3EHmOIxEZQztRk7H3u4mOhag38q50YLrIpsR0lOVzHKWpJzo48+uKba9WPIzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732791; c=relaxed/simple;
	bh=anixDg7LGsiAKEye3vzDCmbMOgFKwZSpi+cgANG/Vg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGLKbmcchxWMCbbNlqgfx5146pcIDrrAkSkNdmFQvNjygBUFjYxNNG0dKBUMOfQNNbo93RpQoidd6nMkj6V01PnJhiQ+snogAnYtHtBYuhRinpkE+PaE3qm+bPsWNqFP6DMUScHqCTrzdbUh9CHxGdL3a2ownN/1FQJOUtxwyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RwltiS/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5ykNJOp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RwltiS/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5ykNJOp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9BEF1400075;
	Wed, 24 Sep 2025 12:53:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 12:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758732787;
	 x=1758819187; bh=HWRV+KLdxP/XhouWdNKaozqU69UrXHiFm7LUcDkom4U=; b=
	RwltiS/Xr58p7Ydl9hKu2nSX4IIIPI+xhKFdblQQwH7w1peeTjQwTRB1DpKFLaTA
	GjywfBuApXkKQEMjUcN64x3cqw8lalJ/bVyvgWpQQuH6lOm0EiX4Ceir7pJh5iYa
	UG+Fok3CLR24iBXZZEAE5moixyGXb0LZUk43AaGoYFA4BqNyc9F3THk4f8bfTV18
	6KX3tKslD8nE44woR7z6s5IaZFguJjK+/RX1Qa8gusoXYu8A0dJ0aQif6Q3FiSBC
	CZ0IqVx3CY0OHbGAa/N5Mu+hq+lQ+fssYPkH8BvHtW/T5G1v5kUto0obxru5Z7yT
	Mriiu29Q4WC0HWTz46K+/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758732787; x=
	1758819187; bh=HWRV+KLdxP/XhouWdNKaozqU69UrXHiFm7LUcDkom4U=; b=R
	5ykNJOp8xIPRAZPnQzAQ8AhrU40ycPNnGlWFWkyQjCQBDlBtaSid7i2QAJ2bfEnp
	7pmcKhqp94LCGp1Bd3tU6Z1y1BNck9nGicroLMp+8g2xFSIGEaZONHgPcMZ1cfFF
	Z0CmXeACW9DgLhwarqSaYLZwflPgThLKYeOsxWCTNvt6QboPgzC7p5VAr3BcFlnC
	NfpH/2r+wSFYVYTxAK/RJY0hrt2cDOGS7msWtpzPFx2+dFwhm8AxcD6gvgwhrNHZ
	MTeKUpRM/XnRWACyBkK9idi7fldcmxfa+bxbzo+tIttW1nyTLsgIfzZCFx0ek/Wo
	EbLcGpLbCTeFy3k5dyq7w==
X-ME-Sender: <xms:8yHUaPplzaOK-yWEoWRXh7RSeihTIKXJFU7HMn7eRvQTw2SEt3R-fQ>
    <xme:8yHUaArIuXn6apCNAHJbwZ7BGkCk159V0_4AjoUKlQ8qndBtaUH5qNraeV8K_e6wB
    b9AFmyhHyXDCpNnhebpN4kOHlTT9y9ytphdx14VYsWjVhpw2SSPFWA>
X-ME-Received: <xmr:8yHUaBM29UAD9ZzofnZW2DtS389JVXg391WimN1t-SNJErSfUkrqdB4s91JtRI3yRd4-0g_Goq1EbJTk_UZye3czb7JdMoRafv5->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomh
    dprhgtphhtthhopehvvghlohgtihhfhigvrhesvhgvlhhotghifhihvghrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8yHUaBwmoSP5o4cUbFgxtWdgITD6lfrqP_OvQtqtZHqWeErxNSavcQ>
    <xmx:8yHUaKuX6wqrjo3g4L1yLNDYFTvdnuNzjJ9AX17IFws21-Z21jCssA>
    <xmx:8yHUaK6Dzbqj8x0o6dSZ3ltNzLyuPVMCWHnesU-H6iCFv8kTzZ3djA>
    <xmx:8yHUaJR4Iv5nhQXHQaDxfltWDdiONWp5PIKi6woenyafnwSw523fuQ>
    <xmx:8yHUaFbrD5MNj2kXDqKZDlTSvsvjYmQNUEI6MLH3uwpKCY-5OvU0KZKp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 12:53:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>,  git@vger.kernel.org
Subject: Re: 0-Based indexes for git log
In-Reply-To: <aNQRoMgSRVvNtStG@ubby> (Nico Williams's message of "Wed, 24 Sep
	2025 10:43:28 -0500")
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
	<aNQRoMgSRVvNtStG@ubby>
Date: Wed, 24 Sep 2025 09:53:05 -0700
Message-ID: <xmqqh5wrn66m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Nico Williams <nico@cryptonector.com> writes:

> On Tue, Sep 23, 2025 at 05:15:46PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:
>> In git log it uses a 1-based index for the date instead of a 0 based index.
>> So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say "Fri Sep 18
>> 14:23:24 2025 -0400" (or "Friday 2025-8-18 14:23:24 (-4:00.00)"  to get a
>> better format)
>
> Day of month numbers are 1-based.

Correct.

There are a few things in Git that are 0 based, but not so many.

 * parent numbers are 1-based.  HEAD~1 is the "previous commit", aka
   "first parent".  HEAD~0 is the HEAD itself.

 * merge parent numbers are 2-based (sanity of this statement is
   already questionable).  If HEAD is a merge, HEAD~2 is the
   "(first) side branch that was merged", HEAD~3 is the "(second)
   side brnach that was merged (in an octopus merge), and so on.

 * reflog entries are 1-based.  @{1} is the "previous object pointed
   by the current branch", @{2} is one before that.  @{0} is the
   current branch itself.

 * stash entries are counted 0-based.  "git stash list" shows from
   stash@{0} that is the most recently created stash entry.




