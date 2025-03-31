Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29B1C173C
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406044; cv=none; b=tFg5rKuDyJjzgPUKG0udX2Ms86kzRyUDcKFtDmv25o642urzg1RE4kBKJ/rUeL3NX9k1mVjT9pnAZvP1bM2yyfqNUEYlXoC0YsuCcd/fa+v3b3iliAQVQyOi9BAAq1TVNbpwKR3LnptCiKqNoTUVpxufaG8EwwYxIp7q2G9o7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406044; c=relaxed/simple;
	bh=oDBUKUmj7ONZqTOFpMwz4TWmM3cE7LCpkT7URGjUhL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T15QF2Q6X6tcuRmeZbFcQnxXvE5SQgYfOSMgIGf4iSae7b1kjcP+ynn00HsrjdjJhS/KIEQA+5dywUUyIb2qjg2pkbqcrqTVJYNcVzAAd616n30/DU7ns5u2lpY2ChwxjuSAOlBbhnPozVeGe4YBbwQS/+xSlENRVTfXFbcbPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNSg1TlF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lcw4X049; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNSg1TlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lcw4X049"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48B8B1140192;
	Mon, 31 Mar 2025 03:27:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 03:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743406042; x=1743492442; bh=lJb1pVpDAo
	bGN5pqwfu2KBl8m+pk2ys4IlSbdEGvKmA=; b=UNSg1TlFRCSDihlKgKaL7o9ILp
	S8mnGyVhonRYZsP6ZI49Cyz7UnCzCfZSXgdvpudGdKbXkYIsYbMEFHu7RTQaukMn
	FCyLGFy/J1YRce7pigpujHSVkC6n2ORWV374+UlVQnqD1C0qPmCl02YXIx6FGw6F
	0l6qsIUgLh0xC17EZTb8zPbwrb5zx+iRAAEJI2fySPiSd4dIi0RGM+AhmjGDDkgR
	UgdgKaUM1cHR0A5fxY/jDkWkZQEQPJwV1jAeSzkeQHAn6qBtc89oYxxcP5RUmRvq
	ie83kpdWXW0bLx/gUMRTrE1IzaBx53QQUNoSdW1EseABS9mkGH0wdZi3KRag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743406042; x=1743492442; bh=lJb1pVpDAobGN5pqwfu2KBl8m+pk2ys4IlS
	bdEGvKmA=; b=Lcw4X0499n92DIhiDydi3oCZmifuuuU8Azj4jmjXZyQpCnHinh9
	Pdbk6WQ+DSGVFBElY/prZa08B3nrBULq9kpuSKDQU1vL1uVZlsBYLz1lSDNKo8Y8
	FK48gxfyF6BW68pu/iuPukEt2xBvq5tpbZv48bTOQXz0LfCqj9qdIdd8gfK43Ytn
	cFXDW/KDhHevKRWFN0sAE+wadhX5k+28wPC7vDaVRPeaXwO/SZzbFAeq9Rkii+/A
	8I89Fd2aEvap3ROxErOp2Q79sFbrBMyvjhj7blwxHvlM6PlcOMtF/LDAPsh6/8Yy
	3V0XJ4NsX1DSDpU67tHhPYppAkQI6p415+w==
X-ME-Sender: <xms:2kPqZxn7SuRh4hc4F65uYAAUZAWzZEP0CZUudA25z4MoZuHTzO0pxA>
    <xme:2kPqZ817hwKXDwrFMmj1fEz4pc0fQ4XOdGzcYp-bXusM0q_7RgBVqezLgWRtEEhs1
    eIbQiDb4Nqw8mNm9g>
X-ME-Received: <xmr:2kPqZ3o8RqvOs9BWp49aWUAWclnx6_N8jNAma3626j62t_ioHgL_F4bNGp_PlwRJwmn4ogvvk9ll3AX8GoyCy44cntnUpAcKSHNz1L82uEiD1UYt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepnhgvvghrrghjshhise
    hmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgv
    sghlrghinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2kPqZxnImNhz89V5_T7mpkU1vP4MtCPTnZKwQsaQH-Hl3uPjCnfkEw>
    <xmx:2kPqZ_1sI94Ou-jEKNe-qYpYL3d9onoyx92RzgsGp2ZKg9vRSck-UA>
    <xmx:2kPqZwtSI8mkXCW22jsNrfkhQT-IF7O5EZIHUHO70o2FqaVazjfskg>
    <xmx:2kPqZzVigf5aOaNNF-CUJ6a2yvWX1mIN11rHLWXSBtAjKrk7Lz6zoQ>
    <xmx:2kPqZ_8N4s6eC-VlgjbjWMQOQWNu0uByd9PwFLp3uHeaGwVNeNZKkkGa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:27:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93ff38b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:27:19 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:27:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] p7821: fix test_perf invocation for prereqs
Message-ID: <Z-pD1puYT87YKAd4@pks.im>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
 <41a093d570a5756f730b069980edafbcedf5c8bc.1743181669.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a093d570a5756f730b069980edafbcedf5c8bc.1743181669.git.gitgitgadget@gmail.com>

On Fri, Mar 28, 2025 at 05:07:48PM +0000, Philippe Blain via GitGitGadget wrote:
> diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
> index 61e41b82cff..1d126c7b039 100755
> --- a/t/perf/p7821-grep-engines-fixed.sh
> +++ b/t/perf/p7821-grep-engines-fixed.sh
> @@ -33,13 +33,13 @@ do
>  		fi
>  		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>  		then
> -			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
> +			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
>  				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
>  			"
>  		else
>  			for threads in $GIT_PERF_GREP_THREADS
>  			do
> -				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
> +				test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" --prereq "PTHREADS,$prereq" "
>  					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
>  				"
>  			done

"$prereq" can be empty here as it depends on which regexp engine we're
using. The second case you adapt already looked weird before because we
potentially checked for "PTHREADS,", but the first case was correct
before but is now potentially checking for the empty prerequisite. Does
that actually work as expected?

Patrick
