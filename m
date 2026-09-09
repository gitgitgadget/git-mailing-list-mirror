Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D93E49FF
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984430; cv=none; b=p6UtS6OzK27SlOuDq4MnvJnnDjU1U1YXQ6jkCuxeuEklZF9K6SIYWV+I/qUpxtoDIOiLgBglerVipfEP8JRSUz/2ENONyo8Fh1pAAxRUUfHPAsnmzuzmBHs0BoAwMTphxlSQo8tMwLb/V5MBWScZ/thjHUJRl2goJPYB/1c4oVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984430; c=relaxed/simple;
	bh=cETumMjsM3Ce5uyQrU+pbFoadszN+JA2V/4PNyY/aig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgH26UkCNu75ZxsepEmGOXBznuMbkoPO+eRk3B900yKRglRK3u0Vh+t/TYHQtWw7qhYDKIQGmaMrkXe9INqoDBLTQju2nmovtRx9HxLWQ1VobabP+PJN8wBKcdnMvq6WTjMOTmZMX6NnbKzW19c0uyN9HpE9yNUCOngH3fzn++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AhLTjbvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duL58bI8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AhLTjbvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duL58bI8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 80B1EEC018D;
	Wed,  9 Sep 2026 16:07:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 16:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788984427; x=1789070827; bh=6r541bQWeR
	52hCAX+hxbjD24UbuDa8N3evrvmNMXcd4=; b=AhLTjbvvZaABiJEZTbrAlTq3iV
	JS6jy60g346uLuK6WZ7AgTqWO/i7/Q/2KU7VFViNuuQ34nsqmoJchbfDt/Bo557v
	88bSIVgEAablglaW7IIzevpKwc2vs/rIdpI/UKA+9rL7QA5u9y5Ym0NGshbb1RYb
	aii/3+AQd09eoKapbAXFzz0P3VM8MnWpHFaja1Iwh3Jv68pR7smnyzGLFI1jug0z
	zL2h1jlW0P7w2PBU33Umb19wcOyBCPytCqJ0/TonIjvZMloX1ilU+zSPXNaEi+Pi
	REkWTSOxBL7HMD6yZIXSlO1/Fkq4vC7r/BhE6ZQ+o24VG9RbNr8zVTszeMTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788984427; x=1789070827; bh=6r541bQWeR52hCAX+hxbjD24UbuDa8N3evr
	vmNMXcd4=; b=duL58bI8mHoG7GD1NeExBlCo3rujAAu/BKh+qnmBWXqlbKuZ7VA
	XIg1hmLbLKv6gWO/FGTl+qej96J3TfTXdjqeLr4gZlHcPHHTp3gBs36AysjqDjNj
	0vgCTj6dhVLNk9HJGE4hSlr5Wwtk6wXFkRh5JP4Vbk7b/DD394jqawGgGq8O9Qiw
	mio+tiH4SHyMXX9saA/DE1+iMae1SBPBzN77JHSSTjr+2p0MqOTBN+JGTEnfChdE
	TjQbzNmryc14Ii/WLLrisbE9xLmF9oSTzIM/Vka/+UXh4KNb3IheEk9G2cBkNaId
	SFlyeIwHLe7AITuSO6ixjJeu0XYBTKfF9WQ==
X-ME-Sender: <xms:a7yhaojShylVwIeTi9W1JwyEfU8NB7FqROlJMnKQZq_5FFnbL3S0uA>
    <xme:a7yhaofLLG1FJmSAuFTm9bDmTh1iBXR7Rc_sn3ENOcv3J9SlUYSGOwZ9NrZah6r3k
    JYFHXL1fPb7BE7JBgb6cQYB1MoE8pa_4bH4f6kxyyGCXjgGGnPi8RA>
X-ME-Received: <xmr:a7yhatf636HcRNq-73aKox425CmFTI9EgitS7T2pd4TPqMiuznx_XIEtA02GK-ZZIfP6qBdeTDqHQv7rrubEpXjIxfbHuSElxhje>
X-ME-Proxy-Cause: dmFkZTE2yaL9a3L3HqQ1Tv6lnS+KxHMUTJ+OZbb4wIsx+YvbQtJBInioQ7ky1ryDBwEvhm
    b7lyvVX3+ZLet/DNOkQrdF/6qOwvODVJtWm+AoB99ltGIdhIlFVctPnpYtgHzYw5XReqdZ
    JBTcdAG4tUk6e9/lilXyMQywGnDRkUOO0QiWzh2P2PtzrwIH+keP8QFdiaMpbE3nAThXYd
    LAsdZWMt6TdbbiBKUlvORnWp0MoKUvBro8avroZJ0s1VqcJnzmG6nGiw9xTclYhDxPAAbF
    IgiJ6QPzvkr00kaokEJEbNmU9vqgTOnG1JgyBSY1Q1e8Mwl/buM+b6IqF+2am4J/aEx8CG
    FFimuaNx5euM/LuvEmmF1IfZy3qrqnrLml7YSRT79tjja+RUWH8Mm8XLboV/irTNP/7v/P
    X7DrNz45JrKUowIqklgMXTotAmaR+JM0hFpYBSpfkNw5YVcBUL0ZQ+ciWND0ZngZzycB8r
    81GnOdZfIMdz+nGdjsYazLAYiFuv+t+VRtFG8WW8hjf21XG6arTyKnFnVio1w/vUWlxr10
    mZpVbRYf+2PNpVk8r1jhXkQVvhSMK7aVH8zUBeo74F3QWcEX0CJctq7/N2iF5CDDekNGC/
    SfDmQodQOMrAKckXelKG/7xl61XczbYXR+swwndhsleXo/dmjmauuKgBp7WA
X-ME-Proxy: <xmx:a7yhai97ucCKT5d9octftf9Q3mrPBILgeu-NT1vBP0hojBeqaJBqNA>
    <xmx:a7yhapkoW2_un-D7jBhQIR4kvuKBDM4dKigpweuwBjYzxAYQX2nA-w>
    <xmx:a7yhak9A53V3q0J5IrkqeoEzeW398Pj-7pc-Bw6Bm_BfdkxriMOVyA>
    <xmx:a7yhanll5C_li-dHYSkJ-6fu4HVuXDQb9DlpYhN0zToKOwllWv5cEQ>
    <xmx:a7yhaooqQ7Es6Q37px3Z0W2j8WijQVYaLx0XS4cuHxAzZph_8sxynGdi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 16:07:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: James Le Cuirot <chewi@gentoo.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rust: respect CARGO_BUILD_TARGET when locating build
 output
In-Reply-To: <20260908215344.24843-2-chewi@gentoo.org> (James Le Cuirot's
	message of "Tue, 8 Sep 2026 22:53:45 +0100")
References: <xmqqo6e7yaw1.fsf@gitster.g>
	<20260908215344.24843-2-chewi@gentoo.org>
Date: Wed, 09 Sep 2026 13:07:05 -0700
Message-ID: <xmqq4ifyqjdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Le Cuirot <chewi@gentoo.org> writes:

> When cross-compiling, Cargo always writes to a target-tuple subdirectory
> determined by CARGO_BUILD_TARGET, even when it matches the native tuple.
> The build looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
> locate the freshly built library.
>
> Respect CARGO_BUILD_TARGET in the output path so the correct artifact
> is located.
>
> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> ---
>
>> Nowhere in the above description I see mention of meson, but the
>> patch is only to cargo-meson that is referenced by src/meson.build
>> which invites a few questions:
>>
>>  * Does "make" work fine without any change similar to this?
>>
>>  * Shouldn't the commit title say "meson" somewhere if this change
>>    is only for "meson" driven build?
>
> Good point. I hadn't realised that Make is still supported. I have now
> amended the Makefile and tested both the native and cross cases.
>
>  Makefile           | 4 ++--
>  src/cargo-meson.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1cec251..5cd5889 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -940,9 +940,9 @@ TEST_SHELL_PATH = $(SHELL_PATH)
>  LIB_FILE = libgit.a
>
>  ifdef DEBUG
> -RUST_TARGET_DIR = target/debug
> +RUST_TARGET_DIR = target/$(CARGO_BUILD_TARGET)/debug
>  else
> -RUST_TARGET_DIR = target/release
> +RUST_TARGET_DIR = target/$(CARGO_BUILD_TARGET)/release
>  endif

This seems to be based on a bit stale codebase.  Specifically you
would want to build on top of post-924dfced6b (Makefile: support
universal macOS builds via RUST_TARGETS, 2026-07-08) version of
Makefile.

>
>  ifeq ($(uname_S),Windows)
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

When CARGO_BUILD_TARGET is not defined, this leaves double slashes
in the resujlting pathname, which may not be incorrect per-se, but
still is not what you meant to say, which is probably a lot closer
to

    ${CARGO_BUILD_TARGET+$CARGO_BUILD_TARGET/}



>  then
> -	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
> +	cp "$BUILD_DIR/${CARGO_BUILD_TARGET-}/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
>  fi
> --
> 2.55.0
