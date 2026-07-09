Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2633E47B
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589979; cv=none; b=Y729r34JfLl7MEEfAinJjsAEMQtUQS7CYfyfCeCln35phhlxdqHyo5pGTgqjUzkCp0bS73wQsDXc0lU1mczovsQQ5Xw/ApzwLE7Waue7tU20v2QQLHuTN2dvFQI/nhG9v0+I3C9kTqdxQ4PLJ8XVi70ZaD7+tLnGR94be/bhEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589979; c=relaxed/simple;
	bh=ocXnutBQ/CVRYAaregEuHDzRGXwfaLnxeWZ8SY938h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUq01oLdD/hi0ljFXHTwoOcXrAAUTiGRReQy1pwoEpVNv7N1mguG+NoW6YG7b546p6+DXsYQ6LSXc+QFAadZXd2h+ZXgyKH1s1NLjCZZy1txmqY66YCzlfTwoebmO9ynCl+/UNqtXUwqrOllpiDR1gSpxp8Wvm3bJdQVm7uaPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HgWv6aiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWmI0iBN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HgWv6aiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWmI0iBN"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D09C7A0078;
	Thu,  9 Jul 2026 05:39:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jul 2026 05:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783589977; x=1783676377; bh=2IVsnPM/y3
	RdebdeP9G1V8H1l/n5BOdy520VwMlO4XQ=; b=HgWv6aiNY2oJQIO0yn+XFlMZZV
	rldljWvO7YTm5kTDVmy/GhZIcdBvV+piLFQDbu9X7e1+XhHQwpl0hPD/QgABTD2k
	WmPT8ErqtbkINK4GU96CjVMX4pluI4s3kqp6xvqdnVYKWt9UFicJBEv05psrzdWp
	0EUHu6W0sZ6/HwPlLKUW5Y54Hl4stLOfeHPnfj2VTxq8c+/ERVuo9J5xotHBJbd9
	nzS3M3nMEeadQcPSG4Oi7x8PeRGpERG22xQtujp4+ljT5jxLJaTlMjOt8NeAcmdI
	juaOz70ex9Jo8dUeyXAq5bF2/bwalmJLUt3gom0pyQpSx60djaXncQZXRZVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783589977; x=1783676377; bh=2IVsnPM/y3RdebdeP9G1V8H1l/n5BOdy520
	VwMlO4XQ=; b=LWmI0iBNrMvlTNdIOc5kC2nEogS7005MUzUFtfKwBDNao4xSBB6
	lBIW5zVvQn8o+j+jJ670yr/Zsiniqidl7xf75tS66Nl4RJ/zhAIu49C0RlMUOa3+
	4Yf1OdQGmaIkJhmiBmXwZmEPFf77qqK5IOPj6dHY3AlCeNFyKdfcf/V4rX/c5DMd
	ddQb4pVFK4RPKKSNatUPiOVlO2eeWz+y62J2HZYnKStqjC4Y7sYCahRgkSlFf54o
	/t3DmzGNdX87exb6egRnFpVKnXudBd2sDjRvn4mRBi0zNNsNTBdNbOJvbmAlxXl7
	/S0T54oFut5I+1aU2nA/I2ZWMeEOqHtaBRA==
X-ME-Sender: <xms:WWxPatmDpH_G6Jw7ci93jaS14pv00BP-5NYBbdjXpmAdrYTh0zFkMg>
    <xme:WWxPagQRX5PcY88MNYB-sfBFs0neiZW-Y_MrlGAG1-w3gieXeOm22qYGR1-qKX6MD
    CoUjAWbnhhgNIS6RezjAsH5Aqydx4elTcl6Bt307blW87EmGNbk>
X-ME-Received: <xmr:WWxPahDf8YRC0Lyb9MHqbifx1nHCI6zlYJzJct5Dgjne6tXt9CBilZBmSWivSfCcQBzqIm969PUl1rbr0NVwznKaFU_NTUchtUQiWsR8sw>
X-ME-Proxy-Cause: dmFkZTGOksP55TLb5CHg9URKxxuvY7lH+GhlwrLgHsXqB8dwyukKEnjEj+gcaOiTl1B2WH
    LFnhZR9I91NnvKOP8+89jTgXKAcvDSBUqEDlIDSp25rBT0yeVMWpiYkMXPFnvC0UHmdVgG
    fccZXeys19ofZnCc7dC9ooZ8YMaALHMiC0FzhZufoN5oDI62RrxpEyBZECSYtxA4Qr1Wbv
    K/6RT2lfQU4VmBPeDrvlcSaLzIoi+3DO7qJ8q0dNeNlJslknbfJNre3ZuM/FNTFf9IR3RZ
    avgibVN73JEVvgSwlb6QwLJxeO8GZ1inVGAoZk6TYqApqZms/6gQ4Z2t+pGbVNH3/8xKNI
    p321wQbayHY8TbNTAxzPY7ZpFbWWZiZs4hqoL74HijbqS8VLPtjNdGmr1jkO/0GKCCFtpk
    Hvyoq2pCVqfXiKqhOSYYKsXTNnzEeCHSa9woGH74RUVva8PYwX607ZmBo4mooIFsvfdBmy
    T1sj3HIiokbb+95jX9WoWVFS0y5p+mHKPbNlanJqpOBcDTRzIprd6riaqlIAzLAQgq1nvK
    C04IIhIQLHoW1RR9hKWAeu+pOwGIM3ZmsB+oj1Exxp7V3s/HiLu8AS7XoYPJngX8PqGjyE
    AkEboxB4hqUu1WYNfpHTzIJ5/BGcR9B+k3v1Jc4Nd5Es5+PlYTv+gHervGMA
X-ME-Proxy: <xmx:WWxPanTd7lSyLRJmWKk1ya_5mnA4xetQfOrp0AXDG-Yq8y-iipQxSw>
    <xmx:WWxPavr9--2bhnqdDmRLJA63qXbWPvE2bdv3Mp6wFuOPCCnf1XzcFw>
    <xmx:WWxPapxAg7Mg5BCppzdkGte4UmlF6FM_B3u8CGxeKhHoBLTekVR2UQ>
    <xmx:WWxPakK0kaDBz_uOu8I4EGOh7LFmuo7Waq_0Dn8T_ETCe-4K647g4Q>
    <xmx:WWxPakSoJnHr0DfI2IVxlnYQh7jAEOgt59KnKC-VSVad5d9XhfG-SNIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 05:39:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8571a00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 09:39:35 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:39:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 00/11] receive-pack: use ODB transactions to stage
 object writes
Message-ID: <ak9sUt-mwXyoTDLj@pks.im>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>

On Wed, Jul 08, 2026 at 06:59:14PM -0500, Justin Tobler wrote:
> Changes since V2:
>   - Clarified commit log reasoning for embedding
>     `flush_loose_object_transaction()` logic in commit function.
>   - Started printed some error messages on transaction errors.
>   - Removed include statement.
>   - Fixed transaction leak on `odb_transaction_commit()` error.

Thanks, the changes all look good to me and I don't have anything else
to add.

Patrick
