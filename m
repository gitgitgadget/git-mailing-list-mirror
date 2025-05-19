Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BF35946
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639080; cv=none; b=gWrmoeHctv3K5h+xfTtHWbMJ5WiMhf3tph0qRjiF3LJFKQktRpItTWYCnMWKqv+rr3x0h5xhvdnhI+BMmAtU9SG5EDZVPUjRDY+z0sRWYpoPlpctZ5LjlLrqz+JFhrY2w/7fJUFv057CJrvSzm1CsLDs/G9fuOF2omSTKZAwyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639080; c=relaxed/simple;
	bh=HZxMPPK4/XBNiSdr70sAoKTD50gm+Q/JJ6w3KpTNuQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXhwSzDPmgytohZEGiGcfInQUtCD1qvfrtfdPWuw5c9Tl6u5yvFciow9IQTCewGlyCG/ThSRTKFZ0X64MCb0rP2bZAyhTA3NqoBpboGJ+ph9WPawQGkKm4e+cn47eFYYAL2HiwY7hoqa8Nyq7dWV05cujWTo2qWOGv+D+HUtYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y+eMvNbF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5//kX4W; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y+eMvNbF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5//kX4W"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AA49811400C1;
	Mon, 19 May 2025 03:17:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 19 May 2025 03:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639074; x=1747725474; bh=ETQK6LBD+e
	MKAbz05wX+5kQR4aTnRuAzcB8iDXwI7HQ=; b=y+eMvNbF8tz6XUztaGx7EWY1Io
	Sg6y6sxyuB/DmTj3DDVOLfN9i+WT5auFkc39HqojetyDm1PaASgVbk06LECgl2TL
	4WLX2BQbNRYK8joCYu0QeAAxiKP2v5/hsZsCySz+oa7H9S4yrT9YLhc0Lluu+Qby
	c3ePNvnyvG4uUNG1g43g7uR3GtQ/5CgTu0YnCatQ8jVI+KRFwTnOkFUkIs/1XlOl
	q9zgwfVToP6SNlYavP3c+P6NO1ipxJtXFfIoQ2fqiYhf04WVaJovFYz1c2DQGLzL
	ISJyFLiuuaWx2LWHC0K2T335UbR4S9ricI/AWR/mNejcm1cwxP2CHXgWTT+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639074; x=1747725474; bh=ETQK6LBD+eMKAbz05wX+5kQR4aTnRuAzcB8
	iDXwI7HQ=; b=r5//kX4W29SBe9x+cU4NKr2kGyZGOvP45bXOeI5ytY1HGEpnvDi
	bJbuTGZB0qZbl4cW3MbnDZFAMUjf7L8p0WTDdM4D4RG4YzpIUVN0b+H9Ua7LMZoy
	7Az6gjecfoyxSCo+de70QQcvxh9x5fHokES4Z1u/4eNNbcLzdlYAwfLz08mj9FgF
	ySo7nAV89BeuCSydxrH6Ltr+6BBF0veiMj83YIaE2be7n9DfQwMXGgJT0rOp4Jau
	xM2YmgAwJoAVw0OlTVrbA6fPsVELi4FXKuydj4Y1E8eKztQ2iBeudM9tv4zJ/Pdb
	u+o2cjmaEVI0G6nmm8U8nZ/QXIK5qdDlm4w==
X-ME-Sender: <xms:ItsqaO1szs9LNcDOacyZIeCM-q5fLqztD8LaatzJpiOGZJQifVBELg>
    <xme:ItsqaBFrMymcyajewUVra2eM5BvpTQo-44vVREAEIyiUX5Z4_x6SmRtGqM5NaEHr3
    UOnPVv70UzbuogZSg>
X-ME-Received: <xmr:ItsqaG40Iiak7GxwifR-_DYd9GJSW95yfKmtkoLUd8dWhmOOvFMr-61O4vmwZ6ia_ZTAjvi5zA3Dm_d3UM91OYmYuaJaEALIwYd-GD8JryTV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ItsqaP2S9vUiEPYHAFRzOg41H80x8MePZwbELCQTY5__TSkkaoF90g>
    <xmx:ItsqaBGoi2WrQy1tTBz5cipfIv1c9WTZYdVwfTFPdQ_m7XHf0QDwjA>
    <xmx:ItsqaI9xCOS0i36WEw_Jhs-EJ8jhQ39RYhMK3DIj4nHd3W_wiPlhfQ>
    <xmx:ItsqaGllENKHTZQQVh45A5h_6vb95t0mgTQderMlG1_ExTSbC7UcSw>
    <xmx:ItsqaAz2mwnwRoEJAVx-6ZQD1Sd5mS6TFllDOMYVH48Hlpf0wwQP5mGk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:17:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73397361 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:17:51 +0000 (UTC)
Date: Mon, 19 May 2025 09:17:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] string-list: fix sign compare warnings for loop
 iterator
Message-ID: <aCrbG0lavNa9Plc5@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDSyycHNvFCT93@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDSyycHNvFCT93@ArchLinux>

On Sun, May 18, 2025 at 11:56:59PM +0800, shejialuo wrote:
> In "string-list.c", there are six warnings which are emitted by
> "Wsign-compare". And five warnings are caused by the loop iterator type
> mismatch. Let's fix these five warnings by changing the `int` type to
> `size_t` type of the loop iterator.

This naturally causes the question what the 6th warning is, and why it's
not fixed in this commit. The answer is that the last one is more
complex and handled by subsequent patches, which you should probably
point out here. E.g.:

    There are a couple of "-Wsign-compare" warnings in "string-list.c".
    Fix trivial ones that result from a mismatched loop iterator type.

    There is a single warning left after these fixes. This warning needs
    a bit more care and is thus handled in subsequent commits.

> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  string-list.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

All of these look obviously good to me, thanks!

Patrick
