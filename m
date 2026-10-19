Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4344F558
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392362; cv=none; b=KK/HvwWnb3ctMSYcBgTbKNsXwOIpPfol/JlTj1g2mIQThlMvslQSOgdkR+oqrky7tU0X93UxV8Q8sKCoqSZFzKu92rUbPq953UClYjvRbFsK0c/ZRvGV7yXhZS7Y90vmfir8RMmSRn2yH69vZhilpqnTiq0oXbneMpgi/fAovIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392362; c=relaxed/simple;
	bh=fnApybVEui4NpAA4cohNN6NiuuMVlLzAIiDXnIbFI7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrTEqJOOciQD38p+fGeg/qcsrg0tFmPrcLUeaqFjMKObAP2fWUdIUTiSwNqPLAoxHwTX3P3WI+CWg7tW/zDTsOfHo9Iau5MwMFsEqrKF4v6/U/Nbsa0OmgWSpIda+ME5+s1Hkb8+77JXNLgm3FZy9ioa81Ial4231cX1ET2z6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZwMadMgG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ayTir9G7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZwMadMgG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ayTir9G7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 451A31D00128
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:46:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 19 Oct 2026 02:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792392359; x=1792478759; bh=lk3A7SyRdt
	Xdag5AWKRXirBwWu+pVS33SQAiPdgjDMs=; b=ZwMadMgGNu93BSF3E6/xsSrlG5
	FdQxgerdRqojzdoeRfBZSHNiF9vfHE2n0UlP1ieDSJNrg+Q6L7vOWiWE4Ko5BlOU
	ntjOWUheMfSRRiBxT0PzPh1eArrm6Lo/wahW44nP2ZTU4bsjmpeOj4HK/GDA2p+9
	IA38v1a82oUd4OQ9cAaBMVUUYb/yNDp1+P8xTzDTjxQvLMIiANSOxDo97zy6z1r0
	tfSLTjHURJMW86vcc1s6gQ6rN2829t+8iVO1kNN17gRveoLngrpaxvsdxvopIlyX
	8oCjDiQFIsjSpSW+sNd1ssfDWMRcP9qrLDlZ/pqEML6RitExS1VG6OfmkpFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792392359; x=1792478759; bh=lk3A7SyRdtXdag5AWKRXirBwWu+pVS33SQA
	iPdgjDMs=; b=ayTir9G7cHXLFOy+orCxANfYgv+xOLsrS6YwfpXkkCeuV/Sm8PC
	Z6Kx7TfS3Ld2wDVd+e3IszJkoWlZntavCiDb9D6ai2bEkp3SyizlxGSLBmFf6ATR
	sPJcYqcYAQ9ebLOKGvrtrWfpYwcIV9jsV8/fQeEameVejsumlTBK+D+ArAwP6+k4
	WNdtZuv+l8yoU/o5X3j55R5fuxPbBN5CxmFDSV8SB2AD7jR+QR3jmImuBiNISPoE
	7Wl5sA9Qj6UC6pBDZycjgfv0pNtVVBj9yCymVBPdZl/sTT5O/lciwRbSBchPLbNX
	x1NC6Mq29fSofGB8cWGQuoqiKNnDCaFlEPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792392359; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:thue/eGCiS6fEAupGtMhl4FzjgG//dUQDtBu8dEIc/FOYeH
	UzG9tFnHlDUJ69bKKEKKjeCgGr87vCi3ZoOEijyJ7rrpa873XSQaK+fSjuqYJIWF
	dXFyZQW0oZP7FRQD8h0f4FkmycFlOrc+ybjf3LKfyxw/Bv6Q7SqJh1fRVkFfuvQy
	y9MBHI36oDvDdzaSvHuGdw9Ing0FT5LgrAGzFYVg+0/n9gxRFQxKzBT+sGYqw0mx
	Gppu0kEFqOht9MlqOAeO1CwlD5rssI1mX0BgBU//NSMdPIvGQ6+6mfC6PdHthoid
	te3kXzveBVFNVVh5zwyJZLqrUtgFsuwKQeLY8XA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rhdwEzxPc3JBtGsZrwQWr2kfdPwQyuacmq1MOvKxVbA=:fnApybVEui4NpAA4cohNN6NiuuMVlLzAIiDXnIbFI7k=;
X-ME-Sender: <xms:p7zVanUj4yH_jP_f5VV9ilmACzhAo5IXT96oRF1TpSIgxo1BrFQVhQ>
    <xme:p7zVamn3mwhuERpZ56x9bYRKEFrwwPb8Dsv41vyIDWtHHN5A33x-DMjs81fWnxWXe
    ZqgpFpQVHmXAOIJko63-aptbaggjF4Nnf803G6jgTiOYYYJdSGG8hI>
X-ME-Received: <xmr:p7zVaoa7Zlv14oTmMjY5d0TY494jsbPZiZWT4u628s0Jvx_dIbk0Jg>
X-ME-Proxy-Cause: dmFkZTFlxIbEMd3RyVXlENngXFAkrhGP5SDshht6NWjk3YTzLE2GvgfUyA8KiaxbFpPdc3
    NoXM4XHfztRZh7k6K7gtiSuW/RN94e/Md0q84LPpbkgLmkCLArfyTqeIO4pPSpfgdDXRPP
    yet9SOA6tHmDHwV7mZSUWetzIETgmjegHva+BGGmyb4YQfl4V3ZiFgCEVlHKKCA9TDjNyw
    qzJM88Kl7c8uI5aBNaBHBVp5oQKka5yWjzPaL1Pj4KFxwcKeTtpC/vhtMcazpUwGi342AZ
    TvLoF+3jEa8gUxUPnpm1CYFke8O0y6SKzQaFDOitSQB0M5KM7dY3Yrzv/BmX5nXhirB5ql
    ZgZ5HFeZXKNC20YbnDJFDLjUd0ky8DPcAHjcwXgNNBvtPpHGh3D8SGdolxQYg5+hjwfGIb
    CXQyXB+ci8TrP1lFz9FZTVgEcMaAChjDVeX6ESaF1fqjKZ0dg1OxlUPp0HRN4creInroDT
    NEtPx+FWJEWbW4ILXTlLxkRfNqvnP8el9r+wvuhimXJCUHAZiTG+VyAlJIXa89ACsvtCet
    R/WFSuG+SA5NAGmVrFj8BvqB16bA4EYUGXjkdJs39YD1MsawvatPbIuLp2rIzFHX/Jytn9
    G1J4Rk/3ZbJJq2I+t12MW0GH7sn0GybTMExCy1KRIkGZ9OmksNli5o8OIBXQ
X-ME-Proxy: <xmx:p7zVahNK4CN2SVquxQKRosRY1rlD7Ea4XfWgFQ3mBqKvGdt-led89A>
    <xmx:p7zVatbR0TlX3oxsmlQ1URjWkIaLIJZeLR-tyHyGaDkBWZh0N8Am0Q>
    <xmx:p7zVav3punQMnTrRuTlWjzyeJTocx3ethzkU6v80mJ6e8jOZptkiWQ>
    <xmx:p7zVajcC9kQ0QGNjkqvY8Czn9lrjNKA2ZRkdbpTgVOhMxQYapeVnNw>
    <xmx:p7zVaj5FLzjohT9wWgEgFM9Hx9Ax1rH7V0Ki6Ck1JkMmmpKD9ROxzlok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:45:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6244eacc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:45:57 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:45:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,
	brian m =?utf-8?B?LiBjYXJsc29uIMKg?= <sandals@crustytoothpaste.net>,
	Shardul Natu =?utf-8?B?wqA=?= <snatu@google.com>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
Message-ID: <atW8otvbLGDtDBG9@pks.im>
References: <20261018205305.2634339-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018205305.2634339-1-andy.koppe@gmail.com>

On Sun, Oct 18, 2026 at 09:53:05PM +0100, Andy Koppe wrote:
> The Makefile assumes that cargo places build artifacts under ./target.
> That assumption breaks if the user has a custom target dir setting, e.g.
> in their ~/.cargo/config.toml file or in the CARGO_TARGET_DIR env var.
> This results in a link error due to failing to find the gitcore library
> built with cargo.
> 
> To fix this, pass '--target-dir target' to the cargo commands that build
> gitcore. Add it directly to the recipes rather than to CARGO_ARGS, so
> that it isn't lost if CARGO_ARGS is overridden.
> 
> Leave the contrib/libgit-{sys,rs} targets alone, as nothing depends on
> the location of their build output.

Right. I sometimes wonder whether we maybe want to start merging this
into the main Rust library. But that's certainly a topic for another
day.

> The Meson build of gitcore already passes --target-dir explicitly.

Indeed it does.

> diff --git a/Makefile b/Makefile
> index c649c93c51..aea99a3639 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3039,7 +3039,7 @@ $(LIB_FILE): $(LIB_OBJS)
>  ifndef NO_RUST
>  ifeq ($(RUST_TARGETS),)
>  $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target
>  else
>  ifneq ($(words $(RUST_TARGETS)),1)
>  ifneq ($(uname_S),Darwin)
> @@ -3049,7 +3049,7 @@ endif
>  
>  RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
>  $(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target --target $*
>  
>  $(RUST_LIB): $(RUST_MEMBER_LIBS)
>  	$(call mkdir_p_parent_template)

Makes sense. I would have preferred to use the "--target-dir=target"
form, but that really only is a nit that does not warrant a reroll in my
opinion.

So overall this patch looks good to me, thanks!

Patrick
