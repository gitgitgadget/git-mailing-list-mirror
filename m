Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32483259C
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710571303; cv=none; b=PtPDVXNBE5/pGpWsdu3M0UpF02C5tMXBN4nL4sEtyLQwUrk9S9jbd93i7gFM2Vt2N6/jzpD6wGZqGJgty/W8BAuw+AyIkOA2oU5lzL+20aEq8wnrY2VhNiYo23KljeUj46Hf87yN4/77pPlE3unXtGGsxi+1YJGhfgkYYI+mIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710571303; c=relaxed/simple;
	bh=Cwl39de7hxGuRL44CLKU64B5tioSyrGXxqsX/Moqgdc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IGYo/PGDi5uM94fXkl1t26ZNYutlrOIrIajWkh3AXlfNLjjl3e/YQpvBFd+twdEIsxVXk3C+d0inLx23WTIobKVZc+L8xopz/mu1zxO4fPNhqDuShaVO7vQcjnIbpSGp21gtqwiH19FXdKzuY+4F6jcXn1IPfM/s2IY8GQvqzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=W1586T+D; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="W1586T+D"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710571296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIRnRrlc5YMQO7mkBoMIGPFBNjk/acK4XxK3VfPbm90=;
	b=W1586T+DIL/lwLj/POehcD87UD/ovQKGQ9FxqbcHharcXqx2PVl+E5lOXgXIzdfxZcoKzT
	vXjHXNCzNkoMngDCfve0CX+aA0p213xLcyj5f0vDHYLuVD5KfnPkJMAxqCbCKcQRVi+wxu
	TA5B5yVwaQr9nNKBxliKv0+Qdu8waxf9Q9So20aMSvXjBs9e5fqEQkQ6wP5eF8LZ/xuLIs
	hmMrVyDq0PV+9tCFUk4VJFr4YJvKztekcCrh2Gog8gjF0YMXuAkDXgFOwYRC00Is4infTo
	iO8rB2lWyxSomjVTGl3cAlanLyZx0qVhLZEDVBLGFxaW/zRU77Qe/XuuvAIUDg==
Date: Sat, 16 Mar 2024 07:41:35 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, David
 Heidelberg <david@ixit.cz>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
In-Reply-To: <xmqq8r2ioh19.fsf@gitster.g>
References: <20240315055448.GA2253326@quokka> <xmqqy1ajqvkb.fsf@gitster.g>
 <xmqq8r2ioh19.fsf@gitster.g>
Message-ID: <9c58e8b8bb39c15c3a980c996daf9327@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-16 06:57, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I am tempted to queue v4 with the z/ -> y/ fix from this round,
>> without any other changes from v4 to v5.
> 
> So, that is what I did before I pushed out today's integration
> result.  I however have an "after the dust settles" clean-up patch
> on top (not committed yet), which I am sending out for review.

Looking great to me!  Thanks a lot for the final touches.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ------- >8 -------------- >8 -------------- >8 --------
> Subject: diff.*Prefix: use camelCase in the doc and test titles
> 
> We added documentation for diff.srcPrefix and diff.dstPrefix with
> their names properly camelCased, but the diff.noPrefix is listed
> there in all lowercase.  Also these configuration variables, both
> existing ones and the {src,dst}Prefix we recently added, were
> spelled in all lowercase in the tests in t4013.
> 
> Now we are done with the main change, clean these up.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * If we were early in the review cycle, we would strongly prefer to
>    do a "preliminary clean-up" followed by the main change, as the
>    clean-up step would be much less controversial and can be queued
>    earlier before the main change solidifies.  But at v5 the main
>    change is more or less perfect, so it is not worth rerolling to
>    split the clean-up changes into preliminary ones and change to
>    the main patch.  So this is written as an "on top, after the dust
>    settles" clean-up patch.
> 
>  Documentation/config/diff.txt |  2 +-
>  t/t4013-diff-various.sh       | 48 
> +++++++++++++++++++++----------------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git c/Documentation/config/diff.txt 
> w/Documentation/config/diff.txt
> index fea89291c6..5ce7b91f1d 100644
> --- c/Documentation/config/diff.txt
> +++ w/Documentation/config/diff.txt
> @@ -108,7 +108,7 @@ diff.mnemonicPrefix::
>  `git diff --no-index a b`;;
>  	compares two non-git things (1) and (2).
> 
> -diff.noprefix::
> +diff.noPrefix::
>  	If set, 'git diff' does not show any source or destination prefix.
> 
>  diff.srcPrefix::
> diff --git c/t/t4013-diff-various.sh w/t/t4013-diff-various.sh
> index cfb5ad3d8d..3855d68dbc 100755
> --- c/t/t4013-diff-various.sh
> +++ w/t/t4013-diff-various.sh
> @@ -633,8 +633,8 @@ check_prefix () {
>  	test_cmp expect actual.paths
>  }
> 
> -test_expect_success 'diff-files does not respect diff.noprefix' '
> -	git -c diff.noprefix diff-files -p >actual &&
> +test_expect_success 'diff-files does not respect diff.noPrefix' '
> +	git -c diff.noPrefix diff-files -p >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
> 
> @@ -643,58 +643,58 @@ test_expect_success 'diff-files respects 
> --no-prefix' '
>  	check_prefix actual file0 file0
>  '
> 
> -test_expect_success 'diff respects diff.noprefix' '
> -	git -c diff.noprefix diff >actual &&
> +test_expect_success 'diff respects diff.noPrefix' '
> +	git -c diff.noPrefix diff >actual &&
>  	check_prefix actual file0 file0
>  '
> 
> -test_expect_success 'diff --default-prefix overrides diff.noprefix' '
> -	git -c diff.noprefix diff --default-prefix >actual &&
> +test_expect_success 'diff --default-prefix overrides diff.noPrefix' '
> +	git -c diff.noPrefix diff --default-prefix >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
> 
> -test_expect_success 'diff respects diff.mnemonicprefix' '
> -	git -c diff.mnemonicprefix diff >actual &&
> +test_expect_success 'diff respects diff.mnemonicPrefix' '
> +	git -c diff.mnemonicPrefix diff >actual &&
>  	check_prefix actual i/file0 w/file0
>  '
> 
> -test_expect_success 'diff --default-prefix overrides 
> diff.mnemonicprefix' '
> -	git -c diff.mnemonicprefix diff --default-prefix >actual &&
> +test_expect_success 'diff --default-prefix overrides 
> diff.mnemonicPrefix' '
> +	git -c diff.mnemonicPrefix diff --default-prefix >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
> 
> -test_expect_success 'diff respects diff.srcprefix' '
> -	git -c diff.srcprefix=x/ diff >actual &&
> +test_expect_success 'diff respects diff.srcPrefix' '
> +	git -c diff.srcPrefix=x/ diff >actual &&
>  	check_prefix actual x/file0 b/file0
>  '
> 
> -test_expect_success 'diff respects diff.dstprefix' '
> -	git -c diff.dstprefix=y/ diff >actual &&
> +test_expect_success 'diff respects diff.dstPrefix' '
> +	git -c diff.dstPrefix=y/ diff >actual &&
>  	check_prefix actual a/file0 y/file0
>  '
> 
> -test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
> -	git -c diff.srcprefix=y/ diff --src-prefix=z/ >actual &&
> +test_expect_success 'diff --src-prefix overrides diff.srcPrefix' '
> +	git -c diff.srcPrefix=y/ diff --src-prefix=z/ >actual &&
>  	check_prefix actual z/file0 b/file0
>  '
> 
> -test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
> -	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
> +test_expect_success 'diff --dst-prefix overrides diff.dstPrefix' '
> +	git -c diff.dstPrefix=y/ diff --dst-prefix=z/ >actual &&
>  	check_prefix actual a/file0 z/file0
>  '
> 
> -test_expect_success 'diff.{src,dst}prefix ignored with diff.noprefix' 
> '
> -	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff 
> >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with diff.noPrefix' 
> '
> +	git -c diff.dstPrefix=y/ -c diff.srcPrefix=x/ -c diff.noPrefix diff 
> >actual &&
>  	check_prefix actual file0 file0
>  '
> 
> -test_expect_success 'diff.{src,dst}prefix ignored with 
> diff.mnemonicprefix' '
> -	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix
> diff >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with 
> diff.mnemonicPrefix' '
> +	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ -c diff.mnemonicPrefix
> diff >actual &&
>  	check_prefix actual i/file0 w/file0
>  '
> 
> -test_expect_success 'diff.{src,dst}prefix ignored with 
> --default-prefix' '
> -	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix 
> >actual &&
> +test_expect_success 'diff.{src,dst}Prefix ignored with 
> --default-prefix' '
> +	git -c diff.dstPrefix=x/ -c diff.srcPrefix=y/ diff --default-prefix 
> >actual &&
>  	check_prefix actual a/file0 b/file0
>  '
