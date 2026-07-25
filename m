Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CE2EEE79
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996417; cv=none; b=Zkd9a8lWhQLYCESCZZbf4E6qkeWRQzEPmQlDzhKo402arKzDUkTm2CfakDl6q9VE+M+4uFuvXscxz8BUMLo10rgN4nzfEzmzG7RlG1rbALySuMJ1x+c9xLaaGRHq3BV8kv7+sNTWke3DrKLC//DDHhin96HXNZRI7e5nHNfYyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996417; c=relaxed/simple;
	bh=gZUVAm4Z4yGU5lcPVTdYbxpBRTVGB8LxnF9y4U3AzOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u8DNW8rCYwtkSGNC1ZjdNmv2N5tbVq0dLIGjUGCV17JdPAT6tIWNrt72WXoT0eKzBc5sCOdFWzbXoGIg47LqWAsNioV4bBl8qZ7tw16BAwStLBBm0ykP92Vx3R9LF/neHn756n5q+IZyQ11Oh80sZRz0gT5judOcuGSIAWnlA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jCYdlcMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dr70qU+d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jCYdlcMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dr70qU+d"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EAC96EC0116;
	Sat, 25 Jul 2026 12:20:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 25 Jul 2026 12:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784996414; x=1785082814; bh=gZUVAm4Z4y
	GU5lcPVTdYbxpBRTVGB8LxnF9y4U3AzOY=; b=jCYdlcMv+EYA0fKBKNxPn/iFRK
	ALKj63eQT+66OO+2jT+NPmt1xQVq/VvFYhcr5T77UHZwyyLJaYGeIyTubP6FICFw
	jt+PnhyjfaxGN9vD2KHVfe5j/RrgnONnv9KsF22RrGQKX8dsNMplA0VLibHF5ejj
	TDXEMTyQiYn5ya2dbU66ZIg/9O1epB6v/kIKQRaalHjoYNOK13PIo5pG95nZbcs0
	mghpKqkG34qs57L4MxxOXMWk5Y9HHE9UfF/t3Liuod3deweHYEXi5hhgBJLWOt1I
	dgbDuBHBFX2wpWN2/JR1SrjhCzzDfhzGT5gvMxbXZoJWZEy2TARDbjK65Dlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784996414; x=1785082814; bh=gZUVAm4Z4yGU5lcPVTdYbxpBRTVGB8LxnF9
	y4U3AzOY=; b=dr70qU+djVvhd/4ghuyzTtBMC2Iffr3GV1AEzTSD78hWHMTF+Io
	WA0dcpG4Ipj8zz+Lqvwv7ut6f6UwbsGmG/qma1Zelht72YzMR27a/6b9hPyW/z0U
	XEyNLQsvl6LjD+TJoAyFi4rs1bUwYkCusBvBNXRS9MlX5RstTclE8PlNStvyb1tN
	6NHLurOtzZDXv8ohcHO8uoxpI00g8XYPC976JL+Q+csNu9hD9BOdwqdb5cf4vCWC
	3lF36Z26jsBNeE/tjQkNsTAWN92KDqkZNzNNzcoUhcBowoiDb3RU3fMQhVRg95r6
	9vVxVjCuaUMPwsFqFEZA2HJuLE32r/UalSg==
X-ME-Sender: <xms:PuJkaqjd5QvvXyA-x4pYHf6kPsLjc3r9TG8ViBhimwMRAqHA8hWdpw>
    <xme:PuJkatkwmM-Oz7HYWIwqUB8GqMHGiW-SMSRolLVctrodQAHowecZChYzZFYPPGrFn
    sPhgLJIgNHPgL7_TJY1qmNTEnxdsNlhA1GkMAi_T4IQ94tgaAoezA>
X-ME-Received: <xmr:PuJkaluX2dwOckip0YKW8ZpBbHfZRYd8jZJO3R5Rkl47BqLjn54npIZ4KRY6hlbuhSl3J5722O9k82mxjZ4qq6j4MDhEaOf01Q>
X-ME-Proxy-Cause: dmFkZTFGkkqZj9fdMAnH8pe6DazSuikUIVQDGGwXf11ekPhn4YvD7unw6ModgqTD3TZvIm
    GLwxljPdsHf9Ztqbx5uKxw9apAhZMxlloICuWCsaFNH0C+4T90IWzBT+mmu3IoUL/gb6ga
    W0TKs2tta4NCwJyIq8dIk5iQLuSMTnLYOIuqRX/Jq7Bn0jsP+a2i2OL+CQW2WZ4t0vD1HA
    38H0t7ek2i4oJOmi9SOy0QfILzaseFmU5phn0MGZhX5s+WIHRkH0d8tGavBS60IHR1FDoL
    RI3bU5vZL5WvLx+d3Lrycg8FMKIobWm2rWxwByGM2QcicnBeuI5QCdWnz4OUnC3HfiEtQa
    Bm/6KdtJIvBr5PFdw4WHtWN3fzpyQAcLyaQLMF4t7RmP8AHXEXi7LyTU2jdq8kF2/6/WEv
    FFvCuo+PTfc19F8ycNm7SXgEfDY/V9ujOXPdbr2+Mpc6KE+XpvAMwn/Of9LTvzM2gpBAON
    Y+gNixEFnS4eiIas6xHQCtikyfQg7cGK9j0TTcoaH+6ehQ8eCpTcKOd49/gbR7CnnoRv1x
    snMu9GajD8NpgDEWY0EuI1jVKzb+o1AjzTUjm543ovGeHzj5xFjLYmTYSkL+uk+6PKnPSl
    Vw8Vi+UIeOW5933L461Q7JKqQjE7h3oZuiphLRFv6Z52nVqdETs1UfPk3+4A
X-ME-Proxy: <xmx:PuJkajbpEQabef_QncASkzX27YX61xHUuk7tl8SUFFUe0BBEnqDSeA>
    <xmx:PuJkatD_bgDGOBGWc39yXS29-qGL2Ysqf1ISXuBJu1wn5Z2YpvHhNg>
    <xmx:PuJkar-BeS4vMf4LnE3oJoPKoz62CKeoCG2JYh64sk65kjWt8R8iMw>
    <xmx:PuJkapTUaPuQKHlCQ3dWpw3PaHM-RMZnVecPy6ammJpt3oO-agJavQ>
    <xmx:PuJkauEcClzGItyYNZOprGvYQWzxyV2Ki5_8Fyv7oxXs0mdEimEFis4I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 12:20:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ted Nyman <tnyman@openai.com>,  git@vger.kernel.org,  me@ttaylorr.com,
  ps@pks.im,  karthik.188@gmail.com,  sandals@crustytoothpaste.net,
  avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
In-Reply-To: <20260725100251.GA1933232@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 25 Jul 2026 06:02:51 -0400")
References: <cover.1783982021.git.tnyman@openai.com>
	<cover.1784676106.git.tnyman@openai.com> <xmqqldb19evx.fsf@gitster.g>
	<20260725090910.GA1438796@coredump.intra.peff.net>
	<20260725092154.GA1925154@coredump.intra.peff.net>
	<20260725100251.GA1933232@coredump.intra.peff.net>
Date: Sat, 25 Jul 2026 09:20:12 -0700
Message-ID: <xmqqik6311oj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I can't think of a synchronization point we could use here. We're
> waiting on curl to have passed the bytes to fwrite() and for it to have
> actually synced to disk. We either have to poll or modify http.c to
> write "yes, we got some bytes!" to a fifo. Both are pretty gross.
>
> I wonder if we could just drop that "test -s" entirely. We'd _usually_
> see some bytes written before the second request starts. But it's OK if
> we don't. It just means the test is working in the reverse order (the
> second request may write its bytes first, and then the first one is the
> one "overwriting" it). I.e., the two are symmetric from our perspective.

Yeah, that sounds quite sensible.
Thanks for digging.
