Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57815CD52
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353951; cv=none; b=nn7tv/hZVXfBz7liAggzSwCW3mZsFVfFdgk1zhUfICUxpFIkZ9k7mmlO/X8i7dGVA/rQoO9LzrvZc9HO3nH48/8clQUnqNoPURjd09+jbkHWtonaSO6T9WSQsxi8z4I6grD6yfuph631AD2OoSfFAvHaYGXUcBl72G/VX6ppMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353951; c=relaxed/simple;
	bh=ZHjji7nsQQJ9jRVjNtWH7dDlP4ak9Lh8VqCQieEPCrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZbPJmMePp26s5SPZeWrQpjv1Cje2aK84U0JKaEibqWDwuQdkuSdSxZLEVJnLRG1eF42rpyS1OHhB0e9BF8eSx/v/mrVh4X8I6RPzIDJXEt/96BSB2XMiFQKY5aRf0p0VHQz8bYx+YX1+madNmTOtZ+aayHse5sS4nDoBvfCoVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VESyf2hS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6Jm0wQN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VESyf2hS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6Jm0wQN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 935AF2540162;
	Fri, 31 Jan 2025 15:05:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 15:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738353948; x=1738440348; bh=guYUlAN+1G
	MzsnrprX/TnUGKvoFSmkLDB77AzXdFcyI=; b=VESyf2hShup6LwhDqQXdK9fByB
	uaFhzuqRv+4HrTVazw3hRyLbiCo9oESQdygCbnbKHU4aXxjZ/oxFCDIwfL3pr5me
	MtH3zaeGU85wX6ON3qshYy9cuVivk8Ipij8DWWwqk09kHxjjmVsVIhwsjc1FtcG5
	mHPCoKE2zWk3j+fJ9uO4VYc5jxyC4Y6FgIzprAmmWYH0szPKFdL4GQ1LmVcHjMTW
	dVTXWnsI+sc29xAeNnh5vWySGgMAMbb45j74sHMNoP3lwngRBDaW6P+k/Iyd3ELz
	jU3ksZYhpFA7mOEBRJ0jQkQrhWiANAKxNdLLA+i66WiE70D+i25zpEhekPOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738353948; x=1738440348; bh=guYUlAN+1GMzsnrprX/TnUGKvoFSmkLDB77
	AzXdFcyI=; b=v6Jm0wQNQ42t3LGLK2/LLlNNVMU/MFLQMMDrUnVMIZUOgdR4fzC
	J5pJw9sAp4Zeq9BTD8zb8o56MJvjgQp4zzf1Xi5TnOhNLfV43vsFp5Oyg3GLHEmw
	z56V6rP3UqhMthQpviymgSm+d0QjnkDTn0XEW1+iSOUwg1SfRSz49f4j8rRLE28x
	myzwqJwe6bq66Qy/ZENpwMR6w7H/3CelfSEGkaOQaQpauQWJMSsSFx9KUKhReiPG
	kL1kZ2EcRmyhq55IrVsd+BjLS/cUV+QgzfNJZMLCfbrNk6/lOrDPvegxro7siAdK
	CZ5fm5yzgeLODvsQWqJ419UtVcUNkU0fbOw==
X-ME-Sender: <xms:Gy2dZ19RJCh-Y6YlVE01yJfE1tgeWescP7UGWyDidLx5Hufbvdgy_Q>
    <xme:Gy2dZ5sbHGaiFsr54GizSiZ1TSx7TT1txg_CpQW2F0uzR-o9ZqssrYV1WIbj6qTBm
    4mYRBg0_X4RnikhbA>
X-ME-Received: <xmr:Gy2dZzBbCY_gNtDYnZLceDA12CCETpcRwRfmpqPLEOYcroLOJIDZy8KDxcGUXz4UU20tQqJ85SS_kTlSkUHdnSwhIxDU0kxQnWTq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeljedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgig
    sghrihgughgvrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HC2dZ5dfDEQKiOmYih7sCrkN90btEfEc55cAlUra4z31tMsUBXOXRg>
    <xmx:HC2dZ6MhnmS8YKZEDKpiCUJaQC3Emhwm62PZHf_lN3tJvO2acrkAGw>
    <xmx:HC2dZ7lgt8Ya7QOFZxz_HJFMl06XtBro1qQ0yYf-CUBxbgzPgj0gnA>
    <xmx:HC2dZ0v2I2jkDMVUIZxPUhHTHH76CHu4_Z2U2w0iRHYFc_38-wyAOw>
    <xmx:HC2dZxqUZG02r1gt5xxpG9uJpyft-_a4uvfwNcWwQBnrsFUp6CDtC8iC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 15:05:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,  stolee@gmail.com,
  Johannes.Schindelin@gmx.de,  peff@peff.net,  rsbecker@nexbridge.com,  M
 Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential: warn about git-credential-store [RFC]
In-Reply-To: <pull.1856.git.1738352886190.gitgitgadget@gmail.com> (M. Hickford
	via GitGitGadget's message of "Fri, 31 Jan 2025 19:48:06 +0000")
References: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
Date: Fri, 31 Jan 2025 12:05:46 -0800
Message-ID: <xmqqlduq7nqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> -	if (!c->password)
> +	if (!c->password) {
> +		if (c->helpers.nr >= 1 && starts_with(c->helpers.items[0].string, "store"))
> +			warning("git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7).");

I have no strong opinion on the details of how the detection of use
of the "store" helper should be implemented, but I recall reading
somewhere that users can configure more than one helpers and they
are used in casdading fashion?  Insecure helpers may be configured
to come later on the list, so [0] might not be sufficient.  A few
other things are that git-credential-store could be installed in an
unusual place and credential.c:credential_do() may find it from its
absolute path.  Also the end-users can use third-party helpers,
whose names we do not control, but presumably they will not name
theirs exactly the same as the one we ship, so starts_with() may
want to get a bit tightened.  If somebody writes a custom helper
"git-credential-store-securely" and installs the binary in a
directory where "git" can find via the usual GIT_EXEC_PATH mechanism
as "git credential-store-securely", helpers.items[].string would say
"store-securely".

I agree with you that it is a rather unfortunate layering violation
that you need to know what helper would see the result from this
function, because you want to warn before the user gives the
password to us.

Warning immediately before the bits hits the disk platter (i.e., the
result of _fill() is passed to the helper) is not as secure because
there is no way to say "ah, was I using an insecure backend?  Then
please stop and do not store it there" later, so I do not think of a
strong reason to claim that it is a wrong place to give the warning.

Regarding the warning message, you may want to consider using the
advice mechanism for a thing like this, perhaps?  If somebody has a
legitimate reason why they need to use and cannot move away from the
backend, it does not help them at all to keep giving the same
warning() they are already aware of, without a way to say "Yes, I
know, I've seen it enough times, go shut up, please".

Thanks.
