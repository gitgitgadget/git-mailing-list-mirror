Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AA2848BA
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774069360; cv=none; b=IWgPgl4Jzyde+qoh6usjGpH/EIxyi/0H1VhUBinktSimEdV0+KmqIqp8VpnyN9P/IE/2Wp3EV/7jLloyBU6TEIem5rGLRUmw58jIrdpXgQn4NRKQyfU2XoAOBfAvadhGYDd2fJNjM2qi+Od3f7C2vorie7chMOGVlm4znZgsxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774069360; c=relaxed/simple;
	bh=IQUdeasj6at2Gmv2xprQJZDnCFlmNljBwUMDnmunFes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MUO/lZHiaWQKQlm6/iRhjaKBPYWky6CBpfZQsC1tRtYAzueW2hB4JkmF7GQYPSPn+NQ8J5z7G6TGI8HO4RXE4k650ubNzDGJxEjGSftRi5n/rQebrEX75dTFc5RYheQcwhztLpOXhkYxFKfyrHHBn1iV62ZS3SifbvRc0zkbuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lh+AYgYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5wYvaDD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lh+AYgYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5wYvaDD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D454D7A00EA;
	Sat, 21 Mar 2026 01:02:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 21 Mar 2026 01:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774069357; x=1774155757; bh=Knby03JROK
	SZL91Snzjr13d5V1sszZ+Y12GyZC0kicE=; b=Lh+AYgYQfvMQOiX5XCWwI7p7MV
	4j3B0gd7AeWZiPaoik0N2MXpbmeIKwHFDR1Xx8en2OGfdqEEt018/W2SdX2ncbvJ
	bkR1o1zjb/baHAjoBQDIn9RxG1NYyOFEV8ELF+BfwRDQ16HcjaGzqjELYdvhPGjq
	cpzBxYtrH+QfKApfGoj1GZbVIfNESnYlZQufLLvp6xZRIKZ7ObS2mKayyUZpt4Bn
	z/g5tKM9TpX+IIVUu2D4JewakI3lsdaJtzK54Cdd3fGJzaAoHv+JbFcE1J4rfWph
	1gpqz+FXAgF+P7fcb67G30a6bp6h1jkctNRGg85JOUweZb1QqlVfAgf93hVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774069357; x=1774155757; bh=Knby03JROKSZL91Snzjr13d5V1sszZ+Y12G
	yZC0kicE=; b=k5wYvaDDb1yJuaN4OAhxkoqfbHgByxfC8pkwlye8w/QBiG1Y3UV
	VrEL9PL1V5+KVo2BZ3vz9kUHBtHzWdudv7IGTs0dkhWHLxY1CyRZ0dvJkchiLJT0
	OlZvq6W0X5BY4CgqOr7TToGts2boLbsUUKnuuy2U+uHYHgRNqNbpTtxwdcK7CLXl
	1Ohrnr2xfIwNWh5vyi+S+6aohpVruxzQxmUl3xGV8Q0JMWatwLPUW36DPfGHG1ip
	g1F1FdmLnTogbFj+LSTU6/dPeJTn4+BrAz8SuRzqQpw1N+N0JKzQohU7cCGpIAvI
	IIdvka0aPdmvXgdjqw/1LT1Rnsp+DJitJOQ==
X-ME-Sender: <xms:bSa-aeadpRFuX_lPvkIuyJFsSU1Utouogf9wMSMfusXz9W52hSu3iA>
    <xme:bSa-aYTFlW7-maUk1pnMty91jdMmIkEC8rFCXDlMouYTXFKNWVJTRtgnLAcURcBgx
    8FNtuBc8gXSjH1lF8qHuMz7xATzrC_W1MUzckgX6kkARu9FNgFwPG8>
X-ME-Received: <xmr:bSa-aRRE_NU9Q60iHpemOWUD5RqO0v_hBroUzsLzoEQt6M91nTJD-J-KMV-WcIVmYXbTuEAxgJQy_iwDwT7W6iv95M3NyKaKCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlsehstghhlhgrrhgrfhhfvghnlhgrnh
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhssegthhhrihhsughofihnrdhnrghmvgdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bSa-acQepGF7UXmZzVeqm0x1T3jRC3f9FsguVeMSgtZ1eeN8cY40iA>
    <xmx:bSa-aW7uSpBNnjY9t8fmJydZZeVptpiXoO8jpNXOOzxN31P4CGmC_g>
    <xmx:bSa-aY2ygvfYX1S8leQcQQS2Mu1tuz8VMj-pb113cCOd7NnpWAuKsQ>
    <xmx:bSa-aRD8RQVJpCsYBVCwwWC54Id9cgLz43oyobq1IiX52xSTBFeIPA>
    <xmx:bSa-afvlQrIURecf_uDWZgT7fkANR7zO96bL87UqgQaexTwSMlQiuhsG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 01:02:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas Rebmann <kernel@schlaraffenlan.de>
Cc: git@vger.kernel.org,  Chris Down <chris@chrisdown.name>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] bisect: use selected alternate terms in status output
In-Reply-To: <xmqqfr5tdbpc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Mar 2026 21:54:23 -0700")
References: <20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de>
	<xmqqfr5tdbpc.fsf@gitster.g>
Date: Fri, 20 Mar 2026 22:02:35 -0700
Message-ID: <xmqq7br5dbbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sounds good.
>
>> Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
>> ---
>>  builtin/bisect.c | 23 +++++++++++++----------
>>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> The changes in the patch look good (but it is hard to tell if this
> is exhaustive, or there are places where good/bad are still used).
>
> Thanks.

One thing I forgot to mention.  This lacks tests to protect the
feature against future breakage.

Thanks.
