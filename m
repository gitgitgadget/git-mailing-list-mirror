Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCF1E884
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655902; cv=none; b=H6AUw1IfTVdZgygyZem7u2guFiRllgs7k7sm+S5SPzdvc4rftYzNeg0qI3eG/6RNw0URzsTrUe4UPcUE5kafWTXuCrIthUjJe3HqkXybUwMHi+6f2ry4dvbb4rH0o5QQKQc4JCJHxN9uS5UFs3ZWel9gThJa1c1i7QCNfL/1B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655902; c=relaxed/simple;
	bh=18Kl2qW3PC/0dCLgMxtG3Nkjw55hMdF4jHh0LEzEv+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYQqHtCL1AMqawRU2v7VlVqW+BVeEhwNcVvkELXZSJE1XNVM5LeUvflExymwnF2h60eCeFky3AhYtqy6tRB3CdcLlHuw9cZbG7vwnAX1ryxUEAUsko/kwEF9/PSBRBOtB/moXbUAG38JTqQmNKCDf+s0BRnf7iMdcWrYnqpwKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GR08oFi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cQ/9j9Qn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GR08oFi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQ/9j9Qn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF410254008B;
	Thu, 23 Jan 2025 13:11:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 23 Jan 2025 13:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737655899; x=1737742299; bh=CfZBlxKhKv
	bG/dNG+vsNct0QNx2EyLPhEOg9hXcEQjg=; b=GR08oFi31yk9BhrGNAijOrWx8h
	hn8qmMmx/RtYjoIUQ4ZRnhuGsG/SttjgD8QhDLc1wh4W4iGsUrPQbIy4rdQVEpGy
	3OOQ2CJyyxZAgmD56T5ri+dnjGZJfuLg2h2SRODzDQ1Y77YTIUzS/Metq8DgbgBA
	WepCOPijYFUVC3eCHjq5t/et4iaqB/uxW7BupxIAhOcyIf6KKs355ZN9IG/Fqxcf
	L0wa1Sm/NqYi5V24FA0F7oBI6YNk5m6yBV3dOSSwhG1F14eCmKaA3sM0oXUZyPfM
	IbUwjpJoZqUVsz++r5/Jum1jOr0OcPHiUPXq7Yz065hYxK58Etof/qT3IRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737655899; x=1737742299; bh=CfZBlxKhKvbG/dNG+vsNct0QNx2EyLPhEOg
	9hXcEQjg=; b=cQ/9j9Qn527cMNZwMC48eKbVsFgy609ZE0KO+y7/3/dZ1XSHJ4p
	FO0vyIq6g9vYiRnsuPZkA/DFh6LWLkxf+hj2601Cv07789GuMvGWfCicxccFaXIy
	StDEOcox0wIwgevWDrKmNKkzF9ph2tUMcRz82aZARMYOf/zTW87MGTkyv1sE0CF1
	ReUccvVclBC4IM66+2gJrKUqmZ6yk1E+8JxTQL0RaQmtQMKK0D4mE4qPS+ARtkZK
	jjlxynkshyRGh6DWGo5XOjZhYZ5/tUDba9EW6nCg9U6h5mw470mZ58gjTVBkUWFB
	2kSMcAw20evi56noaXg/PLa/ZLwz6iRS7gg==
X-ME-Sender: <xms:W4aSZ6FBtNlyxJvfSeS-bbkIx7AmE2W1VQ-1WLEEDsJWYdxwHzFeog>
    <xme:W4aSZ7WzGAua27EAbazTprm6h-ea7qnWApMzbjkzdOmI4MmPSuEipY79Mo5g_ybR1
    FgDbZ6ZypJfKoNKKQ>
X-ME-Received: <xmr:W4aSZ0J6NYOWqb2PBKOPcMAOHAh9LqjoAoasj2XZaVux4jSd3dIgx74PHSvGwEzriD6ec6Gce5wiKxDmKPT2HNwUTNehW_4sK4X7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W4aSZ0HGVx-0Y4tj_uqfmJkcu8wPm1NymPc1hhy6aHwbMpefui-lDA>
    <xmx:W4aSZwWUrZKc-csjwCDN5MKg6esomYlr6Z4STkf2Q9LzB8pDj3alYQ>
    <xmx:W4aSZ3MgZ7JaSyJ4xad2RYJWETDHF9UUPPZmYHgGosgahxbKKJwFuw>
    <xmx:W4aSZ320sbObEEVk_A_InAcOp-Y_oqwwxe_b6exVdH4rW4xMTixBZg>
    <xmx:W4aSZyJRqXcm5wTllVUVZHTml79bt0oVxVRM97XFRCKVR4Exr7IQnpvW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:11:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,
  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] reftable: write correct max_update_index to header
In-Reply-To: <20250123135613.748916-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 23 Jan 2025 14:56:13 +0100")
References: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
	<20250123135613.748916-1-karthik.188@gmail.com>
Date: Thu, 23 Jan 2025 10:11:37 -0800
Message-ID: <xmqqbjvxs8me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> While this patch was merged to next, Dscho reported that it was flaky
> on macos pipeline. On further investigation I found this was easily
> reproducible when the leak sanitizer was turned on and the reftable
> tests were run. The fix was simply to add the missing 0 initialization.

If it is already _in_ 'next', please turn it into a relative patch
on top of it, instead of replacing it.

That will give you an opportunity to describe the breakage in the
original version, which everybody missed until it hit 'next'.  And
you can also credit the folks who reported the breakage, and
describe the fix.

The reason we do not revert out of 'next' lightly is because the
changes we merge to 'next' are supposed to be reviewed well enough,
which means that any bug we discover later is likely to have been
caused by mistakes any of us may repeat in the future, and it is
worth documenting in our history.

It is quite a different review philosophy if you compare the rules
we use for patches that haven't hit 'next'.  These uncooked patches
may have mistrakes that reviewers can easily spot and get corrected,
and these easy ones are not worth documenting as much.

> The patch is based on Maint f93ff170b9 (Git 2.48.1, 2025-01-13). 

Thanks.

