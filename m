Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F451813E
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897295; cv=none; b=ou0QB9gQH9BJkWvbm9tu7DOObsKtepSXksCvgjBLIHBH2nvWmxwcETfA5jQdt7j0XoZmoq6orfnbFoQOkuRnOYtOnmqvsbJkqyR9IMcf+jmB1l3jZqVek/BLdzvA5gh/ZbPbEfKZQ4p5t/VK4amsilkgHl7VM2ey2oRHgHdNvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897295; c=relaxed/simple;
	bh=Grdwlz7BjR6VEVr1Qyga1wj9kBC5Kcg9BhLHjSUN7Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0UHWRsFzRB0hi6ECLHmT0Usaa67mW9Aln7IgyOnjUovIqNlXy284U6BKRiKkakUaWnhj8mhn7zUUtcgVqQvZZIaL4Po8y3SeOu/uq/npG27dkmULP8NN9GusWNlMbPwcirqGE9nq4sCUiCyi66vm6oQq6KZ3ZopRUif4lehPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H66nc/Aw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wgzdn/Iu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H66nc/Aw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wgzdn/Iu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A5C57A0163
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:14:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 09:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791897292; x=1791983692; bh=bWJmfc/p9j
	3GLRdaDGAimwz/vO3TxSjhoJHEa+BT2Aw=; b=H66nc/Aw9ncVILs9Ku7Vzf3NXw
	sXKgK79eRjKcHMzoPKTTCt4zlZgmqJTYqFcVKmov/i8nNP+6abkIox2tDCcNO+R7
	tZk9+NjheCQRQx6uBfJQhnDFqq7/3OAGHU4ZhEulHjVkk62W04dLZU9g0ohwPoN/
	eRJLzDI03jiYyaA5MGCYct1Q3vFzYyS7nwaxIsgFKNXzuGS3+A7Oe/c98GFWmZUx
	0hUUVGm9DeoD9WhIjgogUZuqnESHVrRQ37vpC+9XdzxfDmpjZk3wx51MYAvEGGpS
	ll4ADKMCvUPX8o6lA6jx3uEtW+03TBnaH0zXaVd2GNzUZBt50e/LN0siyPFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791897292; x=1791983692; bh=bWJmfc/p9j3GLRdaDGAimwz/vO3TxSjhoJH
	Ea+BT2Aw=; b=wgzdn/IuqWdZA/MftJuBL0NpTN0HHEcgYFdgMk7afePK0ctCR6r
	iGajXIykEJZAfKO559AOJaDhTQSIXxtaN2DN6j6gJXL5Bm1UELKu41z4PjKifN7Q
	CQxcXIR9DIZkPeFfOvlHbnNx1+Izv6IuURcLtnj5bJ3v59uCBulNJsXnMEDUMxGl
	ta8LA4zPGHCO/AljZ4y6hf1v+A8QlMEBugc5zU0D648IQZlIxqI1+n8ea4t0TWyJ
	63UPOzt6wiT9OppSZvTLJAmIxv/ZWLiG+1P2pYBppzn7sQlpKgckV3GdqM2krm4S
	dQqigCcOWDWID/IKoj2Kjzcgrf9Nnlyk9Aw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791897292; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sSbZqu2klQj8c8SVU+IxpH3EJyb3hI31sxdrhIw4Hjq1YYh
	6LDSSpT73gzpK6CgjBKhhbc/1FHZru1l6T/CZXkNCpza75b18qAaeNtDhnKWg7z8
	++ZBipFbrgrL0g57Q+KmqGeZdUiRmJJ0CYbcHi9w6NuBJzcFS/9sI9+g6BhLNHfW
	Dq3xqBwZcC1MKs4HtxfVpfgvjEK6b7N46CmnngwgKl841tqFvr6Grz8cA+INWTf9
	OtwVrqFM/CDR7WPzlQtB3LqAyn/mITY1cT1eo/Qj6krpa16eyt+y1ZnSL7SdMuW2
	NsaB8GHgJMemBeuz1fLsSdpQrg7UtuIZIwDG8Vg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CrsPrq4lMj+6MU7SSpNqdkjkpi9XkAuYDyTiLJ5cYqI=:Grdwlz7BjR6VEVr1Qyga1wj9kBC5Kcg9BhLHjSUN7Z0=;
X-ME-Sender: <xms:zC7OajiPmagdmhS8GGlZtj_8u4BM4WbFoOZe2qjQ8Aplkw-FNTo9pA>
    <xme:zC7Oam4x23LYE7T2m6Hc-C1kKTSBg7PBQj58KlaL0aLnirXmHz5qFnFXhunvPHMnl
    4w2XjqxGdtdyfC8_DKjeEMRyqdK6juuDn8X8zKnMVmq3MfLQxSWfOA>
X-ME-Received: <xmr:zC7OarZyN25suDlgzDchTZ1VcHXVPdHRia-YGukV-9AczkWAEd5Isw>
X-ME-Proxy-Cause: dmFkZTGkkDeI20tq9AOWac7teIpwaJUDv8tRvZBYFf3pDa8Gv+C611tLcBQCUB2WpcTBi2
    P28Lg7g1jM5Kp9YdWKZNrlhYoZ0oCvlYwp7+LFkrxnV4u2ugAuFkJoH1wYLBjUSe0I9Rqb
    1eULG9z+lG7y34DyRKer3rq6o1eInntnx+zjf9+WBwwY3+1bYUIUYfR/aryxQFP0GexU/a
    MefGGUXH/vPfYgR11l6aAzCprEjVcYfSj5vBzJ/oRxXT1EjgCmnPugEo5Z7/kG04X8JYzH
    H8JUkuqQCXBdNd+afGgEBe6G/sBP+lbRWHwR1PU69a/4z7d7Aotq1jaqqRrPhYxlfLTdL7
    7l2O9mmmY38peV09T7r8Erx65+OO+zbP7+EbW4mEM/tDzssyuzCzk/m3WQv6A/X37TgHqt
    gzMSmT3dw2KjzbZK0ckqiyBdy7TlwsPjd/DpdWTOZTWeAH8tNCAla0UP326HHOTC8To+fq
    wxFRIDh6dwJSb/0h2QT8DuGFaWS5VRTjBBTvvVafwHMZSgfEc/ftPATdHauNYE5HH+J5u+
    rBnjgDPaakDfE/lCX+ayG0HdIacqDHKllurxz9VgAYJpQbr9ADcrsM31hxBDr2z4hRtj9z
    fu6K6FxbXYCUeNbGQOVtup2CX+7ouZ07CN7XzSjSS3YF1Y8otY/y3jihS74w
X-ME-Proxy: <xmx:zC7Oar6FFNiR1s40sL3STjt4B2xd-5xRluh7t7pHqd56olFhIE0-Iw>
    <xmx:zC7OauBiI7UylHMQqW-8x-g3HkarCeBBVhVQeko2Vi-u-XrvjVFxog>
    <xmx:zC7OahezYlVQRnlHk30dJxFE6lYp8l46KB9GlXx3ycGr9A-5WqSlqw>
    <xmx:zC7OatIyWmnzY4qF-IY2M-TA1hl4guAnACu5XpO3PqFejil2ehF9TA>
    <xmx:zC7OauI8bpzQSjousiOoYRrlOo06f1VnEOomHXsloIXqPY0DuV5YzHcr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 09:14:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2be81f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 13:14:48 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:14:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] imap-send: let OpenSSL do the hostname
 verification
Message-ID: <as4uwMflv6qzcoTh@pks.im>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20261012203057.969878-2-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012203057.969878-2-dev+git@drbeat.li>

On Mon, Oct 12, 2026 at 10:30:57PM +0200, Beat Bolli wrote:
> According to the OpenSSL Wiki[1], OpenSSL knows how to verify the peer's
> hostname since version 1.0.2. A simpler interface is available since
> 1.1.0, which is what is implemented here.

What is implicit here is that Git performs its own hostname
verification. A short introduction explaining the status quo and why
the status quo is insufficient would help the reviewer.

What's also missing is a quick note on the minimum supported version of
OpenSSL.

> As a side-effect, we get all present and future improvements done by
> OpenSSL for free. E.g., the old code did not handle IP addresses in the
> subject alternative names, while the new code does.

That sounds like it's win-win: less code and more supported scenarios!

> If the verification fails, print the error message as returned by
> OpenSSL.
> 
> [1]: https://wiki.openssl.org/index.php/Hostname_validation
> 
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  imap-send.c | 86 +++++++++--------------------------------------------
>  1 file changed, 14 insertions(+), 72 deletions(-)

Don't we have any tests for this? If not, can we maybe add some to make
sure that we indeed still verify the hostname?

> diff --git a/imap-send.c b/imap-send.c
> index 9f21705d77..cd9eae15d0 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -325,6 +261,15 @@ static int ssl_socket_connect(struct imap_socket *sock,
>  		ssl_socket_perror("SSL_new");
>  		return -1;
>  	}
> +	if (cfg->ssl_verify) {
> +		SSL_set_hostflags(sock->ssl, X509_CHECK_FLAG_NO_PARTIAL_WILDCARDS);

This matches the documentation, but it also points out the
X509_CHECK_FLAG_NO_WILDCARDS as a second commonly used flag. Why do we
pick one over the other?

> @@ -352,14 +297,11 @@ static int ssl_socket_connect(struct imap_socket *sock,
>  	}
>  
>  	if (cfg->ssl_verify) {
> -		/* make sure the hostname matches that of the certificate */
> -		cert = SSL_get_peer_certificate(sock->ssl);
> -		if (!cert)
> -			return error("unable to get peer certificate.");
> -		if (SSL_get_verify_result(sock->ssl) != X509_V_OK)
> -			return error("unable to verify peer certificate");
> -		if (verify_hostname(cert, cfg->host) < 0)
> -			return -1;
> +		/* make sure the certificate was verified */
> +		long res = SSL_get_verify_result(sock->ssl);
> +		if (res != X509_V_OK)
> +			return error("unable to verify peer certificate: %s",
> +				     X509_verify_cert_error_string(res));

Wait, this feels fishy to me. Take the following from [1]:

  In other cases where no peer certificate or raw public key was
  presented, the returned result can still be X509_V_OK, for example
  when a server did not request a client certificate during the initial
  handshake. X509_V_OK alone does not establish how or whether the peer
  was authenticated. A suitably provisioned external PSK can
  authenticate a peer without a certificate or raw public key. When
  certificate or raw public key authentication is expected, applications
  must also check that the expected credential is present using
  SSL_get_peer_certificate(3) or SSL_get0_peer_rpk(3).

So this here basically allows for a MITM attack in case the intercepting
adversary simply strips the certificate altogether if I understand
correctly. And to fix that we must retain the call to
`SSL_get_peer_certificate()`.

That makes me want to have tests even more now.

[1]: https://docs.openssl.org/4.1/man3/SSL_get_verify_result/#bugs

Patrick
