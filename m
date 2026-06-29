Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E241C2F6
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744004; cv=none; b=Hv7yGbipTAtCMMVtnzjEVu5v/NYiB7v+JfOKHQsxtNPrjTeoWQ+IECBifmG3HbqUZAxdyJTmRBB9cQHFM1SYLdOqx8YRWd+fa8zv95ubwxLL0V+113DQxrmrfOYHa5+Sp+UOUU2tbxgcd7MG+02vzv7faf5HtwC7SiVLiwDaXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744004; c=relaxed/simple;
	bh=59jUlPgHpBYZxTGLSXhgOFdYqUfjom0LgOI4dU4i8Rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZlYQMcyFBOmJQ76JAUuzaQllv1G5+McsZd+TctTIFhJkVdO3ysdmuvvx3EKPkC01yNUcDz2jZIBAr1blCaeC533BIY7VbI6q4DkeTaijSStYIKWfQWhxCNpkwd+z+26oGZqePnJrjEuKcpL1j+GvS4zBv6WXTK75y0Xa+WYN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mrQuvkcl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OdG3WRIX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mrQuvkcl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OdG3WRIX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AC951D000B1;
	Mon, 29 Jun 2026 10:40:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 29 Jun 2026 10:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782744001; x=1782830401; bh=l56Xc4dDQy
	q25tNO7oJEMizd8nrtSS6lAvbg1xMX1uA=; b=mrQuvkclHWIPSLUHG6xT98f+8S
	7Bko6nBs2TGbq6yKcXnFYvWjjPAxAxX98pCsNdbs3nJnTkzUqAw/PaRicuZfvae2
	Sx6MrmsCbz+5yy3cibn5Xxud/4VTEfxQV/a8E+eyigiN0m7F8EL14IlcaUL8BMgv
	Rexyzn16GTE+xyO2Te6Pp8RsMSb1SJ0azZmSs5lVn0vvcKi1Vnk3AdMrCY1SrOVV
	MJg49auFc6k8xS8N71fbkyAiz30UxO3TxN3gamM/YBdAh4AJpq5K3VgzoUuXaaTB
	oHhSoT8GMca+EkzcxjvOqav1IdAUIotiXKHdl+MKQ5tpSmnf+MDqPcoXxGQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782744001; x=1782830401; bh=l56Xc4dDQyq25tNO7oJEMizd8nrtSS6lAvb
	g1xMX1uA=; b=OdG3WRIX831U66BWi5ptDK/M3njAURdcVRHgfm/pXtLziYa22vw
	j5Ne2MV6H7ZXrnTyrljypnspoUdrUwu55xvHQooamzr137CplqmnAjc4LoibRve3
	RL7oQ5486Bdd3Hcx8gU7W+EsVw/MB2MELKYnBZ6oL0UTZ45fgg3MQ/eKthFwDfF5
	irX2kHEgpuzKnNEtHX8fxUqESJUGNoXBqkb1H9hIuCgBVHL9wx5O+3IB86ghKizb
	dPyhVaN+9PpDGByr5E07DinT6XDhcfbnrF/p11+jZDXgwy5qYtAdOFP7AHUnQcvG
	x/4VSwdgB2YjEXjm/qqgTX8D6O6BsDomWBQ==
X-ME-Sender: <xms:wINCaocNxpyzJetBr1ZYo0cU24D6HdPQ7AisRekjKWf-Ge5e8iZEXw>
    <xme:wINCahHzG1Z3CQ5JLyTxBO_uxudWnFOozpqdwUqGz-3wKrzS7HaUw0YtTJG6-KGU9
    QYj326rcq74oYLCE_nKdXiRv0BVzKu5fHAC8ViC_rfUg6gaMMCdWg>
X-ME-Received: <xmr:wINCah1XBjuUz6rrYDe_bDkh2Kt8F7DjRIVm-vf0vxLs-GDLBsV0p5jTqvYP3fdWqYNvfZNpqoGYFb9oqIIYftjkichhZS4RgoDDgbU>
X-ME-Proxy-Cause: dmFkZTEgPnii+2E6G+597JgNtY4m0Sw6m+MCDQ3cH6GCfYkGU1ycvrCfbyPh94aHI27eYu
    yDijpOyOxGK1zupOmAxxWnxtA3hpejZT/Xd+Mo44m3kSOnvdbJ4cL6KO6jchbZwoFEFyQn
    PLXOg9EeDX7NCnGHvmkaIsLxKhVB2hCgMm4MUTXjmR1EyW0xUbFQsakkjNIE7UF7j887pj
    nHLKQhkZFKnWjTIxA9EdUr1ZOmOE3fHfYSWG/crdUWLbL/CJ2j23VWEDsjV82tqlIapVXq
    rWyTnotRtJdx90rvSl6hHvNNMqr8R7TH21Iv9zpq9fHsR46IizfqDJxsUN3UgEEEdw+DWh
    rWogb0IxBFnbDQSwCgJa3R66DbuDlf3ip7MCf8/mO9SmJs3OkvQymb4ClV9ORVFOVAAD15
    +2bzb19ormYKujufyUtjzgV/MOLv5S4cTZh7bmRB7b9YvXZ3EYGIoC2rQ4EiN0bc5ByF6R
    PHUp4/G+Ip5OE5a2jxzLdh/ji9aUCPyNAAkQb8ytDuxDBcfZxe5wg/aSmaRUZncOQ3+U1N
    18tX1qdAyuoMSv6QyFMnINZuTd8RITg75fB3ixtz6pCkWv0oIh+3WCsxlFhVtvR6jP/eyG
    GGVQeRZO31jnPSXlk61kbWzpqluuqPZ7I+Jx5puSzYDgQNhofnYcmyT3nQkA
X-ME-Proxy: <xmx:wINCaplPVM685UYlJDx5M250tbudAenfIjz8b1H7Pk9RndF1PIFzHw>
    <xmx:wINCah8Xi91BrT71k8b1dhyY3jqpQ1AM6PiYZQqvs4XL7j1xIM_LNA>
    <xmx:wINCauoLj4FKdeB4MyFP-dFXo1tgM9U-tajz011FwzS9srBURDHGBg>
    <xmx:wINCaqmWjewjGWfNju01xLAYtGopa4WICI5Qg7dBsHktXkUWHPZEpw>
    <xmx:wYNCalhuX3VrFaYf3Jmamd3tQ06n2f_gNCVUga7ZRWar6kaD9vSB76uE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 10:40:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Michael Montalbo <mmontalbo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
In-Reply-To: <akIfsaVMB_S6kfJQ@pks.im> (Patrick Steinhardt's message of "Mon,
	29 Jun 2026 09:33:05 +0200")
References: <20260621213407.GC2297179@coredump.intra.peff.net>
	<aji9MOE-NTHKXYqn@pks.im> <ajkEzhdqzmAePk_P@pks.im>
	<ajkGkB2ckf3p43QR@pks.im> <ajkOoRhqaAcy6gBg@pks.im>
	<CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
	<20260626051657.GB3138423@coredump.intra.peff.net>
	<aj5ZaZK7xylfs4Xw@pks.im>
	<CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
	<20260628075716.GA3525066@coredump.intra.peff.net>
	<akIfsaVMB_S6kfJQ@pks.im>
Date: Mon, 29 Jun 2026 07:39:59 -0700
Message-ID: <xmqqldbxz9z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> By the way, the only reason why we at GitLab haven't been feeling the
> pain is that we only enable GIT_TEST_LONG for GitHub. So I was wondering
> whether we want to have something like the below patch on top.

If we can afford the cycles, it would be good to have similarly
larger coverage on two different platforms (compared to leaving one
of them not doing as much as the other when we know it).  On the
other hand, if we cannot cover _everything_ in one platform, it may
be a better use of the resources to have the other platform things
that are not covered already.  I see that among different pipeline
sources, we are doing TEST_LONG for pull requests to any branch, and
pushes only to "cast in stone" branches.  If there are other
branches that deserve to be tested with TEST_LONG upon other events
that the existing GitHub Actions CI does not trigger, it may be good
to have GitLab CI cover them, perhaps?





>
> Patrick
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index b939110a6e..57801586aa 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -215,6 +215,14 @@ then
>  	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
>  	CI_REPO_SLUG="$GITHUB_REPOSITORY"
>  	CI_JOB_ID="$GITHUB_RUN_ID"
> +
> +	case "$GITHUB_EVENT_NAME" in
> +	pull_request)
> +		CI_EVENT=pull_request;;
> +	push)
> +		CI_EVENT=push;;
> +	esac
> +
>  	CC="${CC_PACKAGE:-${CC:-gcc}}"
>  	DONT_SKIP_TAGS=t
>  	handle_failed_tests () {
> @@ -239,6 +247,13 @@ then
>  	CI_BRANCH="$CI_COMMIT_REF_NAME"
>  	CI_COMMIT="$CI_COMMIT_SHA"
>  
> +	case "$CI_PIPELINE_SOURCE" in
> +	merge_request_event)
> +		CI_EVENT=pull_request;;
> +	push)
> +		CI_EVENT=push;;
> +	esac
> +
>  	case "$OS,$CI_JOB_IMAGE" in
>  	Windows_NT,*)
>  		CI_OS_NAME=windows
> @@ -319,7 +334,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
>  # enable "expensive" tests for PR events.
>  # In order to catch bugs introduced at integration time by mismerges,
>  # enable the long tests for pushes to the integration branches as well.
> -case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
> +case "$CI_EVENT,$CI_BRANCH" in
>  pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
>  	export GIT_TEST_LONG=YesPlease
>  	;;
