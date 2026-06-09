Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886673EEAEC
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002071; cv=none; b=sQJRX9wS5mEVsjUU4r4OJKvTUWU3D/8kXkzxEWxfjNnjkohGfIyobc4JY/uiS0sAAA7iHAZRuv7hPsDaRYBUFiS/bPEpLmKwazC1CX8pCrxnOGsuU2QSSf+7O8NKyHgGD4HGlD+349uz9jNwNne1FNimgM5nA4uAMfPwEUZTbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002071; c=relaxed/simple;
	bh=X7LeAwzkd6n7eLn9O7IrNBswRFx7XXLQZuvQnFf1QRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0K/9rilE/aOp1kFQP9xryQPkXn/roXzJCABQJjNDSYZmRX8i+J3V8yI22YtuvYcl22HDuRZRM+mdfX8xBGQdCwY6n33pznmqirMbqx6hAgtcIi0sy06oGOYWg4mB88eYhZ7cc6NJibiv9FpaRk44oY3+T/lvNePDyHAINVDc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CClkyHQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqJkt8go; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CClkyHQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqJkt8go"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A7BB91D000B4;
	Tue,  9 Jun 2026 06:47:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 09 Jun 2026 06:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781002068; x=1781088468; bh=BHCbk/HhSa
	LmiLAp0Yrs1x3Od84dtHlBKtP5AbWWAVg=; b=CClkyHQ8l3F8zAlyxf4Oqnr99l
	MVEMh9OKTV2afyKzrClZu28c3hqOQZh/DJy2KcCIRPCHuz/huIFQ4axDjEiqo2t0
	mu4ifOzAFphzbsdFWHk7bOstRKkkkJnLHONrYPccy3MMRU0EMg4EPeCT3giyiWaV
	Jv4emfdqLXIJdDuVsfGyRaiqtS27u+6iuIgpr++Q67R5HS3QWPgRGjYtRIHCTFCR
	WpG/gpfyDto5QfSWskhnq1zu9e18qLHrjHWR9NE73vLItEK/rWYKfgLE7+HwDVrC
	LJXYMOANiGjSkfEN6qLE83hZCkPYLZWwZ74qJpUsIxQJFy/7GUTwDnMilIMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781002068; x=1781088468; bh=BHCbk/HhSaLmiLAp0Yrs1x3Od84dtHlBKtP
	5AbWWAVg=; b=ZqJkt8gouzWXHO5hY1crmNIbXxzMp7N1xZGgvuwL7CfP6M45c7x
	eqxJWP5zwK1JhIbZwlJJoGbZCd33lbliEEvwQz4Hm3e6XfCKGVvfDKNmB/+ERGGm
	TY8wjOF2v93ROQOLjGQDNLVbHeY/XOTWWvez4NA8PqaluB+rxn38xt2Ap38BTE5M
	dBN3CuYqYmM+8twTuhc5hoIrFvuCHz4AwvvUrgoBpeZ0Za3atlnukvyklxJtF/V6
	r8sPwrofQQkomBZAcksNRlqzq2qvbkniPXzYJN+xsW3vCx21DOzepHQt+05Q4kxj
	WETGSW1kr+VJHuNS2CX9VPJi9KhEFYnvJ+Q==
X-ME-Sender: <xms:VO8nai4LVtH52k4RN7BTIXTHsPeGe4Qhi0w7JQTXXOB9rmEf8XTXWg>
    <xme:VO8nah62qXqlp3K7QkmJNGuAKtit9IVWLghVL2yUyoqSKRys6zXEYXStYOwSgmcxZ
    AmEz6krkBTi03thkM6fJIYDCuTf8y4VCPG-Nr9mYj6AdfISJCKhBA>
X-ME-Received: <xmr:VO8navF00s-WdXbRh00VOHne8K9kf5MsbCEn0dtdFKA4YUEGKel3OVPWLc71YuJKszqRd17urRZyh_LOjduNHbHrqx8YLzE6KN-Q4hgsSXc>
X-ME-Proxy-Cause: dmFkZTG4Nqld7C+NNTajL+JMlJ80rf2YOPB0Wa7HF+jv8RPUfyvxidyGx0QtLKcPj2l32B
    5ox320IhoJ3/wjzVFKfCry5+Clh/oipNDUdkJsyRCktKAk2gWkGjRMtTyI8OIvyVZr6sBd
    YN7YM3gXO6d3SamWa/EJ9Gy5Aj6IJUdNQecfn0DI96/HjAv4hb/DXDV7nWLimmcMtA+We9
    siQS9tUNpLeWQtfdlpRsQcVZuB63c+UdqGB2C9F125uFn8ivIVO3e8Zx2ySRX2Gw+1pSzD
    WmwcRZO5O3vTO/UJInwr9HmSGXXPFwL7D75iQUQ54nt4Pl0g7XfNPawlYLX5qXhO75GnlZ
    PGfD3m4bKIFanotG/2jruBPJ3VhFBVrtKJmnN2WoPw1GYt/OCIJ9ppymMSgz5foi9Xt2pJ
    JH1tzhn1DkrqxSN0Ay3zRiF4975nXTxl0rNbhvlhDPVAiNihKiYLUkkq0OaZAe04jyyuhe
    eC1LEcHOf+MhxXznPcbbJ4M3lCbYSxtz4tZDHiuhw0K9ceo6J0cPhys9+TfEwmZEPI1CyI
    wTcR4RaVQ1dTmmvez1xi9BMKRXs42ND1ogkflqc3nCYkpxsME1cnMv/fv0omEGAB+3CaL/
    99f9CVwm0mrmhCAA6z5c0w4mkSHs0/4T9we2AIl/4cwX79icG4bRec7T4Ogw
X-ME-Proxy: <xmx:VO8naqSZsoWYb0Kg3EdF_ngFf6JGzmeoPQROnydCXg8ppeDbF8-bqg>
    <xmx:VO8naotACyiY7yd0dflJHcS4Iapec79NNcm36qG9Tq9_7QaTHxE-uA>
    <xmx:VO8napxIg9BXPJ5BuWUZraOqldl4z-OXOrdikA7zc5E7C9_KM5Fcxw>
    <xmx:VO8nai7Fhs4P8OHHYW5JULjLyhNNozcklpTvzN8yKX6nzMVtu6JvKw>
    <xmx:VO8nagqJFfaietHtGKJstWQFwf9OVlzNG-ET-MuMMHDJkXZHf7MKIqGX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 06:47:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78c36667 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 10:47:45 +0000 (UTC)
Date: Tue, 9 Jun 2026 12:47:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/16] odb/source-packed: start converting to a proper
 `struct odb_source`
Message-ID: <aifvTmsPzaVdC8Yq@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260604-pks-odb-source-packed-v1-4-2e7ab31b4b5c@pks.im>
 <CAOLa=ZQst6ucwvtVOfXC6g1ZcP9_UZAwRyAXfQdjL7WcJ6ZzxQ@mail.gmail.com>
 <aifAVpxanV31KUpC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifAVpxanV31KUpC@pks.im>

On Tue, Jun 09, 2026 at 09:27:25AM +0200, Patrick Steinhardt wrote:
> On Mon, Jun 08, 2026 at 08:29:04AM -0700, Karthik Nayak wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > > index 12e785be48..f81a990cbd 100644
> > > --- a/odb/source-packed.c
> > > +++ b/odb/source-packed.c
> > > +	CALLOC_ARRAY(packed, 1);
> > > +	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
> > > +			parent->base.path, parent->base.local);
> > > +	packed->files = parent;
> > > +	strmap_init(&packed->packs_by_path);
> > > +
> > > +	packed->base.free = odb_source_packed_free;
> > > +
> > > +	if (!is_absolute_path(parent->base.path))
> > > +		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> > > +
> > 
> > Tangent: seems like no one sets the 'name' field within
> > `chdir_notify_register()`. It is meant for tracing purposes, but if no
> > one is using it, we might as well remove it...? Perhaps #leftoverbits
> 
> There are some callers: `chdir_notify_reparent()` calls
> `chdir_notify_register()` with a name, and the reference backends call
> that function with names.
> 
> Ultimately though I think that this infrastructure is somewhat misguided
> overall: we use this to update relative paths after chdir(3p), but if we
> stored absolute paths in the first place then we wouldn't have to care
> about the paths changing at all.
> 
> I plan to revisit this infra for the object database going forward: we
> expose and use `struct odb_source::path` in various other subsystems,
> including user-facing ones. This is inherently wrong though, as there
> may be sources that don't even have an on-disk path. So there's a need
> to drop that field and make it an internal implementation detail of the
> source's backend. And once we've done that, we can just as well start to
> store absolute paths.
> 
> For the reference backends we can already do that refactoring now-ish.
> I'll send a patch series later today.

Well, as ever so often I went down the rabbit hole and discovered way
more than I wanted:

  - We never free the `struct repository::refs_private` field.

  - We create the refdb multiple times in case we have "onbranch"
    conditionals and never free them.

  - The chicken-and-egg problem we have with "onbranch" and refdb
    creation is awkward.

So I'm now sitting at 11 patches to fix all of those bugs, and I'll also
have to make changes to "setup.c" to fix them. So I'll first have to
wait for ps/setup-centralize-odb-creation to land.

Patrick
