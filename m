Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790B1B532F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927624; cv=none; b=Cmfwf4cJN8hQdsyo4L/O+t3/tv3XVNWMPtMUTPTtR3uCORUiPW62zPidfakJmkR7oIWHPstCzpFk81T/VxCK2XaCWr0cVOOVV1/FOnTGODPU5ZA3Y5Bqoi/vMqc/FNdlxWfsOJESa2YpTmvCyx5BKKH3iPpt5Vi2X/VVxQe7WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927624; c=relaxed/simple;
	bh=weRnLrweBNVX1bQrCY1j5AlgOBQuJ/VEeDNb5otLHhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irWwc8Ml7bc3ZNQabiFLJRqTGjgOiKVh74x0oUzD3kMmktKRXgXXOQPl42DaLKs2NQdsPgA6SssS4wyPe3VOXynb6gXiAtjdRhn1b/gh+pQha8s97cPZVsCROoXOs9cirtRu4DdR0x96cMDP9oMD10IIUQ+MiVshxDzDdKVW9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4iUih20; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inVlqshx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4iUih20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inVlqshx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21CF41140230;
	Fri,  3 Jan 2025 13:07:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jan 2025 13:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735927620; x=1736014020; bh=weRnLrweBN
	VX1bQrCY1j5AlgOBQuJ/VEeDNb5otLHhs=; b=h4iUih20z/c/Ev42wmhX6240Tg
	Qy0MBAcbCNmFGryH6otDzS+OyVq+dr41eEeJopOcMNghNqG35bmh6+NlwjTfEzw8
	FseUB/boBkiaZSOvkZUXtfasVyP4w9IkIaHLUUCe+lOCwixaI//jr7ShhZOR6wjW
	cLStYZqj1wjXehhI9JJOLSQkGw9xtV4zW0sdeBlyTNdGrJuqFr/q6VEAaL9KyxtS
	PU1iTZSWmceajlqx80U2M1zFm7BeV/6sqZ2oCeqvvpmpqgXyJbg3DopLXBpJYe0+
	TZvKNy3ehOrBW581HQ4XG/9Lh646oHxKqvm8OEnkoJLC069NKX7Hcmst1pBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735927620; x=1736014020; bh=weRnLrweBNVX1bQrCY1j5AlgOBQuJ/VEeDN
	b5otLHhs=; b=inVlqshx6eFuJ7KsIqp1jKUEAg8a+cPuzTq6z2gno6m4Y432Nlw
	dpO2dRhEtQtWuxR2D1ZOSPHW1cDpIKPTL6xqimJrb9OScp+Y8q+c8zvXIiPtHkm9
	O6P6q+QvjXYZXJgl/ErDP+phmQ48zMGfDA9YIZ3XQVEpzjNLB4+SxDATLCWxqlCC
	XbZtw+oKpUtfuU2OPhpFZvkiTfUyMVYyA262y++1ur8IjPXaN0TaXI3xHfOJdtU4
	rmjOlyz6bRUOCXfuWNYiU1uIrrNuDz/k0gvZVmhBfwSGF/0vfST71vWgvR2hCrbs
	VPhU7k5gm7q/pjkD9K5q2GYovagYcQycuUQ==
X-ME-Sender: <xms:Qyd4Z_R0f94C6XJlDcgKGsNazNmWWKXxDmxAwoC8O-qpNo4QDQp29Q>
    <xme:Qyd4ZwwgPvDoRWoud8CLk6vEnia8AznmPDXy8LEBauQec5V0myPaNEuFoKyE2HyRT
    mpISy1YBKJmu1X6LQ>
X-ME-Received: <xmr:Qyd4Z03FrgVBP41nMNlswLHLZk_AYs8SPTCoU6NWjJmEnxFYPXH_HwWv4VE-4GNN8jAg2I1bArmJbMTdNM4CmsfjnOoG6eONbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthgvohgsrg
    hgnhholhhinhhivddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Qyd4Z_CbjF6cM6NCKJLnr042AtthBE9l9bVRKdQkQN5BY25NLT_2_w>
    <xmx:Qyd4Z4jJe7MJ4B-vg5YfDztUehw_pei5sI5LcyAtWceMPeeYKwD0yQ>
    <xmx:Qyd4ZzqbC90j8Ny6HFm0AELtVt_oIt9EXjLP0mESHKsXNEDl2MgOgg>
    <xmx:Qyd4ZzjFfGOSgSd7xvlfYmLy8uDlqPBcSyr-EVvHPuKxmjaSkN8iWg>
    <xmx:RCd4ZyZKtO31vMxZol6Tw0SHbMqRxYer0Zr46f-psEpan5unMKmSCjen>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 13:06:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Matteo Bagnolini <matteobagnolini2003@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  ps@pks.im
Subject: Re: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
In-Reply-To: <CADyPGv0T7Wwrf_FidWDtLGOH7A88DcisAG4-jU3eEax106XEcQ@mail.gmail.com>
	(Matteo Bagnolini's message of "Fri, 3 Jan 2025 18:27:45 +0100")
References: <Z3fM1bT2Z_0GoD4w@pks.im>
	<20250103130035.79376-1-matteobagnolini2003@gmail.com>
	<Z3fiREGwXdILl-M1@pks.im> <xmqqfrlzsw4j.fsf@gitster.g>
	<CADyPGv0T7Wwrf_FidWDtLGOH7A88DcisAG4-jU3eEax106XEcQ@mail.gmail.com>
Date: Fri, 03 Jan 2025 10:06:58 -0800
Message-ID: <xmqq7c7bsrel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matteo Bagnolini <matteobagnolini2003@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Fri, Jan 03, 2025 at 02:00:35PM +0100, Matteo Bagnolini wrote:
>> >> From: matteobagnolini <matteobagnolini2003@gmail.com>
>>
>> This must match the author ident on the Signed-off-by: line.
>
> So should I send another patch with this correction?
> Sorry for questioning, but as you might have noticed, this is my first time
> contributing and I'm slowly trying to learn the process.

Thanks for asking; if there are no other things that need fixing, I
can fix up while queuing.
