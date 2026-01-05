Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2051DDF3
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767578727; cv=none; b=tUALGzPeXVzjM+ceRLopFLqZnDpsc2nUSm5teYIos5Bl+9UBIkNTrTNdkxcqtMMa3bnX8sbyJ/sMfbcPXlK1EVBRUXSP6bVwnQKIzT7UwraVGtlfICgwAMF54b5ElH7ZcCYLyhUuzRUuSFFwgSAurROZVMoi0SumO/sjGthX8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767578727; c=relaxed/simple;
	bh=ktUNmWZ4G+E2i/VkF28bnG/ckhUIeeUyd/6qyPzPCPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kln2+ARQWyi0mAGADRPILr3JH3/LMMLVC6iQ+SH8/XHpUBoOjYtH50m5aNA0bG+9SqxK8a/wjc73vTSoD5jNebnfgrJCizKWICg06e4/WYqVhozKAJLayvcxQXzDO7Q9LfSuaRhOgO7qtu7FqL6LoHUcPb1aMQ7ALmqe2+MRk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G32SbZij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SngYDKm6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G32SbZij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SngYDKm6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 53E451D00066;
	Sun,  4 Jan 2026 21:05:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 04 Jan 2026 21:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767578724; x=1767665124; bh=BNUigo9hLw
	RSpow9/+e6OoMC7+n9crDttZ7q2buIBGM=; b=G32SbZijIm7Xr5iv+YUkbF/LHV
	nNi5P0dR0hJqNwhR0Y682UWxZByGrpPVfuN4Frm7H9jDo4NqBU81ackWZxAaPHfl
	Bc4pZv3jZbUsWgED9Dck9jd7OAyFN9vJbUttMHjakt3oCbKG0yjx/0QqreG92emp
	BZjicREmFs62yzDU9gf4o0gf911xVRZvmJgJDKeTTQKOPfcpBZNcu0X3lZJJXWZ1
	2vSOicGujzaiC/x1h4NWTODkHib2Si1onv5Qh21fsiO5vK7QbrdKd1WDh3KqoHhO
	08kKd8j5UTkoevQSuo9a4wFk3KlOl7PfkdoPFrF2kLuwrUT4daOJIWyKyfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767578724; x=1767665124; bh=BNUigo9hLwRSpow9/+e6OoMC7+n9crDttZ7
	q2buIBGM=; b=SngYDKm6s3SzafbxzZwHZPOfcryCROvAiNsJcqvaglM8m5cui4K
	Cr2H403vN8sBI7wtNOuv4tbNW8KbVbazwnli6tyPJ26Gu8Pl0dM8UoAS9wplci4+
	/vNtyiCBh1r2xa4ZrS4MZZjaCiwYs7KF5Sqan9jkug1pS6GFxDGD5AY3yeSqdjU0
	XR5E0PrNXVEIa7siUNpAIr8zuYfMe7Wur3iD+FQ/IZ3h7j52jlJs34g03ih4tNJn
	SraAXx3qlVQio/jgMRE6jBA/2J1c0Qscyqv+MyCQ45ppu36oQbI2J8J24/qK4tA7
	aB4DLkDqqCdGB4C/5kTSMF+UIMgpYvjHDdw==
X-ME-Sender: <xms:ZBxbaZ4rMitT5MfLGOIt29zpgfNnTDZ3APbuZvwiREhlSSmqRy7pxQ>
    <xme:ZBxbad5GYxTFItwnTd2bA_vb3Yd5X36p2IQTvAohoMCBg81YN6kMsR38f0zOBnJ0m
    RVRI31klAefgAOyciSV6lCX8ZrpLaKfW7LCMBnTISe1ddhMrHXSKQ>
X-ME-Received: <xmr:ZBxbaVeugiZxgzQBecmbqeeCIrnGJTG28jXocY6X1SDRzEnMaA8qz266yI3hkW6Rw3KtF4jfHA5nsaV8_M9GXNqM_R-RxigRqxr9aX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeliedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZBxbaRBzmtG6yag8p8E_AGsTMOYmakJTnlJlbqfPu3VHARFnSKSg8A>
    <xmx:ZBxbaY-TJKLFIVcwE8Np1vKADUJudI6RVghFgbMyg1z4keKY-Fyx3g>
    <xmx:ZBxbacKbjz5-YKm9SsZggU7lChiDVjvGcvSyGX7rFnPSCIc5Stsbhg>
    <xmx:ZBxbaRix2AMf9ZiGgJ1iCVGlGi1fSqJ4r96N7GXrMpLyM68CrLEdeQ>
    <xmx:ZBxbadoUQuVemyupScDqZj6otE310xUlPj6IUVUTPqV9S0BTvEtzORW8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 21:05:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v16 1/2] refactor format_branch_comparison in preparation
In-Reply-To: <cf4e9779c5d47b22bd4a04fd9b2b138d5602145a.1767568882.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 04 Jan 2026
	23:21:21 +0000")
References: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
	<pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
	<cf4e9779c5d47b22bd4a04fd9b2b138d5602145a.1767568882.git.gitgitgadget@gmail.com>
Date: Mon, 05 Jan 2026 11:05:22 +0900
Message-ID: <xmqqa4ysn7a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	} else if (!sti) {
> -		strbuf_addf(sb,
> -			_("Your branch is up to date with '%s'.\n"),
> -			base);
> -	} else if (abf == AHEAD_BEHIND_QUICK) {
> +	if (abf == AHEAD_BEHIND_QUICK) {
>  		strbuf_addf(sb,
>  			    _("Your branch and '%s' refer to different commits.\n"),
> -			    base);
> +			    branch_name);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>  				    "git status --ahead-behind");
> +	} else if (!ours && !theirs) {
> +		strbuf_addf(sb,
> +			_("Your branch is up to date with '%s'.\n"),
> +			branch_name);

We used to check if there is nothing to report (i.e., !sti is a
signal from stat_tracking_info() that there are no differences
between the branches) and reported that first, so when abf was
checked, we knew that there are some differences.  Now, your patch
reverses the order so whether there is or is not a change, abf
codepath will always report "you have differences!".

This smells iffy.
