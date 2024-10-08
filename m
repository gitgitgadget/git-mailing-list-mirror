Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD062178FF
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431145; cv=none; b=ddH/75apQi9nrdjKjKHMmiJ8g8F7JxAEkKllh/0pKSB+wxbxC35gEbBcJKr8eCRKK8MNSpkGNM2wNrtIlAqwUfbG4bG3xMsDV9oSoiFNBRp2wJECN3zVZJHdvdJurL4bnPV6PXVI0Q3hC6UbBUfbqS2QJlBPpgrCfeearnnUQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431145; c=relaxed/simple;
	bh=2mE5CCSUNgniMGdyaXSZ1Nn64xlKxKXU3NLGQjRrOlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVe6zLu+iSme62bztidkbAj2M8scbzqnMVUAlZWQwaHspFpqRmbF2HO6Fy3lIOuzuIXDkxyI3MWvqkzVjXmdrDUgV5cfMz3QJsDyjf6EBALPpqIWemt03wFJ9dMNUgwdoQ3U5PIGanY8z+6rJYd3UsC4acwpbDMZ7+hpzYFsRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pg1ZUPlq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2VxOFXS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pg1ZUPlq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2VxOFXS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 360021380240;
	Tue,  8 Oct 2024 19:45:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 19:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728431142; x=1728517542; bh=5vDOJdA4N1
	PsoDZzApnyy0nkjwxYw2YhVfQx16q31n4=; b=Pg1ZUPlqRUCRRLXUFFZuc7nTJ0
	A94JhFSrsgS7jgaip9sc2SvM56yPd8aDfRs7p16HV8aoG6ZhVmjiQgwG/PhlIbFw
	qLl0z4w+lC/PTa9R3bkxW8uRLNok1u+OcikJQXarMm45v2PQJkXHYvIW1T/P1Tuq
	Jq1hcrpxfPEzZBcyT3vGjDcWhHDnYVDb9HuoeneLVL5NtysOnbchL6/gJUIdHYF/
	RCalMu4lNYelku8RCWx/YKSXmHAzQe4TSZdKaE7YrLpe8hbA7yqb3ivkUYWAcxDJ
	ux4DNvHvWbMEdAGMVnfwl83By0GHqTQZuGezOVLTrqitmCJvfZl/SJLYhMQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728431142; x=1728517542; bh=5vDOJdA4N1PsoDZzApnyy0nkjwxY
	w2YhVfQx16q31n4=; b=a2VxOFXSoGu0hQyVw4I32gejUK1kQtaF6I/pwdq0i1qS
	dn6BaEYdjfdtqHZmK2LqKtrIkkv/uX7X0Y+vj4YxVuVNmYcfhgjPGr9yQGbX4w1l
	jR2+O49XU8BpHLsGexllGxvpNeGdLZXemPvG/fzgfeH7X+TeLDDj9Wo5Xgs2MJQC
	UY4KcsPuh4W+4m7OOOzYgRAdV3bViEmLPymDB20un9y/HSng1cYfSf3IVUmTKCxJ
	AcEWiVvDEJC8H5eV6qHIGRDDq+/6n2FR2GaL5KjRYxONYjGaYn9vd/AsJDDCbDEe
	7MG4TAKZd23VlVj6X63t6GCCoa6JEf2ZAIOXyajuqg==
X-ME-Sender: <xms:JcQFZ9hAlOMO4ZK7vseOg0aPY_quAci014qF9GJy9gnC-Bz2r2aYKw>
    <xme:JcQFZyDId3d1zqQbBwpqC_p2_KccxPw_ruyy2edYnItvI9Ekibmb6Aln8inZHGMz6
    Lj31RWEpdKUhg5zEg>
X-ME-Received: <xmr:JcQFZ9FNrbASiLF_tozRq6jnObVesmi0Dc6nbxh-Rt8gQe-hgXGd8XPx8fpgPvB4hEywywA2BqT8GJ92F8I-IrWEPFzLmn6kAzH_CEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JcQFZyRUQy1PCuNbS0kDssoI_wh77_jV7Gr8lDBqe-5xlcl5krRI4g>
    <xmx:JcQFZ6zvtsjLRQ-JfPZNvfg20ZM6a7gVw3Q_wNrk2fEpfnKk7R_CKw>
    <xmx:JcQFZ44wr2yp5br1RcFgMTObzgrDHtNiMj8V8RWaIm8--p0l0SL-JA>
    <xmx:JcQFZ_zRvAWYYGaEOxQA6RoBfKbwX_TjIRixr8HAkR7Jgz3J2bnwww>
    <xmx:JsQFZ-iSfCxhDvqDjRz__eTFfFBc75yaAQvLY7tiwMnD0loJAplzcukv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 19:45:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  mh@glandium.org,
  sandals@crustytoothpaste.net,  ps@pks.im,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 8 Oct 2024 16:19:35 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1728429158.git.steadmon@google.com>
	<2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
Date: Tue, 08 Oct 2024 16:45:40 -0700
Message-ID: <xmqqed4qxior.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> automatically builds and tests libgit-rs and libgit-rs-sys when `make
> all` is ran.

Is this unusual, or is it just like how other makefile macros like
say USE_NSEC (to cause the resulting Git to use subsecond mtimes)
are meant to be used to control the build?  IOW, shouldn't this be
documented near the top of the Makefile, e.g.

    diff --git i/Makefile w/Makefile
    index 41ad458aef..2b55fe9672 100644
    --- i/Makefile
    +++ w/Makefile
    @@ -392,6 +392,9 @@ include shared.mak
     # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
     # if your $(INSTALL) command supports the option.
     #
    +# Define INCLUDE_LIBGIT_RS if you want your gostak to distim
    +# the doshes and ...
    +#
     # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
     # database entries during compilation if your compiler supports it, using the
     # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`

It might make sense to follow naming convention to call it NO_RUST
and flip its polarity.  Those who do not have or want libgit-rs and
friends can say NO_RUST but otherwise it gets built by default.  It
would give you a wider developer population coverage.

Thanks.



