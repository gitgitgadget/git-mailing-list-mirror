Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA52FFF94
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812488; cv=none; b=cLpaag73vfHbUtKiPc5pMQUwPECMgr4UTY0ireYs+yf2kLZcD1EfDxjoms/hWukVAqOY6+jNQDqo0LYaGT9wlosF2QKH2p+hRO+TByN8UiRIQWgb0H9gtXGLR8DSK211OBXJzAOIISvp3ge4FJJ6XlhwRA/quCi1E7nu6A4rZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812488; c=relaxed/simple;
	bh=gbGEhL4+nQcX6Vcpo4ee+AIiofevh2e6ugAjdQ+y9sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pilfYkQZbbj+P7BM2TlNskvI4HSgx0C9p/b/8x+Lfj/ZlyE2i5JyVtkJqsgKIobTJRZrSVvrkaa3Or/loXuJFFoz9Rb0Tli91qj/uT3mTgYmmUhDHQOUB2/GlkiZDMg9/kXSKIGC5LO7GO8gSchNKtXyMWokWfhyBwI0RaJ063s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P4ipRret; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVwbu/iN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P4ipRret";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVwbu/iN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 956D514001FF;
	Mon, 10 Nov 2025 17:08:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 17:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762812485; x=1762898885; bh=XCTnwU7868
	lXoiphQNI4yB3PSmX8UlIXCYBuGzN1z0k=; b=P4ipRretJe2P7VxsNXWmxflu4g
	lWqmWpjESCujgGdhZsaLaSX/eAzVdlw0P9Vg1/uBesUAjnOA1yPWss1Edv73SKYT
	PIywQI85jKL97+vjr3hm+j0mV/CNSVdDmo1IM6jsWDdWr+jC2nQSnltaw1msyyXz
	7+A9Lgd3CAM0DlrAi2+FQ3RCf3a0xTurb+FVwK4Zxe0tOXk7TbIT1OExR4ZTyqcR
	eGhU56Sb3TvX5OOaHGoh/70d72KrO4WmIDVJdrs5WgVjPkVNx+l2t6lJt6tHW+HN
	UdjNULQxZ6ogpjiIkQ2//DvZ5/TT4Sqd8aWyWTLyeQyjHWJEwdh6d/X9/RaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762812485; x=1762898885; bh=XCTnwU7868lXoiphQNI4yB3PSmX8UlIXCYB
	uGzN1z0k=; b=WVwbu/iNn6JhdryW06tQHDldBkGssyPi9ASJ6fWTMtVOavoWJbU
	wJ3MALCBeRoQcs4uDIHYqyTPpDAZiHzduVmgN06jO0XbnttDHkymm5eVi0Y0uidr
	AD6PVwmLf/GLoOi9rx8pymKWy72kTP4FugPxhSLd7kr1PCRrlWKFvJ2bvSg6IMO0
	y9TK4n1O6NhqDewHBAm23OUGc573uos83JSyxviEIdLzomQA/G8Y3xF+ez6fNTsE
	BBp+KvdTo7oGi/Le44g4OpIV9HAJl48qDpv7TbiFccsX+DdJ2Cv1VM1cbVzC18Nz
	g7cASSFIUneWRpjSbFJJgHc10iDHnEWvVdg==
X-ME-Sender: <xms:RWISabJCT6FTWxusJ0_aXxb4lVCNeIjoTY3eB8gcYc0-W4_b4O_J1Q>
    <xme:RWISaYfBsKB3Q3cAUQQmNB0ld8I4SHAShHyRfcHNN79xn-39KHNDXFFfGTjz_qVmk
    p3CA8-DISoI3eRzwyxUmSrUo1i8nzgGzd8AKfBw_FSNStY47smiCw>
X-ME-Received: <xmr:RWISaa9_CxoDOUgXexMqBI9WdRwfldiLfWTolUakWgGCmJRyQxRYaY5I-JnwLFRssE4_XwdPOkoSCXGYbIUiO7gcZ6AcCia6syph>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RWISaVq2IHJOxzn1BSLTOUHMXVZ4s1xy99wftavKkciRm5jWZWBi3g>
    <xmx:RWISafD2wjBLRE8P7Zffa17-R8ECyfI3XBso2R8ditEHzCL0OBcXww>
    <xmx:RWISaXzI7LCvFSvkHQeYL6edp0ptp3kZIGS57Qukz5wkVlB3EP0UPg>
    <xmx:RWISac2ghFaYgzCaf648JXwf-O3buzWJBw7V-LiwbIUIpydM-Xe0kA>
    <xmx:RWISaes7AiDG2eg0GcuNXur8bMnFrDV44wIqj42xVTGfaIjrVwCkMme7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 17:08:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Li Chen <me@linux.beauty>,  phillipwood <phillip.wood@dunelm.org.uk>,
  git <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 1/4] interpret-trailers: factor out buffer-based
 processing to process_trailers()
In-Reply-To: <f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com> (Phillip Wood's
	message of "Mon, 10 Nov 2025 16:27:38 +0000")
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-2-me@linux.beauty> <xmqq1pmcmn7s.fsf@gitster.g>
	<f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com>
Date: Mon, 10 Nov 2025 14:08:03 -0800
Message-ID: <xmqq4ir1zgl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> This patch is based on my suggestion[1]. I had intended to rename "sb" 
> to "in" but forgot to do so before posting that diff. Here's my signoff 
> which Li should add before their own
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks
>
> Phillip

Ah, thanks for clarifying the origin of this patch.
