Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE94D4873
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396062; cv=none; b=XINllDk9U5O1EY1GPwlKISfh1bP40w99ouAmwXAsbXOz2hMP8Wt3/FhTI+KCwI4enBLpv7R65TYpuuxZ7GqAzFN69DDe06NjMusWrM0owOePo8JyhVvsRwQZn9UHJ21q1c+1KxME04nPpALtR5/lwTkBgSDYF6Q1sjGDoclfaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396062; c=relaxed/simple;
	bh=ycwYBa9JTYaoGnkzyN/TlO+1hrMkpqUoj3XUXdV3Meg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R6UExzbYSYTwgSjQr7r1AaRCEbyLQwOcLFlaLPD+dg4QybpiurcM588oxm0O52dJh8ZAZQkkts9TmaOwUHUzrCcPgiWl8ZnDib8lZI+PGjY00zD4vr9MuzzYmK8TRj/g4cYvJsY99v5JY360mkmdwsT97x9shUmZWfJbze+Gvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBW3f6rj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALY5Gq7w; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBW3f6rj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALY5Gq7w"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 838E41D00190
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:00:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 14:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791396058; x=1791482458; bh=Tmmg3NzwdJ
	qzDXc/ZVbZK5um978ITWign4rwj5VXOrw=; b=KBW3f6rj+xsE0AisiH4k9BVJmP
	HD2gIkIybFvOicgDpoaHXgDDX9Hzn0kFCdDSJcpNbFUEUaZaUK3zB/MiXlE45BzG
	egyopO6Zy6D/Ms1aAXUmRsKdxm8lp2kkeOLUpYWZ3QwMibsDQ7sHQRt6S0mQ/AfD
	NUX6MzeZhkZIi3OthLkHfcaaCexfkatUBWA34V2cNsVR/xhN+iNZrCcVXJfWZban
	P2FcVprQsrsJsnrqvnYUy0HINwX/SyFyhRu6/epcAJeYiArITxDBbPEs90q1sZL/
	XzFqPfBjoKHvVe1r5O7e72RjGE6ynwKEreTYiea9blneRQt9jimZjbBSR59w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791396058; x=1791482458; bh=Tmmg3NzwdJqzDXc/ZVbZK5um978ITWign4r
	wj5VXOrw=; b=ALY5Gq7wwCg4qLMY7RkcT1bVOiAQuCqVz4xNXwoHioyRi6s/TIo
	DAvapnAtOepQWAvV/vxt752W2rTLhvausNgF53GqhJjOAXaP0rLJ2qGxLQCYpK3+
	+7xrBMPDtW4rKgWlofvIfBYabqQbw7IcPV8uY7B2/AfPNmPKTGEIBYp9KehHQ9uj
	ZWOipnzV4oTiE6BrS3D+P0l+i3t2cgKE91oRwjXZfO5tdCPDaLvLg0zqzG8g363c
	3+Ub1n3J2Zxv3D02malqA4ux2nvwRxsUH7C9k0WesIcnIDc2IHZsA0AJqG26nJJT
	gMjX7iXhoz9LM8sGikYggnUQ5HIuf6QbCUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791396058; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iMMbIFFUiRpb48wyTHeDwlvn0Wp3r+6cIFCk5tRBUgl1xsZ
	sutj0Pe3XlsCct8i6nILOZOXqI7QAHbLk2vml/mvJRVgMHWENBUAkoQanV2s41bt
	a39hxWy6qmkNc8Z1jgKXW+YB2LATnKC9cj8l6pxmqdZbgQCPU55DN8RVlgRX9lKp
	vNyz++kRVha2N7D07xVvYmqfMcf2wI1+7WhXlKa8Jne0ZWLJqq4m3ZAMP5/MAAAu
	fLLEMbt3GsL0KRHPXoWQz2GiBWYiprA5Sg5DszS6KiVILzcutBhYiOfL1uB00O5/
	mek5w9rSuDVTZI9uBNM4Q4x7JdA+6QFvLjxvEaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Y7NoYSl//mVGiQe6/rk3uK6b1ga0hZDyK4OCyLyXkwo=:ycwYBa9JTYaoGnkzyN/TlO+1hrMkpqUoj3XUXdV3Meg=;
X-ME-Sender: <xms:2YjGah2d6xQejhEqE_xE1fjYD9sZzF-2Oe1n4bOTa9PwEGhSP4NUVQ>
    <xme:2YjGaghO-dwCfMYn07NBLlNPFxdzBFBx4KsO8A39K8bU820nC55-77KFUAUrngTe-
    pA8iopcOSHvMsW6Bm2loi57M5dcBNZSGD198cgaCDS1SsbD0JhjL8Y>
X-ME-Received: <xmr:2YjGaiXZjtXb_rnHa8sBwukHwHWDHrHiP2rWh7_95ZEWeFR_VrwMUI7xHbJkUG4E5IhrcABehNm4Qe67eNN_oTQV3dLIERhNhZbt>
X-ME-Proxy-Cause: dmFkZTGg+byOYNZFoLn08igJjJtb4OjDyZa2hywa9i+CaFSngpffifbP+rZYk8NaJFSaaU
    0Fn2u+vmre8ctAYFmYJ7zEUu5a1Tg0d+S9xX3dYyJlyyYfNniBWkb0uCj6dCwGltkc1Frz
    YK/ac55JComMLYTI5hvuNcANHUTz7kIhVlvHqYNrFxxX7j1cb3tJRmnxVCIC15e2bjlpek
    Erea14eYqxvhGSpTzwbCYFDS2K1bdzkxPBRFcjDWNm6IddrGO0bV8A9iByCIrI9jJiSPvk
    skT2UTnMo6tyntsQ6e8JnzeYb0z+7xAZdbTx4x3MrMf5h5IhMPtDgoHMns5kL2+GMFaJAv
    RjFRuzKfWVb8HVkuAi1Yre7kakhUTfkdPI7VE5s0ZcOvl9CtKTmB3bI5Mv0aNUtQeuW3W+
    VkBOZEiQbeSRNd2PGxFOgJmD5nOjiFa2JMZTvwyhUSYmKxNMNCdxKRfgcvxu23wv6e8ILK
    QpjUq0eQPcRDCW+1lWTtTZfMJCgBQp3+6g1haWGS659pMM3IQ2ZMjwFPwXVoXt9t8nxtLV
    z+xl56LGfxDwFLMN8NXGOWabQbVmsLBU0S2EjBOZ8FXnGu7ibWlE6QC+7GZME3ymNF/Ts0
    kgmFA6ylBPs8Pc4SxnNZ9Futab0SnXSC6ByhV2W63eFJliwGe7URF+rppSPQ
X-ME-Proxy: <xmx:2YjGavWBe-_uxfcEQuZlj-O25OjYzpqEpfml5S3ZXXmP__QloWwUaQ>
    <xmx:2YjGaiiSZMHFF-cfrcolUyoRINt1kF05aFRtyPKb6FEy0-HRVJ-yJQ>
    <xmx:2YjGaqahCi53BZ3o5wyAXUSAV0qrWwQ5uoj0NN7w1BKdwwQRahDrOA>
    <xmx:2YjGavr7lx99CzTSaJc6f8azapxO6m0yumfj_q45shBFoHLW6BDIew>
    <xmx:2ojGanS0iIKF6fzxwb02Y2T43aadWkGrxQmwzSrRVcg-S6doahCm6FbI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:00:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Guillaume Chauvel
 <guillaume.chauvel@gmail.com>,  Philippe Blain
 <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
In-Reply-To: <20261007081844.GA606386@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 7 Oct 2026 04:18:44 -0400")
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
	<20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
	<20261002222335.GC833115@coredump.intra.peff.net>
	<asM2YoImN8bHLHj8@pks.im>
	<20261007081844.GA606386@coredump.intra.peff.net>
Date: Wed, 07 Oct 2026 11:00:56 -0700
Message-ID: <xmqqcxtl8k6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Ah, I get it now. It is a little funny to key the hash on the in-core
> pointer we happen to have, but it does provide a certain uniqueness. I
> suspect that doing this would be mostly correct:
> ...
> and would trigger the use-after-free, but:
>
>   1. It introduces weird semantic questions, like: what if you freed and
>      then reopened a pack of the same name and it didn't have the same
>      contents?
>
>   2. It's more expensive.
>
>   3. Changing the bug from "hard to detect hash equality mismatch" to
>      "undefined behavior" is not really much of an improvement. ;)
>
> So I think just fixing the bug is good, along with accepting that it
> only triggered in certain specific cases and testing that. And your
> patch looks like the obviously correct fix.

Thanks for writing and reviewing, all.  Very much appreciated.

Let me mark the topic for 'next'.
