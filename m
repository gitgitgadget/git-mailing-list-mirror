Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821B3E6DDA
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754621; cv=none; b=eTELP1dKnRaEQjd+w/BpW9Psoq+qILsK9ih0fOhC1kJOWQ0/ceHACue2CRg/Naq1If9HRp5cSMeFQbvulf45pzbXJeby9IGvPooQKje37m33doJ8a40b/J/9LbNU/yuWQZuZ8FBJD6cgQSnnDxdjJQJZnRG5y5ToUzMTMFZ8xKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754621; c=relaxed/simple;
	bh=TovtO90reRPl8KPtCXQC2quyeiCqTHWHboBqnQuOitY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpsFWGwlp5kuF5PnanQjcn0cFVUet3vJakq/Jihywh2ySijHK3euitTl3VE+NWucaD+aCpBUcyHNzn+4ewRv5xebzIeZpEfM0aM4FBC+WaeWltJg2O2xqN70ngIYeprD4yHQq5bMhHlnZ/vAuuGrRKTn81D+AGDvVIjvsuv+l0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qpNzJ8iI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itTLZ+h4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qpNzJ8iI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itTLZ+h4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3BBC7A0780;
	Wed, 30 Sep 2026 03:50:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 03:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790754616; x=1790841016; bh=EpZ7REE9t6
	qEiAiapYaMbMfgkutWAc78nWxQ4F0BX8E=; b=qpNzJ8iIvXeWVrzaP03AcqsKQB
	2nH+XFf1ffyE3BCWebwKSh6/uIj3SE0W5eWUS040ZSawP4m8v6d4iITIxHp1ZV8p
	XZ2DyBviC/CWG59HbR81O+YC0YPb+nHtmgE0/qvx/4W4o+cYQ736MawkJnhTqxxW
	C7bO0iIm9nGm8M2qu5gtAt8SHmnq3tndNdgtRuN5O1iwapVMZrzUQkKP39IhVuhD
	9kgG5ClDvlCzoNOjv18KvheEIgUWf6639VIiq7CQJ3PE1MYwdIDJ2VMi4e5YQFWS
	bAGkHtcQEth2KEgFMc3G8X1UAUt43zEYPkTvPiW4TmG5Ai2Az99M0ngMk/BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790754616; x=1790841016; bh=EpZ7REE9t6qEiAiapYaMbMfgkutWAc78nWx
	Q4F0BX8E=; b=itTLZ+h4g1U4YnbJ4sMxYRbe+4rFJqcG+U5H2oIJLdqmTlVQSa7
	DDTOzfTaRFioymWxxnX9m1Nho24RW1RC3TUKVdTlTeZPs3E0KtpyoiSLFsU9rUUI
	oO3WBhkklyr/t9SBqeFWihNBIvdB/qCm5m5R4Pb3rAdVJVnw5uE61FEDBgh8yWsP
	5D96U0iXfU54ViOuBaEjV1fnEnhmQmqO2Kf6qJQk4z0nlGk2Jr4+JT21S0lQyDRD
	/PjT9BpU1yKypykhcurC9u7rwtJkQ8WlT52aEfJDaB0Ahnrb23opmnAfNJRPcRh5
	QR6FdRuKldRIpt07lUrtCARuTBW3caBaL7A==
X-ME-Sender: <xms:OL-8ah3tFffZUZqSLGANouUxKd8NgkVS9oR312ALD5fghSe8kewDVA>
    <xme:OL-8avHDSAfsI43q5EigGwM2SSursE9oEsB0unTDjJxsIzzoSXYUxoVRjh9spI4yd
    rykyBzOvoosGrpNNyKhiP6MTpB1UDLcFQ-D0irYdLYAN48L72Z-9A>
X-ME-Received: <xmr:OL-8am4BHIhVIh4xe6aOwmY6QAd-bDwj7EwxmZ3l4urMsVglWY6SSST48Kkm5vr6Kh2zxQnL6zNhFRQzc107rK0lLxyq5o9VU8OZ>
X-ME-Proxy-Cause: dmFkZTEzr93MGnpHs7NDAhKzlwkAP1Vjg3Ig2xCtH999Suv/ivrTPZxFshN6FLAxP2ECYS
    igWJ9XfqEA3GRNf8IBTwISp7bh3GN4b1xsgrlk5N2ZUYyiOe9DYE6X4lGsVQmSGCb2NXUD
    QOMk7GTn0a8c3Ar8Q93MgQ0o71+r3ev9GTribfYHtulhTci1g3sOgGGO8YJBcW+S23UMxJ
    GdMz0bSg7XphxzZ9CCMTh8W29CilFKZSxcvFmKu51L78uXyiftOtnekHzB34tqHT99mrev
    4K0f3iUqkirWsqr4P+cSOrWe3aebNmBaoKfTYrNn00Oek2J8j4rMy9daArZ/+1ntJfM+r+
    BglLIjYf5jVeYQQlN4NydI71tl7krm0xGdXQHdr+tiZIMtbzYrnngfkHcfn3eM/2sTi3aI
    vWyJUOIGvm/1K3v9DjxPXIUEVpWhzoQjdtbPnXcb/og/YgbDox9hv7HZqpGf/oXk0lLruF
    /R41EG/WRryfQkC7A9exPK69VTJvr0sMuOuvvTze2hJ7jyCrtIDxk2fapazvS/tBUlyCd6
    AHu6ULSXR9Fbf/eH+7H5I1fkYpidKa9K+uE1pj99cbMF4dhsc6GKMCBfi5ZJ5JAbn0CemM
    9EFTtUH1vNz/QXExc9kQ6UROkIFbXGMrf/hgYDn/rK1KnsRLW8wJavpXMzYg
X-ME-Proxy: <xmx:OL-8att9vavazyle2dn-8v2bV-9GlU0GMPRhbRFjWD14zZFF2D5fyg>
    <xmx:OL-8av6N5vu9-UQmNdJJJvYL9YjH6F1ESmaaSfsmCGGCjxnQ4DULFQ>
    <xmx:OL-8agX3et0yLO-T9IQxm2ouIMx0H_f8ZIkPZBgPa_f4CIxnJ3vZGQ>
    <xmx:OL-8ap--0F0uzaEyr5XX4tJBqH_aeWjqa-aVUClJpYpojjkNXqlTMQ>
    <xmx:OL-8aib9F5tzlb7s_jijKMNwHnCjpYEpH_D7L3ZSGcVyNmyiTLyVe9uS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 03:50:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com> (Julia
	Evans's message of "Tue, 29 Sep 2026 06:42:40 -0400")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<xmqq5wzojy31.fsf@gitster.g>
	<8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
Date: Wed, 30 Sep 2026 00:50:14 -0700
Message-ID: <xmqqzewzch55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> So I personally feel it is OK to remove the old one, without
>> promising or even hinting at what in the new one that replaces it.
>> But we would want to see its replacement in the not-so-distant
>> future.
>
> I'm not planning to replace gittutorial-2 since the material in it
> is already covered by gitdatamodel and gitcore-tutorial.

OK.  I didn't sense that from the proposed log messages for these
patches.  Sorry for my misunderstanding.

>> Also, we may want to decide what to do with gittutorial.  It is
>> short and reasonably sweet.  One old-fashioned thing that does not
>> exactly match today's prevalent usage patterns may be that it starts
>> tracking a new project from a tarball, but other than that, it may
>> not hurt to keep it around.  I do not know.
>
> We definitely want a tutorial that covers `git init`, `git add`, `git commit`,
> etc. Any replacement would definitely cover those topics, but 
> I don't see the value of having 2 such tutorials.

> Why do you think it would be valuable to keep it around? It seems
> like it would cause a lot of confusion to me.

You confuse me.

What do you mean by "it" in "keep it around"?  gittutorial.adoc?

If so you said it yourself, that we want to have a tutorial that
covers the basics like `git init` etc.

Or do you mean some other document, like gittutorial-2?  It would
have made sense to keep it while a replacement was being written, to
make comparison easier, *if* the goal were to make sure that the new
one covers everything the existing one covered, but we already
agreed that it is not the goal to salvage what is in gittutorial-2
(and that is why I personally feel it is OK to remove the old one
first).

Puzzled.





