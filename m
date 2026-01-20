Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790F38A29C
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939915; cv=none; b=m3PJHkCdZcLBIMuNEl9+wrOGBhDeT6mlzw/l2BydDm9Oz9gzjDUTPgK5gizEC5YMhJt4OYd6n2GRj3Gwammpdw7Dm4aLCTqEeugcMOcQbDa+wiQYNTphzgGTYIaXJ97/tSdpm7ikjnw05ivhNiC6BS4fVy9ALBaWjarNA7mCxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939915; c=relaxed/simple;
	bh=G09M5yPBiLhRTlvf7YqVAMMoElMDlg0QEt1T8UFnjfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MjiQ67kFaeubwnp/OyOyfLQROz1YGIHR5z8MqfY27mpKf+WTN3f7rBvRjTB3Sr22aEZwdrEAhFDYGW868s5shhLgol9x6RUlzWojjVwcQGZo0no+2oGVQ6A7LrzRcL2rinh51RFIOlypSvbrVmYKN/VkY9TzPp5ywenzH4RRC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ahCBuLMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0okT561O; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ahCBuLMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0okT561O"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8483C7A00C8;
	Tue, 20 Jan 2026 15:11:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 15:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768939910; x=1769026310; bh=+jJ6RgcKQ6
	eebXcgBBO1wLNMA1//JGgscme4GYVMI0I=; b=ahCBuLMz/Vw2IBHJNQ3TxQf0in
	J/wbxtD5I5GD82c4Ow8nttSEOcT7W1nYhMbswzqyawjo8FQHw4CSbDoaBKIofBr9
	xU/h2ghd0w8osk/j6GyEns3Ceadk51v6v8Rsgdul7VvArezAgl9C1irIqQivZL+a
	vvOdHYXjXyAuOkFibnvjl62FmeI9w0DKW65xC456Yrs012Uzd/ax0fwf0D+06PKj
	TlqaKXBRH7yIdE/jxqmfyqdnBd3RwwW6TFkV3mfACgtO6dzQ1WhX55DS2Ov3uhrk
	s/iU2v4mfp/OV+wsHH9y/q4dMhFgWCWCdTDQ3yS9eeCoVQlFQi2aRJ4CjC6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768939910; x=1769026310; bh=+jJ6RgcKQ6eebXcgBBO1wLNMA1//JGgscme
	4GYVMI0I=; b=0okT561O0XzS1q2XUAayZprT2Qs0TOHxQveMsbjd8K2WmFYZKxb
	mS6cZxRYsWJvurcsCf+oVS9M8DS7T9l99IGLZqE/IlfDQIlSqK3Hh1g/xUEOUYJg
	x7MA7iZ9jTqu4738sy02B/Q7eHDwJ5g9vtcdjhQm/kyrEpjhdjiRXXmKc4QfD0Ss
	i9imd8XqYUkkq2Vg7mJCau2Gtug4Yrwucuwi7u3FFYeDTjpltd1tsDdb7dyjbr2v
	4N7T/FaUdWMmS59I64z1SdfurxD/nyybhxfYr+FpXhdJZ/q8xqY/tGrt4sLwVWai
	pY6BvoUGbaRpYfwgWhToUPDTkzrJLPFRTDQ==
X-ME-Sender: <xms:huFvaQn2Ne4mfIk4zr-LU2hDNoxqGWA3B5OjNnDLqLYGsz_R7OAJWg>
    <xme:huFvaca-Hf5CXHp3EyK6oE5JTVts6ZZCDxC0xBSqcxGC6ksuq0PTGqQoOCw0rBtMh
    qoHYO3GNV2HeG9DihxQp--cBTm498qHWK7k_qjnaE2S3Rg8sr6O7A>
X-ME-Received: <xmr:huFvaTFXPvIW4XWxyJzEPzB1uVhy6Q0ODnaFTkXSyVI6rIUlc9bNgfqMDpfpYurRp6GVBkk1m_vL50sgVuXZQsCyVU32n4QfPSNRFpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieehhfeuudelhfeitdelvdduieduteeludelgfefheegveethfeljedtkeet
    gfehnecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhmpdgsuhhtihhtughovghsnhhtsh
    grhigrnhihthhhihhnghgrsghouhhtfihhvghthhgvrhhithhruhhsthgvgigrmhhplhgv
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthh
    ifrggssehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:huFvaTYngjYp-tFeOTHseg2_x40PboDYoc4RAtLsVSAYOxnzs7VP_g>
    <xmx:huFvafwNi3oDSvamKhUfaUSRYUiP80Vg8SSBuuTKd4TbUmWveV3OTg>
    <xmx:huFvadTTF2EBKFXIQ5U-t5cHOPtjMfeakFLmgOckxnmxArIGWuIp7Q>
    <xmx:huFvaUISpnKuDltBrQ9Kyg-BPmSPIMefnDqIHDz5FJqNBFkTlD9htA>
    <xmx:huFvacxfq1sdJ7GxG3kr_am_am-W3NXTJFLfIom3bBlaZX49rDlu7DaR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:11:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Ondrej Pohorelsky <opohorel@redhat.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <20260120193109.GB3295894@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 20 Jan 2026 14:31:09 -0500")
References: <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<xmqqa4yeblsx.fsf@gitster.g>
	<c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
	<aWnekt4ESo0bKpOT@pks.im>
	<CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
	<xmqq3445bn33.fsf@gitster.g> <aW3bSYCIPMhJT1mf@pks.im>
	<aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
	<xmqqa4y81ag8.fsf@gitster.g>
	<20260120193109.GB3295894@coredump.intra.peff.net>
Date: Tue, 20 Jan 2026 12:11:46 -0800
Message-ID: <xmqqfr80yrgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I hesitate to suggest this, but: we have a similar distinction already
> for protocol selection, where GIT_PROTOCOL_FROM_USER tells us whether
> the URL came directly from the user, or if we were directed there as
> part of an untrusted automated process (like a .gitmodules file).
>
> We use that to disallow file:// from .gitmodules without breaking "git
> clone file://" on the command line.
>
> So we _could_ use that as a signal here, to suggest that servers you
> feed on the command line (including remotes you've defined) are more
> trusted than ones that you may have been redirected to from a possibly
> malicious .gitmodules file.
>
> But I say "hesitate" because:
>
>   1. This is a convoluted scheme making heuristic assumptions about
>      trust. It was a not-so-bad way of compromising on the file://
>      thing, but it may not be worth the complications here.
>
>   2. The trust boundaries aren't quite the same anyway. If I feed
>      "https://evil.example.com" to Git manually, I can verify that
>      "https" is the URL and that is OK to use the HTTP protocol. But it
>      doesn't say anything about whether I trust example.com to write to
>      my terminal.
>
> So maybe a dumb direction, but just thinking out loud.

Yeah, I think #2 makes it unworkable for this purpose.  When
somebody you met recently at a party and you not yet know how much
to trust told you "You may be interested in this nifty add-on I have
in my repository at https://example.com/nifty.git", you may want to
clone it only to peek at it first without trusting it.  So automated
or manually fed from the command line, I'd say the destination where
"git clone" goes is much less trusted than the cloned repositories
you keep (presumably after inspecting and interacting with its
contents enough).
