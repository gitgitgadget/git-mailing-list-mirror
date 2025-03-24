Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276C20EB
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796694; cv=none; b=keuQi81NOS4rxwMMtP/vDJGl/wCgF38t8J0s4ByCHF7ssG5KgrqGzndc4a2MkkKPi+Wpfk0lD8P9gY54LIVAigSVQaW30JMPSKxhtVMeImku/7RIQ3ruGy1v7Gr6epmgXIkXSUmOV/x/iJ4Lv+KHasvB7KL7VDh9IPcdHM/68XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796694; c=relaxed/simple;
	bh=iyuSjSbqCpx3FDewZZDAgySMKMbylB1xBoeSWhkVw/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aI2CJV3nPCpaQLY228K11Y/29fsGb9W9Ysfy1Oz+nVpEaw6V18wMWsX5DredpL3tgpqb1WyyvPQDK5BNtrWI7FAU3tCMtvO0LM/TBnFzHXXvQVk9Ub6m4RbMGPNZbshocQsNCPyooxZTEvxe4upZCX1p31Yifurqb7axN9A7k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDyevL5i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aoqgS+0E; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDyevL5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aoqgS+0E"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4C5C254018D;
	Mon, 24 Mar 2025 02:11:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 24 Mar 2025 02:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742796690; x=1742883090; bh=lHHFex9Ty2
	HpZJVXjbmQKjZJzcbn8YpZnXGT14fiaOQ=; b=CDyevL5iTbWKZB4Ayuy7SDTOCR
	H1iYXwDgBXkYSnVyJrfl42HOQWRwr/ESSnaSOQ0G5IkK3MaFagg8s8YdylDCX4vl
	pn5zkKpbwxTGXSAW9fhxQF0FKhPsWf1c/RKHbH1vDzxtTTuJZ0WR/YhjTiblZ1HG
	OK6ZPIsP6rc40j8gwAwuf+nMBZcOdfHvTcFzU9rtGw/nl11DkhdMnAl8H24aG80D
	7CJK9qswqRXH99Zt7khgZ1QgRCgb01fhdkUg9sPmQjMK8d7h0PDY4XsInXUUkAN3
	P+5IhQlEDTMEDs5j7KxxTd8CN7bsFkhZNcKiNkwptwyIt1csmEL79wCSz8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742796690; x=1742883090; bh=lHHFex9Ty2HpZJVXjbmQKjZJzcbn8YpZnXG
	T14fiaOQ=; b=aoqgS+0EY3kclqaAc/qdRQb1H9ghalwD0zgSgfT3cBsG0qgJ0Wa
	oElidD093K5IjCZ8PdH5vuAiBIRuqP2ChN07pwqnaHja0P/WZkNoYy512bpFbMM6
	5lgMwo/qqjQ6z2LToy5q16FDkhAGRuvYAefMewCZ9/h24DBjE4Ctyz9cY+DxNwxT
	9JWQryzBVWCrjDqMwkD6K/YZHZcg4AQ/O8EaNfHmGJYsIbVpRJQ48fktIA3v00/n
	FUejMlzwAVgs2quvvEWjQG3zbxcpfyIjQILmNc+vhf6xYS5eKXUiWEEAIyJkrOzs
	E4HaLugEUOVzfVl6dZHIMyyAQaOX7iv/qQg==
X-ME-Sender: <xms:kvfgZ1x3RTfgDkqR6T7b9IfisCnRE3jmbhUQts4pRNTF1Kbh89htMg>
    <xme:kvfgZ1SWlgrRe3sMr-15bD1Z-7TL8MWBXsSjfnqbBlS2LChuVWwPvCTy5KQfwLJwl
    pmJjsoDp5pOuevT7Q>
X-ME-Received: <xmr:kvfgZ_XR_TFtGMaSZgKSFYUB8twHKmhLyILdf2cvfxK0MlBqTaZjDcDICQrgEQ_as5SUR8KVous1tMlV-34txql05iyvh40MAhgvQaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kvfgZ3jvc5y4aB4GAaML7a9PoU4VcTVaQ986YTj3TBbfze4ds-ep4Q>
    <xmx:kvfgZ3CKZtXmSvulIIc95Ryl3IKPBySygM1HImNAq_2aZOH17UEE0A>
    <xmx:kvfgZwIuMD1hccPsh4lYO7PL9wtVvqdb52g9e0MaiACjUFduKsWYHw>
    <xmx:kvfgZ2D0Tu-TSUBlkISO-C8CpIuJy3TfKjHO4BWpN3MCaTdFciwbOA>
    <xmx:kvfgZy-vximUAi_clhsPNABGzVeVj4PP2o0f_aqHPiQ7mJV5PA1xLpFF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 02:11:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] maintenance: add loose-objects.batchSize config
In-Reply-To: <6ed537862fa7585928fde33d21b77367a7fb708d.1742777512.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 24 Mar 2025
	00:51:51 +0000")
References: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
	<6ed537862fa7585928fde33d21b77367a7fb708d.1742777512.git.gitgitgadget@gmail.com>
Date: Sun, 23 Mar 2025 23:11:29 -0700
Message-ID: <xmqqbjtrot4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The 'loose-objects' task of 'git maintenance run' first deletes loose
> objects that exit within packfiles and then collects loose objects into

"exit" -> "exist"?  It may read better to also do "collects" ->
"collects remaining".

> a packfile. This second step uses an implicit limit of fifty thousand
> that cannot be modified by users.
>
> Add a new config option that allows this limit to be adjusted or ignored
> entirely.
>
> While creating tests for this option, I noticed that actually there was
> an off-by-one error due to the strict comparison in the limit check.

Ahh, I, contrary to my usual routine, started reading from the code
change before reading the proposed log message and was wondering
about this exact point.  

> +	/* If batch_size is INT_MAX, then this will return 0 always. */

Cute ;-).

>  	return ++(d->count) > d->batch_size;
>  }
