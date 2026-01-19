Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC028980E
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805444; cv=none; b=RF//PCYJG0Ofor2FcceywlDWLiWtMXoiBxEFP7kFSTHtPmCtgLL+g/AtGsI6F8RR4TKCxS6xnvpjxdPznEOZ87cdjkkc9aw75/kjSW9+6U/dGnRJhsQkC8+HJPv6vFEBl4+92NQTLY4xSME6WOUx2rYoctyWiyj+ZJc+Jgop008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805444; c=relaxed/simple;
	bh=DlpI36OvCWu7N7WD6uYJf07KWVW2K5h4RSX9H9suHRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnizUtVzk/DDMW5QZewsMhD8rpHh/3AM/mhyUvTt9DT5adtMBWbAnm/H3bciDlsvoz2SeUIw4tJlYou7reiHLMkTwwNA2YRKJYKLksOMUYI1AIxdAnWIpuR5dLREr7nDZwAbTsfEB/5WxeCWwIiOFYrgaEu2aXrqvuZGiXk53f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L2jWmQtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qr6nMqN1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L2jWmQtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qr6nMqN1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CBF81400695;
	Mon, 19 Jan 2026 01:50:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 01:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768805441; x=1768891841; bh=uno3VJfTAU
	eIbd1KpPMOOW5ooIWbRdLT5QKv9pFCKGg=; b=L2jWmQtr6vAmSQ29OLN+mIEmPm
	4umwooYG9XV9vBiz/00NXnqM37j7fJ5M61Bw7XkTGfb0mRWLO4h4umA02BuQg4bu
	bqUgxIQ3TQLYvEI+A/5irfu+qrNZb5eX/pCcrmJbAY/VAXrJUTFFZgo+yPO0x5W2
	ZUu8KaBHyQCnQ6/UQsgflB82aeJE7L4fKk9SOQDseYoz9JdEIuz9DTb0eH4PP/Sf
	wYQ0Nj+LH1u+aEg4V5ug9TDfiEumzhhn8ydg3b7/dND54sDZeGP/gtRiW67AXHd9
	dpA0M8g7zzcC4S+e3aDvxTQqmeytjrem20XqXs7ZOQUHb/ymaoJgdp5wiA4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768805441; x=1768891841; bh=uno3VJfTAUeIbd1KpPMOOW5ooIWbRdLT5QK
	v9pFCKGg=; b=Qr6nMqN1s2pXBKIrNmkiWOWRpAg4KNrL0L0cMp5Vfkcn2/Gs2X3
	TJSOiJOuuJzXpqVgOD8hI0vPX8H4WDGZMxNvyGdJQMqglQGzuTQWv7gZWdiIazDa
	CkoEUZzhNVknqE5yF5mMUJnTe1jzMhrGixqyI2LOacLSkgYeeje6SbejxmTzRIjs
	k/+AyIvdU7YM9tc52tx8iVzmj5XwLv/fi/IWw1mzXT4mzPF3/tHco0q9lEOuR/eJ
	rVc3lsEZ0ZzzXr2FgZGlUZ9c6+iI2e1rh6JJVwz8QszzLK9ykhEt31OJg9OhVOk3
	1jN7q4FHW27RWVAawjMvLizHlyq1JIJ+zbg==
X-ME-Sender: <xms:QNRtadsnIpsm4EDgPFpAejtpy2hkhqn9P6miMriLrDKcRmsTbPvB-g>
    <xme:QNRtaUTIXT5094D3B3ox8bevd5z4SXaQe8pMDZjB6Ct6ZpAQ7lC0ZSvsR6SzgQtcL
    LVlgYzjuQTrIqkq4X3kQxNP1k1LqcN9stkQNgnru1knT6bZcRVRXg>
X-ME-Received: <xmr:QNRtabOSzBN9GXVPx6fSIfUV1lB849svhXpC5rpVXnoo6Y-yw20AK3Lr-I8IZJ4PWAgcfVE2CvkCJXU-qnrpeXVAXmcW_76Oxoavh0XNJ4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:QNRtaRaWgf9j1CopN1RLSALl3o6kfYutongsKrhAhEJEcRymK82goQ>
    <xmx:QNRtady-Ny9Ns3FEKFInL7o6PqSrDHyHU-oX_jQxpq6oe-a8G8X06w>
    <xmx:QNRtaULSMgYd-HU4xuJuIv0bFs2wQxyO6mOOjZHfrEF1lhpk_gyeqA>
    <xmx:QNRtafpkdQA2WchCR3fQnyshXv1K5PCm0FhlS_BAY4ydX0Aa6yyi7Q>
    <xmx:QdRtaR6URsaj_AkJstHeji8lDFoY831EQXU52Q0b6VgXRL3GjIWbAUSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:50:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23824113 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:50:38 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:50:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t0610-reftable-basics: mitigate a flaky test on
 cygwin
Message-ID: <aW3UO3ff9aNc7HQz@pks.im>
References: <f46e023b-1925-41b2-9842-42e7cb727056@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46e023b-1925-41b2-9842-42e7cb727056@ramsayjones.plus.com>

On Fri, Jan 16, 2026 at 08:39:56PM +0000, Ramsay Jones wrote:
> 
> Test #29 ('ref transaction: corrupted tables cause failure') started to
> fail intermittently for me (from v2.52.0-rc0) when running the testsuite
> with '-j8'. (Also, having moved to a new laptop and windows 11, rather
> than windows 10). If the test is run by hand, or without any parallelism,
> then it passes without issue.
> 
> When the test fails (e.g. 1 out of 32 parallel runs) the cause is due to
> a permission error while corrupting a table file:
> 
>   ./test-lib.sh: line 1010: .git/reftable/0x000000000001-0x000000000002-d89bb8ee.ref: Permission denied

This rings a bell. I remember that we discussed a case at some point in
time where a redirect converted to `test-tool truncate` fixed a flake on
Cygwin.

> This corruption is done in a shell loop, directly after a 'test_commit',
> which uses an ': >"$f"' expression to truncate the file. Adding a sleep
> of one second after the 'test_commit' and before the shell loop fixes
> the test (it is not clear why). Replacing the redirection shell expression
> with a 'test-tool truncate "$f" 0' invocation also provides a fix, which
> could simply be another way to change the timing sufficiently to win the
> race.
> 
> During a debug session, I tried looking at the strace output for the
> shell redirection:
> 
>   $ rm /tmp/hello; echo hello >/tmp/hello; ls -l /tmp/hello
>   -rw-r--r-- 1 ramsay None 6 Nov 10 17:25 /tmp/hello
>   $
> 
>   $ strace -o zzz bash -c ': >/tmp/hello'
>   $
> 
> Similarly, for the test-tool solution:
> 
>   $ strace -o xxx ./t/helper/test-tool truncate /tmp/hello 0
>   $
> 
> When comparing the output, the differences seemed to be what you would
> expect and, if anything, the shell redirect probably would have taken
> longer than the test-tool solution (many fcntl() calls to dup the stdout
> to the <fd>).  The call to the win32 api NtCreateFile() was identical,
> apart from the first (FileHandle) parameter, of course.

Too bad. I stil wonder whether it is the extra process that we spawn
that ends up fixing the issue.

> In order to fix this flaky test on cygwin, despite not knowing why it
> works, replace the shell redirection with the above 'test-tool truncate'
> invocation.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>

Oh, so is this the exact case that we were talking about? If so, it
might make sense to link to the mail thread so that folks can also read
a bit into our discussion around this.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/t0610-reftable-basics.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 6575528f21..e19e036898 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
>  		test_commit file1 &&
>  		for f in .git/reftable/*.ref
>  		do
> -			: >"$f" || return 1
> +			test-tool truncate "$f" 0 || return 1
>  		done &&
>  		test_must_fail git update-ref refs/heads/main HEAD
>  	)

In any case, if it seems to reliably fix the issue I'd say we just merge
it. It's unfortunate that we haven't been able to figure out the root
cause, but so be it.

Thanks!

Patrick
