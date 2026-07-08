Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AD3CF054
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545228; cv=none; b=ADHzrvj+78zkTXk/qQ4qHex8IxTCutCY8d3sgGWSBzw1VvPhwl6i/wUKMggsjBZ/tzYut73PHwxxYQul5PG+CvFaQe0XAeqyrvV0AFJdLcO4NL192rEOibE+mB9NzCXEWqmpvT3OKzTTvuWuLaQCxJXPKqdA6kV4WMrcK3oGPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545228; c=relaxed/simple;
	bh=iNf5ihGm7GTuWnoNEwCN/uxcmuHd20tcRG++NTlfMP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZQ3Sq9NyHPNTbnP7WIzbQo+CusDRXZJIm5iML6j4+BYhlX21V1JcGBPf5d3YFqnU0XHAlLaOn7KQZeSF5ApzlwWI96aysrgxrtRkaOkF9+qbXBhGe6fHZDs5UJA21fJJEnXtqgiE+XPm4VnsC7Ef9dcTFz2rZ2It0sxnx1301M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A1LwQVgY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5ablfPJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1LwQVgY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5ablfPJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E27867A00FA;
	Wed,  8 Jul 2026 17:13:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 17:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783545225; x=1783631625; bh=kYSSKSJkJG
	2ni05rZS91EO4VOGpbYRxSUoiUvZ3imoY=; b=A1LwQVgYYoeXz3MSt1skrCwHNM
	78xiX023HPC4lV05JQtabULyaWqvFaIevl3yqkA2o8SfOUEBlC5qZcFj0qyjLAH+
	o4YX2AB5QXOMyI06tTInQtgjTTmKsDCkBvGxSkiZXoCYokXPTok4v8CrHKAQN8NZ
	r0jdFVj+oo4/cXquVpl6+MvrMcyupA5N3c1dr1DZcZAso+YwPni5geilqo1qp4zA
	nT49AnTD/2dU0v1r/LQ+9ldbFkwCzpC8HgwfNcBDxIjDWQoypZfUUKOkrDs4I9Rm
	mGRitLlMSjbCZc9aMSlHys2nzGboC/wItgeLvCZO3K69M4k16czAL4kg2xjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783545225; x=1783631625; bh=kYSSKSJkJG2ni05rZS91EO4VOGpbYRxSUoi
	UvZ3imoY=; b=A5ablfPJh71jvYOJdf1LQJkXuFJ7NrhT0bw1DjRW4St8/rsQsBq
	/wSvjapgWA+W0Tl+huu1ipJdhC7+V9TYkPo1JKlg135MHIwE2Sc4TlPlu4VaCgHz
	VhgWaAx7h+k2QWrT9Q6iUrN881CCA6MZej/myxBWzCtKaz5AFy6iW78nLVcqAikq
	OcU0zOXiz51OAo8p2fLRQCUbU1rxzhJJAQDimnVFWOujPTNALwUgqhcUjF2nLUU1
	nq4Rs3Vgf5sPUKCRnBTrsmQ1fnz4GLISdWSJ3AciYtxGgYCyWT2QcE2f8QWqtNCT
	z81pVReSiobR/wXKocWYMc3SylK038EGGAQ==
X-ME-Sender: <xms:ib1OajzO3C45YI2b5zQs_zqnq7vECrjKC0JgLP3-C3fV8yqOOGfTXg>
    <xme:ib1OaiR4zN888ROKMX8hSftln6Zi_pweoOUBpKeO3YbOW7ldBcCAS-lvJzmf6T-24
    1PMYaPv91oGdWtWPa9JF_GMgOLXH9IE09cbv6FJbbyXtKhNCZlmFg>
X-ME-Received: <xmr:ib1OaiWNGWWvcpbVHleqazsUUJKNU6q5WmDPsbGsm5RM2acR5ZfoenN-T_flq7pFnum48ve3h3cCacqXEWFqgYIi1jfHYV1mwf3Kd6c>
X-ME-Proxy-Cause: dmFkZTFNJfGFyc2MYQeTUbxYJVF+sh2EaNSPlFqSk2hpX9sipNOa2kBqHG9al9XQUSo6jz
    ugP3t3313jJHjegt1QINT676oUDP2lkXiuA41VF+XpMZFlxVSRoBLVn243n40Ahk1WMg8h
    ZeHpc8e3n5Gf7Vy/RzY33PJh+wiC3CfAU76OPRXBM3mQtgcDnFOcDag1F7vfVrCmbGTcXv
    mbsYyTi1LA9aPk75FVk/RrIMjmO3kZiyJOgq5CwLEXjDSgzaHVP3ahthlsMv2HD+vd6+sm
    L3G3MFg1h26bqNNvUowFSmK/44/OXEQY+ZY1XfsGX6kukO+PvFvQg+z2zDri0JsYFDDuK4
    LR1P9ki91SpFic9jqooS9qW/TXJdhy9vAJnEBaRQs9/29i2JPV0vhRtM2TpHj1SMBNLiAK
    OnF2Va/ubnmB6ktQwcuTlqrW/NVye4P+x6L2F7Zlw4l2FriGgeB7J6TGFLcwSK28HLgy1h
    W+fd/a5jefqNdYDkFuFMcSiMVMr1iAW9ZJQRYX9nqP+AADi8aUIzAgc9THV8p/A7Ranxry
    YzbUfoJ1EyaFoJUtihppwZZ0etAzdhp6HO9blMbV+uFHE/dO0kDjBiTWdOFyrMx1nWmi5D
    Wq3e2FLV3yoqpx4UbNFyLg8x5t4L+HqfaXPZB65oVVHcFlJj3wOBoca/BHYA
X-ME-Proxy: <xmx:ib1OasZk7A0RAsdRkb777sMCqpBO0_zi2waIzOqMMFWzqQAsUdjEYw>
    <xmx:ib1Oag0C-pfq0sunNr0JIlToWqTZIa6fGzUhrJ-Rl0VOOORjkf8tWw>
    <xmx:ib1Oamjb3MuxpRRcWu4wRkLi3NstBmM7xBIph2RNfiQtUvdoXc3DWw>
    <xmx:ib1Oasbu8zXMEiV7SLWKRPG5PsWXJq-v5AwNjMyKr67XdsLwiHI9bQ>
    <xmx:ib1OahXHJuhPIKaJzId3DU9zYxZkQ0c9RIX-_jGg09cInCVdFJ_BID0d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 17:13:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/2] bundle-uri: drain remaining response on invalid
 bundle-uri lines
In-Reply-To: <20260708-toon-bundle-uri-no-uri-v2-1-09a03d8db556@iotcl.com>
	(Toon Claes's message of "Wed, 08 Jul 2026 17:03:34 +0200")
References: <20260708-toon-bundle-uri-no-uri-v2-0-09a03d8db556@iotcl.com>
	<20260708-toon-bundle-uri-no-uri-v2-1-09a03d8db556@iotcl.com>
Date: Wed, 08 Jul 2026 14:13:43 -0700
Message-ID: <xmqqtsq9qj5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> With this, clone now continues successfully if invalid bundle-URI data
> was sent by the server. This is intentional, because since the inception
> of `transport_get_remote_bundle_uri()` in 0cfde740f0 (clone: request the
> 'bundle-uri' command when available, 2022-12-22) the return value of
> that function is ignored in `cmd_clone()` so the clone can continue
> without bundles.

I am on the fence.

Alternatively, we could terminate the connection immediately, given
that we are clearly dealing with a broken server.

It is one thing to successfully parse the server's response (e.g.,
'fetch the bundle from this address') but fail to follow its
direction because, for example, the resource is unreachable. Since
bundles are optional, ignoring the failure and continuing makes
complete sense.

But it feels different when we can't even parse what the server is
saying.

While a malformed bundle-URI payload is benign enough to ignore
today, future protocol extensions might introduce mandatory
data. Eventually, we will need a robust way to tell ignorable and
fatal errors apart so we can react appropriately. That
classification can wait for a future topic, however.

The patch looks good and matches what you designed well.

Thanks.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  connect.c                   | 15 ++++++++++++---
>  t/t5558-clone-bundle-uri.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 47e39d2a73..1d74c1eda2 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -517,7 +517,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
>  int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  			  struct bundle_list *bundles, int stateless_rpc)
>  {
> -	int line_nr = 1;
> +	int line_nr = 1, err = 0;
>  
>  	/* Assert bundle-uri support */
>  	ensure_server_supports_v2("bundle-uri");
> @@ -536,10 +536,19 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  		const char *line = reader->line;
>  		line_nr++;
>  
> +		/*
> +		 * Do not parse if an error was encountered, but
> +		 * continue draining the response so no stale data
> +		 * is left in the reader for subsequent protocol
> +		 * exchanges.
> +		 */
> +		if (err)
> +			continue;
> +
>  		if (!bundle_uri_parse_line(bundles, line))
>  			continue;
>  
> -		return error(_("error on bundle-uri response line %d: %s"),
> +		err = error(_("error on bundle-uri response line %d: %s"),
>  			     line_nr, line);
>  	}
>  
> @@ -554,7 +563,7 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  	check_stateless_delimiter(stateless_rpc, reader,
>  				  _("expected response end packet after ref listing"));
>  
> -	return 0;
> +	return err;
>  }
>  
>  struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 7a0943bd36..7cc8627e17 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -1302,6 +1302,35 @@ test_expect_success 'bundles with newline in target path are rejected' '
>  	test_path_is_missing escape
>  '
>  
> +test_expect_success 'bundles advertised with missing URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/no-uri.git" target-no-uri 2>err &&
> +	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
> +	test_grep ! "expected packfile" err
> +'
> +
> +test_expect_success 'bundles advertised with empty URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.uri "" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri 2>err &&
> +	test_grep "bundle ${SQ}bundle-1${SQ} has no uri" err &&
> +	test_grep ! "expected packfile" err
> +'
> +
>  # Do not add tests here unless they use the HTTP server, as they will
>  # not run unless the HTTP dependencies exist.
