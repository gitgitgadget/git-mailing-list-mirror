Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FB2D3A93
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001979; cv=none; b=T2pz/IgW7nVRQGTcVtIbzEMFffIp7j17utOCqDm+CtIR9cCSARhf8WkHs5WELXl/ZSK+L6dz+ig7C204JV/aLFUsQKZW9TzxkmVqcA2nJ4gGbk1Q3PrcEx76ibUeJSiH1FRzAZGRNMP/GXSYkl5Sm8qqe/pyftqqSzIntXUqycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001979; c=relaxed/simple;
	bh=mmzJgVI+hJyLBgYkrxTvEs4oUEznlghAehW2K0+VFWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upo983Aj1hMwW9nE4IMLGkkbIhiytvpqoLpVtTrr0wYzuAbso3x9ln5RdM6QmgeaTq5Qvz08uyXzb973xxDZ73SD6FZkvZx8yCVG8RjGlDSTqGIIoLOBYN9l751nblAA7rc7d5hEgdaWyVoyOut8S+xpUEp+JAsLinLyfONlvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=NCkamvMB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="NCkamvMB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c21495722so23445261cf.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784001977; x=1784606777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=INjG9p+9/x++1hvfgyOYyOL+AKDfBPYRvumJeSf5gxo=;
        b=NCkamvMB+Hx1oEyGlUdRq6lxK7DmLuFxRMBQFyoofA0G8oPvp3WouP0sCVa1bR83fU
         XUWibRDhixfP7EmR8ndRqmNQHfDN0duuZ7v7Llnx+0vqR6htOf4QVSY/pgbBnMOTYQjI
         CndbgWiTZxecneuWo/+uVj1r5kffkphspkCZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001977; x=1784606777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INjG9p+9/x++1hvfgyOYyOL+AKDfBPYRvumJeSf5gxo=;
        b=Lc6Mj6qz+HPEBDRxFI70DnS3gzUx0Z31lL5oF4yUTJw2cEN/gQ2iD8MaF2mpC72Bfi
         oEtU/qXQXUFM5FZYNYNz/x+2QxCJv6E0/rCNonrIdvawPvY/nNEJejX9sPIQP4fp3YJb
         g5LrhHONU0t7D3+Te4TLH/nEEGCxCpfH79BAHdtgw0avZBlQZPpSPMN8kRneFUv0Kq8f
         17p7PkaUyus59+ZxWm5VXD/nlvgZpySo2cYip9NTKHdhjAUW3jOx1HS7tnnQ8e9J0JCe
         ZM17ucXX/oU7DV9vs8CF96mzFxLH69DnXE9Cn6yaH8OMyyHKtWrQoN9e4sOVQ804ISqL
         laqQ==
X-Gm-Message-State: AOJu0YylT9ySUGpHY2ZesQ7sUvgXekmuJ8u6AOdTRZStPY2/6jSYx1hd
	q47Iw/r9TUX5+/oxu2PETgEvaE8CoCVyuGd/N6H72l89hyk6sK6EFo/+zERMQU7Qwoc=
X-Gm-Gg: AfdE7clmOZHtZtLppULniXOsZuHE11lnCUDoR0ZE30nzJ2+0qrFj2cM+ifTYDPafhT7
	grs3+LWkh744ZRxCTSeGMAu88ss9GdrYKECt9ahzuO1Xunaa0FK0s82FVaJj7QW4M2gRSI6VKua
	BEyOtZH1OlfCrFLAiDQArl9OXAbiww68mZ6h7gtJW9VxU4o6c0XDdadh9n+2Uct37r6UXzrqh1y
	jtymQTQvAy0cTV7izSjRH372dZCOkphQVkjb3ryFJfJ2O+/Yb0qE8LE6tzIB3jhRPtGSNA+uk+y
	Fenggmu0ROdMcH5m5zYM6CateCmcJeC8wugyIs7rWrlrvuvMrY4maVAL7s3V/TAkOZZNsOQWu4L
	XfyTT8p0j4lcE5+28y2U+oYCJT35PgUGwvc2AR4H2ipXx2DRJhgfZNcoV8g87bBUN5siYxVJRsD
	rSMVAPfF8o5VDuFCbxJo5cttYI
X-Received: by 2002:a05:622a:124f:b0:51c:9ad:d77 with SMTP id d75a77b69052e-51e3c2cc1cbmr21740391cf.51.1784001976707;
        Mon, 13 Jul 2026 21:06:16 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cb884e0cfsm105585261cf.29.2026.07.13.21.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:06:15 -0700 (PDT)
Date: Mon, 13 Jul 2026 21:06:12 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <alW1tAnMtOznxrhK@com-79390>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alVn-QmK3K91_tkH@com-76773>

On Mon, Jul 13, 2026 at 03:34:33PM -0700, Ted Nyman wrote:
> Since 8d5d2a34df (http-fetch: support fetching packfiles by URL,
> 2020-06-10), packfile URI downloads have been staged at
> objects/pack/pack-<hash>.pack.temp.
>
> The path is derived from the advertised pack hash. Two processes
> fetching the same pack into a shared object database therefore open the
> same file for append. Their writes can corrupt the temporary pack. If
> one process arrives after the other has completed the download, it may
> instead try to resume at EOF, which some HTTP servers reject with 416.
>
> Use the tempfile API to give direct packfile URI downloads unique
> temporary files. Keep the deterministic path for ordinary dumb HTTP
> pack requests, which use it to resume a partial download left by an
> earlier invocation.
>
> This means that a packfile URI download cannot be resumed by a later
> invocation. A retry starts with an empty temporary file instead.
>
> Add a test which pauses one process after downloading the pack and
> starts another process using the same object database.
>
> Signed-off-by: Ted Nyman <tnyman@openai.com>
> ---
>  Documentation/git-http-fetch.adoc |  5 +-
>  http.c                            | 77 +++++++++++++++++++++----------
>  http.h                            |  1 +
>  t/t5550-http-fetch-dumb.sh        | 72 ++++++++++++++++++++++++++++-
>  4 files changed, 126 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
> index 2200f073c4..533bf381c4 100644
> --- a/Documentation/git-http-fetch.adoc
> +++ b/Documentation/git-http-fetch.adoc
> @@ -48,9 +48,8 @@ commit-id::
>  	line (which is not expected in
>  	this case), 'git http-fetch' fetches the packfile directly at the given
>  	URL and uses index-pack to generate corresponding .idx and .keep files.
> -	The hash is used to determine the name of the temporary file and is
> -	arbitrary. The output of index-pack is printed to stdout. Requires
> -	--index-pack-args.
> +	The hash is arbitrary. The output of index-pack is printed to stdout.
> +	Requires --index-pack-args.
>
>  --index-pack-args=<args>::
>  	For internal use only. The command to run on the contents of the
> diff --git a/http.c b/http.c
> index b4e7b8d00b..5a46e7c65c 100644
> --- a/http.c
> +++ b/http.c
> @@ -2668,7 +2668,10 @@ int http_get_info_packs(const char *base_url, struct packfile_list *packs)
>
>  void release_http_pack_request(struct http_pack_request *preq)
>  {
> -	if (preq->packfile) {
> +	if (preq->tempfile) {
> +		delete_tempfile(&preq->tempfile);
> +		preq->packfile = NULL;

We should be able to drop the assignment to NULL on the second line,
since `delete_tempfile()` takes a double pointer to the 'struct
packfile' and NULL's it out for us.

(The other callers appear to avoid explicitly setting `preq->tempfile`
to NULL.)

The rest of the patch looks good to me.

> diff --git a/http.h b/http.h
> index 729c51904d..2c900779f5 100644
> --- a/http.h
> +++ b/http.h
> @@ -224,6 +224,7 @@ struct http_pack_request {
>
>  	FILE *packfile;
>  	struct strbuf tmpfile;
> +	struct tempfile *tempfile;
>  	struct active_request_slot *slot;
>  	struct curl_slist *headers;
>  };
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index b0080bf204..314a74c433 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -293,6 +293,74 @@ test_expect_success 'http-fetch --packfile' '
>  	git -C packfileclient cat-file -e "$HASH"
>  '
>
> +test_expect_success PIPE 'concurrent http-fetch --packfile' '

Phew ;-).

This is definitely tricky to test, but what you wrote here looks
plausibly correct to me.

Thanks,
Taylor
