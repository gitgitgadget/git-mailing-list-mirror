Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA001F4613
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037063; cv=none; b=hQ8p9nXVoK+ybbNUtFlpr/5w0uDBkXrfSinCKTHMl+gyYW54tVuNYsjjMoSFHhDb0xPbhz6pYmvv1Gi1m89ExvHTUQVboBdx5/rcS4sNuOVbDwUZkWg2TjbAVFXRRwD7MVbWAhmtG+FdDjIMK84PtXU5mIi6ek6haNkNbj+iA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037063; c=relaxed/simple;
	bh=Fg9yrnAvz4Z/N3ouxMNbNkOD5RJopuNIJHUBxUAbq38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpZT/liW6L3Q5HATOKH800HoirWf9Hfd0D/VgABbJL/YJLaBQh3CTFU0zQZNSPex9rzwqcPYkxXLR13WiQObGNurQyJijufOL0dPI31vUkjaKqJhiwP5D6r9FyTSPBM8WxhruxdtXFPt+nSv8bZNfJDJ+7M6U+D4SWkO6OQtZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xg3SPA/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SX4+wXnO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xg3SPA/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SX4+wXnO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6372DEC15C9;
	Fri,  1 Aug 2025 04:30:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 01 Aug 2025 04:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754037059; x=1754123459; bh=e/owBVvz+J
	5TiIUyjvBIdwoEDJ9nLx3IPtYUSzy09ZU=; b=Xg3SPA/ACL4zFrbTwMyeXFqQAe
	FvVBFx0CtFoX6j5axrdGwuX/w0OxMqjMBnUNmZEo1AduaWhDLi1FmsebvorAg1xb
	RXBjUZIsSnMcV3wRkJo1GsANbo6Nq5sBjqCyJsZttB8b88QrlY1wjDTdHNbga+gC
	lLq2K1puo7qju/M0TDEoPJ/sawYUmB12nEjXopPPmPrZWrh8RuQ52+N5TWtCLtRn
	8SNF/Yz8lh3NppNmsGyB6Yg7RtnNoXakIaT1qmGabg4ms32YW8wGGz8wOB7WmSlz
	3RRsN2ttTufNR4bo1R9jlVCjqloiJB0XEqUe5qcvXNdG0Yi8C/oiEOFayMUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754037059; x=1754123459; bh=e/owBVvz+J5TiIUyjvBIdwoEDJ9nLx3IPtY
	USzy09ZU=; b=SX4+wXnOe7HkyGxlKfkDV6iaFRoknnL3GXPJ+RDwK0k5ZMwcOG0
	xZfQ7ldceGacpNOt7MX878m+3kpD0hKhkBQtpRFb1XCGyl2cMhne2iIEqTlrhPEq
	4Y9Ws/TqkOJV3VZ6mDQwx6EWmpOtq8WvBkmV3d5fflQl1NYLJur8pwnQiGiojXu9
	8NHnBSjMSCYTw/E3IOx/7uo2H3X9AvqQcmWlWCr/By4WdKg5LS6E0+mq3XqQ3eZd
	C9zKxsYMrHT0d81xLVxVJUlPuCpx5jnaMbGaZ7mHlJBjeNpuOf1yAEO2Md8YLY/o
	gKUXEBS+CqTtUfC+5O4ZIVemJhVyC09vfGw==
X-ME-Sender: <xms:Q3uMaGPbD7JkDybWopWDJQgi-UmxF8x6NMyLMc53hnJLVsQgfboxwg>
    <xme:Q3uMaINjnV29Ol48mku1pA6IrrL_MdSzRSeNQMnoqDrgtbhEDVuFIAOb0WiChUaHb
    9crNuffaWhKHem4cw>
X-ME-Received: <xmr:Q3uMaGuU-YJ2d6lnwhsYcqf7xG2Yl9BjQFE8RzpqhSGYMGkemcGvglLuOfLQXzJWL5LV8KZaPvR0FenwPOXgZAdGN9lglbcYxGCmTYUYMmFW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfejveffteeuudfhkeejjedtheffleelgfdtvedtieehffetgfefleekhffftdelnecu
    ffhomhgrihhnpehvshdrthhoohhlshenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q3uMaCXPoQaA8dZYLMRaooL5GyKZnpJBQYN6-j9rdCvHBVB3weXmhA>
    <xmx:Q3uMaOvxrUn93sr0iOeli20K2OwKUOqcvK9igNz0RtoXadm0Tcpfvg>
    <xmx:Q3uMaOUs4OL9pIp62bWpx_VBBCbkv4ekQkCfSFeMJJ3oIK6Wins_0w>
    <xmx:Q3uMaBmcE149yweDP3-tJZ5SeE1jPjmMNk3u2vyg1WK2T0c4eFHYCA>
    <xmx:Q3uMaOLdD2C1cvUnTKKywbYSsF-VXKBoSi-oY6bL-GfndZr82pdIu9Ht>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:30:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbb821d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:30:56 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:30:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] t6423: document two bugs with rename-to-self
 testcases
Message-ID: <aIx7OEX6AEqNsIHb@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda42aa85cf4f332ef60aca1a8937ed4b868fa87.1753197791.git.gitgitgadget@gmail.com>

On Tue, Jul 22, 2025 at 03:23:08PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index f48ed6d03534..69de7a3b84af 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5092,7 +5111,85 @@ test_expect_success '12n: Directory rename transitively makes rename back to sel
>  		git checkout -q B^0 &&
>  
>  		test_must_fail git cherry-pick A^0 >out &&
> -		grep "CONFLICT (file location).*should perhaps be moved" out
> +		grep "CONFLICT (file location).*should perhaps be moved" out &&

Let's use `test_grep` while at it.

[snip]
> +test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
> +	test_setup_12n2 &&
> +	(
> +		cd 12n2 &&
> +
> +		git checkout -q B^0 &&
> +
> +		# NOTE: Since merge.directoryRenames=true, there is no path
> +		# conflict for world vs. tools/world; it should end up at
> +		# world.  The fact that world was unmodified on side A, means
> +		# there was no content conflict; we should just take the
> +		# content from side B -- i.e. delete the file.  So merging
> +		# could just delete world.
> +		#
> +		# However, rename-to-self-via-directory-rename is a bit more
> +		# challenging.  Relax this test to allow world to be treated
> +		# as a modify/delete conflict as well.
> +
> +		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
> +
> +		# Should have 1 entry for hello, and either 0 or 2 for world
> +		test_stdout_line_count = 1 git ls-files -s hello &&
> +		test_stdout_line_count != 1 git ls-files -s world &&
> +		if test_stdout_line_count != 0 git ls-files -s world
> +		then
> +			grep "CONFLICT (modify/delete).*world deleted in HEAD" out

Here, as well.

> +		fi
>  	)
>  '

I found it to be a bit weird that we have this conditional here.
Shouldn't we expect one particular outcome? Even if multiple outcomes
would be techincally correct I think we should expect one particular
result, but we may add a comment to explain that different output would
be fine, too.

Patrick
