Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B01ACEAF
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427426; cv=none; b=Zy701xuEpTXp/xSFBoqEcoJtqpuM6T1BvhPGc7DlYhwBSTFeXq/+FE7jb0gG+VVjiynjT+alLvrSDQn0m8eJ4ctJlPUFZDn2mrSqaoHyz1JNoZfpm3PJgxSrror7lz+dGBA5YB5b/6qj9BzrVNE3mki7TVF1jqWZagp0dFSTx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427426; c=relaxed/simple;
	bh=p+CjH0QL1iUZ3pt8LDbvIFZPc4izv8pEbw2bD2UZx4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0b3zJdJBFTePNXAbC87EKtzaY4GO0Z4fPCYe9FpN0CVnD3WxbgN8VsgzS3tFXusPSt4e1oslziOsgnogwG7G/3HvwFPyezMObgsHLzz0HWatoZ93xNm6RYDUO5BwGWJgZCTRVeksXRVZyRrL6K9r/fX8I+F/NshU+07uLGoEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFTS3CJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmZypNLo; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFTS3CJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmZypNLo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4030F1140189;
	Mon,  5 May 2025 02:43:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 02:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746427423; x=1746513823; bh=i3ionFJZuH
	WbY6VAp9cHTLJSrLfmVrzNW4zKtQWvQd8=; b=KFTS3CJhI9sZGxhockEHIuB389
	KX1LmMVXaVhvbnRNwJhyxffadjKpnRukp2DxPheNTV9eCM9oWyEKb/OMkJJa4fuk
	KeQJAMyFBuKLE5aZsq9ruoL59I2h1MzpRg/WE3WxdzYfwnhPPeeUEmi90DlP4Acr
	meNqjLPhZ39VePzQmbgYJ0m900csEaeU8j6JysBknEjSY3JCjSFZLUIBVI1TRsp0
	3FJCvkYUdFTN/OAbTqAJWnepKjhtwR0HYBWbYQMur+dVhy7H/jIkQalM2DCnG9fO
	aUwSKExDF8lC20AJKOswKtKVAwhIOJ64xeLipXnLs2p3U4SCc+T+KlpPmwFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746427423; x=1746513823; bh=i3ionFJZuHWbY6VAp9cHTLJSrLfmVrzNW4z
	KtQWvQd8=; b=vmZypNLobkIeNGKSm5Oe/liPWsUjcRrc35E60O6TPbkkk8ZWqXp
	bZAA/lbEGvvIKLTa569YtW2GpCUQKijH2ORVtmdfIIogSnc7wnMUYsmHBfQ8BgYf
	9ICgXuykZgqRzXW6oxMAZFerNMZ/vHprrC+lFsgatFB1/8wr6Bhx21LCZiSOCVUD
	FfWpq3d+mPlr10HAiSCoD3BE1RVno3nzgut7WJBJ4eWXwW3QrEDEfz8fJsKgyeEa
	92UY83d2+aI/p9BjCSWlCalRZN/tYbb/SH3f3YhO8StvN2eHxtgxvXt6nH6zQRNh
	5i26lUTotk0nV2RUda17oZKOXHb98mLLymw==
X-ME-Sender: <xms:Hl4YaBXG-gWgW9c8eiTA1ztTDrKyMwUu7cF31gyjop55xUxhYcQaIA>
    <xme:Hl4YaBlRD_MLr_v62YqFEqPMrpXLlzblkNZ04dJyfb7fWzKeef13IWpXxzqrezCtB
    TUYr5A28edEPB60pQ>
X-ME-Received: <xmr:Hl4YaNZVzqjyb2V5OJDbb5hftozsUVZ3wZOIfUwNBqQ1uRbB_wshLf3x7_8Bc8EcNt6DUrLCRj3Yt7MBHjd7N2cNIUzjWMBO9D-Drzi83_KbxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:Hl4YaEU8JDsIFr-0lBIEkGhVovAA2Vq4SwhQHj9_xDebb-7GTe-q1g>
    <xmx:Hl4YaLlrc1491FF6zriI3pcH4FRDWHF3bgQ5fzria4cOjkt2Kjdnhg>
    <xmx:Hl4YaBewXyd0RWiarTiKc83J7LfbmfHE42mCKGSBAH03_MZhOOuzVg>
    <xmx:Hl4YaFE1xHXimEebegMWhQBv0rOQUOkhetifyBGVy5d6VGPN1OYEEA>
    <xmx:H14YaPwvcG4P3yebbO4D9_hQujL1XTf7kszZrb9iQCtkbnJwS-nrzUTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:43:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89d2cfc0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:43:40 +0000 (UTC)
Date: Mon, 5 May 2025 08:43:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE
 where POSIX uses ELOOP
Message-ID: <aBheGySF1FTsIVzx@pks.im>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <20250503041718.42195-1-collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503041718.42195-1-collin.funk1@gmail.com>

On Fri, May 02, 2025 at 09:16:51PM -0700, Collin Funk wrote:
> As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
> symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
> 
> This patch fixes the following test failure:
> 
>     $ sh t0602-reffiles-fsck.sh --verbose
>     --- expect	2025-05-02 23:05:23.920890147 +0000
>     +++ err	2025-05-02 23:05:23.916794959 +0000
>     @@ -1 +1 @@
>     -error: packed-refs: badRefFiletype: not a regular file but a symlink
>     +error: unable to open '.git/packed-refs': Inappropriate file type or format
>     not ok 12 - the filetype of packed-refs should be checked
> 
> FreeBSD has the same issue for EMLINK instead of EFTYPE.
> 
> This portability issue was introduced in cfea2f2da8 (packed-backend:
> check whether the "packed-refs" is regular file, 2025-02-28)

Ok, makes sense.

> diff --git a/wrapper.c b/wrapper.c
> index 3c79778055..f74e3f7747 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -737,7 +737,26 @@ int is_empty_or_missing_file(const char *filename)
>  int open_nofollow(const char *path, int flags)
>  {
>  #ifdef O_NOFOLLOW
> -	return open(path, flags | O_NOFOLLOW);
> +	int ret = open(path, flags | O_NOFOLLOW);
> +	/*
> +	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
> +	 * time this errno occurs when O_REGULAR is used. Since we don't use
> +	 * it anywhere we can avoid an lstat here. FreeBSD does the same with
> +	 * EMLINK.
> +	 */
> +#ifdef __NetBSD__
> +#define SYMLINK_ERRNO EFTYPE
> +#elif defined(__FreeBSD__)
> +#define SYMLINK_ERRNO EMLINK
> +#endif

Nit, to make this a bit easier to read: our style guide says that nested
preprocessor directives should be indented by one spaces. So this would
become:

    # ifdef __NetBSD__
    #  define SYMLINK_ERRNO EFTYPE
    # elif defined(__FreeBSD__)
    #  define SYMLINK_ERRNO EMLINK
    # endif

Note that the `ifdef` itself would also be indented because we already
have a surrounding `#ifdef O_NOFOLLOW`.

> +#if SYMLINK_ERRNO
> +	if (ret < 0 && errno == SYMLINK_ERRNO) {
> +		errno = ELOOP;
> +		return -1;
> +	}
> +#undef SYMLINK_ERRNO
> +#endif

These three preprocessor defines should be indented, as well.

Patrick
