Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D314F70
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235464; cv=none; b=XRfCm0E6jRhe3MU04bjI+nWNM0/C1Cyp5Q53LF3R4yoyVZ5oQD54J2xrp3Q1Mtu+w7XX5sp0IaRscItNY/yr61farK3z49zfg6IeLBb/F1qdvDf0rizD354kvmkZ7mKemAGmSvfv0x6DhmCtPZs4m3+RgjEKCALoGagQ+/X6omc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235464; c=relaxed/simple;
	bh=qXl9n6e8HpK79mTTn5xRMc4KxvRttJwVe3Ncq7wFqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0dQ9wL/TcQvkFsRc4DYRpCYDC+RRivCDuT/L+lph6OngUW0qY2k49mPt4yD4DbxAP0Gxb9p5ZnLPVDYyqbkZSJ3pkOuRawwrk4J2hiWRLJ4UJCa4nn4HHMMhi5/4/52IJx/dgNPyYiRLY0G5UNP7j1EOsvxkCth+XDYSH+8MS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q2jdGocU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3RQuGzw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q2jdGocU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3RQuGzw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BD6C1380201;
	Tue,  7 Jan 2025 02:37:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jan 2025 02:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736235458; x=1736321858; bh=r/41/wkJ+k
	x7i5vDQfIV0Piw7qiIELO3kcxjVvko+pc=; b=q2jdGocU3qU3j4RUeIAVRCc8Ts
	y/d+BaJyoDFzTUlBRW1j5g8PH2HPTic4VYhxU9xwUCswZ+LA+KZfx0DgcCDJghdj
	5uJ682JUS29jP0ngjWtEeX+Rgp56H9Ele+E4w03jzo2f1AqfQFnD9ZyjSc3rSDPQ
	yPCUeUlTxT+xj8IDWVIjLtl83a1pCRSYI1hpJIZVBxWypmhg8HKdO2xsvcRkL8Fv
	BF+a921g+m80XALVRuDI3pmPS3TugkCObWan6cogeSFk7mHEJU0+9od6RJm1qasd
	t1ux9MmGMFKv07QlzejN0m4YVfnK22OQe+IZO7fy9EXF947NnUXkhSbUMwjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736235458; x=1736321858; bh=r/41/wkJ+kx7i5vDQfIV0Piw7qiIELO3kcx
	jVvko+pc=; b=k3RQuGzwIhzcn1/d8PeBT8kulvE9fMYvxdshFZDbO9QQirF2Z3M
	GPSug4LOYCx27hcf6vlJLRjtvm9GMkyV5fQ0qLO7K5UwBfoakrxyXbYdgzIEnAPN
	O4GMZwDzNgverPM6TOzpfV4aqbvQ5IOUHV1NKHKz8WAIy26wdCVHs6Z+lkPWptpE
	OqJQaJpkBQB/7udE6PO3d4wpVm0V61eIZJF6rt0h2Q13eDENbKGrS2jlpKZOxPAh
	fNEvogn0rx88vWx6yOV2EjUo/ThSSqDx1aGrP9tCeleTZlXutdSx/rcMIWxC23Wc
	0DTiZSMuw8jEkiWvglUsLVFaTRlIBV/BJOQ==
X-ME-Sender: <xms:wtl8Z3oLgsb5M1-KMfDBlIsNnitQKedFum6ppqFObaRG-kyUW7DJYw>
    <xme:wtl8ZxqbHARHSyeP1Lz47y7cZ0lMIUP_OnAXslEen26LuiC1cGcuj6bmg7OiHIe8H
    MLYC2dEOK_osZZsqQ>
X-ME-Received: <xmr:wtl8Z0O-3_JAdPJKlTAjElcy0v30E6N3IFBA1VLvWVkSkzCx7MvrGluAVdVwsvFnpHirnVMHag5W_cIMe87IIE8vIr59sd9kpLktA5nhEbt0Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wtl8Z66g2zI-E5I9tS5xFwXIleTLJK01cMzykBsqtQS1EurPW3Tk5A>
    <xmx:wtl8Z26CizrlorGlkx4RRzNz0JAM3wwQ9lPXt3AcoHuwZSPwu_cnRg>
    <xmx:wtl8Zyj542ZcV51Pwy9YFiFpR_eALB5rpomWWDYfZKfZXP2vBLwFEQ>
    <xmx:wtl8Z46XaHT7lSasotDEX5_s0ySCdEjlGyqfjs5sO2Sdt42B3xjVrA>
    <xmx:wtl8Z8lbk5uvHIajAIJJFY6vTv1Fts-JqpgHl6ic_M9NZe8FcuoGmRfP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 02:37:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36480ede (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 07:37:34 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:37:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: simplify lsan results check
Message-ID: <Z3zZt2OCjcDGvjBS@pks.im>
References: <20250107070409.GA584456@coredump.intra.peff.net>
 <20250107070752.GB584668@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107070752.GB584668@coredump.intra.peff.net>

On Tue, Jan 07, 2025 at 02:07:52AM -0500, Jeff King wrote:
> We want to know if there are any leaks logged by LSan in the results
> directory, so we run "find" on the containing directory and pipe it to
> xargs. We can accomplish the same thing by just globbing in the shell
> and passing the result to grep, which has a few advantages:
> 
>   - it's one fewer process to run
> 
>   - we can glob on the TEST_RESULTS_SAN_FILE pattern, which is what we
>     checked at the beginning of the function, and is the same glob use

s/use/used

I'm always a bit thrown off by your style of bulleted lists, where they
feel like sentences but start with a lower-case letter, and sometimes
they do and sometimes they don't end with punctuation. Maybe it's just
me not being a native speaker and it's a natural thing to do in English.
In any case, it's nothing that really matters in the end, but would be
happy to learn if this is indeed something you tend to do in English.

>     to show the logs in check_test_results_san_file_
> 
>   - this correctly handles the case where TEST_OUTPUT_DIRECTORY has a
>     space in it. For example doing:
> 
>        mkdir "/tmp/foo bar"
>        TEST_OUTPUT_DIRECTORY="/tmp/foo bar" make SANITIZE=leak test
> 
>     would yield a lot of:
> 
>       grep: /tmp/foo: No such file or directory
>       grep: bar/test-results/t0006-date.leak/trace.test-tool.582311: No such file or directory
> 
>     when there are leaks. We could do the same thing with "xargs
>     --null", but that isn't portable.
> 
> We are now subject to command-line length limits, but that is also true
> of the globbing cat used to show the logs themselves. This hasn't been a
> problem in practice.

Yup, this also came to my mind immediately. But I agree that it
shouldn't be an issue in general.

> We do need to use "grep -s" for the case that the glob does not expand
> (i.e., there are not any log files at all). This option is in POSIX, and
> has been used in t7407 for several years without anybody complaining.
> This also also naturally handles the case where the surrounding
> directory has already been removed (in which case there are likewise no
> files!), dropping the need to comment about it.

Okay. So in case there are no matching files we don't expand the
globbing string, and "--no-messages" makes us ignore that case. A bit
funny, but I don't see any issue with it.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was surprised by the use of "grep -s" in t7407, since it is totally
> pointless there. But I think we can take its presence as a positive sign
> for portability.

Good to know.

>  t/test-lib.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index be3553e40e..898c2267b8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1172,12 +1172,7 @@ test_atexit_handler () {
>  check_test_results_san_file_has_entries_ () {
>  	test -z "$TEST_RESULTS_SAN_FILE" && return 1
>  
> -	# stderr piped to /dev/null because the directory may have
> -	# been "rmdir"'d already.
> -	find "$TEST_RESULTS_SAN_DIR" \
> -		-type f \
> -		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> -	xargs grep ^DEDUP_TOKEN |
> +	grep -s ^DEDUP_TOKEN "$TEST_RESULTS_SAN_FILE".* |
>  	grep -qv sanitizer::GetThreadStackTopAndBottom

And this nicely simplifies things indeed.

Patrick
