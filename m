Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BA47D951
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945681; cv=none; b=fcci2OZmn52gpuBwVSNVzSan7nFuR+7mvTSkBQ4Jrhv76yPS9gr+XwTJ4xghFU32ycppss/Q9xGzpPr9vlUzI34TGBwfKOChR3atLg2VQoLHG/cjKU6JtN7nX7LebBe0QUp53TBtinhK/157U/s94fY3Fk4tNUvNd3nYHZudEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945681; c=relaxed/simple;
	bh=yHUnE6TjYiYda3nM+sJOoWMXsrQT3tgDD6aNMargaBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuQm+23510idtM/jjiti1wfwXidvJrSGHDntyDp1ovTxP8o0DrNzQF/LacVoBlCg/nH6pfad5wgRMEbovLEDom5XeMGJqXutZGGgG8SR0+QrsMru9TiaHPs8BqOyGpqTWVJJcbHiK7jrePyH9cnyfRNJw8T8wB2pWzTUNKGJFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dLkdDB8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gwah4e5i; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dLkdDB8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gwah4e5i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 008047A0161;
	Wed,  5 Aug 2026 12:01:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 12:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785945672; x=1786032072; bh=vLTM1Nfpc5
	FD3hEu7v6+m/O1gSvMi8NeIUazkWQ9Fuo=; b=dLkdDB8A4X49bZUnuhsS28LJSO
	5qtCNg2p5MQP8Evg5VsnKuVD1e6r4T7c2AOxV9zKwBrJ0gZ+J4aE1aZbj4aHqN2x
	D6bf5NZoExUJ8Oeo3jkbInXcl4maL40NmWgc7XiijwneWQVEVfi1YnvDIp6Fh2Y7
	A8JoSSRHCS3D22YOukIQbqBzWx790WUePyFGKTutt9aPDM8l9k6OhxN7IGTtOYs5
	V0/+i8BvhTfiRwBXKin+DmckqJPUF4Ibq7JI6alOV3TKocnEhqFXNXwgMn5UxuK/
	s+zkIvrDzN0VhG2tCwZ1GEv4cEdKchVYszYgWbWDANvWPJLf5R70cg4xCouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785945672; x=1786032072; bh=vLTM1Nfpc5FD3hEu7v6+m/O1gSvMi8NeIUa
	zkWQ9Fuo=; b=Gwah4e5iyTA8gvYVQCWyNEFoNg5FJ7FI5sgGGJFEJsTXojZThS2
	/SK8cIsa+5anXr/DuwE0RF7qFp0KjZ6kf9B5Ge+FxVZu5ZdozXeCqUY8z8cY3IN3
	vjIBHaz/WyuYR9vfb7xsATxKdxXohvo+5Uofw4+Qw/yFqbFNjCDx0ESuyc/K/HyO
	FZjTpTt2zLiUEYXg4P3Xon73BQdwpf6s5QQXjUZKaCrEdC846oKNirDaPtNSXezt
	J36k/OhuyzzZbL2HjURgO+BTU7iZ8CLOWW6afBObdfNhU/oiGypGFvrhMInbOYBf
	ekCeTuARjhJwEpI/GiIKT72zE64eIvKIv8g==
X-ME-Sender: <xms:SF5zalD9B1tzZIHABF4HS0dVUaRnflhcs3ehuckCL-NsllMLcmEDQA>
    <xme:SF5zanP8Lc2xa-W01uUNs1z4E0Vp10mfpkdFddrVlDXmqoSUAnt59vMQc9COS4TpB
    5SzLxI7ws8OOLVj-t_zHUimpiq2Xi5RJW7THwcLQwSedPoFIgZzcA>
X-ME-Received: <xmr:SF5zaqYpK2oED3W0k_b9YOVvYDh588R_BDwJa5iymGzVaYTpVNblEk0jE3Lpjm1eLhexK2SLpCSrqLcGQ3aENe9e11T28_Sn_A>
X-ME-Proxy-Cause: dmFkZTFlRSlig0eO/tOVJDTf+2rmlTysjsJVOnLIxFupdS9WpaEoar0ymXbIT6j4KPX+G/
    3bWHs/QtPleioELDn0tv4of9/6DroybS0rSqI7BNH8s9rANDxebdNbdlv+HHCauWzndNAT
    qLkyGECfGmYh8hc3HA7Rc08OA+cbIJISCeRuw8FnGoqzzi7q3zB0XcQwA0FHEnVJQ0KTS/
    B+R2skbhbcxRrsVIC1kJmrgi6SnRyEENH1pQaVOoDw11DSxDhSVnQickK52AXRyfJOWxaH
    8BzQntREIynxCK3skl8kyY4wYwzEDQyKCHFA47HpAf3BxBcFZLGo+pY8X6UzwfdYPNk7oq
    8cbweGXO/tEenwI4TfaRk9UIMj5FuWNoKMWzu+vVkxz5y3tqo30p22Rdplp1PnHTfve/rR
    CuFdPr/GH9T4gK8+r64BisST81A3elTBzgHTnCATI98M/fg0jHNwVA+dNZWT19elDNK6Z5
    YfCx88siX05KZxZYamILtjRg5h8BidmfAN5SFeUgHSrRl+G6UuLG0q0R8l3fNGGWytJXQg
    MjfNZcw9o/bRJnfshLf9gf2PFljJktr3XiS+Gm0xyiBx7Z0LfZFJZBhE/dHrMeT7XkcwnS
    V+SBsckcD4lIyeHlMPzZUhEP5wbkXbqGqTZJgU1f25sdcV62mjYG1cTylqGg
X-ME-Proxy: <xmx:SF5zamtPwThYdf6uKmsbTgN3HqqwDrylXe_OcJzZYVCsHfo7XbOxag>
    <xmx:SF5zasPBwj7s3p_BCD2nYUxdLbjDF6rkiVvfji_fi8kbqr9wk24b3w>
    <xmx:SF5zat7Q9ftV6X1X-zS4Eeti66oXpsH01T7OBC4YsmoZk2r7DJoixw>
    <xmx:SF5zaiTZAUDdyaaFpyKkHM2NmCJRT11AwbpPjpGovpUmhVQMVHeMig>
    <xmx:SF5zalvPBnQWSodb2D9Yzhl1zZC229GIo_u3bmYUVtnX1XQ3JapoY4Z2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:01:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Toon Claes <toon@iotcl.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <anKHP7G1uE78e2x0@com-79390> (Taylor Blau's message of "Tue, 4
	Aug 2026 17:43:43 -0700")
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
	<20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
	<87a4rp1l65.fsf@emacs.iotcl.com>
	<20260718081407.GC22588@coredump.intra.peff.net>
	<xmqqzez1sf3m.fsf@gitster.g> <anKHP7G1uE78e2x0@com-79390>
Date: Wed, 05 Aug 2026 09:01:10 -0700
Message-ID: <xmqqqzkcsgjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> On Tue, Aug 04, 2026 at 03:19:57PM -0700, Junio C Hamano wrote:
>> So what happened to this discussion?  Are we happy with the set of
>> patches in v1 after all, or are we still thinking it over?
>
> I don't have a strong sense of this particular discussion, since this
> sub-thread involves only Peff and Toon. But in general, I think that my
> comment[1] here needs to be resolved before we start merging this down.
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/alq1Q55ezuN9ZI9j@com-79390/

Thanks.  Yes, the --show-trees issue looks a lot more relevant.

