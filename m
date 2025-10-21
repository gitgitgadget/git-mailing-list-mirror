Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB37221FDA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070911; cv=none; b=JTeApiryeYWJzixcaOltyoUcP+QTa1yZSeljgC+aik8b7MWrDcTyyIMCm2YJfRWcyOfepFE1i9+oH0wE+hw4hKgkWxCXRDkfViuP0RlNDhsoRSvIIfQvthKrZngO0MC5XzshHNXF/C+h47BRSBnVxRX77oZBxzrQ5sOhv+lQ1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070911; c=relaxed/simple;
	bh=h+cGPaKHFmBBvtbxB6tCA+0XKEBnmooYe28IVG+chIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOisFHQNokFDVp6Bhi9yVjgv5D/ESv8Rvy4HkOqhrfEzTffcgwdqmaiAA5tOrOgfSs59beL7lVOuRQQDbwPvl4fqV6Jww2j0M7UfI+rBdIlXR0VL2QMNDT2nKZoFPSQf5w3hLN5W3tDM1ghy2wldYJIsmoE10PthzMx9Na/Xdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ed2VXZ4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sV27jlLr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ed2VXZ4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sV27jlLr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 064027A011B;
	Tue, 21 Oct 2025 14:21:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 14:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1761070907; x=1761157307; bh=Y91wTbQatfES+oO///FMw+i9mUysHv5p
	/f/O94jW/5s=; b=Ed2VXZ4Bn/oN+2Es11IAx9mr3H6fJhUIEGC+Sf105aPJ8NXW
	afBgPoFUVmGMWH5iw6Yq3digmI5P6ZofsmUGgXf1YWi8uKJffkhsQtuXDkkk0UPh
	BngCDhBMqrCOR8guMY6zNZEC78DjJmkB6DOUUkQa1t3IDpWb6N7e5zLzrn4hdypH
	HQHWjCrEVgfW2eY0UwLGCq1AXpNk3lK8wq5YaajzSNT/4Wer+ncX77CSN7aR0Qxc
	9jO0cmRBXyNHdR/G9xEuNc8QZyLKL896tplT2BEYnHHWQhVQDv6Xc1Bv806h/AZP
	1ih06Hp1OpWcoRETJ/eFEHFKEpK44qJTpI8iEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761070907; x=
	1761157307; bh=Y91wTbQatfES+oO///FMw+i9mUysHv5p/f/O94jW/5s=; b=s
	V27jlLrLeA1vpPKgOBsOjaESQbplEZU2J8UmocQgMbMrcCcfUs11iMYxUmZHoaTE
	1Ck1PkivlIPz6sdyqhShcn8GLE/OKTSJWbKHhK3W3snKEj+l9A6JGBE3Yn0Sty48
	E2WgXNQ0OhYTzzpuTNFFhWAhN69/NG3Dgy2Xgt8HBCFhN7+nKmuTeXtFg9BcFw7M
	4HmUbXgvCWPR6Dhc3kmtwkZfe+zXzLv6T3nsbCIB1i2ig2j7uBerL8xP9Q9xSyk2
	drnlbKjnfETM6rqy3lpCUN03eYxl8hWgPNekJ/5Yq0gMcrAJfqtO56aRkQNHBhen
	jULTL5kMm4aew851uat0Q==
X-ME-Sender: <xms:O8_3aBEHRD8YpzgW2mP4_HwZC3D0egw6qJzStlTlw0X__j90Be88jQ>
    <xme:O8_3aMXnjyi-I2DK6pSi5anxpUcgb5iXb74zlss2hfz5vjSI0U1FzFl-RPMOX1ySe
    CXKwjRxxrwm4e5_gzwqi0Q5x4XzgExyCay3d8LsNmaXL6YxDlAGrhY>
X-ME-Received: <xmr:O8_3aAyjZUNIjNG7J9s6wvxHdVSBKZLBphgMy_J8kfSKa_HZ7ZFlVU9aEVh4wpo8BIw3B0x3v7A5he24QGLpba5l5py32D5zdoXf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:O8_3aCN9reHOSfRLylajs9YNXXRuhAiia-jqF3eubfgp12wRntAANA>
    <xmx:O8_3aJ43VpUUX_DMI3ZlrT7cI7KkqJY3uZUn3AFc60pik0pB9NV9qA>
    <xmx:O8_3aLON7fIMJZkmsRuZyK0k1irruWRoYslPaIc1K8uzQkfikDIQ6w>
    <xmx:O8_3aPnZDJOKL3tyF21CkOjMW1LJDMaOe2om-NlirdIe17I8OVD5pQ>
    <xmx:O8_3aMfx5sxNcqu5l8DBYXLIAEukSNd5Y44N0xDXEe93c6Rmo12LDk07>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 14:21:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
Date: Tue, 21 Oct 2025 11:21:46 -0700
Message-ID: <xmqqldl4und1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A good default matters, and people who find out how useful a rerere
database is would say "gee, that sounds great but why they do not
enable it by default?  It is too buggy and they wanted to reduce the
number of support requests?"  Yes, the reason it is not enabled by
default initially was exactly that, i.e. those opt into the feature
was used as guinea pigs to polish the feature.  But we forgot to set
the graduation criteria and never said "ok it is mature enough, so
let's turn it on for everybody".

Perhaps Git 3.0 boundary is a good occasion to do so?
