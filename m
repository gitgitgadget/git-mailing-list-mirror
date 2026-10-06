Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C345C6EA
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296852; cv=none; b=WBkwuAMBg2BrifowkoMN+Qkws1UXoXAXhzYa6hXzTsbFLgrQ+ngKjCQ72VXHgA3AI+/+HOsWQ44IA1/lC9eEFXOADer4Tn5EeA7fOU2peX5t9Sk+PUIjtmRUXiV227qe0uMGuW5zXs4yyBII2qLAE91ld8KubYibw+i3saKgPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296852; c=relaxed/simple;
	bh=1xHCSAgOsWGyeCkZS9ffW9yz7D3FUa/z749N+k1SPF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5Nxd3I/DkLOKLhNqoMrF6fT3vpbZs4fBQYN5ZeXZDaZzj8EfGVY+L4tyHj3LcWNn2hFrBNIxetH3j4sLzWETOpvOQ3eA8J8gpi8hYGY1n0pB6OPLbI2uly6EFHu1OhpbPuhuaBBq0Syyl+V7mBLUXj/yMTX9JiBxiIxPzxex2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oxuu6o4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8FQnT+q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oxuu6o4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8FQnT+q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 901411400103
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:27:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 10:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791296849; x=1791383249; bh=f0O2dfZ6yK
	LILbRecTPxmzIVz2Xsqdu3WpcWHd3Bw6o=; b=Oxuu6o4E/BlMDuhxoyi9sdvWgl
	DFutI83nnfbXZ07eimau15j5NJqfCvtsVoOdLs+/PiPrjZMWtEq8K/Br3+WhtTi1
	EQQjZp4kQIXV/9m1BBuotuy8tFLA22v0qOnkjdBgQVVi2rfjS1IT1uKYQ+ccCfbk
	LbboWvw/wL9BqJey4x1mZFZgjmuh/iCZBphvhHuSoPa/j0rZw8goji7EE3RF9dZz
	Bypu9QuTCzPpc68svRk7wCFljOviTwt8QBqwfXyD/Fd5o15foT33+X+1/4Ira9JO
	CSc5qH+t8IsMHIljmMEmLTAceX4aFLymdGIJLIyUlY7kWsyPY8S4IpDBE48w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791296849; x=1791383249; bh=f0O2dfZ6yKLILbRecTPxmzIVz2Xsqdu3Wpc
	WHd3Bw6o=; b=g8FQnT+qjcngEL80aRNBuOSgEgt+5a25GxubRYAgMgx6U0rycNh
	hUUL9Da27bglnQxZ3wtNVzWyACVqYjXRI4vZx6hVHKNK158cHm+SrELt20H6kRO7
	FQ/w/uHu+xelh5C8Tcrrggr0Mq/LNC6yDAPkdJj2kVx2yXE8tpUhsuTEJ7Dm9QCO
	YhhL9eAW720iJOMBvnwJjVxyQljS/FK1+breGn75AICmbNXtYV6gyt0N3VVPJnog
	gMFpEvUDNGU+w6KmsSJNYaXdsRP4SPzACBQ5PeOOnWOABxjaX+iQGWHOtTkCVGDK
	qa4sLNOqSdVcdnPlQh/Tt6TT8kKPGv2jrKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791296849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Hyn4inaoGlx5+lA/WYeqxLXLKobgHtybCfNLROurS9eGknD
	/v8jmRSHFF2bl0ZXiFztOhyn+Gyjda2XJtmWWcYXD6Hf7/6+39xuGYkShxsQE+aG
	6zffp+XF9TnuyX4q4Ch3ShF6zWUSUJHlJPbbXPFiOsEi+cOxFlUywZajngHx+ZRE
	AEucnSYXMCEKDQtl/zqx4eq4/MbKTIFpfEhXMSx2qJAK21VmULi6Ryhiv3XlChye
	SUj3qoqeLOdbHpA+AIkjfpFn2brT0nyndzHOXn7rn9BZwHxwTRzRakPHC8GVJ/Mo
	g5Wa/AVCKTvIRLCs1Sw2NX0q1gJir2tlryZ5W2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BzQvWxjxRwzxCILapryx6hXlAhXgoBuUeporxp70dvU=:1xHCSAgOsWGyeCkZS9ffW9yz7D3FUa/z749N+k1SPF4=;
X-ME-Sender: <xms:UQXFaoASjZ7TxlwZpC38sIYm6BykoR9V_rm5XhU-z5BSAE_ecO5j3Q>
    <xme:UQXFahih3rFBux31-j8E8s1qogpf8gkcHZGF_ZIsj-KNZtWzHItEwANgEFUdm2qNU
    UUyVCk2ryJ5ngB81DJex-SyDn951nSCnDtglPUPqbtkOOrPLAPn>
X-ME-Received: <xmr:UQXFagk1kICPCFO_43j-M8InAWCVjrgrH1SYi18sEIjuKuZpjtc5-EthzvZYZk9-PKsMVEra8DsurFbiphtbsD6FiKSfE7RYBTiH>
X-ME-Proxy-Cause: dmFkZTFtNp5JBjIbTNuc9LuF2CwnEYSpAhucZ47m7/T4gvXBp16UOtAHikKTZaGYX9A8U/
    S2VoG7dFtamANvneR9CrlIF3SiCKbacihYWXZxxp3ZHvpteCnUhyAf3+kKAIaM7jAMZD2F
    mi9700Rf6jsrMaXe5AK9gSEVeBQilyVUPOq6jyZazCvgZH4a0hyj5E3981o5q7ro1dpxPI
    bZxhlT8m4UwglNJQr96Mb7sTSAMk2k4OF1PDcklUorsbWery6n6pC4J5yiCLyqRvms6uFE
    lNimR6Q/RGxcWVzzd2V+THZRzpc2ScvDV8roNksNeRqn8NfZvSPxHKs01WHgMNIB+GzVSh
    YveiPUzOfRTt+4NFRNfLsdJ2YslzM3KKOtbDiceIYLzDfJBF1S2tgJowgus1sbumWdxsmH
    pWrASkjMwgh0yAv9iPQ2pplAvVmEEJU7kXSiXb1M0+2DrHvCTB+0tMHRWmgSE7PXiLtYPh
    Ft5wYoh+8qcNomJfASKoRWBdQT6LA0aYpUwW9u8SVtEdan4CYf6waPBK/AiDWak24RyRKp
    1u3aGzzmM0bp89GA1a8qJCqBcvcRD9Bznilz4H61IZS7Rvei000zCeWcaY7Zzps1zRFM+s
    Jpnsc9snpBoDzfR8Q4zPw8UDIVb5AFLEF8/IXpT251vZhJi7tIHRWz0vwOWQ
X-ME-Proxy: <xmx:UQXFatq4eNjjb70woVe5CWo18iU0YqoKLDD4ClAb1aANDmZg9PP83w>
    <xmx:UQXFapHGs8O0nwXc-T40r_sG6NaBrSG01pSWAL8hPdOZpVznTw7VxQ>
    <xmx:UQXFapwfNPKD6xYRzP13N-N5Qo2ENlisvSeBN29bVeWD4O1UqeA7iw>
    <xmx:UQXFauqwUuj1Zp8Cnr9MdoGeQGrvNsDcc38_G6U0Ob8qLbUyxuTXyA>
    <xmx:UQXFarGZoL30V39PTUXbqKntpGGEXbim7xKeAUfOB-M654FILcjNY07D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 10:27:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH 2/2] stash push: remove duplicate changes detection
In-Reply-To: <95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 5 Oct 2026 17:35:31 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
Date: Tue, 06 Oct 2026 07:27:27 -0700
Message-ID: <xmqqpkxmgb00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 9a5006e3d92..79fdfff09a2 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1538,7 +1538,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	}
>  
>  	if (!check_changes(ps, include_untracked, &untracked_files)) {
> -		ret = 1;
> +		ret = 2;
>  		goto done;
>  	}

It may be time for us to introduce symbolic constants once we have
three choices instead of two.

> @@ -1664,8 +1664,8 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>  	free_stash_info(&info);
>  	strbuf_release(&stash_msg_buf);
>  	/*
> -	 * ret is 1 if there were no changes. In this case, we should
> -	 * not error out.
> +	 * ret is greater than zero if there were no changes. In this case,
> +	 * we should not error out.
>  	 */
>  	return ret < 0;
>  }
> @@ -1728,12 +1728,6 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  		goto done;
>  	}
>  
> -	if (!check_changes(ps, include_untracked, &untracked_files)) {
> -		if (!quiet)
> -			printf_ln(_("No local changes to save"));
> -		goto done;
> -	}
> -
>  	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) && do_clear_stash()) {
>  		ret = -1;
>  		if (!quiet)

Before the precontext of this hunk, repo_refresh_and_write_index()
is called to refresh the index.  We used to leave early when
check_changes() saw no need to save.  We no longer do so, and
instead keep going.

> @@ -1743,8 +1737,15 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  
>  	if (stash_msg)
>  		strbuf_addstr(&stash_msg_buf, stash_msg);
> -	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
> -			    interactive_opts, only_staged, &info, &patch, quiet)) {
> +	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
> +			       patch_mode, interactive_opts, only_staged, &info,
> +			       &patch, quiet);

And we call do_create_stash().  The first thing it does is to call
repo_read_index_preload() and repo_refresh_and_write_index().

Are we refreshing the index twice now, even though we know nothing
has changed in between, when we run "git stash push"?

do_create_stash() does call check_changes() to return early without
creating stash, so we did save the cost of check_changes() with this
patch, though.

> +	if (ret == 2) {
> +		if (!quiet)
> +			printf_ln(_("No local changes to save"));
> +		ret = 0;
> +		goto done;
> +	} else if (ret) {
>  		ret = -1;
>  		goto done;
>  	}
