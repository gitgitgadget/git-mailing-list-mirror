Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68D2C375A
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867908; cv=none; b=oedwbsvX5V7KstyvCaKd7FHbk5GDV2gMATLWHf8LvgdTI5KI5P7QefEgq24k+oJydM58ff1exf822dZOdjJRehH0Toj6GC/Shp2YvxLl4ROjDEJsKtpWm1VhNhaI36VgIFZkb5TQ62ayiKiQOdA3xiLjrwc3vFhAqew5cxAUOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867908; c=relaxed/simple;
	bh=u8GfieSJ/GaPwhCtkSrOHYDOqxZMOw3WIRSJP/tPzWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oNd+moSgwQAKWZ4wXgINfCY+KwmCwPzFQilHbXK/VJlt5RWOH7QB0MoqnNtrtkUu5tuBwK0/a8d4aI0qK1F2oYCRiSOFEDGIhJGNrAEWfpF1e+a5oyziTaRtQP4G2pqLa3w6cSo8SuGnuQYU1idwZO1RrYz6RVXCzMeNVZL5LV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qax13qpb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9DlZ3ZJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qax13qpb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9DlZ3ZJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 34785EC00C2;
	Wed, 25 Jun 2025 12:11:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 25 Jun 2025 12:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750867906;
	 x=1750954306; bh=3ZMHQrdpeIbHLq/O5rB4HoqJi7W+qc4tAXjGzzMWthY=; b=
	Qax13qpbJwDAbIvk5R5hYATUWY88FPYG3pV7PdDoqsCTYNWhqygjfnYQllpyvd78
	QA9MT+SCzmaq49aAZirSW8VPlzXPbmo4e2ALFx4PZSBgAHvHU5YO7kqltLJTq3/7
	eu6rioiKVixmy6zouK/qOJJkPWZKcf9TG9xxHr86MTra+3O+JImr0IDZFwE7uAkg
	YyUZVHLGg7wHoAMm5qmj/giOgtn9E8NaBj++FiWjPUbBdTvFvMXqqOqbAOaX0CYF
	oT/Z0KVZUDK9if7TneoAFUncR36FmanP4hgR8B04EAzhxs7INLjYwh9OQ/MC09RE
	aU/o1BU62EpR8cYshNIEVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750867906; x=
	1750954306; bh=3ZMHQrdpeIbHLq/O5rB4HoqJi7W+qc4tAXjGzzMWthY=; b=C
	9DlZ3ZJgs+OjvfnptUT1kO3gmDZymfA4uMtgreICx76nPyxqhtRw2m9e9nsz//Py
	fgvFqgahMH/9cTkB7feZzZpRvTiL86cNLS0kQ22riO1kXu5mPgrTbft+K9EehR9i
	Dm3t33vc7qxJr3+ANvQMPkiRkmWiAzRPozsZAeeaWLCpTnqyA5yvffxGHRHC6U1c
	V3kfa5fmcV4HymxGzIik9sDHmIsrDPJjK408F6zle43xrQl2MQA7GP06BKxlI2k8
	XMFBo+l9Z8t0JOMkVC0n0G+U2TxUqUyEt26qpUPcL92RKxAgjZ2+ilB7DAloGZnr
	6hxRoaPRg/gixj9K6npPQ==
X-ME-Sender: <xms:wh9caHoMV_K6g8p0TdCYOfxG40XT3_T5BCU3q7Cy26S_9C21J9vFPA>
    <xme:wh9caBoItPi4SbPVhY4k6HsY9JDQzMNxSxq7T39cujPojfLkHO5PkryozBZB8dPMP
    YdQ9uFxTNyDgBLOow>
X-ME-Received: <xmr:wh9caEMnR5_8PMm4krzrIYTETAQxytmuKuvlyIRSD-Bs_6O1D9k5wRpWBWiD5iqnhwfgtrQEE2K7ZMrhCFDSAU5KfYROpXB3DIPy2Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:wh9caK5VOU_PaWa0VHbESyh5ugWl_Wb-LmNcnhgK5Rw2LM1kExciwg>
    <xmx:wh9caG6TD1sv0Amqt4kZ6ZdL3C8waiqeLKg1pi_kURc8tvGlfqUmlQ>
    <xmx:wh9caCg2ZZLXgWt9N96uQm5TqCf6ejzPzpIBR_501rDi0CW6fIJCyg>
    <xmx:wh9caI6QPVPQRkDKVymK1R9rc8UlxrEYwMvOx6yheWtmXQ9h_4zfnQ>
    <xmx:wh9caPZnxEf7kjMeH3tOnfpmqzOhBu7JApTx551STQG4mHeh-lUHA3ov>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:11:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 3/3] daemon: explicitly allow EINTR during poll()
In-Reply-To: <b737e0389dfc280994e118736bf4452ed80ebcd6.1750836928.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Wed, 25
	Jun 2025 07:35:28 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<b737e0389dfc280994e118736bf4452ed80ebcd6.1750836928.git.gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 09:11:44 -0700
Message-ID: <xmqqzfdvx0lb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>
> If the setup for the SIGCHLD signal handler sets SA_RESTART, poll()
> might not return with -1 and set errno to EINTR when a signal is
> received.
>
> Since the logic to reap zombie childs relies on those interruptions
> make sure to explicitly disable SA_RESTART around this function.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  daemon.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/daemon.c b/daemon.c
> index 8133bd902157..01337fcfedab 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1133,6 +1133,15 @@ static void set_signal_handler(struct sigaction *psa)
>  	sigaction(SIGCHLD, psa, NULL);
>  }
>  
> +static void set_sa_restart(struct sigaction *psa, int enable)
> +{
> +	if (enable)
> +		psa->sa_flags |= SA_RESTART;
> +	else
> +		psa->sa_flags &= ~SA_RESTART;
> +	sigaction(SIGCHLD, psa, NULL);
> +}
> +
>  #else
>  
>  static void set_signal_handler(struct sigaction *psa UNUSED)
> @@ -1140,6 +1149,12 @@ static void set_signal_handler(struct sigaction *psa UNUSED)
>  	signal(SIGCHLD, child_handler);
>  }
>  
> +static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
> +{
> +}
> +
> +#endif
> +
>  static int service_loop(struct socketlist *socklist)

OK, this is the answer to the question I was puzzled with while
reviewing the [2/3].
