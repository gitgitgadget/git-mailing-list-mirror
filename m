Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A28376
	for <git@vger.kernel.org>; Fri,  2 May 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220912; cv=none; b=V7D7Ua9tqOU2Y0HKWlfK8Wbq/wqG9u9vIvmQ3Rh0yaFPsMJrvwte0a9QEiVwH9Ra9GBxaGw5AlmZG0uW/wGxjowIc/2yh8gRTzj6WhcPz9uPVX79aNxKBhs05caxmrtkUblxOv1B5BiAapGq0AuJ79mgABTglNUtYwzFBs7pFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220912; c=relaxed/simple;
	bh=CkRylovyntyBPSIE3Ey9eUV9T2nhkwszIrdGWLA3lqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvIqtLtjvH3rLiydliYSBqZ3Xew+Ewc+gUV4bLDlrZ3So4KfgfyW/MGKioVq8Ze0GnraK6Ryq7GncRYK7hu9JDJZ6H8JKwxH18zEhfJuzqoHKPSbg/2rO5KMBh5SbWNzIAN0YuuvU5stNGDJzpdsEsnVSED66GLoD94KjfGYum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YPvGyD51; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRcdzCLw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YPvGyD51";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRcdzCLw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F9FB11400EF;
	Fri,  2 May 2025 17:21:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 17:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746220909; x=1746307309; bh=DkJGF2AW4z
	l1DyymkghZlNDi/y326NPEehQJYgxjn0A=; b=YPvGyD51BdSF63x5rYaecjBeeV
	9OcHK+LmT7BQ2Uw26gCiPvfBwDV++aFV2JSBoxr9tSRq2Ws34L1aVbTiG03bI9y1
	ftr7tVfTA8sf8JE3pYjaAz/Qws7Ziy1gG0kHTqAJTwPi4OgVSVPgrdIMjiSQRLOr
	Ic+aliidDpRau5BpEBV9DBYiYEo9AN7JhtzRNDlHO0RrxYh+aoazAPxtCngZvnbX
	9j4nES7pmR+r3NfV14yN3Qjv96pQCI3MMI4wPG/NtKXxu55NijBDnnEjH4Q6JkkJ
	F66eFH76BwgeEZzFFDxx14IOKtLM3V2x6DQ8Cvf8HPLmOwQb3Y+U/hzZgviQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746220909; x=1746307309; bh=DkJGF2AW4zl1DyymkghZlNDi/y326NPEehQ
	JYgxjn0A=; b=eRcdzCLwhQD9G0IWPdJrLUEaA3auGkolLww59i3L4NyjKxTnhG/
	5SxiKfbw2IdyvakzKsKuHZxxnnRYAGS1Gdy6kU8Pz5l5Whlhk8FlEKYDD2wOcC5B
	+wnF2PyJmJmdhtPBSyFpECSPYaS0jgFrNKiwj/AClA3DDiRQOoCuWyE8cXnghR0S
	6BJTMQf9PqggvTNdcaTknuwy4t1ChHclToTZr7WASsyaiDnnMvV7CIq3MSdr1Azc
	9miBWdNYOmZO0QIKmoQnL7nIlGOJ6xEFV8NaXnQ7Xp7ICLulwekZGA11Bk/DGNH4
	YHQTYggZ5e05083Q46jtThr+cq7XiRyMhOg==
X-ME-Sender: <xms:bTcVaGP3Q2AjpvSoE5gMts4_brvSHnvm3r2CVODZGJq1Z63lwvrbJw>
    <xme:bTcVaE9jbT4Jk2jGpwFcWmXQz0YU1La_r7vGPgy0DrJTkO03wq9WATLoP_kw5isDk
    DVwNrlzGLM1XDk28A>
X-ME-Received: <xmr:bTcVaNSaAOI8dC_vmP0kyEPL49W-y4lizmnSI_xzQdKyVzHDfCQDItsmzlMVhET-mbjIdywD2q2nJwmbi7nKq7gyeK1NzbAr2HtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bTcVaGvQr53HBYlAeyUj1cr8KK7JpQsGb9m6FqSpCnL1lWEMfkyP6Q>
    <xmx:bTcVaOejA0J9kaYOZ5R9nUN-9RsL_uVS-dVWrs1cXmcI1O9bfJpRBQ>
    <xmx:bTcVaK3vqEwyNDsDiPWwvR2PMV3WcQnyJvH6S3_z7Rry3jaFJB9maQ>
    <xmx:bTcVaC8MXdcxE7fiOQ5R69Lz9_aVRx2XZTmrM1AjgP6ZOAhMFEQWLg>
    <xmx:bTcVaNAn_Pjz4Lnx61bKZIcT_YnJ9W-B3Ye23AhEEsBwI9veARSavEqE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 17:21:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 0/4] pack-bitmap: enable lookup tables by default, misc.
 cleanups
In-Reply-To: <cover.1744924321.git.me@ttaylorr.com> (Taylor Blau's message of
	"Thu, 17 Apr 2025 17:12:10 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
Date: Fri, 02 May 2025 14:21:47 -0700
Message-ID: <xmqqfrhmu2s4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> This is a short series I extracted from a larger topic on reusing
> "external"[^1] deltas during verbatim pack reuse.
>
> As part of performance-testing that series, I realized that bitmap
> lookup tables are not written by default. Since it has been a
> significant period of time since their introduction, the first patch of
> this series makes writing the lookup table extension the default
> behavior. This is:
>
>   * pack-bitmap: write lookup table extension by default
>
> The next three patches clean up some t/perf scripts that were redundant
> now that lookup tables are the default behavior. Those are:
>
>   * p5312: removed duplicate performance test script
>   * t/perf: avoid testing bitmaps without lookup table
>   * t/perf/lib-bitmap.sh: avoid test_perf during setup
>
> Thanks in advance for your review :-).
>
> [^1]: The term I'm using to describe delta/base pairs which either (a)
> are represented from different packs in a MIDX bitmap, or (b) the client
> is known to already have the base.
>
> Taylor Blau (4):
>   pack-bitmap: write lookup table extension by default
>   p5312: removed duplicate performance test script
>   t/perf: avoid testing bitmaps without lookup table
>   t/perf/lib-bitmap.sh: avoid test_perf during setup

Peff and I were the only two people who read these patches?
Is this topic still viable, or has it been backburnered?

Thanks.
