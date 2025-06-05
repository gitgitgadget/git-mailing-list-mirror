Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BD27EC80
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749165190; cv=none; b=YNDd0kOp4DZvbJJ/0sdKgbdm+vyd+kxQFwI5G1a5lts/q/L02ZdPHBO/4EK0Iz36q0cTpr+j1VCfwa1TWJEqWziB2Y2nltQLJIW/914y7Utjkmeb2ONE8r8A6bq04LkbCDWpU6R0uDYLrh7oETw+vYVTUOhX+OtWyuW/NhTZW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749165190; c=relaxed/simple;
	bh=5/hECpEz0Ua6D/1kZKgXkBQhBGcwJu2UWzcfp7ubMuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Keheb+9s3oMbJCeYR7nek4WVvGGGCILM+P3+gVU46SErkXQScOaGuZ+YfbkINQospHtCqyKzW2F277VZAXyOeyVxaq6fvTJtJp5jNWs0Ju922HYpRr5VOvuw6d7V6aWGAYaSJFJc4O6qUugRW/l0xEylud/3duCBK3jtiJ+bE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tGarJOw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Scy9BOOW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGarJOw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Scy9BOOW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EF2911140103;
	Thu,  5 Jun 2025 19:13:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 19:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749165186; x=1749251586; bh=+/6zv+dAai
	Em8y9JjJCqNt9XEDAciVpXL88JucG6aj4=; b=tGarJOw8EpRVHY2eJa5bLypwgG
	T31YNiv18adkj/4BxvVdLCDns2AEGonqf5gipnOFAzdCxEYy3kVUmuet3bf24mS7
	HTjxOIela8egRH7deJpf9e94aFGQwXk8sjGvsyN9wTqp47yIxMJUUpOfyEaugcup
	aRdqmjnb3akNzjo5iHYAbhF+mc8JoDl8Z8eUfKBUtgYKo8YtZ5prAtCeMBH0uqmu
	xcLp1XJrCjrIxVWw55CeJ1EZgpWKWXKN15bPqYVrNyJ7n1aCy2CaR8QLRP0JhGSZ
	hRcvRJYCtg6RvFB4I4po9CmT/DynkwozMQhBkQYP89XoJIS5n8m5vXrcwQ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749165186; x=1749251586; bh=+/6zv+dAaiEm8y9JjJCqNt9XEDAciVpXL88
	JucG6aj4=; b=Scy9BOOWji8NnSCoamsQX46ZAR6R8g6dPBeQ2tqbLq+K+SyFlA6
	m2fYnSxpT3+aUfppc4s/QbkMqWn39KaQ6VotBvWPgu+aVXOPa2yioRWu2UAjUuRY
	gbXnn7CRWojse0cPQ/c4Kcj3+ukUPQaCRTJDEoj6MxqOPA3AdfGqdXLeyzNSB0O3
	TruupuNTquXqSLdwD4D/IvBT1Mf9vrnTa40WEVQDLr7+YH40sIF9nYrEcqQJd9TM
	CrUvstzdYvaDg51z9wow/UAiiRuB56eET2eXwntafSeCc4ARZqM0FvWFlatkvrLg
	oNnMgqWXvazK6ZeIUcO0AW1QV91HALX6jVg==
X-ME-Sender: <xms:giRCaHbSJhMwcarA4ryG_ZOU0ldHjfa8IDDMp3y-kIfV_R3BK7pDWw>
    <xme:giRCaGa8W6n3R3ZE99CVEmT626DMatlQIPzvWG52ZlkiapRftqP1Stma5WX5EsaVO
    6mdCoLBvnRAN_sB2A>
X-ME-Received: <xmr:giRCaJ8zu6DV4H36LU1veG65wdr4DTsSShei1PsDcyo-Px03mk11_npT5GB4VHxRWPJehimpGq-LdBhI6ad6ic1vTG0yAdNKttOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:giRCaNpAjV39kDdER70h742MjsaJNBgyvcVtwfi9uSgj3HjFfZle6g>
    <xmx:giRCaCo9pM4VN9gG0WasBGEzL9-ztm3gTbLDbJTD9UiwYl3ew4BdzQ>
    <xmx:giRCaDRjgNpWB-OD0rzplMQeyYMRo0n_ZBaSp8rgsFfBjeMKeY1F7Q>
    <xmx:giRCaKqGWGDqSIsVwt-3crBnE-7IF2s9eQDN_uRZCOgF5ekchhA7bQ>
    <xmx:giRCaPOJ4xhsZqoN4s-YojVskN-13veOMFRZTvBucPRvJaHR85qJsi7->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 19:13:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
In-Reply-To: <20250605225144.GD3005733@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Jun 2025 18:51:44 -0400")
References: <20250604205505.GA1510724@coredump.intra.peff.net>
	<20250604205513.GA1510819@coredump.intra.peff.net>
	<9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
	<xmqqh60u9nuo.fsf@gitster.g>
	<20250605224910.GB3005733@coredump.intra.peff.net>
	<20250605225144.GD3005733@coredump.intra.peff.net>
Date: Thu, 05 Jun 2025 16:13:04 -0700
Message-ID: <xmqq34cd7pfj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 05, 2025 at 06:49:10PM -0400, Jeff King wrote:
>
>> On Thu, Jun 05, 2025 at 09:04:15AM -0700, Junio C Hamano wrote:
>> 
>> > --- >8 ---
>> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > Date: Thu, 5 Jun 2025 12:57:35 +0200
>> > Subject: [PATCH] curl: pass `long` values where expected
>> > 
>> > A set of patches posted by Jeff King earlier covered some fallouts
>> > coming from new typecheck warnings cURL 8.14.0.  Here are to fix
>> > some more instances of the same new compile errors observed in the
>> > `osx-gcc` job of Git's CI builds.
>> > 
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> 
>> Thanks, this patch looks good, and I think applying on top is a bit less
>> work. I don't mind integrating them appropriately and re-rolling if we
>> prefer a slightly cleaner history, though. (I don't think there's much
>> value in recording which hit macOS and which did not).

Yeah, other than giving a quick access to the places that only broke
macOS for those who are curious enough and want to find out why ;-)

> Ah, nevermind, my patches are already in next, so building on top is
> definitely best.

Yeah, in any case, taking all four of your patches together, with
Dscho's t5410 "does tee hang?" fix, finally lets the tip of 'seen'
pass without forcing retests.

