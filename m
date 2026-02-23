Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83934D907
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843703; cv=none; b=NBhDncobbQ2UOGrhel2LrRbHyhLeG0FK/4Zbzbre36+k0wgtdcjiQLx6/DUT7WG5+LLWlbLNsiDXGJClW5H8IgS1BWe5XM+UllCksxHepTx23lSnpqluvNnE7bEs9gsMjrSMWiPXEbj94HZHA6nZstxHODnsmR9cYzHS0WRC7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843703; c=relaxed/simple;
	bh=JUCDDDtqTgbJFbJP1mOL0ct8DLETn5bJKE1+Urs3WQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK159JA+1JesAHz6Ssyozuo3tZlda5uGeVsuj5kVZUEPfKPCEW9ifUo+QiltFiejiJrvdZfCc2iq8ve+bxWRtfchHM/01Vl9q2Q+kZckjB39ZpODNHDMBv/GOSAzDryIn+mkhA7rUDML3q7ksVVLnGeCuSJsIFBoTkbxrPJkg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PkIpDtUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mdcBAF1+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PkIpDtUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdcBAF1+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C6A11EC05D8;
	Mon, 23 Feb 2026 05:48:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 05:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771843701; x=1771930101; bh=uEJVuhse9v
	NURRNbZ+45p0FwJQd1bVMhCOZBjFuYTFk=; b=PkIpDtUiTIGAdl7srLSqKFafbF
	v2j5t5MzuSmnakN5LYNIv8RUj0OzIoW/mxkRJeBsQgUYyAtaU5SC6I2iOwdlLV0H
	ZKyN/s8QThi8MDubkc1bThi3N5w+/q2dbSPztQT085S76XCWJzGxg0ZCnZ8eH/0n
	9gHSwaszWPrcvMoQiCCB+q9FupuT8vi9f8st4Z3Cxl4X5fRbV3ggK0H/mr6KeVVP
	Sw4EI73QbKM/DMq3+u1wuXj48Tv7blBJQLq2k5c4Fk5IcuJ0qCv+PQjKqfWhkGpd
	UFMqjiQ2+WCe0H+N41Ta5ZJ4Qqlz9L9ouLUjO6vO8Snf2LSHwDvJjA0zPzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771843701; x=1771930101; bh=uEJVuhse9vNURRNbZ+45p0FwJQd1bVMhCOZ
	BjFuYTFk=; b=mdcBAF1+Cu7J/G3YwlOmEk+fx6MoaAyBJpk9YYoHhP+P1u8flB1
	YBD/f5ODyiX2US4Sb7tcA/9eay1c5beAMq+dsrZzbrQ66Vg0jIqVlTeJ5HXTpjp3
	GvRexoiYyW+VUkSHmtEhgnjnYZ93mWvC6I2sQ0dlLEoPoiPXBN9rhh65z3L8VXec
	PVzQiMRmf8hcbo8oBytB2iGtMpxoc1p0HY2JxSv1pFtawm3/nXBs5U/0YD87ohnS
	/rZ7jkO1SfmVw9fBrPFvV2CU3qkyUCugjoeGn3iR/2slRE+djzhd7i2A+v14nsU3
	I7e4eA1KF75JKaaDtc7ig2oIER6WBX+mOIQ==
X-ME-Sender: <xms:dTCcaROUsBNb1kooIrPmD4xqB6_5k1wOcgmFs-Sd79-QlC9T62AzZg>
    <xme:dTCcaZ-9T9vwTNhUO42LXWhtBbju6fPsJxAd0tbn16fe8IesRUu-iEO_mhVrM8rMV
    R64sFjX90PZz2XUAMtFJ2IpPE9Ogx0DLWGh732feyoDboJqTGGYyg>
X-ME-Received: <xmr:dTCcad6MLepWeXrTUWoP-6RFLHvPfPtyg9TGe57Mttya-ANjNp9gwLWUx18kztdcnciIyyUNV_tQBuGb6esPgPQ0bsutsel3eTxN7ii9Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dTCcaY23dipo2CgVq_ml9-Pb-FAJwD_WimbW80gE5rHMkG0UZQJITg>
    <xmx:dTCcacBSNyMVy9tqhoWDCe8XxXZ64UXx8aYanaqc_PmDPm2iUA38ZA>
    <xmx:dTCcaS2nfhmxZUtQSA8DkPjezbWeTCFbv1bsOqjRazO6Tvet-FiCbw>
    <xmx:dTCcaetOMKSiWH5vc8CmW9JII2AkbcQsb1qgM7uiLbfXi7VY8jKcKw>
    <xmx:dTCcaT9Yz_b3jvl2uj5e4g2qAMyCdqbaO8DFaASyNZaw3DETxxfeEDO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 05:48:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f27fd716 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 10:48:20 +0000 (UTC)
Date: Mon, 23 Feb 2026 11:48:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/17] refs: replace `refs_for_each_ref_in()`
Message-ID: <aZwwchZjnSMTiN0m@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-11-17170bd99de1@pks.im>
 <CAOLa=ZRXbQEyw5-RvZrXTYMnRQr47=JuiUP3Ps4LGQPspo8gPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRXbQEyw5-RvZrXTYMnRQr47=JuiUP3Ps4LGQPspo8gPQ@mail.gmail.com>

On Mon, Feb 23, 2026 at 04:11:52AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> > index 9032cc6327..02703f2fb8 100644
> > --- a/builtin/rev-parse.c
> > +++ b/builtin/rev-parse.c
> > @@ -613,13 +613,18 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
> >
> >  static void handle_ref_opt(const char *pattern, const char *prefix)
> >  {
> > -	if (pattern)
> > +	if (pattern) {
> >  		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
> >  					  show_reference, pattern, prefix,
> >  					  NULL);
> > -	else
> > -		refs_for_each_ref_in(get_main_ref_store(the_repository),
> > -				     prefix, show_reference, NULL);
> > +	} else {
> > +		struct refs_for_each_ref_options opts = {
> > +			.prefix = prefix,
> > +			.trim_prefix = strlen(prefix),
> 
> Tangent: I wonder if it makes sense to make `trim_prefix` a bool and
> then internally trim strlen(prefix). Is there a usecase where
> `.trim_prefix != strlen(prefix)`?

I don't think there is right now, and I cannot think about any myself.
How about we leave this as a #leftoverbit though?

Patrick
