Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C645369981
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386140; cv=none; b=J+x4xt76d5wSH48FL2t8qLDCTplmllVbZGz7rdHbUntSy2crFzzVwvmCnYcC0JRL132+5OEfoSAC5fZVxh9996+v0hzl0x0w2LfQLZ8rmWrewdIQazWProGaqPQMr2Ml6k1jP0cG+6biwmAY9m0VpCgqJQ+ViM54InIG2SgbKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386140; c=relaxed/simple;
	bh=MjCLCAFpHytZ6hzysdw2vVszHebWxgw1EWqFxQzNNrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A0S2hEYA1n2LOnR59j6B1pSGTbCuYNMFe1Tg8LF4uYV0PLl8qTlzQmrGiUp8BWQXaq1jSQBvGBr0ofZR8XZpPwNXq1I4rvei7Cyp5tIaD0u3Qy5ZYvtAkU7cBIsTni8o5km+E0ISs/U/SK2xJQifhx+uJ6f6Tq6ESvijIrZYKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QjA3nIpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBDGn/B5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QjA3nIpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBDGn/B5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31B4F140014F;
	Tue,  2 Jun 2026 03:42:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 03:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780386137; x=1780472537; bh=m6PVFkOb7c
	r9htso/g2hnqpZeXUDhDGOHHrhLd4g03s=; b=QjA3nIpm0rKWZXkE9kJDSNhAUr
	DjvLGWzOyn5JnbX0Qm6LtyRBKtk6h0ieaoA3IVUK9kPLeuSjtRXXnb6/qRrUbhLd
	q3BRDQ7imregDwwkgK6N5KLHdkgM9WGt+t/a3yXr7cz2jl5oSsrGFbfHQlbKwET2
	XAJq6dGtt9q4Xz9JiqWmSXP8hFtYw3Yy48mVEkrO/7MCFqunEGZBpa9Dl0Wb0JOB
	geRpL5XK+lkTr94k04RRxLxIkxpiRjRp1Yj9C6Eb99qN6sR2GEShzouGA+gVg/Zc
	xXFtXMa34faDvOSZVioWHieSVZ1ObWmweW3v3oKfAXA/q5raQhyxH1V+Rbug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780386137; x=1780472537; bh=m6PVFkOb7cr9htso/g2hnqpZeXUDhDGOHHr
	hLd4g03s=; b=aBDGn/B5JxSWMI+VRnc+OwmV3XdDNg0r9UIV8qAqUX3NZS+1m/0
	k7doRWzcBJgC4gg3Po9xvG7//4c8TeZO0+vmRq3z4DbwVC0LhWOnVe/Pz7jQESM+
	BrBRjiri+nitjK9hHBAZkxKuvNx60vmqhy/NpBagjzbbi1eUB79rHZDBjxQuAT2j
	IgXLnN9F0AKhBkndWHh/oOqOiMgQ8zFm8s984tnzG6N81wJ5eORKVkx1nNY48Zkx
	PcuhjyWn8Jm5d1EqNTttgM+wDdsxcaRwfcDIfV/v2fJmF+aDJg5pcdGNvWNf0usN
	VW3DqYlmrkRyUEA098c8Y2/Xljs5Jizn1Uw==
X-ME-Sender: <xms:WYkeajOqwXa-PkI8nRG9MaF9XxsDKT9Jnr8H3JJE-X7dpkikJ79vNg>
    <xme:WYkeak8KkhORjy4qE-J0pa10NsjslD3g8Kl0MpPTIjGuGK6MCN7VmbKfirNJGRMXg
    Fgob-l5BWgzmFVpGGr9Ha9RgyEedPEEchoMr8QEFVTLgIC_duJTLA>
X-ME-Received: <xmr:WYkeanRrL_sMT843jtBTza19FoGf8vz01u-Eh37tQfBvAXUCQ2hdzemlSC_nU19pIKR8CjrCKVsYAP5aHRAODX_JUZGqnwGPDd0->
X-ME-Proxy-Cause: dmFkZTFg0Wou2h5eAgjORepHtGTu0eOAqsKGv0KxyNYIjJ4vO7f45iM7ID+XNqsasxqtRq
    dQEvW73omD8S3QF9sM/t5x2fsE90kNzgP3lDoPD1qeSzrZJRD3/V91JSWLzZfs12arM/OM
    qQX7g5XCSo0qtBiHTXG7zF1/4/zjL3g+qTlNFhoX/6A2lbVsmMFdTpb8/cb7yX90h66wQJ
    naCyPME2LyDR4dCBKhlmzGNP8YB0sSQuSXQQwcrcuTB8fyQI/5d+WdBRfAuiPunEqJdmjz
    hSF8y3Unjl44gMzhRMWHqUZvJRl4BDUSAyz538fDM2kyb9mVCBoPaMbZrauv0VIE4b9Lnv
    hki93GMLvwSjf5j8O8SOMhApDUGY3FhFpFNRgAAD07+IV7g0FPl+9kJkfZAnYPPbdRqMPM
    CSRHBNmQVYO1OT21uO16KX+m207j62iLEwZhXtKCSX9vhuIsoQ9tL3UbyJywios2Oye5HT
    h/rAwe5tCq5P4Nbh72gjtwf6PdLiK+yCvvQQOEqRsLWYlU5jyGoSSotp98lFJu3ZcVGAs+
    2GYczVe+b1eMESVceEFIKC146K6Kr99IAKVp0yJTD3DO7CVz5dNZE27RCXt6+2735opUqN
    J374q4HHyjPtHG/MYCIm9EWXS15QwLie5UgpyW2Wfh/U16tJdQ36Vr/2g5wA
X-ME-Proxy: <xmx:WYkeamkGyw1GJFdjhAP7-TJSl4_UY6bizb6Cyerxi_NNxsbZ9VsnjA>
    <xmx:WYkeanRGQeuCAUVZMI9_BQo1JZSH0VDDA54vQ_H6l7iyezDbeh7zxw>
    <xmx:WYkeakOFnalJFYDef3UBZyghF_KZJwNEQUmfc8j5zj237BShKwhIWQ>
    <xmx:WYkeagUDeznYKLMkZ2giCm4cs07eVlhOdE1g02CknOQlH35KLw9dUg>
    <xmx:WYkeasSL6Fze9fvAksIwjAgcCDWUDHA5WHKdctOHN36VFZ7hbuOo0xdm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 03:42:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
In-Reply-To: <20260602061159.GA693928@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Jun 2026 02:11:59 -0400")
References: <20260602061159.GA693928@coredump.intra.peff.net>
Date: Tue, 02 Jun 2026 16:42:15 +0900
Message-ID: <xmqq4ijlz8vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I've tried to make the minimally-invasive fix here:
>
>   1. We only copy the string when we hit READ_GITFILE_ERR_NOT_A_REPO,
>      so other error codes don't have to worry about freeing it.
>
>   2. We'll turn read_gitfile_gently() into a wrapper which passes NULL
>      by default, leaving other callers unaffected.

Nice, probably.  I do not know what to feel about the first point,
though, as it burdens those who add new callers in the future more.

> The result is kind of gross. There's an extra layer of macro
> indirection, and the validity of the string is subtly tied to the
> NOT_A_REPO error. A cleaner solution might be an error struct that
> couples the code and the output string together, along with a function
> to free the error struct. But then all callers would have to be modified
> to call the free function. Alternatively, we could perhaps put a
> large-ish fixed-size buffer in the struct, though that means potential
> truncation and a larger stack footprint in each caller (even when they
> don't have see an error).

None of thoese are particularly appetizing ;-).

> So I've left that as possible work for the future, or maybe never. Some
> of this gross-ness was already there. For example, the only other caller
> of read_gitfile_error_die() is in submodule.c, and it also passes NULL
> for the "dir" parameter. But it does so only when the code is not
> NOT_A_REPO! So it is depending on the same subtle connection to avoid
> triggering the bug.

Yup.  I can agree with this.

> ---
> Two other points of interest.
>
> One, I'm not sure how useful printing the pointed-to directory is. We
> _could_ just say:
>
>   fatal: gitfile does not point to a valid repository: /path/to/.git
>
> which is enough for somebody to investigate themselves. That would
> certainly make the patch smaller.

Thanks.  While reading the main explanation, it was the first thing
that came to me.

The implementation and the test are as expected in patches from you
and matches the intent explained in the log message exactly.

Thanks, will queue.
