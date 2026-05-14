Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32E3B582F
	for <git@vger.kernel.org>; Thu, 14 May 2026 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793992; cv=none; b=BgiHYuehA/xxRsFF3HcVSXDN8TnYWA6ThTdTIzgh4HempmrOJwpIW5zjWSCo5QNFtjMC5kFds8qq47ANZJhzjcNama+jvxjXM6LcYLWYcSymjrHFYL0jFoxiBaDuogzXIh73g7HiiWF+9eGkLMQSWNzjOD2Ik87CK13AAgkASl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793992; c=relaxed/simple;
	bh=cXlX8X3e8z/caDnU9MEt3UwfwWIF+do/H02qyynMP9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rCVLZds+m/gfQ048ufoUpVMsO3d9cPjyHBxp+TGszXJ3nF1pQ9qUA59OxsKp6/mmVq4b42jwk8pPtP12N3n2HW53tEarw+MBwq/jSW7nqKE4VF4USc2vf1KwjqWFoLPoBKJyv8525BKjhFl772evMQWb8TpKEXZOlY8zJE+t+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NTZztF2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJiSwDow; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NTZztF2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJiSwDow"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AB8FEC008E;
	Thu, 14 May 2026 17:26:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 17:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778793990; x=1778880390; bh=ovF633Ruvo
	ReRKBn/SM716wQPQM/oQ3HX5amwDNu2Eg=; b=NTZztF2sCgtpaFjMy2HZbNghmF
	sWdsMPfTShRvp38vUUIxb4wJXbP38Y7r96WY7lFMFs0upWOl5OeqZi7XQsjqxcYQ
	YJFMurdI+NmigtMpxeLov97vMA87nyjTZAvdHZjqCuDjYA3gzJ1mSQ5SlparmJ7h
	qPgpJHKFJ7EtJngKW+3o6FTo4K7qaK5dbUOPTyJH+KsFE7DbN2xiC5OlE7h1kr6Q
	+bQk/HHf60kuk1kuVxW15XQV6cXkV7Ej+LODRSD6UgRA5pny8H+m6nP2eylwGOFt
	kher8+rFjBYT+tjPOzIaJ5GwbQEw5vwvCBx5+erBGqFXUIISlnaQL1FE4ASg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778793990; x=1778880390; bh=ovF633RuvoReRKBn/SM716wQPQM/oQ3HX5a
	mwDNu2Eg=; b=uJiSwDow8r5FxSUeNu4+6dM0D7uYI6tKay5egvCTrOfjRmJFYIm
	6/b9V8FuWu32Fl6T4UX5EOh5j6NtFq0YMvxVsuJVzUggolKj00fEBVTKFedJArr5
	UXIMJr6FfR4xlxC4AgcuSYQ3yeG/qDkj21GybN3scaqG/+UC8NNkM6UOjMPgk3On
	1JM5s2GomIcGD0xLBg7a0qMluPpV8YOvHkhalm4ihFhmRyzfj4mTuZjhtf2MFDxM
	3pK4U7xn+GeDTNytXGfiCIGLdJ/iFzKZWXs1y80zJ83EDGhhZl1dyYZuH7PNX70n
	Xxl6eugzj20+sEDsZL8GccYiaGYHFUCDHLQ==
X-ME-Sender: <xms:Bj4GavIyaFt9lh9F4J7qBYq963lKy__7vQCpEkEcUsjojvgTHKzMkQ>
    <xme:Bj4GaqLdab_13quONJKOfjPhDfAa_JQHZ5APM6VRhKJGgevTqRQay6Bt8pK9p2AHU
    xclMBFkk0XC3I24ddMTmslVmn1Sq3bUuDug3huBUexcvxXoBLLeow>
X-ME-Received: <xmr:Bj4Gasv3dNjhmhRUoVb7OQiZp3YY3-TMUWktT4mvliUGRuUokq1RUnf3DfyuP6G1yC3EEG_VK0GBbcborDCvWSGAchVxalv-Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsvggsthgrrhguihhfsehntghfrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:Bj4GanTxsZK-PGDkn2_HSLrW3f7V9uyc543cDmq3BLRCkfCuQFdgdw>
    <xmx:Bj4GaiM84zAi5K9w4h1lgMXSS6D7dWKtkwgLicu1aZFqJm-Gui3knQ>
    <xmx:Bj4GasZaohHFal2WE555h7SJgv6Dmjh-L_xqpZCYjl9Mupojt9bI9A>
    <xmx:Bj4GasydIUrHdOQ6DddlQrDxfzpvRNB85dYryxgdnCXrOzXddSq3zw>
    <xmx:Bj4Gajm5d50QFMMM2M58KvPRWpTKaLJev_mEdqPNyxjrkSnev7RwSAdf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 17:26:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sebastien Tardif <sebtardif@ncf.ca>
Subject: Re: [PATCH 1/3] daemon: fix IPv6 address corruption in
 lookup_hostname()
In-Reply-To: <b2d81438117a716417a031c74b678a8f91701af4.1778773592.git.gitgitgadget@gmail.com>
	(Sebastien Tardif via GitGitGadget's message of "Thu, 14 May 2026
	15:46:30 +0000")
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
	<b2d81438117a716417a031c74b678a8f91701af4.1778773592.git.gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 06:26:28 +0900
Message-ID: <xmqqmry1el8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sebastien Tardif <sebtardif@ncf.ca>
>
> getaddrinfo() is called with AF_UNSPEC hints, so it may return IPv6
> results. However, the code unconditionally casts ai_addr to
> sockaddr_in and passes AF_INET to inet_ntop(). On IPv6-only hosts,
> this reads from the wrong struct offset, producing garbage IP
> addresses.
>
> Fix this by checking ai_family and extracting the address pointer
> into a local variable before calling inet_ntop() once with the
> correct family. Die on unexpected address families.
>
> Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
> ---
>  daemon.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 0a7b1aae44..80fa0226d8 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -674,9 +674,20 @@ static void lookup_hostname(struct hostinfo *hi)
>  
>  		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
>  		if (!gai) {
> -			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
> +			void *addr;
> +
> +			if (ai->ai_family == AF_INET) {
> +				struct sockaddr_in *sa = (void *)ai->ai_addr;
> +				addr = &sa->sin_addr;
> +			} else if (ai->ai_family == AF_INET6) {
> +				struct sockaddr_in6 *sa6 = (void *)ai->ai_addr;
> +				addr = &sa6->sin6_addr;
> +			} else {
> +				die("unexpected address family: %d",
> +				    ai->ai_family);
> +			}

The previous iteration used to more explicitly cast ai->ai_addr to
the target type, but the use of (void *) here is a cute way to make
the result shorter, which makes it a bit easier to read (it may take
readers a bit of practice to convince themselves that this type
conversion using (void *) as an intermediate type is perfectly fine,
though).

>  
> -			inet_ntop(AF_INET, &sin_addr->sin_addr,
> +			inet_ntop(ai->ai_family, addr,
>  				  addrbuf, sizeof(addrbuf));
>  			strbuf_addstr(&hi->ip_address, addrbuf);
