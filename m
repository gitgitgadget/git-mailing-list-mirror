Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F3260565
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366563; cv=none; b=siOppCAVGxKQ4XBdiIcs27y2BRnZEv2XJuKAsCn36swhkU6izFfY5LW8ZiAC3c4sS4CG3n9yPly2/fHQUm4MljjDEXdaFEMOScXkKBNhyi5+dJP2C517K4oPoaLF3exLyOYAYE2Wzp1Xc7xe9E5M1BwR/KOSRg6LUZc/p3apF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366563; c=relaxed/simple;
	bh=xSN5qqW1M5oVyRvNY/YHmss5WM6e7QbcHYQp92eQAtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CqjznkK0mDCFSuylA1VCyu8kLOhZWZnvuuSM1r2iB3lQOUtzSXfynPw9Gu1TDogS7IVqN1+ih4qomRO7zrn/NA7wTZSnIyFGm5RBEHaF9vrtuGDI+jjPeaq+5d3CCOdkpCGmo5Y5OcJt73fDnPq164128Xjb+BcGSebj5crgD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V5YkxUTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2nICHKZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5YkxUTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2nICHKZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 458E3EC0085;
	Sat, 13 Jun 2026 12:02:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 13 Jun 2026 12:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781366561; x=1781452961; bh=g/pBBczqEX
	KSw5Rg7WMaV3F6nIb4j7o3eBh/tURUIDI=; b=V5YkxUTEM/EqXrsQZDXF6POWap
	vww39bncz7bO2LDZ5wE2W/f1XVgpkFhXympfGs/qOvopGCpHebzRGpQ0nOdRk+Dt
	1WrhnGQwc18GZQqLOaY/QKz1sZL5tptNRrJePApfAC0rPndaQpnsTF9s+kO3B45W
	frCKtBpW2UTP+l5QcCXwfflLGzKllT0udt4x1jXHJdx/BGCh8lK16zbzlH3xvVx0
	6NNJBQXsu7OTwebIXD+wFLhAAe0BSSLr2qPlcR5RX4vspOqanu/u6wCV960iODuf
	CL4Mg3i5xOz4swQKMejCvKZn9uLFc61oD/dUkuwru7b5bmKLYgaS/17Bvs5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781366561; x=1781452961; bh=g/pBBczqEXKSw5Rg7WMaV3F6nIb4j7o3eBh
	/tURUIDI=; b=Z2nICHKZP3vw63yDgCLZuNqJzDZbmiYXPyF3OEjhrea1Sxhylz8
	3kIxpTSi3SSI3GusviLT2q+I49ktwJA0jRP5B384OHcWTIlK2ki3by4dp/ss4xeW
	8wDTtg3iEW5yn0kGW8PPEpYf2w1cAF8cYA1Uohr80zRLJXOiEwbEnemYG9KhtRHJ
	Y2kQXFrIBfaFX2+I7t1TEoCBZsroUFp4bthryLMFHEF1ps89aPW5eybV2KSgxmc1
	66GJODtKVoHaUXEfB0VNF6X1P9H1oMjaPBt/vgSpTBSsTKyCP/7F+8QwwercVGzG
	uL7h5t5yUI7NlmaTzKGw7za2wZGz7w36pSg==
X-ME-Sender: <xms:IX8taqWBnh1FPoZWeFarAAjKoGqkFcDu71W4qSDYsfkQ11i80FyssQ>
    <xme:IX8tatkxQgIJLnZqn0cj15jCeNE7WlRbDb35DUQkR2MvCQWBYsghe1ag4I3VGmmvs
    E24d8wOr3jwMhqrx1HMvgD6E6QJKIDQ_gQDWam5ZQCd7-R2ECruXw>
X-ME-Received: <xmr:IX8tajY97v4zYOt6on73SxbqjxNzo7ZLVYlmtg3fO3AsAD2CAqr40h35NYmtLvy_EgL1FUXsSiLeXdxfRgN-wegCVXjv3OcJ5b3g>
X-ME-Proxy-Cause: dmFkZTGVPlcI6b33ZTwEI9Aw05eECvQqZsh7J90JRtcClH3c4hbPCf215SXFaTuYpjeniA
    qLWFZ6Ri4MuK6hc2/twVZS4mXfey1D/kcv+uWVflFtYaSaeL2a8ma/Rw90T0a9M1rJtrEI
    GuJWnDf+J4GPixg60gDw/PrSN1qcVpJJSoJk9Z3QULSSCqJl+84tTggV2LG6ofsSFvN0vH
    epCQJVNXLBBWiIM+DBfIr5BjWFFJPL+z0rF/MlLyNUc90I+ABmH4OAhJl7z2nvk8nxI1Ks
    oS/RuaQbL+VLMpSzW38Av1tna7BY/SLRINV9rdYhIzzrffaTMkvuoas2DnYPxYONWciJX/
    w/qNdgoddF2bv0vnLjshob9OXxKTN66lQbeglg3a4YeUofxTj/dGXo+TzWKCL/XMVejquv
    YKM3AvxA7gRW/bX04jQhKqHOsGpE2MjsgoAGKcid6K61+0AajNhRIvLO+/ukadBjDjNb7S
    zGBi/GHCOmM8p43Pe3jwelYnLgNCmp/icxpZA0xk/lYLNOXImppOiOo9uJjd/KaBl9GkuT
    7PoGvTOzl76cR1rpPw2JI/RhUE4dzRSQlkeVAofIogXEBSGk5oM08E4TB7s7kCivg3A6Ww
    rizUSbcZpphWVb3zsGQTjH/MLd7zeiKvWwuqtSt1TSYg4eS78yfCPReqV1ig
X-ME-Proxy: <xmx:IX8tagOiVrH7y6-5Z0i_pWJD2GIU9XD6AemJCX4UgugDfU2Mu1ekyQ>
    <xmx:IX8tagbjdvmWUJfRDncSp875_z3nNGewZEYG0-d2_WfTnBLDRXXuyg>
    <xmx:IX8tam1btNNAk8XxIBP4_tW5gCNBW2VKdkBDkbst58lFWQ9lstjTBQ>
    <xmx:IX8taufuVYSgyHDo-8p16pFz3Qt3ckvYZIW1h7AhaCUhpht0iN9UQw>
    <xmx:IX8taqUkvpaCgP0w3MiS3db4oK-nKg4U2pqhFuTUZucocbHRVJZRRvZm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jun 2026 12:02:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [RFC PATCH 2/2] doc: advise batching patch rerolls
In-Reply-To: <8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
	(Weijie Yuan's message of "Sat, 13 Jun 2026 22:09:06 +0800")
References: <cover.1781358364.git.wy@wyuan.org>
	<8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
Date: Sat, 13 Jun 2026 09:02:39 -0700
Message-ID: <xmqqwlw2e8dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> Contributors often need guidance on how quickly to send later iterations
> of a patch series. Add a rough default of no more than one new version
> of the same series per day so feedback can be batched and reviewers have
> time to comment.
>
> Mention factors that can affect the timing, such as series size, review
> depth, substantial rework, and how close the topic is to being accepted.

Another good thing to discourage yourself from rerolling too quickly
is that such a practice forces you to think twice and be very
careful before sending patches out.  As you have only one chance to
get it right before, say, 24 hours, you'd want to make sure that you
would not distract your reviewers with stupid typoes, off-by-one
errors, and such, and concentrate their reviews more on what matters
more, i.e., the higher level design, choice of algorithms, etc.

> +This consideration applies not only when going from the initial patch to v2, but
> +also to later iterations of the same series. There is no fixed rule for how long
> +to wait before sending a new version. A useful default is to send at most one
> +new version of the same patch series per day. This gives multiple reviewers time
> +to comment, lets you batch feedback together, and gives you time to think
> +through the comments you received.

And the 24-hour gives equal chance to comment on your patches to
anybody no matter where they live ;-)

I see you CC'ed Patrick, and I am sure he'll give us more useful
suggestions than I do here ;-)

Thanks.
