Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320433DEAF6
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492931; cv=none; b=W3V8sb1CthPOSDq0/tYVfQ8c5xldAxKESd1NNmlrMEK4kmrf/ZS5XhQLlTQACNdocE8N87NaSGGXNrNSQhrRGq0D2WEVSL2y7SJVkY5LosF4/ofV4l8se1my8Vm5vn8ALXuFY2NjQUKKt5or4WBaHdvHaUpsUXgmUT7FFAL7li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492931; c=relaxed/simple;
	bh=ZPdoAfpjwm69+8gDztrzN0Kcdn5rAA9J4zD1qTpe9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz7VDJX595piqGl5iNLE6sjKdQqQLsI0zUn3B/ierlvdJ3RIc+8TLdvebDE6ZGoXOG8pxq2XD5WE2h868i6PVkJOYsoe6xDE8svjsklXpqlWAdkuLY1pHlU6LO+MFkQOJoM1lkOOYoxQIK6uTA++ekvZoyAsWsFmrQYA8qeWIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RoS8Ttnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pq5k2f7M; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RoS8Ttnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pq5k2f7M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 733131400052;
	Wed,  8 Jul 2026 02:42:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 02:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492921; x=1783579321; bh=ZPdoAfpjwm
	69+8gDztrzN0Kcdn5rAA9J4zD1qTpe9b4=; b=RoS8TtnzShz1wx8cN+1u42hufK
	Fgo0vJ+p+zgeltY6O5pG/O0xjn2DegOky0+K1hdkyVuGZE+XB0n5/EleSkFI5jR3
	zEXaZGFg0tAypBV6/sIARuZX3/NCMtmLQmjC+PPn/8pZNsNmsob9S+ErdwR6RPmB
	v9/uYl9ZiPViHLk9UxSNlLiBW/cx+oSYof1Isx7YJNGERbSO1IDnZ8NBejKD7Dsb
	m7HjcdP/uHabo9GcB67Mknvsk9ynW+h2qJTU1scPN46XCRS9E22yLAndfiR1BbuE
	CgCDLCV7U76Yj+5uKOeR8EFGUbNTWCzz36S3HuaR/ReaVc5/+52Ei9kP0KQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492921; x=1783579321; bh=ZPdoAfpjwm69+8gDztrzN0Kcdn5rAA9J4zD
	1qTpe9b4=; b=pq5k2f7MxW8T7oOHkv1OfZFPEpjnq976z+4aXE4Yu12p+0T1VJK
	qjZf2+kKj6kLL2ZtZjKEnNZJMHuY/p5CJisQ7TVcfCzvYdgXhHhNw/PFuSnP8FCa
	2z8vd6W4q++9hSP3dTjPF0qWcwXth0oLZnvjgJ6vqlqMmnPTomLxdOBtKUxuacSe
	ESr8Fnr2LfRJ5aBElxnJDUUAnjhs2HyTPqaTla6mNZiuQ9DCUgJU5Hmun25G91ds
	06oj32/bHX/xe9oOVZQsLC2xksf7DvCOEl6SxuqLvmp8RkOIJPE0+38EelmkcQE7
	vU5pC7qIcxkg907Sc1YLGVJslHtRP/5Na8A==
X-ME-Sender: <xms:OfFNam4E-W4gfQwP2wFgNo0nHjdPfoFKXojhd43oPqdikxCdWgYyCw>
    <xme:OfFNanWuOyXAWk_f3sPr3uahNA0pcEzfNpPfljGRhfP9PUqqPiLpjqzFT3PpRdxO6
    Iq2LXiwWk9nnF3NPjH65DQXAIRXdqODiuQ78AcbDn0RAL3hr0m5cw>
X-ME-Received: <xmr:OfFNai1ugPdF4aZyxWymTzHP8QlgPapEF9R7IY6unFAjciqGh_z0JnAoqWfvnpEm5QxsH4uEd6AWWbDRws9qOzEBEqsFXXwNkXpRDFZX>
X-ME-Proxy-Cause: dmFkZTGZXL/xVJBZRT0XjNqQmj0NiEBsL4QM8RtI8yDGZADKrRfylrcgFrWZI9uiDIKpJG
    NjKjs02P0Mm6RVE/7hDfUtc9cztgn2Cw1NuVWkTQj+sAuE+2j63eSJoWyolt/Iiji6uwfB
    AwsPpkAgDLBwGtskl6J4DfVEmE3a8CrgO0CsSJrcgOSpTlkDb4uBEU2zo8XcOuoumIzvPq
    jcg3C9N3hj/0A3Ui37jFkht3TKzzhYoJNu6TlM4CtvieEBaYn4bcsRChYX5mEXYpyukiBZ
    qNG2o1iENbIAOWxM/sLhn2X9ptN7rf4lBdIWSM0XtBgVFCdgfwbiDeFlBqFipjcVgu8+Tg
    WML2K/JPUBA+ft1DQhyEkZJMKkLtt33dZI6+tbrYxH7BumRt162KGrafUh+TJvHKeRC+ox
    NSi/dAk5txXwGn8XDEsUE1j6uVG/671YsEfZXRniZI8HtR8y3f4JGV81NfpSlcg9MuCle1
    zkWe8FtbOiA17KoUT1AAyg3+9Ij2wHuFdbPUOwA0vIfudcHZzqFmtdxlmGennh8ZKfGz32
    2eFqubfCtegHpHt3ZkUbRPDK32pTYPms8bOhtCUgUeQYIHwOTFB8sS6Jo5It+JqW0tklA2
    qZLwNGLMw9rOtf1DD9X5LhmsVXHj70c5g/DfRvN3sATtZMTwC1g/UgCPqIng
X-ME-Proxy: <xmx:OfFNas3a8URKawqHxY8Uha-2sPZo7Jelf9Ff6GaSXiht-GJh6xa52w>
    <xmx:OfFNat_S64rWjgoDkd4ezeLLB1nfP5-6SSSWJni12B-_BlSyTCepfQ>
    <xmx:OfFNah2kAtinC_LiExvemoLGB9huJpZf4OAO1i-hm-KbXgIus89cew>
    <xmx:OfFNai_4IDfOhU2LURoJeIQJj-glIdqBjc6cqsY7i__5HKqLbNzfZQ>
    <xmx:OfFNavUc0_M4qkQqHbpVXUzCAFFRqHGIB6Xf_JgOKsi8rcFI94yAqYqm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:42:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c911c274 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:59 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 10/11] builtin/receive-pack: drop redundant tmpdir env
Message-ID: <ak3xNaHeMli-H1wW@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-11-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-11-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:11PM -0500, Justin Tobler wrote:
> When performing the connectivity checks for a shallow ref in
> `update_shallow_ref()`, the child process environment variables are
> populated via `tmp_objdir_env()`. This is unnecessary though as
> `update_shallow_ref()` is only reached after `tmp_objdir_migrate()` has
> been performed which means there is no longer a temporary directory that
> needs to be shared with child processes.

Right. We call it transitively via either `execute_commands_atomic()` or
`execute_commands_not_atomic()`, both of which are called after
`tmp_objdir_migrate()`.

Patrick
