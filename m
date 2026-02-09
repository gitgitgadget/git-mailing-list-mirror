Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872825F984
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659713; cv=none; b=r2MkLD7JveGu02isxjuJtU3DRqEVVTuUXuSG/9gqN0QgjdSMthh1IpDxSKZv7xB1i+A4dOYxQXoJqEPk3es6zuUfNJV0CUVH1rqH9Qr3nh3yjTBMFrRaC81xdwmwjuXG2Ay576nAc0eFk1LfX04lyVOJzhKCMwRpbn3feo+l/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659713; c=relaxed/simple;
	bh=JC3ZVvMeJE0c5q5Qb9skhZ485IjgkS/+CzhLT2mYKtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p//5G3YHmTNXlVGzSUg6mgoxVjFi9DuRGxYHfpt2mYo8JlrhpkF2dNfrSZUMthm9zR6dkPu7WJ2yjZuAzEzQmsao0cDb1hErDuM1pPRz6z8hunss9Eyb12oma1HxpCgr+EbOkmSuxVORZfTPD1y8oWKnQEQPV4jbuGGxTr4YDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SVmQ9Ftz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Czt1VzGc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SVmQ9Ftz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Czt1VzGc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B41271D001E4;
	Mon,  9 Feb 2026 12:55:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 12:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770659712; x=1770746112; bh=1aT2e0yTMj
	du3woY2jR7ASEndsYQE6F5Ze+He7g2yzw=; b=SVmQ9FtzUvpizhK7/0L2K2mz+Q
	ml7c7h66ymF6ZsyZfZT608EvgKdgX31Z+68wChEEARySF8xeFmVwWtLRP7B71p+J
	QHR+mDhyRFSlYInlHzM5l/vgjRhvGsQAMcqzxWohtsazh3KWAdb+SnkF7ta8ATce
	KnvlzizcygWLF0FBm84XOlIgE/7eNaFCQt5SU260SLNjgBBwH3U3ap1WML05sDrS
	sJx6m+h7vDaB+NRZFAW3OxZR7Yb+fHtEe4LBiL+fEnsZl20SvDtrM9o2bg2FUVMz
	p+kPOaFG6vjfS948MIm2G+Wq0es+wQ5C+gUMkbrzAiHsy0QvQHhgF8PtRADg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770659712; x=1770746112; bh=1aT2e0yTMjdu3woY2jR7ASEndsYQE6F5Ze+
	He7g2yzw=; b=Czt1VzGc37xskNlHpo9ANhw2F57Dj4Mf0jaHovrrSTobdVRxGt9
	v1XtIUXRElFSde1DpdaUC0PeudjS+ryH9vBkQKl4ec9PaDZoO9vbWV7YOiBmzfUH
	KmonvcqmADDT5cEj2Cwd9P8cGBiR2RbNEv6BhjZRhhOTpE8lUrkWNyfQAuVk1aKY
	QQ3AgUONftzQTNwLcB5iGchd6afmcQUBDo4gCnZc3wreYie22EGKm6nD6TcWY79Z
	MrHQxhJ/diIa4Ga3Wq+R3g1bKoISdsskeOb6tZiWMY0yjtm487vyds6heAR57/Vy
	rKAv8+HNb8fJqQAEs3HMZlQDFzUl4CNEcnQ==
X-ME-Sender: <xms:fx-KaeBkZm72eQyaS2PDsOVROTU_30dTab7aiYGpTbBbb7Wkssg5_Q>
    <xme:fx-Kafjz6KHLy86hdAhOE4KOzIcAwXyN-QHWRcPvEN2ah1lrnR6ys6oLdE2wjKYew
    R1fEHfL9cFvvolNPV9PJ3tidU9_4I7nn57kmKN5eCjZ-3hddNznVg>
X-ME-Received: <xmr:fx-KaWm-6qHHoZvPu6jkhcLLI0D7zkKXUpCr3SVXszkExlte4CFArxiVDTYFDUEZr4FublZEZGORTi8YnM6QB7Hnb9SPUCml8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhu
    gihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:fx-Kabp28UdQ9zE0NBtuaS47RwrlVRhDnNPXKvwTLg2tJ_XuKZoT4Q>
    <xmx:fx-KafHeM_9pQcd0nABhF4tmjR55pR-FtHdVq60mE2mvOinNl2MLmg>
    <xmx:fx-KaXzAJBYoG2c2weI7UqE1VdnNdW3w90aiEgOF3sIbwZ7aeWZ9YA>
    <xmx:fx-KaUpw0PRkJ4X4ZWZQCkkpv6CJFBzJVE9HJgs1qeTigenNcU9StQ>
    <xmx:gB-KaejsJ0jj6ZWHvtlyT4XWpiivSBynsTW7AmsxDCLgp8AgPFsrDkZx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:55:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t4xxx: don't use iconv(1) without ICONV prereq
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
	(Patrick Steinhardt's message of "Mon, 09 Feb 2026 13:42:04 +0100")
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
	<20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
Date: Mon, 09 Feb 2026 09:55:10 -0800
Message-ID: <xmqq4inp6bup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We've got a couple of tests that all use the iconv(1) executable to
> convert the encoding of a commit message. All of these tests are
> prepared to handle a missing ICONV prereq, in which case they will
> simply use UTF-8 encoding.
>
> But even if the ICONV prerequisite has failed we try to use the iconv(1)
> executable. But it's not a safe to assume that the executable exists in
> that case. And besides that, it's also unnecessary to use iconv(1) in
> the first place, as we would only use it to convert from UTF-8 to UTF-8,
> which should be equivalent to a no-op.
>
> Fix the issue and skip the call to iconv(1) in case the prerequisite is
> not set. This makes tests work on systems that don't have iconv at all.
>
> Note that arguably, it's even unsafe to assume that the iconv(1)
> executable exists only because Git has been built with support for it.
> A more wholistic approach would thus be to split up the ICONV prereq
> into two prereqs: one that tells us whether Git has been built with
> ICONV support, and one that tells us whether the iconv(1) executable
> exists. But that would lead to a bunch of changes throughout our tests,
> and for arguably negligible benefit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4041-diff-submodule-option.sh             | 8 ++++++--
>  t/t4059-diff-submodule-not-initialized.sh    | 8 ++++++--
>  t/t4060-diff-submodule-option-diff-format.sh | 8 ++++++--
>  3 files changed, 18 insertions(+), 6 deletions(-)

The repetition across three files look a bit disturbing X-<.

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 4d4aa1650f..4dd4954260 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -37,8 +37,12 @@ add_file () {
>  			test_tick &&
>  			# "git commit -m" would break MinGW, as Windows refuse to pass
>  			# $test_encoding encoded parameter to git.
> -			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
> -			git -c "i18n.commitEncoding=$test_encoding" commit -F -
> +			message="Add $name ($added $name)" &&
> +			if test_have_prereq ICONV
> +			then
> +				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
> +			fi &&
> +			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -

This was a bit unexpected.  Do we give any guarantee to builds that
lack iconv support that "git -c i18n.commitEncoding=... commit" will
pass the payload verbatim?  I would have expected ICONV prerequisite
is used on the whole test_expect_success to exclude the tests that
are affected, not at such a low level.
