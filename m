Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA42D0C7E
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098043; cv=none; b=CpmX6SOrsrapg8l9d3EP4cHFudznytyXTVI1SBUIpo/V6JoPjlKSa1ozoorPywrJ9r8McgvAyxyU8H/3c8csgzOdq6/eCPUx/j9ei8+Qga2vtzitoraZFvwUeT2IdnsHqv5U7GObq87Ynq9INqGZ6tjVDU5jrlfu7zbdp9qkxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098043; c=relaxed/simple;
	bh=uhYHyJNEIKfl0qdNNAmxumRUrpUxDsbNTBaxHmtsb1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwJhmwRkXAneXyLe5udvPtct3c0e3SBHnvJhYtb//Cbxk/4UlMSGCppdaHRjft990A/lnqU5otmP22EcrLHIQXKOV/zr0lIvxu9SIGHOdepNL0LE7tMMO5jlmKGSRDOwlYkcgRyhLuI7tnpMge8kfdsuwKBlqN7lhH/4Bq8/jaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ogd/Y+ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jw8ixNyb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ogd/Y+ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jw8ixNyb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C510A7A0137;
	Mon, 13 Apr 2026 12:34:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 12:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776098041; x=1776184441; bh=RDlfmCNL0L
	At+xdyvsHkdLvxYctTATAWuxdjiHSAyrs=; b=Ogd/Y+ruTBa0y2QVP4UcKY2E6Z
	XCqIiUjnZ0tbBvhy5eHIU8X0pk3mfTwTQmeOVGX1R9UUl20pby2gUMzmdBp+6peG
	RCKw+XwGO49z7Hfyqw6qTw42kwdnHlxBgubD8R2XkGGaoubwpCTGepy4nq5G5fAl
	pz7mF3AkfpYYloGqkG0M8EpFlNjcH97IcaCdYuN/rjy82Zz5fRUEWzQa30OrbNDh
	ZZo6jiYc7ejx8hNB3jitAE0EkIv8H2aI2NsAIROutmLTp6gHydTIfDQH85N7pl8o
	nzwPJviaIwh+SRpTnSZtcHfy6BFEC3VzuctkuP5b9zWGIV7x6j+cSoFmo2rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776098041; x=1776184441; bh=RDlfmCNL0LAt+xdyvsHkdLvxYctTATAWuxd
	jiHSAyrs=; b=Jw8ixNybGc8E2XyeNkG/mDZJ8R8VeyqNOYKn5ZYP/JaTC+X0+bh
	apJgOo04uz7RYm/KsuuLl0qj0C5gNjdw1AJJqjENVVvsEHkM7xDLdMIcOKRUBHtr
	diQ3fqo81qHAWVK/0JTGPyjUgLqn8QfZWvnHYTguU3L+FrFwV796Qw2LcvJ4odOO
	A14a/0s4gEjYv6kMBrFOASoWQVFY+6RN7MnK8X2rS/c6djKgf8JD/odqDkxyVYbj
	rsX6AFqv4JHsfAbc9Q1/x9Z99oPBu8sRQotENyfPlnCrl0xPpOJRJnXq9AoTC1Hh
	bwhfa7D8FZ1IAkps2aEdcuJO5J9lyPyTTnA==
X-ME-Sender: <xms:-RrdaTpJ1pXLoiU0S64qyePznO5fvdEj3bTICnJN0Nbneq7BMMEGYg>
    <xme:-RrdaVFBUdHdub-x58C8P5gwmBDyuPF90hurxaTIOhvLxT3F_qB7UuKGYuKhogdQG
    G2WeXyD2BwEg3X1ygbl-o1sIWQyAxhJVFl3SOnokNhTCwX0Y2Wm>
X-ME-Received: <xmr:-RrdadmdccmHUD4uwhxwrmjHWs7j8x77xqmt1So2DkaekaIk8Pmu9qmuBQvaquFxohesFvzmRNVgjDXy2OsDGU5pkgdl2EQrIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:-RrdaQmvB3QJNqGUuSdx2E7lKPhs8hrOEvrYDw9NmcZmVxg9-g6mZg>
    <xmx:-RrdaWsYNePz-N961qvZRt1MUMBRWC5mqi-VFyz9lvrUl-qq2diINw>
    <xmx:-RrdabkIwchqCOIKmUFm067gXhyIy9k0gKkOEaxbECgzf04FZCDrJg>
    <xmx:-RrdaZv2Zc7mwxipm56GhFTkAomasWeCPXtV9UsGNwDujpnuP2UfNg>
    <xmx:-RrdadOrRNmz58fdwTz-E7m-Y5DPegjqCw7Uys1UM5Ay5dMntGUdcbNj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:34:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:23 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 09:33:59 -0700
Message-ID: <xmqqcy02kefc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The helper function `test_must_fail ()` executes a specific Git command
> that may or may not fail in a specific way. This is done by executing
> the command in question and then comparing its exit code against a set
> of conditions.
>
> This works, but once we run our test suite with `set -e` we may bail out
> of `test_must_fail ()` early in case the command actually fails, even
> though we expect it to fail. Prepare for this change by marking the
> command part of a condition.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib-functions.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f3af10fb7e..f8bc77619b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1195,8 +1195,12 @@ test_must_fail () {
>  		echo >&7 "test_must_fail: only 'git' is allowed: $*"
>  		return 1
>  	fi
> -	"$@" 2>&7
> -	exit_code=$?
> +	if "$@" 2>&7
> +	then
> +		exit_code=0
> +	else
> +		exit_code=$?
> +	fi

This is obvious and clear.  Alternatively

	exit_code=0; "$@" 2>&7 || exit_code=$?

would be more assuring to readers who (with less fluency in Bourne
shells) wonder, upon seeing the else clause, how far "$?"  traveled
and it still holds the status of "$@".

>  	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
>  	then
>  		echo >&4 "test_must_fail: command succeeded: $*"
