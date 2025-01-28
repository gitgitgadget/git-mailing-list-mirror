Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2719CC28
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104242; cv=none; b=QDDMDkHbDQ/+PCMJ7Np874LqZmtjriUoDtqjUgRNYs01dIHp2DHxAa/nNtnm19BGX5/J11UFhutScnwXjUKVJrT3MUxhDLpphr7bnHRlPENgaoPukequPs8sGU2tkG6iTsQgnEDWfwlkSkgdqOXeQOb2d+iCBWjsEDDSc0NhfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104242; c=relaxed/simple;
	bh=Hc2jHS5/wKugpUB4SehLQRSi+dx7idG3uZAOFoydR1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbnqAXTF/W+vH0QvIa1u14tUZ5s3L0S8F4C3bHaGn3eCLmGciyjzJD2TIc1/6E1U/1y3YBSBbLkvbkXFmmqN8mN0SzlzQOrVTFBDJ9S0X7wiNVheG+PJq94LxKY6v9pccPg+vtLyWQrzLrIpf+dgMdw7GOsZm3dsLptMs8QRoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nMlnMKea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTPtvjP7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nMlnMKea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTPtvjP7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 34D191380AC1;
	Tue, 28 Jan 2025 17:43:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 17:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738104239; x=1738190639; bh=5GwFZOMBR+
	xfUsBxsj4Qkl4yGtJQanW76b3kXjaDNdk=; b=nMlnMKeatjJJUt+GVQSN5oF0lh
	ZyAerFfRUxqqbVV/d5nuspeU15/PAODXgGOE2xNQ9eh4km4eswvQ9ZZcX8ylhs0I
	3LeweepfkQ+9S9kdhoyteJeJel1Y5JEXdPRbz/F6GnoIbGPByS7qjCGj49Ov2IVq
	OO8Oa+qfUiNWMf/VLITPAmbtoR73zpmH+lpEkYm28d6O0XhBCqtyvY7g9EIaPMZp
	e3PmnCeIB/LjqrPKbiAUypAvFMhE5GW5d/EeM4vGRNYQf9l/oykQi1vw6PK1rIt/
	XRlfZaB/bGeuNJ7RXHeBuxVlvanHaqXwneLeHcv6ROeGrrKAWv2isCcwL/Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738104239; x=1738190639; bh=5GwFZOMBR+xfUsBxsj4Qkl4yGtJQanW76b3
	kXjaDNdk=; b=UTPtvjP7h8LrUaSnqEiQuxh3znTRovvOqR1IxoudQkX9qmMPoV5
	FyjSDha8gGSYDgaWetWztkZLYhsa4B55BdsuTzwnOnRYIQN22GlX2/P9PKUvq+Gk
	BNEeDc+YiMX/QSALhJaoIwI8pQopYqwWUNfffPpSFJv9PZDbVJj79qI88iaFRzs4
	6c/PMgjLHd9iM7WYsHQyIexBr221vprMQi/UCrmJjqFLor3b11/90/yGLRMmuMg+
	kNDSu+AZUZ5dJ9ZHLFpBq8ChuZq9jto9gmk5yq4MQSpc19X3Wick+9sf4LjEDENr
	rpOgMupSJqWwKMR0Ike4YgJx5q49e9k7eGw==
X-ME-Sender: <xms:rl2ZZznTpV2Xz9jVT1KLNo-nyPlckDNa9vqdlN83O0phPGdEK0lPKA>
    <xme:rl2ZZ21B4kk1jikhWwXYktsqXS3K3lC7-MrCQ7hAqANnmzce1UafNrPEa7d4NTKcU
    u-Qx0OFx3QZpGr67w>
X-ME-Received: <xmr:rl2ZZ5oh-onXVefu36TYwVSszXGomacd8Clqao38oq4vMCNP2967w78Y0mDeVkMgleHxZ4pZcX5MXA8NZS6usopI8AHJWdfiMFri>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhr
    rghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r12ZZ7kWjERrnEjLTsCGK8CXsOdmJpnCY9X463c8dxR5u7-z8r74Eg>
    <xmx:r12ZZx2n36jtjItf5CEHm9oEmT2uxKowwtRfw37OnV7f5b7sb_vyVQ>
    <xmx:r12ZZ6vRAI2TeIR6VMoh1MXGN8EFzZeFoNdOAuhMH2SlgTMSEZGNiA>
    <xmx:r12ZZ1V5-st526ASzYYhVeRqQqG0jg-xsXHmXEXDNmMl-Dv9fvhIrA>
    <xmx:r12ZZ7xXqEhPrnqeDKZKtiuGZksoLR14-FnorSxuEXrKNQ2vQM_poxkC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 17:43:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  ps@pks.im,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v8 2/4] libgit-sys: introduce Rust wrapper for libgit.a
In-Reply-To: <3588a3c3fc76fd2a98b89e837dae07fd97fb88af.1738101256.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 28 Jan 2025 14:01:38 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1738101256.git.steadmon@google.com>
	<3588a3c3fc76fd2a98b89e837dae07fd97fb88af.1738101256.git.steadmon@google.com>
Date: Tue, 28 Jan 2025 14:43:56 -0800
Message-ID: <xmqqcyg6mudv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/Makefile b/Makefile
> index 27e68ac039..f2c08df4cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -416,6 +416,9 @@ include shared.mak
>  # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
>  # programs in oss-fuzz/.
>  #
> +# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
> +# test the Rust crate in contrib/libgit-sys.
> +#
>  # === Optional library: libintl ===
>  #
>  # Define NO_GETTEXT if you don't want Git output to be translated.
> @@ -657,6 +660,8 @@ CURL_CONFIG = curl-config
>  GCOV = gcov
>  STRIP = strip
>  SPATCH = spatch
> +LD = ld
> +OBJCOPY = objcopy
>  
>  export TCL_PATH TCLTK_PATH

Good.

> +LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
> +LIBGIT_PUB_OBJS += libgit.a
> +LIBGIT_PUB_OBJS += reftable/libreftable.a
> +LIBGIT_PUB_OBJS += xdiff/lib.a

This is a fairly minor point, but if we look at the places where
OBJECTS, PROGRAMS, and friends are prepared in the Makefile, they
all start with empty, i.e.

	LIBGIT_PUB_OBJS =

at a fairly early place in the file, and then appends real contents
to the symbol with += assignment.  It probably makes sense to follow
suit, although the result would be the same.

Other than that, nothing jumped at me as fishy.  Nicely done.

Thanks.  Will replace.

