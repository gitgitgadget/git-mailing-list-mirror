Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A78380FFE
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847294; cv=none; b=I4STt4skLMpiJXw9uVX48jdz0k2/2laHgsogWcka0taA9P+LVU5wR9kZBK5HIj9tmJ3Cru8sZHJwmJBkaAVXEMgI7oH2VkyzjEro5SqH7wgFuYrFZdOmzPbZBXarezPwnmgtph7C2hRipMyI9O2Sm96aLiIcCd0UxT9UglAma0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847294; c=relaxed/simple;
	bh=3AkUcf8WgbaKDA6XlMV/SV4s7/0T7M1GTWE9J+wrxyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9tuMaVfJJlfe6DXgjyD2/9sl7srwQqc5p3pCLKO7x0qmvKNbv8b6cH1YYbx44UtnNx+6ZB2JFAAiw65/Xs0j2xENAAbIZ3oXkvlRTqCW/yaMZkFiQWnFod7MyAMDqfu1mlx2PTVvwF6ZcbRPQaCyYyHSOYUh3Q5fwuCHnVPc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=av7grIBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJUnCk2D; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="av7grIBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJUnCk2D"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 03479EC01A0;
	Tue, 30 Jun 2026 15:21:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 30 Jun 2026 15:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782847292; x=1782933692; bh=9RcE/EXFcY
	ZXB0jTCnOo/rhS3YCZYhSw5KWP5Lc37Ug=; b=av7grIBraLpoS+jbQcHX70OzGD
	6M7COUCgu/KHQFchxWPx0Q+1QbOYRgoSs3+DsM/tSzCbwidFBR/r1nchBGjznneq
	HTYR89b2nCd00vc+7xQEW4XbtVKonZA9kicb/SurxYl0twJdaROkwE6ZUHKg6DZo
	LcQMYZjE4gwIq5FvdDDw5Q10yta3/aH5GtnJqf/LcuSooKvtvV6NwYbv0xpyx/1u
	H/n1hpk9TLwN0fHkSI99hj/3VTbW/KWzAEduwYhanVjH2V1PmCsJi0jXwwf0AW33
	kDJNfVv1AiRIqOsftVw1jhj1aTzj+dlGvL+dVZrq3ZaAl0RYvA1huPujykbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782847292; x=1782933692; bh=9RcE/EXFcYZXB0jTCnOo/rhS3YCZYhSw5KW
	P5Lc37Ug=; b=XJUnCk2D3GVlzXmesugPPkrjLq0DltgVYg+fM12bo9gQdfkTyh7
	w03NTXXyoOXU6U4l/mlRRdekdkPSMQQbxysylMV8R4IN3st6V51JIQFPKDLC2Qj6
	0kEDAJhcyIDBRy9EYisOVDnfJq78tGzmcd2/tcNL+Tde1agyDk1HFiiic2tic5Pl
	5wfRYi0tvZnTrOBrOJQ1c6ytVy5t8YwtfwhKmnY/wUGXJ9aCsCA877x9GHNAPwaN
	ebGMe9H2iw+EeyX+fXVQaU8VUNOSUKceQxbz48O/VSxF/Uz/SC21Pqga1uYtTP7Z
	UStj2nz2yj679j+S526mT0T0IwjOTa9HtTQ==
X-ME-Sender: <xms:OxdEalWNBbzqAx-0RhW6hJnGuK2W4lakvG6MrCBv2Jofkh0vnISnFQ>
    <xme:OxdEasdx4CZemOX70nJRaEWV8kTYgI2ChX03dEun-hYeOW38-hud6BVkVuL-rPuPG
    BEw7EKkFXL8YXIFkCZHedbOdCYnr4jNr4WIBwNGKF-c1fyfDnhVMg>
X-ME-Received: <xmr:OxdEapvOT0zKXO-rU3P1kjm2a6pZjG9K5r7LHpH31prWCoFKOHNiQ0j3vZv7zVxxXEIqHTRY-aLW8AlDPZ5Fe36Mchh-4wYYc7D1y4U>
X-ME-Proxy-Cause: dmFkZTFrspFAZ+JXgKna6d8altJguWr2fHYjBmDP/fib3apYZDYXCcR31aLFzVW4026O7q
    hRJAGFVcZbdGzJU1+L00Fzlw02yur5g/U08kaIHT6bKxy5ta/IvvBaKfCIee7OD3ODJybs
    x6pFexQXtSbKEIrD8JoN7NHuHZNRBgmzprhj6yT7TJiSdwzh6phM8P/4zczhy3ElMkT4Le
    QVGN9V2hknSVrInj9aGwxD0S+8dvgZT/qNEffT1E62mSl9KYmDvsiMwNXPYKXX1/v0PGV0
    IKiDCbH3BVU5v/YJ9ye3kGImiYW+2GBX1p/Rj08Z/hkNPtEoxC+ZJpGHip57BYDRlMQ/X/
    B55cTphj6BfC5HET+WVTcTziq1D4zDUrh+M5JHQgOlYrgmYiXMjPPcBoFo6O3A3w+kU1hC
    FG9z32lq5ptyA5NbsbG0zdNBjbkKAFMKCvpYnbGUeN53WM823cpI8wkA+WoXhqPZqP3TfC
    jQWkD/4oRdrGlMBNVovR1joZowEGtIWOhVDKj7CmbYivlVeUjfsxa0li+zk5/T9L4wueDE
    Ypo5ubfoUUX4iREud90eymf6750/xVZJVp0RW19dmkafuK2IZCI4Ai6GMGbGHCYbptyzEu
    KV2S5J1spqJPcH609hYz0ol60tgPNq1yICvhMnJIsOqdqAQff6iL2S/2CpXA
X-ME-Proxy: <xmx:OxdEaj9kH5g0HFF55tjSXkCk66jdJmNKmqlN7xsii_xZQ4Cd-v38Jg>
    <xmx:OxdEas0FmDqziD6WOcONCZHL70s-pPqWr9VVdrTcSubYNZ6QTJtcmA>
    <xmx:OxdEagAA6aqZjwu6o3zXv0oApUORm8wErX00H8bOcKBp7OCssLPh_A>
    <xmx:OxdEagdIbnFNqjPesT-yIkce4RZ6iu6lr-9V6giFizadcxhHW_yrZw>
    <xmx:PBdEaudDW9xGXK14TFtu0M0DzaspYRcJICOn1QhDGEAuAlXApD5L_XqZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 15:21:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Michael Montalbo <mmontalbo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
In-Reply-To: <akOGzAq8Is7ghgIM@pks.im> (Patrick Steinhardt's message of "Tue,
	30 Jun 2026 11:05:16 +0200")
References: <ajkOoRhqaAcy6gBg@pks.im>
	<CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
	<20260626051657.GB3138423@coredump.intra.peff.net>
	<aj5ZaZK7xylfs4Xw@pks.im>
	<CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
	<20260628075716.GA3525066@coredump.intra.peff.net>
	<akIfsaVMB_S6kfJQ@pks.im> <xmqqldbxz9z4.fsf@gitster.g>
	<akKYv3nqX0BXcavu@pks.im> <xmqqik71xqtc.fsf@gitster.g>
	<akOGzAq8Is7ghgIM@pks.im>
Date: Tue, 30 Jun 2026 12:21:30 -0700
Message-ID: <xmqq8q7vsukl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The pipelines of the official mirror can be found at [1]. We might for
> example add something like the below patch to our README.md to make it
> more discoverable.
>
> Patrick
>
> [1]: https://gitlab.com/git-scm/git/-/pipelines
>
> diff --git a/README.md b/README.md
> index d87bca1b8c..9ad77fdf7e 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,4 +1,5 @@
> -[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
> +[![GitHub build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
> +[![GitLab build status](https://gitlab.com/git-scm/git/badges/master/pipeline.svg)](https://gitlab.com/git-scm/git/-/pipelines?ref=master)
>  
>  Git - fast, scalable, distributed revision control system
>  =========================================================

Oh, nice.  We of course do not want to be heavily involved in
advertising offerings by commercial entities but I think these two
sites deserve one line each for their continued service to the
community ;-)
