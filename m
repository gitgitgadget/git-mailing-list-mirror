Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317730DED3
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035635; cv=none; b=rl7PZd19yy1Rd4NvmemuGd5ldvXjEm0mDImSGBOBbIlZ1lLlrPFriRZ1Kgkh3H0tKdJmnhVbC4WiKiK/dhIEQeaFUnRZW/2W3iAUjOG4mJHUyV+rHeoqCIdo9p75fXHP9aiE7LX/apkckX6NrLFaAARX0AB2qw5/1U/J9iCKzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035635; c=relaxed/simple;
	bh=tPeooIRLlLo6DCTx5FPyrIPGqK3gBZpqhXfflNBrar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVKNFy9ImtTgMsF0Q19uRNqjT+CFVpj5SQIzaz7G7HxMDUERvJmvn+0EEafH1HtmH0moFAo6tsQU0whN4IYBu414CVgYaMxeU0zeiO8L9BaDYsk8W2MHAl+IH/esLsMkyzE6y8c4rof6MHSxF0dTEMe36vUewVDcBURcPSZOZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eMmVuqhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZ5pLmrr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eMmVuqhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZ5pLmrr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 041491400112;
	Tue, 21 Oct 2025 04:33:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 04:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761035632; x=1761122032; bh=tPeooIRLlL
	o6DCTx5FPyrIPGqK3gBZpqhXfflNBrar8=; b=eMmVuqhhdhvhK4dvgIAbJohs+u
	b0A8VxiSHgltcaHJ2niKK1Z3Ztp/+c2xx9xzxsS/41EopagcmMcEpK201f7FMV9k
	mr5BRoZipqRJPKJmZ92Re7029NS60H0sNNacV24hSbdhUfzxPofkVorDKPAFZoIi
	0hMLLdBE0bgQb++Iv1HN0zUhkxhFngo6wwujnLvoc428GycURtQ1Vp8bdXvW08No
	PEN+griZ+AnvKMSQX/sdgfJVIVEsJyo5JnWTTs39vwL3pjjSmKb1WV5AHv/eWrNs
	aF2WBq+rXVcU+KeHd9uIN1+BYGu/LmNg5eANLekgi1K3zQ8GDAus4DFkpcew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761035632; x=1761122032; bh=tPeooIRLlLo6DCTx5FPyrIPGqK3gBZpqhXf
	flNBrar8=; b=MZ5pLmrrGx1gaTCRo5M8RuxAAnop/+g+kKick9t/tKc/ZIqJJ9m
	o7JRRxXi1fbzIwl/EYDbkrPVTYZKiMDmKd1IyM76/eGV4xOGZFfVEknbMqqAo/vj
	9/oG4MS2rbkFAoEAvvlx7oO+EwsI8CJIlP8GTY2J99uO4h53SW0Xm5mmnBKXxLTS
	5ZppMd7cBIMwGz87vJg2l9lxOINKm/vbjg0xkOHdKJqbI6BOVT1Rp3b4K6CHU1ce
	eQx7nEPtr5AFM7sCZKVDhLEWxbhaUWK68avkhGRToJJQPz4THsfbmIuimxVUiHLe
	HXXjDruzgxkFN4Bz3iGMZIUjGZlWUKhgIgQ==
X-ME-Sender: <xms:b0X3aH6Gb8rkABhOLPH_70A6J4AeM7xcKcB6rwuceei5y95VVRYFkg>
    <xme:b0X3aEVvS1Y1sIWQ1D9Zw0BTitW0twNjoNkOrxgeEYziQBSzDXdYCsEVhQxiHSnIx
    H59ayaNilD-ioHXH-qhIDfgnkPTRalTQc4Mz4PORjlSpdbynB2RZg>
X-ME-Received: <xmr:b0X3aL1mMCIdfgd-fljmW2HonYEAl8VdldBjzJoE0vukrV1qEl6YZ1dlmRO-S7ZzcXcQM8qQ2NAXeDR__feWA7Pzz9loaPJU4x9s8eJWv0aAWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:b0X3aB0Q8I9I4JSfM538mraWlCMX-zldereEQiba958RwCVhr9OgQQ>
    <xmx:b0X3aO9lzmIX8pnf_hywiYgy7SiVlUJC_7iYQ05kb4h5on14PfHiuQ>
    <xmx:b0X3aO2hW8YPpZxtp1WU5sDczHa_3RDRbQJnoo2uTn2207mzar3WZA>
    <xmx:b0X3aL_pzQKTGGqLBpB2mXAMN7Z3C3Uo2895yTctUOGr3ioJplJDbg>
    <xmx:b0X3aNzz-ewlVzfYnkprRFeewigmHa5EkpS18AjT0vRmhbxw_AxHTfcl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:33:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a427be4e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:33:50 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:33:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/9] xdiff: use unambiguous types in xdl_hash_record()
Message-ID: <aPdFbPN-60MVo3cv@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7fcd83c99076404960302b64a4f0c8fa1c13feba.1760563101.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcd83c99076404960302b64a4f0c8fa1c13feba.1760563101.git.gitgitgadget@gmail.com>

On Wed, Oct 15, 2025 at 09:18:16PM +0000, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>

This should have a commit message explaining what exactly you're doing
here.

Patrick
