Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B11AAE28
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649896; cv=none; b=oMMYQlEasHn5fxKUwGY4M5AGPwvVA1Q4EeQVttJma8j3Q3kDn7FdDz2dxGL/Xp8JNHGMh5uOQ45+eGZGgxA2kzqd9lI0/ZBjWaXvRtXkuwNVBmuZ25W2/gJM4ihx2S3LuCK+KgL1LDT1YEXAUxaOsJkRl2MPN6B0USRJBaNAfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649896; c=relaxed/simple;
	bh=wJ7DJDpN4OERydasFal5N0IZzxjnoRTfXhpJ/CXn9M8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qj51QFuKfwMdA+w/LZh97FIdqz78cYHHgOqwsPyCf2yVdmP/2aCDCpSGtcMFl0gKpUrxo0FutkMI8YEXTJy7jqkPqqwnYvcOKS1MpQ4LmLuQuszKm9+XeuIoC4481qs2+gVqy/odLerR/H5DkZi4b1iY6bCpanADCjxhzYZEXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bkscmrv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNwuY3Ku; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bkscmrv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNwuY3Ku"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FA491D0000F;
	Fri, 27 Mar 2026 18:18:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 18:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774649892; x=1774736292; bh=I3Vks+2KMj
	t+Hicu8Z17kOvM1SW3OahXsdantOw26tY=; b=bkscmrv5lWrH6WDJ3EY8Th/W9e
	EK0LHM2VBuWCKdUWF5bEbtdz0w4bXv6xzJDX2GmaNqvA6Uo1VoJOPqB0eigQTOgx
	CtIJd7YmW9MM1E/L9CHOLUvjPQjEk8Paij3Yw8ZIl7SD6yUQ8KE0iZQvT5MF6ASP
	Ou3cx3TKWTAYxy4jTsgv+FjGELQRIsNwNzL6gNCS7/8jP3E8v75cCvu6HPr7HDaf
	Mx6l/bMxnnbFuf97CoyXKw2U6eajWSbbjM4exu2a1GpU/iEsIoHXanK1df1bmpdS
	DqjrzOHyJ16kW1/nNK4+8h/Nk4f7JleDFe8XKWzgS6OsM9JzpfiE1uGud1FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774649892; x=1774736292; bh=I3Vks+2KMjt+Hicu8Z17kOvM1SW3OahXsda
	ntOw26tY=; b=tNwuY3KuZPOTqUJfynjFAUc9g3S4kl8e+eJJGdvGUd/dIDlxPtV
	TqnJSnUP/obIq+Hw32gWyFkM9pKmIVuKqtcieYov+m9SC5pIqQOEd0vahgJRplV5
	Q9z+gWxi6phU6V8y9l+fh9nK8iUYtTQZvf/wFs52j1v50t32DVMwJ0ikSrew4VVI
	EXmy6VvB0WzkuvJzhOw6GSCAjGHn+yY431AiHPDPyMIRr8LAzqMZQreq4/5g9sQJ
	B4DhXQP8HVNycAG0aYoVQ4y1uw9QT6FRreeM1B8prLLCyfrkxr04lchMOrEm93Bt
	z5GcNBFHz+qnhgwkTpA2fHVaP9eyVPFeJ1w==
X-ME-Sender: <xms:JALHaVZqoiUXfzvNXrrB8GsqBP4gs8pBQgW8x0pbSb8-DCYmHA9grQ>
    <xme:JALHaeqOxotbOee4oCAh8dBOVIkHcU4RyHz0gGA8C7718KJksPv9mifKVb2AeBKev
    LHl2FW8M53hpoTcV0yZUfX_7C9T3vTBXNmO0BTMF2ktHyoC6oo7RNI>
X-ME-Received: <xmr:JALHaaPx7H4rvLEWkNBoOZ86y9y2ccfuNsU5BjLrIv_XVsgLx6Ke65pCnR4XHLoRrO0TUuraDJWa10mfKyqGX3utM1KKqx3Wvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehush
    hmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:JALHaZrC7pZviGOuwHLXvawhbDohaWbqroeF4XhucURQn6utBqGcJA>
    <xmx:JALHafcLLADT26-Jf5s7MeZZ3z0iYNegfIPdTKUiKzx5M6CGWPBSUg>
    <xmx:JALHafRhgjHo1kApv-ikfyXwswyxZfaWNay4HXQHNCF8Df2VQhlydA>
    <xmx:JALHaYZIT5H0QCD1l8ERiq-q-9zURpJ6dQACfV-U9MrZ9dh7JBEl3Q>
    <xmx:JALHaXSGpj66yHEcwXH9z0cOI63NNDRe-txU8dtIgfYoN1tVAVBGSZKA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 18:18:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v3 2/2] push: support pushing to a remote group
In-Reply-To: <20260325190906.1153080-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 26 Mar 2026 00:39:06 +0530")
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-3-usmanakinyemi202@gmail.com>
Date: Fri, 27 Mar 2026 15:18:10 -0700
Message-ID: <xmqqse9kj4rh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>  t/meson.build               |   1 +
>  t/t5566-push-group.sh       | 150 ++++++++++++++++++++++++++++++++++++
> ...
> diff --git a/t/t5566-push-group.sh b/t/t5566-push-group.sh
> new file mode 100755
> index 0000000000..b9962946c7
> --- /dev/null
> +++ b/t/t5566-push-group.sh
> @@ -0,0 +1,150 @@
> +#!/bin/sh
> +
> +test_description='push to remote group'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	for i in 1 2 3
> +	do
> +		git init --bare dest-$i.git &&
> +		git -C dest-$i.git symbolic-ref HEAD refs/heads/not-a-branch ||
> +		return 1
> +	done &&
> +	test_tick &&
> +	git commit --allow-empty -m "initial" &&
> +	git config set remote.remote-1.url "file://$(pwd)/dest-1.git" &&
> +	git config set remote.remote-1.fetch "+refs/heads/*:refs/remotes/remote-1/*" &&
> +	git config set remote.remote-2.url "file://$(pwd)/dest-2.git" &&
> +	git config set remote.remote-2.fetch "+refs/heads/*:refs/remotes/remote-2/*" &&
> +	git config set remote.remote-3.url "file://$(pwd)/dest-3.git" &&
> +	git config set remote.remote-3.fetch "+refs/heads/*:refs/remotes/remote-3/*" &&
> +	git config set remotes.all-remotes "remote-1 remote-2 remote-3"
> +'
> +
> +test_expect_success 'push to remote group updates all members correctly' '
> +	git push all-remotes HEAD:refs/heads/main &&
> +	git rev-parse HEAD >expect &&


These tests will break rather badly at Git 3.0 boundary, because the
default branch name will be 'main' beyond that point.

It can be visible in

    https://github.com/git/git/actions/runs/23667958553/job/68954593675

i.e., linux-breaking-changes job.

I think we can squash in a futureproof fix like this one to the
patch.

diff --git c/t/t5566-push-group.sh w/t/t5566-push-group.sh
index b9962946c7..32b8c82cea 100755
--- c/t/t5566-push-group.sh
+++ w/t/t5566-push-group.sh
@@ -2,6 +2,9 @@
 
 test_description='push to remote group'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=default
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '


