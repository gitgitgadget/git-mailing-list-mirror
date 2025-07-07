Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E61DA5F
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928795; cv=none; b=BUtYEcfLTvcy7O+w/vKsmXzgKXcB1rLqCw/lYElq9fvsQRUWtwtn9li7Mr/n/CT21TnyxkkEkO0yXgLnXWp2ySpAUfwfAcC+J5eJHPIBNOrKYvcW7kcTzc/R3+GxmsF7b6MCrn9A+CH+c+T0woFzKZ3itGg1uSngZE4ZmLssvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928795; c=relaxed/simple;
	bh=tj04Sz2Wpp1bwQdrVPZDiDhTLB8B2tCIxF+Bmv+JFXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnOv700mVAS0znLwHDUAmrUzFx6CTNsVryw3JYJdvjc10Bub9katcKTKCGhjPUM9aIOOut7Dyyli241HFSyKfze+9HHJBpkHNHUVZY0cqVfIWlzn8Zlz070ek6cgDGwfvNg6sRWoyixGP2/0SHeQoer8ou3a0Qd9pjkJlZCfYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X58OCkQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/9Q3HGw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X58OCkQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/9Q3HGw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2350A1400362;
	Mon,  7 Jul 2025 18:53:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 07 Jul 2025 18:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751928793; x=1752015193; bh=MX7yypsYsu
	2CZn6jF1qyRBNeU060rYyC7XtoOC08OzE=; b=X58OCkQ82lFWwiLEVYAOpny4ex
	Y/pHxrcZhnnYhyYjGN7ZWYIjAxijgxMTTHtxK/IYPAT5SQUz1T7cOx3ABR7k1dML
	KB5B6DTIdYutW8moRWi3+tGMUYmpwtXoL6HEN8cUnQQxRZUVMWOFP2Af/v1XJPT8
	2NzbLGGYdSfFGbNQVi3E8Itm23E3lIQ70A/Jkw7I37rhe852ykOKWfgS6q/7NZ3P
	75F0WwDt6B9g8O6BKYDejrTrIGjtcqvHyub7VX8MctpCIIdiJNfU0EGttCjcJ7pL
	9Mp6iVBmmoGCaD0uAyqfye7giBgrns/usObwsH5jz+RLnrm/yvg/2IRAahig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751928793; x=1752015193; bh=MX7yypsYsu2CZn6jF1qyRBNeU060rYyC7Xt
	oOC08OzE=; b=f/9Q3HGwKhuvuCZW9pU3/PfIONqCzkXm+6DlEGXc+k6BO05eB6u
	yDg9qhWQ9nWQMEH+kq0QBL8f6f6cteL6pF4SiNtkyScWnZ2YyQj7LO8GfBv/kbzN
	I5U7lD2urhmKHGUenDmN6674XjNb9e2Do9ZsU+qalX5gHewh81L+l8nNyXsLMe+a
	PL/bPacFNCNgdQnf113G70QdlzTDqo3WepRRJd4z03cR/uiWHWAgI36ocjPzdUMs
	6FpF38vceZR/x1EryDpbQNvGmsuIi+twfHCGW9N+PLL/UhA+rU6bO//oZziIjRFJ
	yTNvIeg06lXrmxHhRJ6WzVGZZlJjO2OD1xw==
X-ME-Sender: <xms:109saLn5du9xVKds1Q2YaCxsycZB5rF4KADlL_E5S_YFSbOBcJ1rUA>
    <xme:109saGMAmYz3LuYnf3fd17V9-CQNttNVbJPAC8xKB-M2TE-IQaXmgyYQmPZPLXx3O
    c78NifbqOxqoN7daA>
X-ME-Received: <xmr:109saHMgkIcLkNmiejcvit8fy5oDyTPWjdEhgoaClGi6-R5KqakyW64EZqGf7GBJx2lXJm6TgJuqgP_KvxD79rfHh6UfLdV0OOCFRuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughu
    rdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:109saPj-zMTqykIPCCg-7yUQ5kUuf12X1c__UFxR-6V8bB8Ci6vG0A>
    <xmx:109saMvNqqNWe7kqetkCYHKXu6D6Hb5D_E7vJE3hnx38VbvuVE4GSA>
    <xmx:109saNTVdi2r-NYR5pQgEr5AI6D4Hhkpxr7iDIZRAVhhKWsMyEi8RQ>
    <xmx:109saA3jcmn8ho9-xbq8RFEzVPbukRMOjE5ncZ-SUqehTHQNBXFdcA>
    <xmx:2U9saKT9n0cF3gD_A9EQcFUibnPD8VBUbOD0efMWXg_BcfhRb8pK64Rz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 18:53:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v6 0/3] pack-bitmap: fix memory leak if load_bitmap failed
In-Reply-To: <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com> (Lidong
	Yan via GitGitGadget's message of "Tue, 01 Jul 2025 05:32:06 +0000")
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
	<pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 15:53:10 -0700
Message-ID: <xmqqfrf71ull.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since it seems this patch has been inactive for some time, I have revised
> the comments according to Taylor's feedback and submitted a new version.
>
> This patch prevents pack-bitmap.c:load_bitmap() from nulling
> bitmap_git->bitmap when loading failed. Thus eliminates memory leak. This
> patch also add a test case in t5310 which use clang leak sanitizer to detect
> whether leak happens when loading failed.
>
> Lidong Yan (2):
>   pack-bitmap: reword comments in test_bitmap_commits()
>   pack-bitmap: add load corrupt bitmap test
>
> Taylor Blau (1):
>   pack-bitmap: fix memory leak if load_bitmap() failed

OK, now, how does this iteration look to folks?  We haven't heard
anybody say yet.  Is it ready to be marked for 'next' yet?

Thanks.
