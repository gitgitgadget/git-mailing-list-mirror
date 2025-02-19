Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C771F37C3
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977866; cv=none; b=AmM8pfBphEMqC/igLT4nvMvD2yxmTIjTuhRqZ9Y8gsHXCti9TeNNtLy10yBUvXm2XdJBwqd9jSPNouS/Fv3pZxVQRQS6B3xslR2I+4dpi7VANBDe5j8WsuKZqDpOOYAvTTEL3MxVkL4Rb2MulRymRPgRIJYCqoGumTxgtED97Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977866; c=relaxed/simple;
	bh=ooguIP43l75QL92B2V1MTlThLvykXjHymFnMShLiUOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKXNmFOsku4g1Ocbul0LVgZM4it7uoLHcAKMEq78cXggoVGcLURVUiISZsFIbE38IAy/RnffjvrBm4z7Fr9KUjyIoUX8Z9EaOD6+JULULwgHVXXuMMtiwTE7sIHlfDkC8WRIzd0adhBNFJEgzib0Y3qgl5gINHIWQXXE4jPX9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AD8JJo0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qy0GXecJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AD8JJo0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qy0GXecJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57C7C25401DF;
	Wed, 19 Feb 2025 10:11:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 19 Feb 2025 10:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739977863; x=1740064263; bh=9S80m8Hmm5
	/QntQ+zA28IvIslvmKi//G7OMY6Ss/CsE=; b=AD8JJo0ZdUZGxSi+Mj9GIb7i8Z
	RqWo/Hk1KQPS20xo20bH1IVUjT8ngluNUE6dOSOLgXelx0LULxsHc7zVn4c9CD9m
	89cbY/+fO/OBD+0i+yujhr+4R4kn75CQhscL5Nn1MB0XkiiVWuC1kYRHJfSo3smR
	wNtXeKHCErD0zQdd9B3rgXcNg9mlY50Nq2CSmZg6p9+JomkEd8S5SJ0ju55i7myg
	6UR1I38MXX2kGEbpj3QmBqrA0RxBP0JQCMZiFnrfxCdilGkDXDWn7iQwCTy7KUZp
	cy4e+apoXVR4Zst/Wovis64vGNKXxplm1sfz7Aj5Gu4f8UAXyGtz7dbzji2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739977863; x=1740064263; bh=9S80m8Hmm5/QntQ+zA28IvIslvmKi//G7OM
	Y6Ss/CsE=; b=Qy0GXecJGfYdqvTmdQMaeol6QGk2s+XYV0us/RiRnJa6Z4EDvOm
	GhaASUQxI5+IyaXxNjGqOqkHXQezvIbtJ4xBqbEhcahARffZD+kgeVvGH/hEkrXb
	g2v21AyLNrJMN94T75l/y/kIS1hAjmHMomdZd7N8gjy7/epUKBsT8O9bz23teTu1
	7ERn09CE5KTrHiudJ5AzWGeue/8wT74jVrtx9qjouXNg627fSXMqBBFFBTe26wBg
	3EViQRFkUoK01E3tkvpGTr8nfe21yQZlBl++fhRRR4Qj+/J3zkyBLOPuynLqhDsw
	s5DxbF6UMpuRsUED01p5AeVLGp/95xVMp8Q==
X-ME-Sender: <xms:hvS1Z1BudnEJh-_K6BHfolDOuMYeRRIAYpgETnYkcBoP1ljl2o4rvA>
    <xme:hvS1Zzj0PhD6-sjNv-6ji_jCm6JJu5L0lqPMLNkJmYKCnz6uvC5fqLaGdGvXqls6W
    A7d649scdMQmkm0jg>
X-ME-Received: <xmr:hvS1ZwmkOCWcDoYIOKpQ3xrWwselZ5mIXEFkyUc_G3MJGabJJlaKAHOucwOOIxx4p5WwFpYGYNofdnVk3ldPPLV9HKYpn_32iY6dt2jO8TbISCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:hvS1Z_xZrQdGMkb7bAeasvPayOvqGVSH9n33uGUqzcGUDw8gNtcTLQ>
    <xmx:hvS1Z6R8O7ym5DO2VvxZ7zN8LcF9cqQgcNZiXzBuSGBTPyQIrX9k4g>
    <xmx:hvS1ZyYGZjepfHc-PtBuYWUku2kpaqlT03kVi3oXXS7GXvy0JPkD0g>
    <xmx:hvS1Z7RTnFHw6do4pvn96fwZlqqJfSspSJS8j8Tk9KBcE102ssRzgA>
    <xmx:h_S1Z3JqAhrfuf2GOwlrsqjw5Ll4g2Jnq9aCB1x24qPsEPa-VLkBO_gr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:11:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff592a8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 15:10:58 +0000 (UTC)
Date: Wed, 19 Feb 2025 16:10:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference
 transactions
Message-ID: <Z7X0ga1nmRheAQJ4@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
 <CAOLa=ZQF0=WgW-2HumRbSp4rUjXikEfecjp5Uxp+zJ+Tun5yzw@mail.gmail.com>
 <282b132e-27b0-41b7-8556-cbbdc08081bc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282b132e-27b0-41b7-8556-cbbdc08081bc@gmail.com>

On Wed, Feb 19, 2025 at 02:34:15PM +0000, Phillip Wood wrote:
> On 12/02/2025 12:34, Karthik Nayak wrote:
> > Thinking this out, having a different interface sound good, but I feel
> > we'd end up with the same structure as currently presented in this
> > series. Only other way is to really split the implementation to support
> > partial transactions as a entity of its own. In that case, we'd end up
> > with code duplication.
> > 
> > Do you think you can expand a little more here?
> 
> I was thinking of a function that took a list of refs to update and made a
> best effort to update them, ignoring any updates that fail.
> 
> My concern with adding a flag to ignore errors in the transaction api is
> that a partial transaction is a contradiction in terms. I'm also concerned
> that it seems to be ignoring all errors. I'd be happier if there was someway
> for the caller to specify which errors to ignore or if the caller could
> provide a callback to handle any errors. That way a caller could ignore d/f
> conflicts but still cause the transaction to fail if there was an i/o or
> could create a reference if it did not exist but leave it unchanged if it
> did exist.

This is a fair point I think, and it's also something that I called out
in [1]. We shouldn't blanket-ignore all errors, but instead only ignore
a well-known subset of errors and then record the exact failure reason.
This allows for better and more unified error reporting, and would also
allow us to easily build mechanisms where callers can specify that we
are only expected to ignore a subset of those well-defined errors.

But I also think that this is another selling point for continuing to
build on top of the ref transaction. If we now want to record and ignore
specific errors, only, then this falls out quite naturally from the
current design of ref transactions. We already have all the ref updates
in there, so we can then simply set an `enum ref_transaction_error`
field for each of the failed updates.

Eventually, I think we could also allow for modes where we declare only
a subset of reference updates to be allowed to fail. I don't have a
specific usecase for this, and don't think it needs to be implemented
without one. But it's another thing that we could implement on top of
transactions rather trivially.

Patrick

[1]: <Z6YxA4BlhNwbeYk-@pks.im>
