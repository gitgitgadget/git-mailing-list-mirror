Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DBFBA42
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760343; cv=none; b=MxQHmrQfTqjM7Sco4uZTMXs35YhXc3j3szYha3JcGO0A6JL2dGan8dGLSmqbBLfzcFF6Ztigxnl1i0ZE4vKCFssITQ7oxHX7PQWkdUxkKMV/qevDbOghnlndkFNaazFBQV2mZeneoq+uNakxFBYLcXAmO8/DgVXDbuDmDPUotMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760343; c=relaxed/simple;
	bh=pXCcgMBm91VprnzPkTaJ/FAHK655QuJx3BUp5Mseovk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVSc6AR0Hf5tFJ08ysT7w/G1BbVLc/jD0ZrjCEVFgXZ+K9nKC45MOYM4tF7nAVrsucYTV2GOBK7zsELiVbjwDUWCl7ho5Xwp7nCoPn7KMPHmvkBKO2YD83sM3OOparEf6yxqAWiiZbTNQM0kaC+p+nOS4kdUzDF/3c1z28+ycAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MXQrbeVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zXt/uDQA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MXQrbeVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zXt/uDQA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDE28254019F;
	Wed,  5 Feb 2025 07:58:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738760339; x=1738846739; bh=qdRm/XJsAd
	dWeK6cffdms7LSYRMv0MhC39TN3jtYNug=; b=MXQrbeVW1kltEN6a+LwIZgQyhk
	enlppBzwDyGo2LZLmxfOJvNdLzYaQmVgN5bGuFRXgkUDEJn8Z92kCnqKlyJYggwb
	4j6QLA4gYLeSG8VzWrykcdagCNE2MMSPdu1t3gqXG10nYaEWSmtiGs6Xw20ooAYp
	8aS7P2Nywu/Kik93172MHD5s7OxtKTt2m3q7uzLyJr9iNY8JVKa0tCx3ju8wouRe
	1wnFJruvz9FswyLWq36NfGPdk2VDgqYPQmgW7IKL27jLEQSRP3kxtvco6P17tIj6
	eyQw7nmc00UJod+BJe5sNDm1NE39bCQ/ya4QeUG+CDRhi/lLY7TB30a6c9XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738760339; x=1738846739; bh=qdRm/XJsAddWeK6cffdms7LSYRMv0MhC39T
	N3jtYNug=; b=zXt/uDQAj65EEORSV9PVzyiKKsA6wMlSeVv9QdX/IG8e426bB7s
	FANFi8qArw/h3DB0NYY0UJSrElHfazfhniFFEEqpTp5abrldbLGcxP0XLkRAoV2l
	m3RBYwJv5G0IzuwFkmJEvHF4TyosLmW4AQ055ME25vUjn1bohwZzU2gZS8ciKOxt
	WyhKyUCbctFkdAy7ybM++eLOet5gpfvm1a9LMar19ew+FFv7kV1IYxSYd3bxaV1K
	kGk41ZGkAfbi5qG7WqhBrJqoKxUUtU92v9xwoRpT+TJpn6uP3EJ4pg5NutLwTnMH
	ZpUzaN4jueF1olYhbWkG1ARWqPdDZXwb9WA==
X-ME-Sender: <xms:k2CjZ1tjhjLNyyjTATVnOHTm1R73nDd1dy2GtwlfQzfLR4iqL77zzQ>
    <xme:k2CjZ-crVgpZu3qgJSDz60BjI5pA01qxIYXmtd8Z4NMy4Zgbw5PP87Tu3Xi_sw32g
    j-iqxq0-vFgoQlLPg>
X-ME-Received: <xmr:k2CjZ4yTdpRPmA5liVc_E_jHAMSIw319tMSltJV-Ak1UiSUVHUCeWXzC34_upIQIBm0dgwAMe5NmgEvj7bCc2dxs3HBtFG9_pcIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghllhihrdiihh
    grohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:k2CjZ8MGAHGapLJhkQKeg_Cayve7-tDtlQD6IYv63e843AVoDdOFFQ>
    <xmx:k2CjZ1_XHbXDmAt0dqxtAFw8PpOMBXZ6-4vK5JGAVxmtOkR-0bPo3g>
    <xmx:k2CjZ8WprlsZnYqZqXEugjQ92x0GLkcdSYW8OpdkIgH2QfAH8Zyovg>
    <xmx:k2CjZ2fYHsCspM-jKipmT5fr8D147iZWDu5fwO9Qt1vXoJBjx15y9A>
    <xmx:k2CjZ4ksv8KUTD38QHeccPEQxioL05QvBqCWCPLULLxGRgpI7y-m8ds4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 07:58:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
In-Reply-To: <20250205014055.737190-1-jelly.zhao.42@gmail.com> (Zejun Zhao's
	message of "Wed, 5 Feb 2025 01:40:55 +0000")
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
Date: Wed, 05 Feb 2025 04:58:57 -0800
Message-ID: <xmqqh658r1im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> @@ -1087,11 +1086,11 @@ static int gitdiff_index(struct gitdiff_data *state,
>  	 * and optional space with octal mode.
>  	 */
>  	const char *ptr, *eol;
> -	int len;
> -	const unsigned hexsz = the_hash_algo->hexsz;
> +	size_t len;
> +	const size_t hexsz = the_hash_algo->hexsz;

I thought that I already saw this discussed in another thread.

The .hexsz of any hash algorithm would never be larger than what a
platform natural "unsigned" integer type can hold, so using size_t
for the member _is_ the wrong thing to do and the fix may be the
other way around, no?

There are genuinely good changes (correcting assigned variable from
int to size_t when the value ultimately came from a system function
that returns size_t) in this patch, but there are other annoying
ones like these, so I am not sure.

>  	ptr = strchr(line, '.');
> -	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
> +	if (!ptr || ptr[1] != '.' || hexsz < (size_t) (ptr - line))

Is this about -Wsign-compare complaining about size_t vs ptrdiff_t?

> @@ -1207,7 +1206,7 @@ static char *git_header_name(int p_value,
>  		cp = skip_tree_prefix(p_value, second, line + llen - second);
>  		if (!cp)
>  			goto free_and_fail1;
> -		if (line + llen - cp != first.len ||
> +		if ((size_t) (line + llen - cp) != first.len ||

Ditto.

> -			if (len < second - name &&
> +			if (len < (size_t) (second - name) &&

Ditto.

I said this before, but I am not sure if being strict about
"-Wsign-compare" is really buying us much.  If we are getting so
many false positives that need to be squelched by churning the code
with so many typecasts in order to find a new and real problem,
is it really worth it?
