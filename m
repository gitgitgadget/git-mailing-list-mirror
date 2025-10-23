Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1C33DEEC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238103; cv=none; b=EIoFpGVDOjLJLNss9+IrpVuHQD1FuD8GVHYf4OWAGqJGe4JEq48Xbu1V0bvP9FV2uGNpOOgUUpgd7ToPJt+xnDz1MQtv0oqxKx/h+TurA6VY7zZikIgXfu9sWCb2/wPyR5kkECjBOegYTZoyK4aH94E2jrzCXmKEuLcmeP0BiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238103; c=relaxed/simple;
	bh=IXl23Sk2mP/7Bnj0BWKbZ7uUQQh6cdzUkMTLwG3zgm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NrOgLw+CIugfzLSmUvxwZy7bPgynmmqowvhLPX4SWDod5G8pQ6FolIQz4yyZDe4jPnHtaul/bjD4HeN5qSlf/tDsulu8VcvlUFNACa7QvAS86TDv3xIYtbD9loTuxOEfRzvZVgH4vJgRqmiGlO0eAhK7Mo1Fm+ZRk9izo7z4DuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MrIo/sCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8b0vaQy; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MrIo/sCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8b0vaQy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id A39951380163;
	Thu, 23 Oct 2025 12:48:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 12:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761238100; x=1761245300; bh=nJ5/oNbOnz
	Pp7acL1p4GlMpUDi72VhY1dcnBOQVQBII=; b=MrIo/sChM6PxmH/tL8IRwCF83s
	pdQDbJL/rTxwTI4Sm1XV0ETHu26U1rnozlDh+6xjlumtpuUqu1mx6BeNiIZFhEUM
	OqHlb0fpRUAppNAkT7RwHuMeR8LTXgrviikoQtRudyhyfPBMRVc7xAxLFMA08TAc
	4YvYtss6l/e54TDtdPFY12mRvqNJaqsjcYky4nG4VfSufZJmG934ufs4F32O1Wgn
	uOuqN70DHaCab3YcbiR02AubzitDn3dKOkEjjBaj3jD/MZOk1usB0zocGqFfps4v
	YRmA+YeTlmcqWUCpASCuGzHntBHzR/Ba1m98QvCYsHq4PKJW/5FufVjPgvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761238100; x=1761245300; bh=nJ5/oNbOnzPp7acL1p4GlMpUDi72VhY1dcn
	BOQVQBII=; b=F8b0vaQyS4xTnIDiBl7Q0F8pd/JN2V9oYs6VFj4lr0RrEI4Krdz
	QoMwzESSfI/te6yno4pmmbU1TOgWOkwrzJfCLMA/lYSichCL5AXDhwHB2djBHgcc
	7DWTjRo9FNQOmqoL9ihnomkP4nBNWDZP6gUgqp51S4iYY8jZNqRCUn3ojSssR12W
	u8IgoP9RznjvKZV9SgTcxd3/s03y6ELRz5K9HrDxTQOeWEOWUHpn5kbcxOCY1r1K
	24uW1YLf2A9c4fqP+H781A4lRYMgMkBmP/zhuiYTxD7fpflBMVA65HgSQoma39aR
	OOo51WhqBTIfxJ9S+n2xoSbEQaly2cs6C0g==
X-ME-Sender: <xms:VFz6aMq1K0iTpyDyyni6RSW69xf6UlU5Lx4M1wJDdifV8EJUTE9jMA>
    <xme:VFz6aJjJVN2-gD-h3Gv2E8cqTK-f1ce8tgULwabv4p8MuqzkgIsWLtK6j33hTLFe_
    WWZsHgE-QsGw3h3pfQi84_CDhllWYAt2G1cdn1VPsyhkFXIXJ6C>
X-ME-Received: <xmr:VFz6aJj4arWNJFHvoLpj9zH_R4EYHtT8FHeRuM26Ffov_pWGeEfWYW9_skXG8UH2dBIJ83MR0SBNPA80yd3jI4GZzuztsCNaj9m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhi
    ohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrf
    grthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfel
    tdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:VFz6aPiSpdsHswP-EsI0SquKCv7dnflk-1TqP0IvSGhD78jKaHb2Cw>
    <xmx:VFz6aJIgQAnJ1BK5RaR6cV9X7tOR4cuc54rzuU_30XRDLtICazDU5w>
    <xmx:VFz6aOFjJTSyzj9WuMcJGd__0nHVOZDYwKMKJD-FB9m-gz2DvUOwCQ>
    <xmx:VFz6aNT0TFO80EcGmgOTQZTY_HPlGO_BnAzTIKgX4DFK2921815AQg>
    <xmx:VFz6aHXmpxoVSwp-VRbcrsVr6_T9b1Yf489-yyms33CDpyV_8rWQiqHD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 12:48:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/9] builtin/maintenance: introduce "geometric" strategy
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:13:22 +0200")
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
	<20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
Date: Thu, 23 Oct 2025 09:48:18 -0700
Message-ID: <xmqq7bwlwoml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of b660e2dcb9 (Sync with 'maint', 2025-10-14)
> with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH??? play well
> with other topics by preemptively including "repository.h", 2025-09-29)
> merged into it.
>
> Changes in v2:
>   - Make the geometric factor configurable via
>     "maintenance.geometric-repack.splitFactor".
>   - Wrap some overly long lines in our tests.
>   - Link to v1: https://lore.kernel.org/r/20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im
>
> Thanks!

This round looks good to me (I wasn't very careful picking typos and
minor mistakes, but the resulting code overall looked sound).

Thanks.
