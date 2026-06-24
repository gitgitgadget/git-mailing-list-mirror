Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A712F87B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324960; cv=none; b=CmLFhzFixKD9jjGvoEe6B0Ut94LDNYHi+aGO4Nk0vBlYPpe+khNyTPahEfIqpAGeZF8Aa0TfKIwG7Wlsz9DNp8Vp2rtXDgMcjx+jc0/0k92gFHcaZnZ3ZpA95rI5MffumMF1QXqJqLiGkyeT8c+LGrczdjTCvguCDulksPB+i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324960; c=relaxed/simple;
	bh=pICwT/FpgWJcbavl7FgftaJKcFDRj5V17hTNLhqrDnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=heY8NIYtLmUSAD3DuNIxtHrwXq3gLVMaS3EZExXOfPeWvO7FNx0nl92MtaKLOCIRilgpunMHTqbNca1Kp6cF2AU+nbjE865KUVsMNcFFIsW5CRhoub7zn7mUW74+6GRZKjWT6LZ8uBfwTEzOwT1gosRAssWGgb+ZZC4exzaZs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WpYOM9Xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsKoFINv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WpYOM9Xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsKoFINv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 142AC1D000E1;
	Wed, 24 Jun 2026 14:15:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 14:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782324957; x=1782411357; bh=em31vO7ZRU
	8SZndZ9IkKOhI7UY9YsTRpMZzulBtOpHs=; b=WpYOM9XexYsHn5oDdu/Yk7AQE+
	GkFCtHqYZu4vHxt4D3b7DfDI7nW6IQrwKTdEeNMHOrAflX7TyoV2UcyEMrguNWcx
	xqMpjFWTpLzFo8bh1r5d7RHZbtg71jnOk+LLpDmcyj7ZwKjrWzfATx7fUmVtLRWL
	cjhOHcS+eYYtuAeCKarMa9JvpQT352neObOad87dUbRRR8XfwANRsbATYAn3MfZb
	QuSFIJrFNgE0IvgTpNwG57p5Cz0Ax2QB5A7Dgs5NWFv/F+bH93OcA/anCphXkQyP
	T9OzECSSQPwzTxsB3aO8Up7FxNe6Wzt25nQTWFT0qMsP5bwZVVBZrLAVw6cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782324957; x=1782411357; bh=em31vO7ZRU8SZndZ9IkKOhI7UY9YsTRpMZz
	ulBtOpHs=; b=FsKoFINvWSARPlGEbZv02pJrdhK1gSjLemsO31GqIfrbIbBac/W
	HlgVYG7D6mnQOcvpl8aXqJBuuu+JutezN7Np+zmepNCxtfWRge3l/yyrCdkRScB/
	apYlej7fpETUMWOUH6SDG5ntxwidxJuKltsQYu/WicKEJMC9ttTTJulBmM4Zlk0Q
	9N43ZwOBVtiQ+AX/RyUvmnPvBG8DAFZd2YRKxC9JKCRNdvpONgiu6I+EpNTH9mxK
	NJQPrdTt2KFiOVj+AtZnyCptufmHHLECgkudtlICe/kX0kfvOSbU6ObPHqgDNVBR
	lNHUO4bSrxXLf8+tr/c9EEZpLGe4pjdqVwQ==
X-ME-Sender: <xms:3R48agcEQoX_yKFpVkE4GxvPqG2CGPfdPzvYRuvJzFP8MWcJJJc4jw>
    <xme:3R48anK2uuKB9ILAlNA8VUvbwlYKMrHSqSXtVaw4SaPUPwa4NtRy1j8L8fj-MFVUS
    W9hmpQJa-zk6CeV6ZTgtOB18htxJ1Zmmp1YcplOeU38tGgPQwzaFg>
X-ME-Received: <xmr:3R48alxKAtgFjUy94zEBewkuyxDPj_cXBaMfwGohNop2XxB-Bbnz98ohzGJwln8_B0Pq1haeZB4ssOyaZfcVffZIFWkS7SkUgLmi22A>
X-ME-Proxy-Cause: dmFkZTEzvFRcZA/PASlwifrrITCXP+Tsp+xiNdzdSBX3NUhpSKAFqVtrGO4apdGFDOfdVR
    aWozizORAMUyvjwVByPMUsqOCPfKrNx/jQk0/raL8MW7v2a9otxaL8xwhQ2QLwaqSmW9lZ
    ieJRU55Tswmwxkqb6eqcFvBL5+iv6hQ011yA7TpT9wLlMCeVztLrrMwfBMzgPF4cZmKyrQ
    IhL6eiLL2u27MdJfkolRn3glz4WoHqWo32GF197XOIboJQdfjXfJsXVwozBJBKivBMcv6n
    hr5fXFqbUZUXH2z5l9yGTOTfZvV/PKfvnSdDt91W27ogP98hScM09J9/VrB8PdBIZHgOTU
    6MgmYdXMQHj58HPpkGNLKFbcIvw2pTrtopDbrLIb8r35bOinMwYF3ooMKHTE5XjqK1+RtU
    k5hG2i3KfxXwIBsfs8uSJoJLxMLzABj8HohAddYP/w+GiV3arpAq/5hiXo7SZVAClrXjhA
    2BR23kk+TW0GKkq3U5jiLNsAW835kqusS1cjiokAGxeEBZWdZjMBnVkpqVKx9tgKJplAEV
    3cE+KhBWIZugQYLN6Ld3uCkW8RABVly+fcKK4T/VJ/4P6OPyb2PB1aIB3cwXQtkKMmZQOk
    fP7V6Bc03Qqt4o5NqQBCBMvYFDiB8ndRhoMg9vEQau4N7yqdyKFnku1pHnhA
X-ME-Proxy: <xmx:3R48alsHOm5-l9caHQ2a73scnn0nDJL1aK_MfnqS3W1rCH-HKVrLDg>
    <xmx:3R48agDgO4zC2t4EvBbK4GlL1wf3qPToTP3BQes6l5ENqSjxCKml5w>
    <xmx:3R48avFGinj9lR3px284cNx_Yr6d057KY_E23dWZV3wk8WZx5bd6cw>
    <xmx:3R48aoDzbma9oh453UHVrd5I2mghhaduDCbiZOm1rNvmnYFJY1AA2A>
    <xmx:3R48agoc1gz1vtzbQRcXsFvkUjqbJ5d0fVElQxYaYii827hNYnTg8CEr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 14:15:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: a3205153416@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  kumarayushjha123@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net
Subject: Re: [GSoC Patch v8 1/3] path: extract format_path() and use in
 rev-parse
In-Reply-To: <20260624033748.108281-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 24 Jun 2026 09:07:46 +0530")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
	<20260624033748.108281-2-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 24 Jun 2026 11:15:55 -0700
Message-ID: <xmqqy0g3iz38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +void format_path(struct strbuf *dest, const char *path,
> +		 const char *prefix, enum path_format format)
> +{
> +	strbuf_reset(dest);
> +
> +	switch (format) {
> +	case PATH_FORMAT_UNMODIFIED:
> +		strbuf_addstr(dest, path);
> +		break;
> +
> +	case PATH_FORMAT_RELATIVE: {
> ...
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_RELATIVE_IF_SHARED: {
> ...
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_CANONICAL:
> +		/*
> +		 * strbuf_realpath_forgiving inherently resets the destination
> +		 * buffer, safely aligning with our replace semantics.
> +		 */
> +		strbuf_realpath_forgiving(dest, path, 1);
> +		break;
> +
> +	default:
> +		BUG("unknown path_format value %d", format);
> +	}
> +}

Hmph.

I was hoping that we could lose even more strbuf, but since
relative_path() does not always leave its result in the strbuf that
is passed to it as its third parameter, we do need addstr() into
dest, which is a bit unsatisfying but not a fault of this patch at
all.  At least, we lost extra copy in the canonical codepath ;-)

Looking good.  Thanks.
