Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B93FAE0D
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656052; cv=none; b=asGREoOox2XWa7nYxZqPlswWulqrd9HEQBab0Erj4alPCDrHx5nIct9F5gqaczrWXijPZwWRHP0LbEW0vLYCTh71xsYhXSLBOneAg5IuIenVIPNrXtF3QBfNtzqZ7jWaA96pK9LgxEQuM6VNjeZLhXOye8lnzNXb1Y8zO/KfEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656052; c=relaxed/simple;
	bh=Rk18qkpNVmNk3VYeto9rjaitJfxAOjw5Lf7LpJXIxzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN3dWeQ8nx+HReB7awFxDmz/IPc654meDYT/c9fspEC39X/THlzhxUIBbEl6U4SluJIceATDW9eL0Y9D5g9lxtTsxg/G17IV0eelgQb7eyy+cdTmStskJAdAwQyVC70N3BXMwndpo8TMR5S4Olh+p+KiQMKrmF+S7zx9s1JD+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l2MojRgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMC1TdPh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l2MojRgb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMC1TdPh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B13D214000FF;
	Fri,  5 Jun 2026 06:40:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 06:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780656049; x=1780742449; bh=rSKS1+EjWX
	zzsXldfpkMbQNxa9GewV0Tf9tMr0hwKIk=; b=l2MojRgbiM0pyWuDxmJ8MgIy3N
	3I0ioZkjqY5VxN5OSTwd2t3beIkm99Q2CwAC5WeZr/hZFtI5RYOC90RByeZz7HMo
	bUimCpblz/5YgadfL5thV46OttN2tRHY+B8UGkumQGuKrSOWphJS4xv/BXojXj8y
	gD0vv2VWAwRaU4w2W6kGWqeROTqzQnfQnaAWX3LC7bLGG/zgkhZOujZSKaPUsKX+
	Ww6XmTyxGapCaBXFCSKiCX6WGTThzv/SI+AJbAkNljKzOHeLOJSCyUC7oIAEX67E
	TZHF276EqjMG1JBJGGbSW5wPDYxDjYNCBQS5CUAVtGbkBYNrs9/E5n1qNDoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780656049; x=1780742449; bh=rSKS1+EjWXzzsXldfpkMbQNxa9GewV0Tf9t
	Mr0hwKIk=; b=TMC1TdPhmx46IY6Lt1tOw9wSCcEDf7ep70tkysDG/ibjAtRd77x
	y3lKcjHSkq55il9070OoCw8OEyggi0GD24YrOU5YdUNGyDITALQfFjt8kKYL7pU4
	i91pyuuKbOB9HfchpmLEJbc5WJfYyg5EVCox4wMwPcqZ60jX/45ZUyKt4Y2jqopi
	VDMKIva/RvikMVpoT0oJoUy/Gz5WtdBUAFhaLYsoCI2qNaJazFIqvJt9Api1wWoe
	gbp8DDjs0iOsD2M47BGDDgEiEcEpuhDcMHO8GOwdaY0Gwm78R4Uyik2X2Hm2P4fi
	NdZly5omhoyKBLluB0cYQ+B9kgiUB3oyVUw==
X-ME-Sender: <xms:saciaiaRvQy8FjCQKKVui8oPrcSHdJko_zDdXN9ZQIP3mtf5gTO98A>
    <xme:saciautgFGRJY8Il-Zkaae2sZtjryQkXL0y692_3rLx7UPHfbgJ0moBGKWkNi4xW3
    UwaAO-3cSD3Bn_ROZfV8TsbXxZtw_ULO_Xr923AyxRSkGEGeic55A>
X-ME-Received: <xmr:saciakM12nQZQUG8SQ3qe47vpNCxj0srAUnVLksvABnhQMp7rD7sfzI6u3rN-DN6UZcVD-gDkQ3Ccgrwps4Mn5f4f9H7Vj1SC584T_RJ6Q>
X-ME-Proxy-Cause: dmFkZTFmsFmqpy5L3fj8z3WEDOI04G/sV7POg53RL01uykaGXdh4dC4xydPdFxMfQxsUjd
    FMG0hddbruYPKbEmTufb5Co358BtIxP/Tp/dZLeiRLM8Kkd76/kI099ZP+FVWSJkJLBA/c
    AxEzXFVnxKjp8eqzhtbgwQiCX/dT+Tp59BfKtRV3RDWkVBLDONAeiS37Yk0vyBlCw43jLa
    fbUvJYmKpmf/0xwWtX0cjTQq4U2PCG1e1fyNzZPZVz20uIr8rKV6gZnUwZ9oaW5DzGBA67
    FUB06h9sjPVJKy1IOxU8wCnILAmJJNQJsFzN6fyfwD8Wq3NzOSjLQHIj1MLndDsKejtLAw
    MbLqKpppwVIJOziakrLQA+GJGaQ/6YUEABjPHSDcxzgr2a6Xbqd/64TyD2BrnqAB4uGli2
    DJz6hp4g4rmu41m9Kl7aVLH5fihAnY4pRx0cG/GhNe6Eh5fY7il7ZzUbBXWKup7KeTpRmM
    2FrHsmbrH5vqEsDE9uCcsQpNo33ItMWgUTkDEgv3s6MZiZzZHbL6COqm156L3HLaJxGqKP
    nkGUMHuPcQihizZgSYYNh89C4eC6wtvThIHwKUH0WRgFr3h1HpI6vxRffhZImIOJwNRR4I
    hqN3Ml/2dtQ4sXVxVcPcIOmu3uBazw1btqQ5d/fLV5oVJ5GOr9Hr6673/B6Q
X-ME-Proxy: <xmx:sacial7-to9m_aFAO7djW44xnphORtXRBxEJ6-Dc3aavqK77jqzvdQ>
    <xmx:saciaqQ4I6pf0c0C14pNSgtFh4TVdYSP8GNlw_VA2cZd_WFDtN_FMw>
    <xmx:saciaiB64IMoxHv0TUjJ7tVLItpDEZyJBaZMea1DBeA8GPjid71tfQ>
    <xmx:saciaqGbEBWDYR-sIxz7e53HhnUECmsqFxROHMzJXZSAkgLgnMhipQ>
    <xmx:sacialvBx75cpEQLAYSMZIOMfRFl6EnDPEXGn9sJ1ah0yuz7HTOM06zv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 06:40:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58f39e18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Jun 2026 10:40:45 +0000 (UTC)
Date: Fri, 5 Jun 2026 12:40:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: gitster@pobox.com, git@vger.kernel.org, asedeno@MIT.EDU,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v2] compat/posix.h: enable UNUSED warning messages for
 Clang
Message-ID: <aiKnqlI7WdcskDAs@pks.im>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>

On Fri, Jun 05, 2026 at 11:46:47AM +0200, Dominik Loidolt wrote:
> Use a dedicated Clang version check for the UNUSED macro.
> 
> Commit 7c07f36ad2 (git-compat-util.h: GCC deprecated message arg only in
> GCC 4.5+, 2022-10-05) restricted use of the deprecated attribute's
> message argument in the UNUSED macro to GCC 4.5 or newer.

Ah. I was briefly wondering about this because the UNUSED macro already
works. But the important part here is that it's really only about better
diagnostics via the attribute message.

> Clang identifies itself as GNUC 4.2.1 for compatibility, so
> GIT_GNUC_PREREQ(4, 5) does not detect whether Clang supports the
> deprecated("...") form. Add GIT_CLANG_PREREQ() macro and use it to
> enable the UNUSED warning message for Clang 2.9 and newer.

There's a second user of `GIT_GNUC_PREREQ` in "git-compat-util.h", but
that user checks for GCC 3.1. And as Clang identifies as a newer version
we don't have to adapt any other callsites.

> diff --git a/compat/posix.h b/compat/posix.h
> index faaae1b655..88ad29d74b 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -22,6 +22,17 @@
>   #define GIT_GNUC_PREREQ(maj, min) 0
>  #endif
> 
> +/*
> + * Similar for Clang
> + */

Micronit, not worth rerolling over: this could have easily been a single
line: `/* Similar for Clang. */`

> +#if defined(__clang__) && defined(__clang_minor__) && defined(__clang_major__)
> +# define GIT_CLANG_PREREQ(maj, min) \
> +	((__clang_major__ > (maj)) || \
> +	 (__clang_major__ == (maj) && (__clang_minor__ >= (min))))
> +#else
> +# define GIT_CLANG_PREREQ(maj, min) 0
> +#endif
> +
>  /*
>   * UNUSED marks a function parameter that is always unused.  It also
>   * can be used to annotate a function, a variable, or a type that is
> @@ -35,7 +46,7 @@
>   * When a parameter may be used or unused, depending on conditional
>   * compilation, consider using MAYBE_UNUSED instead.
>   */
> -#if GIT_GNUC_PREREQ(4, 5)
> +#if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
>  #define UNUSED __attribute__((unused)) \
>  	__attribute__((deprecated ("parameter declared as UNUSED")))
>  #elif defined(__GNUC__)

Makes sense, thanks!

Patrick
