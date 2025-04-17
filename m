Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C022D7B1
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877683; cv=none; b=pmdFa3cewy9cBkYm2Rfo5l0T/vdRrgxVTTfxnF6rXV0RDCvqSV2eDB9O5IV6/l5kMwcG7EXSv7kF8bTmf3xisreIt69Og1jaIMOeGz4wYvL1g3MNljAxht0evsvbhZIY4fs/NuuwoKwf57gS7DPRUSRqVAZBjn0CG0kvIpDTxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877683; c=relaxed/simple;
	bh=m6SEhUi6ypvnyq80/+75m+6cGf3ltuS/DvfP4WnepZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYisX5k135N1KorOlrYdQ99AVd+jfPyEqb2qNEUiwTQ0LUZdT9Xx7LtPOkFVnG5jgFTOG126U8YOuXaOxesqcbgtLigm1txfnRkzUtxka0MgLJRqTVtnIKP+0DrofSQ2Zr4/dEppZ4GFukLQfAaSVGqHS91MWs3uj3xryK1hOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EJ/1Bmd4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aPxdW9W3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EJ/1Bmd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPxdW9W3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 834C425401C9;
	Thu, 17 Apr 2025 04:14:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 17 Apr 2025 04:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744877679; x=1744964079; bh=xtUnf4BFQ8
	FfR+ZRXvR7bnu0ZGnkzO8HRo83ATjeRHc=; b=EJ/1Bmd4qX+Hpt/MBtIQ6PRWHL
	yePq2jc03f4ASgW8HyywbjFDPq+xVguB3Q60HVqA0cQUsQMgByTulCejv6b1WxiH
	8hMU+HepadQ6ZJTLELUjELY78gwG7/nY+DqBmHY+YIIHFg5ttwnTh7l/SydGDVkD
	Z4dbtHaGga6UwDOEJD4MBBj7wEi1xM+vBi+mFUzjJVA/GovZiJBA06Zjk6DHvmsh
	ABEkGjU22B6WM2yDFK6rdiwxBRMZV9qw5WwoCJNFZ+TM2eAAxBR31wf3tb2EtKJx
	TSgFQmsC8FMa+V7rcRlqfezaQOtNppwvbv+LZN++57evZ39Bo7QFKGR+sBkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744877679; x=1744964079; bh=xtUnf4BFQ8FfR+ZRXvR7bnu0ZGnkzO8HRo8
	3ATjeRHc=; b=aPxdW9W38G7nuEqbPKvTZPIWpOZwNWr6vf4oANad94qucD632Rn
	1FwJMf2Xjh/bn1SMvFn39n16cdkw1f4IEmZavDO7FtPjhNG580fFcfgZWgkf1AK+
	Mr5JMkBP4vxR6/7rsziMT6efyeoI0W/kLu5o7UYChvs4VTt2URHX3rQf/pX34BwA
	L8rcua5XXiEyqua2rKtRygOZMna0UX/JB0Tf3bPq3CsuTqOxI4QEBPtE2s+ERKwE
	FXRPANZDc9JUJUR7bydli0OZnqO1JniMayLpeTdcRE21sMjHcBIZc8vJ6IB0wtmo
	+R5zV0UxjKNA/mJGn27+xr+5+n+CkKYOcuw==
X-ME-Sender: <xms:brgAaOqe379_Spo7x0gl8QE4u7s6bv-hVY1EEqPUTOWrAuAdiRtGpw>
    <xme:brgAaMoBq04g_kYxZ0ZgOGhBshDHR3f5QqXNv89ck-6D5adK65v8uGhliFxshrpQK
    fdNoKnDbxU_ftKjOg>
X-ME-Received: <xmr:brgAaDOXA-xX-tFRVB35Nyqv0Rl461v5xUslDa5Q15Wl2frCb86ZEn7Lu8GSht_badpu0HUyHlDppvYR5FbPzpKbpiqTPy4cyaIr5EoyaWBuocAF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:brgAaN6eRpnd3Gq5PM1TD6e6vFMHkTQwGjuxKTJhY84bRSVvfyWk9Q>
    <xmx:brgAaN7cuOrhoMsXuqh5Rv-9HjPXUWQMrNeZtHbyW817n-gDop8uFw>
    <xmx:brgAaNgatKgAeeqB066AmwafyhVIJIhr1MnotwARJFhiVmsSyJgKfg>
    <xmx:brgAaH4PiyYb5mXwtXiMYg-LviKw7yXjrAQr_Tbx2b_AlV_KVKB-1Q>
    <xmx:b7gAaMdGaBtLt1wD26rO6A0nh9qg9Psx58yD6V5u57UF58Ct5W_ds_dJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 04:14:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ab69025 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 08:14:31 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:14:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 7/7] parse-options: introduce bounded integer options
Message-ID: <aAC4UwjLBllfeDLV@pks.im>
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
 <20250416-b4-pks-parse-options-integers-v3-7-d390746bea79@pks.im>
 <xmqqsem7hq2k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsem7hq2k.fsf@gitster.g>

On Wed, Apr 16, 2025 at 12:19:31PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In the preceding commits we have introduced integer precisions. The
> > precision merely tracks bounds of the underlying data types so that we
> > don't try to for example write a `size_t` into an `unsigned`, which
> > could otherwise cause out-of-bounds writes.
> >
> > Some options may have bounds that are stricter than the underlying data
> > type. Right now, users of any such options would have to manually verify
> > that the value passed to such an option is inside the expected bounds.
> > This is rather tedious, and it leads to code duplication across sites
> > that wish to perform such bounds checks.
> >
> > Introduce `OPT_*_BOUNDED()` options that alleviate this issue. Users
> > can optionally specify both a lower and upper bound, and if set we will
> > verify that the value passed by the user is in that range.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  parse-options.c               | 40 ++++++++++++++++++++++++++++-----
> >  parse-options.h               | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  t/helper/test-parse-options.c |  5 +++++
> >  t/t0040-parse-options.sh      | 33 +++++++++++++++++++++++++++
> >  4 files changed, 125 insertions(+), 5 deletions(-)
> 
> It is certainly cute, but unless there are plenty of existing users
> that use OPT_INTEGER() and friends and perform bounds checks
> themselves, I am not sure if this can withstand YAGNI criticism.
> And this step being at the end of the series, plus the above
> diffstat, tells us that there aren't any existing users converted to
> use this new mechanism.

Yeah, that was also a bit of my feeling. I was on the lookout for
callsites, but I ultimately didn't find too many. Which is basically the
reason why I said that this patch is more of a PoC, and that I'm happy
to drop it again.

> OPT_INTEGER that wants to track percentage may want to say the value
> is between 0 and 100 (inclusive), but instead we take it bounded not
> to exceed 100, without lower bound.  Without a real callsite, we
> cannot even tell if it is acceptable compromise for the sake of
> simplicity to forbid 0 as lower or upper bound, for example.

Yes, `0` meaning "default" is restricting us here. But my counter
argument is that a value that can only be between `0` and `100` should
use `OPT_UNSIGNED` in the first place, which allows us to achieve
exactly that.

Let's just drop this patch for now. It was only a PoC anyway, and we can
use it as inpiration if we ever see that this feature is something we
want.

Patrick
