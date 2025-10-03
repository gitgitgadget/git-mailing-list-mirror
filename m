Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE652C21DB
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511675; cv=none; b=CxFbQv9+pJDNoN3sVhuNTZG+7zAMp+awOog0iyrBHZybx7I/xs90j/2iZaWdWne70eHiBl934KjoFpquBJKNJ0J07zOvSh+mvwRyzcO/+GR0nAQcK6jd9DIacIgheZtBsHPDWBRHwQQtbmmFex4d3S67AqSek5tplPpJ2QfiByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511675; c=relaxed/simple;
	bh=g3yST+AhC9Z7mvgQkvoe8WPoxiLFT/099PUH31qhUWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNCDUGElndEWp4f3XhHGYp5+59Pf7fX9KxyRAq9cR5liNCZxWRQJdTx78nQxw+WyA68LpXbSw6PFUXGUops/pwnzc8XVBPVuLlwvl2Kb4mCSsmKEjnir/MOCJdoCvJWLkrCDUEaNpZn2IXtP731bThwfJ6I5Zak3+aG6EvfZ148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R68KBVVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efHqEmjY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R68KBVVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efHqEmjY"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BEC4BEC0209;
	Fri,  3 Oct 2025 13:14:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 03 Oct 2025 13:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759511672; x=1759598072; bh=BUbm1UhsQc
	tv9d4oGJ4Knf9+l5uFQOkVbJQ7kQbM8+0=; b=R68KBVVx/f5CNNzGW6+oZDYP5N
	tNIdNktFsTsq8DJAx7GSAGQAKQzw2YXtJgJREVXd+i1s2JUgV0xIQ375Ec1z1Xhv
	HgWXMZdoZo7wlO6SEsvgFqcvlAPrr7jPneZ0gWOrJfimV6tFvnsdkpTFi8OQ99KW
	rZDvVNulmybmQuwxv1Jc+HaIvcj4jZi76vIbOdqfRnQYPDQzLvzzHiOTujW3Nf/c
	waFe8PduFQXtpW3Nfnb401/+uuY6Fey2RDE3pJtswq2VNDPgk3yiTSL6gytk3E1i
	aWkUW4kdmAUSO70jI8Q5gQJj3Uogl/ke9HKxubn0+tJsT/wfur4eHfKrZ8dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759511672; x=1759598072; bh=BUbm1UhsQctv9d4oGJ4Knf9+l5uFQOkVbJQ
	7kQbM8+0=; b=efHqEmjYy5mDr4UxUoQubD6+RY6A3xsKc3jerJ/iXl8iaqXP+FW
	8knxTCimeu0thZ5kabNHos/o6hQx/WW3KOK0NpNhdilB3dVbmPWkAj6shuyt8wGn
	ufpKABDxk95ib5HBVsp/yFIJHAfkDmbE9URbQC4ymtlLL4WuSDrg6y8PhBdNOVIo
	mYb4sW1G+VrKJjRpTiryo4xLK/Ax3MWzKSDk9njEboAY77u+Bq08DSiTHy1FHwbc
	B1U8yqKnA/3/f20osbQpjNqPaRhIx5Nbx8YbI9xyg6JF1g1iiCwasv4qJXAH8Hfn
	G20rM17o7iUaX8ZYUOBKrggIUfZcWbaBz7A==
X-ME-Sender: <xms:eATgaKk99SJssHy1oPx9JDQ_myxU453jOiLFrDo4FIHXoXjTsjbTyg>
    <xme:eATgaI3XywBsQC8erftOOa-buR0DJ6PTGPQ86rdX7-K9Iq8wPKiJIHaKAVK50E5QP
    RXwo3cJ6yF5peLaQotn6RJBovl1kKfFN9ohiB_B9UxlgHZ6gxqpgg>
X-ME-Received: <xmr:eATgaNqCWeRpBa4S1z6kqbcB1Iza8e5wIMELH8u-gHC_ISBqRjNhhM9s2U9XW_sELeFavbxkt-EcYdk4gCRMv5YP6qSnL770P_Nx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:eATgaNegxCsk5HXZ1L2RNsIAZHq1CWzcnTW81V2OBMrMloK4Gb9vkA>
    <xmx:eATgaErbrrAVc5EOVjxxP4H5bXEcad1fn0fvJxXtgmpx4zr3WZde8A>
    <xmx:eATgaGEoRvbB_5THipIdnNBtx5_5k-fnKcO7_WuRs7sHEuftaGLcdg>
    <xmx:eATgaMtqfcOTme2YiLxzK3FhnELCF7NRQ4sQcCgaBmKDtaolXXtxfQ>
    <xmx:eATgaAuTloifUxi2JhvkXS2EDrZPX9xM0ihSZ4t83w5n0_duJno4g9w->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 13:14:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 8/9] t: allow specifying compatibility hash
In-Reply-To: <20251002223855.1022847-9-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 2 Oct 2025 22:38:54 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-9-sandals@crustytoothpaste.net>
Date: Fri, 03 Oct 2025 10:14:30 -0700
Message-ID: <xmqqqzvjucuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Finally, in this scenario, we can no longer rely on having broken
> objects work since we lack compatibility mappings to rewrite objects in
> the repository.  Add a prerequisite, BROKEN_OBJECTS, that we define in
> terms of COMPAT_HASH and checks to see if creating deliberately broken
> objects is possible, so that we can disable these tests if not.

Thanks for an attention for this kind of details.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 621cd31ae1..9eb79324ee 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1917,6 +1917,19 @@ test_lazy_prereq DEFAULT_HASH_ALGORITHM '
>  test_lazy_prereq DEFAULT_REPO_FORMAT '
>  	test_have_prereq SHA1,REFFILES
>  '
> +# BROKEN_OBJECTS is a test whether we can write deliberately broken objects and
> +# expect them to work.  When running using SHA-256 mode with SHA-1
> +# compatibility, we cannot write such objects because there's no SHA-1
> +# compatibility value for a nonexistent object.
> +test_lazy_prereq BROKEN_OBJECTS '
> +	! test_have_prereq COMPAT_HASH
> +'
> +
> +# COMPAT_HASH is a test if we're operating in a repository with SHA-256 with
> +# SHA-1 compatibility.
> +test_lazy_prereq COMPAT_HASH '
> +	test -n "$test_repo_compat_hash_algo"
> +'
>  
>  # Ensure that no test accidentally triggers a Git command
>  # that runs the actual maintenance scheduler, affecting a user's
