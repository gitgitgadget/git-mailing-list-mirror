Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368874C6F04
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929996; cv=none; b=q/FUgl6dyxiC2sPJm7h1FMWtX1I/F3bZwN6HjcsdsHM2rZCEBXqWEzt0xp0z2G2X9fYXe09ygDZAVTYjBXvB5YxvxBI+GSfTBJeW05JXKtK+uyttPpt8OGQi4JyFt6qUW4KQDsxFuVxDxAAYUGw8IlYk74EeY0pQLeg/jjBfsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929996; c=relaxed/simple;
	bh=dwFO1G1mMG8LcCHCxj28WF8v2AcLCZwYWua3kX/Wao4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QsdyQT/TV/nb7fnpOLcyE22XWEnL0XJY4nRYRITnPpXesyV/8Kvp7lZvyjjm9R1QG0IRFN875AeV0Xb1YsPRLJXhYh4AJ/W4QSHrP1vHlWLDKWeQ4KxhObyp7kMU9s/UpzCANIiIl7nKdu16AejmkoW93GmRocOviDbm/tOsoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kNoAr3N4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bv2sUF/l; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kNoAr3N4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bv2sUF/l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 41D921D00118;
	Wed,  1 Jul 2026 14:19:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 14:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782929993; x=1783016393; bh=ZdqWLWqFGv
	4I9jp13j0hhAx0i3PLxHKmkZFFK9O6b2g=; b=kNoAr3N4pGfeJANqi1C4nEuuIm
	8rrLsWgWnHf2uPaq2+XEScVlQV6HQWj5B8ViIgLqXdnsHUuY7k+dx408rTgV6TUC
	rLbqMoKGt2GvJisqpZYoNSai47ai5zOtQQ+xMvrIPueT9rvvq1poUmU2qQD720xA
	b2ZQ5NewELX+FzAqcurRFLMhgl0KRrW4Sty3bRXFj2rOLvkOwgsSsR+458+6NZxr
	yzoH+zT5Pb/dqxxYEMqwhT+oqMYBINabbk5NOGeDwWam7Tc5Csi2ukY4cHbwry9R
	ROg/Mx8oAsrmtnDNsYo36KpzNWV5+XRNfkBWE6zfCZxe+h3zempYdUJ1Hzaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782929993; x=1783016393; bh=ZdqWLWqFGv4I9jp13j0hhAx0i3PLxHKmkZF
	FK9O6b2g=; b=Bv2sUF/lBqTA5Za2/eAgXmNylj1a0B0Gp74KXe7vAgN7cwGCAhT
	hltYKmpwPopJ7Hnig7KPhsPDMeNuLpQA8HtsHqniPaO1zFGfcukAPKMMDEwFksEv
	DVE2X12A/GgVRRIZUc3MHDmgfjpgZ26DvUHhiy19zwFKPLLh5+do54I0iIjfZXk9
	0XefQx9Bc4j18K/dczT7JVlAYDrkMSaGZGPCQ2vKX90sTtKz0w9OrjhLKhnrt3g4
	xkyyZqKv2aymRGZg5hTE6y0LxORNz0ARmqvrZZauViJbAz771EI5TztqArY6pmOZ
	8U/kBGJLTirXNCJ2e47uTt/VSE3JD4zV8Kg==
X-ME-Sender: <xms:SFpFagDZElLhZ6M-1qbR2fMRdiK0EmJSmhs-nNoED9q139spcThbBQ>
    <xme:SFpFauXPLarjOPT_unzXcGhBhmSKWQjUGH3Ck04NOgLk6y9FHWFyVthlCIJ_csAr0
    jOKwvADVfhIue36sx4hRxyTt1ImN_0kZcroz8qvo1-3Hh0LEAu8pVg>
X-ME-Received: <xmr:SFpFau97tqN1ghoDA6gm8t0_CcbPuIXibRJjmMczSE2MSarv_T2YUZFw-a0ftEj45D9QBhrKz9JZoQHYprxOG9mbESrTp7mSqXQSwWE>
X-ME-Proxy-Cause: dmFkZTF+XNSYsZS1UVzZUE9/VNsbG/a0uS0/VuWvev9a055gH9sVjZ4eFJbLElTwCz7vjh
    j0nPy13r7re4NZ6hNX5ooJWDSGhKoEgYZVBfeIIadQtGEIDmT1pXmeNqy4pGrnuZbAO6Kq
    UKDAC4eunFHSL5YqJfXCJ4AJQNjQCN7nkl2L1JWkx/ebqlf6cmQfyMVpckYGlwVjXmMPQQ
    fTHlAMNSH0qzoNVJ0bL5Tc3qyDrelpF5VApy9/3rlnSD04Nva4DVxw+HCMLIHn6ZUrvj4H
    nCZz7rPcSLMKR5gbyrrIytkeD0GXNaTFjoMUsivRHIFeSZyzUdSSSaEL7h+WR4SNBnA6gf
    M3/9+9BVcb+NsBK9JnYt6DG6CgomwQt4Ov6CCTuDU9XigGKPB0nMOUgdZzY9F6LuBEIEBv
    IQGUG6r5YCFrv5guNaoQyG4vI0Ard7YHcA0+mwKjB48biERu0h/RfuyOCUaKreUyCnkFBX
    PbwSOenMSRyeoRzdR750GOdSCduzQisbsM5c1YZQn1yU7OeVchlKx7TDbayt5nh1e2NE+I
    2zciMYSPCy05ztkPPJzDuXflTGsbIBqjhfy18dRF8QyPLkD3E7cIeQ0ZzdmMBn013GWAgn
    TXI5Nl8FOCYgJEQpyQXjaXsNLzN4JEZ/1ZTmXfE1XBtENAD0rUjBkvTpJWCQ
X-ME-Proxy: <xmx:SFpFagS8DV2vs0U8GVrJwiFFN7uJVOhUaxk6Di3pPysGUNFk-JCDxw>
    <xmx:SFpFajQ8_wc5mDxkYrtLI9dvAdGjFXuKHaxgSzToJpbNEajS3z1M5g>
    <xmx:SFpFas4rsnol6MVB2zAt5yM2Tu8i_kVKBxrrdTPpl9h0RgpiJXiqlw>
    <xmx:SFpFaoXIuCALL75bBQ1Rpbly9CkrEVpCSPVKLI-8VzDcGmvHTGMilg>
    <xmx:SVpFaudZ1T2LhBHdb4bSL3uFW1p6Z24Uga68eb5-uXtFItYLe65d6O9o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 14:19:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com,  Jonathan Tan
 <jonathantanmy@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH GSoC v15 05/13] fetch-pack: drop static `advertise_sid`
 variable
In-Reply-To: <20260701-ps-eric-work-rebase-v15-5-c88a43b63917@gmail.com>
	(Pablo Sabater's message of "Wed, 1 Jul 2026 14:18:39 +0200")
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
	<20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
	<20260701-ps-eric-work-rebase-v15-5-c88a43b63917@gmail.com>
Date: Wed, 01 Jul 2026 11:19:50 -0700
Message-ID: <xmqq7bneo9mh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> `write_fetch_command_and_capabilities()` is moved to `connect.c` in a
> subsequent commit. To prepare for that, drop the static variable usage
> of `advertise_sid`. Currently `advertise_sid` is used in two places:
>
> 1. In function `do_fetch_pack()`:
>         if (!server_supports("session_id"))
>                advertise_sid = 0;
> 2. In function `fetch_pack_config()`:
>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>
> Since `do_fetch_pack()` is only relevant for protocol v1, it can be
> ignored because `write_fetch_command_and_capabilities()` is only used in
> protocol v2.
>
> About 2, call `repo_config_get_bool()` directly inside of the function.

Puzzled.  The patch does introduce a local on-stack variable with
the same name, but does not remove the file-scope global one.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index f13951d154..ad07603755 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  						 const struct string_list *server_options)
>  {
>  	const char *hash_name;
> +	int advertise_sid;
> +
> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);

If there is no such configuration variable defined anywhere in the
system, advertise_sid will be left uninitialied.  Wouldn't it cause
problems later.

Initialize it to 0 (if the default is not to advertise, which I
think is the case but please double check), and you would be OK,
probably?

>  	ensure_server_supports_v2("fetch");
>  	packet_buf_write(req_buf, "command=fetch");
> @@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  	}
>  
>  	if (server_feature_v2("object-format", &hash_name)) {
> -		int hash_algo = hash_algo_by_name(hash_name);
> +		const unsigned int hash_algo = hash_algo_by_name(hash_name);
>  		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
>  			die(_("mismatched algorithms: client %s; server %s"),
>  			    the_hash_algo->name, hash_name);

> While at it, change `hash_algo`'s type to match `hash_algo_by_name()`'s
> actual return type (`unsigned int`) and make it `const`.

This one makes sense, but is better left out to a separate step.
Especially when the primary focus of the change is iffy (see above).
