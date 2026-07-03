Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77930B53F
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066800; cv=none; b=Dj22OsRSPKJJKmNrr+dMHk4dZQ3lcPnvcALuRgKa3GbiPL3Pn3xYyX4MKW9pyMlyLGaCQitw6Ku7+iRgqnujF4JLdzZnO7nojX9hQIM5TFaBrWPUzZtjlzB3UrKivknDzajD3Yxx4QNe8eE3unI2yhvoS4R5sGBNJn/Kcw6d/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066800; c=relaxed/simple;
	bh=Ag8KX3VoHa1AVNLMQi+S8KOzYwCFEkVz7UgjlcUISZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsoRZzqeEJq39OSqizOaAArDsQvod2bTbUSc8vG/94sMv/D+13PXyuNBN4sqVybWpKqnwrcfO/3RAEFvHMe1ppFapk8wTY9PhKcwFkDYYo09pZah+iW8pftFn4Gsf8sLFuSNyugQZVjg0ew60hWW+4ogIKhOAGz2OhEqVA8foQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq3bWilR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPidx6WB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq3bWilR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPidx6WB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E90C1D00099;
	Fri,  3 Jul 2026 04:19:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 04:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783066798; x=1783153198; bh=6PTgDF5jfX
	io3QfOtoB1AIdkDD+Hpzk4ncOqjvh1hGc=; b=Zq3bWilRsiGhYKAKC5A9QVdxBu
	i5yyBb971wExW0Nat0HpwMzhqg7Q/7pmnhvzCiXFdilZ0PBNKhPMQDaSDO6JjgrP
	lZ+4MZdxz2GdnCvyILYo3LWYcVlELGGdDyt9UFxg9jSKX3syjx3sDiIRQH91z7Wv
	ng/M9mLUpTMlbrmUpO5r5Pia73rI0H2oU90XwCNvaWX8HZh1yjIyPA9GihovQDpz
	blPBoiJALXxHpdsedtCzxfQ/hiGPlGVBjM5w2plVLsrcv56kWXztPmrMYdVawXLZ
	PfBbq6DBEP8qb9kwuOtrc752BVm6n+BR6UYO+MwJrmouhgTILwX+r6RCOFOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783066798; x=1783153198; bh=6PTgDF5jfXio3QfOtoB1AIdkDD+Hpzk4ncO
	qjvh1hGc=; b=rPidx6WBkfBI/AENV6JwDAs29xlMRU1Zcx0Y6EDCf9W/zTY3EZs
	ZYCRGSfKmr5eee/ISrFYoPTdwbUB313b5zXjcFX8EZV5QXEVjwYgFFMNENLjtZg0
	nhaQxg4EuhSBhsKBCLZackPqcg2056DzjuKkj6aP1YEhITMCqpxFtXux7SJPkTwG
	NTUi7UzdUMNsVGF2oEyVlxyxnvQ78xrdSggiK8u7SvShOvw9gqbQwILDDDY9AzhX
	Mf9gP5gOBPX2vOFlAosq5Np++fQLU7oOjMbrPgLYzjY3E6iwRXD05IraSm7ML2r9
	kUfnW9K8zj90iTEIJJfsZ+nC8qQm6dQTxNw==
X-ME-Sender: <xms:rXBHamPZgz1jDnTds1kfCSMJra47Gmweuw_bzJqmlQwYr9OT-Y0FGA>
    <xme:rXBHar9B5UogrwMtwYoDaXBL7cHT3FOjAy0zLyFz6uRxjwBget_fuB6MnidOrZnA3
    CPqqMUcvKBl6M_GDfeIJMbPdiXR3jbAQLEmwG4YpGuDwxDkVvpZ>
X-ME-Received: <xmr:rXBHaiSmrIiGsOkdzcrbb2pe8OdfLCwjJDTa_pPh5I6I-Hpn1Tf-9xFzHN1xc7HhEUATGsOOSs5D1C1LP2l7nHz_YhYVrQND9OWXkY1UbQ>
X-ME-Proxy-Cause: dmFkZTFJXgM2oMSt6sZyKrW3yrg7loDKjxNMfZ2h7BoIqYejW+IOG2zIT8ZvhVTkaaSxtr
    v7rxiLciDiJAhfJOHM5OpfDpS21tjD/H+1svqNuUflaJOSpkq1qpIB0XttPFw6xbtjWHD6
    sy1w9r1IjaoFvXfKM865EJcXI8ajuABLz2p3ot5PGsdyN1zS38p2jJw+0/o3gS7nUUxh0t
    dCntuSu9lFgfZVgu2oR/S2KVh0gN+dVAr782tuZ78lX2fGIAm2tBDTC8ZyWZlrIS8viprY
    qyE0GKeM8oCbh4ifm8SB3doMsWWsB5V2wfBgH1pyiq6lBWOfCdvqyKKZAZOCG2gpZaU7Bu
    gBI5c3CmJWjWrhIG5KqJIi9lq1H1vskxBCgHI/aQSZGb2Z5fQFG/IxGM1LGQV9x2A3BIsd
    wtRxS8VKoNyx33Vpzi3bp44adYV8p5sVtGMef76DYCNTojbjNjTn3ST+Z6URd+Q1opGis/
    3xQk3UC+evXz3B7B8NEdxGmuUu1oxI2QOsi5bIWtOv/qpBQ+3KIGAvcDPBKTKegxxjeQgF
    XS7z+R/BvdNdElj0JfjqRgCEOh7DBPB8+fQ9wmUkFX03vbgYC4pyHhKmYh8iGNJDj/ciST
    8kp3Bh2vyII5iaPy46wJgipQXAzfhHaB2On7fRJgOtyvV9LleFfR2xnj254g
X-ME-Proxy: <xmx:rXBHalkjF4nJvTT_T7wddAjax5E5AiEXJ84XselA6YEkP9X-q3E0mA>
    <xmx:rXBHaqQ46ZnTWConEmJQZq43OlaaqTtUGc42U7X_oJBTzv4St8vInQ>
    <xmx:rXBHarPD9s7eDz75Qbv4lNqDz33H0udLEQE_jjR2PYWA4zIJsBUKBA>
    <xmx:rXBHarU40_22RQJu5_kkeuIOPOhDTSCgRJ540mmM57ZwQdAQHPGzfw>
    <xmx:rnBHalxhq3bd1Hz1knGuVGVODoHISDpaneCQMvzPb_NBAtJSnjcMYPnd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:19:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63293841 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 08:19:54 +0000 (UTC)
Date: Fri, 3 Jul 2026 10:19:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: git@vger.kernel.org, Vinicius Lira de Freitas <vinilira@usp.br>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9811: replace 'test -f' and '! test -f' with
 'test_path_*'
Message-ID: <akdwp_a2EuhVoGVW@pks.im>
References: <20260702140704.65805-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702140704.65805-1-marcelomlage@usp.br>

On Thu, Jul 02, 2026 at 11:07:04AM -0300, Marcelo Machado Lage wrote:
> Replace the basic shell commands 'test -f', with more modern test
> helpers 'test_path_is_file' and 'test_path_is_missing'.

Nit: it might make sense to briefly mention why we do this exercise.
Like, what does `test_path_is_file` et al give us over `test -f`?

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 7614dfbd95..93d6b4c479 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -62,9 +62,9 @@ test_expect_success 'basic p4 labels' '
>  
>  		cd main &&
>  		git checkout TAG_F1_ONLY &&
> -		! test -f f2 &&
> +		test_path_is_missing f2 &&
>  		git checkout TAG_WITH\$_SHELL_CHAR &&
> -		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
> +		test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&

While at it we could split this line into three lines -- it's getting
overly long, and we typically don't chain multiple commands on one line
nowadays.

> @@ -135,9 +135,9 @@ test_expect_success 'export git tags to p4' '
>  		p4 labels ... | grep LIGHTWEIGHT_TAG &&
>  		p4 label -o GIT_TAG_1 | grep "tag created in git:xyzzy" &&
>  		p4 sync ...@GIT_TAG_1 &&
> -		! test -f main/f10 &&
> +		test_path_is_missing main/f10 &&

This is a stronger guarantee compared to before, as we only checked
whether the path is not a file. Now we verify that it doesn't exist at
all, which would be equivalent to `test -e`. That's a strict improvement
though, but may be worth pointing out in the commit message so that the
reviewer is not surprised.

> @@ -168,9 +168,9 @@ test_expect_success 'export git tags to p4 with deletion' '
>  		cd "$cli" &&
>  		p4 sync ... &&
>  		p4 sync ...@GIT_TAG_ON_DELETED &&
> -		test -f main/deleted_file &&
> +		test_path_is_file main/deleted_file &&
>  		p4 sync ...@GIT_TAG_AFTER_DELETION &&
> -		! test -f main/deleted_file &&
> +		test_path_is_missing main/deleted_file &&

Same here.

Other than that the patch looks good to me, thanks!

Patrick
