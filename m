Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA727979F
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524181; cv=none; b=WDxp2KCYLUUouM+JmStYzBh8Cs2RhrLe9b4NdPy15sE2JnSEL4gaWjs7UGmMduG5ri5FUoXrQ2IY47v4nNV2RFx+pe0P4JDYrv5ST/F0fRQAqY7y7JlGohCcnU/0DIqRlGqKIk65mlP5ag5Ob5ZemImC42c+kVb8OFTZRwMukns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524181; c=relaxed/simple;
	bh=5k+i0A0c+qnTX2uelEHOjfJ71PgtdcCdl6G0PQSOS4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qBRNIj6Q11sq/ipOe9EuYYYU8nj8u8nPdau6kfnRnIcxsorESWYZ95/Y+NdUXl3+b4P5LnCX1WmTwDhzNvTzK8q3MDubNkoHnw1M6JxyIJKFPPGOnAb0YN4cgtdGMlnJ4D9qm9EK5XbUdPnkcx+nZ2yb8Uc+D+bqwI2Gbxj3MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=27pypOxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0jZPeQj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="27pypOxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0jZPeQj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A85027A01B3;
	Wed, 10 Sep 2025 13:09:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 13:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757524178; x=1757610578; bh=xKQYjY/K/y
	UHXa/KuVkyRmMHDw3aqPT+NyeGbSdPKLI=; b=27pypOxmTRjEpmTIf8k5s5Ptwy
	TTMBwT7Wg/Di5dviS7Y+1YpahdTd+HsZ9lGhHkrIBWfigkStL3EArSoHTiMs44A5
	sk26RO3N3MMvM2NtF+Gu4seKu1CD6qqLPKEwcZlLUSuRHiYT1z1sJ1MYOIPXi/Tk
	Ck6vrIGl3vtQdIASwqxJcxcfRWEzYh5YHF6rXGlWg2gxLgW4E2T8DCKdmWFLEtHd
	sB6LvFUMCZvL8WIgNproQx/HkFii35fYZOCpmZqXyoThokp/5kIDqjC4l7Y8OU2e
	A9HIYNfwvQ6l0h/Hyy7sCkVVT4Bcp+6d6cSPWuqOkCc3vt6VY2I/P5jopfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757524178; x=1757610578; bh=xKQYjY/K/yUHXa/KuVkyRmMHDw3aqPT+Nye
	GbSdPKLI=; b=D0jZPeQjx709OnWdXLfbfta0sEHmHRmOC3vSyJkMCONOzKty3aW
	AsshGhH5ZDQjYEo/otjdMEe3KI18OhXtKwwU7EPgk6F+7OR/cDYp6wrBCrgRleDZ
	JSsHkyf3YlW1fRRAGM3TTem93J+EhPIhqeobccmpgIEqH288Rlat7yveEe0cxyMn
	cpx77rfpAYP0QIzI2ByOGxy3U8e0pSULc5A0pK2b1wS7O5IwBLbyTu368yn+e2Gt
	j+1wBRJ6/MT5UYtys+w2fAj2B8kphYsc33cp9/HR7Egt96Rm5QPsC+n3okLk5v7l
	Nzt9Vk5KfJSTCcJP1Dfb/d0kje04ovyLrSg==
X-ME-Sender: <xms:0rDBaKmIieLITEWoY8jiYM-J6rjO0qcnd2ebznO1vhjiCXUv6bK1VQ>
    <xme:0rDBaOvaQBZnNYLUsKQ_K2JgxLmu0GjQPdNhPK0e2hslHjM8fHKBO09-SPuXJb-Bq
    pSp8ubVZLei0b2zhg>
X-ME-Received: <xmr:0rDBaIYNfWbUGRoihZWt_pn8Vp_YqDcMucvz114PHBdo0p41PSyc8RLGlhQUF_HaCdg_xccJ4Ch_2_CNUF0U_Hdi6gTApDL3aMMRYJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0rDBaOBVbSp3yCq4n98Q4Cnc81xwFmPw9iVIH7NW-nrNa2YP4ufU2Q>
    <xmx:0rDBaI-G1sdVQw7WJJcnpjXZjuWuxNK9gGqlIx4xEbWsm1__1ucoGA>
    <xmx:0rDBaCTBFqpKhl3waSCewul-o8l4E1-OS-fTuPVg_jC6jM6iuRJ9sA>
    <xmx:0rDBaEV7MppbW9cy4tjntV0TlAcj-XEKejrmS3MHyV9Uwp6wfbZN8w>
    <xmx:0rDBaPzeExJAn2TWJtlUmtmGfCerbJLb-a__IzRhIF670SfdT_Bqg51q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 13:09:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <20250910080839.2142651-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 10 Sep 2025 10:08:39 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
Date: Wed, 10 Sep 2025 10:09:36 -0700
Message-ID: <xmqqtt1as08f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> @@ -2785,6 +2787,23 @@ static void store_signature(struct signature_data *stored_sig,
>  	}
>  }
>  
> +/* Process signatures (up to 2: one "sha1" and one "sha256") */
> +static void import_signature(struct signature_data *sig_sha1,
> +			     struct signature_data *sig_sha256,
> +			     const char *v)
> +{
> +	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
> +
> +	parse_one_signature(&sig, v);
> +
> +	if (!strcmp(sig.hash_algo, "sha1"))
> +		store_signature(sig_sha1, &sig, "SHA-1");
> +	else if (!strcmp(sig.hash_algo, "sha256"))
> +		store_signature(sig_sha256, &sig, "SHA-256");
> +	else
> +		BUG("parse_one_signature() returned unknown hash algo");
> +}
> +

THis is a new function; I am not sure if the division of labor
between this one and its caller is done right.  See below.

> @@ -2817,19 +2836,28 @@ static void parse_new_commit(const char *arg)
>  	if (!committer)
>  		die("Expected committer but didn't get one");
>  
> -	/* Process signatures (up to 2: one "sha1" and one "sha256") */
>  	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> -		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
> -
> -		parse_one_signature(&sig, v);
> -
> -		if (!strcmp(sig.hash_algo, "sha1"))
> -			store_signature(&sig_sha1, &sig, "SHA-1");
> -		else if (!strcmp(sig.hash_algo, "sha256"))
> -			store_signature(&sig_sha256, &sig, "SHA-256");
> -		else
> -			BUG("parse_one_signature() returned unknown hash algo");
> -
> +		struct strbuf data = STRBUF_INIT;
> +		switch (signed_commit_mode) {
> +		case SIGN_ABORT:
> +			die("encountered signed commit; use "
> +			    "--signed-commits=<mode> to handle it");
> +		case SIGN_WARN_VERBATIM:
> +			warning("importing a commit signature");
> +			/* fallthru */
> +		case SIGN_VERBATIM:
> +			import_signature(&sig_sha1, &sig_sha256, v);
> +			break;
> +		case SIGN_WARN_STRIP:
> +			warning("stripping a commit signature");
> +			/* fallthru */
> +		case SIGN_STRIP:
> +			/* Read signature data and discard it */
> +			read_next_command();
> +			parse_data(&data, 0, NULL);
> +			strbuf_release(&data);
> +			break;
> +		}
>  		read_next_command();
>  	}

I am not sure if this change had to be this way.  The old code
always called parse_one_signature(), which was responsible for
checking the signature format and then calling read_next_command()
and parse_data(), so no matter what happened afterwards, we know we
are consuming the data stream regardless of the conditional execution
that happens here.

The new code calls import_signature() or an inlined sequence of
read_next_command() plus parse_data(), essentially making each case
arm in the switch() statement responsible individually for consuming
the incoming data.  When somebody adds a new case there to specify a
different way to handle signatures, they have to make sure that they
do not forget calling read_next_command() and parse_data() themselves.

Even though I can see, after some code inspection, that no branches
in the current code forgets to advance the incoming data stream to
leave us out of sync right now, this change feels like a bit of code
ergonomics regression to me.  Was it so important that we pass a
broken signature without inspecting in STRIP mode?  I am guessing
that is the reason why the new code tries hard to avoid calling the
parse_one_signature() function in these case arms.

An aside.  I think the warning message about importing should have a
word "verbatim" in it, e.g.

	warning("importing a commit signature verbatim");

Thanks.
