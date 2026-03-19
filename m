Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD53D522E
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927810; cv=none; b=e8wgPn5tTezor/VcB839Fyz79y9S260aFQ8w0YdRYTEdHdH1fzcaAoWw7acTNRwE7clv5IchZO/MJI2w78Fj2nf0oSuK3FOdf+yA71JaDQhmU9zYGQMU5IXzxC0GbFqPdd+Z1JiMiEiZg8CZ10PkSqZe2XXCgBHIeCOuvxMWl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927810; c=relaxed/simple;
	bh=VyCUoEazRaQ5bFC5xCbJG6dUWjgMgSWeV9rJh//38dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpH6NwMKfi+7tp4ELqPvqos1cNPgJo6Bdnr03i9QEBQdH+jaTQAJkJZJz7T0yBWQNB2Ed/DG+NLKJ7sc8y3tmGghszgSli+ikztTyPucIVPN7l0mgCQAusWEYkpKYhYewQCO3tx0Qy0x9TqDqtNLHgeJcUTy8HDu/xOqn5PDThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h/6vD1P7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Nvx5aRY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/6vD1P7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Nvx5aRY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D80B1D000E8;
	Thu, 19 Mar 2026 09:43:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773927807; x=1774014207; bh=VyCUoEazRa
	Q5bFC5xCbJG6dUWjgMgSWeV9rJh//38dg=; b=h/6vD1P78Y3f3maEz4c7p6rkW5
	JPlPNk7/kdV+sEAQh0X6nDgcbbm/PVdTO5+KS+T2rRQNETj0d0ngRD47JcCoCksr
	YXMLuCIVWnwcNOjKZcsvMQDE1sK3/gtv2P/gx3Has6emcpoHb+YFfWUofId+Ymkm
	xWvVrTOG8BWWhGjlaTHD3b3tY2e8xZhwlpT4QVzlBP6fidOVgDh5LXz9ijAQLxsw
	bQfx1CUoQvaqSbLgeLuLwfC84JCoyJbF82GaOk8PVpZpxTUkLg/GJ4Bza7hs8XN2
	WSHML6B/UUwUG9EkPlvGC+FiTE6kxn8zYFI3WGleEMrN24dJ8SshcuKMl+5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773927807; x=1774014207; bh=VyCUoEazRaQ5bFC5xCbJG6dUWjgMgSWeV9r
	Jh//38dg=; b=1Nvx5aRYSseotdwZzG0IqAIUZv+SLE99V7Z1rfrZhNzqQJlv+xH
	c7a9Oaowch2r+JprBg7hvCri9cDvM6gtYgzbZursZzYSDVB1AaZXUisVgsRBDDtA
	JuidPCPByWnrMsG3mS+vlNkqA7ikVOVBU+HDCH5EfVC+zyw48ZGH9txir4vbwBa4
	Tue9bsDYxfbnz1ge0ieCLvvnvQoL/qLneGQ/7Ecveo3RtODMfSi3RJCYJectIheE
	B4J+pCjOUmmokGjLFqYChBz8INanN8sRvUOJYLWxINEUGR4qf22TY8g3Ew8wmN2j
	O1m3bZUrAUX9HaOiAt1WG0jisIYHw+5je2Q==
X-ME-Sender: <xms:f_27abubvTkNJdb3zHsBYVZiB0nD-FjsYNhZ6KdrQNMGBhTU_VFtkw>
    <xme:f_27aT5I21sU5tsESxaCFQDwP4rlCUsQXnEz_HxLiqKCGUmS4Az8NvUAQqjrYVZ_x
    s8lZUPsLJRjxkpfDntP0eY3yxcgrMjBOp-WJLnEW1I_tUnkzUS7dA>
X-ME-Received: <xmr:f_27acJ-67BfHzalbEvFe8oS5y2_52JuEhNO_KI1wB6EzWRMWZ1FQGkH2ql5FV9Q2g0tHfi8baquRDTvfudo1rfz2lIezwrMCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:f_27aT7IyeeSy5dciJTji2qPcGCJBsqIyNkyXOt-HWuwKuU28E785Q>
    <xmx:f_27afxxW8J5WcRT8MQpzCTbApe5ElAza_q1URa3eN5FGaYpgUqe5w>
    <xmx:f_27aXZxOZBq7sw6sEfwsUTxPgAUARzG6HXhL893lOxgF7VWqtmZ-g>
    <xmx:f_27aRRdAF-FeftA4w179ahQV2A5J0-N7ws_AGxKox28pNVPqmW4TA>
    <xmx:f_27af5r4CrTfcnPdZeXbO0ZViL7FF0gUUVegg010OIBaHIqIfZRLTR6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:43:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git am: apply patches directly via message id
In-Reply-To: <20260319092441.1283001-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Thu, 19 Mar 2026 14:53:36 +0530")
References: <20260319092441.1283001-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Thu, 19 Mar 2026 06:43:25 -0700
Message-ID: <xmqqy0jolyte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Does this sound like a useful feature to add or maybe any kind of indirect
> implementation is already there and I am missing anything. Let me know what
> are your thoughts on this.

Sounds a lot like "b4 am -o-" piped to "git am" to me.
