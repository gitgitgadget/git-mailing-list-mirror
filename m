Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44A23E334
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719660; cv=none; b=Dr3S0XFSWHvLtc7wlx8q08TuDv45S08zw2NteDg+Tk2SZmfAj2Urqns03MFpsfD4X8RQJx6Dk0UPCg5kOiZLzMOCL1jWhRRBYOopg2SKdhjgyocwkyQgUztgZdPl5N9hD1F7RkscEFIkGLEw16aKgqTfSWpEPF9F0O3voNZQ2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719660; c=relaxed/simple;
	bh=oUEtkWY7dT09G+2j/1WupAqPDl5EjcQPpFZs0tNfL/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDH8IDX0uhJxfKpwHhROOIld5zEaTnVbnmgk0OFf9pGI/jX34rkT7inCQpoZShibdO8+ad1WyBFBqYoa1hZrZ6U7v0oeRIJsrVVKshFTG5UxAriuFvfD/msRSF6jk0f912wwH7omrpc6Ym+r1cecTJ2f4b0OGFXkajzHWltTm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BmOec011; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWnEw8or; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BmOec011";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWnEw8or"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62A5C7A00FE;
	Fri, 18 Sep 2026 04:20:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 18 Sep 2026 04:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789719654; x=1789806054; bh=eYxlWShuVs
	OBjCrpOvtx0KVI4IJff9NKT1vymAC0R7Q=; b=BmOec011ToPjF3mHQTL97aTmHV
	8KvQ2DZBQgntgSMvnOO+J8h/1bMyq43As6Tu0lsWKEIfGqUDlnnLLIkRZLANIQ7x
	uedwbBhVFLBgD9Fkb66jIyk1rsiz020ax45qumfSX+PE3zZG9MzEvOi88i82LioM
	kyDajIVltyVy9fd8cUM+BNa+C08ZxMKTsj+FdObV6m3O5zZGKN/suT3vMPTbH7ff
	/E72kPjMBezdyuCvZ9Bhzu23nAZJCOY+51J9aYXXHs0ENzkylcDCZ/zSyOwfmu78
	ICTRR580kNwhThsZeOeoF4v2UizPFy98HaQsHgPC5nkHU4SILCaikCcVr6zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789719654; x=1789806054; bh=eYxlWShuVsOBjCrpOvtx0KVI4IJff9NKT1v
	ymAC0R7Q=; b=pWnEw8orys8fD6+rqqo8X1kJkg4obeN4+KAMmcXa8ru4LT6GyHM
	p42fhWl4taSdtMd0Rlj7sXDnEmDSTQ4KOqvGus7ajLQPG2yZI0O4HdDMQePNuH6o
	AQBrLCzqg8dyKun2++ab6J1hYw7P9yMWyFd8C04DN2IDmiOQWAgdxrfdpQkDwZGm
	Mbr+XHgriRUGYV1tFDPjkgLS9Iacl63HnvFyBh/XQTeWmucGWPHg+mmidrDOHZG5
	FfBQCW89fCs31ErhRSbnHJchg+7i/cNbj7yoXIgp9tfSJyJy+GrI+EcSrHmtNrFJ
	rQYKQjIvKcKR1gq7uPrUsvi5p/cBmhivjAw==
X-ME-Sender: <xms:ZfSsanrauMJjOclGOcZASzX2jjwBsom1CC71Jm7G9Qv5QYmxCTAxuw>
    <xme:ZfSsaoiIo0xixXK3C9AUHiZBT0yjqus0zcKHDPf-uogx2HBkabux_XadB5HYDPzh3
    TYRMAJSh8KgyRfCxFCu_-vQE0Mf2w0xBCJUVLEKPT9zlV_Gz91KgCU>
X-ME-Received: <xmr:ZfSsasjkvf74pCRJeYxmz92Vv_UwMGlMoYTsonGpA_2PUlmeRfIT7gPZeqbIpIu9qXiVOTTk1p7UMn-l4yfaB9gkBpsjecLLPTpw>
X-ME-Proxy-Cause: dmFkZTFjY/EB74l8X4SI7j+gQMsPF0boRUDNEcc1hCXpSSZUiUPgpwA8UyoN54l6hvnr/f
    RvbDWsPufLnOr01vIEbQSRlGGwI4bhWTdVUL5ufAMEPMtQHshj6/Xz2biUtpm5hSrDwa23
    eSqxPN4wt0K2VmFSUMC3E5FG4VdCqprcBEV0P9QyTLSn42TwZle+Pj8O2d656i0Kt1VX3h
    oH7tnc3mO/TpqwDpZx28wecCCEytNoPPCI56HnEG+lJU3i+JdcbSjd/5fnn73lS1kRdUlb
    4H58UXIIM7Pa+bj3yr7LdLeTiNq8pD5Zuzc/vsPnnF5x45YGLvghTGkVYz3b1Gh4c8wwEb
    v4OOnGtssfdKsgKYqCTcnvEGjjsDYzlnUOkgGPsknWkOLjYllD/HKGbSSPbhBubwHanh1i
    Z64YJmzhfFAYCsYvZPu3IdqUJ2eF27B9G8d5mPysEXKNGP5s0n+v70SHO7FYeYPvqyFld6
    rPXNvVCd7req4tXJEg7EP0O3RtcaYKYU9kjnGJ5/Nlod4bSAXXdP2+tChlYm/D52Rl9teF
    KrHD3JSBLBCUvlKoWuWBca9BXh7zj/KEuqfDHSpNAPE1EIFaE8K0mvUjC4lQP3hpZE9Ajd
    qoS7I+oZC7bP6AS6wyiXpID+QuWs9LlKJTTXs+3Q8rXv5hnr2q4fjwfTJCDw
X-ME-Proxy: <xmx:ZfSsamhDZ_B7cBc7UUwgne-klUSJCGZ6MEvMRAoFLqnFFFQfHDd0Sg>
    <xmx:ZfSsakLgfKuGfcPuKMRAIDlDVWRfSKmgGYQFFgNhmUP98X3Z8bhSPQ>
    <xmx:ZfSsatEhezLU77z1Ic8ik_MBR1pjuDbEi9w3_5dIxx7Xda1mW3gtzA>
    <xmx:ZfSsagR0tN98z4Jij8vMuN8a_RbrAd4FrQcKJxzeVs5KCea5Gqa7_w>
    <xmx:ZvSsams50z9l3fuKcXPCPXGXeEQjnUxjt3WEm3Vs54Wmb8KaZPIWyah5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 04:20:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
In-Reply-To: <20260917060415.2986259-1-mh@glandium.org> (Mike Hommey's message
	of "Thu, 17 Sep 2026 15:04:15 +0900")
References: <xmqq5x0df19l.fsf@gitster.g>
	<20260917060415.2986259-1-mh@glandium.org>
Date: Fri, 18 Sep 2026 01:20:51 -0700
Message-ID: <xmqqfqz7otr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> Having `Cargo.toml` at the top-level of the repository implies that one
> can run `cargo build` directly, but this doesn't produce anything useful
> on its own.
>
> Additionally, when including the git source as a submodule of a Rust
> project, it prevents the git source from being included at all in the
> crate package because cargo skips directories that contain a Cargo.toml,
> assuming that everything in the directory is relevant to the crate.
>
> Move all Rust-specific files into a dedicated `rust/` subdirectory.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

It would have been a friendly thing to do to describe what base was
chosen, especially with a few other topics in flight that touch the
build procedure for Rust part of the system recently, here below the
three-dash line.  

It seems that this patch is designed to apply cleanly on top of Git
2.56-rc1, which already has these topics merged, so I do not have to
worry about conflicts with them when queueing this patch, which is
good.

>  .gitignore                     |  4 ++--
>  Makefile                       | 24 ++++++++++++------------
>  ci/run-rust-checks.sh          |  6 +++---
>  meson.build                    |  2 +-
>  Cargo.toml => rust/Cargo.toml  |  0
>  build.rs => rust/build.rs      |  0
>  {src => rust}/cargo-meson.sh   |  0
>  {src => rust}/meson.build      | 16 ++++++++--------
>  {src => rust/src}/csum_file.rs |  0
>  {src => rust/src}/hash.rs      |  0
>  {src => rust/src}/lib.rs       |  0
>  {src => rust/src}/loose.rs     |  0
>  {src => rust/src}/varint.rs    |  0
>  13 files changed, 26 insertions(+), 26 deletions(-)
>  rename Cargo.toml => rust/Cargo.toml (100%)
>  rename build.rs => rust/build.rs (100%)
>  rename {src => rust}/cargo-meson.sh (100%)
>  rename {src => rust}/meson.build (81%)
>  rename {src => rust/src}/csum_file.rs (100%)
>  rename {src => rust/src}/hash.rs (100%)
>  rename {src => rust/src}/lib.rs (100%)
>  rename {src => rust/src}/loose.rs (100%)
>  rename {src => rust/src}/varint.rs (100%)

So things in src/ move to either rust/ directory or rust/src/
directory.

> diff --git a/Makefile b/Makefile
> index c649c93c51..67e74c30cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
>  else
>  RUST_LIB_NAME = libgitcore.a
>  endif
> -RUST_LIB = target$(if $(CARGO_BUILD_TARGET),/$(CARGO_BUILD_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
> +RUST_LIB = rust/target$(if $(CARGO_BUILD_TARGET),/$(CARGO_BUILD_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
>  endif

This part was touched by a few topics in the recent past and I
didn't want to resolve conflicts there.  This patch being on top of
these two topics makes my life easier and is very much appreciated.

> @@ -1571,11 +1571,11 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>  
> -RUST_SOURCES += src/csum_file.rs
> -RUST_SOURCES += src/hash.rs
> -RUST_SOURCES += src/lib.rs
> -RUST_SOURCES += src/loose.rs
> -RUST_SOURCES += src/varint.rs
> +RUST_SOURCES += rust/src/csum_file.rs
> +RUST_SOURCES += rust/src/hash.rs
> +RUST_SOURCES += rust/src/lib.rs
> +RUST_SOURCES += rust/src/loose.rs
> +RUST_SOURCES += rust/src/varint.rs

So the sources are all in rust/src/ directory now.

> -$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> +$(RUST_LIB): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> +	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS)
> ...
> -RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> -$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> +RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),rust/target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> +$(RUST_MEMBER_LIBS): rust/target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> +	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS) --target $*

Is the reason why we now need to sprinkle --manifest-path all over
is because rust/Cargo.toml is a non-standard place for cargo tool?
Not complaining, but am wondering if it is simpler to set and export
CARGO_MANIFEST_DIR from the Makefile.

> diff --git a/meson.build b/meson.build
> index 0a95d90d21..432e306b21 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1795,7 +1795,7 @@ libgit_sources += version_def_h
>  
>  rust_option = get_option('rust')
>  if rust_option.allowed()
> -  subdir('src')
> +  subdir('rust')

Not 'rust/src'?  Just double-checking.

> @@ -13,7 +13,7 @@ libgit_rs_sources = [
>  cargo_command = [
>    shell,
>    meson.current_source_dir() / 'cargo-meson.sh',
> -  meson.project_source_root(),
> +  meson.current_source_dir(),
>    meson.current_build_dir(),
>  ]

What is this change about?
