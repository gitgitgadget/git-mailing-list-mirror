Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBF1514DA
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954513; cv=none; b=q1I0huML4Z2oEzpm3jyVTLQSKuu8VXfNV1Fw3xqyt1Xljk4fOiDb1yZWoaoQSqPfk42YZN9J/cy+JRZ6dxoNPoktBC8r2sCyxdMTZLHlZpd5bpdoUInMxzxv+tefUW5CRFmBZMRrDniC7KaNa2ZfXlVPLCa/epVsMZRUoTk912g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954513; c=relaxed/simple;
	bh=RjJFDQqAuNQf4l+8dr16zw1lTwFByrxr4A3awGuUYOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHN4AwtLrN/wiIfVnV2cjT3RpMmW7yiDT1HgWsgIXe3SO7kdcwEdWoZO96myq+yLO1GuHPfJump26UxcvLO3c3h5yi3djnewo/LsII9LgmwPzosfqHOy2W64yIYszX1URAAJ/GYgSVQ1BkUe2i8ld8pvwCi6hyDTlI2FgbDnmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QelyJI1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JkaWIy4R; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QelyJI1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JkaWIy4R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D4B5138027D;
	Tue, 10 Sep 2024 03:48:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Sep 2024 03:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725954511; x=1726040911; bh=5uHQXOgL31
	B10OE2zOqW0nO2ZaJqL071c26nw924J9k=; b=QelyJI1PQUb8wvv3Zg5uMI0ZQr
	lR7Pl/QZWeIU7bv7If9QfTybJ1T3NPzMNjUqC/Req17OIcEzqxMj7VWVaieqld4O
	C+Vy+W5XekBoeLWfmFDIm1cHYb6Wges0TzkBUVtK87B1EaF43RquMGKlVf9ki8Ex
	xbSFGIk/2np7sPikzSqV3zuNwzLy18QULezbUn/WklZi/hXqkKVmZm0Jd2dYw3fX
	vaB6XTAY1h77j9zmVDWhU05theojW2+/4JacEA1uRAspwQONGN6QDhNGM1rGbrN/
	5SxXbgmiPTWTO50W+4MUIWoxbTfdz5IzFLzr9frgtAyrXz22n4VsdbmHsiYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725954511; x=1726040911; bh=5uHQXOgL31B10OE2zOqW0nO2ZaJq
	L071c26nw924J9k=; b=JkaWIy4RRSF2E8cHUcjzCFgFbM+UvRaq7wSjfM8IMYBL
	kEPBcWeLUTe1w8llAYUsU/ifZTe41booNsKTcF4s5larbSYr7JtRyxGS9PsPH/CD
	a5iqt+U96Irmfd97FMtPE8oOMagiit5hcBFCRu3/jgYBnVzdvYSegAn50UGtVaPT
	K9MmFymfXg6pmQ5QjAT4mrHFM/yb+z5bsZu5q/kjqiRTRSfv55fOd5v/+Q2J0JoA
	ZCg+Oi6PVZdUEaYmMRL+wFZ1BxTg33lmEfegRMjEmMKKVset4Q0jFvDoI9XoY6LF
	YVNfEBsQu+yZKTI8+UVLBln2Oti0+eBqhGR9W3W3UA==
X-ME-Sender: <xms:z_nfZqU7jTWzc5rLBs8UPkiAnYvFsmPJ-btykVnhoi6relutbs6oCg>
    <xme:z_nfZmm_ygpSUZ36zM9vYoi9jEThysM47k0PmOEZzFcgENRLHr6ezBkWR2O9A6-7L
    avrPuoH00d1QABAZA>
X-ME-Received: <xmr:z_nfZuYteDo2B54LfiRT-961saaK3rMKOeqtTgQlOiTBAimAs3N2mTupt6-7eq7gBRfCaQrpIAl2r4lKW6tU3IZHPDH0TzNKU4L614UseN3QWZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegvrhhitghsuhhnshhhihhnvgestg
    hhrghrthgvrhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:z_nfZhWbU-eVLs7Ek-0Us6KnWooVfQmkVLML13iKCOhyD8N4NM5ueg>
    <xmx:z_nfZkmqjQVMbv2_2UBetaE8yFmRXk-MknPpxdzD3MMJNEQShOfrSA>
    <xmx:z_nfZmezgW5NgTHRFLtBWlOI9X7atA1JgoZ5QsLLYC0FT1OPn-2a6w>
    <xmx:z_nfZmF--bvAqJ4Su4i7Fz4lGOZr1xoYGIRDaLSVsbCf6AB5W-sL4A>
    <xmx:z_nfZjswMbOoKGtp0fAqblLvoBXcMrcrcU_cRIflct5tmCDjqghu3lfa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 03:48:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39b9f166 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 07:48:26 +0000 (UTC)
Date: Tue, 10 Sep 2024 09:48:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] chainlint: reduce annotation noise-factor
Message-ID: <Zt_5zMiu4QRka5x3@pks.im>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net>
 <20240910041013.68948-4-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910041013.68948-4-ericsunshine@charter.net>

On Tue, Sep 10, 2024 at 12:10:13AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> When chainlint detects a problem in a test definition, it highlights the
> offending code with a "?!...?!" annotation. The rather curious "?!"
> decoration was chosen to draw the reader's attention to the problem area
> and to act as a good "needle" when using the terminal's search feature
> to "jump" to the next problem.
> 
> Later, chainlint learned to color its output when sent to a terminal.
> Problem annotations are colored with a red background which stands out
> well from surrounding text, thus easily draws the reader's attention.
> Together with the preceding change which gave all problem annotations a
> uniform "LINT:" prefix, the noisy "?!" decoration has become superfluous
> as a search "needle" so omit it when output is colored.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/chainlint.pl | 3 ++-
>  t/test-lib.sh  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index ad26499478..f0598e3934 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -651,6 +651,7 @@ sub check_test {
>  	$self->{nerrs} += @$problems;
>  	return unless $emit_all || @$problems;
>  	my $c = main::fd_colors(1);
> +	my ($erropen, $errclose) = -t 1 ? ("$c->{rev}$c->{red}", $c->{reset}) : ('?!', '?!');
>  	my $start = 0;
>  	my $checked = '';
>  	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {

I was first wondering why we didn't have to change our tests. But this
seems to use either coloring or the `?!` decorations based on whether or
not we output to a terminal. And as our tests output to a non-terminal
they indeed see the old format, and as such they don't have to change.

One thing I don't like about this is that we now have different output
depending on whether or not you happen to pipe output to e.g. less(1),
which I do quite frequently. So I'd propose to just drop the markers
unconditionally.

Patrick
