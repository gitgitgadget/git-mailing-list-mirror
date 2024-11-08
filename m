Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5E1C3F1F
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037616; cv=none; b=sT82wuGuocxJX+v3abjovii1zLJZ70ewKeM3teXSaZO+1N2k9LYbXNnXFYky+oCeAWgAqwAQ6yNd5O6PnGpRzspFQR9ZSQll6NRQynRb5ymxzGCkK4PNTjxhVKyFFum1qMj0F+dwzN5HibiEO2HaiaagYtJre/uf326MzybC8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037616; c=relaxed/simple;
	bh=J9mlwIxbLAQyyn7+BVRsD2EKwbfAPDl47L7ckLU6U5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6Z92eMOj3RTFBOEmNA45Qn7wVdlhc+Be3oAqkOlP3yp10FIlh8aBCg+jLAnvOTo3JTyQ255z9lvRGC5L1N7o06/UUxKc4VubUKxe5JZgloKeC2bH4GNDnZAE7wplKkeJr+Zl9xS0sezp4Xow3I4dpWIxXfB1bJkXopbMBkLhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SxeXBc+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPronnYn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxeXBc+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPronnYn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2809711401B8;
	Thu,  7 Nov 2024 22:46:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 07 Nov 2024 22:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731037613; x=1731124013; bh=vjas+u4hf/
	hLmKJxsEpYXttM2FYxWO6I6Kv1Tnblt9g=; b=SxeXBc+rPUnu/rwnatzsOXX9jo
	xZkEyYEDvlJZIN9ts7LSY9tHdI8kf1MiG9E5nrBAHMPhJGbPf6GHri7OPqYsgQ7q
	nhGHylzLAIBvw0rvSoRMlu3ucRmmTT4zeE8MZ8zqim8pWAa9vxk/2Fpo+d1Y/eKm
	fi/UQYZYZUwDMLDlGpLGjsBmKRDdjKVrOsp69x+qzSjF5wrffJ/mvT58GghlR6hZ
	GEJHygXkjaRUJydOfoP/Ru5oAHNbCAaxvTC6vLfIuPScibVD9HHjA45bg+LrRWFl
	EgQtYX9c1WSAGJAu303bPjAjH7DxN5TYiHy+LN4yHgNBBibU+HO+U37Qvx3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731037613; x=1731124013; bh=vjas+u4hf/hLmKJxsEpYXttM2FYxWO6I6Kv
	1Tnblt9g=; b=fPronnYnz99zSjRgLY2Mto9eHtb3N0lzPwbc6m6PcIo1TxGNDTo
	lzQ/MVYahpUf9UzT/Yd7uE1QCrAMf2rQwzeM5NJroyGnr9lqXshi9U0Rd+DbGISI
	XeBzqqB0QLerF5XZnhVXUmXXdkvGceSLAKKAMgsX+hxSb7HIzMPswatp1hEIjDQZ
	Yle0JVdzPUAIdEeh0YsdcTxdRrq0O7dW6CsnsBjL7AWfLIgrPqVkgQtgIHJaZyXG
	JDNYsIQst3YEkcZDYstt7N2oNkS9csZge4PR5JWapzacZfPDMJcVgPuxHLSY+jSp
	oYKODTPh5ZxAHgi40/7jwZ6Tdaw8VmIxZHA==
X-ME-Sender: <xms:rIktZ0LEspDK-NdDsiXCEUGsnrahjFZCHuKRRmBd0TJaJnY7VVen_g>
    <xme:rIktZ0L4PqnVy4yQuSxVcCgxtWDwXg18dzWaqyyU39gyaYR_uEMyLRjJd-u03I9_w
    Z3m79hGJl02f3onJQ>
X-ME-Received: <xmr:rIktZ0tYE7MWWryYpbLFPCKuxBzcnScmtSffuEZKqp8x5aK6G8pP_7zqTO-r5_TiD8BaoB2xK7h0UwxciLEbR-E__1ZsZIlKWOw7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rIktZxZml1SXPKRYbW9xKZvwgDMkOHyh0jUzv96LNiIcX-BtuduOkg>
    <xmx:rIktZ7b_uXZLfucTHwnwad_JSnZMr5eLXa8gu_BkntSpuRYGQYVR-g>
    <xmx:rIktZ9AAnrmqj3_svnDXAMEd_UefG6JIj1r5ugakJFDNfikc_9X_Qw>
    <xmx:rIktZxbKXo8h6hpEiIv6IHocCiP4vyNAJ0WSSZdvbe1GXC4YkKgIng>
    <xmx:rYktZ2zbU1K4bjdePTapQ4pcQxW61uRPRywxafxSfYGDijxRFP22jnRw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 22:46:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
In-Reply-To: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 07 Nov 2024 17:20:07
	+0000")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
Date: Fri, 08 Nov 2024 12:46:51 +0900
Message-ID: <xmqq5xoypetw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Let's add corresponding support for `git range-diff`, too. This makes it
> more convenient to spot differences between iterations of non-linear
> contributions, where so-called "evil merges" are sometimes necessary and
> need to be reviewed, too.

Nice addition.

As the "diff of the diff" outer diff part would be two-"blob" diff,
we won't have to worry about this option causing confusions to
users, unlike things like "-U8", to which layer of diffs the option
would apply.

Will queue.  Thanks.
