Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFD38E121
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945018; cv=none; b=rkT+hvThGweufaBhgN8/Z6pfpzvo10VVtr9MboMF/r3o6CoJkYO3uaErtoYCggQlw31y3oFCjTJZ532l2+IbMOojOrMof8no94XWxcKp3poMnGPadiFcUXYIFbWlIJWm+3e7j6RcgA0qXnL2EEpOfXmA93UcJSwS95z7a1r+RRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945018; c=relaxed/simple;
	bh=yIvy8B6x7rGnZ16TzYsDq+I77qzAEb93+Y1Jd0WJRtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE0ItOVoib2atVRVs6CXmYUZJiUYnvGmNimQyPA1lTPUVHMRI75bOKRmTCFSgkm3QhTflD9I1MsixLS1GXBaQp7mzuWRTDADQ6GiFkldYzvqJcfUEWYybPbPYuhCXvpqb43T9DesqyPuxeVsfGJl/8f3oAmsujA7H8IettLxIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDr1WCW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MV/6XGaM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDr1WCW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MV/6XGaM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 875A11D000D8;
	Mon, 17 Aug 2026 01:36:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 01:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786945016; x=1787031416; bh=ilJISYPKqT
	fdAt6rJgnCFk5+CoInQna+nVftFAnRJ3Q=; b=aDr1WCW73pKCj3QWqHJ6maEyCJ
	evGy5aJjFCs8RUNlUuVXVuQkF0tZJGd8VSK579aQmqtP9v63VHk7BBO4fMYyJgHa
	fJnJwG0QKm0XljEUp4lypVppxOHgElY9pU9cX6rFa+ZNEvfyFRp8TeteVF/0EmZc
	gaGrxSyPr7QZmerGyckYJ/rX0dCtFbQyFIVNROHmVl62PfRMiJoOrrEhdjPu284a
	G6RJI50HZB0Igl/998qDnnvyZwiGF22b0daeoB43jwHQQcDFDtGh/sOC01Dpz/i4
	BdoeLJo3TlGjUlmMMGOT5Da4F6LyWBKERuauTMy6EXR8Tr7XVTbNKAbT8hzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786945016; x=1787031416; bh=ilJISYPKqTfdAt6rJgnCFk5+CoInQna+nVf
	tFAnRJ3Q=; b=MV/6XGaMy24w5AX/iR4Hpyxkgn212VAyyfKrwjLsJFHnyYcrP8q
	qDL7f/GXra5yW6Ohu22NOxxmFZv8MY9gIb7yesJCyo5qzJn/9FZ4dI3q58CawxnN
	lTcbqDIUt2zQuv1oRBO/VTVsaXErO62WuT4Kr5iIHEWc78bi6X0TXfCEbf0xK02f
	cSWHx8AELC4MffbnxbS1HaXrX+dR9RhBObvzTu081v6JKvIr3Wx1LLwHf4Q5PEoH
	jd7+V+Rf47AiJWiKQPm5jvXXX5kBglgtfg/5SRCiPBbypwJFPuOTUseJriVoR74s
	6rEFjU/MVgSIlqJ9NvsXiwVliQVLon5UyPA==
X-ME-Sender: <xms:-J2Cauxm5NLWgTd933bUXFDOlpQsYW1y12exHnjMJcYe-0kXX3PTfA>
    <xme:-J2CahvSGTs54oKegb5fIq4go1k_zKLLb1HGnv75PCdGpUVctUTp4KaMMWIDHJp8W
    XNPxK2eEqx21dwvCuYeZbCbf1RP-Ajv1jbLQWUR_umgiWWZ8rt7iQ>
X-ME-Received: <xmr:-J2Catu_JKyTvVvQGMfHfeHtu-eN4Xxp0KYftDfZezWaOnd83JE5TzkSexjT51It0zD2AsaaKbKmXVq5UryWqXRkusq52JHReX3RDiV87Q>
X-ME-Proxy-Cause: dmFkZTFOImVcbUGHdsJ6x/mNXOVHR9aV0ZIVTuUz5eL0QWvq5d6DOU1g+rTifeQr9DNBXr
    Z9eQRPaFUEY5m6Wx15eGkGYruzlqUqkVT6kKggRWuBtJSJ8GydgXN5WjZcvA0tntaRddgo
    mfCf93X49IPZFZ1qQPLwcy7/qVUPjQsmQyTi88bCULxNLWQL4mtfk/nMZI79OB5dJyJSYx
    aC0t//g3tMjS8o2N5nNtzNDegMmBYO91ZNnGCHj7z4DbXAkuXWZfHn/cVpTbOUMXULNzrC
    ye6Kdryz5g5yXCKap+H/nyg7RbUjTc7WGU8l2xSusrIuxVjOR/+gQkB+aiQmn+zWduV3Js
    uskWxuDYBGqU16ETZSMkdhqh8u48fJPfXLLhzFdX9in/eGKUpaqeOnNCEJvExhmICFayyR
    oiQnyRuycjsquHk2VdlWLaJgGF+1/iYXgsYgZCpBKrw8Tk2OVUDnskmV7Xjn+7gmcdkTAR
    byalttaZPT0SC2FqBCFtGuFz4UnE3lIILDW825ipZ/VqFD/DN+8wbjENUO25alz9g/Ptjp
    QIsabAWrvZ7tHqUg2VGcU5Yrk71SuYXCyEr7S+D8D5STEkxkjnddAF4gnQKZa97Lz2GfQx
    mGdaqyPG58nIrvqtXgNPewtgmXJbu/ipWz9v/RVy2fshhIzjpeI2bcpSMSeQ
X-ME-Proxy: <xmx:-J2CauP1sgBIRMuoQShxRK_yxozD0LFTAAmogBBTnxO_nG9fVXgSQA>
    <xmx:-J2Caj0fwga741VJrJVWEBfwoteOZsnc8G0DVKzJ3AvDKVzSm1LnoA>
    <xmx:-J2CaiOchQU12rlIiAYNUn4qgMk13Y-0hQrMeuLnwjXq79zLksyOtQ>
    <xmx:-J2Car32QRzGVBILRzF55JqxGgZMHTeIzXXOfcJUr95h8XHLUBVkOw>
    <xmx:-J2CakYTMbVsqCCOoscdyL9OJ9kweNax0g8ePmGiwXBy6ceYhKOcJcKJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:36:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a9ca129 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:36:53 +0000 (UTC)
Date: Mon, 17 Aug 2026 07:36:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <aoKd8g43J6k0xaKN@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814172113.GC2563235@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814172113.GC2563235@coredump.intra.peff.net>

On Fri, Aug 14, 2026 at 01:21:13PM -0400, Jeff King wrote:
> On Wed, Aug 12, 2026 at 11:13:57AM +0200, Patrick Steinhardt wrote:
> 
> > Fix this by making the comparison self-contained in the object
> > database. Instead of using `fspathhash()` and `fspatheq()` we resolve
> > "core.ignoreCase" manually and then use the correct comparison function
> > based on the result. This requires us to migrate to a `struct hashmap`,
> > as the khash interface does not give us the ability to change these
> > functions.
> 
> By the way, this bit about khash confused me. We can provide whatever
> hash and equality functions we want. But I'm guessing maybe the issue is
> that in the khash function interface khash expects, there's no extra
> "void *" parameter you can use to store the bit to tell you whether to
> be case insensitive or not?

Ah, yes, that's in fact what I wanted to convey. I'll clarify that a
bit.

Patrick
