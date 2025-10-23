Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AE8405C
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256898; cv=none; b=EBJcDd09RX/ydhmxoowJghvSq86QXhEdONGU9Yp2YsJgr5q1Z28zzgzee7buFvY1lekpeSsMWxiEQRyJcGQI/atA9w8h8VWd/hp2YcTQjbUtwtPh7bDYwzXwIHRE9gk4hLahR8GY0MUhfyEb9Vtv8zPfhGkbe4HpHVx0bD1wySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256898; c=relaxed/simple;
	bh=S2ZFC4kvsBc/Y8MEN/8zOLMBlmcOlvZhzWnamD8ACBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AYwEfGkFsljt2JZw6dMUIthmd4QkDfFSZ90jx/B+zBYsHDu02y81Xy/8YkriyHhmBgeR0GdfhvXxzyR06b8c7brU6UZ5O80ndt52s4/1LyzPZfwLgY9MzPrE9pfxKYPu8jOKk44KMAJL+UAIsb2j1K4wAf+YABjAqgeWWtLzlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cHUVO7j7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJ7ZR8Rz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cHUVO7j7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJ7ZR8Rz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ED3B61D00091;
	Thu, 23 Oct 2025 18:01:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 23 Oct 2025 18:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761256894; x=1761343294; bh=AZWPMzPh6X
	ChVztArp1gRWgtJ/yYBPXHUxb3vQZf7UU=; b=cHUVO7j7tA8iywBgSXcs4P1ftD
	cIRbZSLXkK8A5FoQQJlHuYrugveATWqDCF2bogLC6KwfvB72y4HwaFZYKHJGTQOM
	I9sN+fJVrh7VpCBrWdv9Nw1YlGqef4GNQjqv7u1ul5grdnzCHdW15wDhOkpSjYCw
	ZmZMvOdv7Grrixl/JHgfPKIFO0cvav9JFaZozHJvEwiPRhkEDW9YLabjtHZ3SBgg
	PBNDSJ/763umQFQcuKDUPXFt+foM47IJVR6KcAdWpmkACPeKDa5zbhfnO1bkHwmf
	1yaleSRPgDRQ4SRX1Yn/t8J7z6EN5KJ5uwSh5Zm3J4wEYDtCJKWlh+jBBb/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761256894; x=1761343294; bh=AZWPMzPh6XChVztArp1gRWgtJ/yYBPXHUxb
	3vQZf7UU=; b=bJ7ZR8RzCzLGZZPsf3v/idlbpDbWtnKF/DcNns2bFzvP/52ZTdy
	1k/Jq8T3Wul5VQf8AZw0P0L3Ee7L3BU766bZjQarJ3TR99jko9OcjmOZAIjdTN9i
	UNQFZ2S7ZiCftdDqaz+Ywqg6PFwGSumjxA73+KdKI31OaPLb5xKYwnzSQ1MVXlgf
	p8sVPOTPPi6wd4zq7zzvhXw7NoVM327HvDWORZc3V/BOx+ncp9dLNzBQ0368zr6j
	YeUTiqR/5RjtI4KPKlnDh9PFiGyJ6Soh7LsI/2tk0J5ZqwQRxK8kM3DsZ4aOSqpJ
	pXGBUjSXi5nL0A8k3aI3C/GvD/Xwlj8zC/w==
X-ME-Sender: <xms:vqX6aDB9c-W-653tRO9dOsQ7pkOuA2QsBmSd1i1x5ucfC2pUDf3lzA>
    <xme:vqX6aAZUEphFDDTWocfGVXMu9_HGabDOcb5IHmbR1xNeoZWkeQsvEmUXAWOgo62Y_
    TSMlnR7JndSoMPyEikqW-4YUKJt4Xh2hQe2LKTaeJ-pZLn1ITckqg>
X-ME-Received: <xmr:vqX6aG695YMIT7E4jh3e0xSRpJdh6x86VfeSZO_DYdvqRV2fcfroejeLgCKL7BZiarU01YNGkPYlJqEufWqtIpYwaUIhded8DIY6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:vqX6aBamCxyVRIec9g5Tb3A5BYaRtNy8je9c69_v6Q8eA2DgrJ34XA>
    <xmx:vqX6aFg4i80TvznA0QuosB4e8pP3YP9pc_aP8KOkTXY8FySlvUVzuw>
    <xmx:vqX6aC9nAt5RKJHhED7ttvs5BqkI6Bjf1_YeHttfO3eCNcKBDx_4vw>
    <xmx:vqX6aApxR-eeY5b9i3qYVQtaUuDyr_i95CenRgThvDzTeSsU4hHBxQ>
    <xmx:vqX6aHoIymGfi-ghM4gDHj1IK9eKGK_Dng86DBQ7qH3DXjJ1x17WUMag>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 18:01:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> (Patrick
	Steinhardt's message of "Thu, 23 Oct 2025 09:17:40 +0200")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
Date: Thu, 23 Oct 2025 15:01:32 -0700
Message-ID: <xmqqbjlxs2f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> An initial version instead included the bindings in "varint.h". But that
> would cause us to recompile all dependents of "varint.h" every time the
> signatures of exported Rust functions change. So instead, we now include
> it in "varint.c" and compile that file unconditionally again.
>
> Adapt our CI to install cbindgen(1) accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

I am debating myself if we want a patch like this.  I tend to prefer
"make clean" not to be too specific to the build options used to
leave crufts.


 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git i/Makefile w/Makefile
index 59e5a2c61c..9b673865e5 100644
--- i/Makefile
+++ w/Makefile
@@ -1558,12 +1558,13 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
 ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
+# allow "make WITH_RUST=Yes && make clean" to discard it
+C_BINDINGS = c-bindings.h
+
 ifdef WITH_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
 
-C_BINDINGS = c-bindings.h
-
 GENERATED_H += $(C_BINDINGS)
 
 $(C_BINDINGS): cbindgen.toml $(RUST_SOURCES)
