Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BE2EA75E
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876698; cv=none; b=Jb3zovUJdX0BayTBl8RKlWXDBObpi7jwwXNfmzE9c4mcjS2mT1A3XWR+RAM1vfd3znU+HngpRQvHehpZEw43gqc0xn2yXkopw0pMrThM3+l/X5HXGVbUnplHpQ8O8zoy1j9WLh/1qQwnLmv2WcAuemNgGqzw4WrLlyqmaqZPdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876698; c=relaxed/simple;
	bh=/23XJojgnHi4bsZ9bcUnCMqoGQdCUPZY04OQSpxaYbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2Tr1JUozxAo787kl5eTQOpmETloVjmnfHoEbUjAL+QE5C7gIyoWosE+EJoSPE6KbVSCnVDNi9W7+VOKQO7GRGRPEr4Q6T11x59MyCk0FtgxhD5j24o5+nOIFriJHv1zTiUJaaVKJUTCuSCTa6pAb8geaAvvCTfeOZV1w7itJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JYcSu2ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6SAYIaS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JYcSu2ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6SAYIaS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 143121400152
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:31:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 03:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791876696; x=1791963096; bh=82nyT067G1
	V23ESj7BoyYuEbsTq+Www9SOTiUulFrCo=; b=JYcSu2oveBD014GkLMgY/4WSgf
	6QHk6kRDAc8MEnnUiRIvsNEz5i5U2+aWJkBSok56oTZoIWFCQVbWQQ1i2E7bfBG9
	66JzU7cq5dFnKPxRQsUoG762cuYROoFv6FHxiNRAvschjqqpjmtz5Odxe7jgsjS7
	jGTilF2Nx4w1byG3PMgFrJWdyXHLOh97WTN8pJL1q0URZyh3QRqW7ZSE1ox2jV0q
	s/VTy/kSE9QzLFbwr/l3XxSAL5wCZLoUuzefjZsX8IJaY0U+dEeIywsOT0WEoj4U
	rw5dX6xXHR77JdilEfXmCB6xjhKQ7rXmt+n5fXqntCB6MAaCsLknSQj8Mo3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791876696; x=1791963096; bh=82nyT067G1V23ESj7BoyYuEbsTq+Www9SOT
	iUulFrCo=; b=E6SAYIaSQrgSz7v5qLJX5OGbfG5MfzfqXefD1yY6GIU3Avt8FVl
	IW+m1ArX/2akFU3l1Nw+isfxnppDRmRk2IlZLIerGD9doasKEmiLExd6wRr8bL+p
	TFP5lAxP1TCAI79aRPU4JC4j6yLrJbo7+3w8tN9TrYsUNa+2jbPS5bVA4fNlLLY3
	eP0yBbXuaCOYiYdyBGFmmMQ8UUDeZL2lQHXmFwLMG4zkPeVWwingAXC/2CMjgwij
	c/A6z1FHfOKotKLRJXttYZqcfBGPJ8ZUTwToi5MqOd8sHnZb7jH9f/1iHC5L70Mq
	1rjr+tMwa3n6LL+GpEwYgV+e05LluY9biWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791876696; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QKdH++XK31v+qChDOEEPFoYVGX61L5K9pVedNmXgqLuEO7K
	X07XWGabBeTyn/3CnmYGh5P/xM8h8KOr4A7e/NKxQRHML2BlIheWETTZXAGMih11
	rioOa2VomiUhT/RX4d0f6wOU8a2VMQ95aw085s4wOGl1hQE4HEVB39PWkt/CNh2Z
	xB6KrYKuEiNAO343VuuzkWQ0adqspRr2WqN3XThTP6Xp51LVg9vJoU/j1TzDvhIT
	e91K//CkgDUN+5y5z+UPPhZp1LrrpAVezm2Q7LvfKJxl8UolHG76BW/iYLu9pAOk
	f68zbMNlfaI9jlnWswH9UriM/yEN2F88SSvK7wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2QqQiYOkl0nWdM81n+OyXFEWF7pQGa72jqdclIaiRfA=:/23XJojgnHi4bsZ9bcUnCMqoGQdCUPZY04OQSpxaYbw=;
X-ME-Sender: <xms:V97Naqxsjonj6Ua71fdPUrmSbHF5_XFGVHMtT-WLvDd0W_-lvvvuBQ>
    <xme:V97Navk8xMHZCeZnNm7pi_iAF6MSPk-L9vZgz6ephDmA2ajv2HHFa-xeCPPGenmle
    dxKZ-agI4mExLulj-YvwR24eFh46SuuHtMk3WUnqAcD-ixWxuYsD3U>
X-ME-Received: <xmr:V97Najl7V1ktsGocLpz2ZIOpddowhP-LFG5fCPz27beA9ogVttGetw>
X-ME-Proxy-Cause: dmFkZTFmayZVlv+t2X04NrBu/zc08phac/lTyxkgtx2sW7JGZxCoNLzenAdXkB+xTxpQx3
    14HdLuzMmHvmfwfpCWX4jWnZVlTbPMqlPSimbFyvUZTX6rHRXtc2fyNrvECTD8Okkiwz+q
    UXgZ8+E65Ama6AahsrU/rMKHS3zRJqHDEFByh6Xca7QSgpMwKYfTkt9Nr1tVXuI2Fmk7d7
    kfDOO6e2c2xVhm0IYqETt0Aa63ba6hUTobP6kqj2ld004XUdWWtAySGFliVe3DSjHDnTKv
    wvEvLIamIRmH0Eb8kLIoilO3qmXu/SACVhphHLqyNCE3xon+U603jD10M+K3hxrT15NvQl
    oHLDa2a7Va4qYl2cBwUG6aDORFE+YY2fzh9Gix5SlK+WviNFbIVvbMtRDT57dUXBavv5Yd
    +KTOjQJtZYIdB8ufYDcnXo8ELmSfFQxr57PDArLfx9tBioybYlhB9Y0lG75qjWIBHoqelB
    ebDJVyD80ovB9pVQZ+OZ03oUrUfbo8Js1zaEsi+McK2/egXwN9gsV4eY94tdj2UM3M2L3T
    4fVk7OTh2vZUrypWJxpld8qQEmhCdgLHxFiNTbChSlQ+3PGnwOsN2P1MUgLH8mFPq2RQjw
    ms/cyK4so5il8kxVLY/7+LNRpmpMiJpHjeUJd2JHnAijTJ3sLtjPTwaUUc/g
X-ME-Proxy: <xmx:V97NahzMsDhLkF4qBmJDxZ-v01MBSbtkYy9U2s4nvOd1q0TqAVHygg>
    <xmx:V97NaoqGgHpNM6Q43Msg7LsiRbeKEFq6-qus-pe0XkxMVf-U6uTVPw>
    <xmx:V97Nag5Jn1NZOkT_xkrabkNEK6PPhB8yKSWInEXFgl3lYRaxHIkJtQ>
    <xmx:V97NaveKoB4pl6v0mxqH4wQE2IZu3J76bOTNf1BZPju5ZtylHQQz_Q>
    <xmx:WN7NavvA7KuAua5p4aKKkPT7VbyaJaMNWTuaIxzOM86lXUujYz27nXqO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:31:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 291fd4ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:31:32 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:31:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v7 2/2] rerere: add "gc --skip-locked" for auto
 maintenance
Message-ID: <as3eUhze_btZJqbJ@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
 <000288119671bad19e5e9e37419766b364daaacc.1791627204.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000288119671bad19e5e9e37419766b364daaacc.1791627204.git.gitgitgadget@gmail.com>

On Sat, Oct 10, 2026 at 10:13:24AM +0000, Thomas Bachem via GitGitGadget wrote:
> diff --git a/rerere.h b/rerere.h
> index feeb0e2c9f..61e986475b 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -10,6 +10,8 @@ struct repository;
>  #define RERERE_AUTOUPDATE   01
>  #define RERERE_NOAUTOUPDATE 02
>  #define RERERE_READONLY     04
> +/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
> +#define RERERE_NOWAIT       010
>  
>  /*
>   * Marks paths that have been hand-resolved and added to the
> @@ -37,7 +39,14 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
>  int rerere_forget(struct repository *, struct pathspec *);
>  int rerere_remaining(struct repository *, struct string_list *);
>  void rerere_clear(struct repository *, struct string_list *);
> -void rerere_gc(struct repository *, struct string_list *);
> +
> +enum rerere_gc_flags {
> +	/* Skip the operation in case the MERGE_RR.lock is already taken. */
> +	RERERE_GC_NOWAIT = (1 << 0),
> +};

Hm. I was hoping that we could avoid introducing both RERERE_NOWAIT and
RERERE_GC_NOWAIT. But seeing the result I'm way less sure about my
earlier suggestion to introduce the gc-specific flags, as translating
the flags is a bit awkward. I think that your version that only has the
RERERE_NOWAIT flag was better, sorry.

Patrick
