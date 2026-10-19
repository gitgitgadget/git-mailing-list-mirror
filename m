Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596853921EC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391959; cv=none; b=FyeqsKEL93C8oP8q3pW0eskBNea0rNcMpN1hPxwrkzn0D9MSZLwaTgpwRO3uFQCs1SM/vnoy9DbI6RLwVaDlUIpYDzZmk8q+GhWzR84+Cr3biOFyi6tRA+GGBlKmUebe69nk/qQOL3yt7214yVShWjre9R7tA2gEPs/6pk5DeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391959; c=relaxed/simple;
	bh=gudxJ5BignDJoLqUjbfBKScE8rTzMBGTdhBEo5YrafQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8mQk+Brl/ObFFY7k5pJDT2/6c7eL1OwMaJsOVfSzTCwE5f8nNqYGZ+M2M1GBNxdSakLS/HS9N9MwL7PIW6rEoUBH/HY1tP3VI8smCoAYG2UlPspSLSIaj4ujpXG0CUDoKYla27dnqhJctfkwUnAoFG/C62zFE4NyiwZPBBt34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CNg35p8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w1F5cbEK; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CNg35p8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w1F5cbEK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B1B841D000D3
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:39:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 02:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792391957; x=1792478357; bh=u4MEfmDtq0
	A92Dz+555btlGDz6Y0uUJRcdxVRzHa74Q=; b=CNg35p8CqB43yyg0vCXO0zGLaQ
	i8jUXGBzlZpToVj/yZT/CwQRa/kNgBVMKIwdW74XrLVzWvKd0E1KpkMh3HulA33u
	3FHg/PYUJepenqBIidZ5bu+VUhrZitQbYQfVA35x7FYje4H1CNDgzdVYDfrWSmxi
	XlsROGckE33xapwQrYbnUIRBfnzd/FLEy6QaWMzukxhq6AnrE90W64w4rNHPjyRw
	fDgrwOkiagegZ8qtYOHypwV9JQ3D5bP6jtKMtlu39cArBd39A4nzJSUCAKjQb/BJ
	GrL3NR6aAEuCK34GFtiBAtvTFlC/3JNzvRrOWV+ZdFReMNkof2sZSDLD6m2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792391957; x=1792478357; bh=u4MEfmDtq0A92Dz+555btlGDz6Y0uUJRcdx
	VRzHa74Q=; b=w1F5cbEKVLiR8zfa0JBd6DeGVulU9BQtCm6YIH+V4B2dmmD8sof
	lvRo25WP2BJF0lhduSfXJfbgv58LReH/fiyYn5EluBRO+qsMJuJNdaEch7arU2Hg
	ThbKozWeBaM29hJabOnuehLmUuSTF8Koia3K3FHzNxAX1YVsgesteFQaJThzO+ve
	1wNAc2tkQ1MhaloFcmK1a6rgMx0qiH2L30jslh+wJx85Gsmyw+ttbsmzZaP/gHGr
	vd1svJH1P92BpT8UJ2KKj/QAn4JnD/3f1snaXFo3OxAmiLFdJ7WYdOQH6+EeJzdV
	YrMYm3Xlrd5PXXxEA4eY11HtXboeUbAjx2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792391957; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kBqTbyUaBWFzfuURBNNgEX2iB7terUJAFSxR/EBQldQ0bG5
	qOSdTi1t7C+Zt3kdHk0Gt2xMbqNj7jIaMGt0Hqlhd816nx5tCxnkm2Cf2B/cEKBU
	UuUBOcDGyoVHVuoaAxFFww9EKjW4CuRC6JzVrekDGLMocFjBHbMLVU4xwrdIQeDx
	5XQdQlLs4MLkiRuVwdg8dX6fx5YthnEDLl+e0mAMuo27wfpgi+ZPaRrC2FvYK512
	v3rWnbU2K8L9hSMag5jPpifhx3MUD1nOElKxQtcYy6f0imrLRmQTHXeq9h7VjHny
	2LJU5VL6Eq3esoyMTfXKDfnLkQBGD8RpcluHTVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lxxu6dRAkUkMh5X6fcu5XYRPxrf/0hAQB4QlSxBa3tk=:gudxJ5BignDJoLqUjbfBKScE8rTzMBGTdhBEo5YrafQ=;
X-ME-Sender: <xms:FbvVavGqPdyjo1RTjo9blhyc5hV1mnwKGXAaeVc2o6oARceHL9Z2GA>
    <xme:FbvVakypxQoeJuVUekn_pXmXVjL7MDdnTOf-4nKeTgjUvGPhsClzzBNdMcL__Jgrk
    Cqv0S_ggeYnYy4fARYO5cv0HkwV9OJ7VQIc7U0W0r8HvQJj4CYI9Eg>
X-ME-Received: <xmr:FbvVahnNQAqTr2nUlUjhUUpCWSRb5fNCpz3Xa62iinx1JO8LvvxN4g>
X-ME-Proxy-Cause: dmFkZTE7mhuMB1xd7lO/blWVyyhgPUklLanbS4irIaE6D8o1g4Sqq6iiUde/WJzd77+Kq5
    HcCEtiH4N6tJBHrINf+CjeRBULjQ+4mxHvFapZVdcGxs5zdJrmPQQhqQFPtIjdpZ6tKRZq
    ep5jJklNmdmuuNJ5quUYt9fMKcBLl4IXH+4tkjrR18QWY52/Yu6Nse6YG3LFmZx4V4Vf43
    Ssdff4MCmxYGgnWn4rXm6gqzpzOems2/kMA2t++meStYrIXxZcPApEHMniTAfP6VGlCdIW
    mvIq3WkHULfWhSW+cju4fz9985PIty/UIneZxErw2T8Ed2/Q1Q1zJIpJXt757ZeIZas9UM
    yk7R4XsYorKjOKBoRuLQY5QSZmwn3Ae090xXoJNxeM/KzkvPWtp51VwKHdNBcdha3gjjOq
    dHtL/5UAwFWRk8X90M+VG+NpBTc6Najqjbb9/UeVErgsmg2/OphCn3iE4DSU/T0GjCssfC
    aJ82a9x49fTkOsAWRJ241zoYoBv0jSEREFkqnWtmAdFWsoj+jEJ7oSpDpydT1XGUQP+rpy
    uQdwNZKNKCjN9vvQI6R3mlKVTbTgQ79tdcUAXeYyfrx+XQQV7zvysstLhTs10EEAmrQEJn
    1Wr+2FZEVxnt4DCKF8rcrHFop9F0ng8EprdVd7soPOVpIUiNOKuQu6Yi7EDw
X-ME-Proxy: <xmx:FbvVatmYXb3CH2AgW8RjNLf00V7M5tWaVLrJLjdM2E6lMIOiLvj_0Q>
    <xmx:FbvVajwpaV3GgYBowuvrHifmjhf53Yg6JdqQXt8_G57wDAKiM5RGEA>
    <xmx:FbvVairtKlq9DTB0YtxMPKXj-lTnk-AoaDFQNJaBByBJQExBfX15WA>
    <xmx:FbvVai674AIzET3_qb0hkU89nh5GhQwUFY2nPvU5zyhUd3v1xANkuA>
    <xmx:FbvVaghzi56xTfDfW7ywJrjCj3guHMrN-rP6WEAEtkmXDI7b5KNFxABi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:39:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58e22280 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:39:15 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:39:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/3] imap-send: prepare for OpenSSL 4.0
Message-ID: <atW7EcdjIEodXMD3@pks.im>
References: <20261012203057.969878-1-dev+git@drbeat.li>
 <20261017100956.529225-1-dev+git@drbeat.li>
 <20261017100956.529225-3-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017100956.529225-3-dev+git@drbeat.li>

On Sat, Oct 17, 2026 at 12:09:56PM +0200, Beat Bolli wrote:
> OpenSSL 4.0 deprecated the SSL_set1_host function if favor of the new
> function SSL_set1_dnsname, which fortunately takes the same parameters.
> 
> Add compatibility #defines for the function and its string variant for
> the error message.

This patch does not make any sense -- the only site where we call the
deprecated function is the one you have introduced yourself in the
preceding commit. Consequently, this should already be part of that
commit.

> diff --git a/imap-send.c b/imap-send.c
> index ec4e28e423..526bde2f55 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -248,6 +248,13 @@ static int verify_peer(const SSL *ssl, int did_connect)
>  	return 0;
>  }
>  
> +#if (OPENSSL_VERSION_NUMBER < 0x40000000L)
> +#define SSL_set1_dnsname(ssl, host) SSL_set1_host((ssl), (host))
> +#define SSL_SET_DNSNAME_FN "SSL_set1_host"
> +#else
> +#define SSL_SET_DNSNAME_FN "SSL_set1_dnsname"
> +#endif
> +
>  static int ssl_socket_connect(struct imap_socket *sock,
>  			      const struct imap_server_conf *cfg,
>  			      int use_tls_only)
> @@ -290,8 +297,8 @@ static int ssl_socket_connect(struct imap_socket *sock,
>  	if (cfg->ssl_verify) {
>  		/* follow RFC 9525 section 6.3: no partial wildcards */
>  		SSL_set_hostflags(sock->ssl, X509_CHECK_FLAG_NO_PARTIAL_WILDCARDS);
> -		if (!SSL_set1_host(sock->ssl, cfg->host)) {
> -			ssl_socket_perror("SSL_set1_host");
> +		if (!SSL_set1_dnsname(sock->ssl, cfg->host)) {

So according to [1], `SSL_set1_host` was replaced by `SSL_set1_dnsname`
and `SSL_set1_ipaddr`. So do we know that `cfg->host` really always is a
DNS name and never an IP address?

> +			ssl_socket_perror(SSL_SET_DNSNAME_FN);
>  			return -1;
>  		}

I wonder whether it's really all that helpful to also change the error
message accordingly. Shouldn't it be sufficient to unconditionally print
the new error message here?

Patrick

[1]: https://docs.openssl.org/master/man3/SSL_set1_host/#description
