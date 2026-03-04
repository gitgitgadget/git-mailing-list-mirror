Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97F3845D5
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662297; cv=none; b=Wplfm2Ph9Dd6i9aUzZhREN6d5JHUubwoyGrd5/nUEhjQ9fMgPY2XIizhdMtOqczsFggprD9RejaPuTnL/sPLHoiBJsgzSzkGarAiywESG4TtyRSPBk+TYGPoNcqRaTcLpcvKvOct6fEGwtUWT4c2iPnuEzstMuw5DQ67wKgOX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662297; c=relaxed/simple;
	bh=CgR7cNu4Ff+pqlSNEnwQ4SvzsFpD/7jTg2KKGtVj4VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XDxZLyFCFoM45OCpa7IOBB9CCe1B1HrWh+AGYaaDFt6ZP9UMpcqGRSyorpRiEIYdZU09Gt9VpUIbCqdgCy0uUL7nf3WNj/INlaPCswzDL400OUkhS5+SgAzxTQ5231Vm1AaAJp3pAp0IDBfqpMBnLQUOCapVSVVqLLLvVPbcs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kIcucqj0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODQgL3RE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kIcucqj0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODQgL3RE"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88D107A000F;
	Wed,  4 Mar 2026 17:11:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 04 Mar 2026 17:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772662293; x=1772748693; bh=qV8aFISFxx
	iYHqB9y3u4ifC/l9pGMaRl4MICkbtY/GM=; b=kIcucqj0wrsW8yc23+ISnETusV
	WKjXX8vj2epSSlUHtqkeLl8JUw/VY+wO8zl/bBhDPaFgUZ5oj3VgS+tHGNOI9i5k
	EqsbN2GTyMXo3lQuEH2pePSND/Y2ViviGJiPk59tvEDzlm/DYtxFrfMtgGNC0q0r
	alvDZiw6Lgy1Wyw+psJZTA5+0w5ErzW81WyOSZbBjPAhBIkWkfevNPHQppQisVXv
	yr2uX8LviT25C4C0gNqpD1WJU501B2N6Qluk+t+Dy7PookU89H/CNzKfQi3TFy6e
	ibr0kFrhGJrRWJjoze1alfV5SqV1JIbv+sK0d5TFeJ2XIFKDO6QczlKMPKNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772662293; x=1772748693; bh=qV8aFISFxxiYHqB9y3u4ifC/l9pGMaRl4MI
	CkbtY/GM=; b=ODQgL3RE9VghfQkAhxYAE/kupg5/ICkuLgD00ki+8XrBjP5Xcfj
	HFVbE7o1wjpc4bMAUhKZ+6RKx45xc7LjSSa/KLOq5U1DSi6F67YbW2TbJMp6Zaa1
	ZE3KuchCzFcBiRd+Gx90VndKDKqwP4VSEmxzn83mHZVFuGBkVccx+8a55SxoucVP
	jIhS3lozFik3TqRdJA/09yQm5JmO0HPbGzzRSfGuSJFVS+f6PECzvtz0p9ptZZf6
	iOMkV2Njt8lWqq+oFmXJ4JJ/Br/StiK+ayZOxU82X0F1rAigfizd6lRk1XfOBzGU
	/2efTJ+TfJjo68yulYpBsQpFoQLi18s1uug==
X-ME-Sender: <xms:Fa6oaWaLccOqn0KSVlIlH1W1ngWdgA1Axs6XaW8MAFhhtP9MAzmEpg>
    <xme:Fa6oadE_Dyjol1DKJJRoRoyUmtcL2pe5IDqbCeWbAn05UZRkQ7G3kHeGd5JQ7Xuoe
    WjPhjIIQmAJU6mXHgz5xPgg3QmAelruMDf_Eh8AYewKPHe_Cl89>
X-ME-Received: <xmr:Fa6oaaxMQx1d3FwNF6Ul632qEA_wfkI8anvXRy8F7ybwq2-YpaakVZoB2Z_7jyPiOkp_H8hlL10BXqrRlEPWhpEcxMUof8gqSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Fa6oafmcB6dgJroJmtcHUNacE0Uh1upSHVXkzsXLfPCa5eRFR_8BPg>
    <xmx:Fa6oaTlbR_90pSvJY_W-IqTE2riQb2bkve0QvRNEgNh0DAYoMTFTaA>
    <xmx:Fa6oaRwsE-OVM4xXRzFJxFcyMTsHT5jq4e9Aq5pxSW2upgkP-QkVgw>
    <xmx:Fa6oaYpmo-gjqbyg8vRFOVo3zaAFq5X9hkynvnz9m8jo0tHn07-0PA>
    <xmx:Fa6oaZrbVGSjQKVoL4nBc4Y3jSCU1cm5t1OrcW0wQFjQwU-meR3IYUgN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:11:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/10] csum-file: introduce `hashfd_ext()`
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-8-7321830f08fe@pks.im>
	(Patrick Steinhardt's message of "Tue, 03 Mar 2026 16:00:23 +0100")
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
	<20260303-pks-upload-pack-write-contention-v2-8-7321830f08fe@pks.im>
Date: Wed, 04 Mar 2026 14:11:31 -0800
Message-ID: <xmqqjyvr5jos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -static struct hashfile *hashfd_internal(const struct git_hash_algo *algop,
> -					int fd, const char *name,
> -					struct progress *tp,
> -					size_t buffer_len)
> +struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
> +			    int fd, const char *name,
> +			    const struct hashfd_options *opts)

What does _ext stand for?

More seriously, this essentially chooses to pick two parameters
hashfd_internal() takes and put them in a struct, which would give
us a clear upgrade path to add more to the structure without having
to change the function signature.  But what is the criteria used to
choose these two among 5 parameters the original function takes?

Specifically, I am wondering if fd and algop should be part of the
structure, as these would be exactly the same for repeated calls to
this function to write to a single stream.

> +struct hashfd_options {
> +	/*
> +	 * Throughput progress that counts the number of bytes that have been
> +	 * hashed.
> +	 */
> +	struct progress *progress;
> +
> +	/* The length of the buffer that shall be used read read data. */
> +	size_t buffer_len;
> +};
> +
> +struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
> +			    int fd, const char *name,
> +			    const struct hashfd_options *opts);
>  struct hashfile *hashfd(const struct git_hash_algo *algop,
>  			int fd, const char *name);
>  struct hashfile *hashfd_check(const struct git_hash_algo *algop,
