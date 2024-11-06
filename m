Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7105189BAF
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730862784; cv=none; b=LvVJLozAPtAgf242ADLZmz0nnOSQMfYY6XnFxNEUyNo4SQR5qMk+9aMbkaO1rdqDNVqqIq3KELiE97uBpZDII/Ko4DjPpRa7eYuhdv8xKmSPL059LOyKmG7HHik5/Z7jll7u+FtCC8ir5UMS8/R74bizNh3qyD9zu1lbn0CPVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730862784; c=relaxed/simple;
	bh=BJ8WxEJYGUQD/vvZjaG/Bgp+bPCtyMfMeNbS8lm8fRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4DkyjRdNO71MjW68BkbHIEiZGzaRpw6biicBtL7uQwYds9fpFiOcByAAxtFD0zkSq6gxZs0xpfpz37FK+JECz/r3JiSNERnWobPzJ+r5rTwfqbgCgyn3IOq+07FVIdyCYgG35WqfF++kBJJQLS0NRRyV4v/EvJZr9bBxn2DoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LKN1ZeB9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mviw79TN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LKN1ZeB9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mviw79TN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 05CA311400EE;
	Tue,  5 Nov 2024 22:13:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 05 Nov 2024 22:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730862780; x=1730949180; bh=+XUJB7mWsD
	syKIhrZyXBBF6I+jcMUP34CEfWfYfIeZk=; b=LKN1ZeB9tg+oA0fAqWJeEZRPAy
	m9t/jQ578t5Am5J3oFKYOCgUGNFDB5X5MeZj91o2l/xBNhVrNXFR3u+juJQUUh90
	GwQLiju0pNIayJ2fSPxc38/HIBFZHRY+dGhwwa9kamyyh/rUlAbgCM/KQSrLhqBw
	1N2pwXDRWf5vA57Amasl2z5D+eMbliU+nQyVh6xldzjd4rdx+9QrMbeim4bJo598
	Zj5+tvVjP17/dOPZLf4TojVzFNX2yRiAszTeG7DqKgKrS17wyspHoo4/YwBp9gC3
	x/MrWnnqk1ynxqlglDOvjcUJK6qwEPGnMCIqAFlzlBgwooYljOoU3vyjfIkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730862780; x=1730949180; bh=+XUJB7mWsDsyKIhrZyXBBF6I+jcMUP34CEf
	WfYfIeZk=; b=Mviw79TN7545nuE1Trf2U6CWDu9+V9bQkmUwXeEIKXHJJkN5cSe
	tZfnU+aRy3OzbQL+lqiIfEVDVhX2ESlANQ/HJB55xedFM4pIP416cuhs20l1ibg9
	b3p93E3wnz/hWEz7VOqS3A3ZuQKXGqHkYmg87G8cPxQ68lC9WiDK9GcGMHlrXqSD
	fTLUVVjWQ1ju5aPfeiG+qeLo0darhJRucmszfZSx2SHkB1BQ6N7LmR6pv85ZDrvn
	DkrWh96EaxfCAHliF13P57mFcX2wDUjAGGF9+NqXF1+QXoNA4WBmp20CqGvTnsX4
	MzrSMV3stgc9HKJN2wsarFw4XJJ1Y503b/w==
X-ME-Sender: <xms:vN4qZ0eU1yM56g46UkHAorJdLxgiJVSbN3v_PWJ5hvN8mUNiTZUuzw>
    <xme:vN4qZ2MIbH0mMQF3wOzx5nNUPwyjvmJnSEyVmmZsC-e3cNP5AisqwCsnul1u8d7xV
    tl8E_jREglEDmVYbA>
X-ME-Received: <xmr:vN4qZ1jcLANR4VoA9i93GPOW2HaPRDTrVPpCY9nGGD29624Qx8g2hXAyYV8xFyyOdTndLW9xLCa7Qzct0vOtLRLhk-Fa4LnL2usq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vN4qZ59NFF5b0kZXyyt32TMtHTwXsw0U5gQtvITgeXjv4UENACdNyg>
    <xmx:vN4qZwurOfm6DUt81kAVh5HGVtf1Bead14L3Kgx30mYKbIM5JSSjTg>
    <xmx:vN4qZwFSRKYsF0m_lMj78A0B3QoVBjl4mII3fR87l_1iIYy72haWFQ>
    <xmx:vN4qZ_NhTRaeKCQC_2BkZQj-Ic5ZU0frXdsnuQhqDMLyIZRUcTs_vQ>
    <xmx:vN4qZ8KWijzwo3ojlOFJJ_WxuS7-czxWtjhTAfLuVDfUzPzJz8Waqqn_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 22:13:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] When fetching, die if in commit graph but not
 obj db
In-Reply-To: <cover.1730833754.git.jonathantanmy@google.com> (Jonathan Tan's
	message of "Tue, 5 Nov 2024 11:24:17 -0800")
References: <cover.1730235646.git.jonathantanmy@google.com>
	<cover.1730833754.git.jonathantanmy@google.com>
Date: Tue, 05 Nov 2024 19:12:59 -0800
Message-ID: <xmqq4j4lqclg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Changes: the commit message title of the second patch, and a change from
> grep to test_grep.
>
> Jonathan Tan (2):
>   Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
>   fetch-pack: die if in commit graph but not obj db

I presume that with this the topic should be ready for 'next'.

Thanks.
