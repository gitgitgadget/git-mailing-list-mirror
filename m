Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373D24DD09
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066911; cv=none; b=qZfT3mdgF6Gtlm8U77Xws85GW27LpqQgySPaAiD/+keBOu5FxxOnUp9ewDGzu4/CFfTegz4SfFP84WI9dk7nOGDEM8d2m+gb0UFOONwhVAVpgelomqPZwjZxEYZsWcVGUlXXLiJZxXIBZfJghHEPSCLI2s963iLIqFp3q4wO0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066911; c=relaxed/simple;
	bh=T2xBGg1zzq2T5hU4B/DtHcNuWJh2JoPItVUVLgXll5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X9kdjGQRmOKMF7ScdSFef3Bcf4ryEeILEpci6o7ooXy3XveZ9PZlZsbLIJyLQNL41aTcFD2gN9xqdFpmjdRlV+D9lYtaUHsgr/9tgsgNyHRWukmrlHYwtZx3pmMXhE2ec3+j1bbsb63586oFKALeQh0uY0tmQnZlyQ0Dhp7/fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kLf5MkSA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MaHkuTXh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kLf5MkSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MaHkuTXh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 553BAEC00B4;
	Sat, 10 Jan 2026 12:41:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 10 Jan 2026 12:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768066909; x=1768153309; bh=lieaM6ySYQ
	GL5E6dyMO1MGPAuRyoqX2qUQFqgWUmark=; b=kLf5MkSAB1KRKJLinSaWhFk8lr
	tN+f1GV+QjSLBvfAJpF0hkhOogPRZT/3LWnP8L9QY6zqTosinPcnPf0TkUVq6kkY
	DvEJC4fKOfIXGFhfUmDSR/7sfZvpa61g8vbF5vWlG+gB2VNbQO4s2gQY0SSQ0gar
	NqRdZyDMDoIReihDnv6UxYx0nWp+AFLDYSKyjFxSnJo7XjToJKIP1t6d9YBcqmI/
	ONO4b2HBlpFccPbkUWXO7b+MvGenSxGWR2doec3BDWmdJKZ8bkcEmyt4U7RjvT1K
	p4RlxPbzE914Udg+U2kJ6mK/hFeyJZt0yDJUG1Oq1Y5z88xfzV3qaeKQscHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768066909; x=1768153309; bh=lieaM6ySYQGL5E6dyMO1MGPAuRyoqX2qUQF
	qgWUmark=; b=MaHkuTXhERUnMdjJ8zQ9wSW8oUrAKv5Vqru5Ir4bcpDF3+tQbEz
	maoPL+uG4W/orVS9jP+KnKmzl6soe5RGb44C91olQ87bPBzjQk8dh9AZHiLld0/l
	jU+sF1dHvthZuIrwjFELRInapoZdt2atI2BHbHP+upTZSjlWQLjDgZEmvZ01UiT+
	IJ3ijm4C2dWTUDDVCKWi2UpbQhq6ljOPg8Dgkgn76iB1yABlOl/zHLY2/mzUF9/V
	5o+K32spWv8Xb9uBm9ba4n1MeNd+wG0KG7elLbtmqAY5wmrgXRSot8SEvlzDrB3g
	aLIIuVJthwI0ozpThkECoykRcYRG7tE4GYg==
X-ME-Sender: <xms:XY9iaX1NVTEoBRwGo0n_E2PjGe7OWoaF2p9fbojBXKP3Pvu5Z4o_jA>
    <xme:XY9iadEMW909XV2wZEapMZYLNSnMULSji8u0TQaCoaspdA2JNwOLC8kQyUr5vmlAG
    T-M--p4RsC0esmzZjBzmWP8sXnPZNalSV9Lp7ZmswAsRV42gaUl>
X-ME-Received: <xmr:XY9iac5I3okzpPodd15O8b08u8vr6h1oyvL0jJnEt3I9C9_h6qSMNiCC3vJKCMvaE-W9JP0ZK3rZbj-tmYHdkn5CJHGCa5EFyav7i3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XY9iabshFgSNqzrbC0m8x84Xhy5RjF7Tyv72hkqsoH25N58r90SgIA>
    <xmx:XY9iaV6UX488bZ5Vm3DaSw8e3SjFcOsx5x0BzjUjH7r2n2p-vDl2Nw>
    <xmx:XY9iaeXtPITPk23Fakwk39jkNd1LNG7EtN2X2Scv8B7awUS03wz5mg>
    <xmx:XY9iaf8btHhb3JfUGbaY5NWJnxVDCj-hOoskAWdg9ey91fOoaQsMXg>
    <xmx:XY9iaYY8WehqpDCNllL9bsgVO-TJcVZXcgFh9S-1Ji0CC9ENQ-hz2gQr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 12:41:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v20 0/2] status: show comparison with push remote
 tracking branch
In-Reply-To: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 10 Jan 2026 13:30:29
	+0000")
References: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 09:41:47 -0800
Message-ID: <xmqqzf6lqs9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

Here is a place for you to explain what helps people to decypher the
differences since the previous iteration in Range-diff (which is not
very easy to read).

> cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
> ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
> cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
> kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
> cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

I am not sure what good these lines are doing (to GGG).

> Harald Nordgren (2):
>   refactor format_branch_comparison in preparation
>   status: show comparison with push remote tracking branch
>
>  remote.c                 | 183 ++++++++++++++++++++-------
>  t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 403 insertions(+), 42 deletions(-)
>
>
> base-commit: d529f3a197364881746f558e5652f0236131eb86
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v20
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v20
> Pull-Request: https://github.com/git/git/pull/2138
>
> Range-diff vs v19:
>
>  1:  451d7a4986 ! 1:  bb3e00863b refactor format_branch_comparison in preparation
>      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>        		if (advice_enabled(ADVICE_STATUS_HINTS))
>        			strbuf_addstr(sb,
>        				_("  (use \"git pull\" to update your local branch)\n"));
>      -@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
>      - 			       "and have %d and %d different commits each, "
>      - 			       "respectively.\n",
>      - 			   ours + theirs),
>      + 	} else {
>      + 		strbuf_addf(sb,
>      +-			Q_("Your branch and '%s' have diverged,\n"
>      +-			       "and have %d and %d different commit each, "
>      +-			       "respectively.\n",
>      +-			   "Your branch and '%s' have diverged,\n"
>      +-			       "and have %d and %d different commits each, "
>      +-			       "respectively.\n",
>      +-			   ours + theirs),
>       -			base, ours, theirs);
>      ++			"Your branch and '%s' have diverged,\n"
>      ++			       "and have %d and %d different commits each, respectively.\n",
>       +			branch_name, ours, theirs);
>        		if (show_divergence_advice &&
>        		    advice_enabled(ADVICE_STATUS_HINTS))

Could you not mix the ours+theirs thing into the same step?  Either
make it a standalone patch to clean up before or after your main 2
patches, or leave it totally outside the series and send it after
this series settles.
