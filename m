Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA556329A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884322; cv=none; b=a4+4nvD029XekkeS0yP/7oCsgCHyviTDXf1a77myv9ocEL8h2M7ZyDx1lCa3AvT+Fcsiedj622iC9GI4c05GtRdXHQQda/Bh3GXK6qSvs94jiCscdaWzoWvLPRlOVLv0stcy4fEwQoBLWUYW+bRYaKFZlfKp2TAMlOH4bRnarmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884322; c=relaxed/simple;
	bh=0dQ9Bq3OrZ91+iTDq+kVfdZ6iFFq8cLy/nYqHWQ2A1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzbjFmgYk+NF0sTxGdABG+CBUCcj7emLUBIy5aoiZoKZIToTcbwkNNJOdeSybkCrJxvWMpm4MiiOF1U1C40tchOLgM9i2Hq9+gsBmDqXRnV7r0ADt4wmGhi1LWyvMa6fz3xT3ldL/GfQgOD88iMKDpe/soBwGNNbymCSD21L1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v12wBPY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpE8XZwh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v12wBPY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpE8XZwh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EA9BEC00FA;
	Tue,  8 Sep 2026 12:18:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 08 Sep 2026 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788884320; x=1788970720; bh=mFdavpNTQL
	58IyZ5lsGKG7I+hAAqbrigBA1y6ByHwB8=; b=v12wBPY3iaw90iy1tbUVqxpYmA
	RR8Wtz8DomBAuiybh7FnQmfLgq5qRNZHvy3Tihbsm48mIwdJzPfbZxYBjH1wYuN6
	MBy5CKfeCYv0w0H/nSqdhhfkcto7pSBGzkl2VZtHLaqj6rNQCWS5SfbiMyHTdZid
	csyrFT4iLcx7ys4qnKKvE7dDBzZgVlAtrRgnZq0PQWhuZVt/IJTffvnY97VJA7jb
	GjdWDdZ6PHJPgcESEsAQY0lrJHtv6fmu84pA4m0PPDguAL/ZAsSafms9g3QIUSN6
	FLoMeNbJwNDdU0K8jvw1S2Grmk6SFoWtsTZLmpUdg24oy6rR8jYgEFSrS/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788884320; x=1788970720; bh=mFdavpNTQL58IyZ5lsGKG7I+hAAqbrigBA1
	y6ByHwB8=; b=GpE8XZwh7YlclCuBNtK4rUOalToCGc5xQINsttWWJ1XbZLF0PbO
	Gyz6f2ThDGx78IHzCFM9r7R+9WIJqgCgOGeYVIOzayQpJdr6Q7WBjtgDBnRvAm7g
	tBCkxHwbz6XZGCkx09PFYUZLkBB7TtU23c+h7aKf4QAwlYdt7T0+MgayGZHMU7dd
	ic9xpLIup3+5My6xCd9L47xwvrZ1zsOc0rBs8pedHZ/nEfYKEZ0Aa34AxL6Ob41K
	vODg0aWpMwxntaBK1weurLPmY2QFWLQ144WkRjzLtnTA+ZPZifkSScenBxm+F7ht
	Z6KGVSqH/E6IhNE5lHq8+64qoLTOp//nV0Q==
X-ME-Sender: <xms:YDWgajHyyI36vgHdPJKa-fQ6usg9PKufne1H8XBeRAv0LQ5dx4MxPQ>
    <xme:YDWganwcJV1fHe3TM4pau3sRGDMoGUji4gNbto1Me0wbASYGz5MABhzLauYppa_kA
    5lyqzxTfSegUCnx14GrO9rxk9nkBRG-WHonp8Sv2OgQ9DiJ-lAP>
X-ME-Received: <xmr:YDWgaiiRMv9gnYGJTSxkN0oRlVJ_hKVYVHgQYUHiMpEj0JfsQEjhezDHzUVo0-ucBv3JUbaFmn2xT9V-bsJWZCO5lAgdtvngpn5z>
X-ME-Proxy-Cause: dmFkZTGSyoEht8EBCnUo9aIS7qBXm5M5g6q9AVafNFb13ygXshWCACs+EjpLoKrEwtj2gb
    4Zon4hPbXm3+sg/ulEPmzJM8PatJyXndzg+OvwJTPIIJbuuByeG0kBkuYKGALpATWAUKMI
    mI69nvf0moBUJeQCcCQJzv4rnt8oWtGRNma+fb5i+0x9wDd2vEpzEG0Jsw6HfHnkWIeIoz
    ahVfhlzxK+VbngXlM2CJe5lrUlCw63Z7dUx13Q2l6tqZmFtYJ9ly2ddUq9ZU4gbOyMHdX6
    A6TLWElj8bc29oiNsZZ7aFXGvlS1wvXnu+8+sDMNaUll7773CbN67u6YZDzorYugI92Bap
    p4CkE4C0ydXjORlAzNlhs/3DJHRQ1oQOHAuDOTohLelpCOh/QRZrA8T/B7U8rAhm+BzTZa
    0/6OTyLTM+kxYIW9pfy+lIXMhtr1YX7c7SljSe57+dkZaFT5yYQuVOu//01hzSA1JCr/1S
    6T8rf4PeKqqEVCWhBj73UnuEffJWXDaMCim6aX9IF8qH1lUiVeELZ2g0qCdkOkl1i1w2x7
    LUojuKqO/0ssxhjFFWyQcaNIZG35Xjj+VL2wSKmXFf2LaxYC7SMNr48rRQrxBXxA6zhC0y
    WVAG6QcOFn93Q9Z1xgBBnmVGYKctfNiFl8QiQMYUEWG3VK6+qycMP+9IPXAQ
X-ME-Proxy: <xmx:YDWgaqxBnIDAMWlgi777ha43ns820KgiTtHG4VKwDCw9BHuVJzp0vg>
    <xmx:YDWgatL5eULgbE2f4E-QZnaaHsqfJE6a_JEC_njXfVKQJj2KHfl4ug>
    <xmx:YDWgapSLi1jSRaZ-mfnRAs-S5xKkhXjAZZpGCEiGg5Z4AVUbf9nIOw>
    <xmx:YDWgatpvFIWRJgWboIf4nxnHCqnJSPaBwTOIrOI_TPCcLEqIEZHwHA>
    <xmx:YDWgaldm4jadD967LvMvuE219g43ZEcyrFAGUutUugyl2Umaz5Ou2U6G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 12:18:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: James Le Cuirot <chewi@gentoo.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rust: respect CARGO_BUILD_TARGET when locating build
 output
In-Reply-To: <20260908152425.153131-2-chewi@gentoo.org> (James Le Cuirot's
	message of "Tue, 8 Sep 2026 16:24:26 +0100")
References: <20260908152425.153131-2-chewi@gentoo.org>
Date: Tue, 08 Sep 2026 09:18:38 -0700
Message-ID: <xmqqo6e7yaw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Le Cuirot <chewi@gentoo.org> writes:

> Subject: Re: [PATCH] rust: respect CARGO_BUILD_TARGET when locating build output
>
> When cross-compiling, Cargo always writes to a target-tuple subdirectory
> determined by CARGO_BUILD_TARGET, even when it matches the native tuple.
> The script looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
> find (and copy) the freshly built library.
>
> Respect CARGO_BUILD_TARGET in the output path so the correct artifact
> is located.

Nowhere in the above description I see mention of meson, but the
patch is only to cargo-meson that is referenced by src/meson.build
which invites a few questions:

 * Does "make" work fine without any change similar to this?

 * Shouldn't the commit title say "meson" somewhere if this change
   is only for "meson" driven build?

Thanks.


>
> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> ---
>  src/cargo-meson.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> index 75f3cd1..3a558aa 100755
> --- a/src/cargo-meson.sh
> +++ b/src/cargo-meson.sh
> @@ -38,7 +38,7 @@ then
>  	exit $RET
>  fi
>  
> -if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
> +if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET-}/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
>  then
> -	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
> +	cp "$BUILD_DIR/${CARGO_BUILD_TARGET-}/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
>  fi
