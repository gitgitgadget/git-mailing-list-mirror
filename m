Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4814D8CE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625911; cv=none; b=j2AFbAQiUvIMMguwhYksb2ZlOgFCgSDF821A4cMfmqmyBgGBSMMw0cSN2Ci0eSHhokQq+df9taY2Jd/1E7X+9O1WrL1JUcn6tqUVQwAYS/Fgr7+aJtmhaNXI0qJQvFnX5TIbrtY5r0k+LP0hU1NUnBvxINeKvK2TFZvlI1QE3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625911; c=relaxed/simple;
	bh=hTwHd6aojVrSPnv9BwyyoKWszlboh1nDpIwqn3QYlgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROp3/n/iL1vboF+RgoOkD2W1AYu3hHg4CvUCDi/c6jj+1+GxQxRVfYJi9b7FlJQD1Att0MHmfTcwUEMv/eZ3tVuV+KAKpMMeekTjCzAG//zYGcXLsoZge7/FmwucCre48a+5Clz94EsaeM/g3TXIzrzU1k+VZEBE5lzFVBskdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ad7QtiMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrhyFp8C; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ad7QtiMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrhyFp8C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 162671D000FD;
	Fri, 20 Feb 2026 17:18:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 20 Feb 2026 17:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771625908; x=1771712308; bh=yy1IDywax4
	YgyNiw7tXEjUBOWMg+xpXGqPTQ0tvldY0=; b=ad7QtiMFrb4NxtZBKyIxmhyB2W
	kg96/m6MFB0ABx0efAqQDA/pWR2GipQw8iHXhm0cyZiuoKvYxU3YDzFtYTZg3S7J
	7YznWSxRSHgj+AA0un6x/U8dkyLEd3WLZQ8AXbc49THH4oXnW1+2K/GgJ27s7Ctx
	N6yS76Ss1v2UekXVpiS6+Cr3ojDd9MYslNNoNUQt0gSfKQuOlh35QtoZ2fSOQMH1
	ERARLANx/nU+yaxBH1O/FvGl4kD8Y0MbrWpiBXQEtjreo28aoEQYxNvoI6++lb76
	IYTRt3QDQvcu+7KdGo+Wdz5SBhGCfMrNSa1FcZWT5x17YaaOap97rM6BBrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771625908; x=1771712308; bh=yy1IDywax4YgyNiw7tXEjUBOWMg+xpXGqPT
	Q0tvldY0=; b=lrhyFp8CfqkoyoqNO8V6EXpBUFuvHCYKOVDK4N79ohrNc+BBEtM
	XDzOiJrOudtZpYaG5QQsiYeAYtgN3JJgGtCZjAfrDtsLikcTAdOHXJjKHi5DSMaG
	NSkkqfzhEQG5KoWJCPcT4JdDY9OwOoH0/0VY+0VEXvZxsci8ot+LVOomFc0yKIrG
	a64+pTRIlyFfhBky9F1Fpdoa3K+12oVkABG9RmBax+MfdPdRxlCKBxd87DJ9gmyV
	wbhzg0LkN1skJ8y2hgenQngIMj72OPnEaDJVPqJyd8pP8z9iNnQYkRGzLdU7CnNr
	Lgp2UtmCvOIqQvdCs/x/QZWqvmaeQnmPvEw==
X-ME-Sender: <xms:tN2YaRTMAf8flEUF_HrKMJt_rEPZlH5IfGbDUvfFLy9RLSBqc3bAPA>
    <xme:tN2YaRrDusZVYk-ZlSFCAGspwOXPVYf-BNMZdaa8pkNMTm4wRZ6nV3c0eXgEDsG5H
    UbeNBQ80JtcBxRfikIL6v1ltNHuCLPorstLXVHTesiWoH3poPvQU7Q>
X-ME-Received: <xmr:tN2YafIA2XNnGndfuKVh-wXxMaDe-1x7yW9mT-aIjJjxVLIOws30J4b0rSIekDZqjD4jaYgHJaVlcihWHDkFK276DEC3hkYsEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhthh
    husgesphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tN2YaUr994plCVhcnuL-6RiQg8X3ZLAuAjRAdenrkHlktvL6T5ivaQ>
    <xmx:tN2YaXwRddqHJz-PqIv2RF4U1zoQvWBpOVTaYHcKStDO4r2Mtt0bZQ>
    <xmx:tN2YaYMz2tv2X3w6sjlzBtaM1xmwgUrh85QshYd37MV2vhksjEq8HQ>
    <xmx:tN2Yac7oLBNVrqzuzMyUBzvVtX4FtF1RYBZUHhNrvJIzdA-noftZ9w>
    <xmx:tN2YaUGgVnmC-Fyv4qOVkdSeVwgnfhxBy-uTBiSD0GF_3HXaCC43MB2U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:18:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,   Paul Tarjan <github@paulisageek.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
In-Reply-To: <aVuplzNaoCHlZG3S@pks.im> (Patrick Steinhardt's message of "Mon,
	5 Jan 2026 13:07:51 +0100")
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
	<pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
	<aVuplzNaoCHlZG3S@pks.im>
Date: Fri, 20 Feb 2026 14:18:26 -0800
Message-ID: <xmqqikbrvz2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This would also need the below patch to support Meson. Would be great if
> you include it, otherwise I can send it as a separate patch once this
> topic lands. Thanks!
>
> Patrick
> ...

I just noticed that the discussion thread went silent after this
message.  Has the patch been reviewed and tested well to proceed,
except for that meson-build support?

Thanks.
