Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DD46AA8F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391955; cv=none; b=bA7hBXeh/q2vZIHSeVEGXxAxGNrt+uozRVY2cxN4JQYajXIpe9mmrFykvp4KC7vXt+ZB/n9PFDJYA2V1vISqYBmcNCCPD/lMkmR+e99KVTmLShzgLjxvNBs7wLvcQo3ZE5XABIUYauiFZoqSEN1L4SmxRWNAwnKVABWxRsGJMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391955; c=relaxed/simple;
	bh=NcqmkNlO+cO4zHCbfAXUn+wKXm+4N+L+jLFLYS1khks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGHW1ngNJf+xgqPZ+YdMC1aJgr1tPhpIYWD7tkIZF9KAogsCnC3SPHOMntR1TJ2pTlm23pFlq1Gx5Y+FspScEWHkHgRVlFHVtIOFcs/RQM/2E4gytVbGTc+H2WpekqWsQiPKX8347WYzEnIRuqK7K83UH4rb/A3Duc5HjsJ6YME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FyD00yM8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7Ji380D; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FyD00yM8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7Ji380D"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C66B07A018F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:39:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 02:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792391953; x=1792478353; bh=/X0NUWm1yv
	O4xZNH1LTzyYasr0q5oxC4LCXPboJCdnA=; b=FyD00yM8tWXkbFAxjYhM3wlGO1
	cWOyp3f2cwpNTQNgQbD9duSC4yarj5Q8KO10gpjCSkLe/lhZ0W3dexuv2cdx0kSE
	79CzJUYNGGU0wdlcbGI161AXXFwIdiX5hXuC9/xmjBI/p5kVidYf9TDBhKkiI/NB
	Co2FJUgKT9V5la0oOBdQ7Yy4r3cY4AH0jMc8D511FonEx48Nw8tEDX+g6pjjo9DG
	PnvsVdngQ83xQdBmyNRidF6zfZ9cUJWz0d5ejroOTLlr/qAEs9jk8AdgVRK2Zb/o
	IFz8LPs19SP02cpbEw1+OulA+UEbGFLDbGr3VllSlSfueNZ4aWwRb5/d4K7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792391953; x=1792478353; bh=/X0NUWm1yvO4xZNH1LTzyYasr0q5oxC4LCX
	PboJCdnA=; b=k7Ji380D76nj5tQoxsZiezSfDBRXWfmbMmP5v06Wlb1PGExU6xp
	UU9cBHwut4pfg3mnGE69sMtdfobb/6TAE0vsIS3ya9AxX9oVkpxvUnM8ZSuZPa/r
	xn16V+hzqOW8h17k6ONPn6hXNgq/bngrfOrtUamYH1cBSRRyhvhpcDkDKJuPJafn
	AetY9SAb3iynBhBKAWCsYX/qebvLl8MaPUyUZIdDqVVdc/NAsC7q6wsyV0pIRN8I
	S0hJbi9Fq949MQnN8lddoIAUVGttskBh6USrHAF3wEOGRhYyQytxgS4C3xNCUmYX
	1V74G47crtsFR8d5LqAc8I6OKB5L8f1Lyew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792391953; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CzX2Ig+G1MVSZ8Z3OAnDJoFzmb7LANUlGw9Bn4JCeHx0y2B
	LM5zL7XM885+uWSjUl8w0ug4/6vCyviwQFeDsUzV9bKDJ/jPtuoT+qLfzfImkq2j
	YgCyct6ibVQ64yCfvw+zrZInyyYJdWKQ7itGMvkeXULX01ccfEo9CgKv53eocZLk
	uY75F7IIn850uEYPo/UZw5ChYSbI6lo7KfuNoDHfX2BG00anpHTGsftJYbakeaxO
	kQWtod4OwPdKHDgQ/LM5yl1digLB3sojrkjFI5TLWSQKPeuPJu5xJTkLaw+/+nMx
	Z1L66ngU90n2u57PgEXM8N47aqBP7X3NJ5DOkKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i/bRPy1fJQQ2UAPfUBF83r1DVe043Vg2ejT2obBbIe8=:NcqmkNlO+cO4zHCbfAXUn+wKXm+4N+L+jLFLYS1khks=;
X-ME-Sender: <xms:ELvVajgUT7KyU_LSqyT-O1bJto_CQB_r91sIuJBpfo00m8qCWOxRTg>
    <xme:ELvVajst5yJyamyXQERMRQ8DtcEJR4YFOmr-TEixWCadp3baN6zT7xnTd7shFyBm3
    Ag8iH9rAA00G8v8CVp9owNaFqRRX8yJdGcRLbYM-NDlqjw-J9E6nCU>
X-ME-Received: <xmr:ELvVas6eOLTZIfwHquk6W2l3tYNDmeyBDyejC7GoE8WYeUaHDFhNkA>
X-ME-Proxy-Cause: dmFkZTEu2RnnpAxLtBw4//oJHyp+Efyj5C92tFzem99EgIMrLqYIKtDTv74oMsjNhzpjdh
    pW5f10YQF99LjozQF+h03comkHHoIez60XBAI9CP5QQ/NTDtqRMCUMUHJhhcNMgsfz8+ST
    mXtNuJyYAnDiUQ1xcdJwsK5nhmardICLks/As5iBZ91THHdnqJr9zFSkNGJdXnbAs5zgcH
    JS6LS/YBUp3FPQ9/PPJ+awbZJXS+6ahP1ERllfo05K8pQbBAdqJTke0BxnaWXhdrocmZwg
    NMMMyyYCHnQgdwzctwmGRyISE7d39vvZLXeZqknv1SchfuvSrUdjQMPZwuAbFjKL5pDxjH
    XZSibHF0Yzs9O19PwNPu8ssWcbKFgHxsgH5bByNf5WQsVRVCHZ/U8eDI6FyFiOyYvCh/Ip
    em9BpNCUrWvqGGrcKKhJ9/mTNSKjW3cPI+shn6lWA1Bnw5UaFhpp54LcxgXb0UQ7D5dMnx
    8P/Ps+EtABW8k8fReok3Es5BSutR976SByF+/A0ftp1smJZdQB95NFWFR+3fk5HV0Vnswc
    bJg3mv4pB9qaIDr/CDilusw2pbVpOcvryriIn4lhhTQ+6yjoqDf34H5n6CFww5DNIIEbOC
    B1RS9hpHhAHU96P1MRzhq4cE6MevQTmZ5CAYvusHTliLvP0Wq8jrylA0/+tg
X-ME-Proxy: <xmx:ELvVanMhnoiehfnSJin0Q_F7Vd-cP6C3qnUdWaOAvZ5HyRY5IbCx9Q>
    <xmx:ELvVaitf2zOi2wcovHp8_cDfnGzt4JgN_TtR-ytcORhBuk6TgGsLfQ>
    <xmx:ELvVaiZGvMDkP76k6Cp85hcklXAgLCeBI8Zu3oNfu8ba27O0qClSKA>
    <xmx:ELvVasx4QOR9u8dFa-nEPk4RyPayVpb_gcbZ8-CDpJM-ByPq8pUy0w>
    <xmx:EbvVaj9eTpZe6YgkGRFYKStiwL8YLe4moHN3_WGR8OFe_qgNLuMDK7Tr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:39:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f124479 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:39:11 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:39:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/3] imap-send: let OpenSSL do the hostname
 verification
Message-ID: <atW7DJZwHYK_hABy@pks.im>
References: <20261012203057.969878-1-dev+git@drbeat.li>
 <20261017100956.529225-1-dev+git@drbeat.li>
 <20261017100956.529225-2-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017100956.529225-2-dev+git@drbeat.li>

On Sat, Oct 17, 2026 at 12:09:55PM +0200, Beat Bolli wrote:
> imap-send performs its own TLS hostname verification. This is not ideal
> because it does not support all certificate features.
> 
> Let's use OpenSSL built-in verification, which is supported in its
> current form since OpenSSL 1.1.0. This gets us all present and future
> improvements done by OpenSSL for free. E.g., the old code did not handle
> IP addresses in the subject alternative names, while the new code does.
> 
> If the verification fails, print the error message as returned by
> OpenSSL.
> 
> [1]: https://wiki.openssl.org/index.php/Hostname_validation
> 
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> We cannot easily print the certificate's hostname in case of a mismatch,
> but the cURL branch does not, either.
> 
> Unfortuately, the diff looks bad because two functions are replaced by
> the new verify_peer() function that is completely unrelated.

Would it have been possible to make the diff a bit easier to read, for
example by having a preparatory patch that simply moves code around into
this new `verify_peer()` function without yet changing semantics, and
then changing semantics in a second patch?

> diff --git a/imap-send.c b/imap-send.c
> index 9f21705d77..ec4e28e423 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -348,20 +320,13 @@ static int ssl_socket_connect(struct imap_socket *sock,
>  	ret = SSL_connect(sock->ssl);
>  	if (ret <= 0) {
>  		socket_perror("SSL_connect", sock, ret);
> +		if (cfg->ssl_verify)
> +			verify_peer(sock->ssl, 0);

Why do we need to verify the certificate when we failed connecting to
the peer? We didn't do that before, either, did we?

Patrick
