Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757FC33064A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014786; cv=none; b=IJSsLb+3zrhBAZiv2PIoT0blo2CKSeFemsC0jgE1lCQ4U2WMeKgyimgVNEYrDYSiRnq61a2n4FmyQwLe8MbC3VC37luRI+GIxSmVH6IpPVsFkKczmzHyAOk6r5djzqW0h23ZnGH8g+qB24h8osjb+KW8976uEDMlfm2Z6mv0hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014786; c=relaxed/simple;
	bh=M6qu951JOPlVntl91pYdFiVc/ua0gxbE+7cEvEvn330=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASAhyJDbofmwl8z8K4HNkNo2NStb7icgVCu721l7Yiod0RpOVMzyyREycXCZKHmYPtNMhWVEp3YxeemdFd+3/DjtUpkDXoUIg96MG9YkUHKCHP5NnuDI3Y7fGG7fDR8LD1PHRpR2vQccuG95wmbg2XTTF6G6aKmyEq4hYzAtu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mq52N9/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdALH4Cb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mq52N9/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdALH4Cb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 80942EC012B;
	Wed, 17 Dec 2025 18:39:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 18:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766014782; x=1766101182; bh=SgduUQ9DLH
	+3/KzxmrVPhCO0gnyznC0geYvMwrd4M7s=; b=Mq52N9/RhoW9u9HkAfHfWKcujU
	K8gMPi8C3ZihEZAObKTyGbphLedmUY3p43Y3Vz3OIAkDilojCVepP79f/FQgsMM+
	hEA+M7ssla2zBzBRq5e6RAhsp9TbJuYHgpS2z14eJe0ZimBL8o4WXLqz3n93bEDd
	yPU1usV3s48lltygY+P0IITYj1+Iwp+HbHI4jT9qXP7IJQaKUwv4LJUTCYpTGtFy
	03AWRPSeoTL7wV+XPNvWMQuzl5Imr/xgJ3r0U/McGXypTYMVUNXPx6jB0r/nbpwD
	reUWcrGbv28arajADF6G/3svgD4QKVizPrwg5ZQpDTtXEYAYso96EMsSiCqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766014782; x=1766101182; bh=SgduUQ9DLH+3/KzxmrVPhCO0gnyznC0geYv
	Mwrd4M7s=; b=ZdALH4Cb1CacSpyElI/M26WbWuEWsoWz9BMV4f1Tk4hJiUi+fVo
	ANVyXUbXorVFkBA2PfDlz1gsBXmwk2P4hBOerifWHZ0rJ1oqcqbrglEie9Y2S/0F
	h0PsbhiUVnIVikgOe7CbkWHFCg+qbjYdvjQY/8hRpHwtgyxBHdq/qvpgNJfzjhoc
	9cv9pwSFTv4YL9hhl2p3JeLEQgqcKfm290XDbJS+/Rk/qtTn7md88wh0GluBGFGf
	FyXmpBp1gwU3QgwfJzytY5zXdH5zp9MFTheMSMPO3JNMJv7d3Y7JfDCI4SSTeRWs
	WS1MWseWc9gUjQjEyzLd6TZ1MswovQP9u7g==
X-ME-Sender: <xms:Pj9DaRCAD30euwpD6ZqnsFWISPi3J1cI9fVNwvkuE2AIznaHwiaPUw>
    <xme:Pj9DaWbNlDZEr6ld2N9j8-6kw3sRiltaaqxYMXlQ8Y7zTlP9Nfr-tRTP6ONeIAVGW
    DI2JWSOXREp4C43ESkCY9OoLm9_Q7v95qSYF_G_cBPW6bUjbSpB-g>
X-ME-Received: <xmr:Pj9DaU6r_16SYjf_Shyo5_UZLGmnJXPk0x1n19kDSeALBZqru9znTrjset8Z78Y95QBYumiHiUk0qqQmItEydBx5aKK_88edGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepsg
    hlvggvshesuggtohhnrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Pj9DaXYuTTyaDio0wF1Y2ESszGKX0koKLzggtLHnxRd3GDCl6Vv5iQ>
    <xmx:Pj9DaTiJeGIVIHfbPE4a1mKrzeAfwyBp3jLtYqAlc2j8U4jUvCHUuQ>
    <xmx:Pj9DaY8WN0wIJGoMGxCinbaVfyd26SxxdLYSiaZlPXAKQVSePUBEyQ>
    <xmx:Pj9DaepcxhUh4PHov0IZaVcQLo_YzopQOZh2vI7xSSaTydJzW2rVMg>
    <xmx:Pj9DaXxCEWxGdLTKEP54L9CaHTjNu9gDK2egWbl5B4mCsieq8i5nsEiG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 18:39:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
In-Reply-To: <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
	(Karsten Blees via GitGitGadget's message of "Tue, 16 Dec 2025
	15:33:48 +0000")
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 08:39:40 +0900
Message-ID: <xmqqy0n0znib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Karsten Blees <blees@dcon.de>
>
> The `strbuf_readlink()` function refuses to read link targets that
> exceed PATH_MAX (even if a sufficient size was specified by the caller).
>
> As some platforms (*cough* Windows *cough*) support longer paths, remove
> this restriction (similar to `strbuf_getcwd()`).
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  strbuf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

We've been bitten before by platforms that sets PATH_MAX too low
(i.e., lower than what they comfortably support), so this is a
welcome change.

> diff --git a/strbuf.c b/strbuf.c
> index 44a8f6a554..fa4e30f112 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -566,8 +566,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>  }
>  
> -#define STRBUF_MAXLINK (2*PATH_MAX)
> -
>  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
>  {
>  	size_t oldalloc = sb->alloc;
> @@ -575,7 +573,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
>  	if (hint < 32)
>  		hint = 32;
>  
> -	while (hint < STRBUF_MAXLINK) {
> +	for (;;) {
>  		ssize_t len;
>  
>  		strbuf_grow(sb, hint + 1);

I briefly wondered if this would cause us loop infinitely on a truly
broken platform, where readlink() somehow keeps returning negative,
but we only retry when we got ERANGE (which can be seen several
lines below the postimage of hte patch), so we should be safe.

Thanks.
