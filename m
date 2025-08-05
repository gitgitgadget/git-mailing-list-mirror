Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFC274FDF
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400489; cv=none; b=hsAPgFf2EhLq8cb8kIhiDq4zK5xGHXmHzAgmAJZGJ/XxIw+0VBoW/nMKs/wSCASx+sLXnhJSN/Dn+Kd+vS6FSrgsHh873+KlavKUhrChPimuqa1lriBBoA+bhUUmXUFjV0Be4iWRfDMG3MAQyd+EB34x1Ls5XxUo3VPa+6/fkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400489; c=relaxed/simple;
	bh=v1Egkt/Xblme5Fjyla3yy4tafgHvq1Q+aSuJj4Im2QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaILcdUU62oH9PfzlFVdJAoYtAq4YvanRqgmDstlFW/gaKs0ZZJeAteBMSR1beZn+5smZqrcOMb5mzxrzel6YGu6cFKexExgkNKTkWBm+tbTap1YSnC6y4dPjrfux+/QtJo/vAnrSoEBJFL6EntrnEHlQL6H8zdLpd33ZbSDvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/UdnVRe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R3383XmU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/UdnVRe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3383XmU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FECE1400219;
	Tue,  5 Aug 2025 09:28:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Aug 2025 09:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754400487; x=1754486887; bh=MSFAbWWOB9
	9+ueURPPExAko1ripbHR8h5gNdhKvnOeo=; b=T/UdnVReiqly4eHzPsMd0wpSca
	rWm2i5PvAEfQleldkC/CkZtubd3hdVXhcD5BHiOhcu6rByIXggARZJKyBYyGzIY3
	j4EFmxcNY5K6joeyjbsH647/h18pU9+FADTvRkfQ5iB0pHEG4Xp1WxMrdmQe41Iu
	ze5AvUHon7JxF0X25UOVvKUIRo3SlLwIYT70wl+mPNQTuBFmLaBv9PvOhif3i/i4
	T5Cdn4oALHEXa6Q19JAQNZBRWKwDMnF018x8jPBb+fgynl5UZLirYr1yguTs/rXl
	guwxJHserwtd5Oid9L2M2aS91A2e4I6nCQcBeH0hoVBEbVJJUJpEtCcTHhPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754400487; x=1754486887; bh=MSFAbWWOB99+ueURPPExAko1ripbHR8h5gN
	dhKvnOeo=; b=R3383XmUIcgKeezx8go5T40VRO8hKEJWOWqQQTCIAa4wmaB1kSN
	7BPNTpzALogX8soZHDlwUbIqRamyXhBAWzgIT5EYyZOdHnu3fK+XsUQEkf0HEp4g
	WF05L0MjoGKRLjcrymqY1Yzat2XFeZ55MIYz7+ipZk1ajkhtWC0QbH7YP70NIz1x
	9S0z8L6rGjw9FOYAgdaLI1MUMHeJFhCbhXvq0xzxbxfCuK0dZxRo0wrKe8LEnM32
	r+zoluLuF2jwVBRnGWBosTBzToATgwgF1EE2R+rYC7hcb1GdXFMtYjA9kuZJu/ps
	4eeQs2uk1YLK9PLnMUV/35+olH4t/O1os+A==
X-ME-Sender: <xms:5waSaHQCC44ZOFd61Iqw60YFqFctCeq2hGEpDaaYAL4YvjvsRnHg4g>
    <xme:5waSaMBLUm5Uw4ZCVIsMlpZQjq3gQkum_1nmJc9Yb03nhRB-ngKc0X-qw2efNHVVV
    qEOfHNtP8JWC6WBLA>
X-ME-Received: <xmr:5waSaGRE4yYHcfhcEk1ooRJcd6HJiGOhO8A5lGhrbUpub-K6ijXOHFtnGqRE6Pq9ZhfhTQtob9xflnCORN5Ln12wQY6BSDULQfkBbv6zHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:5waSaCpyx-yDCeo9daj81B-HvbsX2-CM3Jk5HbT0QyW3ljzaFpKbxw>
    <xmx:5waSaAzZxrYKAsX1DRB5YtGx0Q3W1CwmiziS9E-3qHYItg809D_YMw>
    <xmx:5waSaPI7jmYNJASfo1noKXu2fkhy8igZwDd83ycKt71ROpvU2DLwcg>
    <xmx:5waSaKKysfbHaWqv9pZJ0guT0Ele-0a1eweMfwOo8tkBpYzGfB_FXQ>
    <xmx:5waSaErwspxA2MEys3n3MfUQMhYi7E8QGLjTv47SXAUJB0uWxn4EwKXR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 09:28:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5fa0721d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 13:28:06 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:28:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t5516: introduce 'push ref expression with
 non-existent oid src'
Message-ID: <aJIG4lZURgqvSup1@pks.im>
References: <cover.1754300389.git.liu.denton@gmail.com>
 <cover.1754375026.git.liu.denton@gmail.com>
 <d26f355c19c59eae30143900e218533bfeabec2a.1754375026.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26f355c19c59eae30143900e218533bfeabec2a.1754375026.git.liu.denton@gmail.com>

On Mon, Aug 04, 2025 at 11:24:37PM -0700, Denton Liu wrote:
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4e9c27b0f2..c2fcfeca92 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -509,6 +509,13 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
>  
>  '
>  
> +test_expect_failure 'push ref expression with non-existent oid src' '
> +
> +	mk_test testrepo &&
> +	test_must_fail git push testrepo $(test_oid 001):branch
> +
> +'
> +
>  for head in HEAD @
>  do

Nit: I don't think it's necessary to implement the test in a separate
commit. Folks who want to check that your fix really does something can
trivially revert the code changes while retaining the test. I used to do
the same in the past, but received the same feedback.

Also, I think we can drop the empty surrounding lines in the test body.
Other tests in this file do the same, but that is not a good reason to
not do better for newly added tests.

Patrick
