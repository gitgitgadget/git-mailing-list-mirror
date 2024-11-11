Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3115CD41
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316183; cv=none; b=mtDEsvBBxbSo/+Mb3IWnBtuboQwODwpYoKWqPb0YjUgzlH6NGhyL2whtJGbKkjWKGxmf+dmM83AHDgUsNw0QV7epWgmeDspUVELtPKksm5ff27kLi+kJugqOH8W3dEk8YQxKUjRdEebkgCpjNv09oi4sAKJNIr/7Nk5fT1TIvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316183; c=relaxed/simple;
	bh=c4L/XQQrS2AFmfLiLLEzXG9UiQWZnOtRWWkm+7smJIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKepvdPGVFvO8qSdLM6HAVGVIqf0k89066ixcqz8/gQVLHdyeZu6UvlCOflgL+B7kiOvKqa+53sHfxLADPhjyR1TIf1cAUtNGO1TH2keNFpWsmbeyWNNkODo7ZVLpCsHU+73HaAhCDIBCjexHy0aneriLIyjM5ZJ7VAMw/8ifAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4Fz5rcAe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMfPCMvp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4Fz5rcAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMfPCMvp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DB94B13800E7;
	Mon, 11 Nov 2024 04:09:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 04:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731316180;
	 x=1731402580; bh=Xt/RcyRJD7G1OrtlDafmv6QpzN9sg4YRNOhBSddxDrE=; b=
	4Fz5rcAeXIetbsgm4PLBF8b2AcT5wILyMdPwTDOgCuBaj3QxOQLAL1VYVqusfnSH
	MfVrfXhlfqgubtLS9cYxJZUGX5WLE3o733aGajx7in0mlXPOJyKQLAdc4Fv7IzXf
	+Ap/NQ3NhE7MP5K+HyPWoXFFRsBRd0vIevbV+0VgIEHHjmktqkztrKSnZNWwh1Xk
	cxpEEAJTUM/S360eYBBkheqjecAGPSGd9/EqmDwYb0d63v8CkTRWF1jtbAGtGYZk
	pcL4GshDOSk3kMnO4H8EepdJ5mqvPxK+rKnGUMuR70vwCG+zW9D/rtM72bs6MH5A
	bXjVsxX+XUCFSxwLvUNLPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731316180; x=
	1731402580; bh=Xt/RcyRJD7G1OrtlDafmv6QpzN9sg4YRNOhBSddxDrE=; b=h
	MfPCMvpeQxGSyXQ+BSmqDLNgHZudp1Y8yGl0xZrKuccIaNbWDIZfk2thgsYJoHdG
	YWLZ39KT6rkfENgJlIq2BZErfb4J8ttYk7Zgq6ktNf7hq0SML6OCK6Qoipze/iuD
	xUj8I0zEljPcbJRmMOgrvT6JrDVJ3u1OSepZ1+tKWN0awSaRTK6CUzrfe4qekZXt
	J7FQfwrRzYLepupxiue4sEFkNj9DKzTA52pDUoaEoCsRrmuxc5aM5WZ+17ifSbjG
	E18zDA+k+tnnYoAB8wWh1Z0y4ZaKMPJrOHD/db4VJZK+UZRpf1AFywdk2xz9A3nv
	prGEotAmpmK5fb741dPiw==
X-ME-Sender: <xms:1MkxZ1stzwtHKoer1pL6m-uNZ3HoAqlqBhFnc4iu-JLHtHd-axGSbQ>
    <xme:1MkxZ-ct0CsRoL7iVVlajX8Bw7-p08jgqLOiBJhXKgb4m7BC8EuaBTrPmvdQzni7O
    Xy8oZPGlwm7aMJ3Dg>
X-ME-Received: <xmr:1MkxZ4xtNUselEZIB97RnF49ROzcbr_Wil65m7xVdZnU_CA_bpyHZajs-hFTjmKSMpe2mROMikWSwRK0QOEGFRcwzvrR0r1t-SrhksrpybeWVElQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveev
    jeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1MkxZ8PYHrBjCKZmfEnA0_X5u5eQ2ZsjRxmE__YRD5G6Il_lpbbM8A>
    <xmx:1MkxZ19B6d0lWCGcV397lYsAG1feNLN4gYNLmDmYkJte4IDA7oSZgg>
    <xmx:1MkxZ8XLhjPzdM0Ep1OR3vvikR_vhksY81i4HCCehO29LheinPqcfw>
    <xmx:1MkxZ2dSsS0H1lyNess9_rnbqe34Q61Iq-d4c0QOV4flcyCN41qD9w>
    <xmx:1MkxZ3J7Mav9wATLOuxRA-qEOhtBLfpHc_2MdrMDZW6qUpsRgCBvyH2P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:09:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0356c8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 09:09:05 +0000 (UTC)
Date: Mon, 11 Nov 2024 10:09:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/26] help: fix leaking `struct cmdnames`
Message-ID: <ZzHJy6XRywOltUx1@pks.im>
References: <cover.1730901926.git.ps@pks.im>
 <2fb012662d6c5720be1fe86973640c7a2d6f5681.1730901926.git.ps@pks.im>
 <c376f2ef-fc43-4815-8e26-f13da3729ed1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c376f2ef-fc43-4815-8e26-f13da3729ed1@gmail.com>

On Sun, Nov 10, 2024 at 10:46:29PM +0100, Rubén Justo wrote:
> On Wed, Nov 06, 2024 at 04:11:03PM +0100, Patrick Steinhardt wrote:
> > @@ -630,7 +631,7 @@ const char *help_unknown_cmd(const char *cmd)
> >  
> >  	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
> >  		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
> > -		exit(1);
> > +		goto out;
> 
> We haven't set a value for `assumed` at this point, so it's NULL, and in the
> new exit path we `exit(1)` when `assumed` is NULL.  OK.
> 
> However, I think we don't need this change.  And keeping the `exit(1)` close to
> the error message seems like a good idea.  Perhaps, in another series, we could
> change it to `die()`.

Yeah, good point indeed. I'll adapt this.

Patrick
