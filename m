Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39321D3D6
	for <git@vger.kernel.org>; Sun,  3 May 2026 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846792; cv=none; b=FcYoCHyNXKXleitnXkJ+JwjcVv7mYUPBPVsPHMV4YWl5NCpITNZwnbSuQLY+D6V8cUWLTeBX/2NCnBdEjTExvy9EEJZ1jTD5d0eUkJ7Y6TrkDzYGc5ro8NTRBKjXZYMyOwKsH4gb+AHH/yxBrh39UUqqU68RdGhrp9Xm7Qv49xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846792; c=relaxed/simple;
	bh=Dl2x56y0JSNnkMC/P2PNGlFN9I3UFkqfF8cWEmFqg4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VcH8AemixXLUmMh9EZYp5tfUOUUhjK1jN1xDuGOd054r1L9ISRZzUHfaYCJgDWafyZFOoTOs6a14SR9MytOMq4KQ+LzrvMSucCWZWzznQVW24xR71uMovxHPlsbNIVqtZlNzpCUL6JjAw6tKuTQ60KbmppqLiKsYfAmAEUHxutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PqetDhoL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OatYoG48; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PqetDhoL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OatYoG48"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B20CEEC008D;
	Sun,  3 May 2026 18:19:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 03 May 2026 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777846788; x=1777933188; bh=9fM0qvjZF7
	X8MG50/w9IMPbdRF2ASODPDf8QvQHrfp4=; b=PqetDhoLsNLilGNNLAO0SZsAPv
	TQ6zqbv7KgB02H1IZYGz1rpjhbRlrCdqmZwanr0FWJoKuIuhfLw5hBQlv1eaT0B6
	COMNx88hrEMl30HwXOhj43cPHoXWuLjJr+QaxLVsRWbRaZe8XvS/1Sa9DGGY2IGt
	vv+rZ49tcEiFYzxdDiuZbLsFReN/5a8c1dCTjwpVXzXP9w4zJezM/bK4qXlTW1iH
	Zdc9ER580r2dVFCxjwUex0M1aSTKzU4KjrWpD4sI31CvpEAcflVTbt5I4OnvCiwW
	H6GZArrhIN/711UJy9fMC7h1QvHfHdDYaeY25AMjs8/+PuInlq9VjnqrTPww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777846788; x=1777933188; bh=9fM0qvjZF7X8MG50/w9IMPbdRF2ASODPDf8
	QvQHrfp4=; b=OatYoG4899HaiS7IrJjo0YDozWlbJBxYLLkZ8oLljpO8CiJ/8rU
	+oTMaVoG2uYZ7sChWwB8YJWErwHTLis2domJNCutghq6P+OXwPCpo7rEqlKkP62Q
	f+xeW5aJfv8rYnAY3tMXhFMSiYhve/ZuMFuGh60pHbAVeFQJTfJbpV2r95jwiIRQ
	V89TTp7r8ZP/VuFiDAS5nyt6sYbnIsqgDJZPYrvty6PBKLQyGu0LKf+UCNTS7Nkk
	gRZGLdr08GYXw0dhffmOYSw93ACV48hBFpiZSXvD9lLjSVSGcMocDyi91cV1CFdL
	n40g7ZsKPvi8Rc3eoA4/yDjNsF9HEuY59Mw==
X-ME-Sender: <xms:BMr3adWz79mY4gBFXl5c9EUu6x6YhLgEV9JxzNT6KmI41D5-IohfmA>
    <xme:BMr3afEZnipNsAkLe0IE0mrPm96Q8HtJe3UU0ZA4BiGer0rxJSMoZGtgkaUlczEiR
    oW0A-w99gXX5XCVUaNMUmuQlJ2vmxyswTnN4eYI7Dc5OwV5_2fCphg>
X-ME-Received: <xmr:BMr3aZdO4U1LXhrhUGFtFil9-dpQG9ts1nM0pWKErvmQLLo62Hs3yyQoX7j5FQEa6dLlYuTjbS8Tix9cnRlRDLiSqmJeLGcmsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffejvddtveefkefhueffleehtdfhvd
    eiieehheekvedtudejueejlefhgffgvedunecuffhomhgrihhnpehhthhtphdqphhrohig
    hidrshhhpdgvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghmihhnnhhimh
    grjhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrhi
    grnhdrhhgvnhgurhhitghkshhonhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BMr3aQJ6uv4IXBD9Ib7L9AKKjjXBajgm3bcw-CCSrF7jaFA9WLzK2Q>
    <xmx:BMr3aeEGFYuOkJ35gH7EBCK9hDxeyCyu72AmKSjA7Po61SkIrMMvpw>
    <xmx:BMr3aTBV_4hy-RC3gZAXafQ0WHFyNi8Cy5JJoZmv296OZbNp50uRQQ>
    <xmx:BMr3aR_AQyy_FVDiUrHbwFBFxJ1CGD6nqyn6nAPCtf_eGS9GY4FNTw>
    <xmx:BMr3aTjiWO8l7O9odfNKlPlElRYCdd3K5MozICMq69ha00O0lX-UvbV->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 18:19:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: aminnimaj@gmail.com
Cc: git@vger.kernel.org,  peff@peff.net,  ryan.hendrickson@alum.mit.edu
Subject: Re: [PATCH 1/1] http: reject unsupported proxy URL schemes
In-Reply-To: <20260501190401.1580-2-aminnimaj@gmail.com>
	(aminnimaj@gmail.com's message of "Fri, 1 May 2026 19:04:01 +0000")
References: <20260501190401.1580-1-aminnimaj@gmail.com>
	<20260501190401.1580-2-aminnimaj@gmail.com>
Date: Mon, 04 May 2026 07:19:47 +0900
Message-ID: <xmqqjytkrv98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

aminnimaj@gmail.com writes:

> +static int is_socks_proxy_protocol(const char *protocol)
> +{
> +	return protocol &&
> +		(!strcmp(protocol, "socks") ||
> +		 !strcmp(protocol, "socks4") ||
> +		 !strcmp(protocol, "socks4a") ||
> +		 !strcmp(protocol, "socks5") ||
> +		 !strcmp(protocol, "socks5h"));
> +}
> +
> +static int set_curl_proxy_type(CURL *result, const char *protocol)
> +{
> +	if (!protocol || !strcmp(protocol, "http"))
> +		return 0;
> +
> +	if (!strcmp(protocol, "socks5h"))
> +		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
> +				 (long)CURLPROXY_SOCKS5_HOSTNAME);
> +	else if (!strcmp(protocol, "socks5"))
> +		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
> +				 (long)CURLPROXY_SOCKS5);
> +	else if (!strcmp(protocol, "socks4a"))
> +		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
> +				 (long)CURLPROXY_SOCKS4A);
> +	else if (!strcmp(protocol, "socks") ||
> +		 !strcmp(protocol, "socks4"))
> +		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
> +				 (long)CURLPROXY_SOCKS4);
> +	else if (!strcmp(protocol, "https")) {
> +		curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
> +
> +		if (http_proxy_ssl_cert)
> +			curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT,
> +					 http_proxy_ssl_cert);
> +
> +		if (http_proxy_ssl_key)
> +			curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY,
> +					 http_proxy_ssl_key);
> +
> +		if (has_proxy_cert_password())
> +			curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD,
> +					 proxy_cert_auth.password);
> +	} else {
> +		return -1;
> +	}
> +
> +	return 0;
> +}

Can these two be rewritten to be more table driven?  I.e.,

static struct socks_proxy_type {
	const char *name;
	long curlsym;
} socks_proxy_type[] = {
	{ "socks", CURLPROXY_SOCKS4_HOSTNAME },
	...
	{ "socks5h", CURLPROXY_SOCKS5_HOSTNAME },
};

static bool is_socks_proxy_protocol(const char *protocol)
{
	if (!protocol)
		return false;
	for (int i = 0; i < ARRAY_SIZE(socks_proxy_type); i++)
        	if (!strcmp(socks_proxy_type[i].name, protocol))
                	return true;
	return false;
}

static int set_curl_proxy_type(...)
{
	for (int i = 0; i < ARRAY_SIZE(socks_proxy_type); i++) {
        	if (!strcmp(socks_proxy_type[i].name, protocol)) {
			curl_easy_setopt(result, CURLOPT_PROXYTYPE, 
					socks_proxy_type[i].curlsym);
			return 0;
		}
	}
	/* otherwise ... */
        if (!strcmp(protocol, "https")) {
		...
	}
}

> diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
> index 3bcbdef409..db69aa2295 100755
> --- a/t/t5564-http-proxy.sh
> +++ b/t/t5564-http-proxy.sh
> @@ -95,4 +95,9 @@ test_expect_success 'Unix socket requires localhost' - <<\EOT
>  	}
>  EOT
>  
> +test_expect_success 'unknown proxy scheme is rejected' '
> +	! git clone -c http.proxy=htpp://127.0.0.1 https://example.com/repo.git 2>err &&

Use test_must_fail to tell between uncontrolled failures like
crashes and controlled die()s.

> +	grep -Fx "fatal: Invalid proxy URL '\''htpp://127.0.0.1'\'': unsupported proxy scheme '\''htpp'\''" err
> +'

Avoid insisting the exact match with such a long line and stick to
the essential part, like "unsupported proxy scheme '...'".

Also use test_grep for better debuggability.

