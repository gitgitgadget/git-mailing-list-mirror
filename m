Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808342F6167
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231610; cv=none; b=RAXiwM2fbtDMGOxpPgcZUC1jdbwEprNeZ1/GpUMyK3bXk45OpfWdhR/5pJkDWbRushy87TQL0eTTuSOtKOBrlEKYYBI3cGbov7zoZikSt+bWYnbHpo0XwMzV/42KSzyP04/1HIb7MUiN7T/0sjO+Bu/j+ZpFlPRN458ee5jag6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231610; c=relaxed/simple;
	bh=Ei6d7Xo+NAdeu6o/MddAAK8o42UoGAmUEbWzGDYOCoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxtRvabZyVDUM9DyjYcFvyta4F6XgaqWUQKon7VWV87rnrPdmclAbRQLiB8+tyex1wjhKtreJl/aJWbqsOItyYqbS4DfiFlDrG9EPMP7dKiaxd01hZsZzr3U3B2BcQ+2+5U5PFAliOqSiHJ41y5CYG6zxPjQcoQ3wb3qtxX8XVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFSKuoRV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXnI3WW8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFSKuoRV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXnI3WW8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F0761D00069;
	Tue, 30 Sep 2025 07:26:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 07:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759231606; x=1759318006; bh=vh5PwO9ZZz
	vWo+4TZEpkLN/h4FRknWOgSkV0c+sXvgw=; b=KFSKuoRV+M8oYivd4VIIAo6q2S
	viOZX7/9iivm1zOYNyvNvdSC478RLtoOHAk5aCkHxDqyEoR2apizxmrepOez4Zuq
	hPBCtGgeMaFRJZkVeWUoJJbQ/N0IseXoRFeFcu0ToTooVtIkZtGRA0bt8MMDbczl
	cKjPOTwzmT7elI6XZaOUaBtDGZzTh5MhZNEhYKo7n7tKXngA3hdZtqg3qEkIfgm6
	PkI5xST/yuG3enO4HZr5peV7DHrIrXKGIIJnMRFBJSfrg+p/hfc87ZIo4AjixOCU
	sbG4DULnsuaWZRXw8UZpCwFjNmCU/saaflbEzu2mJ09UywoV8oEcq+2NJNOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759231606; x=1759318006; bh=vh5PwO9ZZzvWo+4TZEpkLN/h4FRknWOgSkV
	0c+sXvgw=; b=hXnI3WW82eylZIvCMBZnC3zSE4MPF8gQtei68zM6Ma9mq+Rognu
	Nq7c/UrO27WNlNZbQkQB2x9z9prFax/d4+oe0Y+JUt8+u5QdV+2HfrBo5bE+92yD
	uKZ4E8e/qUzO+dbgQ91FLcGAwAVdnJiBMuW4Jbn7DdnBydzjK5x95bh7c6G6fdw8
	qnTdPgKk4kwzN4pNvJiBhHJQjHfXmNGkgE5ZA8p1V2CD5FOx6JBwFa6eQ0JD9Id2
	jLFTr9/GOSt3fL7xlQlUbA9eIvL4Yv52c5mNUa4MoKKuykto9ljHjAVH8aliF7zz
	te0ysz348cFXJg+wJhl5XSFc2hnkKlDEv7g==
X-ME-Sender: <xms:dL7baGAnQFTVH8UFX0czmP_Stthvx18cHdfb1IlzOHhkAwVkWSLTtQ>
    <xme:dL7baH_7AsFFBir3niQ4BM7AzjtI_UNAZRsgcWlWUlYFLilHmLdyG41dsZ92dUUfh
    ajgf-_4C8BegUA1QRmcI8Dfz9QIuIP6iHzP19LBzICpDJcAF0U3nQ>
X-ME-Received: <xmr:dL7baG83ywtphCHYpFVMFoHKchuH6qRFrSCkmJueWoOJEKZYvEQ5yb518ziSKXK--qkGxcwz285NmP8jiFg4D4iNlvYuhsEUrchKgNbI5r9V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhmlhhkohesnhhothdqvghvihhlrdgu
    vgdprhgtphhtthhopehgihhtsehlohhhmhgrnhhnrdhshhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dL7baOfXct7bakg1fUYVjApWdHdezxwRHEL6pxP8WF3FDeifSzngZg>
    <xmx:dL7baPHyNKqPMOQi7p9GYd2oye7Hhfk6eMekIH-dKDAfMi0jFH5lIw>
    <xmx:dL7baMd3jQmwH91F9YS2LGs0kDQRZC5Xyh3S0q7tGRaDbPluQRxtsg>
    <xmx:dL7baJHTH5Z10sHKGbc8ctNktqIbHGmEP5_gNfX7F0AyvlwBaPGcVA>
    <xmx:dr7baOE5DRr7v36Cl9_OsxviAAQRIkIZ5CXkcvwUnYANp-DvyXxUL3Au>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 07:26:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efbe2e28 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 30 Sep 2025 11:26:42 +0000 (UTC)
Date: Tue, 30 Sep 2025 13:26:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: gitmlko@not-evil.de
Cc: git@vger.kernel.org, Michael Lohmann <git@lohmann.sh>
Subject: Re: [PATCH] builtin/reflog: respect user config in "write" subcommand
Message-ID: <aNu-cTrJwPdcW6hq@pks.im>
References: <aNsc9En-DjxVOLcV@pks.im>
 <20250930091411.14179-1-gitmlko@not-evil.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930091411.14179-1-gitmlko@not-evil.de>

On Tue, Sep 30, 2025 at 11:14:11AM +0200, gitmlko@not-evil.de wrote:
> From: Michael Lohmann <git@lohmann.sh>

Is there any specific reason why the originating mail address and the
author information disagree with one another? It makes it hard for us to
verify that these mail addresses actually map to the same person.

> Previously, the reflog write command only recognized the environment
> variables GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL. It did not account
> for user.name and user.email settings from the Git configuration.

Nit: we typically write our commit messages in the following style:

  - We describe the problem in the present tense.

  - We then proceed to describe why that problem exists. In our context,
    it's also relevant to explain why our tests didn't catch the issue.

  - Finally, we use imperative mood to say how the problem is fixed, as
    if instructing the code to change.

Happy to provide more guidance here as needed.

> Since the test suite always sets these variables, it was unnoticed that
> not present, it would use the system config as defaults instead of the
> git config.
> 
> Co-Authored-By: Patrick Steinhardt <ps@pks.im>

Another tiny nit: This should be "Co-authored-by", with everything
except the leading "C" being lower-case.

> diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
> index 46df64c176..65fc4cae93 100755
> --- a/t/t1421-reflog-write.sh
> +++ b/t/t1421-reflog-write.sh
> @@ -101,10 +101,19 @@ test_expect_success 'simple writes' '
>  		EOF
>  
>  		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
> -		test_reflog_matches . refs/heads/something <<-EOF
> +		test_reflog_matches . refs/heads/something <<-EOF &&
>  		$ZERO_OID $COMMIT_OID $SIGNATURE	first
>  		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
>  		EOF
> +
> +		sane_unset GIT_COMMITTER_NAME &&
> +		sane_unset GIT_COMMITTER_EMAIL &&
> +		git config --local user.name "Author" &&
> +		git config --local user.email "a@uth.or" &&
> +		git reflog write refs/heads/something_new $ZERO_OID $COMMIT_OID first &&
> +		test_reflog_matches . refs/heads/something_new <<-EOF
> +		$ZERO_OID $COMMIT_OID Author <a@uth.or> 1112911993 -0700	first
> +		EOF
>  	)
>  '

I think it would be preferable to make this a separate test case.

Thanks for working on this!

Patrick
