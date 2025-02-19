Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43D1C1F13
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008850; cv=none; b=s7DT5P4tg1ef+EdXHw9q5vkx/TTuOXDz/wVKt4Et5RwLAaa6ytfWnVgzf5QONwaQ0SwZr+q078SSM8ZEH6Rwx0UTrBNUlIyJREJleOpcC8RcbSJyPtLDYH9pNSiR7heJrG82CkUnC2cBx2RawDRKaEJ0Ds1FPIhZE4BZ802d7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008850; c=relaxed/simple;
	bh=a2t25KcTPR0lPCF51Ucg94VNmuklhtIHcFndJ3XONN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdZWOB8MmAbPRQsApjNfOmHipChc6bab85+pA+lCrClFZiXyPMKcxq7CvfSDoSWRsHSrEMqmEzv2Cbv4pPiHUofMP/KwsVWlHUncpszmeVJj7opeEow42sw67JEAmRo6lHNMl7lPKeh7eAyMYo5bh05/li9Jk+NPadUJzAIz8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TI1NqV5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzLEK3YB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TI1NqV5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzLEK3YB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF49E1140186;
	Wed, 19 Feb 2025 18:47:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 19 Feb 2025 18:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740008846; x=1740095246; bh=8PiZFqQxGx
	LB8bYV/iMohsbpwst7EEs+TZ+AtoAMFnQ=; b=TI1NqV5q/qhVPz5U+v0ZNY0290
	PqMStLCMKTATil14SVrNntmWWql0H+eZVrjxxDng00be/gq4LL3oIPeHY0gGrTPL
	Tpmelgq6mDWPSXxBnXyN6dJvqdaEWmXrcKoWW6UrXFJA65dD0lYFNTGDEdMRe3EW
	LTgkebUVIxbjSBC/qSJ3kwaUF9oRCcVqSx2hC9ldHWzwGYkq3Ufz3fdc/H15IpxD
	iy6m3x6/yL6N2URJ/fNKNDoB+bICt54ldF5UhcPbQWbydpeDRK+ylqspSURSv4NZ
	R55bHIENk9s282/CQqVxVX9f7EIKydBdZazLE+ap7iUCAI8PyqBR3m0rSzwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740008846; x=1740095246; bh=8PiZFqQxGxLB8bYV/iMohsbpwst7EEs+TZ+
	AtoAMFnQ=; b=jzLEK3YBD645KLdz0WXRj7wZwWktO4bCpf4dZqeJEMD6IUlkP50
	M/CTXFunEa5JDpoOtdxHmyGMDRY3/7n9DuBgLoKwQF18NhlaFnvOgb5vPb6rKNlG
	yMwXrRj/4kyXxaP9alYZAAhRlhYr3agtz6DvAaok/URFmgVQncxgih6lJyXOW5Pu
	hNvlRuXZ0bpcvkE1T3sJZ2/zFiNAFI6mAiqB21KUWoXOUc1uTvCuDr8veNnvgKqH
	+kgrf+4s9ZQMwMUO/y0rpMoxpJ1CdRfNc0DDrwUMBqAIIjUBfFkSRCSzzLJHqMmM
	epHTOB6ijP87G1dt7wIPK/JLDA/mr5Nnczw==
X-ME-Sender: <xms:jm22Z0pWwFfWoCB8T7je80i9zdUMGBl-i7r3T6KRD-2OfczZcrPUXQ>
    <xme:jm22Z6pVmSocEBjAwv2u2CAJ9B6L8qN8jTLsoBAC-T-m5jmPFG1gVpnT28k0gyAYP
    CxljCuofbQ-B3jNSA>
X-ME-Received: <xmr:jm22Z5ONWELsa4tGNH9WBiTPfySRJ4mk7MEGBw1qq9LPPwCu4qutCNkflExDSt1DM6FnykX9Ue_cxIvnS8um52htlbOHUFVMnNxKAm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jm22Z77FTRF8dD0ABnNI9dWz5EDxcS91Q2DPqnaMrmcDBCZAwFvGJQ>
    <xmx:jm22Zz6qMYmSgsMlsnDe2_NLyWOaSahwWLiqD9GCOz05FJG00zApHQ>
    <xmx:jm22Z7jMJz-b0MRV0hhUDLzKiB_VotNEGkSa5g0lUDRxkWSMYdoSSQ>
    <xmx:jm22Z94LHWJhpvRJKcQ551d9Pq7XfwvY3VYE3wKlQPm5SpRW4YF0lQ>
    <xmx:jm22Z234JJ6aZkXuKNEKeYanSGfNDneRNUX6ySM7Ywi3j0yNXH66GPMd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 18:47:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
In-Reply-To: <xmqq1pvtfrq0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	19 Feb 2025 15:19:03 -0800")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20250212041825.2455031-1-jltobler@gmail.com>
	<20250212041825.2455031-3-jltobler@gmail.com>
	<xmqqldubumxf.fsf@gitster.g>
	<5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
	<xmqq1pvtfrq0.fsf@gitster.g>
Date: Wed, 19 Feb 2025 15:47:25 -0800
Message-ID: <xmqqwmdlebua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Regarding pathspec support, being that git-diff-pairs(1) operates solely
>> on the provided set of file pairs produced via some other Git operation,
>> I don't think further limiting would provide much additional value
>> either. If we do want this though, I think support could be added in the
>> future.
>
> Another consideration is which side of the pipeline should take the
> responsibility to invoke the diffcore machinery.  We certainly could
> make it the job for the upstream/frontend, in which case diff-pairs
> does not have to call into diffcore-rename, BUT it also means the
> downstream/backend needs to be able to parse two paths (renamed from
> and renamed to).  Or we could make it the job for the downstream,
> and forbid the upstream/frontend from feeding renamed pairs (i.e.
> any input with status letter R or C are invalid), in which case
> diff-pairs can choose to invoke rename detection or not by paying
> attention to the -M option and invoking diffcore_rename() itself
> (which should be at no-cost from coding point of view, as it should
> be just the matter of calling diffcore_std()).

Sorry, but I hit <SEND> too early before finishing the most
important part.  We can move the features between upstream frontends
and downstream diff-pairs.  Depending on our goals, the best
division of labor would be different.  If we want to make it easy
for people to write their custom frontends, for example, it might
make sense to allow them to be as stupid and simple as possible and
make all the heavy lifting the responsibility of the diff-pairs
backend, which is the shared resource these frontends share and rely
on (so that they have incentive to help us make sure diff-pairs will
stay correct and performant).  If on the other hand we want to allow
people to do fancy processing in their custom frontends, maybe keeping
diff-pairs as stupid and transparent would be a better option to give
the people who write upstream/frontends more predictable behaviour.

Where to do the pathspec limiting is one of these things.  You could
make it responsibility for the frontends if we assume that frontends
must do their own limiting.  Or you could make it an optional feature
of the backends, so that frontends that does not do its own limiting
can ask diff-pairs to limit.  Which side to burden more really depends
on whose job we are trying to make it easier.

Thanks.

