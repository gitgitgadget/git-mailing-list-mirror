Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9B199E89
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039442; cv=none; b=IZI6CE1RS2rPUwQD5UzlWBBrDmySZA31mws+67gGSwoy4POJNGFaIwZCjGqLWOInvPP+KN+iSlC8eCbD9/rcEkJw8mqNZJ9NGf7nCWIVzSQlZ1mVThY4Z5TmGYS05fZxNu/rY19YVStOWDhUDpttggQF75rhEXtQAvv9FuGZuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039442; c=relaxed/simple;
	bh=RDk6BQyd+5nO3XYvP0nSqK7vwdBSSdA2sXvDVuyJZ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgNmJt1b+aL8I7Xx0AyC+kHlXoIulJ9p2VO0uwOaPiCR8uW3otxRXXr6Rxe5159vRfg1kZL+KWVhugnKEj6CLriA8pwZmjbYwfyfZkquv79XoM4eKsbFpHEjkjDI7O4EQ+BHQw7NIK4oNYVxI5cE95hC27vHJSDNq+l4WqXW9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dW6TQMvg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcFPV/Qk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dW6TQMvg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcFPV/Qk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A5D9EC013B;
	Tue, 18 Aug 2026 03:50:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Aug 2026 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787039439; x=1787125839; bh=a82jMygv0Y
	Y/csAWTHmir6C+V0jh+wW3NzEmh0EmtFc=; b=dW6TQMvgXRJM0BPaiQ6gbX6xfc
	/+U22HsXZ/hAWRdfaf1kR9W+yXyS0beR8XmSeLDTrLylz4u+jOsfb7EnjT3lYmwu
	c3ksj24Xn1tHE95ZdYNVBFKk4YE+PlZLPalMxnQ+Ik8sy4XeqB2n9T6hjaUXx9a1
	2QVjNEmmB+nkmLy3lFqRC9r4fYW6tvXkplMnjE4x4MFIx8jszpjshkMzSITZCB3P
	xyg2IH9lyAk/l2J2Q4vCkEXqYhb/ti13k/V7nEfT7Or8c79aKPUlwyVhE2oTHZXe
	+Pch3/ZXjzb8ok94q3Gg028YJPCSpVdSu+CsOSVszJMYvlChuyBwNSpFjpHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787039439; x=1787125839; bh=a82jMygv0YY/csAWTHmir6C+V0jh+wW3NzE
	mh0EmtFc=; b=HcFPV/QkqC9MGQwwD0k0JpQNQVl18tw2hYFlocMoFuZUSOf9BkC
	go7SXMKUPO0eY0aqwgQ9ylfiG6V0HJI8cti1kaDF+U2CyJB8GfFyDZ1+FvP6pGQw
	IMLKopmsChUCCjQkLO0QE8PvlCORraZqFwMXp+PlCwoyifc0yFmHViiqVcs/EVZP
	8po2TOGQHTT1RIh4YDtFQPBlxKRfT2Eq+4HFD3wDFyA5CIt+8zCPkIt2bHlGikdl
	1aaYKINA3Iq+kf4UVNM5EvrrnF+tRzmPvgL6E4XXV56HaCHByFHfYZPOtjp12n4D
	uTW9vwo5hxLrOnErhrhhQLCWOOAfjJA0NfQ==
X-ME-Sender: <xms:zw6EauN9VjH4Gxn0WMqkMmL8hQ6CrjIKREs5_7i6QOVyNppIacETqA>
    <xme:zw6EakaDA1Cx55N9Ev_E4JNeBXKIt_ROwUuKLvmH9h1UGUpf-um-WZImeS0QZfxzt
    tTGIm864cKloQEpEqWB9haYJTN4Spo9rjqfjaR7bGqvqkoy-jizaQ>
X-ME-Received: <xmr:zw6EairRdSY-thvNIvlKIgMh8_3hfo8cY1Ceh05LNVpZAc9N-hP8HfYinn4SPPyaL99H_io813zNYueqLzOZ2xAFTcQM_Uf2IqQVaJuF>
X-ME-Proxy-Cause: dmFkZTFR+G/R6QnfCqMeRs+DfeFQaU4aZtSclLnN75oKid/x6Hdh2TFC54wrz3hLj7SnoI
    QfYo/UV6Zv8Ui3dnjYQSCqY63XXPo/tvlqT0Ji8ScKZZpcztHB8wMhNQxPwBE2pU0p/CKB
    dcuFkGLfABRmUBZxNvMWm3J8sO0zzrDOPVPPd1GQ/jOy/nc4vNauofmfwQD66KVuezP4i4
    l5I7WIufkbTA69YpY/VnF8LWJmM27tiltpZlmpAlGe0Xx7+OrQySGnfHi3M4Gy/zVihkSi
    8TlNz+j17kpTtPg/5SLiKv3bMq06ufpGIZ2mWD2/pG7fMEL3zlpSHks5S2IIe0Qj728MMt
    W6a9SD3RuybZhzOYAWKa9NOqjiv0YVprhzi6dY2xEtKJjcbZbtSNyPxnDRej6uSFjUUEKH
    5MIpUOvBJ8vu74xJvauhXhO3VFYr8BgFhR5PueeUGT660l3sjurQG7utH6yslfm86433OH
    nYwXNpnxfx1X5r9I5VWwjxd3VESUEJjJytvMowmME4+cjy92uyfgZ3f3IefrXZLsxkJ1/y
    KXPiCpJyHauyI4w3bB+hyN0s+4XUj+8YNFHnuHcO6+DYiNLyxURos6rkzw79Inql5t4OUV
    3+h/7J7jhq4lVerfnKe5uZ1m7Zl2J4IwPMV02jZCQidlMAY0sqKanSutjaQw
X-ME-Proxy: <xmx:zw6EaoZOmGEnZ05ni8aRYE9P1fWuvVZ-qxR-hTuy7oEC5hFcPY1YBA>
    <xmx:zw6EaqROT2ZWztVrOKiHRcU3EoFfScJ3fdsjQkSUZp0Jrxx1YiON1w>
    <xmx:zw6Eav5ULZJNUBZla7AcblBK41e5JjQsyhROlMd1-7cuWXYHqbAi_w>
    <xmx:zw6EavxtpANkJVRTLJf18V-9Gt8VCnCDNUoVUfcJ03GUh7sljyw-cA>
    <xmx:zw6EagbBdZ1cjr0kkIWsFQiFmlQJBbccexOeh8dHFCIqUiip6DcbKzv9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 03:50:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8763270f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Aug 2026 07:50:36 +0000 (UTC)
Date: Tue, 18 Aug 2026 09:50:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <aoQOxISPfEwh-ik2@pks.im>
References: <xmqqmruqt36l.fsf@gitster.g>
 <20260817185242.22736-1-ggordon@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817185242.22736-1-ggordon@gitlab.com>

On Mon, Aug 17, 2026 at 02:52:42PM -0400, graysongordon-gl wrote:
> From: Grayson Gordon <graysongordon1@gmail.com>
> 
> git asks libcurl to verify the peer certificate and the hostname, but it
> never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request"
> TLS extension is never requested and any stapled OCSP response the server
> does send is ignored.
> 
> On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
> response to the application and takes no view on it:
> SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
> whether the returned OCSP response(s) are acceptable or not", and libcurl
> only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So git
> will fetch from a server whose own staple says its certificate has been
> revoked.
> 
> A GnuTLS-linked build behaves differently, and the difference does not
> come from curl. GnuTLS consults a stapled response inside
> gnutls_certificate_verify_peers(), so the failure surfaces through the
> verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
> not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the same
> server, therefore enforces revocation or not depending only on how its
> libcurl was built. That difference is documented here rather than papered
> over: this option turns the check on where the backend needs asking, and
> setting it to false does not turn the check off on GnuTLS.

This is only part of the story though: GnuTLS 3.8 introduced
GNUTLS_NO_STATUS_REQUEST, and curl 8.10 started to set that option in
case of `!verifystatus`. So with new-enough versions of both libraries,
Git behaves the same no matter whether we use OpenSSL or GnuTLS as
backend. See also aeb1a281ca (gtls: fix OCSP stapling management,
2024-08-20) in curl.

> Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
> Because http_options() is the collect_fn of a urlmatch config, the
> per-URL form works with no further changes:
> 
>     git config http.https://example.com/.sslVerifyStatus true
> 
> It defaults to false, and has to. The option is fail-closed: libcurl fails
> verification when the server staples nothing at all, so turning this on
> globally would break every remote that does not staple.
> 
> Leaving the default to libcurl is not an option either. The same
> complaint was raised there in https://github.com/curl/curl/issues/15483
> and closed as intentional ("Marked as enhancement since this was done on
> purpose"), with the observation that stapling is expected to see less use
> as Let's Encrypt drops OCSP support. If the check is to be reachable at
> all, the lever has to come from the application.

But... don't we still leave the default to libcurl? If
"http.sslVerifyStatus" is not set then we don't touch
`CURLOPT_SSL_VERIFYSTATUS`, either.

I might be misreading this though, as the whole commit message is quite
hard to digest. I'd assume that this is because it's generated by AI,
and it added a lot of the usual weird phrases to the message. It might
be a good idea to adapt the message to have a bit more of a human touch
to it.

> If the TLS backend cannot check the staple, curl_easy_setopt() returns
> CURLE_NOT_BUILT_IN. Fail loudly there rather than carrying on, since
> silently not checking is precisely what this option exists to prevent.

Makes sense.

> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 792a71b413..40b849bf7f 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -196,6 +196,23 @@ http.sslVerify::
>  	over HTTPS. Defaults to true. Can be overridden by the
>  	`GIT_SSL_NO_VERIFY` environment variable.
>  
> +http.sslVerifyStatus::
> +	Whether to check the revocation status of the server
> +	certificate using the stapled OCSP response supplied during
> +	the TLS handshake ("OCSP stapling"). Defaults to false.
> ++
> +This is fail-closed: if the server staples no response, verification
> +fails. Set it per remote, e.g.
> +`http.https://example.com/.sslVerifyStatus`, rather than globally.
> ++
> +What it changes depends on the TLS backend libcurl was built against.
> +An OpenSSL-linked build ignores a stapled response unless this is set.
> +A GnuTLS-linked build consults the staple during ordinary certificate
> +verification, so it already rejects a revoked certificate under
> +`http.sslVerify` alone, and setting this to `false` does not disable
> +that. Where a backend cannot check the staple at all, git fails with an
> +error rather than continuing unchecked.

This information is not accurate because recent GnuTLS+libcurl versions
handle this the same as OpenSSL, as mentioned above.

Also, it might make sense to convert the backend-specific information
into a bulleted list as we may add more items to it going forward. Do we
have any info how other backends like mbedTLS behave? Or do we know that
those all fail.

> diff --git a/http.c b/http.c
> index caccf2108e..94f8dd817a 100644
> --- a/http.c
> +++ b/http.c
> @@ -400,6 +401,10 @@ static int http_options(const char *var, const char *value,
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp("http.sslverifystatus", var)) {
> +		curl_ssl_verify_status = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp("http.sslcipherlist", var))
>  		return git_config_string(&ssl_cipherlist, var, value);
>  	if (!strcmp("http.sslversion", var))
> @@ -1133,6 +1138,11 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
>  	}
>  
> +	if (curl_ssl_verify_status &&
> +	    curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L) != CURLE_OK)
> +		die(_("http.sslVerifyStatus is set, but the TLS backend of "
> +		      "this libcurl cannot verify certificate status"));

Should we include the output of `curl_easy_strerror()` in the error
message? That'd cause us to include the following error message in case
we see CURLE_NOT_BUILT_IN:

  case CURLE_NOT_BUILT_IN:
    return "A requested feature, protocol or option was not found built-in in"
           " this libcurl due to a build-time decision.";

So we could instead do:

	if (curl_ssl_verify_status) {
	        CURLcode error = curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L);
                if (error != CURLE_OK)
                    die(_("http.sslVerifyStatus is set, but could not enable OCSP status verification: %s"),
                        curl_easy_strerror(error));
        }

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 805bec025c..c11e96c1ac 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -680,6 +680,35 @@ test_expect_success 'passing hostname resolution information works' '
>  	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
>  '
>  
> +test_lazy_prereq SSL_VERIFYSTATUS '
> +	test "$HTTPD_PROTO" = "https" &&
> +	test_might_fail git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
> +	! grep "cannot verify certificate status" err
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=true fails without a staple' '
> +	test_must_fail git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL/smart/repo.git"
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=false is a no-op' '
> +	git -c http.sslVerifyStatus=false \
> +		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus applies to a matching URL' '
> +	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
> +		ls-remote "$HTTPD_URL/smart/repo.git"
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus is not applied to other URLs' '
> +	git -c "http.https://example.com/.sslVerifyStatus=true" \
> +		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'

Can we reasonably add tests that send OCSP information and verify that
enabling "sslVerifyStatus" makes this work as expected?

Patrick
