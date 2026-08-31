Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C995305664
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160705; cv=none; b=cjRw5QmucyTI5c0Vyizobgo39KCoVddAlkCTeurirSyEDOKFob9esb6wOSIoousw3uwrJmDXvODbJeExutTZkT21mvheShp3gIDsX3KMrrDUBvj2qiKzsx3N5sYK+7yRoYty247vscN3abenijv7X0DBD7Z7kWe32/EPlDxDO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160705; c=relaxed/simple;
	bh=LeLs7x4VqwsHpqWW4NPlw84dJHn4sBNRDts/Wxhsehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ+5RHV5H5uxP5sHY9kptH6yfH25VsHlakEAItIHXBdwC2hZK5wr0IhG2QxM7+DDojI3ngJa+r9DphU3yuTKP32rnSKMQwFhWxmRgoC6OmsvNaQFgyXKtePvzAlYihTwqWnULDM1MpF80fq/oa/QPKFgdmC4oRNYqJWjqDlJkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PLDrmixW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgLgtwXE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PLDrmixW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgLgtwXE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86A737A0158;
	Mon, 31 Aug 2026 03:18:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 03:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788160703; x=1788247103; bh=YmTeA2A2wC
	gOWjZdDw75pMRL8SMVPz5QMugr1xOC8z4=; b=PLDrmixW3w8fW59rIGAg1Jo41d
	DhXpZzlvHOC0HZo0rmatvIYaQWKZ6Zd1m6LI0Xpg71J9mTQoyDihADBm8k2xQ5D9
	9u3p8Q9i4HPafNBcLXoOh1Vih9WsV7fvIlzjIHpR6VXhYTnkyPO5jhdhfDygNBAR
	lmySQool8n79C5G06wWDOAK7j7tAvoy/KYhO3Nw3L/5qC75oclyPrFnqQhK4IqVp
	gnyr8irUTiejZ4o5pJ4CfIwzfOrqbeDPQJVmtonAGQbFn8vPWfZp3HCBGEvpB7Sf
	1CaiTNpqvG/L85Mz/NiVuW4fGtMjmbeX0K60yh5i9U4rTKg8yy2+l5V1aCmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788160703; x=1788247103; bh=YmTeA2A2wCgOWjZdDw75pMRL8SMVPz5QMug
	r1xOC8z4=; b=GgLgtwXE8uL6D+VKbKymuoRwcK2eEUwkfFQ5OKrNayCVgwzpAtM
	mS/9mIxeryBMczexmR/jC8VP9IjCi2W9cDii3U7bUa7tW0IlylheL+XEx+cMKSax
	I9jPGSghZcHSpUbqD86y0yQxwOkNWiARRc5rZ9CzE5brHMO3bxVS/6Xsv1H4xfHi
	RKwOhHg7eupB84ChwCXBlO7vJqwJVDOI39ad0iz06j5TZxxMP3XJZg4EJuGdNshi
	ILJ2yLXhzfCW542KOGHDXfSGltRHazObTHPvW3nuwkH6KnfkfUQDmDvkzGrbSD9c
	Sa1IbXNfe4MF+8RgZ74aXae9Sd6t/a3d9Rw==
X-ME-Sender: <xms:vyqVai4SE6bjwVYmcOaFZshA1q3F-agVsiLe56Ke8MdffbZL_WQRVw>
    <xme:vyqVajUJrjCNqUiCAvdx1XDkOHtyOH7GdhvCTh2sO3yuRXOIlTeqlPv0rwG1Hfjmd
    aZppbkwyVQ3q_13rmcCC-dNyKcHJo1wDhaepGgLGCf28iV5hdzY8PA>
X-ME-Received: <xmr:vyqVau2Rub1VX7QrPLtTyu-cWdbkc-0xVw7WKY-XYt1KdjX5iO8IiTtbQs1rTfEvzU4QTQ>
X-ME-Proxy-Cause: dmFkZTGRhnZOliTU2yaBMsCox/soAq5GyukRJeFrxXfFUF7PmXBQrfGAPlnhGVf2HpDZRZ
    FIWoKdh4UTgGzK3+ds4vwuwNJKEMBrliEgcNdhoDCw4kVkGvY0zN8FvtA3SLXTBDarO/Ke
    1fB7WLcQb2HM1AED22o/P3uFaH+KP2Xn7n4eqDb8ApETJJqqD0oZ2yp7rrcpJwpQ2cZo2N
    Os8sdWak9LVI+S+2jzpFVaPPfpn2so9S0i2g+Q5JgfMjYOS/6TPPGwgHkbxFY0KwyxuKLO
    Uy7b/pojs8s3fd6HX0IDzq4dnF8Xi+U+duHtdbncdRtmBAyWMD+qB199D4TmYmwCGavcoy
    1iYcxb8oZFrtr07m/Yaen46f8lLWmqjdIL9kP4po7z42wmoKIwWVF9Ev/p8fG5H5KaC0sq
    g1i8gQQNQC5Bm4aWoLuah5b9CZoBNCz4yMSs037fOoMZYGUcdjwxkZXH4jsA1KDY7Qh11n
    NE9S9/OySI+sh5Dna0yhyuIKnUWFNe7zAjkGYAmYVr5mZ9czxJNXorz84dX0jsA8F86Qdw
    RUqwosV+lAtBC9TAxOSVamPQbb8+iQeBTH/t5TTs78KGztYXpSa5pDnpS6u/bfdyInho/u
    IrcduT4S6Y5MBkioznKBSMeBqS4mM1h2Nq+7RkI+hgx/uvTRpxy8AL2TvYhA
X-ME-Proxy: <xmx:vyqVao2TZHZV5Y5t7zY9qczFRitGFtu696nSksSAHlfuCznnllxw3g>
    <xmx:vyqVap_8wHsFATyTghO_ipYKh9kH-9PHe8_7X2ltikr3OvvBjBEvhQ>
    <xmx:vyqVat3qR-OdfQbrr07sooimLs2Ss0Lk0fsUkBOd6Ekt_PLlz3G1CQ>
    <xmx:vyqVau-XMPpQdj67oykRHPErGcb-ImHXdS6BSElT5bT1kDh2Ie6yHA>
    <xmx:vyqVasys8Bmhllq08wcDfGpm1n-JpwpKOV-w0oAYgIvw1OsAo3ncu6Hx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 03:18:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d624322 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 07:18:28 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:18:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 3/3] t/lib-httpd: document writing concurrency-safe
 CGI helpers
Message-ID: <apUquYUS6AvR5clv@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
 <374d148f43036077c31c5a55ddb1b59da4d3a923.1786583137.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374d148f43036077c31c5a55ddb1b59da4d3a923.1786583137.git.gitgitgadget@gmail.com>

On Thu, Aug 13, 2026 at 01:05:36AM +0000, Michael Montalbo via GitGitGadget wrote:
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index fc646447d5..f26e1594ab 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -159,6 +159,19 @@ prepare_httpd() {
>  	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
>  	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
>  	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
> +	# Apache runs each of these CGI scripts once per request. Apache can run one
> +	# script for several requests at the same time. A helper that keeps state
> +	# between requests must update that state with one atomic operation. A check
> +	# and then a separate action is not safe: two requests can both pass the
> +	# check before either one acts. Test the exit status of one atomic operation
> +	# instead:
> +	#   - "mkdir dir" fails if the directory exists, so only one request
> +	#     succeeds. http-429.sh selects the first request this way.
> +	#   - "rm marker" (without "-f") fails if the marker is gone, so only one
> +	#     request consumes it. apply-one-time-script.sh claims its one-shot
> +	#     marker this way.
> +	# A scratch file name includes the process ID ($$), so concurrent requests

Nit, not worth rerolling over: s/includes/should include/

Patrick
