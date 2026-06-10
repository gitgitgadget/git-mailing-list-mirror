Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A1391E52
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078945; cv=none; b=rbPGWq9VMKYYW2cvgDuhkWCIHrjV94NKkbkgbm2K5k8fTmCPsAA5B30IDYi1DFq4QUjqIz5BfxHJPu/QfTn+HjPtpH/CSXEPAlH0nDulwqmkrMfFAL/o5kiKVY23cZTx9zwi4vyV/w/m+dixl460/tdWr4Zmc/tE0PeXHm2l+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078945; c=relaxed/simple;
	bh=xBr+fvyCYlFYkSnv+I19TNu0fCFpvPT2glGc8Ex7PEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBZKn4wqfwA24fPoqkZufjatsDYTXmExtTF+xA+N2RszgbcNVOaj+rBrHL2lBHss77yk1KjoWzvPor8Pvv4VyheFMNc8JRiiJ1HxINnfe8VSK9zCb5Ru8pzlF9hagDqF0TQbnvFKGYr1VqFqJQrQFz/Uo9/BJBORlKbjTVTKmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GGNf6DK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N07ko+qx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GGNf6DK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N07ko+qx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4319E7A007A;
	Wed, 10 Jun 2026 04:09:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 04:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781078942;
	 x=1781165342; bh=FjLGIKBaQStWyPS6VZ3iKQjinVvh2MZ4Zzq0aswk8xg=; b=
	GGNf6DK39cjmCC8P9kAD8nOil8J9VTtiae6tr96g6gmRswwo0ukd4mOwWeMPplBm
	T/Z5atBKnRddAicOKxRlliWwNk7BT8tYqeVhHQuSH/UnBR/+FAmBa67jnQ0hHEDh
	GC6bj8MixsMqFuOhi24Vc7hyePv0n+4hLAPtsc+2HUpxcrBwahZTlF3By7Tbect4
	urq2Q0TH6oh4ZnaX37zUUPKSQ03QvCfdrixvpM9AD7ipmwLhu/VAAMRCmg3IoE3j
	FFQne3c6daN0JYngs/hPMGt9U48ILpF7E5k46RDKG87QFooawTx6Beoe3ixjgPi/
	3UB3bg/t1jOfxqraplhJ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781078942; x=
	1781165342; bh=FjLGIKBaQStWyPS6VZ3iKQjinVvh2MZ4Zzq0aswk8xg=; b=N
	07ko+qxfJvzaDDzhPRU7xfp6ZdC4ahyd2H57kOiNHjUMGy74wqGnRptMHoYoZuk2
	z/dOP/193i9R3uNpzXbQp7LpUV68Jw42vXICudyCcrIZiliMenkWfZGV4raH8JCK
	G90XlxQfICRpF2waqzRIACGGAcyVwwOWNOC0M0YyFrpATVNg9PmeBxo2lDcTX7O/
	bcrNrEN+JezLp+Ju5Z+rJZ3WdiRFP0kuSdpz/JNslZ9O8Kt7/QzYWiMMGnnZFc8E
	YNJr8eSXlnJ+ak0oMCDOuDf58LkRNy5Vn0Qpj1eDH0sEqENL3GMgNUJX0kZsfxmm
	ppMQeTlnVmSkC6Zjg4PJA==
X-ME-Sender: <xms:nRspamWm9b9LaVaQk3MgCBmeIoAMxcd-VXpK4glFEGd_UwrmHdXT7A>
    <xme:nRspaplXYc1fTQu6eQq9J8soXjYtaAc2T1wB5MHVBkZt5_8f3cA3i2eTeDoFJFMo6
    v4zZ6adgbQ70h6Dpy0STpFs4rBJoPhK60_L2aU0U2KoBlHruZvTyg>
X-ME-Received: <xmr:nRspavbPG8R3faJWpda1WNveKV6i_uIGa5zkvEyLJ-S0YpxGKjmuc_A4-3M7sFznIe89wWpwVQ-8XacCas7zEtS5omEC81sk-rKV26ovbQ>
X-ME-Proxy-Cause: dmFkZTGyr3YfSBB2JqeFQypAiElOQPv9PPulUcjpRop3WeWLGrV/ToXBRjOmFG43qeWUYx
    zGmmjJsqskuMlvwo7QNmW3ub36b+MrchgCXqJOfZRW1alWnSaZyVN6WJ//0kZaiLj5FP92
    APk4ZVGqebWOb8pu7uxWhyfi1b5ci5i8wsVIAdONUxVc18ynhY/KxraNnItsEUbTMwgYz3
    RcQ0sVlGK1SbyiHHWkXXdLk/LsfyJQ5N3S0LFM0u5Pnt5p07CRVOjZ8B6+/iMa71YsTSwS
    p0w3BirFF8kfsZ0+zFTdML9tzaDw+nA+P3EPXhzT0pnnDhPth51a9oYENpgsa9InLIKlY2
    OrQjc8zDiGpRT0HATWRQRibiJEtnmDeYZefXVlw7kGCFnyxcObPB2b6dHy8WNPIIsPGukW
    1gtY+GQHlJeszCcXQ0HDzTZFRdxku0DiD1A1J4PnKPDQMtYTwg4HPQUXDkY6T0HfyNH4Bj
    U6zTt1E2Lacj1W50c9x0q5E0eejnGXP1JN20fgW/QaGj0rUbMkAg0m8SPlD157TsDNYWhN
    Bq04sPg3JO2caDSWS+A7nF4kTHt6tQTQNRdwd0/Z1BHjx0XSJ8zFsPsKNRRbi1HlNO8skx
    C44/ah2xcv6+PpWx1fS3SfqjUXz9CRA8eZjYMmlljEm06pzbf0pFOPJjOZMA
X-ME-Proxy: <xmx:nRspasOdlmAO2WLKCbzmmodxCOKB5TLSZpOaXXpDBPN3rfmwD-PD9w>
    <xmx:nRspasaT46jMW1CNOLALRj02kjCc17urJ96o-BHW5kRZn5oAjZWykA>
    <xmx:nRspai0dyJxjngm-AQ2ZpfEXTBlaYHZVOY6bYUjl99c_W3cD8Ya_JA>
    <xmx:nRspaqft0f5YdKyY9szRAMBHZ1_NC6ESNhkogk4TQHExVpZ17MhYfw>
    <xmx:nhspanV_xJbGTKXs-cmcB1y-OmWuhIzQwJ8s7WftPehqqOt-OllGgxNm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:09:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46cde93c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:08:58 +0000 (UTC)
Date: Wed, 10 Jun 2026 10:08:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
Message-ID: <aika_Q0rWhcI6eXR@pks.im>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
 <20260609110957.GB1509396@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609110957.GB1509396@coredump.intra.peff.net>

On Tue, Jun 09, 2026 at 07:09:57AM -0400, Jeff King wrote:
> On Mon, Jun 08, 2026 at 07:32:14PM -0700, Tamir Duberstein wrote:
> 
> > The benchmark checkout had 120,532 refs, of which 330 were tags. With
> > `$repo` naming the checkout, `$commit` an exactly tagged commit, and
> > `$parent` and `$this` the two binaries, I ran:
> > 
> >     hyperfine --warmup 3 --runs 15 \
> >         --command-name parent \
> >         '$parent -C $repo describe --exact-match $commit' \
> >         --command-name 'this commit' \
> >         '$this -C $repo describe --exact-match $commit'
> > 
> > The results were:
> > 
> >     Benchmark 1: parent
> >       Time (mean ± σ):     171.7 ms ±  18.5 ms    [User: 23.9 ms, System: 133.6 ms]
> >       Range (min … max):   142.3 ms … 198.3 ms    15 runs
> > 
> >     Benchmark 2: this commit
> >       Time (mean ± σ):       9.9 ms ±   1.1 ms    [User: 3.3 ms, System: 4.7 ms]
> >       Range (min … max):     8.8 ms …  13.1 ms    15 runs
> > 
> >     Summary
> >       this commit ran
> >        17.35 ± 2.63 times faster than parent
> > 
> > Both revisions were built with -O3, -mcpu=native, and ThinLTO using
> > Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> > (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> > efficiency cores) and 128 GB RAM.
> 
> This patch looks fine to me, but let me pick a nit for a minute, because
> I think there is a broader conversation to be had.
> 
> Given the discussion in earlier rounds and sibling topics, I assume the
> commit message here was AI-generated. And it's OK in the sense that it
> is describing what happened and I assume is entirely accurate. But as a
> human reader, it feels so much more verbose than what I'd expect, as it
> is full of semi-irrelevant details. Why set --warmup and --runs? Why
> bother with --command-name, which just means you have to show the
> commands separately anyway? Is the amount of RAM in the machine
> important for this test? Surely it could be if it was absurdly tiny, but
> in general, no, I would not expect it to be.

I agree. Earlier this week I also drafted a message that was going down
this angle, but I think I didn't end up sending it to the mailing list.
Or at least I'm not able to find it anymore.

To me the biggest problem is not the verbosity, even though it _is_
overly verbose. The bigger problem though is the incoherence of the
story that the commit message is trying to tell where it jumps around
randomly. It almost feels like rambling to me, and that makes it
extremely hard to follow the narrative and figure out what the message
even wants to tell the reader in the first place.

[snip]
> I dunno. I am not trying to pick apart your commit in particular, but am
> more interested in the broader use of AI commit messages going forward.
> This kind of verbosity is quite common in the output (from my limited
> experience), and I think creates more work for reviewers. Should we be
> expecting contributors to make things more concise before submitting
> (either manually or through prompting)? Or do people even agree that the
> shorter version is preferable? I could be the only one.

I very much think that we should and even have to expect that
contributors adapt, because if we don't we will basically reinforce
whatever AI is doing right now and increase the load on reviewers even
more.

I also think that we should reserve the right to reject a patch series
completely in case we notice that we're basically just talking to a
middleman that sits between an AI prompt and us (please note that I
don't refer to this patch series specifically, this is more of a general
statement). My assumption is that this will become more important as AI
gets established in more workflows. The number of patch series that look
sane on the surface but that are utter garbage will very likely increase
quite significantly going forward.

Patrick
