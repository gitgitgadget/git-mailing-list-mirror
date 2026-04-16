Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F02BD5A8
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370379; cv=none; b=NPV7m35h81YlrHVLwQI4qSH523EWDVeJhCg1qfwgd3FvEhx28QtXSuxz7yavQYOOHzDee6QyuoY58ND0+dSNJ53jFxE2BLeRcxvWP7TCS+6Bgdd619hQ7ANZ2nfztUL2eJ/nIqfUYqAXsW03KmAqRcdUwD6/l0A8Aef4XUyepQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370379; c=relaxed/simple;
	bh=gExnuJoibM299vWQoCpFgdFj+ky/D0S9/zygtn4C8N8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aA8HRa07Je7/ywVJxk4bU61h7kOiSTh8y+3dSAPIl0NfCCVDpXpZsmcq0fCPLAe0wZNBaHra9V5GnRZ5wlsVkLcFhmUpYbOLxOwbLfr2OouuFeLZgd5GAN+sstYj2jJ5lOAuC5wqoh347XpaXoqEgqJGM0ATPWZxPGViOqmvXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u/49dWvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8+lOF/k; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u/49dWvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8+lOF/k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 51DA9EC01F3;
	Thu, 16 Apr 2026 16:12:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 16:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776370372; x=1776456772; bh=jttYzYEgdb
	IQKN0IcqOPzyBZVbPhV/8nVwalvZ30dVY=; b=u/49dWvqdvdRgdAps3n+vxzFCx
	kUBEXmPllziIQSHUmduSUF0nDBG7wViySFpH6pTh6vMqNwFcL5mb398sES05AvxO
	6gXEL551vs8KDbCPQspKyZ5JibOka8io2Rxlx871Emnzl5JwK8Av4t/vcGZkigyG
	3Saf56pZe02/wGbQgkoTLMqpuwxk8WjJRk8EnqGiBJGJit0hrlj2hn1a+3r/l5DX
	RpeZ5Ct5J9qhL504TOzANqvSshBSB/VGWpdOItgnRRZYUrZny12Kq9+Y1sZN7LT7
	DPg9zr6V1b1aWuUVz/HQFM0E65ZAhLSRgm25FOazp4tYyz6qB4FklUkIktrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776370372; x=1776456772; bh=jttYzYEgdbIQKN0IcqOPzyBZVbPhV/8nVwa
	lvZ30dVY=; b=O8+lOF/kSpM7ZA+da1nm3zTm/RYdH7fT++1p0fFVuyxb+aH6mUA
	mzH8g6nFaur59ef32wB6EqqDXQtOB3R66uB6HynbPg8DfpxBdNsUMipzCLMHfuwb
	3zjZ4qA2VLl4gh2YuVtYvwOwUSdh9RkKWT9R498BJ8l0Gb6s/Iecd5rtzaPPBr+N
	wwK1b6xOuX8l1NwTDFO3yMuVJT4wDJa8kQxXlKtlqGFbvyLCn8cASiHBhjvMiexw
	EOCYMDmksZCjAZKrXSeGTXWvvP87NJP5uA1Ese6rYl2sCVj3T0dKCYfrh7GTcn7V
	oJCojBVlUhFL94SzmZRc2FGy1A9lSMaSMuA==
X-ME-Sender: <xms:xELhabVWuXb7qk2BhBbrBP1sIqd4csEilGLgUrb42sIo4-5NrWtWlg>
    <xme:xELhaadv2RD4Owxcz1aeCyBcbKYSAd2oCDCldilgO54ODMDT1NOa_aBvgU-QkI754
    9vSx119U6F15_wvjT4me3MI9JXdG-PgGognG9-Z4tKQniV-4wFf>
X-ME-Received: <xmr:xELhafsm6-mP7y3dXkBfSqaoc4vu7B4EFLZ_8I8oBoBvFllFL8FvJ5X-rALYa_TeBgmWj80_6IaG5phaMfpsFgfrAtgfQO-gyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xELhaR9FKv2PbY4v2aFZ2JR02F5ZQbLoKX1b3PExB0uMv7eto2DWYQ>
    <xmx:xELhaS0Fw5TfQEYGkaPf2VZ_eXwXYEYtQi0Bi_EImMZqwav3-umN5Q>
    <xmx:xELhaeD7J10G8F31BCqcC9w8nCepMvYDg5l2Mm6OtmUhQizaYGyhUg>
    <xmx:xELhaWfGCl9SpxMYFb6RePstao8l1lR8lvA2kd8DLmYDV5BWaFvhOQ>
    <xmx:xELhaQViKWpmAavsH0adhgEP5K_XmjaA6Jn_U37tlUrDZn4nQR3MBgZK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:12:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <20260416194922.GA1887222@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2026 15:49:22 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g> <xmqqh5pa22h0.fsf@gitster.g>
	<20260416194922.GA1887222@coredump.intra.peff.net>
Date: Thu, 16 Apr 2026 13:12:50 -0700
Message-ID: <xmqqqzoezmt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yeah, I agree that re-wording would be a good idea here.

I actually no longer think so.

> I think this
> can happen post-release. We'd like for this to have happened long ago,
> but it didn't. Doing it in 2.54 versus 2.55 does not really matter, as:
>
>   1. We still have to worry about 2.53 and earlier anyway, so one
>      version is not much in the grand scheme of things.
>
>   2. For midx v2, 2.54 knows how to read it anyway, so is not affected
>      by the problem. ;)

I agree 100% with this.

Looking at the later part of load_multi_pack_index_one() function,
it is full of die() calls, not prepared to degrade gracefully at
all.

The reason why I do not think reword is worth doing is that as far
as this function (i.e., "Here is an MIDX file---please read it and
give me struct multi_pack_index back") is concerned, these error
returns are giving diagnosis on the nature of errors.  Sometimes we
cannot learn the length of the file, sometimes we find that the file
is unreasonably short, sometimes it is not sorted properly, etc.
None of the existing "error + cleanup" says "we are continuing
anyway" and that is good.  The decision to keep going without using
midx file (or not) belongs to the caller, so if we wanted to say
that, we should say so in the caller, not here.

