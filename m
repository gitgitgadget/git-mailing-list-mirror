Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A02853F9
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222445; cv=none; b=u21enM3KknW4pV/s5bOdCcNy7dzNzqUHm0ALh5ccT58QRB6cYZ8nccC5/x0NLvPWnOMwVZQJPw/XHGjeOrM6Ow1JdofQhqSn08jnL2JRu2bbYJmJzYazAkLzXV/F3i4Pb2PTp6jGflibVgtI6RRh0ZHMRxJg+QrVCqHTLclVM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222445; c=relaxed/simple;
	bh=8PuOz6VgpxwC6GbF5oR2ADJKDB8dEMN/kI2loUll3DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1b6NGh+o9UXItGxNovlz9kcq6ARduVY7kY4VVXg9S2c+663+UbyhnayKM+kKoTuA165FhQjF7WHon/Og1cKr76k4LiXB48yyvI+uiAIOSXBAVaIeeRNObXYnrvhDc1/ZChkKEWdW2Jbvaj5WudM5JsDxf+Wg5Z7qu/MHYyaXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q9S1KY4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FijYxIcp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q9S1KY4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FijYxIcp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C7307EC02E6;
	Tue, 26 Aug 2025 11:34:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 26 Aug 2025 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756222442; x=1756308842; bh=edEIF29YVz
	JRAT0INlGp5+ZlO+jxrU493sIQXQIblHc=; b=q9S1KY4H2smwP3nmpA50vRsB2x
	LQiKwSsxk59E6AaW23m7//wJlddyQRqWqyH4iFApztsqAWbj6yBlL5K5bDYvh6O9
	qnLCtmN72wV3g+57SM7Edi20yLs6oV1LN2GiMyF8uc++YW4sa4hpy3jY5s3u7Gxj
	kLyFr93RSJ/LFZRMQr26XIqJrbNURSQTkRsvz8wsE+s9oatHoqIvT/aAslBHlDyb
	52yeBLDP6pTKBFz8stBYks8qgPkamL+beCkiSP4gefZxrsYtgCMuXVN5GzNe4KD1
	erKFTzZ/ivMpSZcOWpkWWkPk8d3I78AKeeGUt41hPDhW20KduEotFpU4MEYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756222442; x=1756308842; bh=edEIF29YVzJRAT0INlGp5+ZlO+jxrU493sI
	QXQIblHc=; b=FijYxIcpDt0dHb2k/qmSlfaONVjpzAjn4UwWDDmOt13HtFUFBW1
	9MqkSPQ8ySrNWjTT1FyELLnKgct452gykwHE+bjrjslOkKt3e4O1qJKwKJAti9Dl
	jo0+bzhhj2rWHbQtNY7oh/cGRxzksNazb1pdcaLn3xWO65jw8+s8CnfSDjjvKBKP
	SBagra6hWt0orZQ+Rro3wz/WCWPXjlohYrGrcehvfXQn557bh9Dg6cZ7+cCHXUGa
	wfeQ8YYNwjopmQLVOyICH4RIfbdQNBqyTEjYC3/zoZQNDehWbO1eYOvG0bxEC9uU
	+FOaNnwrKKuw8BRcj5ggpMKCID4cdGa0Tqw==
X-ME-Sender: <xms:6tOtaDkmRBx_plniDM5Q-hGnQgoQN4kXnPuGQZkI1gjG-q0aMmJh_w>
    <xme:6tOtaBaK0VtaiU62u2ogr1UNNVsEXspqg_LyXr4RsdEmg7sxAhCzDO5HgHzx329L-
    AV1HYtrd3Dd2MIaPQ>
X-ME-Received: <xmr:6tOtaGOdr5OF1YhdsT5_z-VPIVtcroq8NYzjZpPgDOAzPkibbvU6RhIp7tQNqWCz3rBgGY5s7eXQlvq1UvQXJBD7cJVsoQ3MId5xars>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6tOtaOYqskfWxu8zhC7n2vckxSqtS5zfODoIVdLHS32cMdI1eBGRpg>
    <xmx:6tOtaM01BeiuwL1dxXSl5trQss4De2jyNU0NFt6t5aio9DmHNnuLMw>
    <xmx:6tOtaMcpdV9UQaeBRbzBufOKTe7dWbu07YpYrdkoVpbjTcuO2StH6g>
    <xmx:6tOtaFF6DBm_xrMM3Au3vWifuCL8_ftrQjXSlo6kYwSYAyr1yiYaaw>
    <xmx:6tOtaB3Dd7NBmtBMiIa2U0Zbly7gZ9gCE8qvMcXxmjVUwJSzrt15xJ6e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 11:34:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
In-Reply-To: <20250826042607.GA995491@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 26 Aug 2025 00:26:07 -0400")
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
	<20250824103117.GA250458@coredump.intra.peff.net>
	<6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
	<20250825073403.GA332447@coredump.intra.peff.net>
	<20250825081345.GA352784@coredump.intra.peff.net>
	<xmqqcy8jqlue.fsf@gitster.g>
	<20250826033920.GA388997@coredump.intra.peff.net>
	<20250826042607.GA995491@coredump.intra.peff.net>
Date: Tue, 26 Aug 2025 08:34:00 -0700
Message-ID: <xmqqwm6qksgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> OK, maybe I am just holding it wrong. I think I may have mistakenly been
> using the wrong timing for my baseline (maybe --date-order instead of
> --author-date-order; the latter is _way_ more expensive because we have
> to open the commits to parse the author date).

True.  And the numbers below are much more believable ;-)

> Here's a more apples-to-apples comparison using hyperfine. On git.git:
> ...
> So a little slowdown, but within the run-to-run noise. And on linux.git:
> ...
> A little more measurable there. Those numbers are more in line with what
> I was expecting.
> ...
> I'm not sure what it all means, though. 6% is enough that it is
> probably worth keeping a custom data type like slab around.
> Though it would be nice to have a data type that worked on all
> object types and didn't necessarily use a ton of memory.

Yup, a short version of it is "assume that we still live in the old
world where 'you want to compute X?  spawn a process, work in-core
and compute and spew out your result, then exit(3) will clean up
after you' was the norm.  And our codebase has an easy way to tell
the object API to allocate N extra bytes for app specific per object
bookkeeping purpose.  Now, would you use that facility to store your
data there because you'd need that data for all objects you touch in
your application?" and if the answer is yes, it belongs to slab,
otherwise you are better off with a separate hashtable indexed via
object names populated only for few selected objects you care about.

For example, the slab is something I would have used to rewrite
"show-branch", since it would have been really handy to have more
bits in per-object "flags", and the most natural way to write that
application is to keep one bit in all objects it slurps in core for
every starting ref.

> This particular case may not be representative, either. I picked it
> because it was easy to convert. But I wonder how bad it would be to put
> the object flags for a traversal into a hash. Right now those are in the
> original struct, not even in a commit-slab. So I'd guess it's an even
> bigger slowdown.

True, too.
