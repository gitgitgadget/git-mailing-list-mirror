Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839632860B
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722943; cv=none; b=qApSHE+dAEnOLVjnDnYtEeWt84YiLstx9tosx+i8BMKXKl7uw2dOLt0mg7lqxpkPpCSCm4jAEMZv6wqkU5SIzn7HlWCGNhOngvKU1Sj5v92bCQw59MhdiFt8Ua6LroomlNL9meA1gFg9NulDfH0ZhLdHS76qBg50QsWGu/Jht0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722943; c=relaxed/simple;
	bh=rAUFFRAmLD2JxR4T1QPYQPTgNSAwdXz51W0KmDupxxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Urf6LUa9liFCOPQutdDcqk309yHk8AybyLLZQiQUxenbBIhirP9IaacKaIFig97MWfl7jZjXvckzFRXjcpLc77jLTWmCZ0ScCQT/WwHF4El0GxCF8SgyfD++qa+MAxMl9L5zFAMHTKeb9NwaXkdpCo+wYv+MsajFheTm1fOVe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XIj+9NtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsI0Rsvd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIj+9NtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsI0Rsvd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 251457A0098;
	Fri, 17 Oct 2025 13:42:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 17 Oct 2025 13:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760722939; x=1760809339; bh=BY/x1o645z
	dP4ykUvhofk4eqaTxwNLc9XBiUwtM4SMA=; b=XIj+9NtEjbCPFlIVQQqimO2hgn
	9DojFsc70lKBaiYcmYMldkAwmMmS6ADG/PLSEXwVCee0Ey/9Stl55tdTlOPed78x
	W9E4Y9cDU3+aDCqvZiTLXYKvcEdNOiVcTtPXUFpxlDEZ+Ct2QJgVm9haVXWvuCac
	yRSB1AvDDqEUCCKWYKD/JiZbEQjwSRn/9e23qixQnSp3TX1jh85i1xOoSRuQtZ9n
	ramVWtuh4tG/odu/MtF97YkxsQKZ9Rk6gBg9g0UJKjYAdHhTqaDftdI9ksG9hTjc
	VWyMSmC4lJOaQCBirR+f1w9rYgK5clU0InRFEHPakUV332bU9Zz0SHA8+w1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760722939; x=1760809339; bh=BY/x1o645zdP4ykUvhofk4eqaTxwNLc9XBi
	UwtM4SMA=; b=nsI0RsvdvG5sqhZZI20EkrFMDM0PAKis6a6iTfVbRAFh9V+2U5m
	1i27zTdPjUtcRoHJ89YcBj9pCI5ePPRcnAPsgsRKP/NwLPrDE1WBwQPkrxckZvBn
	jDqif6BPFuZq1NifiF1ttuBgVNJ9xPdze3u8Eav78AMKC5qOS2x8RIFC8PUFEXtn
	Z8n+5goYbs7D6DIb1VmA/enxIRJwE72rP+EI4WmEPeVH4xl3rOqKiRTU4Qb2YrA4
	OuQlFY4w/ky/SCezup6/nE4+5oVzlyj+F9OhUmd659va9L+qo8QeLFsig4HVddXZ
	zRhQe2hHK4IUiERK2sudPO7q/1osZl1F9Zw==
X-ME-Sender: <xms:-3_yaG3qNXgu3wD-IomFWkL_6jrE2_YgAVroH6rVgKRwPcRDHp8k7A>
    <xme:-3_yaP-kO12xn00GHvmjRNNzZKGADW7FLDtd5u2VF8zCv4gZDRs8W7JgF3ghbIk5c
    oUWm5FCbgfIp6QtKQWr_ydbGLQAFImiGYJizx09rlwpEjbNm7Zn4w>
X-ME-Received: <xmr:-3_yaHPtyCgfLGdJ3IYyFohj19siq9krvtXTC8OJVw4n8RC3L9WcRyRExQZw9IcJ5dPZzlFtm1cZ0QReoPF8AydtZyK3tvGZHeZy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopeigrhihuddu
    udesgihrhiduuddurdhsihhtvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-3_yaDeWhwj1F3gKvs5BJKjY7vaHNwCmnEHJave176lodtVmPJS85A>
    <xmx:-3_yaGUcetRWlCR8c9o1-AlKVz5gWuzWuBlNpy8KL1C_M8NPXgMzuQ>
    <xmx:-3_yaLgumfSotTr9sq7O1dkUpJ-pATMSFPGwvZjhTYfog2pxiFFR-A>
    <xmx:-3_yaF98C719RbHEWo4EWCaUXhFxv0w-vmWKRpCN4fgmaxYQeaY49g>
    <xmx:-3_yaIjfiE1k2DaEBjXbGGcQQifUqLYPkDeolVA17sHkn6JbXA6p5yr0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 13:42:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Collin Funk <collin.funk1@gmail.com>,  Xi Ruoyao <xry111@xry111.site>,
  git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to
 start with ENAMETOOLONG
In-Reply-To: <20251017070912.GA4068463@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Oct 2025 03:09:12 -0400")
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
	<87o6q6nux7.fsf@gmail.com>
	<20251017070912.GA4068463@coredump.intra.peff.net>
Date: Fri, 17 Oct 2025 10:42:17 -0700
Message-ID: <xmqqbjm51l3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> AFAICT, ssh-agent does not quote the path in its output. So for example:
>
>   d='/tmp/has spaces'
>   mkdir "$d"
>   HOME=$d ssh-agent
>
> will produce:
>
>   SSH_AUTH_SOCK=/tmp/has spaces/.ssh/agent/s.IcPuGe26YY.agent.6PtD3uhM4O; export SSH_AUTH_SOCK;
>
> which is nonsense to eval.

So if $d were

    d='/tmp/has rm -rf in it'

would that produce some interesting side effect?

> I expected that would cause ssh-add to fail, since our SSH_AUTH_SOCK
> would point to truncated garbage, and we can't talk to the agent. But it
> doesn't even do that. The extra space turns that line from a variable
> assignment into a one-shot variable attached to a command that fails to
> run. And so we're left with the original SSH_AUTH_SOCK from the
> environment, the one in my real $HOME outside of the trash directory.
> Yikes!
>
> If I unset SSH_AUTH_SOCK in my environment, then the test consistently
> fails. But I'm somewhat amazed that nobody has complained about this
> before. Surely somebody somewhere (especially CI!) is running t7528
> without SSH_AUTH_SOCK set in the environment. Which makes wonder if I'm
> missing something.
>
> -Peff
