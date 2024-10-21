Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17318EFDE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539099; cv=none; b=cflhkGl1K2XWQO9hRHnVj04112Ovq22ZaK3BBv2c+/FwSZiY82qC11B2lJ1PA+sWICBod+ERdiNzVPIPSVSa6ko/9SYVtUsHu4amQJisd9gyiELf+23aUTX7oMqLsKeMAIyc6mHvkIze+fW+akAOrPeSZKncmhCnja2ymPWnEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539099; c=relaxed/simple;
	bh=v7j8MeYlAznwLxItsY25bQVOSUiLVK7SYDoNUjzLioE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHPWxULnzhuSB/u0rUxmp9FllN3aMtbop0LhJFDGhnR15a7kPlCp3d54ifwLsPUyBo1aPeqrvNSrA0q1EoeG7xxdQ4Z4F/w6eyikjwqYYjioyJdLRxXlbCBThhilQW+qqUW3/hfPdH8Aa37KTQU+KcRD4CuTzXZGKOG/Qu+w+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fc/bB8Ei; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fc/bB8Ei"
Received: (qmail 19956 invoked by uid 109); 21 Oct 2024 19:31:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v7j8MeYlAznwLxItsY25bQVOSUiLVK7SYDoNUjzLioE=; b=Fc/bB8Eiba/QhZCx9jomDwg/iJbwrc5yI2HBaVpYUp4JuAIRdL7MI8WZdduGL1er6i8oaGuUbpeZXtWG2rL4sFDVK11/utl4hrZrn2XyR0ZPMsurW0tMgAEUm5EcRjaLCiL3xKznBvhOrtM1hNO4zqDwz149oYqOibazX8Aeggsf09kPOa+JXTfRP//B6qTPaQhsTSGs8RaTdWxcBcratleQcS3EO0Uh9EaXekn3+XAdQN/i3JvqFgvBpz4f6matYzDi7vtK8jXctFt/H3jPh2ptM059JJyqiAld4agjYv5+Lt0SA4fLm8j/ZIAOHzDuNhESjZ5ZYFupEhl/JFg36w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:31:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31971 invoked by uid 111); 21 Oct 2024 19:31:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:31:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:31:35 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <20241021193135.GG1219228@coredump.intra.peff.net>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxLAC-c4y7_sQqzw@tapette.crustytoothpaste.net>
 <20241021191934.GE1219228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021191934.GE1219228@coredump.intra.peff.net>

On Mon, Oct 21, 2024 at 03:19:34PM -0400, Jeff King wrote:

> (This is all assuming that we are dealing with a uclibc with disabled
> features in the first place. I don't think we've seen an answer to
> Patrick's questions about why the #error is not triggering).

Ah, nevermind, I just saw his response from this morning about the stub
header. So I think we do know that this is a tweaked uclibc build.

-Peff
