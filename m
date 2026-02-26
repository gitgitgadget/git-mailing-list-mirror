Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB1330675
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147035; cv=none; b=aTkIXCo5pA8ZyJpBABR4z4IIt8HpnAssSa7a5SojZowFrfjvF6q4akZ4EaQ+RaWTtqfaV9/Xwta5m5bHTJKLD3qsimqj1f6jRZB5ZlaqaYpdVS8A4WJQ6jiVMVBIkivpAem2R4S518jSoJ4AwNTUR4ikY/tCfmTl3yi36T2hfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147035; c=relaxed/simple;
	bh=YQxvV8UAvroSe7A1Tw/p0TWKname5nxlXVwKOEpAGzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgQyj+tJWwMuYj1np3693+ieW9jafNvp6iUcTSoJRbflG0ySoM6Nbk1iM01ZsdIgwV7xB/crMbNG1cxjQ2ymyBOR6t7l6BeobrVNgzcfOm0IZ5gsreIWhRlc7EIIQ3m4v3i4uGdIZLwr+wEeZaaVB7XUGVIwBAr7rr8aOspcqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k0dstY1w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSOJ4AfA; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0dstY1w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSOJ4AfA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D51C57A0132;
	Thu, 26 Feb 2026 18:03:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 18:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772147032; x=1772233432; bh=qeet4yOeFG
	bw/025lx8yzhV9YCGO4hdzeISWEVzOAds=; b=k0dstY1w1aM/UaoJcudRu6pwa1
	JuF1uQxsvHIEjxBz3iAuzUQXJp/fpy+Dp06u/FFCfbrxIHgMQsvbL95VlQGUxuO3
	ue/DRL+FkfK/jqPGkCwQ7Ba2O0Qu/DQFvvkaDGeabg5YcS0+eZ3U6vdulL6m2bk4
	EDnRmHSYU8Gkvcxc1+85CKm5+VPtSL/XN/hmk/slHHSR2X5YDFoJ51XwfmLR/nmn
	XCxwofA1nCraWQ5sK3bJMLIgftt9Md/Xb57K1WOyZGD2w1J9R9Qhz2myVT6686vi
	HygLC5BGFTA/meYNfLiB4PGyRTQRMgt/Y3eAb3n5Y/B4j2CTgdE06G6Lzm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772147032; x=1772233432; bh=qeet4yOeFGbw/025lx8yzhV9YCGO4hdzeIS
	WEVzOAds=; b=MSOJ4AfADe1xvZqmL6BGfPQq9++k1nHb1DBJrrPWHNmdqpKwhbC
	j8kXtkmUCCjKqb35PFSkjBTP+Y4rtIEzC06lJ/Mfom93VIB2KVNbDgOwb2bU9DR+
	nNWpjRgsG8Y39DHlo4c9PL4MezEjzo2lCb/ZMiQSFESn+bryy0q54JiM0naiR10k
	oC3TFE3Ty+syxSfkxksnK+8Lo2roEJ6kzIsjphL/ZV7RXBP05wd0qdL7+Q66l0kg
	Tzhj41ep1TVFJBvSGa7larWS8crZdqq4xFFuWpZZrCj/FmN1006apmLnxBV3i51D
	/H/Alb9OYsPRMw6M6DrLwVWr3ofU/mU+lXA==
X-ME-Sender: <xms:WNGgaao-WaZVZW7DJnE_mkd8vE6zMwHNcT7nsZDSQSRgllf2YD1kBA>
    <xme:WNGgafoqM5ZM8NVV8hETnOH26pkcp3qvgE00BeGsbDBcoNZSovQHsJ2VudWxAO-XH
    84t-3k_i3j-H3WZ7tUPTinbHe1MIXWYkyPajerpBBt4Lg7Smcvw1l4>
X-ME-Received: <xmr:WNGgaUP2x8Q0KwV159GLLgFe7Ua5wS07iYMpsOZ8Dw5UhhABL5hjiCotwK57Y8xsZWN0cAexFCQaFhlX8dsty_6mCOgSlHp3rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WNGgaYwaSGmq5KSeYLI-11Tpvbv0ZX7TTO6gGChn3AQXGqKP6Wtfig>
    <xmx:WNGgaVtL3inAbN96dl-8e5ls8gwW2XnoDMBHqkM0RVb0hnGsyZ3F7A>
    <xmx:WNGgaZ4l1Dt6O9JBLjMqDi1jaQ6cl3L3O82mSIRKyjRlyv6560gt2Q>
    <xmx:WNGgacQLs0yTCLuEHvqdVCQMiceYnS5eYbaKCwW9SPbDf7NwBFCpNw>
    <xmx:WNGgaTtugWa6EMLAm_IosqMZBs6bG7KdPYAQLZ-87EfrOcfSaXkPMPRa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 18:03:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <20260223074410.917523-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Mon, 23 Feb 2026 15:44:10 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
Date: Thu, 26 Feb 2026 15:03:51 -0800
Message-ID: <xmqqpl5rumy0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> 'read_gitfile_gently()' treats any non-regular file as
> 'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
> and other stat failures. This flawed error reporting is noted by two
> 'NEEDSWORK' comments.
>
> Address these comments by introducing two new error codes:
> 'READ_GITFILE_ERR_MISSING'(which groups the "file missing" scenarios
> together) and 'READ_GITFILE_ERR_IS_A_DIR'.
>
> To preserve the original intent of the setup process:
> 1. Update 'read_gitfile_error_die()' to treat both 'IS_A_DIR' and
>    'MISSING' as no-ops, while continuing to call 'die()' on true
>    'NOT_A_FILE' errors to prevent security hazards (like FIFOs).
> 2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'.
> 3. Only invoke 'is_git_directory()' when we explicitly receive
>    'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
> 4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
>    when 'die_on_error' is false.
>
> Additionally, audit external callers of 'read_gitfile_gently()' in
> 'submodule.c' and 'worktree.c' to accommodate the refined error codes.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                       | 45 ++++++++++++++------
>  setup.h                       |  2 +
>  submodule.c                   |  2 +-
>  t/meson.build                 |  1 +
>  t/t0009-git-dir-validation.sh | 77 +++++++++++++++++++++++++++++++++++
>  worktree.c                    |  6 ++-
>  6 files changed, 118 insertions(+), 15 deletions(-)
>  create mode 100755 t/t0009-git-dir-validation.sh

Unfortunately this seems to break almost all the tests, not just the
test the patch adds, on Windows (which I almost know nothing about,
but I can observe that CI jobs die).

https://github.com/git/git/actions/runs/22464017037 is a CI run that
merged this patch on top of the commit that corresponds to the tip
of 'next' as of today.  We can see "win test (N)" jobs dying all
over.  I cancelled the workflow before seeing everything die,
though.

https://github.com/git/git/actions/runs/22464479533 is a CI run that
tests this patch applied directly on v2.53.0 in isolation.

As I said, I do not know Windows well, so this may be a red-herring,
but in this CI run, we see "GIT_DIR=/dev/null git diff --no-index ..."
results in "fatal: error reading 'nul'":

  https://github.com/git/git/actions/runs/22464479533/job/65067515458#step:5:95419

which is an expected thing to happen, but we probably used to ignore
it as a non-error?

For now, I'll kick this topic out of my tree to give other topics a
bit more test exposure so that we can notice new bugs in them (not
in this topic) that causes the tests fail.  With this topic in 'seen',
such bugs in other topics are all masked.

Can folks equipped with knowledge and environment to debug Windows
only breakage lend a hand to figure out what this patch gets wrong
to help it move forward?


Thanks.




