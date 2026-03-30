Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0733345A
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882819; cv=none; b=talUpfGQLYcvunhdB9thapdWWhqGFUL30I9+E7YTg5qH5EBN79ZH8pvSBbJldViQqYLVtjV+0ff2UwGYnqOSv0hSqxN6q6m/JQXeWpEtPsKPUMQqK0dggjtirC4wejMr8JrijZkUbpejND0hvnHXwTWEVAGuAj0kv2D9LI0VpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882819; c=relaxed/simple;
	bh=pzMemRXOy3swtp3KumtgSWqD/taLhWZdtIJoqx2O6S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnWNJMqFUC/4xqfqEhX2lmq8Jbh3JN0Og6tYovYNo8wgfgfLT5+aWcUQsouOzuScckOuNvbVzjrS8lk9KkMIimChn5652vn89zG2fuNWv5uI5ELRtbOs0Fk2ESfFwdRVp+TA9Z4ZCS8aM6kqWV6PmcWN7AHdSvhO2I1dSK5zV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GNNQLEnj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGxghdZ1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GNNQLEnj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGxghdZ1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AA231D001E9;
	Mon, 30 Mar 2026 11:00:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 11:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774882817; x=1774969217; bh=EjqAUE2E9m
	AFJJcAoSa+M09WIXSk1asUg9l0DTwEyuY=; b=GNNQLEnjnyUegh3e+lSY6GGNo8
	192ZeFoXva4LJKZ1zUJogFQ3lPGG6T66GGkHlWisvzOJfPRdDVYsJgoWyR/+0Y3S
	rj+Oe+LqMSxNn9O1mJJn5fdwC5a1MYDFdV+Vgc+sicezKxk3rHb0tBuf7bMwuwNT
	oLBdLzge12DkXWzWUo7ijZRsxnTvtB+YHYejp82f6AjNr7VZByB3h17LNU3aPR8M
	JT7gHglYBD33TOLeWzIFsARUKm9HAvFMhLc0piEOT85zPvNtdySEc0Xd/t+pqlBs
	TqArYkX3q3eX17actc1f4VrMxRmMqDn++gHpeeKOAIoH/0PKJ6mA6+z2znAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774882817; x=1774969217; bh=EjqAUE2E9mAFJJcAoSa+M09WIXSk1asUg9l
	0DTwEyuY=; b=gGxghdZ1JJ3/vLmi8XVOL1RH78vzhDI5V2xHDJlxEqnnMDAWkpM
	JSuUZGTw15OD7Bp11F6ZSZWFdAbJQECA3wDDpBBm0IUuZM3/ANdbtijo1tDwV7EJ
	Jib13zP8nYd/vWp25tfUkqWVP+bJ56XpeGg33Y3SKyDkSpwQTuUwdTYuh/198IUZ
	dqf3DaRNE99gEoSpKf/7lujehhBQdagCfJUiXQkgIOLRCtTbRnYA1sW6USfQ7IpA
	/JxEoEaaibGRrgxWXyZ9RDO3oX7zHIOV0c4lVczXw90CfjjIMVVTu704VTkdJnGL
	+xjXQF9FmoJOTrdayids4X1vzWFhjymqtyQ==
X-ME-Sender: <xms:AZDKaYyAAY2xkcGCwAr28twA10EYR6m_yYW1OX8-gA-CAidlKTEhUQ>
    <xme:AZDKaTt7A_44upk6kExGzq_zRoQ32_XcpO7NdsBfT9OrPQTQXyaQWIzGA0C5AovtL
    UQ7K8Sf-5ptxFJOXPV7j6-wqOYR0Oi6-RBvqwLfcwj9-DSsp0K9xw>
X-ME-Received: <xmr:AZDKaXuCFEElxEgxT4Co3G-UfRjnzUIL_8D2X5qyOnFWOE21Oxa4xOtU0HeECOBoiymCbiOjDGszaaMDs_kx-3Tg3f6MV67ofA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhkihhn
    ghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AZDKaQOUJP9t5hLFIr7YC6oB-g1qa7g_uN8UHSy6n5EkmYcwTEuoyQ>
    <xmx:AZDKad0ys_a7n7k2V7Hir_kn0UoVMXrxcGIhkfhhBDC2R06kvItxXg>
    <xmx:AZDKaUO3TJ47pBnWSCdmhTBn4n9TlTpedF6IHJDK60bvRUsLfJRAAw>
    <xmx:AZDKaV1D58yK_3BCaVWpP3UNt3_ybOLBb7s2DnsoN3xeYJNcZesuxg>
    <xmx:AZDKaTtdChNgHzAGP26BrfIDikuC9ax_HINOa-97Pmb7qXZqAORsbQWg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:00:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit code
In-Reply-To: <ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
	(Trieu Huynh's message of "Sun, 29 Mar 2026 19:59:21 +0700")
References: <20260328200255.247759-1-vikingtc4@gmail.com>
	<xmqqpl4nh3b3.fsf@gitster.g>
	<ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
Date: Mon, 30 Mar 2026 08:00:15 -0700
Message-ID: <xmqqbjg5fjls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

> Ack, I missed that point. Could you clarify how many patches or
> files changed are considered appropriate for the microproject?

The end product (i.e., a patch that could be applied to my tree) of
a microproject is not expected to have any value to improve the
project codebase.  The process has two objectives.  One is to help
new people experience the end-to-end process of sending their first
patch, getting it reviewed, engaging in a dialog with the reviewer
and communicating with others in the community, and polishing and
resubmitting the patch.  And the other is to help us see how well
each candidate can work with reviewers and others in the community.

The size of a microproject submission to allow us achieve the two
goals may ideally be one-liner change ;-) but it may be a bit too
hard to gauge the effectiveness of the candidate with such a small
patch, so in practice the lower bound would be a single file with a
few hunks, with two paragraphs in the proposed log message.

And we certainly do not need 16-patch series, each doing very
similar things and likely to be making similar mistakes at the same
time.  Interactions with reviewers on just one patch would be
sufficient for them to learn the community norm, and for us to gauge
how effective the canidate is, without doing the same or similar
exchanges for the other 15 patches.

