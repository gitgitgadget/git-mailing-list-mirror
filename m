Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D5266B52
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113949; cv=none; b=qMgDQ8mS+ITH8id+SG5TKE/Txmh/lO67vi2HCAfsVVZOOqomrLkzMeNNxKsd+SYYLdVAyJ+1DCecBt4H3QZJGJzB9USYBxpi1+c7ytjS4LsS0cUxYJ/GkOe9KoKHokQFpUll4d28hCfSvEWYkzWOgYAhh3zHhGqShfK9ZEu8hZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113949; c=relaxed/simple;
	bh=BSBvWyvYIBFOJflVBTnOZkQY/FRT1DiHE54y9dvfVJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWjpaZ3p3aixufQ5jSHnYEr0/n+86jBCBPYqSOzZ4uSQPXKP3k0FKWyTudA7dggzdxtI1m9HlW46h2etAIeK3SQG/qfSFykYo3ofXbmh0hkg4oWbF6fGD1iOlIwA1MDl46jfgIWyq6h3d9b8NV74arObwx5i39mE1pBiKb6f1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P282OV/Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iI8oEamg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P282OV/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iI8oEamg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C8AD7EC005A;
	Fri, 10 Oct 2025 12:32:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 12:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760113945; x=1760200345; bh=k7GLzx77Sw
	wU2YHh25NXU2KJgD4LR/cDOuX9r7syV6M=; b=P282OV/YP7GYZWTlV3YtoZb4HJ
	5D498Dt+XVJXGR3rS0lG0V7vK+ix6BCB1qqYvnvd1UwZzF6CHFf/Latt9usIAYa6
	TlyGMm5JV+oOw29V6TfMUmlDDQaSQHyBXWMgjbwm5RczGuG00/iOpbMMVoz9sxNV
	cWZ0OFuEiB1BBJ/H/oe4gU8w53kznx198KCL9fekWGHuyvDXp0kjK+COwTlGTKwG
	pCfimUW4mtNoxIojsBiMZNuAWHzMVBqPlOUjxU+nKZgqOpD/sncNHZHPMfQcmcff
	gGeZGlIx18I7bj/GWrIRArU+1yDz8h53kenp7GaSgEGX70jPbeNO2EJa6wQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760113945; x=1760200345; bh=k7GLzx77SwwU2YHh25NXU2KJgD4LR/cDOuX
	9r7syV6M=; b=iI8oEamgO+Yax5c77Gn1PhvYi4RQBAUBe7wHrinIeaMz43ChTmt
	pfVOz8Gc0M7SSvVfIYiaF2B4fpo0+/V7sCpe89sE3qJHNrWjOL5f2E07eKbTf/ve
	vwKch9la274sDSthM5l7EiqRMZ+Wm4BX6A4psUch/uRsty1GwirZt0nCh3Latxvv
	kIvufai+rqdJqNphHqJfm+kdiJ2nzWuG8/Mi0kIqmSaJxjk0wFF9kDhTIILm0Mio
	sbKr+tc/elqz1GIdnKv2iLbOyXe9eAVoAF1D0nQ0weO01j7PtgzST1SK5CidFOFE
	kDwpPsCnGE5NtUBVhfm+I4wVvaTd/BZcc+w==
X-ME-Sender: <xms:GTXpaNZT_FgX-iiKhG3IbpN0BME5H9dQqkZvVE6u088snD--yCFkiQ>
    <xme:GTXpaDfxcgKeLXqLn-DQqIgph1CcH5CWybXJGRM8BLn5kmLbZ2fEFuZ-aXk_tqyCO
    EykzL_5_SiRKJoUYmG_VC1MY7aWb5ILVldFnCvweIOFpaGzir-Vuw>
X-ME-Received: <xmr:GTXpaGLc6PPiHOPgAWimxArq7nZzx8AdVV_qYLSmUTFrHniPEfIVyfm55oMlbmNOunAR-AAZDfZs1uGJBeX_gnLVA6haM8DXngqK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihhigrnhhgrdhgihhtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GTXpaIL_ZqvuvqOdjgae6ORAHB2J6HjbjeV83amG8XZikIJvqHyCTg>
    <xmx:GTXpaNUkgPTt0Dem-lT7Fuu2x7aeS2Z5KjL_Y7auji9zYzaS33gJxg>
    <xmx:GTXpaJkKu8YkoDr-j0eg1PjlConDlkU9YdlRlVbn_y3_LOAfaoOxWA>
    <xmx:GTXpaLlJ-J7mtsWy4ubFTVjojG5FZxOExyGkEEDZNUSR2I2rJwQzYA>
    <xmx:GTXpaGpf4_U6lCwpTJYv7t8phiRLXFr2iQY0zolRHNe8pgppwfoXmHwt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:32:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Emily Yang via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,  newren@gmail.com,
  Emily Yang <emilyyang.git@gmail.com>
Subject: Re: [PATCH] commit-graph: add new config for changed-paths &
 recommend it in scalar
In-Reply-To: <1a88e577-a808-4815-b390-e5d2253e670c@gmail.com> (Derrick
	Stolee's message of "Fri, 10 Oct 2025 08:48:23 -0400")
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
	<xmqqecrbd7yh.fsf@gitster.g>
	<1a88e577-a808-4815-b390-e5d2253e670c@gmail.com>
Date: Fri, 10 Oct 2025 09:32:23 -0700
Message-ID: <xmqq4is6afag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> One thing that is tricky about --[no-]changed-paths is that it is a
> "tri-state" argument due to 0087a87ba8 (commit-graph: persist
> existence of changed-paths, 2020-07-01):
>
>  * --changed-paths : Definitely write the data, even if it didn't
>    exist already.
>
>  * --no-changed-paths : Definitely _don't_ write the data, even if
>    it exists already.
>
>  * (not present) : Update filters that do exist, but don't write them
>    if they don't exist.

OK, so "--no-" is not the usual "no"; it is more like "strip
existing" that implies "even existing ones are getting nuked, there
is no way we write new ones".  OK, that may explain the construct I
found funny.  Thanks for clarifying.

> The situation that I wanted to think about was this:
>
>  * A user sets the config to 'true' in global config.
>  * They then set the config to 'false' in a specific repo.
>
> In this case, the 'false' _disables the config_ but doesn't cause
> any existing filters to be deleted.

Ouch, that hurts, as they expected this specific one would drop
existing filters but that does not happen.

Perhaps we need to strengthen the description of --no-* (if not
renaming it to --drop-* or something to clarify what it really
does).

At least the configuration needs to be explained not like: "setting
it to false is different from --no-changed-paths option".  The
documentation should not stop at saying what it is not, but should
also say what it does.  Perhaps "setting it to true is like always
giving --changed-paths, setting it to false stops writing new
changed paths filters, but without dropping existing changed paths
filters" or something along that line.

Thanks.
