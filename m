Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D23ABA1
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907662; cv=none; b=XO41+hOiFcEQXqcHqH7c7pqeZFtvSCivCxKNA218c2oIfDM6en4CMpK1iZmfJeYzn8mOQHM8G3qUwxzTu9gJ7GxRfl+Jtpc4QUicJK9zLfuNOPbv3RKh/IJ2aK1E7TcFQj3Sl+Mq4ZUUUr2pGE3uQMRNlwJRWIGRypNU9ropduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907662; c=relaxed/simple;
	bh=Tu9HNa2z6gmxqLwsv24rfNV5ZSU/gXM0YBByF/z5uv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnlj7CFK4CIvSV1rVSwPelXC9HNYunD5N4wc72jv69RT72UbWBwV39xL5iaQJZfDFuoPVZ/jL96MaJzNfh5XiZ8BoQWtFEKMZsVHfRJ/2gFWRUchnH2F45Ub5Pd4rHVdXd99UyHLU9ZbCLLze9WzWX0tGUOZE9cN7tLEBRxlqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mxfach0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bABjZuWV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mxfach0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bABjZuWV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE2827A075A;
	Wed,  8 Oct 2025 03:14:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759907659; x=1759994059; bh=kEmxwzgfM/
	bMwOSCrZvKTBJzL8EQEV6Xoh5PjbKq74w=; b=mxfach0zhYqc5d37OgI23fA7hn
	lKBTmcFaXLQmbmrxv/yxsx6f5vIFcByWq4KqZjS/aSno3KRSAuB40MAHXo+krPll
	r0yf2epBpHcJJMZyQGmeUJKeri/XIhN7H8RYdvoaV/JOCLVzW22LxAhl0fDtj9Bu
	JsMDWSz9GL/qBvT9MEvXmY8Ax+I/MW8YAUGjrWBiweMfgUxekEVkLLjNtebs6net
	lD/stSNc6XG6fkrZmMU7oZbuNt8CZFfjGlpJrqQGvXFJSThhP8MLghGFSCGZ+GLs
	8CdJOILUNmOjJhiUG/28RpKHVoPfb+ArAwLMrRmItZa4mnxNh9OlzQHwMS+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759907659; x=1759994059; bh=kEmxwzgfM/bMwOSCrZvKTBJzL8EQEV6Xoh5
	PjbKq74w=; b=bABjZuWV745tzRIOf83qpptM1cGv2fhC0GrnyfELgFYD9V1h5OM
	qGgJ4dH15dn9kr4sZzMiJdMmEIwFHsAQgU87OTUTe/DyyB+S7vHDQkqNKeG2zMl5
	ld0HLVrAvCoouBdE1B66d9o1ymEKCu2wOXcn3Sqd7PsCkbXMB18kNnfMO5cjEqLV
	oJw+kGPQguF1tXmn6PrRXPUrQstyEf+6NdKeS6irRurWosY53cqINnm7juauajg8
	g03K1qiRtak5Nsvrvr4bF4+VuHkerUBbKtxd0NcgWQQSwg+vR8QO7LNnhwmxseUP
	eWI3fz/gKsfud2Ba1HM7kgiXqEVgVAriOcw==
X-ME-Sender: <xms:Sg_maDRHGX7Ebuj73-vUqtOnJcYxhyuP_8z3BQMORHjxEewieFTSnw>
    <xme:Sg_maD0EFbFOdqsZ9EdkwKoFHCluodkYndvqJVhuNcpBS5SL8-qoAuCUKY_h5V1Y8
    KthJ8-A4P6IY373o-v8-AvDNqPct0MQ6VEOoRyaEocLWgDURW_U_g>
X-ME-Received: <xmr:Sg_maPBZiqlwDR1kmZo6K47N4mJLyftsmbfQdTIwGqWrnhuuyRtKqedX33uk-TeDQviy73Aw3n9GF6BTvc4EVTb_R_KblxRtTy3T4zVr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Sg_maPgI3_rHt9n9dOkv88rZZHZtu7R5Jpjv6uVUIaw5l2xJGd-oEw>
    <xmx:Sg_maBMw5K_4Yoq1p4m1ObHz_L6lRK0BD0YpMefgBcvrkear6nMAcw>
    <xmx:Sg_maP-HlZO4hsvCPxRgwCxNQfRG7IFInkmKmikqzJkq-dBRXN63Bw>
    <xmx:Sg_maCdSsTIbGi8qMTeP-4Wp_MW9TWGqoqvB0auTXBefEMZUVMwdhg>
    <xmx:Sw_maPoBa2WKg0ACIZZ8FenysgqdGL1p0WWkPBA4qkYW1qtOazSdoCme>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:14:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae1b0962 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:14:16 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:14:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/5] doc: git-tag: stop focussing on GPG signed tags
Message-ID: <aOYPRKoexRtYUDsh@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122958.1089680-2-christian.couder@gmail.com>

On Tue, Oct 07, 2025 at 02:29:54PM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
> index a4b1c0ec05..9117754ffb 100644
> --- a/Documentation/git-tag.adoc
> +++ b/Documentation/git-tag.adoc
> @@ -3,7 +3,7 @@ git-tag(1)
>  
>  NAME
>  ----
> -git-tag - Create, list, delete or verify a tag object signed with GPG
> +git-tag - Create, list, delete or verify tags

This is an obvious improvement.

> @@ -38,17 +38,18 @@ and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
>  Otherwise, a tag reference that points directly at the given object
>  (i.e., a lightweight tag) is created.
>  
> -A GnuPG signed tag object will be created when `-s` or `-u
> -<key-id>` is used.  When `-u <key-id>` is not used, the
> -committer identity for the current user is used to find the
> -GnuPG key for signing. 	The configuration variable `gpg.program`
> -is used to specify custom GnuPG binary.
> +A cryptographically signed tag object will be created when `-s` or
> +`-u <key-id>` is used. The signing backend (GPG, X.509, SSH, etc.) is
> +controlled by the `gpg.format` configuration variable, defaulting to
> +OpenPGP. When `-u <key-id>` is not used, the committer identity for
> +the current user is used to find the key for signing. The
> +configuration variable `gpg.program` is used to specify a custom
> +signing binary.
>  
>  Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
>  tags; they contain a creation date, the tagger name and e-mail, a
> -tagging message, and an optional GnuPG signature. Whereas a
> -"lightweight" tag is simply a name for an object (usually a commit
> -object).
> +tagging message, and an optional signature. Whereas a "lightweight"

Nit: let's rather say "cryptographic signature" here.

> +tag is simply a name for an object (usually a commit object).
>  
>  Annotated tags are meant for release while lightweight tags are meant
>  for private or temporary object labels. For this reason, some git
> @@ -64,10 +65,12 @@ OPTIONS
>  
>  -s::
>  --sign::
> -	Make a GPG-signed tag, using the default e-mail address's key.
> -	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
> -	configuration variable if it exists, or disabled otherwise.
> -	See linkgit:git-config[1].
> +	Make a signed tag, using the default signing key. The signing

Same here, let's say "cryptographically signed tag".

> @@ -75,7 +78,9 @@ OPTIONS
>  
>  -u <key-id>::
>  --local-user=<key-id>::
> -	Make a GPG-signed tag, using the given key.
> +	Make a signed tag using the given key. The format of the

Same.

> +	<key-id> and the backend used depend on the `gpg.format`
> +	configuration variable. See linkgit:git-config[1].
>  
>  -f::
>  --force::
> @@ -87,7 +92,7 @@ OPTIONS
>  
>  -v::
>  --verify::
> -	Verify the GPG signature of the given tag names.
> +	Verify the signature of the given tag names.

Same.

> @@ -236,12 +241,25 @@ it in the repository configuration as follows:
>  
>  -------------------------------------
>  [user]
> -    signingKey = <gpg-key-id>
> +    signingKey = <key-id>
>  -------------------------------------
>  
> +The signing backend is controlled by the `gpg.format` configuration
> +variable, which defaults to `openpgp` for GPG signing. To sign tags
> +using other technologies like X.509 or SSH, set this variable to
> +`x509` or `ssh` respectively.
> +

It might make sense to use a bulleted list here to list the different
available formats. On the other hand, we could just as well refer to
git-config(1) so that we don't have to repeat any of the information
here, but instead have it at a central place.

That might not be worth it though. In the end there aren't too many
different commands that write signed objects.

Overall this change makes a lot of sense to me, thanks!

Patrick
