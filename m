Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FA23AB94
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637898; cv=none; b=nZcGs6aNMWnAwljoim8xJ2+aYLGG+k3KVMALkqiGjl2AvY5OK9qEBRlY/KqIFdXuOT1qtp/wkTyEJodrbWwbPbEYxdXsZPxg+jbnHMbHUgRV8R5axG7jLda8vqOh/fQqebEwdet8ofCI/nFlt+sKdXJ2E/VWdXzlRqhzuLz0vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637898; c=relaxed/simple;
	bh=lg69TwQ1eEfwWo2+c4wlAXD0Yq4Ljpasi3gjVE4QQhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtENEaV0SysgZ5C0v8Ufm0VgssJ7oswW8ZTqnHSpuhjpnmtlGs4pGIOCBui0vRGeJBRTaIVh3M0XEWZiXtNnakqRpVodfAv4Ym1haF+rplT/30Xk0b5LgIzLMUTVIsnTI4AJUIdyLqTCqAKDf4fRE6I8PmRI2S/TzjDhn3wQoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EaIV6t3N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHDWyYvW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EaIV6t3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHDWyYvW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 23AB41D0013A;
	Tue, 23 Sep 2025 10:31:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758637894; x=1758724294; bh=fIu67B1Ups
	9TJmo0d1QSz5V3gGPUa+zn02OhU6smiCw=; b=EaIV6t3NHtsdcSXBbuiPfOAjXZ
	TKMLI/I0NUfJrBCU1MlcpAd8n1ZNKru2IC8IHerKSHGz67yCIDT6A67Gn0ZR5lx8
	wWhua+MJXLfWpd/zCOIz2auyxMhrJyfBsQJUdTD4SQGMJhUb3CwFvFMOjfzqLshw
	BfHqbI0siAvlcGAbzgLLPgi5I/lv2B6Y4l9obxy6srVeaK/Oq0OW37Nl9IIHklN2
	G8ma2Ffhpq8jLP5RXvP8fRO60ETkJG80+c4e7LsbrO8Jl0A+2u1JbPl2UBOFLlbD
	G4etuIal3ImnSVMk7i9vEONI6IK49+H/nf/BYGyUIcbEP3WfRbQgMDz1VPgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758637894; x=1758724294; bh=fIu67B1Ups9TJmo0d1QSz5V3gGPUa+zn02O
	hU6smiCw=; b=QHDWyYvWjjOqWWOgVm2K78flQlL+YlTcAF6ZppmkfrFXJlLmqEE
	yCzWBD1gZH+o0IOMswi2gGRsMQzNWVlhZMgBkxPPjPv7l2yLngNvVJd3WgFEV8SI
	hDc/YXNc2poVjez6sfj5wL7k5TFQR/YqBHV5Kj8D2OihtR44gHfYzMdAMMw9ig17
	32WBvFYqQHTa4IXXCEO/kv3wz4AJePS82JScESEKBMq3Y8o0X9eCFCvgQjuQjxQK
	cQ8XMYXLrvs+G1LjRyKIU6dsmle0sIzye11DMj0BTi0d1nXN6E16qyWQZTpHXkYq
	kOrU+u+u7gz4QHQjA2g1GpUyb3IR2IG6LRw==
X-ME-Sender: <xms:Rq_SaPbxXKVPPtyr8pL9ze_N9yUmqihBoxPL4sA2ALfIwFKI1epqgw>
    <xme:Rq_SaO18aIDDA85fojfZvNm6WOxlTO2-l9LQL6s0Oi-Oa4WqgdGq3Ic_3zuZVI9Wd
    tviP7U5wVT1w58FDJ1t2ypiOSXkRVtMGb8i0MPn1f3cohzLLdm22Q>
X-ME-Received: <xmr:Rq_SaBuPGZ4elU0JFtiFCWho_3LxNh2Ofps3tVDV6MnDEmJ0GQ_27GSga4yn_vlb_kkCWGQxrdO1_PO--h36TC-eFPWFE4nE2U-h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Rq_SaCAA6vSG0BRgsj3BuaVv1cgvt3ozRgvRIi7lORun4gGX9N5RCA>
    <xmx:Rq_SaEbY6Xt7mdpk1i1ztPyNIYsYJbuEBp9Ptgya-cI_pvjY5RVFyw>
    <xmx:Rq_SaE9ZG6OHD4Ezlz0m6I5tGrSuz0mAtv0ADrlOmq7x5Ie6M-nFug>
    <xmx:Rq_SaIiIB_BE9h45dlJdeW-LY5W22govBeunKHtACM2ASxKrETFM-A>
    <xmx:Rq_SaFRSMh0rCwkD4xAqSLjMacexkA_RzxXZ5cMn2nfze8uKELpnP-KS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:31:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
In-Reply-To: <aNIw23JzQE1vz2JD@pks.im> (Patrick Steinhardt's message of "Tue,
	23 Sep 2025 07:32:11 +0200")
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
	<xmqqldmmqa1z.fsf@gitster.g> <aMfwGHL7dh8dk2cQ@pks.im>
	<xmqqsegev4jp.fsf@gitster.g> <aNIw23JzQE1vz2JD@pks.im>
Date: Tue, 23 Sep 2025 07:31:32 -0700
Message-ID: <xmqqqzvxp7ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 22, 2025 at 09:24:26AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> >
>> > I think the most important part here is that this community-supported
>> > LTS release should still live in the canonical repositories. We should
>> > avoid the situation where we hand over maintainership to such a degree
>> > that the end result (the tagged LTS release) lives somewhere else.
>> 
>> Why is it a bad thing?  The official repository can have a README.md
>> with a single entry "maintenance releases for Git 2.98 LTS (most
>> notably with no Rust requirements) are found at this separate site".

I've been hoping that the relationship between LTS and the main
project would be similar to the one between Git for Windows and the
main project.  A friendly fork, that is led by competent folks who
are familiar with what is happening in the main project and are
trusted by their users.  They carry many changes on top of what the
main project has produced, many of them may not have been submit to
the main projecte for approval, and the main project does not even
feel the need to approve their changes, simply because it trust the
friendly fork.

I was hoping that anybody who read my message, from a later
reference to the coordinated disclosure example that lists the main
project, GfW, and LTS, as three friendly equals, would understand
that it was my assumption, but it seems that what you depict is
vastly different.

> There's a couple reasons:
>
>   - The LTS maintainer may not be as familiar with the Git codebase as
>   - The LTS maintainer may not be as trusted as other regulars on the

If you assume that you can only get incompetent folks who would not
be trusted by their users by their own ability and dedication, I do
not think an endorsement by the main project would help them gain
trust at all.  All it would do to force the main project to blindly
sign their output is to tarnish the brand of the main project.

In other words, you are assuming that no competent folks would want
to be the "LTS maintainer"(s), and you are arguing that if we really
want a "Rustless Git", which will be used by the general public, to
exist, we should be the ones that are working on it.

>> edge.  Most importantly, a coordinated disclosure would say that the
>> update to versions of
>> 
>>  - Git 3.0 to Git 3.4 are found $HERE, 
>>  - Git for Windows 3.0, 3.2, and 3.4 are found $THERE
>>  - Git 2.98 are found $COMMUNITY_LTS
>> 
>> to make sure that people know where to find their updates.
>> 
>> So, no, I do not think we should unnecessarily mix community LTS and
>> the main project.
>
> How about the following tradeoff: the community LTS is developed outside
> of the usual Git workflow, for example on a forge, so that the LTS
> maintainers can work in their preferred flow. But eventually, once they
> want to do a release they send a pull request to the Git mailing list
> and then the tag lives in the canonical Git repository.

I do not think, with your assumption that LTS maintainer(s) are
incompetent ones that cannot gain users' trust by themselves, such
an arrangement would work.  Its only effect would be to tarnish the
brand of the main project if we rubber stamp endorse their ware.

