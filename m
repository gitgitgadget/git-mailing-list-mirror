Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FA21CC6E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901592; cv=none; b=gQjY4u4VkISe23dscNePG3PnvY4YliRAKhwkOAYpy9NOlvB1O6nnsMl+hTtNk9oKEubKu8d6dpqFO+pqSYiClEUOHIkFFsBkiQGCYqq9/+4iZ9O2tQvFDqrYwp1RTRGoWpTR/WTijW7wlRaa5/iOFT7ivT2zMZXlJSRuIQwYsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901592; c=relaxed/simple;
	bh=0b9otWKX6bJ6pR+vf+dITsmjVCbpSPQo+o6YZv1UhgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6Tous8YQod8TTtsHNqpNT2QhqmmUfxiih4edzQQpEMbmYnbOChLHuhV31zCM5LEZI5EfruXlcxjWth69Sl+tjb4wFd0o9lm8fiWqu/EdSki+4R2+E3JnSpFZlbtBWrKUhfp/qM8JgmIfXerylil8Oe6euK+E1NwPM4iPbb+NHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jxzgFGhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNJP1S6s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jxzgFGhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNJP1S6s"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACB83114017A;
	Tue, 18 Feb 2025 12:59:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 18 Feb 2025 12:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739901589; x=1739987989; bh=e7rnh2jRe9
	C6jVxF2uNpoGVR/mm7Pfp0sjiJ4n+MzXI=; b=jxzgFGhe/iOhWNS1klFBr/CzQy
	FcPjK2uHWQihFF2yfsmm473o3apizP68uVet0ZOUrlglVqtlOiknKBtNUlPX0U26
	j0c7Tbbh+1s0ogb88mrXnbXyGNu9mI69gUsom5/UV2Fj/zWYxn1z7aQ7RQSpbzyZ
	hMBxp0QgiM4zp1Ua3dMuiweaFhS3CK0nIqDBILkwZNuG30haENl/B6TPoy+RStgz
	PuPMykLAoC+BhGjDtLKQ++KgJgDIEFMFEa8xajk6caWjvgilaDkkdJ2vsaY/NWXG
	SCAzaZQG1S4/wfm0l79DxqKRlDw0RuCpheICJ9P73P6zftplErj6R6TInZjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739901589; x=1739987989; bh=e7rnh2jRe9C6jVxF2uNpoGVR/mm7Pfp0sji
	J4n+MzXI=; b=SNJP1S6sCBxrFW99m86fko1VN1nCnWSZczk9R6XYQ4N6upMHuOH
	UdfuBh3gYgSVDZ8iD9AcnVPuJ2ijTOdDCuabvRgcpk8oDC6d7CQEHoEnC/xzjVXF
	0UXM5Tcuc6vLXEPiCTma3i8Olf0TiGZcEEMXrsYvxIq4Z1TpLHangjL1cPTM1ohg
	Sn21K9fmChZmLzmtEckMI3FeJvv9+7MKzdOCAXHgQJ1M9i/dRXgh4veHuyoY3Rxs
	XnM1PdhFzk+KhsUYqNFN8FmC3SkZdMvMW7mW7NRzYDtupsnT0Med7vflwZD4JqXs
	WVNgiINNXFGoOz19EP2+AsdIpAsJG05DCOg==
X-ME-Sender: <xms:lcq0Z2J9k5xRybza7qpbZa1dYVtaCzMO8FwzTE9DtYt7mhIFygfmdw>
    <xme:lcq0Z-KKwAeBd1qyVDFku0sq4tlQowsRlWGMeLMQwcwtNXT33mDVnryWL8_dqEH_O
    OBSS2KsNC3covtjaA>
X-ME-Received: <xmr:lcq0Z2uGekXtMrP3jFP_FBVX1QNU7pR3LXbc3Dz8MiNxh88o4Lz3ydXUcrgFsxEDh69aRJH15tc2dZHEAPj49wOaz4G2aWNF_NWM61o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lcq0Z7bJdqPhOVppenFRg_aSHIjLFx60LKwb5C9lIz9dFJNAHfMhwg>
    <xmx:lcq0Z9Yq2VYo0cIa3C9Pn9cmY4RjvA3peQxKBCH7MpsXO9E2hdJr-Q>
    <xmx:lcq0Z3AdIqlh7kZwq48XAfqPIMcd5GOR4w0cgU8f908FzA_g_m9e4A>
    <xmx:lcq0Zza61l_4NWuvo9KAp-MCZkxbo85q8Rn6pxsP0svpEiVzV_QZpQ>
    <xmx:lcq0Z8UZFYFoFt_1IFDbjY21J9UpRiJrbE55JPUfjiGyvVnHNKiSPJgl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:59:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] doc: use 'title' consistently
In-Reply-To: <pull.1893.v2.git.git.1739739761445.gitgitgadget@gmail.com>
	(M. Hickford via GitGitGadget's message of "Sun, 16 Feb 2025 21:02:41
	+0000")
References: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
	<pull.1893.v2.git.git.1739739761445.gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 09:59:48 -0800
Message-ID: <xmqqldu3xhez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> The first line of a commit message is variously called 'title' or
> 'subject'.
>
> Prefer 'title' unless discussing email.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     doc: use 'title' consistently
>     
>     Patch v2 includes git-rebase.txt

Looking good.

>  Documentation/git-commit.adoc | 8 ++++----
>  Documentation/git-rebase.adoc | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Will apply with s/adoc/txt/ so that the result becomes obviously
merge-able to 'maint' (even though currently I do not plan to do a
Git 2.48.2 right now, I often do this to make it easy for distro
maintainers to backport obvious fixes to their maintenance tracks).

Thanks.
