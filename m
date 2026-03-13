Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276461A3164
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383987; cv=none; b=qKjnbHSqfK1xMmT01wEMLUhoOgmrO9h2ykN3XfDvmLjF04QSx9L8fqbYP8b4zkI1dqjYtHlkGoZIM9EC+mYgIszPHpCcMzJvF0boLKySeOxmuDUqX5pLpLIUEPdcUI7QeCPjIN68MKOCY463Qfz/sE2Tor0a4pgJoyflkXiz+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383987; c=relaxed/simple;
	bh=SPFNgQ82ccVmVXoQXgAF3xHtnTk9a4ZZW+76tkstjuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpEKefUwP9JiLavfKhMEJAUgQSwi7yBetqzJ7XLKXc4bogLKl1ZKP/maUe6VCkC1llZoPrzXIfwgIQX5JDAC1aOQf7TZQryZyovI9+F+alEW29CShuvCvUySDZwMV7iOINNLEgXl3isPTB8h8oLWoroAf9lcPL4ceNSE46JzOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CentwuG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2I+UYJKt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CentwuG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2I+UYJKt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 651FB1D00147;
	Fri, 13 Mar 2026 02:39:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Mar 2026 02:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773383985; x=1773470385; bh=ya1eVi9r93
	ESE5ERNDTVjuTm1F3ncBcPoz7kNa2yu+Y=; b=CentwuG3iH8lUYfFMSDPIECKJP
	zJF08/iTMmYyt6uONgJ4AJNwnQjU7Po1q3tiGG2BAKWgGspI6CHFP4qYN7pD6Khf
	HV/yEjAukf6OPdoswtFX7H4uChkknZok5b1fCZIpwrjQ8uniZ3kRoJQqlWgUEdYY
	/JjBsgd5bJ5PSnqjPcrZtDk6gFqd6nDhAZyKYhz8Rbf1jqPgRIM5mFpe71hNral0
	YRXMM1tsBt68q853ocSOAMk3s3DPtgrk2eYIbzBpyiMHnP8qIgLLV4lRyIYVpNQe
	aejIIo/RpknjhHPEVecvOjRaUDZIz3M6qYwUaGbFQSY4pk7eaESLow4w/KiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773383985; x=1773470385; bh=ya1eVi9r93ESE5ERNDTVjuTm1F3ncBcPoz7
	kNa2yu+Y=; b=2I+UYJKtMwIQLV+8K5i49x60JVZ/fM3QvFpyhMTj2GfJIFXRhgN
	6eMqUwLHp0SDVpC//gFajtJSuEnT90crsxQeNlhxrjh2h3iq45fmjaaMmpQp2R5N
	C2kHh9Tw/9dqEQsw0ClcneoFaca6337OwADV45EsCRhqW1Z0q5Bo80wlCT3kv83+
	3+0mQXk+uKpYz/VQMBPzMsgJ/Mik2vvgTP1k4DsE2Ymeohssm7Cf8hYXk2k9VRDK
	yI1sYfRE2QHastmjIrfoGTdmk3H4r6Wga47g8sW3d8V6gy/OVMJwA2GPIDmSyn/B
	glHzGU170/gi6/ka0+ZKAI+PVXc3tzwfspQ==
X-ME-Sender: <xms:MLGzaeIku1mY4B48kPnFjVMVH5GQFRKHk0sETVPk312pwreq6q7lYw>
    <xme:MLGzadm3-wU254-rlxq28XMs7F_12qYED_wcUcAkGOW--WV7yXJaToI5J2BvT9Xix
    Dbye06Pfu2DK4D2eVRs2jw81KZHRfhuFEDWtQtHcnP6lGjc7zy-xg>
X-ME-Received: <xmr:MLGzacFF5JG9P-qWRjEb6F4LRHC2f_0kjD2SYwlX9_bQTym7CVOJT_t-P-wkGkEzbjH5ovrYQnKOoDEkuABZKEwYriHmtg3gvprOnniM3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsrghmuhgvlhdrthhhihgsrghulhhtsegvnhhsqdhlhihonhdrohhrgh
X-ME-Proxy: <xmx:MLGzadGck8lg5sy5QxYJh7oIgGKiPEDvmsNt0X27S0uNitt1OTzOVg>
    <xmx:MLGzaZMGy6tC1CPkqb0T_Zu9qPKPvnwjVdqrL5sz1osoS3fMunJJwA>
    <xmx:MLGzacFfbyExXcWIOyDq2XA4cZMzOuS7aU-61tePLDQhjnlxGOH3aw>
    <xmx:MLGzaQM1Ml56PkkwoZ9RxtdiTooGf5apoD-a_DsMuSt2sSqRorBjQw>
    <xmx:MbGzaS6h6sTsv_kCNUxz3CWQbelFJ1_ZYXTFJmAW9KzkTLUvRnq06One>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:39:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0899abd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:39:42 +0000 (UTC)
Date: Fri, 13 Mar 2026 07:39:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Fix GNU/Hurd build
Message-ID: <abOxLFNGgZjo1dyi@pks.im>
References: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
 <xmqqbjgsdbr6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjgsdbr6.fsf@gitster.g>

On Thu, Mar 12, 2026 at 01:38:21PM -0700, Junio C Hamano wrote:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > GNU/Hurd does not have a PATH_MAX limitation
> 
> Thanks.  clar folks might prefer to take it upstream and have us as
> a downstream to import from them, so I'll forward it first before
> taking it for ourselves.
> 
> It makes me wonder if an organization like this is easier to follow,
> i.e., platform specific settings first and then catch-all default at
> the end:
> 
> 	#if defined(CLAR_LONGPATHS)
> 	#define CLAR_MAX_PATH 4096
> 	#elif defined(PATH_MAX)
> 	#define CLAR_MAX_PATH PATH_MAX
> 	#elif deifned(MAX_PATH)
> 	#define CLAR_MAX_PATH MAX_PATH
> 	#fi
> 
> 	#if !defined(CLAR_MAX_PATH)
> 	#define CLAR_MAX_PATH 4096
> 	#fi
> 
> but that is a separate issue best handled by the clar folks.

Agreed, something like this would read better indeed. Samuel, do you
want to maybe create a pull request in [1] to fix this in clar itself?
You can then give me (@pks-gitlab) a ping and I'll be happy to review
it. I can then handle the subsequent pull request for Git.

Thanks!

Patrick

[1]: https://github.com/clar-test/clar
