Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A924BBEB
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983681; cv=none; b=D0+uba5Zp5oqz+FAbWSM+KItO5gZ4FlPY9Kbzjn5K1BTeBjebcbJP3TCImUKA11p/i60RODRICwM7rDIA/TyKZWc51gqIU46mgLPgPaatUKYyTVqc13xmIymVMJheQ/J9gmEoSphL7XMruOyoVjx3LNt3BxJ+vMc4fsYOSYGkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983681; c=relaxed/simple;
	bh=0b2bXbIMfLi9bryNjsnIHInVrWrn/kIj6vHBgLHiWzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PS5Y+VJk6F4Rxxh+kr5knH5SnygdhFdTpdZ7yw0s9TWip/CE+LBGqxqp6JDJ6CRhYyGVpe1x58dA1z608uIqdfEb8dMO6g5hcHHOYdQvOfptJ7SXqXEVU5a6qgw65aaGqAI/lvUS5+AzEvg4LEKBOFiPsOxD+B/DQ7FQo6WV1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hbFHiYUo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDlw4rEX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hbFHiYUo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDlw4rEX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA17E14000AE;
	Wed,  9 Sep 2026 15:54:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 09 Sep 2026 15:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788983676; x=1789070076; bh=nK0KmF5ErI
	nx9Qge7we/QmlGh3PyHBUmIJoQMKECHo8=; b=hbFHiYUoNHPG+AlD18qTNz53rE
	/o1eZraClZLDNM7ZHf95yIo/ZGs4ACOApAttQl0rlTFt/968XANPNsDfCjMUGeaj
	5ZkmGWEdhGea2sQauW2ET3bB43qQNyzIEY/JyWcDoHn6qVnag3t+V19P8fMVeTsa
	fxllYvbIm6Yp13XOnPg3n7ZW5g5o4DZEyKrMHBOA9mgHZ71agqVNMiXdLQhPpAGt
	yfsM44Up/88g1FWUbqSADUWr11oxhABhuX+F92606A+1yBJkgaIBUGo4u9NzRj7P
	VRjqFWGGt8y9iLs1wSEWjtBMySAawP3cVjvH8XsDSLGHIiRlonGycx4N/aLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788983676; x=1789070076; bh=nK0KmF5ErInx9Qge7we/QmlGh3PyHBUmIJo
	QMKECHo8=; b=IDlw4rEXstNVWhbNmTTbsb8STiy+HwzfK61Rk7s+FuTr1di/P0y
	de+cRqYmgGlAJaVuhRu437epoC1jSiWTbgs+H1Z3IbPctc2FvmiNItEhZzv859Mq
	O0p7jhXjQQlhUnUv05ZxQmG57rxpBQ+S/jD6tEP1Z4rBUeZQuOb7VcDVLKAg51zE
	xn3IqF+Y5Q9Kk8uwI1icFo/AQ3YDcR3oNmfDxGqoj6P/iHdbvi8Jx3rmkpETkr9S
	9V33bsQ69mO/33HAtxHYpqsAt2WT8B9c4it9T9Lb8aVyCmlm96McF3FnQdu89+u+
	dztYQTp/8+atvcLU080hBRgOq5TN+p7OmMA==
X-ME-Sender: <xms:fLmhailTYE0Pjib6qGSjYifHJmvD0jIAT1EiokwaXnQUpnaXTGNeuA>
    <xme:fLmhagsls8-PhPkwUQpgC3ZE370vDo2c2uV5X71AvGPfS22O8bXwsx46jhq5Muy9i
    yECagN7L7HBUcJqGRZLsky9jCwTQc9ZvAucJ8YDus_1SblKxBivyoA>
X-ME-Received: <xmr:fLmhao86xbUhArcfHFEFmexnYzCL8lrXa4vYzmOAtAnM0m9gYsis9myWEUx-5KB0r0N3o0atjmvSRut5ov73dAigiXm9RrlHZ2_e>
X-ME-Proxy-Cause: dmFkZTEVLc5QngTEpZdf2MV2c1EmsJYwa5o4j+KzMYMnPH8r1CuXv3YWYHK/7hZCEOmgpx
    /gG7VB7oyLxqjXBcup+zmE5uiHAdO6UZ96H9KuNs/MnQpgQqai3qKkFnRTdrN74D2K6XNV
    al+Scb/OBGtlwUxQsJO2NalW0KQsCAMWQVavkGaMQHLpUw10HuBCWxMcl9A5HMC6clqB6V
    kMWWXfpRSyFVgMoHsInGj+8kgGhDxQy3/+sK2383CqNp2+oDsFKqsjR7nCt5Nyh9dw3iai
    qfUK7c6eN9CZsYWFbqUKA1bb4tmNOyr0yGHAky+9ol1YKqFXNxHRy6qkIiCEhWj5/E3bGs
    w/fbBidC2h+x5jDqfpbDk7omnt7vwGnx1FcHdYkNNzNwtbxhad9HjPs5+DCjYJ0A8CIlQa
    7+qd0uEuFrvGm0zJe3CIayBQGX4MgfmzvbsIuOCgcfAUAk5sQwTvASzowVhtOmk0dYURst
    VBJ2X4z2pYqmZ2ZtvYmzpRCMY82FhDRK6SAe58zdWnslz24AvV60mVTs4KQljKfrwQZSPF
    x+YBn/VqiSG321bq18RyIWFxxGA5iMmGHfqhpxjXfnV9X8FZaGqAbo4+RG8ylcvYKDmuqy
    C3V0Yy3/RyN/BK2ooIJOK6c1n5KLTxRl2vMISjFjZFW/wn953HOYRn0UAenQ
X-ME-Proxy: <xmx:fLmhaiOTCxslBaVg1fx45zK_Z8nPzKjl-qEQMe4h7zhKy37Q_qILbw>
    <xmx:fLmhauHUeB1-DFMnkIZy4QTvUQ5EX-LqoSM5awdNilc3vP6fPvA45A>
    <xmx:fLmhaoQjHX1eNSv4X-w-GdyzX8FJdqK7ROsHNrBEzhUvqMJm7dRTOA>
    <xmx:fLmhajv_Of-PF1owmkaJMeBQprDjeRwKc7rDWqhjsODXYcOgKlt1OQ>
    <xmx:fLmharatdsiFq_qyRttXbdwvEzAm_cVKpZFWs4foUAER7SLkngH7mpJd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 15:54:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] Move rust gitcore crate to a different subdirectory
In-Reply-To: <20260909013858.1729643-1-mh@glandium.org> (Mike Hommey's message
	of "Wed, 9 Sep 2026 10:38:58 +0900")
References: <20260209224847.1416916-1-mh@glandium.org>
	<20260909013858.1729643-1-mh@glandium.org>
Date: Wed, 09 Sep 2026 12:54:35 -0700
Message-ID: <xmqqbja6qjyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:
> 
> Having `Cargo.toml` at the top-level of the repository implies that one
> can run `cargo build` directly, but this doesn't produce anything useful
> on its own.
>
> Additionally, when including the git source as a submodule of a Rust
> project, it prevents the git source from being included at all in the
> crate package because cargo skips directories that contain a Cargo.toml,
> assuming that everything in the directory is relevant to the crate.
>
> This moves all Rust-specific files into a dedicated `rust/`
> subdirectory.

Very readable and understandable.  It is customary in this project
to write that last sentence in imperative mood, though.  I.e.  "Move
all files there".

> Signed-off-by: Mike Hommey <mh@glandium.org>


> diff --git a/.gitignore b/.gitignore
> index 4da58c6754..3ac0685800 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -261,3 +261,5 @@ Release/
>  /contrib/buildsystems/out
>  /contrib/libgit-rs/target
>  /contrib/libgit-sys/target
> +/rust/target
> +/rust/Cargo.lock

There are /target/ and /Cargo.lock listed in this file; aren't these
two entries meant to _replace_ them?  I am wondering if they need to
disappear as part of this patfch.

> diff --git a/Makefile b/Makefile
> index d4b775953d..7991fa378d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1571,11 +1571,13 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
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
> +RUST_SOURCES += rust/src/lib.rs
> +RUST_SOURCES += rust/src/varint.rs

Two files, lib and varint, are listed twice here.  A rebase error or
something?

> @@ -3913,7 +3915,7 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(FUZZ_PROGRAMS)
>  	$(RM) $(SP_OBJ)
>  	$(RM) $(HCC)
> -	$(RM) -r Cargo.lock target/
> +	$(RM) -r Cargo.lock rust/target/

The Cargo.lock file does not move together with the rest?  That
contradicts with what .gitignore says, doesn't it?
