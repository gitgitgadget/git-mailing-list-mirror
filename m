Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE34689
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979835; cv=none; b=Zdut68QhDApeFYMANaEc8IZjvH8b6+7mLJKwhG73JLvxodDwOcZ+1mpsPcQzHCueEexmMI4pFph9UHDVPrkGfFjZgnjH3dONwCU15AfsqWnTYOwX159ItaPPOU1kS/Pwba8MO2/VP85ULqpJeJ0YQYY/oTMU93Oc+R1XANbnnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979835; c=relaxed/simple;
	bh=7oF/C8U16jiVhgCHFHlA7OMprWNGILaNJHZu/WVj4Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0n6wFdCi2tqOtHw7rYkIu07ADX2AekkMnMknwdXaq0byfldr5SxDzVsJBtTC5C8/r+AlRZilUXFTTCkqSusNCL/3khGOQGA3Q1mLmLjpkQDY0xGAFuxLdygHV2u51U1V40HEXUusdow91pvQDPsfDkwt9hjJeWh3P/7HcCsUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6IQWGgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eA8442MA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6IQWGgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eA8442MA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4317E7A23AB;
	Thu, 31 Jul 2025 12:37:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 12:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753979832; x=1754066232; bh=aaI5TrH2wW
	cKfRqQnyNySpKgSQKDUzdCRVTksVFfN+c=; b=L6IQWGgdN/9nx+Nfy7wjnenMGB
	ewtxGqGcUGKynDZ2PAOh+bDMxRE2I6jOO5FzfILi0A6Ff+2potPMsvljTnOzdrwA
	Y0IVdF6SB1XvoSqLGPJULXeQ8MpR5qomTEMd+MCgfDuX9yvtcoPGEu5kgBVv7yIN
	1AhbjlS4X82z+r2KsMcR8vep8wsISb9pedZckwwk5gF0S029NWE20mj4bYGgOh9K
	+iK5uyoRJDA8RW3xDdMQUcQvt8EniFbNElPuWzymwoHD2/MUglpFnSmZeI74Lhhv
	lYokE2mnLtuP2UffNEss0emEif+NhfTIOEm2TQ3+Ifc5ZCtYI28CBrubO4qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753979832; x=1754066232; bh=aaI5TrH2wWcKfRqQnyNySpKgSQKDUzdCRVT
	ksVFfN+c=; b=eA8442MAtY/sbo2BHWCwbqb02czc/GtvbXfAh407FW1KmvylBa2
	P4KX2EYBRHeVFsexi6Uf8KBHeZFsTRkd+1xvDHCmxQe+ODxbTw0ARFOB4/w/NEDj
	NE3RLl8UIH9HePGmmUV64w3MXhig6dK312C2UKF3LqI7nGGiDgVfl6ZCJa1+PAGN
	ErYqNB0xClfn/T88wjaoxpwjRad6Yhn9zawnbaR4ubw/uUSJy5nllqRBMfQJh2HN
	b8SiciwF5H6jjTLw15pf14HVUvpd4ctDIXydUTaksxOOewPkRoHRnkDTGGZQ37I9
	MyuSCrAJInoGcekMVBmUrI8HSltyuHcuAyw==
X-ME-Sender: <xms:t5uLaP3ysxyu47eIWJfWPNn4Uud0dCcq3WcqIouii_208ngYFbgLcQ>
    <xme:t5uLaIrRE7ol8cad8KBvgJOZGvHsABaORas1apbEi_Z1KOFItwTv_yQuQc6hD_L18
    bpc2-u5sk3wNOIoMQ>
X-ME-Received: <xmr:t5uLaMdBCrlPkRZB-yWn6MQFxbeuL6SyMbud2Vuxk-Z8Pkt-tz1KobFOMlDoVKwq1xIx27G8ypStf-K8cm2786NQluoB0sPDn5DRs4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:t5uLaHoBLOPbUqhcecN9Mqq5K4WK-Hxygqmz-oUiJPY6gRoSOwPBDA>
    <xmx:t5uLaNGKHrqyPG-bQTKDSopFQ9ry42im5aZVRdXTDtSSQzBlq2Iq9A>
    <xmx:t5uLaHv0T258IB_yE1KQ4lXhMs0T4KxSaQvMjxY3NbAIt4CxhUoIGg>
    <xmx:t5uLaPWAQvQ_YuUmzpFajiQfccoEhEazIBBBjlNN9X5xgwnAU7luvw>
    <xmx:uJuLaDTFIVMeAIlO4d72H236zhkBxiucoJm2x7XyUY_fjlkWxxYGc7Qe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 12:37:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] interactive: do strip trailing CRLF from input
In-Reply-To: <2295f183-038c-4751-b04d-0f1819b67b3a@kdbg.org> (Johannes Sixt's
	message of "Thu, 31 Jul 2025 18:07:36 +0200")
References: <2295f183-038c-4751-b04d-0f1819b67b3a@kdbg.org>
Date: Thu, 31 Jul 2025 09:37:10 -0700
Message-ID: <xmqqbjp0s4eh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> `git reset -p file` on a Windows CMD refuses to do anything useful
> with this error message:
>
>     (1/5) Unstage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? n
>     'nly one letter is expected, got 'n
>
> The letter 'O' at the beginning of the line is overwritten by an
> apostrophe, so, clearly the parser sees the string "n\r".
>
> strbuf_trim_trailing_newline() removes trailing CRLF from the string.
> In particular, it first removes LF if present, and if that was the
> case, it also removes CR if present.
>
> git_read_line_interactively() clearly intends to remove CRLF as it
> calls strbuf_trim_trailing_newline(). However, input is gathered using
> strbuf_getline_lf(), which already removes the trailing LF. Now
> strbuf_trim_trailing_newline() does not see LF, so that it does not
> remove CR, either, and leaves it for the caller to process.
>
> Call strbuf_getline() instead, which removes both LF and CR.

I was looking at vicinity of the code this morning, so I am more
familiar with this codepath than I usually am ;-)

The above explanation makes perfect sense.  It is quite an old piece
of code, and I am kind of surprised that nobody complained for the
past 5 years.

Will queue.  Thanks.

>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  prompt.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/prompt.c b/prompt.c
> index f21c5bf1c7..706fba2a50 100644
> --- a/prompt.c
> +++ b/prompt.c
> @@ -77,12 +77,6 @@ char *git_prompt(const char *prompt, int flags)
>  
>  int git_read_line_interactively(struct strbuf *line)
>  {
> -	int ret;
> -
>  	fflush(stdout);
> -	ret = strbuf_getline_lf(line, stdin);
> -	if (ret != EOF)
> -		strbuf_trim_trailing_newline(line);
> -
> -	return ret;
> +	return strbuf_getline(line, stdin);
>  }
