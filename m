Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101132C8E
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511555; cv=none; b=eC6AYWGHK/zK/+74vu5kdqMkOEQ1Uy+3ruMby8iB2OgvKnZKDzYzRCHdgaIl8KQrTrNZ1EymKGVTARHhHGxusJCCl5RHzbAaPmMKD1X0qelphcKESLscDqUBFK2U3JhCRxl/fbj2G/cNUCw2qAbcm18guWTJQMYQM1Viz4eqdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511555; c=relaxed/simple;
	bh=vmbYNTbvMI8IrbKONCiQMn2gOm39ysbosfv1sSAjDGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L61av9Gd3hgkqePdMqgYZplXEycgUEVNWz4/yHrqQ/oGFkuAD4kDfB7yfdlpEoqlNO3hyBGMPSVxhYiGJkMg/f2FGmaX0ZyYf/ECb9Pd6N3UkvJHC4N0NsAiP9HDfEIqq/Rj9U+gyBeFzrDPrn58GM18IhtnNSVkWo0Dv6yPUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H16IJooF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j007CY/9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H16IJooF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j007CY/9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B08F013801E7;
	Fri,  1 Nov 2024 21:39:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 01 Nov 2024 21:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730511551; x=1730597951; bh=KW5M51zesM
	F+8HhxGCHsNFG1UcnaS692ZTWvWRkhGCk=; b=H16IJooFxt0Zx0UDpbVrh7Je8p
	WXELI1sfJclazIefpzORsshIAad+GhT1w+Tz9XgiUzUYq3g3ODOF1+7lpheGaXV8
	lgroRFaUFcltmkjnAw8Oxogo/6B7KZBoEdMF3H9PSaUmZBHKhdzvlBEzLs/PjMfR
	Hv1pI09OSfEXizykaz59oS3OF4dAeUhazVLsUd7ognYGWKkDq9OWaAP4AyhP3DGq
	031yxBV0ZLAh8Ws4kwADP99OgiK7USv/GQPZVQEdle10WzxQY3lwoOOvoC1DPM/I
	Ed5J8M+tf7SC3CUSbvXZNiAGzwO3sxsXiNs9RYvfCpeSSnE4pytvI0exKO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730511551; x=1730597951; bh=KW5M51zesMF+8HhxGCHsNFG1UcnaS692ZTW
	vWRkhGCk=; b=j007CY/91qcGzC5Sf3ZfjF5wplbZeMBVdYV0nj6fyy4HbIGq0Nv
	l8ES03fFYpQsKDAbRf0oUcIEzCwKaldBHxxn4H2xvH8Y3uWVJnobz3eti+rF3oD+
	qxTps3oH5yqXsgMCUmhAtpIic2QqQsA453yZwYKesHLCOnlQx3FigkJAU65FsiVR
	D/9Bq9YGOq5hrBxHx3rh70Xn5HkCfhg59/Cy5C7sxu2cMkVKkMJ9jMa8F3ZG1GYt
	4nHVL2U0BSdzQ4KDHUgt15Fs7rtZmRb3n6gXyc7XRmCpkelLXsfhoZFW2q03okUS
	lJMRNZpzLTtvyUDPA3baPgNzRcKgihUQvPQ==
X-ME-Sender: <xms:v4IlZyFfDkUe439jYgKDOuBBfCBZfWAZ2UX4nlKEfLMvBSfk-JyDnw>
    <xme:v4IlZzVD-OjRfdxFFBmdCV5FZQQ5CBSSgiTiBL6N-ZTH1Xk4sPjc8c4CYLIFD6bUL
    VsQ3w2-m38OYpRIaQ>
X-ME-Received: <xmr:v4IlZ8KTUiDbPyoeNyViP_gWtwvCzaHhHRV6U3DOvHV_ezLYMsi3kIfaYGim5f3N1BrYbf_hvLkChu4-AJWBG7c0CJnUuhVMN-Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgte
    ehueekjeekffehudfhgfelgfdvvefhleeludduudffjeejgfetledtieeuieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrg
    hrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v4IlZ8GhpKs16HZvUNWRC9UbM1G_j0J4oRnHgJ8ItSe4r1LvSQDDtg>
    <xmx:v4IlZ4UJnLZkbEvCLUcdkhm7M-XjlPy2bmLBT8yKCq5MeF-gYNpnHQ>
    <xmx:v4IlZ_MngI4rDXTRsSQ4t2S40ojlhub_yqr2o_2YRNWUsdzpSvgw7A>
    <xmx:v4IlZ_3lFtFw5dE8eHHsGsWBc8VRh7XbFtaGTcICopMmJWuwFqx9OA>
    <xmx:v4IlZ6LOxcsKVshk5evzkbGrbX_bj9tBXw7R5H06L0BuKEynbcfCLrlU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 21:39:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  avarab@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 3/3] Documentation/git-bundle.txt: discuss
 =?utf-8?Q?na=C3=AFve?= backups
In-Reply-To: <c50f9d405f9043a03cb5ca1855fbf27f9423c759.1730234365.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 29 Oct 2024
	21:41:46 +0100")
References: <cover.1729451376.git.code@khaugsbakk.name>
	<cover.1730234365.git.code@khaugsbakk.name>
	<c50f9d405f9043a03cb5ca1855fbf27f9423c759.1730234365.git.code@khaugsbakk.name>
Date: Fri, 01 Nov 2024 18:39:10 -0700
Message-ID: <xmqqzfmiza69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> +A naive way to make a full backup of a repository is to use something to
> +the effect of `cp -a <repo> <destination>`.  This is discouraged since
> +the repository could be written to during the copy operation.  In turn
> +some files at `<destination>` could be corrupted.

There is nothing wrong in the above, but ...

> +This is why it is recommended to use Git tooling for making repository
> +backups, either with this command or with e.g. linkgit:git-clone[1].

... "git bundle create - --all" in (or "git clone --mirror" from) a
repository cannot be an equivalent to "cp -a" in a quiescent
repository.  You'd lose what is staged, you'd lose per repository
configuration, you'd lose hooks, you may be losing other things I am
not remembering.

IOW, those who uses what you call "a naive way" may be doing so with
a valid reason.

So the patch is not quite correct as-is, even though it is going in
the right direction.  It discourages apples and recommends oranges.

Let me think aloud to see if I can come up with an improvement.

    It is tempting to do "cp -a <repository> <elsewhere>" or "tar cf
    - <repository>" to take a snapshot of a repository, but unless
    the repository is quiescent, you will get an incomplete snapshot
    with inconsiistent state.  If all you care about is the state of
    the objects and the refs that point to objects, you can instead
    use "git clone --mirror <repo> <elsewhere>" or "git bundle
    create <bndl> --all" to take a consistent snapshot.

    Note that you will lose other local states of the repository,
    such as the contents of the index, working tree, per-repository
    configuration, hooks, etc.

or something like that, perhaps?
