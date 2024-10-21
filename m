Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47D1E0DE9
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500302; cv=none; b=esUpgJC+TWAXPKMmmiUR+YcC+4gGndKR2bKjFCTvT2OqxipX1JfNhsYYGmp+Hz3DCNZpr5LMinqQkzkDtSdfOltojQirYlXkCmsa8Mao+5tfOwnMDv+0jfc0an+KzkghqImrKqOQA8Jlav80nnETzOZTppXK2qXGvA/T7OQuyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500302; c=relaxed/simple;
	bh=YmmVdMyswaHj1K2UYgbfp2IjEeMHZ9rqI73hZZUKtE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLTjhGq+B9KLZfKuFDhAkWniq2w4E7HfWhYfa+oDi4JVfyvnZyYqQb1fNcBoPPTf87yyVJ9bbmNvr0cOw7yboU3MvsTJlctd1d14ncoSksaUHqz0acn/mxbQ77HYR32ixqPKXXBbAX9Tok8iFsNSoZ4uPy24TaK95EhtOeakSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1hwOGpZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ci1u0MZx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1hwOGpZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ci1u0MZx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47A8C1140218;
	Mon, 21 Oct 2024 04:44:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 04:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729500298; x=1729586698; bh=TDKNLW+eIP
	w2qGsxj8P6Mjr5TsyfyPRwEmDCrKzuxoU=; b=1hwOGpZUgCnpDjZ40K4CjF9Gp9
	94/iMshn3xunMt98BcmITg+ka9RFGHBSgATzSjyMRxnZ/uT4nOgptOHf2JYUtF1h
	hhnnYUtGxs1Bhb6ftHAZu0HFO/p/GyyJK/yepC1OC/BlUhbJ3sZNNvecHo++OcGq
	IFf/RGagCCcC0r3S9z6IqXWRgnlMad2BResRNbA5Govmc3Vxqy9y7Pz4lViNcpUV
	VzwCnKKqdKL9wBRYHQHC/eef9mkNApP6gsShgE98PQY1kwXzmKXFri6zglqDP8/u
	Q4XL9qHTFTSe0Qgz0Qsavm6e6PBO4RoCf2NtvF0wBq6GLGk4AJ36Ilse50JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729500298; x=1729586698; bh=TDKNLW+eIPw2qGsxj8P6Mjr5Tsyf
	yPRwEmDCrKzuxoU=; b=ci1u0MZxh+qR4tIEKF4oBrqUDmyEV4SHeI+fyxnQaf4V
	YBJva08+v16hv0V0A13vtrRpqGMzvS58hV8YKX1AM+NVfGdmlcdgj64tHf9mt/k1
	xDCYdLHCAgyQxe3MXj/xzRhj5sc5/nrvZ+P4AAjxDRc5H8a7jyXbsCoJdEYOqcSL
	IWLSSC0HcnXRmcvr46T0Jk+dgKxJiGxg08OtrGh4HfmCmMrSETfufZ7pqT2Sf4Zg
	BI7fGx46l3UZrUkYhIdwm9Bnjx1ODrL1dPMXRw0yHCcwgmEU4xkTvvMcVljJEC8T
	qoX9jdFKKYE9elY+hXcQGjOyLr45POIvUXltoB8QZw==
X-ME-Sender: <xms:iRQWZ96b61VFKzCmhhp_HEUNCqTBf8LUZ8nEcFAkFY0PwWeGNWRocQ>
    <xme:iRQWZ67t-L9KIaOIa1RlIPqU67D7oz88A0X374rHWTzoV8xjwYDDrw25Ql8M07aTp
    JVzK5g2xSq7lzU5sw>
X-ME-Received: <xmr:iRQWZ0ffT1qF5uscJzCPPHxc7-cE661gTRUPN04aYccEA0MG9MRdOHxnGeHTkQd3kNQ570fg-eMWMZT9Ce1iqcWglOePSyEULydL4eSBLo_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iRQWZ2JH8-IV50vBxWDgOkCE_Nva95oizUKLPbdkT59E-MOzqdUg4Q>
    <xmx:iRQWZxI1UzrRso18y5fNO_YMgIEakwMeJw0AGALsq65mLtYOtecfRg>
    <xmx:iRQWZ_xgmqCQ5FFEnYlOSV7DtjHyrrHzvsSDA6PvroSN-vzExjQOPw>
    <xmx:iRQWZ9JEy3eN_qT88D4M_RKxQT0FekYNKUbnFHS9GXZMoQf2XIHElQ>
    <xmx:ihQWZ4USFckxu7HfzoBWkDmt6zwNa9Tc1z155ECGzWqCipVEYwX8wBPk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:44:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8964a6fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:43:28 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:44:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/21] pretty: clear signature check
Message-ID: <ZxYUfyh5j7EiVRdC@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1728624670.git.ps@pks.im>
 <87a5f1d3fb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5f1d3fb.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 02:02:48PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The signature check in of the formatting context is never getting
> > released. Fix this to plug the resulting memory leak.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  pretty.c                         | 1 +
> >  t/t4202-log.sh                   | 1 +
> >  t/t7031-verify-tag-signed-ssh.sh | 1 +
> >  t/t7510-signed-commit.sh         | 1 +
> >  t/t7528-signed-commit-ssh.sh     | 1 +
> >  5 files changed, 5 insertions(+)
> >
> > diff --git a/pretty.c b/pretty.c
> > index 6403e268900..098378720a4 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
> >  
> >  	free(context.commit_encoding);
> >  	repo_unuse_commit_buffer(r, commit, context.message);
> > +	signature_check_clear(&context.signature_check);
> 
> I was having a very hard time finding where this gets allocated, and to
> be honest, I still don't know for sure. I think in
> check_commit_signature() which is called by format_commit_one().
> In "[PATCH 20/21] builtin/merge: release outbut buffer after performing
> merge" you mention it's not obvious to the caller they need know about
> memory they need to clean up, isn't that case here as well?

Well, I think it's clearer in this context, but hidden by the fact that
we pass around a wrapper-structure. But that's not really the problem of
the `struct signature_check` subsystem, but rather of "pretty.c".

In any case, the callchain is:

  - `format_commit_one()`
  - `check_commit_signature()`
  - `check_signature()`
  - `verify_signed_buffer()`, which is a function pointer depending on
    whether we verify a GPG, x509 or SSH signature.

From my point of view, that callchain isn't all that important in this
context. All we need to know is that we allocate the signature check
struct on our stack, and as it may get populated we have to clean it up,
as well.

Patrick
