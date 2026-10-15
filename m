Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D113F1045
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087578; cv=none; b=APA1vqEZIFT59bCCeU+8qK5zSHYGKf9RmQ5IPM5Fq1fKpi8Pyxc6+kGcEl7Pi9VJwwXn0BYEC9Ezd6Cy9R/MwZLtSCGvy86zCvczYIaXrk9cJOQo717UFWW0ru3Z87HffotxLw0aDX7XtMp8XgE8deWmFApoNw9j2ZK0T2IXKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087578; c=relaxed/simple;
	bh=wCKuzbb9ayGJ4NuMAh7+17QQYs3mbax2BQY1qypy2Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXhRP01mLZZUEL+6puK1rtqxbFIRPbMjVUfSG5BBttIeqtcznSBctIW2KAa+L4mCKpf0z5HvIStG3/EryejEe/souAqMplIhF4iYqLJBQdCQOYjCto7GxZlHc8iG9P7ogznDdLQ5rS8vJctprK3HojMmaZzleHx0Z9Ii1j37t9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ckX2RK0+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SE//Gr2N; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ckX2RK0+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SE//Gr2N"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 781241D00150
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:06:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 14:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792087572; x=1792173972; bh=ZxC9SKgpML
	veyWErlRNPrVu7y3hvY6vJka39h0Xv9jA=; b=ckX2RK0+kGIhQvJyEKg2rzPDx7
	uZBU0JSG563ozK5F0ErvJxx/q6swoIiPiZFU+DHzLDyGaPR75pWz74a8Qe1pbPMo
	KV5lQBXU8EvlgWK/nhZpUABOqVlKdYhyX1DFM30rkBJoT5QWpOLYwxP+MU2eRI5u
	x+FS5+p4fU25L+4BL+7r7Q+uadkB5PL8J7TCyHIZEtaNF5LiG9QWrEWK4gmzzLN4
	y6g1FTTHuancaVTLAdunk+mUjzlStRj+kHbFk05v/wjiWOMvXsh1fsLuIwE3TLye
	DR1W9utxT/F+TnqJkMXTHPRnXc7D0TsvdNrY5rLh37aKxfp1VVABXpoEYU8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792087572; x=1792173972; bh=ZxC9SKgpMLveyWErlRNPrVu7y3hvY6vJka3
	9h0Xv9jA=; b=SE//Gr2NX7W6mYr55romdWl5PlzL6SrnopGYwSZ+KTXoT0Yvgll
	4DSMcUDKMQ98geNhFqRoxkZmx1+OWcfcOCqscoR1RBNI05NsPsVGbzFImyGDIoCe
	A3QJ8sRZEcLvvdDrMZEh2ywOveJzOG7PZluf07HqO9qK9W++W/CwZHeZZb04n4kY
	IvbxFCot3HlDqsKkywBttm0Xs3sDiAaSGWf6apgstqJMWWZryjB2UEzW9u7i7xnv
	4eIIbzZ4pzmhr7FuNKqTZKgrgcdz8AAZQEhoJrLOGf8SY6qQHHOg67V2BcDTAgop
	qamarDsKTWu9xHeaNveEH7rD8UVSEgVo50w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792087572; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:c+ZgYP5DY+I3BG8fg7uSlGKcFUPF5OqcLiDezxlt8Rhe1nB
	LreJ2S51RTWsQuV8lpP4RKIp0Cn3oRMhqBpRUaQ88LIx/iSNHthJAzCPlwhmxLG8
	/kFmTpzspK2ts0WMIPVoP74KG++mzJc4wOQpzE2zDjRpGdfy21vcC2YX9U39nRx3
	a8za8woUyeXmPgchuajURlpQv7pcvsg1c2eCGvay2ILg/JFwtC90/F5+i5pII7tB
	vaiBEzU0VrNB6xPfXUVhsP0JXiEIdtibQWJSJW6qwneXRKbFgzpSlsMeDmY/hcih
	iZLjkN+xsTJTotXIakD6nhdccE78e0bFsjzKHMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vDgr7XeTM7L0JC6GEBdNVz69CkY0aQP6Qtr4FzrHNnQ=:wCKuzbb9ayGJ4NuMAh7+17QQYs3mbax2BQY1qypy2Nk=;
X-ME-Sender: <xms:ExbRahqk4djqndEX8iQzeQekS3VzknGCTzQIYP5n4qQNLwfWQv8u0A>
    <xme:ExbRal4_SOSyu1gk4upM2ZhiVoEd2IVHM-4wCsrisLAwzTRiIr5Pz9m-xvvv1lnDa
    eBFqXgwei70NIBzV8_pK4DaWzdSPsIxZul9MtNbpF5c9jfafJCfyOQ>
X-ME-Received: <xmr:ExbRagdLnfWj0FW6fYUR2k53xFQmyFKfYn31GxeAF-JkL0QOE-K_5lXBxpoGZdwo34Y1IqP1bsb-ELbnnktpcQ5NaOeyX_WSEMLI>
X-ME-Proxy-Cause: dmFkZTEE9Aff7BTS+e0D4FUZMSDzl85buoL+1PNbglpNN1nWJP8C2crsAkFout1R2l/Mhx
    1mWWiwy13LskxUbjKQKjLWVDeDPf3unjNo6Av4y8ZzcZmvfqIVW6RBsmni4XGJrDDqTJ2V
    K5GbJCZIQHbWBgXjrkizvTsioYebx+A3wc3nljr4pkHfx/Ddn4rjWNGWjgCgV01ndraanS
    LcwhFgnOj0v0TF5zGpSNLBa4R4mEtz5d2me5P659bp2UvVaopmZ9lKkadtGN3VRXGED2gC
    a7Yq/fsdlfyrtspB+a7ViVfEy9x71lQFLQU4mpp6KCXTQLIhF+4p5U6pg8aw98M9K/RaIn
    yWuo8wXSVbJAPcZp7mJJyPj2NjMHHH3qCpN+7MahrUILBL4/yCZ3mJC6lefI2NOeseEpVV
    XCRpwMsfBhkggyn/vDTPtuxKyWrXuXEVLzWWPDp3oudtVgxsYe6Ps8A4nMgbpp56oM3kKl
    I/0Gn2PTpzdOJPtWIb9hLm/AHbVtEmTf7XocpzpOvrP3KtPdIeT49kwZXhb7dVV0tPe97y
    jnBlvOxhRv4mGrlBjGuwAPBfvKTgUKIaTOoQZpYAvztFkulLJeUvIOphoVjNvWvCQ1L2r/
    jOw0qDzl4uvI0A0eC5j/xPif/s7yjc1Slnk36auu3mYyyHN7sbnABDxWgAvg
X-ME-Proxy: <xmx:ExbRai6qhLAkp_El6xwfUwTOdyKISJEitrGckv6T3TSRijwVy7NDBQ>
    <xmx:ExbRavudfme4pmCxOLEePdmI9MbgM6c49XOqnQSfOkXdYGa2JZVR6A>
    <xmx:ExbRaqglinJNT-nu1Tr6uI1pMRcGrg5ua73-1sI5NWAHrXrkKV06RA>
    <xmx:ExbRaipUYb3nt7W7OsueSb34v7KIP6lUjtxLQnvfrtbhzowqE20txQ>
    <xmx:FBbRar22XAprTyozWz_1Gt_JwYkArPUebdhv7JAbAuaypnov2XNQD_tl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 14:06:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Todd Zullinger
 <tmz@pobox.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v4 0/8] ci: some housekeeping and modernizations
In-Reply-To: <20261015070605.GA2556608@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Oct 2026 03:06:05 -0400")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
	<20261015070605.GA2556608@coredump.intra.peff.net>
Date: Thu, 15 Oct 2026 11:06:10 -0700
Message-ID: <xmqq4iemon3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Oct 15, 2026 at 08:57:09AM +0200, Patrick Steinhardt wrote:
>
>> Changes in v4:
>>   - Make the test in t5004 work both with SHA1 and SHA256 by forcing the
>>     repo to SHA1.
>>   - Link to v3: https://patch.msgid.link/20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im
>
> Thanks, the updated patch 1 looks good to me. I think all of my other
> comments on v3 were things that were either non-issues, or things we
> decided to address outside of this series.
>
> So v4 looks good to me.

Yeah, I am especially pleased to see your "what would happen after
SHA-256 becomes the default?" question and updates in response to
it.

Thanks for writing, and reviewing.  Let me mark it for 'next'.
