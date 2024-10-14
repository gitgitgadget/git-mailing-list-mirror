Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C41AB511
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911394; cv=none; b=T1a9Mt7xs+kdvt1ceDqrkYPVdXjQZlioenI98HHRQSjebD6l7CnEM4X6sYUpVZnCsjlxIyG9QRYaFbYbB8Oxy3DLjrr03cb4M4pEkyg4zL8tafYxEf3psJTFZzp6vrBI4pGg6uwBkyBVKS1uNJgo1/C128jWMBK2hOfDv4Ucazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911394; c=relaxed/simple;
	bh=ukl6RHt7zWf4WRNA071DutVSEkaJCB653yzioCMj3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAXTbK5DGaeMAepiwfTBY2DzETZV5H1vnyxJFTSBqW8phxMGU5g1taHXDbwSFui4EXvcsebSspf+X2rsgzdvTqWcNHg7IocmfFM87YIzJ1cpgVLVmWnYIYVv2zcVx5NkQXsT5EZXMAxTnadlElWIf6jH1q5GqcK8IfxIvXD6C5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Djsbidjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOH/PBiQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Djsbidjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOH/PBiQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EC68138044F;
	Mon, 14 Oct 2024 09:09:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 09:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728911392; x=1728997792; bh=4XMBq1h/ha
	Z/SbJ+N4fAh82gnCoiGrHI5Uuc1UvpAco=; b=Djsbidjlkt7IYwDiPm1xuC6aLM
	iCCx6b9vg3duHcEFi0e8y4SW5pinf+X1rH1+oKsDWJm/dbUHDX/yO6R443nrlBIY
	VQKyKLvC4hxpeCa1K5L5NI4leRhFMKdpfy6yTjf7MiIm6kPoXy3PfY6yIQQVrbKr
	/hCaJR3Mk+YbXSRg08UUXYQRqHrmtA5eaFf9RIrfwzVyuci5uneZ/PWiXLl54xqm
	edDPaXGsm4H2UBDigdvcSc6gBdXzPh4yA5Gz/k+7BZpBTpzo7rW6h31NbxEx2k4Z
	KCjBvZcw08QIFRGYC1x1HFFXFaysIZe1kkywzRtmORp2Mo7hBoXvqtRqK+Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728911392; x=1728997792; bh=4XMBq1h/haZ/SbJ+N4fAh82gnCoi
	GrHI5Uuc1UvpAco=; b=hOH/PBiQFBUIzLjJLykNdhhmkmHE01+y35kQmUCiJtL0
	LrggwDGZZhQkn3CovD3nfHjcfmS31ih+x7WCDmwpNo1rbJ6RPYTOzf4qCoRf6lrt
	TtYSjlT0CGvJ+qG9cRIA8vm4biCSJkjUtvJkl2rIJh52Cn8dfdm0jf0hliILhKuv
	HqY3wIvySItnxg7L40ZdlYvIFyUGtDuiTp8OZyQJOzwOsA1CQpgysdo3tjboumus
	wkWlWThud/ONcjsGZYVMvPFgveo9O9Rs1FdguE2O8+DE0p7PBhid9IAPQxXs86KT
	+jUa4ULdyv6urfOMUG1BfRpFUFlFu6mw5gVlbjthiQ==
X-ME-Sender: <xms:IBgNZxAPCnNSgZt1XsIIYa0gm9PAHa5rJ8_AOa6iUTfrWDM_Cw7evQ>
    <xme:IBgNZ_jlhg-iEzTnYTiyh7c-kkDv0o1C3BHfWulckE1PfUwuCJDk3t0R7rpuDB4In
    JGfng3SdmDZa5oDhg>
X-ME-Received: <xmr:IBgNZ8kSDdcADkw68Dq8--fA6NrlKvJ1QXqqaBycjX5ATe_SYZbcULvEZ1GKLKcrgDI7w83pDysvhi2VkZv3dLvvHsDiTl9RZWru6StTj6gJwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IBgNZ7wBoTO6q54aNsmiCUZZkeuHYIEL0nPJX3SDENOjkntJtnuWlg>
    <xmx:IBgNZ2RpsIBH9RCUvb6-8tM9m_wkQcR_5hRCamRqalYW-lCz10FdZw>
    <xmx:IBgNZ-ZT46pAGHyXDnhQffflXddEPfziZIHKkip8jEuvFL4Smd3RaQ>
    <xmx:IBgNZ3Tu0D5weOHt-sbeT1uGxk55jw0VV4Bslb0c2T5fvbJ3biVNTg>
    <xmx:IBgNZ0cQUBiwi7INyYc4JWC5D-MwBIdUN2-a66MpKFs6uwCC08TXXmgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:09:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8167f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:08:37 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:09:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 04/10] reftable: convert from `strbuf` to `reftable_buf`
Message-ID: <Zw0YHQ9byrFmKCmP@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <e2ac27dbca0956bc231ad2a866bd796170deacf4.1728629612.git.ps@pks.im>
 <CAOLa=ZTOVGNxqJq0mj9GuLFqa6mVHp7WOkhuQsgiW79OKhhyNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTOVGNxqJq0mj9GuLFqa6mVHp7WOkhuQsgiW79OKhhyNg@mail.gmail.com>

On Fri, Oct 11, 2024 at 07:12:59AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Convert the reftable library to use the `reftable_buf` interface instead
> > of the `strbuf` interface. This is a mechanical change via sed(1) and
> > does not yet handle allocation failures. These will be addressed in
> > subsequent commits.
> >
> 
> Nit: Would be nice to list the sed command used here, so reviewers can
> review that instead.
> 
> [snip]
> 
> > diff --git a/reftable/basics.h b/reftable/basics.h
> > index 4cf3f0e7593..ac3100417ec 100644
> > --- a/reftable/basics.h
> > +++ b/reftable/basics.h
> > @@ -104,8 +104,7 @@ char *reftable_strdup(const char *str);
> >  #endif
> >
> >  /* Find the longest shared prefix size of `a` and `b` */
> > -struct strbuf;
> 
> I guess this is the only manual part of this commit, would be nice to
> mention this in the message.

Well, it's basically a lie anyway that this uses sed(1), only. Some of
the functions are different between strbuf and reftable_buf, and I was
too lazy to craft an sed invocation for that.

I'll adapt the message a bit to say that this is mostly using sed, but
not really, without going into too many details.

Patrick
