Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6415B135
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962789; cv=none; b=LJ8yIyrLULuE8GSxxReypX5azIBBMA03RNv17PdZb4lUhK6JNMV3/sxp37MHb4dxSnmJ3qsTVzGbhu/9CYSdODFSPikhw/GifRNIhwHiiFEaYLFnjgsCfatkg0VbhezUPKlgNHYBlFm2B57vEoGt5IO3hpt0K0ksECXD6FxXjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962789; c=relaxed/simple;
	bh=5KWRsc7rleae0GgANoLAVg9RSAGjy2wrK7rSwIsC9N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2AR0jLIEvIbOgQZa3I4rkTMNUZOl82BNJPgLHvSZPyVo8weCUDaeoaioqZvzcxQDWy6vbS70ynsv2BzFn/uYieuZsv7bjk78VH2P3iAh37hgJ3bDG7BpCfb2EE7Y3DgPuj0X+cju0PuxcZQMYOYwYS7UJ5DOoQ/M46gfu8hJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ct6YXOVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kennUVOF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ct6YXOVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kennUVOF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC29825400A2;
	Mon, 27 Jan 2025 02:26:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 02:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737962786;
	 x=1738049186; bh=5KWRsc7rleae0GgANoLAVg9RSAGjy2wrK7rSwIsC9N8=; b=
	Ct6YXOVembQkduZDVzyIC7kNylxg7SxqRXhVXjnhSkmoHuDbLGGZGSP6LpsPKWUJ
	P6lY5b86P/dOCj8ZDFRhPO9lc1jbwtYkvCb9QNJv+uvkEErXiOnlYfsVNWAXCo7T
	3v/hT6H55z4NAbV56a0Io+BYs9LCwp34F52hHAEKeCsqH5cg3p3fRoL6ct67PyMD
	pryJjXGyo6rj6H4LL4R5fVFk+jrgL1XSMiMQMJ1dXNxExJNQSBxDxubn7hbm8PHW
	CoLnSMCollI39k7QMDkyxnXF6K2jtkcwvguKHs+6FPYXOE6V4GRKw7TPbtGYec8F
	kLKpSuRkpDkvns7LgvaI4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737962786; x=
	1738049186; bh=5KWRsc7rleae0GgANoLAVg9RSAGjy2wrK7rSwIsC9N8=; b=k
	ennUVOFiga13J8u5bVbjt0cKsIY+gOcDPp86gFWNwe9ENh000oH1XdIR0gpcm9A1
	PXsNsDQWYMvtrozKAJNOQpHcOwZlKeBvoWs++Wf8QBfQ61LzknbF+s2u8OnibCUo
	vwSbRKfN3UM+LLORoIW+1qXum1QtQdqaUhLwJMsIRlKPIs2QF4BfLqoOIAgVLe7l
	JVt7KPqksPa4XqJxSb2aCnlwhHFjrWz2hqmNH4jYPb9zaZxVn45dQukNftx8AcU9
	pMuhZmVjX3QCXebEBzfNGIt8/rnMrV0P1IUY5A5NOu8jN1W3esye0i5TSh5P39av
	1CkuNyKD4K7aMlwT834Xg==
X-ME-Sender: <xms:IjWXZwb9LFJ_CqGI4fdWdsADXEKZ2MWytL_-D1e_ieA7P9jkMMFFJw>
    <xme:IjWXZ7Y7-SX6l_wNo6YwSogtCMXYIMf4rWzdNZEjizE70P2Hb5NiWbqqstFJVmOs0
    zrkVuBlK_VAKggeDg>
X-ME-Received: <xmr:IjWXZ69I7O21HCetEFatKG6ko5SG4LLnLaHsu1k5n5eXT0siDlPJYQ_LqvBmWerwJIfbkgMufwdPQ-Pl2Fl_lKtpP5rjiOsh7Nj6qc41Cxs5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggr
    phhighdotghqgeelhhgutggpkeepmhhrhhhhjhguthhnhigpkhhqoheifihgiehnrhelke
    hrshgsnhgphiigmhgsrhhqiehkrgesmhgrihhlrdhgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhovghkkhhlvges
    fhhrvggvnhgvthdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:IjWXZ6qYH59oK6JHblXq3xHuo4lVRNCKHgprFvTJ8fWJ1R4MXG14eg>
    <xmx:IjWXZ7qAmIizfxJKI5tyejwfzK67vHu43H8rFv0B8kdUXEsWSjlrSg>
    <xmx:IjWXZ4SH9KQHXSjkUciV5EHP6le-y6OJVCoCznkpCJ8pEt_p9IFU3w>
    <xmx:IjWXZ7rcK8ZY-Copn1GB42b2dPDJ8lLKF3WWF8ADDj93PLgpzH_6nQ>
    <xmx:IjWXZ8evi8lcddzWK-9mi_GJU9j70p9sM21BXK-GZviqLrQP1rD18sR9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:26:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ddc23a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:26:21 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:26:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 0/4] Fix type conversion Warings from msvc
Message-ID: <Z5c1HdBheaiA87QH@pks.im>
References: <20250126125638.3089-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126125638.3089-1-soekkle@freenet.de>

On Sun, Jan 26, 2025 at 01:56:34PM +0100, Sören Krecker wrote:
> Hi everyone,
> sorry for my late reply and thanks for your suggestions.
> I am trying to improve this patch series.

Thanks for rerolling! I've got a couple more comments.

Something seems to have gone wrong when sending your patches. Only the
first patch is connected to the cover letter, the remaining ones aren't.

Patrick
