Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE8275AFD
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994359; cv=none; b=cQKIq76t7fxQW/hQL20iCnBh8Pdmfdkn6dfRofHWO41g8WbtFdXcFEyLZ3s2Pu6yyvH0/DJARkVOs98UN0isGzKnitxshm8lvrI4Tb7goCUh6Tb/Zs5nb83QJDvxAyFP+pUWwOr8F4Lw36CJ9+xvVDUMyMYRXvhQtbZXCWLEYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994359; c=relaxed/simple;
	bh=Vd/xpeMRo6n9oK1Q/c4BrlyJww/ZjIBwOXCZgBTbYzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hei7XorqormBIkOBMOkFYy76DUp88/DN586g1JwfLK+WuDbArD4gbFkejSZHHMSNMyoaEa5vB92lAe4IBuCdq582wL9/TrnHkeKE9D9aWdF207AZrOcro/PyQDETZsSwtRiZGQdlH3OUj8Fdj1kikl6KoxnCn3Fs6DlhAzySVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vMkhO0t8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EotB8Y+B; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMkhO0t8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EotB8Y+B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40CEA7A014D;
	Mon, 17 Aug 2026 15:19:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 15:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786994357; x=1787080757; bh=RNkT7uoPwk
	HVgtx/yJ/8MTg/YSFKvxgJcWgOJiXf8jQ=; b=vMkhO0t8UZd+LVx6gUtqhGRLbp
	khwh1WbtOmJnWiI7G3JhCoy47V7fzHoR4HJJqQbty/D7y9DJ5zd23OQctyAwLoX+
	HOvI1HI1QrnGV1FyXa0FVsOzH3hZPTnfQYVQ8B5kWaTh4VYuXyZbuaa1dLzTXG8g
	H8+1YimoZnSDYts9Iss9eS3d6IQRPjCkHxdOzpfZRwXUpcDssYIecSMyETIhit+U
	3QtOzGJ0GQz3bSe9THxjxeSKFS1z6nF0A4/RiuyOGn8BboG5k57/RcsNjc4vrVsu
	Nd2dRwIUtlL0GRyZX0l3jaaQLKa5pfjgVuvJMWLmc02Gi61vqgIdD9FhW6jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786994357; x=1787080757; bh=RNkT7uoPwkHVgtx/yJ/8MTg/YSFKvxgJcWg
	OJiXf8jQ=; b=EotB8Y+BTC7S5przcQRJMsxX02SnNz4YmV9YMcUS8yA2DKjQrdS
	scDU6ZpTyTbSTmnCjMRf2Z4oSn2TDh/IAKzZNumRoatKn+UQguCVyaEtzjPb1a/K
	xnWLIEgo3zssr5/TGN4+7vI+6XeQNxCcn9dQC59YQ3X0noXb7Q2z4POXTZGVskLE
	4NihenwbcRC367fImibnGV+xuMXAveMfGdvPqMRoKQ0Y0lyYbrK6sZ2C60OVfQoM
	OUtrCrBh7o0Vi3dhVteFW5JiobC5RshWm8nQs8zrWoDas+tLed/1T3XeW1EgAAqm
	KXpMxZ1y3IR5kfk1Nc+4Tm9dR2gQNnC4bqg==
X-ME-Sender: <xms:tF6DaorKEGZeVEZs0l-v-5pXOh1bcDE_qwmcvmMdVtUDLoYXu84PpA>
    <xme:tF6DamEwKKARSPp37MWBrTP_Ff2fDBtTWJY3u7RrjrR9_v4uBE2lcy2J3Vk2HpZuF
    AUttegVbrKfJhylns5fZPysyGMmu7TGd3S7fLiQ4QloQh7bpcmOKw>
X-ME-Received: <xmr:tF6DaqnHfTiScc7vm_SUGzuFzcyrSuj3Wac0upz7oamd-aMdaBuiaOjYQYSgmeS20L0aLEQKTCoUe1_H6LSUDKGeffRX8te06Q>
X-ME-Proxy-Cause: dmFkZTESI8TSVrsaHCc4LOT9Ed+VKYCbnyZ0iOTF7+Wkbr/3T1/AscMRHciiBpZoMiFoIz
    bpzWHgk+HLgW5kZcWbWuAS5KVnArdZtKaCnJeUTD7ZobKqVY74wQHu8eMkzw0wIpw8L19e
    EzGyNdifE23IXTLUBB1rbmkEOLLPsPxSLoeATNiXAVgnl5u42wDszTbb6dL84zAe85RxSR
    OGrQcsXywiQPZIbSjg/fiKBq2br5DD7QoFJKywb8kE6/xG/WTJ2Bo/NcEtSoKwO390I4mb
    k/Kcc9IPSiLX1o8lkxCaC0m7IBz+jjlxFoy7Ac/UCes6yjh6AZk4+eI74WAhnxR8acM6V/
    TGOoB3eXSr7h3+PIi3GBQ1YBKfNltEHsRxRd7ke0WZ0lnmJCKSIpdbv+mY5jQXRhI5Mq4/
    BLvCS1Sja01RtuWjPKtYTWsqVbzLjUNpm1OTG4Gv7KEk4tM+po6DoOwwpAtuMHFQmVQeYZ
    ww3ljWbEvab2ELSfPslWLS9KoV4ISEAn9JNtV2HtI49KFKjruwn/n2D3j00h6t55C2fryY
    G4NPm6bBc7DRB9ZoQ9ooQMsWvPuKMvo9rZQwUnngiheiGz6IvohkFGOxaJ28Vmmo7Je/Vx
    hsXSl8sFhAcColntT7/174yQm4HZMcSdEBx0SYDJ+yjISW7W4Hk6VngIaRrg
X-ME-Proxy: <xmx:tF6DaplchpVnyaF2pW9ZtBp83CqhcXbNxmrXgKC_eh2Mu1Y-GC1_XA>
    <xmx:tF6Darte1NbqCanae5eeneYa8uEKlvYgsG4ukflvWvspginJCpB8Jw>
    <xmx:tF6DasnYfc67-x_hLpzDXavOHSAAUCqnFiXvUqh1K8jNI4nyr21K4Q>
    <xmx:tF6DamvteJEi7E-H2fi5FdYJxknXxlIfKpqbUuvcgEM1ElPihkJUTQ>
    <xmx:tV6DauG9UJXIacdsw3AArQEJmSvmQTONmFQIx7nBbjeu5codPs8c63tM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 15:19:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: graysongordon-gl <graysongordon1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <20260817185242.22736-1-ggordon@gitlab.com> (graysongordon-gl's
	message of "Mon, 17 Aug 2026 14:52:42 -0400")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260817185242.22736-1-ggordon@gitlab.com>
Date: Mon, 17 Aug 2026 12:19:15 -0700
Message-ID: <xmqqfr0c4kss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

graysongordon-gl <graysongordon1@gmail.com> writes:

> Verified: t5551 over plain http and t5559 over https both pass all 61
> tests, with the four new ones skipping on the former and running on the
> latter.
>  Documentation/config/http.adoc | 17 +++++++++++++++++
>  http.c                         | 10 ++++++++++
>  t/t5551-http-fetch-smart.sh    | 29 +++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)

OK, instead of adding a new test script that weighs 72-line we are
testing the feature with 29-line addition, which sounds like a good
economy ;-).

The code changes and the documentation haven't changed since the
previous round, both looking good.

Will replace.  Thanks.

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
> +
>  http.sslCert::
>  	File containing the SSL certificate when fetching or pushing
>  	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
> diff --git a/http.c b/http.c
> index caccf2108e..94f8dd817a 100644
> --- a/http.c
> +++ b/http.c
> @@ -44,6 +44,7 @@ static CURL *curl_default;
>  char curl_errorstr[CURL_ERROR_SIZE];
>  
>  static int curl_ssl_verify = -1;
> +static int curl_ssl_verify_status;
>  static int curl_ssl_try;
>  static char *curl_http_version;
>  static char *ssl_cert;
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
> +
>      if (curl_http_version) {
>  		long opt;
>  		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
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
> +
>  # here user%40host is the URL-encoded version of user@host,
>  # which is our intentionally-odd username to catch parsing errors
>  url_user=$HTTPD_URL_USER/auth/smart/repo.git
