Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A92857D1
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333436; cv=none; b=K8+ixwmdXJEfvXqfxi3VuF9yxzUAuAY4AQ7rG2+QNvcvOydsfDkE/wlwny/rq0/Fxk/8G2CWaVpLtMnVh+I5Cup7xLyoBtDqGDFX8ltVaN6SE2uiL8d49G5D87SNKbd7TauevIyq9YoqZgkl4liu3VpK+aLradW7Dc7fMKj1YtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333436; c=relaxed/simple;
	bh=zQAwBvRXExVQQb2iHgcGHDLnhi6utdThTx7l7ny5qds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=obqD7z35c0ydXwrgwVf5K7WhhrbKWwuFccbPvNL52TiqQYHHpyiNSb55Drwl0Al0t7lyC+g1uiKiTuKJfxixrhey7N688D8l2NUQ9tXJ4FLQg32D5szfpbmnIdfFYkBprpUb7sOUWnn1O5M8WRYRzzi7Nr3vB4dHv+TYC4G5OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KwA4MFup; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4dXLCzl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KwA4MFup";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4dXLCzl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B9AC13803F2;
	Tue, 22 Apr 2025 10:50:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745333433; x=1745419833; bh=NC+qn4GKaZ
	EdTU7yET03AQ5VgKCnXa63kIp6FjcqxE8=; b=KwA4MFupfbuJeCIturqUv1Rxoz
	xEMF5ROvpKVkw3xPvQzzu5RLpTsk16R0Aq4NbAXSEFGjRYhonBEabTML48KTg7CV
	p65iIAiw0flSgMG5ULfU8KDomgK8hRd00D/djSk/K0n3RomRa4ZaQyxEkqqe3hJZ
	8qOkEeBoK10MJdGggWKUMLcAXjqxU7l8a8dp2gevHhh3KiGnO01tL/i9yn8HO1nh
	OqMyYiVK5Sv0q8QJqdg/GtpiCrLpHaxAQSqYfQMiReVZfCtU+B+ul8nOXyykgrRF
	C1zDH4ZrqVX5wsGtrymkcnMv68ckIb/E8qKRnNyb/mXmki4XnhUtS8WiBSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745333433; x=1745419833; bh=NC+qn4GKaZEdTU7yET03AQ5VgKCnXa63kIp
	6FjcqxE8=; b=j4dXLCzl1+LoAxx53DvDZou55oxKbD2o4lBtiXIcxWvM0UEbSE4
	eMQ8TX7pszBkbwRer4CkpK1aga5Fl6RcteCXtZ/0t6la5IujMmAfuB2wyR3J0mkJ
	15Xk+PLaHYBpX/hShYmzis6Ktmv0VxGQzIE/rA8l/SRavCDAaqcKZDQ8a/GXhR8R
	vGfJmzJ0s1Z9VdTGUrfSO1urqVPRAVZsXM2zhDnz5s7lAgFokDz5cS2ud1i7PjoF
	rgvCeQsIu7J9lTgZF4Kx0n5oWEhhs5T5d9z4QTd0r1bXO4j3P6CzIXb00BPw24CV
	v1VG8fCc0GCxWQTUzvbD9n4kaYDUWAQlWgA==
X-ME-Sender: <xms:uKwHaBSBfhVWY5jrJm1lhsEHDuYPjSLu9CpuUM3MP2flDmd3wYHJzw>
    <xme:uKwHaKwJO22yn4HWuPKrWx5xxKpzz-rPK-UmAdZ2Gw7-JlwGbc4xn9rDOBhqxUpZN
    GU1WE_AxzQkPvQpag>
X-ME-Received: <xmr:uKwHaG3-w5aGFT5JHrq4v1mNolqH47VzE8zA6bsN9FKRjQnbEnE8-M-lNgx8j761uVAVIZTenNl20rVozjat8-VDEQo8QxfXYGsp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfehkeehtdfgheffvddugfdtjeefffet
    geetfefhfeevieduheeukeetfedtkeeknecuffhomhgrihhnpehgihhtlhgrsgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomh
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    eprghnthhhohhnhiifrghnghehudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:uKwHaJCuaJ-s7dmscydBkvy_mkPAghRzFY5LLmUW8cDcewqEpRYFiA>
    <xmx:uKwHaKh3a_UZWXQ1YjidcC4mpGvH2Kh9K6CJgKG81Xc0EEF-AunVTA>
    <xmx:uKwHaNp-CYzoMX8iib0jOlYl70SYUHoR2geBI_-RXW427JDiyZM4rQ>
    <xmx:uKwHaFhwmJf8O7o0EXgVme185rrKtEgF7WCAu91kXuDqeGghDIHDAA>
    <xmx:uawHaA9TCgE25lY92p8nKxBNNk3zmJuYDLnxHRovkkRSjJWVRo9nTjnn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 10:50:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Anthony Wang <anthonywang513@gmail.com>,
  git@vger.kernel.org
Subject: Re: aw/t9811-modernize, was Re: What's cooking in git.git (Apr
 2025, #04; Tue, 15)
In-Reply-To: <aActb3dB-r3s69h6@pks.im> (Patrick Steinhardt's message of "Tue,
	22 Apr 2025 07:47:27 +0200")
References: <xmqqbjsxkn6x.fsf@gitster.g>
	<20250418213531.GA89733@coredump.intra.peff.net>
	<xmqqtt6l9mlj.fsf@gitster.g> <xmqqmscd9mbl.fsf@gitster.g>
	<20250418215723.GA91116@coredump.intra.peff.net>
	<aActb3dB-r3s69h6@pks.im>
Date: Tue, 22 Apr 2025 07:50:30 -0700
Message-ID: <xmqq8qns5jyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think the issue is where we put the resulting binaries: they get put
> into "$HOME/path", but the problem is that "$HOME" is different between
> "install-dependencies.sh" and "run-build-and-tests.sh" because the
> latter is executed as unprivileged user.

Yuck.  Thanks for a clealy written explanation and the change.

Will queue.

>
> Something like the below (untested) patch should fix this.
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/jobs/9760840184#L4002
> [2]: https://github.com/git/git/actions/runs/14526556290/job/40759119217#step:8:1814
> [3]: https://github.com/git/git/actions/runs/14526556290/job/40759119217#step:5:2190
>
> -- >8 --
>
> Subject: [PATCH] ci: fix p4d executable not being found on GitHub Actions
>
> Our tests for git-p4(1) depend on the p4d(1) and p4(1) executables to
> exist. As we require specific versions of those binaries which typically
> aren't available on common distributions, we install them manually via
> "ci/install-dependencies.sh".
>
> This script will put the binaries into "$CUSTOM_PATH", which gets
> defined by "ci/lib.sh" -- if not explicitly overridden, its value will
> be set to "$HOME/path". This causes issues though when running our tests
> as unprivileged user, as we do both in GitLab CI and GitHub Actions,
> because "$HOME" will be different when installing dependencies and when
> running the tests. Consequently, the downloaded binaries will not be
> found unless "$CUSTOM_PATH" is overridden to a common location.
>
> We already do this for GitLab CI, where it points to "/custom". Let's do
> the same for GitHub Actions so that Perforce-based tests are executed
> again.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 83ca8e4182b..412a9a5107b 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -408,6 +408,7 @@ jobs:
>        jobname: ${{matrix.vector.jobname}}
>        CC: ${{matrix.vector.cc}}
>        CI_JOB_IMAGE: ${{matrix.vector.image}}
> +      CUSTOM_PATH: /custom
>      runs-on: ubuntu-latest
>      container: ${{matrix.vector.image}}
>      steps:
