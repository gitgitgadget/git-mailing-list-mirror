Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94571AAE33
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911391; cv=none; b=TMlba68KYuZ6L+aoVpmN/+GEbSpa6Kat7hW9WZKO/m0j7WcFvUzIp33MLuoqObMccrPWOx3jvKmrftVV+KIR4xe0zAiEgy6p35bfvXpcdqHEebFR6JsTO6FaaRPRbHCcEHIr97CL21LQ2SDSnUUlYuJhVC9kU7gT7wdyzKDZjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911391; c=relaxed/simple;
	bh=3BiONQy5c7IeXZ/Lw1K7n8c/Z7tfLAPX5uSD4VYZPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyEjI6NvWprZsk7V4zj3u9prqCzzoNZXa/2s8eRXsdJO1qr69PpQ04esFze+y26C1AetrljjFkW9W7m/ESudd5ih6ZMYkujRbcpbmLEd6URr92mG88JfG0OABzCxE+Z/DfSLJOPWN/aS07d7hiLap84Opnx31IIBl/ZzchjQUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XquCh5FR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mI9YYVRw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XquCh5FR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mI9YYVRw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27FCA1140171;
	Mon, 14 Oct 2024 09:09:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 09:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728911389; x=1728997789; bh=WraGLMH3UG
	jWdqF+8AT7tddyOcexPR9OX1N44w8tZVo=; b=XquCh5FR0ehlcglMe1pHxNdESs
	M9I+10gjXjtvbDb0YKdsoPkPjfz5ixTRIzhWgNdTuMPvWGA34bEVX0hoIYuMdo0u
	V3jYqQZSQ6M9sTKgwmNvkHIBvizv4pEIqlQyfHLCoYiXlZA+mkl5Wp0lyTFZN4IR
	4GilwXZlVdz2nAanwcHw0hfX5HavYXdeVmk2Ly68b3jTBavHUUEdIca+0Kc+8ROy
	XbyAj/cKyYZrSQEdIi75pLAQl3qX7EZMfdcAD3sieqld36jJbD1VgKu4mlv3gw7a
	uaKxQFED4rkas/VkxQRb+Qo49AAVNi3CjpaKW1sZh7ZZZ7ZHulfOI0anjRhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728911389; x=1728997789; bh=WraGLMH3UGjWdqF+8AT7tddyOcex
	PR9OX1N44w8tZVo=; b=mI9YYVRwLqR/OiqxwXqa9aMBiOL/fttmWoMpluflpA7T
	GCNAgiqw+C5vJU19Z8I+59nJ0Lns2VMxkpFqubp2+lmK/sHBN7ry1Zppb4D3rkkX
	ZMJccsfEH2TZidWQSTJICRnqOUY6tV40Mqa+RYxsZlepOxTs9+AJZ5j1HjDI8KAR
	rfndInTA2jL/EXMl0qJnOin3h8sSwTGbMb7TRZcDNCAdYZh0z+17K35Fqk3JskCn
	QXQoX47kzHdvtCSe7LXKxpJ+3BJuHDWcmM0IVwERsAAAuI+bo4K/mZqXw+N4f0/u
	RjvaHVz5qVX8LPSMGCp/z5LhfYO+Dyn4h1UfCRNjCA==
X-ME-Sender: <xms:HBgNZ267O3MXZqxhARW_U_InW2vNXtVgU4sGI25O6iav7aqpUuXccA>
    <xme:HBgNZ_69MTD9DHVsIbRM4iSzkOZie-OQdXi-zCGw5uuuKbZg7vzOze2ziF_S5D4GK
    xe9zK90txmxxDWxUQ>
X-ME-Received: <xmr:HBgNZ1dxaJfWNRrqQ9b6wrh2tFXX9pbyw6A1zj7gUnr4b9gxWJEN7YQP0dZmXGETvMMKkhAIw4KOOjimxn5O-A-UF6atO9qTQTTibWDVqT6hFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HBgNZzLYY4AF6oZgetPBKMWNxRnskDcZX1401Eod4wfCIpWIxaS7fw>
    <xmx:HRgNZ6K9G0Xw7ZUi08GkSK62vGgd4gpy3eHSl95FBfAxzvdK3wkQVw>
    <xmx:HRgNZ0zmbSdetSOcdDeQoQZLwxLJWCDB4dLuWtWm2WBOmcEkV46eIQ>
    <xmx:HRgNZ-LnYC_hHDWIrjQxIMc6v9UDqLdRA2O8KkioFBMed9-1OswgMQ>
    <xmx:HRgNZ21J2LmnLzq9gJtsMMLDgI0QW4ngm3Rj2oe3jjdDd9NQykEwapW2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:09:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06d190dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:08:34 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:09:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <Zw0YGX-o4qteQyvU@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <24e31619b936166404b801dde0e2bca478328386.1728629612.git.ps@pks.im>
 <CAOLa=ZSwHeDAFi9RTzuGAi+5ogo9L6XG2K9WHY8kmvz6v-ZAeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSwHeDAFi9RTzuGAi+5ogo9L6XG2K9WHY8kmvz6v-ZAeQ@mail.gmail.com>

On Fri, Oct 11, 2024 at 05:03:39AM -0500, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/reftable/basics.h b/reftable/basics.h
> > index 4c9ef0fe6c5..4cf3f0e7593 100644
> > --- a/reftable/basics.h
> > +++ b/reftable/basics.h
> > @@ -16,6 +16,22 @@ license that can be found in the LICENSE file or at
> >  #include "system.h"
> >  #include "reftable-basics.h"
> >
> > +struct reftable_buf {
> > +	size_t alloc;
> > +	size_t len;
> > +	char *buf;
> > +};
> > +#define REFTABLE_BUF_INIT { 0 }
> > +
> > +void reftable_buf_init(struct reftable_buf *buf);
> > +void reftable_buf_release(struct reftable_buf *buf);
> > +void reftable_buf_reset(struct reftable_buf *buf);
> > +int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
> > +int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
> > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> > +int reftable_buf_addstr(struct reftable_buf *buf, const char *s);
> > +char *reftable_buf_detach(struct reftable_buf *buf);
> > +
> 
> Nit: would be nice to have some comments explaining the functions here.
> I know most of them are self-explanatory and similar to strbuf, but
> since this is supposed to be isolated, it would be nice.

Fair enough. I was being lazy here because the code is internal, only.
But that's not really a good excuse, I guess.

Patrick
