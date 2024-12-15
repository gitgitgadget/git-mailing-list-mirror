Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895579D2
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734228435; cv=none; b=pCe5aGf5XD986VbRe7YAT0kyuafkmhKreY1sjzNXsbo61oJdJOmHXq7zfdTsZOK4MfKDE5hmMrHS4dTpTia11TTfnGMpXyYov3rvTt0IKFXBhXoZEzWMdXufWbuCfbR1lzTwvoUtVF+zR/S3FZyp/sZbMWKPyu8KfAYVMHV0Q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734228435; c=relaxed/simple;
	bh=MviMhtr3QaagyA+rcSW2ZI7itvE4OeUdtHpKKYRdofw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7w6Y92ivCnm/dGC4MUV9z2JhPhDaG6PRKGUET8o+K7iSgtqNofeO1TEBAekJq2wCqwUHtYK4zgIbBQHtSxK98h4yl0G8RNpPEI4PEtKRmQ36hVETI3c+nasSrUa1yON8rK+4LD1CpoBx48zY/Hb2EjVn/ARahz15eCjfidkVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X0T6wBw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xCCI/QvM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X0T6wBw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xCCI/QvM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACACC25400D7;
	Sat, 14 Dec 2024 21:07:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 14 Dec 2024 21:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734228431; x=1734314831; bh=wF7dJL+O59
	eTd2u04jOqcgrKNDDCJcNIODzZY2yGpys=; b=X0T6wBw12WoPJcw+07pSNmDOOW
	6Cu79dA2mcKoXZkBQTggilYUhxh9/CLTnva1UHcN0VXj2Xp5Pzk15EWSNrHxhASr
	TTm8pTawMBPlDgmDqn4BCLFkcUA4XDtsWGz2kpTLRHYy53dPeajffBHBVgtuXrVu
	1MCV7NyJk27A7+2KFE+TdctMWsBOWfhOmnyR/tXpU51PYZ+m4JfyhP7JZhxVcAjm
	CTvG8u3FJjYFU4QsRRPzFvlTvUvmnCT5RWTbirqwHx+NNkzopZO6DpsXDHcJxunX
	W+9qO4CH8BMfhWndIDUiLTqINAeQYOiMEk82CwvZu2srnl5DOjJLjTntu0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734228431; x=1734314831; bh=wF7dJL+O59eTd2u04jOqcgrKNDDCJcNIODz
	ZY2yGpys=; b=xCCI/QvM3c6WRr5XUe59t/fbeLDYjHYWdzFkTqbXosSCtSrEYtI
	JZ1GjvY91r1uzYhS82+iEItRQGim0RL3qZiI1BlH/nPjcMKintXKYEjF4ZzLSl9a
	OPxvt/rXO1WlVrt7a/tzlTArNsz12H8skS/GFySB3Bq9IsTguHed1mln9YfDGLBY
	KiBI/YoN0WA0QnG/an43WPrwQbg1pVh68Gsg8WoWij0++dSj+JmW7QIJnY/sQobT
	BHggnRsGx+Q9OlqtzDpsnDyubsZoemUzRyOEUzH3i7itZtKJekOnKETTVMDIO0B8
	TPaDtVsyl3tJD1orBLFGGPfiwD8z0a/ng/A==
X-ME-Sender: <xms:zzleZ9GpaJhC52jc6m2i7xllDvSIMP1Suex3WlpGIV1XZGuC5ktFGw>
    <xme:zzleZyUwxP_NQ5ON3Mvq-2xgZ6_dEKED4b8MwJmPQTXR_aOR29ptJQny6PtmU82-U
    WhGJZ1vRYpKmPrJFA>
X-ME-Received: <xmr:zzleZ_IVRpmvGT5r0BBWVKdgaJQEcJf96NhtquESRPeGImZNkWvDOJDZYU2GyjyYklvxHd8UuNdNUK6ikFrviHd9Z7NkQqo1LG6xml0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledtgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zzleZzEwipYiSZRdCnInMEIOvBlpSOjJAly1bXHLXME9jzSWLIwWaQ>
    <xmx:zzleZzVPkmfeTAlCbZhTSV1HmAZIRrSi-ycJhqs4KRXKnQTnBQj1Fw>
    <xmx:zzleZ-PzNwhZyqe5LBS8iyHau-kElxsXmZahwQEI4awf0Ld9R_igaw>
    <xmx:zzleZy1b0uYW2edOcZDK1CQAysOeZyFh3fZeHsEFNkEtUarLxdbJBg>
    <xmx:zzleZ5d66lMr7FpRlmR9P_mo1DIUdIXb0UhKLoqg_xKgWStTSUlEoOWo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Dec 2024 21:07:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <20241213103850.GA1456983@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Dec 2024 05:38:50 -0500")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
	<xmqqv7vnevjc.fsf@gitster.g>
	<20241213103850.GA1456983@coredump.intra.peff.net>
Date: Sat, 14 Dec 2024 18:07:09 -0800
Message-ID: <xmqqcyhtaecy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Unfortunately the format used in the output from "diff --raw" does
>> not capture this.
>
> Don't we just use the working tree .gitattributes by default, and ignore
> what's in the endpoints? In a bare repo we wouldn't have that, but I
> think the recently added attr.tree and --attr-source options would work
> there.

Yeah, you're right.  I forgot about attr.tree (does not seem to be
documented, by the way) and --attr-source & GIT_ATTR_SOURCE.  I
imagine that this feature is primarily meant to be used on the
server side, and in bare repositories, only "diff-tree" makes sense
among the diff-* family of commands, which (as server environments
lack "the index" nor "the working tree") would already be using
these mechanisms, so there is no new issues introduced here.

> You can't use attributes from multiple trees in a single request, but I
> doubt that would be a big drawback.

I think it is also true with the normal diff-tree and friends; I do
not think it looks up attributes from each tree independently when
you run "git diff-tree -r A B" to compare the blob in tree A that is
CRLF with the blob at the same path in tree B.  So we should be OK.

Thanks.

