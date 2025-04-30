Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFC20B7F9
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746044890; cv=none; b=P8wxTU35KJ9VF8wrqdwj/mNQ6NHB5f0Bn8gwdsUeq03kWYdojwboWWH612IQ9sgnkZI0M0IcKIdAedA1idcFZSTR9WqlFRt8TSfVIy0BQ0ZZuvxG+pO+WMVN7d6zRgQQGe32BQd2be7Auvl460djRvmrQu0Lkalp+XveZwLLUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746044890; c=relaxed/simple;
	bh=rnhJytPPbKZtk/mCDPt7nqRhbplM1C+RmznNAMdBBMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVy/tjBInUdyGXU0LiMWAtrJ3kUNcNTvm2iCeMvtjCMGxQAC8TXRd2M4JQOsAdemalsK4DjQBlh3dF078UfvALi+NPaNyUYiqyGira3O+bRXka0/ndm3a6ZIq0hUB+cMwsrAI5Degc221DCE5jlY9EyQqDZbRmas7bTIju0bmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L536d+GH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=md2bp5vK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L536d+GH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="md2bp5vK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1354F11401D7;
	Wed, 30 Apr 2025 16:28:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 30 Apr 2025 16:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746044885; x=1746131285; bh=/l/uo2M7d/
	alkdCP0ai7ZAo/0nAt0sNcbpc69qLLL80=; b=L536d+GHzYeEUxjpd9sNxaBJmS
	P7uZgbZLH+nOJz+8ZgZbyPh9Hdv2dESZUTUAzIPHUeOPqb3yluqc6e/R2Eatfv+z
	sR8+WxJqXIp2qCSkUM82UJ8cf/B8WAJ+aWxIjBBtbmAJI3ZgUoyvbjxW43aTeg07
	a1oApOAJMO66T3qIada2uth10AfTXPpih1LnP17t/esGMppKZ9ZuWQseIcWJ/utd
	Lrs+CCYM+fXGBaxXgUQKoxjyfAA6RgCWSyo7wLgkXacLjhpVmvt44OukP39CAX5j
	JGZphUs885WH4r21nEIcWf9P7+u1UfW5shp+x/J4fawkGSfwPUJc3HanYBHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746044885; x=1746131285; bh=/l/uo2M7d/alkdCP0ai7ZAo/0nAt0sNcbpc
	69qLLL80=; b=md2bp5vKjB3wBqn3KzgG0LOImh3x8BDxg1uMA2hFq1eZGZYRsyr
	17gaFeo68xGgC4FBWy1bKSvZRDLQ0fvUqxA9fAPC0nRExXN7ANCnHwaWOCNKjTLa
	TZkhgV41O4xu+KPRNRf4TNqRKqL9YiSToHQvYLDQsaykfAY57wAeMPgc7siydxoU
	OXiniaIV0iCHyY9Uqg8xSaWSeIxgpmsVaVrZWrKunIQunKkjdrUjBBkaQV6w8sTr
	3KcV8CiHUfZPqLCt+tgzje5Zw4ZD1XHqKcNmty6VKL1L01jMpimTaCD2W4k4mnb4
	paA2nJ6xX+RBX9MtlwvruQGkURuBSD0CqXg==
X-ME-Sender: <xms:1YcSaBSIcCRqZ7xCsrecOYjGS4jIOS6D3k87NKRfdFo0cvuDph2qjg>
    <xme:1YcSaKwEkrCazEURUOwjYc3Qq9nzlc83a89hWIBTxsevV3fHJ6Y45oAym3XB0kYs0
    vnN8caW52Ah-WbQpw>
X-ME-Received: <xmr:1YcSaG3dTszhKV61p0R_T3ChnyUFIANs_JbNDLobAEMhkzwWfrDClz1ZWEgyccCVWPOfCZPgUocE99sRAw2ZhDDDBZWh9eEjIQ2->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1YcSaJCh48O1fPvTS2vlMhY2Dcrs0mIFng6D6peIzkjhNGAipqJDeQ>
    <xmx:1YcSaKjuFvjH0ERJ2nku9DRCSKzKFZcweYGSuKV-knz3Hr7o6imIVg>
    <xmx:1YcSaNop9W_raPRoKCCsRB3jk58zY2K3PPeOmXDTRLO79VtZiGvBjw>
    <xmx:1YcSaFg_kgLM2jwgM3kNOTeS49cgSIBt1OivqjF3LyujQCpvSgvCRw>
    <xmx:1YcSaElwcpu4ojJBYZ3KXt_NJhpOWEs4QdKqC0-8lPUPLH-hdhQxo0hL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 16:28:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/2] scalar: add --no-maintenance option
In-Reply-To: <pull.1913.git.1746008680.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Wed, 30 Apr 2025 10:24:38 +0000")
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
Date: Wed, 30 Apr 2025 13:28:03 -0700
Message-ID: <xmqq8qnh1jjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These patches add a new --no-maintenance option to the scalar register and
> scalar clone commands. My motivation is based on setting up Scalar clones in
> automated environments that set up a repo onto a disk image for use later.
> If background maintenance runs during later setup steps, then this
> introduces a variable that is unexpected at minimum and disruptive at worst.
> The disruption comes in if the automation has steps to run git maintenance
> run --task=<X> commands but those commands are blocked due to the
> maintenance.lock file.
>
> Functionally, these leave the default behavior as-is but allow disabling the
> git maintenance start step when users opt-in to this difference. The idea of
> Scalar is to recommend the best practices for a typical user, but allowing
> customization for expert users.

The feature itself I do not have any objections to and I found the
reasoning given above very sound.

With these two patches, we still have an unconditional call to
toggle_maintenance(1) in cmd_reconfigure().  Shoudln't the call be
at least removed, which would mean that reconfiguring would not
change the auto-maintenance states, or made controllable from the
command line of "maintenance reconfigure"?

It somehow looks to me that the real culprit of making the result of
applying two patches still unsatisfactory is the original design to
have the toggle_maintenance() call made from inside register_dir()
in the first place.  Shouldn't a much higher layer entry points like
cmd_register() and cmd_clone() be where the decision is made if
maintenance task should be set up (or not set up) by calling
toggle_maintenance(), leaving the register_dir() responsible only
for "enlist the directory to the system"?

IOW it feels to me that enabling (and now optionally disabling)
maintenance is tied too deeply into the act of enlisting a
directory; if we need to disable maintenance (and a mode to add
enlistment without enabling maintenance), it is a sign that it
shouldn't be a parameter into the register_dir() function that
controls what register_dir() does, and rather it should be done by
letting the caller who calls register_dir() decide to call (or not)
toggle_maintenance().

Thanks.

