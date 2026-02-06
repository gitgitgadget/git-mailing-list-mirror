Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB2C0F90
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354354; cv=none; b=XHXplMUUeX9S+YNT4IJ1rHpDgddF0mu2u4lhmqeundsesQ/lh4ospXtC8MAH4rWZZKufQAgEKt0zV5WNxJkg4mDDHEP5Dimq39auyKwhdoeDFXCQvbegVI9la6EIsv7reyAAx86wpFzDTBZye3qcO6aVfLFvR5qRTK/agIQKNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354354; c=relaxed/simple;
	bh=9yyLl214TOpFaCugJQxPqKL7Jy9oKqPfcHCSS26kUSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tc9tXuo9MykilnypqaPo/qjZxB6QtK8i/RH5RGrTuAPN9GAJBArb6YL8321o9G71HHsFLbKyrBKk2q+E04sP8Gh4df3wcx35r41TlrgJoZF5AvkQkPE0Tyb063rydMtdsp49VIfcgyWqKvEkkNNcXsoofokrVG09+xQOaIvRTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fclsNIUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCJIr8k5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fclsNIUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCJIr8k5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B4816EC059A;
	Fri,  6 Feb 2026 00:05:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 00:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770354353; x=1770440753; bh=YZXRWykiWI
	6rmENDIYBaNK4ZIywycjxqrGqa+n0adHs=; b=fclsNIUWH1/77G9KW5vjQ6o706
	d6Hgcmz+QenoOpALKcQ4tHs8x0MuAwTm9O/72zdX9vNFdpqMxPSAi3b0Yj1P+YUH
	SKxM2VpnXv7szEHMA6+9lrAra+FyQuenanHNX5gIrdqWdBxRlOCUGcFQ8qDkiTzr
	Fs8wNKBro8WKVKC8yb8tlhhHLSwuOg3CWSRORG3Y6X0FD7rh8X/IiNatjPlFTyGa
	eqJfwmdOKs9H1t3MstJl31dKSsUQMyHaTbPZM3oSFuPFLNIiAV9/jZwg1F8Hrc8v
	y4My1nvSHB6MLr2XdYapzNrGGFDuJF078zUuyN4TwfRjZAkQTKmDX9bekAzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770354353; x=1770440753; bh=YZXRWykiWI6rmENDIYBaNK4ZIywycjxqrGq
	a+n0adHs=; b=iCJIr8k5ZWlol2u39++y2JKE2ZYEKyb0lnLpaSycxfWX44cB/Wl
	8NsSfbNRmbsGSUTiWawWl069xtlTP2qFvLxUlMjdJzmH4Mwy9a0CmoLhd6h4qWJp
	5VMyeDugJcodfY6CX4paM3iiTs6Ffz0231HvzhQ1E2XJJv5KruMqbDhgFJJ9Zzrn
	bnuYWY9LRqYQruFgSnzzOvueSEg8zpc6+/E2vhrfB/TKdX4rWUudVEk625dC53nE
	pDTE+KiBB/37GW+sCo7ada5SCqzWUJUJatoqdEtURroMfX3uNKBINTnAe89DbhSp
	/YihGPV+TuJMkfF2DSGqcWsQLbLCpYGuF8Q==
X-ME-Sender: <xms:sXaFaclsbSyzbX4VduWYFKM-p7zOIJ2BO4PAuFS5autj-eu3DoG5cg>
    <xme:sXaFaS2ozjQHMLWpCDkfeUqyBvJU9p2FYf1bkpPhzNQH0RJBmCg4y5gOr_ITLzpy7
    eXiT5sU-lTS-2j0gKiZjUhFmy3QSOiG-M2Dl-DH-sY4UZpLVJcpAA>
X-ME-Received: <xmr:sXaFafoWfKReJP1K-qdwVsWzbqpzNjyEPbiw26Y13ZIAQtvLgdVa67009g7KiYiE8Qcoz0FC3z37QnDhcipsPOwsBJHbdbST-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsegr
    shhhlhgvshhhrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sXaFaXdyElm9rBv0vzg9-7PBluMMyHgUVMeUN74kMqsU6G3RDByrbw>
    <xmx:sXaFaWrcpuQ0aKZYc7aM6Njj5lJ9JiU32mo7MBB0XFwZ8t-cZtKdUw>
    <xmx:sXaFaQFjYbEL1FDWyh9pBKmb6U2dBDq1kvuDhI1hvCh7-3pVGIH6sQ>
    <xmx:sXaFaesgQbBQNt0UxSvxuZMCbcF3Ou_Gm1tcdJrzoIyQzaDzhQGO2Q>
    <xmx:sXaFaa7JWDRfS8xnxjKi_wEGxD7HIK8D-ZNmvOnrIGvJjQZubMT4N1Yv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 00:05:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
In-Reply-To: <20260107074724.13165-1-git@ashlesh.me> (Ashlesh Gawande's
	message of "Wed, 7 Jan 2026 13:17:24 +0530")
References: <20260106114029.763351-1-git@ashlesh.me>
	<20260107074724.13165-1-git@ashlesh.me>
Date: Thu, 05 Feb 2026 21:05:51 -0800
Message-ID: <xmqqms1mihqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ashlesh Gawande <git@ashlesh.me> writes:

> git allows using .netrc file to supply credentials for HTTP auth.
> Three test cases are added in this patch to provide missing coverage
> when cloning over HTTP using .netrc file:
>
>   - First test case checks that the git clone is successful when credentials
>     are provided via .netrc file
>   - Second test case checks that the git clone fails when the .netrc file
>     provides invalid credentials. The HTTP server is expected to return
>     401 Unauthorized in such a case. The test checks that the user is
>     provided with a prompt for username/password on 401 to provide
>     the valid ones.
>   - Third test case checks that the git clone fails when the .netrc file
>     provides credentials that are valid but do not have permission for
>     this user. For example one may have multiple tokens in GitHub
>     and uses the one which was not authorized for cloning this repo.
>     In such a case the HTTP server returns 403 Forbidden.
>     For this test, the apache.conf is modified to return a 403
>     on finding a forbidden-user. No prompt for username/password is
>     expected after the 403 (unlike 401). This is because prompting may wipe
>     out existing credentials or conflict with custom credential helpers.

Nicely summarised.  So we say 401 when we do not know you, while we
say 403 when we know you and do not want you to be accessing the
resource.  We test for both.

Just out of curiosity, do we test for these codes with other
credential helpers or is this only relevant for .netrc users?

> +test_expect_success 'using credentials from netrc to clone successfully' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@host &&
> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
> +	expect_askpass none
> +'
> +
> +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@wrong &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
> +	expect_askpass both wrong
> +'
> +
> +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
> +	expect_askpass none &&
> +	grep "The requested URL returned error: 403" err
> +'
> +
>  test_expect_success 'http auth can use user/pass in URL' '
>  	set_askpass wrong &&
>  	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
