Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2E403AF8
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818941; cv=none; b=NTi0uYuWw3VqsadOs2oQgjN7KfuhmVf8ZRnREK8W7AF7wRQ3MM0Hh9/TWHKtj54kO+rKqHw/l/PZbDdmnm5DwYNalcaeC1dzZxo0foxE0Gaat3wkFU6Fm8wtxfkbWVQyPjEPurEU/PuNn1G3oVqAsXW0LjQJvpcuVrjtaU/Ji9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818941; c=relaxed/simple;
	bh=2CeJta52bUwrcgifrmtpMLIA5Mh41Bby+TdfmQXPvHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNkGDEiNHhRlZM1Gopntg8eZ9LgAD6Xc53mjj3awj6eGxFAJIzhhPVQfzYTXO0ZoT9EFeRGKhujLwXq4g7Jl7W5dv4rr49Pwhk+/wtMnhfzsp7Ui06kzQ8AlOe8wAy2BN0hWfWRNsdiSswElOpASpHJJw4Z+ueJ9vzJHU7Ir1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tCeFiEih; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWLl3jN0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tCeFiEih";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWLl3jN0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A29237A00AE;
	Tue, 30 Jun 2026 07:28:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 07:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782818939; x=1782905339; bh=1TtFDbdQcg
	uaGpD8qqX0andixgjt1f3uL3XYTwbi2lA=; b=tCeFiEihZgCwO1r9WVWKVPTuC0
	vf370/9wFQv4BxrJ7yrVMcrPiyrQw6SfZlInT4sxz7X7w0jsoe3NwES6QfvYr+g+
	Kpy17YuRK+Bn38YJf2iYGSHuIjJ8XJwTbsTh8zGzh8vfhstlrV+KLkfZfZwkxTBK
	jUFSJeeDlQvl8vkwy33b4WSarww+m7NwbqRwE8U9zoZo6ZzHjYGxNuh6E2P/ZcrO
	ZLgJzsqLxqdsoEkZvEN8J0wmkXz/jx+VyZmUkHyOICu9ARtRz3PM/XA/pZ3QUzdz
	GnggwBDgxbWdenGQ/194Z2qr3POL6yLMDHon9mgMRsUTH6IcFscdR1ncjbSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782818939; x=1782905339; bh=1TtFDbdQcguaGpD8qqX0andixgjt1f3uL3X
	YTwbi2lA=; b=cWLl3jN03F2lAfZd1LBdB0f0Lxj4JoE0xighkTFKM5Eap7gvcH/
	AwFxRELd++RuxZHyj8NJLt8qZzEajfEbhMnGe6GimHCcm5R9eLFPMUu/NbfFGT8D
	xRW/GcOH3J1mFFr44EFwB/jEqJVyrHacWc+DIMTKCGPNh3creipQfOmWmNOvnNVJ
	WSNV64tNV6kqhYIJOUtWSUsTiyVU3VH8xOEjQQe39BRzzIR/WzNlnEHCBo6/gggj
	4YGWJuoeWIIPHuZnAX0WA6Z7JOPj+y3l8DpV9yrpT6KPrEVySjDTf7GhnTmNt4zh
	1wIDWbJd1eWuEX9Pc+w7nQcksSFLxxDH0HA==
X-ME-Sender: <xms:e6hDapuhGSsW3um3mrjAj0zzTOKeEBmK6iWuUgddhkzYlo6iZkRiOQ>
    <xme:e6hDap4I0XdhUNtN3SUIwM6avzopy30XbIumgUXwvFZt_7ef-zNlgM69LMjhd6gjM
    RRM0Te9U1hJOCuTed-8LNaVzSg4D11nbIUdqfRa748QxEdQiZaO>
X-ME-Received: <xmr:e6hDaqKn5PuHrCJ9SCOCwLeC-0F4pTlxtIA_omiLr7wqr278SEBv50XdAu4QBjFRrtVI8KwzDoRymMPhWi5jRveJ3DcJCZmwNWO6-QEGN6HIHQ>
X-ME-Proxy-Cause: dmFkZTEP8gyq1rVzNUn/0HjzBgz/9Moq2/c6+W0mF9K0Ur2/hwLPheqCVQEu5fgPUN4FUv
    KL9FS2wCbLmGf3oA7V9vdLYWMhI2ns7FXSZcBmZKBSC57HkBMlLb3tLo3UyLnkeELt8E4U
    7Llf9equv2aBCztzVBoZccck+q6kuD5Zbp+HYjJXvwHnwYNLkEf7ffSaIaALO1PcneiGxm
    TVYdFmNxbtxftw6FevYNH0+s27rskKY6UD314Q3eHcZWTHlugfW/L2NOxqKFOUAggwBC8f
    oE+0u/5jMDTyE6Jah3UOv7BkNTE/wsSTDSV/6ccYOyAL1lRC+ISqV8SogYASQzydVjJGfZ
    5gQyBveZQtAzKv5xFWQSDv9zule1ajxAr6s+F2oK776XFlC8+epZNRetNrkToS+Oypobei
    k0odoEngiWGwjVNmMWkN3QgeEq8cVMqMdXgwVBaZ+9QwVknY5tGeDGrSWTxJcg2L1xd6L+
    lYRx8ZtEKsq3bShgj4kWATTFKFRWEOmOHJU3De2DXheDeOeeC65/VWrxp9KTCTm8C8BWUL
    G0ttMI7Is9o8gJFZ8Uk6MfLf4MS8R6XwXuvQO96ozFeAFMnImbmr33+VnJIIDQSQCFG85T
    Uwcs+/E/vjrbZzl9gLBZSfu0I3A58EJvzPKT47EtjtPyx0M2O3w2qyU4emew
X-ME-Proxy: <xmx:e6hDap5vGZ2p2Zoyimd4W4fpBTC1QycYtOzc6qwxWXE1cx8dDdhNNA>
    <xmx:e6hDatz1JRIRGXIc_Skd2YJ67FQQkLfGDYyxDw_XiS1tFWUqOmcpLg>
    <xmx:e6hDatbXbk4MlcY4Zs6aKlPsztsXf3EvVFW3VR5PVM2bqNO12oPL_A>
    <xmx:e6hDavQzN_bA7zacnX5xU8_FRT8VyDkwFz6w8ifAqR_tzfmfSH6qgg>
    <xmx:e6hDaqw6OKl0kET5I55hTIsqVK1TesqjsTVM-25ZlbLj86AyG682gXef>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:28:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75c5e528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:28:57 +0000 (UTC)
Date: Tue, 30 Jun 2026 13:28:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb: add `source` field to struct object_info_source
Message-ID: <akOod6X1a2axIXKZ@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>
 <akKtc4ybxFRVJmNv@denethor>
 <xmqqmrwdul8y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrwdul8y.fsf@gitster.g>

On Mon, Jun 29, 2026 at 01:47:41PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> @@ -1424,6 +1424,10 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
> >>  	oi->whence = OI_PACKED;
> >>  
> >>  	if (oi->sourcep) {
> >> +		if (!source)
> >> +			BUG("cannot request source without an owning source");
> >> +		oi->sourcep->source = &source->base;
> >
> > And here it is set for the packed backend. Looks good.
> >
> > Naive question: I understand that some `packed_info_object()` callers
> > may not have the `struct odb_source` on hand, but when the `struct
> > packed_git` is intially setup, is it not always known the ODB source it
> > comes from? It makes me wonder if the ODB source should also be recorded
> > when `struct packed_git` is initialized.

I've addressed this comment on patch 1.

> As with your reaction to [PATCH 1/6], I do share this puzzlement: if
> the source can almost always be NULL, what is it good for and isn't
> it something that can be computed from the available information?

It's not almost always NULL, even though it looks like this because we
ended up adapting more callers to pass `NULL` than we adapted callers to
pass an actual source. But in the end it's rather the opposite: there
are very few low-level callers that don't have the source info
available, and everyone else instead uses `odb_read_object_info()`,
where we do have it available. But those callers don't need to be
adjusted, so they weren't visible in the diff.

> Perhaps it is the naming?

Yeah, as Justin pointed out, calling this `sourcep` is confusing.

> I am confused what the above quoted code actually is doing ("if you
> have a source, then grab its base and set it to .source member of
> the struct the out parameter points at", makes it sound like the out
> parameter sourcep should be pointing at a structure with .base
> member, not .source member, or perhaps the caller should be passing
> &oi->sourcep->source as *base to be assigned to, or something).

We have to return the generic source here, not the specialized source,
so that this interface can be used by every implementation. Other sites
would end up storing their own source, which of course would have a
different specialized backend.

So an alternative to write this would have been:

    oi->sourcep->source = (struct odb_source *) source;

But by assigning the base we avoid having to cast.

Patrick
