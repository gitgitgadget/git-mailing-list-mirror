Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992133D4E9
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065788; cv=none; b=jwDZ1uMFcInvPUeAQutKURdWSiZRgnvWwKXYOEXgiiC1V0++MzECAMP7eETCbMezJI2g0W5XsAGpSoSB/WnUfffsHGC403Biba2cwvgWRH5SqUXn2djtbeXqJlHNtjNo35d2Q1TyK+Xb0aqTV2u77GuMCMtjtFYRStSOTRBQcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065788; c=relaxed/simple;
	bh=lmmwmMd7J70xPjs+sV6r1cS8HS3GN6F1rmRqL79rJgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nOXMBT6oGUVOpfDTarZ0NbvIYkS5XoxGYNbkj25dIFnDBgW1vlBojhnrGrqu9j7JHVrVJMCg0Jwe/eUc5G/N3xKfokyENYEAxd5vfqfu8Brakq4nwW+UzjxVUIJDzF9pM+t41bKfRw89J9SGG4PeSmU1yQLWf1en/ED4gwiMA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N026qJxV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0iJB2PC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N026qJxV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0iJB2PC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ABD82EC0114;
	Thu, 10 Sep 2026 14:43:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 14:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789065785; x=1789152185; bh=LTiZypH3hs
	s6MiJsEYv9O7wy8JoxAxQ7Q7YR5LcstEE=; b=N026qJxVz5YSyn2yFIs+BPFOf0
	dvj6deriv5FTNTL7ikzstuQLq9KFxDFBVEvOosq2iNeSbcPVT9+wzHJOr4BfeYnO
	Xw/Tti3TVxN8srLTapLWnpW7DLlEnzu/TpquQpzMZo/oemIJmPvekTbfnLsngNOg
	qe59bPwNnrFax6YXXIgpXIaVLV7x9xEBUjAsHAetM6shYt+x7SheljX1fefl2G/n
	1PzFBdYPyu9lpwErxTx3mrwJqJU2lJMGzRXAwAS3SFTYLjh6Lhx9UuGMv/1P76b8
	sJ7Pr14AUQtEwabQhHSY18OULtTc51OFQ4mfY4/j10Tmxf6UEICPNlCnKbbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789065785; x=1789152185; bh=LTiZypH3hss6MiJsEYv9O7wy8JoxAxQ7Q7Y
	R5LcstEE=; b=H0iJB2PCbyD7VXUzX2M3sJJnt4j8UbhIY2dYQvPN7raMzT3HNi6
	f5V3Jm16YcNcYReRqRFah0CDbX+RtQ5V+mKd/XSqmgZUrG32QvJaXkp9yyREq83b
	s0hpHeTQhgWtmFF/X6zAbNRP/0/4xcYTPrYn5BAwJ0OBdD9drxwpiFX1DvsQq+3c
	3AqACPxgvCCakvuGca5OJogv1vpqLsDYtjAO9JdVRjXJzYgPAdwC4trlXxwUjWNt
	Lmosm0x4rzqPeIYTqivtxg9ngjO0fJkbdTPPZThpX8Ub/rhq2YGB5NdoYfwxr/Fz
	mLP8lmw/TKfHjeG0iA57eimxWxE2HZsCODg==
X-ME-Sender: <xms:OfqiakpbZOJyL0iRTRTEPXfqHjQV0Cj-XcwDZxO3Xv2WOL3vL0gBrQ>
    <xme:OfqiaptVYHGMrzTzcNiSXq1gZ4LCn9HfYdgrKq0hqaAvzwKJPMD2mGNdETya6vUh8
    fxb3Mv68O-imZgIWTVEUZkjny9X_U9ttGs3XCj8Wn7FU2kQO_3ySEab>
X-ME-Received: <xmr:OfqiavZyXrt59cSm5YBLIAGdgTtgH340F95YF9Wvsda40k1GS1jhAuujNMUnrf3Cu-DzF5TZtuy09UBAsoRyveiE4uzJAaY74hIX>
X-ME-Proxy-Cause: dmFkZTFtCEJtm2efcVkJaxrMzNNcOylhxIl+ss83l1kAuK3wQr5sxhKimTYi1Pz+nBTt0k
    WP1yE7vEoFrZM0hq6XCgnsLnoIuq3OWAlnSAnWu8Fww0SBI9nIH5fERwFOJ8H69gh2xdIr
    tUlhnQieBhHYMl1NykXOIydPFrz6cooLlmbZRlRRzHpXu5EerkJFSAjWr9nLVyDcNLHHVC
    m2vtniSu4rG48f/z3nb6dCHCpwAThBq53AnvsW3z0xXoGljegBfJSKAHHBmjWblt/r6CKz
    sotpF6U+YbRvJgF5VegZaLtj1LfIUP4bqJCiEXPdl3zXqhNNvYyHFI2ugslb1zfmYgR/bA
    6GJuGzzCAt7ep6rWqc9YQbOeeUBdGTBlZsnPZa3o4X4Hcf/47GaDiOTgJ4C07+mJd1X3Kq
    EMYaI0i4WEyAhUAXtlEQPbLa2bm3/Wq4q7+nTnpeqNAw++w5lt1ID6DIl1zF+kV+hNcjwo
    GUCCF6OzW2IioAnH3I1I7lCGqcKrnzcjFLrm8ulkiNFLseiLSicaAm88HcDIgEkgKQnqx3
    Jt+CGLyj5wTyFIJ4dpu/rSwDcpkHojDJJundQhAgKL3Cj0vcQZrRJlQa/aF8uzAcTeqznt
    1E9vSTx8Ef8N04YQBWx9m4CS7fdaY5EEw3kzlsSiJOf3ZvhBasm2GCBmGaOQ
X-ME-Proxy: <xmx:OfqiaoYUMWZ1q0oQpQi8KufTwn45XIDtto7EFxo3bToH6JDjdTscVw>
    <xmx:OfqiaomvHOPcatMUW3C7-423PPhbLFwXS__qhvo8RD1XLA1LLIuM1w>
    <xmx:Ofqiaj3R7_kvo_c0Yz_CKtJcI59sVfB723Dp4AmAhs6bDEzYF5wX5A>
    <xmx:Ofqiao01GC6wi6DluUtMBeck4IUhRf0sNkTGwysFK2H3dAbJuKsGNw>
    <xmx:OfqiaqJxpiRgkVpFFTdxwRvQnNtDk19EcgghHv7yQ-qjRFXLJzHygNz4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 14:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org,  Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] push: check pushed ref for --force-if-includes
In-Reply-To: <20260908222056.1150748-2-tyler@tylercipriani.com> (Tyler
	Cipriani's message of "Tue, 8 Sep 2026 16:20:55 -0600")
References: <20260904210122.431757-1-tyler@tylercipriani.com>
	<20260908222056.1150748-2-tyler@tylercipriani.com>
Date: Thu, 10 Sep 2026 11:43:03 -0700
Message-ID: <xmqqld99dk20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Cipriani <tyler@tylercipriani.com> writes:

> Message-ID: <20260908222056.1150748-2-tyler@tylercipriani.com>
> References: <20260904210122.431757-1-tyler@tylercipriani.com>

This is incorrectly threaded.  It is not made as a reply to the
cover letter of v2; it is a reply to the cover letter of the initial
iteration, and breaks automation.

The same problem exists for [v2 2/2] as well.
