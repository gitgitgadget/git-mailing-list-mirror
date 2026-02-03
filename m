Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D148EEAB
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132640; cv=none; b=CaQefW7MgIZbAQryUv8mDsYwelUNSRrUE0dT+TAZzYIuVUnz//MvDXov06bcOWrVahldXYkIapcmTxJEBim81gvNVocJHMtl2aO4WGr5sNEEo2ci616IWj+HvU8hD0cG7uw4rtMPHQwHkwXtEGjdwoL/x9NYGkjVsHGB40+wlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132640; c=relaxed/simple;
	bh=M1+aQ5+dW7C4AP5cSrhBz+eHVjRqpOpV6s5CoELCuAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f8VuUs1Jc8myaf8rvdvKShAlwuE50YBAdfGpKN5w9o97BDvtvMlZ/5yRpp/gp0Fz3oM0oKsRmnUaY8Lfwm6kOIWJmTjAX7A97cUQnxVrsEOoLC0ZLM6QZkHcAN7oWGn1RdISfdE2rELOOGR0pLRu9BQBmHMAvZ1fxVM+N0l3NHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xRpmUV4M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/i9R8pn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xRpmUV4M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/i9R8pn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F3E97A003F;
	Tue,  3 Feb 2026 10:30:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Feb 2026 10:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770132638; x=1770219038; bh=bwP8L9b2Jz
	CX4+OhYEqZpLAMskIZr6jm40w0NXBHbZg=; b=xRpmUV4MctgIoEZwPC53i/3l/X
	GjWFrxGvibyfR1I9npc5zCb+k/2Er1BYTkp2oBnPixwJbNdbphXlQFqPbN2KgOzE
	M14Ni+CUKTJBFlgXpPWSkVxxgAD2uJTKnWo+VgD7WJgxXwYxRTQq5Yi/vFAgFWtR
	Hk/RDuW/kKKoDkNQKX58Q93vm3q8k3oJOyOMbAhNKoEdpB6VhDf0deMwNceTyn9s
	1zMIbkBvPaCVgh7s8SC5pzLsAnglAH8gpuwMgWVJ6Pcc6aZKf5gNZSj+yX+5wufb
	aDavksCc0GGL2sWWJJOklWGlpFrC+nX76IULuM/vE9XgHi9UrqEw3MEOFfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770132638; x=1770219038; bh=bwP8L9b2JzCX4+OhYEqZpLAMskIZr6jm40w
	0NXBHbZg=; b=I/i9R8pnB89v3E6yOx1wioVbpugpMyTFouCs+mNM8ZC5a9fsgbG
	ZYg2Xds7Vf8zOhlGOwp0y4vIusJpRNu+W39QpcQ0pyFjhLVScEanCY3tjWyjqV9w
	DDu3OuVeJiaOImYBIqDRmZm3cXOzs8POZQsvvh2HtSlpRrrvsl4DFtPWi4oeW9VX
	i0ItdkJ4G+Bl7SfYPOejxTPcoDi9U5X2eqcXwGAy9GbUWYr9iy9+JwhKgA9sFpZz
	Aw94IlOKzvMZuB1+6LCtC8ZB64JCBN6HQddxIWWMhfZTvhgOjxKmntlBLb5ScFe6
	tPDe1c6IFgJcZPz3o/e/9p2dD8URwL9MhoA==
X-ME-Sender: <xms:nhSCad34jPzADcKW3zfsz97EiVSoYmqISiDvxQRvQvSKBLQS59CAnQ>
    <xme:nhSCabFEh6TinkmC5ifSEZkmvc-gPzhyfUG35p5b6dKfOWZdBLT8-fcKn0S2uo4hQ
    Ol5kXASkrXvRs-V_pK2aONmPTTm9_eClqpXrfandHkJBYEx9iO8L8M>
X-ME-Received: <xmr:nhSCaS5TZdR_4K-dZPDOe04OiydVsU1WID83ut5Ss0NkfWoUvj5rX-6IXzOH06k831doJE1iX-Ysv4s6y1dN48JCFB6-pRyQEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhushhhkhgrrhhkuhhm
    rghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumh
    honhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:nhSCaZvMZ-OHvnQhkQaltRpQ5LvPg2hbKrjhNbjlxetd8kWMIztQEA>
    <xmx:nhSCab6VKstG818Khxmpynuaj1dtlkCp8xu3Zb2FKAVae5yIsTiokw>
    <xmx:nhSCacXDaOFP22o2vP_7LHTJODONJhp014P577cRBGjFV7ri0wsBMw>
    <xmx:nhSCaV9sBfFmZkO63rEcrbz9j-AXrTu9cNTPMIHSw-yD1C_i3YtICg>
    <xmx:nhSCaXpjxCr9Smqz6IUHBIhtfSrJZ5ROBO1jsK46CAVPR1MZOBP2wP52>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 10:30:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  Josh Steadmon
 <steadmon@google.com>
Subject: [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <xmqqjywuyhu9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Feb 2026 13:07:58 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g>
Date: Tue, 03 Feb 2026 07:30:36 -0800
Message-ID: <xmqqsebhu9nn.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I am tempted to propose us doing something like this, so
> that you guys do not have to every time you import my 'next'.
>
> --- >8 ---
> Subject: [PATCH] test: optionally test contrib in CI
>
> Recently it was reported that a topic merged to 'next' broke build
> and test for contrib/subtree part of the system.
>
> Instead of having those who run 'next' or 'master' to hit the build
> and test breakage and report to us, make sure we notice breakages in
> contrib/ area before they hit my tree at all, during their own
> presubmit testing.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * There should be a cleaner way to make sure any new Makefile with
>    "test" target in contrib/* directores are added to the execution,
>    but for now this should do.

Unfortunately, this seems to reveal existing other problems with
subtree tests (t7900), in addition to diff-highlight tests (t9400)
in various configurations.

  https://github.com/git/git/actions/runs/21617099884

This Ci run is near the tip of 'seen', so there may be breakages
attributable to new topics in flight, but I suspect that many of
them are already in 'master', noticed by nobody because nobody ran
these tests in these configurations (like "breaking changes",
"sha256", "leaks", "reftable", "asan").

I didn't look into the details of any of these (yet).



>  Makefile                  |  6 ++++++
>  ci/run-build-and-tests.sh |  2 ++
>  contrib/Makefile          | 10 ++++++++++
>  3 files changed, 18 insertions(+)
>  create mode 100644 contrib/Makefile
>
> diff --git a/Makefile b/Makefile
> index 8aa489f3b6..d0ab8fdb04 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -342,6 +342,9 @@ include shared.mak
>  # If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
>  # locale returned by "locale -a".
>  #
> +# Define TEST_CONTRIB_TOO to make "make test" run tests in contrib/
> +# directories.
> +#
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
>  #
>  # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
> @@ -3369,6 +3372,9 @@ export TEST_NO_MALLOC_CHECK
>  
>  test: all
>  	$(MAKE) -C t/ all
> +ifdef TEST_CONTRIB_TOO
> +	$(MAKE) -C contrib/ test
> +endif
>  
>  perf: all
>  	$(MAKE) -C t/perf/ all
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 8bda62b921..b07b89f954 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -5,6 +5,8 @@
>  
>  . ${0%/*}/lib.sh
>  
> +export TEST_CONTRIB_TOO=yes
> +
>  case "$jobname" in
>  fedora-breaking-changes-musl|linux-breaking-changes)
>  	export WITH_BREAKING_CHANGES=YesPlease
> diff --git a/contrib/Makefile b/contrib/Makefile
> new file mode 100644
> index 0000000000..787cd07f52
> --- /dev/null
> +++ b/contrib/Makefile
> @@ -0,0 +1,10 @@
> +all::
> +
> +test::
> +	$(MAKE) -C diff-highlight $@
> +	$(MAKE) -C subtree $@
> +
> +clean::
> +	$(MAKE) -C contacts $@
> +	$(MAKE) -C diff-highlight $@
> +	$(MAKE) -C subtree $@
