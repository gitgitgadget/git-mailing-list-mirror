Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2E1514DC
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404299; cv=none; b=YsDFxlXw8j6+kle/GTf5G4PQX+x4CYiSf3shxOdEVAiP41EGJUWhUesQ5z9uiBfPpthGotRL/uqDInGytSy3kC0c2mzDuCpoyLspt27vvOCeITeFJuOmV5PYq9LFAYRsppJhl5jFosiGWYYONzhWK9AuxoSAFr5Em2gYVWKcnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404299; c=relaxed/simple;
	bh=gBe2/7gSXRFGOhJ+NAUbwlMPI1vCdi+3gnWfGBvl1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnCQoOy18LNpv9b6G0nqye7djIv/C6K+MrNDo2DXiLHTIy+FvxL0QCIhf+p8WRIDNGJ443UJMfwqiQrUUoKTIVEzm9qLo3MejrbuRoJJN5uCeMvwMyFRHH9kyNpLnO/UaB2vClvPqk4RCEFjJbO3mcc+RO51H1ryLsBwOFWB/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JTeFjO7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jS4LZDwt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JTeFjO7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jS4LZDwt"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 95A941D0012C;
	Thu,  2 Oct 2025 07:24:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 02 Oct 2025 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759404297;
	 x=1759490697; bh=2o3dG865JU/U3Y1E8pt1JuSu/zpxpCh+H/rzLpamtKE=; b=
	JTeFjO7Q/HhH3eEV5+TiT4vnINO92659SLZIPJjVm114TMrxRpIbAl8OaAuj2Vd7
	q3nvhDxGGTTXzITvh3gk4caux3hi+IifaDmp7Bpe3yyrLbE7fbgnRnhd8+i0eaqZ
	WvpREqRkTm8PFol6lXdt3yCGHYzVjLu8p0mpTGSWr1kHyO1DZj7i/SDbIYNMKVLe
	f9XK5+8esUPqCKxF01d9is9ZIBU+A6kMZIoc94z1OXsMIaO3aODaA3jTThBD6/2w
	N680V4E7XOvGa5828TGUjCE8x+heL1Ecod7FXiWqrXrEJ6N1oDiKTKfhpjVTScqi
	PqcF6h23QyKHZE/Zuyjxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759404297; x=
	1759490697; bh=2o3dG865JU/U3Y1E8pt1JuSu/zpxpCh+H/rzLpamtKE=; b=j
	S4LZDwtU+iLHH2WQzoT4nkU3o8r4jiFq7FrLtl+lejxxUngslWZ6swG7hxWNClXI
	zMEC/SpPVDxgyUyYiuHyrmYNNO3zjiHJOp0rIqEn1+VL2N9RxHn2C5HYA9r3TwUu
	k2HhFF7BjDLm2guA69U1UPvbk4m5mkfMBKE8seTrboiVwpGl0ZNaRLw1u9TqsWcN
	9GJ3wJaXgyO9dZiN5wlgnom0xjwGjjkJ8DLtjof2SwNAbylYEzxVQb4TJAfnzH7e
	dc4iyw1XVUcVUFnO4pBDTun11VDDE6LctYuCAy/FiI8X6ILLVQjl49yd5072gwJS
	rqlKui9e1DYlr/P6UD7OA==
X-ME-Sender: <xms:CWHeaBd2B6yy9oTmtAFIRPnQ2cHJ1ceYgDQ4ZP0EFy_QFwahH9Qr6A>
    <xme:CWHeaGrpS3Q_ky9M9-BLODDhhZGyAn4cY9B6kubqR320ubuX8GED8JqPj54jCla2_
    tNmwp82CBrru6_1RhQ852SsiI5e0B1BtDYuqBFL3A_uwr0SZFw3>
X-ME-Received: <xmr:CWHeaH6mPQbvtKAI_IJtuUBCiU_1fRmZIJOQYxF0iIZbqCXcFyo72IsUUXgplLwkc8HyUbz1hj-qB41QT7ubS_axQ1Of_L1-hT0st7FRow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:CWHeaEqbx7T-OofEH5iSYh1cdSI_ipqVjWcyEjKG1mow8Maj0_je4w>
    <xmx:CWHeaBgWGw18e56nnuyr7AMR2ja_4LDyVn3jRd_X1xmFC0bBsqJKOg>
    <xmx:CWHeaGJ5EyNES8agdIzJHD2dhTa4b5Fl7iveISLjJxpfM7xoUJAH_g>
    <xmx:CWHeaJDEg75L5_ZoP31KgBdtpDCWo0MD0nOLIggGKhMBMhQm1WfgLQ>
    <xmx:CWHeaCSg3YCwLOtNL01N94Oij3285TpWkYTKmRVLdC6iySbOx7DTgOTG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:24:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 464bd7c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:24:55 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:24:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] t8020: fix test failure due to indeterministic tag
 sorting
Message-ID: <aN5hA1inMQojbnXq@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
 <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
 <50aa008e-1cbf-4e77-8e51-6f2c32b6c12a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50aa008e-1cbf-4e77-8e51-6f2c32b6c12a@app.fastmail.com>

On Thu, Oct 02, 2025 at 01:10:53PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Oct 2, 2025, at 13:04, Patrick Steinhardt wrote:
> > [snip]
> >
> > But why do both of these tags point to the same commit? "km2" really is
> > supposed to be a merge, but due to the way the test is constructed the
> > merge turns into a fast-forward merge. Which means that the resulting
> > does not even contain a criss-cross merge in the first place! A quick
> 
> “the resulting <noun>”

Ah, right. What's missing here is "commit graph". Fixed locally, will
send out with the next iteration.

Thanks!

Patrick
