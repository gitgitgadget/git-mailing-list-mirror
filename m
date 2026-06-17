Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CF392C56
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698284; cv=none; b=k7yJo2BaI66SkWqjekP0bVgOjKjdAaf6zjQIa7bIAdAJEOuvpKRgB72tm6S3xTiNkbqWzgFZMwgFeVMqZ+e9vofWnnXGXdtdh14AZYMkepu0vpbj6DMUWyI2wiQOocTypKYa2uvRrnXEtaYayhG4ZeFfDsMHd09oLx2znK5z7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698284; c=relaxed/simple;
	bh=TVYWG5/NLdQkkIY6XyjRdA+Ork+RdQNcJu9+Ps6V4Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8DFKr+3DmNjeeTLdqAxwcMH+fwXcLxgKmDSJbEr1BzhxwqZbpKe6Io3++VmGaYC7fKRQNCca85DGtAkMBnI7zOqQRWMhyF7S5yIJuegh0WaGGVzZ78YGSZ4zLcDdC1mpa2codpUnY4oEZJjkwafiYki4GtB1q5a+0K9GI3DaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f5qxGpoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evEh9c07; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f5qxGpoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evEh9c07"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2312D7A0198;
	Wed, 17 Jun 2026 08:11:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 17 Jun 2026 08:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781698281; x=1781784681; bh=3jST9mbDqx
	KaLzVuBoEl0bL7DzLsDTkZwWGPDYbyO9U=; b=f5qxGpoNOsND+4Tqf7gHzQBoOX
	MeSMzVSK+Bsm3KqYpHckMFOY6J29TtomWgRHShY5oIM0Cdo8szT0hqwlc/fESsHe
	6TPXTxuMPFXbf+5oLYWL6vX7WGBfxc6CusP6DqyPXfb1IJz03hb6LChX8i1KzPLv
	J/dc+lcnEW28lyV/ABO6x7PSyhebXw4BgnAQRuE/H7wjpDa3Hl4ENCBeWLPAJ6kh
	zKbEEg/BrbizH0yoLQcuAxSHTvCj3SNCGxYDG3X+6LZJygKsDoYM8w/Zy2unFGG8
	jKz5xqTVKZOKPvG3CtS1gHsFDAb3aEW2iffZf6uF6Y7e/B7CjrxxpJgz7lKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781698281; x=1781784681; bh=3jST9mbDqxKaLzVuBoEl0bL7DzLsDTkZwWG
	PDYbyO9U=; b=evEh9c07uw0pOSnIXguOB2DnlxXrFa7xDQ/Ys1AVRkOs2YD62tj
	92PdX6Trm8OzoCGC/Eqn3Oq8Gbe8hmunIZUa3L65z58mQQOdDEXPEJWnoVfMvq6x
	LIdK+i2oxG8+CE/nE6DAW2XFgGbNxse3Uq72JRAlrm773dKIhdoCVzc8Hd7rurWC
	nbPZ6JDTzgYUDJ+dfo6wBGY52aPp5TYhB8lzJWDSwMpDGzKdp6KxhlGPvsV8mh5l
	C0IyvPjNecDKix+GdeytwchWGRWSWbaabsZUMMo2HnCSC0CXtg3Dj0w7ptm8c1AQ
	+L1mGm84PBUgvNrayfd537coZfHl0Vsd8Mg==
X-ME-Sender: <xms:6Y4yatWU47pwbZP-FTDLgounlKxPcHPzt5_ZPvuFMBf7l5_nvRDQsQ>
    <xme:6Y4yalC0y6bAbiIw115C6hdUUzscMr5sCyuaswneDcWzD5F5ueJ-YVzu4hwMJeHAD
    ax7LOKX4V_4-mvCMnN2gEkpmeFkoQMkR7J9yTw488i5XWzF97gt>
X-ME-Received: <xmr:6Y4yamyu-daFkLlBq5QvYP993lPKfMZozSCLaMC-WHYs3ktnvu6oB65EwaQSU3u1Djqupy39NaMDybBP441ElM_XOKWqGCZwoRIl>
X-ME-Proxy-Cause: dmFkZTFjUq/pk23AU21HfPQjHvHXR8UKlqUv4Jf/WizKAGAmQyGkZE9xSsn0i8hMSUGVkO
    xo4JIwqpfXxHNAbZNEIaKhEsJin9iLJ3lODdQAq12piSsB8TV9XBjv0T6DDnGK1cQP/KnQ
    6YgOQtWBdxDIbKRI1cx1326FXysD4yXruCj7d0CVwFYbpOUOPnvJa8G90sa/Ae4NvpBixm
    Ch61G0x2uvHLHvPmYaft+UD4LYKsov/rzCtUtICA+28OS0+wb/uPAbqyZhkr2tijEjXw1z
    FwOcxyH2n+36MNTrZA7cqvIRsNORQJZ6Gp+zNsvpgTxyv1DmDzOS+7c/FonRn2cGINTVHG
    LRSYPNZJvGAr2uqQgkbZV41NglN/hW3eSNE2GP4/CD6Du1hQerVuZWnFcrflzN5Ve6cfkv
    wJgbFMjawoyg1sAPWPtr4ASIiBT1l0Ap1D6rn+PFSnuB37Bn6ibC/+d7VExFw4MWwhYL+d
    SIRJBJx5S6D9Z3TQEE3d6umJFAr0AvjetTePBcDXEcjt3BsXDU93jB/2Sk5Bo4AbvbH0QH
    5YqVeac1/gu6KJsVsqY6OQajKq5IrDyVYlLw82bqphNzjCvHnusQdB8Wb/WJQruUFoquO2
    FS4ejhP4WbxQFdwAENGyi3WQfqlR3Nzm/LxEgSNN7H+8PiKrARkRoi0CgIEQ
X-ME-Proxy: <xmx:6Y4yaqDPXjfzVT0pBH5KbfJLcUULmvIpYYqdhRat7Lt3gO8oc-mpSQ>
    <xmx:6Y4yaraiyVPSSasBPtkDrnCZChjBdHvhIhCHeAuWrLlNTctqyTjpXQ>
    <xmx:6Y4yaqhMY7N_-VLPs2lZQfYoFTEePYvvQYy3xO_yN3YLAXIbeBMyXQ>
    <xmx:6Y4yal6d2WDQi7Njj6QNBE83BsPbyPpuV47-1DlcAftqLLE729GJNw>
    <xmx:6Y4yamUfUoaaeenAM7bCcjErjJpqDLECjMpc_3zq99jFaEtRLRqsiB3A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 08:11:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/refs: add "update" subcommand
In-Reply-To: <ajJMnZchqdpiuKTg@pks.im> (Patrick Steinhardt's message of "Wed,
	17 Jun 2026 09:28:29 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
	<xmqqeci6bupk.fsf@gitster.g> <ajJMnZchqdpiuKTg@pks.im>
Date: Wed, 17 Jun 2026 05:11:20 -0700
Message-ID: <xmqqwlvxz7rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We can:
>
>     $ git update-ref $NEW_OID $NULL_OID
>     $ git refs update $NEW_OID $NULL_OID
>
> This will verify that the reference doesn't exist before actually
> writing it. Will add a test.

I think refname is missing from the command line, but the above is
good.  I forgot we had update-ref already doing that ;-)

Thanks.
