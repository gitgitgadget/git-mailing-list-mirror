Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FE34FF47
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710339; cv=none; b=tzxDYDH9VgMFOzma8piK47rlTjy5u/83EGmkHF2geowrd3r7veBpgCv24kQ7jfHJtpO+ard1uneAfYdaBkyc0U51tFhE6km4vEm4aWETbqE2iC/suk6IP80d7ug30GpBjkusJk5JBb3p+WFH656sOjdnDyiBCOHw4j1vprcPlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710339; c=relaxed/simple;
	bh=lfjKB8oSjH9oiO4q/fI2bJDEqzXiGaLqVgUBFsaW+X8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDC9T8LzpqMs89sGB03BEkwyJRGJJm6/bUb/zT9yU5D1tWQ8BjfrH0lhDPeylwO04uIBAL0W+3BZH96urw9DNEoWZroya26RYMZHjH6vCbhjR5PA7xgowbMrb9qRh3errJYS2pvb2otREXr9FMmXbulT94n8JF0mNHC81XooHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oMIFgM/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iihQcgX0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oMIFgM/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iihQcgX0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A59E8EC00A9;
	Thu, 29 Jan 2026 13:12:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 13:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769710337; x=1769796737; bh=y5/RkYrmMM
	amgsmOfg2kuRi6PLZFqG/zrXO4xGhytRE=; b=oMIFgM/sGAxVOmUdSCGaKBCIqE
	7gKOyJl6czS2cwQYssdjNG/FySaJmdZ3D+8qIYhCcAka+KMRzZmSPGFKy9eXG6wj
	aWAsN4yRlBCguOoG0KT39Ii4xbz7+NTaCyFQmy4C+QXabsc6Ma24StV9UKjQ8knJ
	jNVm5gjjzTyKRktZcsVnE89W47qxOT7VuxhdPMEsAP+B7wGEO3cuedVNEyIr2c5f
	ndNnWbYgOUOnm2uXGYMlJzPsD+52Va6LfQUH6z2Z1zwzw9oSd1u9o/xtT8eLhVNC
	ciJ7bctvjQrN/rAlDvszqymWy1RV8md6QeoxQEQ/pHCgvOWDuxum4qxA8Xtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769710337; x=1769796737; bh=y5/RkYrmMMamgsmOfg2kuRi6PLZFqG/zrXO
	4xGhytRE=; b=iihQcgX05pQ75g3lcc2uFbvP1jNNiiiq235g8mo0DN6Ep8ykPpZ
	L5XPv+YVOnl7i6AhP9h8Uv4oDzppkEUtdvs4VDUZfxS3BZaw40bbYcA9QJVHxfnt
	yMjFr4WlvdkWDicdva9sB/MYDa/nlTgpNJAtiDn1q4Mro61T10csAbrFocVIpeVY
	U48ZDIX0FrrUPy/9YJetW6QIA9TJUSk5t3UcKuUDt8zWjZPGU4vy05e8uCxbgF48
	BRmMv7umQjDcdXCsiwAxIuwd2QnBkYlkz93wnV+yzyRKBDHWsGxVyf6iiiMkAqLV
	PWXeqv2/2L731kSdCsSxjTucZLjoRD9HSxQ==
X-ME-Sender: <xms:AaN7ae6gylWjwg8k7rxqJgmoKnsT7Eg-9BYCB1GY26oj3iXsgy-Meg>
    <xme:AaN7aUdAEMs6oXICLiHpMFeoT4vwk6Hc2_eom4s83MQaOFR0Dvk53rmzFhmiIpK3O
    gvtvnkc45IqOa7WEzJ8InCF2-kUgeq1B-rhM2tZ1T6XaN-7hA--aw>
X-ME-Received: <xmr:AaN7aR5hxVZwqPYZdq5o8cip8A8Bp9o4aMvDpKNr4k7wa8ft6FycNYaaRgkIBEnZfr65WmtH0KFBc1JVH0F4VYIitop1bSPaqTERuhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeikeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhk
    ihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhs
    mhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrg
    hrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:AaN7aR9PaANnuSwzrllFRTEaA4DJ9uk_OvUxq49eSmJWAqta6Spatg>
    <xmx:AaN7aTFiMVnLK3HRXpP9f_E3GrJ7f6jPKk0cpUh6QeXL0uiPqkUyOA>
    <xmx:AaN7aWVMbTSSwW8YqG9coYY5VlLgRrHQ2SomRYhd-AZcPwM5qS-3yA>
    <xmx:AaN7af-tCBwFYghUgp_tE5IDq2msyiSYjgTm9baY1XEvqRTey-98rA>
    <xmx:AaN7aYeq8H_wallOGdQk5amM_LkDJtgUOSlLc2jBpB6snlmj3CrBQIZv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 13:12:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v5 2/3] environment: stop using
 core.sparseCheckout globally
In-Reply-To: <5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Sat, 24 Jan 2026 13:21:12 +0100")
References: <cover.1769256839.git.belkid98@gmail.com>
	<5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com>
Date: Thu, 29 Jan 2026 10:12:15 -0800
Message-ID: <xmqqqzr8b85c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The config value `core.sparseCheckout` is parsed in
> `git_default_core_config()` and stored globally in
> `core_apply_sparse_checkout`. This could cause it to be overwritten
> by another repository when different Git repositories run in the same
> process.
>
> Move the parsed value into `struct repo_config_values` in the_repository
> to retain current behaviours and move towards libifying Git.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---

A lot of changes, almost all of which are mechanical

    s/core_apply_sparse_checkout/the_repository->config_values.apply_sparse_checkout/ 

changes, which is very straight-forward.

The same comment applies.  Do we want programs to require calling
repo_config_values_init(), or should we rely on program load-time
initialization, like all these globals that are moved to the
repo_config_values struct used to do?

I do not have a good answer to this question, but so far, these two
global variables that were both zero initialized for being in BSS do
not *need* initialization byh an explicit runtime assignment that
repo_config_values_init() allows us to do.
