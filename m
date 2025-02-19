Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33173191F77
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952412; cv=none; b=gFAMLR2Hkd50anZdUaUKgweUg1VOw8b37R+nm96S7H4ojgjmcgFmLzmrQPxcyS7PXi3JxJr8rGA+XsHQCNCKHo2x/HRbGM/yvUvN59pLBhCRbdFBmk8GUId0s5JCkrpo00EsEu35NuE6EtjDl4b+iVB9R+jJz3+Mo9eOdrE7x1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952412; c=relaxed/simple;
	bh=DjKscZR5fod4DkiHnxXxP5hlJrxustrYdtzQ7S3ObdE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EtJxDynNaC8/FueMEyvV5mdvsCaK0rinbaYHYxyHO0DjcMfpBYZNxUEuvqd5n+rk+/ggeRDBMgKyC27tdenbIaYM5xpx/tv2pMA/XFKrEnpwmBXXdS0ZdarIK8GGpxnhB47hpv4GT3CgpEre52dQRKR7L3Bk9Iq2fXOA0D5Kd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=UAEO1PRY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z0RSPP2n; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="UAEO1PRY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z0RSPP2n"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C45F81380B06;
	Wed, 19 Feb 2025 03:06:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 03:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739952406;
	 x=1740038806; bh=DjKscZR5fod4DkiHnxXxP5hlJrxustrYdtzQ7S3ObdE=; b=
	UAEO1PRYxoTy7/2mUIWundlJlwp0JoyeJBr0sy4Cf75aUwxz0GCCUUVE0qufnvG/
	0GVvGju1t8qOuuLGi2YEmlPcLju53MzQnZFE1Qys24+05URO/I1WYo6Eju3nR+xb
	JzbxWfW42vVMLaDPXZ0XlQ3Sjc6ZE5qZMffvmtNB/4gvpyymVmUgNnW+vkhQtduy
	aE6R00V2x/8rod5zwzLEl0vBMmfkHbN4uawL166aiyEmpxuO6d50C1zEqgzqnIlD
	I1ancLeUPbNOdkjGRvYk7L2s9tSOWwapv67a9weBSf91XG57jT0ADm/cNYZEyCBV
	1Ke1/5JDsyqmaRzhi59+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739952406; x=
	1740038806; bh=DjKscZR5fod4DkiHnxXxP5hlJrxustrYdtzQ7S3ObdE=; b=z
	0RSPP2nODYJqoGf/wA4qyCR4lEt6KRiENkq7qLArYLf7eTKgB6zdoh4NPjy4usm5
	lFugXFN+iSjSq8oNIzkrLtpA61V49cpKg+ISXz4a1t5nk5AwJ3WAsw45hhBF0QeO
	XMnShkYwrNTCTNU5QKWx5ZmgYRt8d30RS3Gn5Q39Y1bwAUdK4g1d5mozr38RUoGn
	zi/VsUCz6MlczbpuP8vwC7XGWT3Fvd8PzQono9NxlfZRB425hd0qPlot/O5r/vQW
	EocsLGNDgJrqnmEzRX+vszjTkQr7ObMR7KYSl1hQdhll6QYDM/bXJjZP8DcKpatz
	qxw9LrITK/HOK/qZDFTzA==
X-ME-Sender: <xms:FpG1Z5yFHGrA3jh73AULDmPyNwXTJu-rjnor9PI3rjOPwaIF_dEK8g>
    <xme:FpG1Z5Qn9YkhuiXEIm2BBl36A6EQi0JXSyfj0WlUWUNqgBQjw67vTLllurCnGeT5_
    JBDSS5-fi7e1jRtwfc>
X-ME-Received: <xmr:FpG1ZzUqwcpG5uEqFO5I_imC8s64-TFneci3iUOMvQnajkTIjrf0jAuKHMbdeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttddu
    jeenucfhrhhomhepofgrthmvjhcuvegvphhluceomhgtvghplhestggvphhlrdgvuheqne
    cuggftrfgrthhtvghrnhepgfdtleejjedtkeevieduueethfeiteefgeegteelffefffdu
    jefhveevgeduieeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdr
    vghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FpG1Z7gC6gMsec2KNb1E87iny8WRBogkFognIXZT7pIr21YE-lHtWw>
    <xmx:FpG1Z7A8-DbOZ1hI2XfCMiSRU9vXko83jTZUeT6ZS-b1_lkE57Nt3w>
    <xmx:FpG1Z0KTXoE7pLFEO67XnYfol2p34j8ucC-z2TEM3mTDLPxPX7AsXQ>
    <xmx:FpG1Z6CQB324UathO-WsoMopjkhuDDAgClcqXRy68b8-PYC3ztySQg>
    <xmx:FpG1ZyNf2Zavn_gJygZYnWyq3twbSDsoCMoikAFGOvWBM2DThSFAUSLa>
Feedback-ID: i8c5e488c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 03:06:45 -0500 (EST)
Date: Wed, 19 Feb 2025 09:06:41 +0100
From: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
CC: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typo
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqo6yzkrxd.fsf@gitster.g>
References: <20250217130902.2706880-1-mcepl@cepl.eu> <Z7QszEnV4EzQMJ9R@pks.im> <xmqqo6yzkrxd.fsf@gitster.g>
Message-ID: <9DD68D2C-1BD3-4BFB-88F7-306E5E74CB96@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<https://lore=2Ekernel=2Eorg/git/20250218085913=2E1381537-1-mcepl@cepl=2Eeu=
/>
and
<https://lore=2Ekernel=2Eorg/git/D7VO9H4A9DMN=2EJK0CKJNDX3XZ@cepl=2Eeu/>
