Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F083E0C57
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537535; cv=none; b=CAtEyg5IWcSgqu1d1PtGO2FsQSfQCf5X3q0zdxijver1BAIk/mRYgC689lqs39PqnQ5KI8iVXXessl0O03jOwuZX2iTHtW6CeEh/MtPe9CU2h1ibPavu3oKmr360q4ZgB/r9e0+z2heekhHnmQ0XNiWOmtbCrGVebxcSG19o+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537535; c=relaxed/simple;
	bh=GbB4xuIl7/Ba+74uiwnezj77rwkeESMuiva2pC5Akxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipyoA6aaC7qsqWGDmG2ueb8ar/edKse94mckpvKl2TKNP3B9/57kIerSxD7kEUClhMwx39Q8R6wcfM+ixLUhZGREGJCWuPvZ0G5nb+t9QTcZIEGQbZ1OeD7uE16EiWrlxl6j/OYTUZLScoJrN5aqwjsY8e+eCqgyfhSRvgGXngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=olfnDZgv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s49DRz7f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="olfnDZgv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s49DRz7f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D8864EC001F;
	Sun, 27 Sep 2026 15:32:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 27 Sep 2026 15:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790537532; x=1790623932; bh=Z2u5Tobi1q
	9yMNRGR8Q+17LEDAwy0WwOph3zhr6VqtI=; b=olfnDZgvqZF/rvWTYjKLHJl/4Y
	+ZryMmf05fcxuPjPePvjCn8fxeotKii+UlEAEbE5Pa0hquRSJS2RWRXyUEaE0kyz
	NqwSmVJoncuMjRa7bBdmi3XPklDslgnW0zl7/C6r5fWoZkX7tX/NKf33vmRFVhsb
	Z1+QobocmJtYapeqd8q3e+yYRAtRl7uB+/LXcVS9PtoDGtn3rlnk2b/PVmFEU/cR
	5fvOIBeSntu6XAvid+asHHgHHBgxvFiDrmBo5UsL8vwvaheONdCCOz2rNY2cNFlZ
	ozKJq63/hs8j2TNnWP6FU3AuxlTv/Hhdt5s0JaLaQe4EZqhi41q8QZVrtyng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790537532; x=1790623932; bh=Z2u5Tobi1q9yMNRGR8Q+17LEDAwy0WwOph3
	zhr6VqtI=; b=s49DRz7fMTn1EtPNUpGQ04jLulSASiOwMk893eFdR7ti+JvdVJ2
	VCvYV6PXN+//eqmT7Q1HBo6z4+L558/XZcNEP1KTAhaFujkvw6NL7DRxL7EwBVPw
	8elszwk5y1vXc6I1S3qGzz34ZZ1c4IZi7nD25mjZYSBP+McTpv7EtT11xvR3pkZi
	zT+uy5r1xh9W5E9PaOz6MUSWtH9fEqAt1ANMZLsMQyZFrxw/thFy97LuQfqKZcOu
	yhCvTySUrMmam9Sx6PSBeXx0TD1MufwijRtxOe2c3/4gOrTx7BcspVDJLPyjaAss
	C5LH3Ps3DsUZQAijMEfM66v+pqORVxEp7pA==
X-ME-Sender: <xms:PG-5anzh3EzhOBV2nnwkBXlyHGqVvuobpvvYER0jGxz5aPe4vj8RJw>
    <xme:PG-5ah1KpcUyRDzY154oewq_quKoLFuHdOtW1De6jG2b6-4kZrDfxvWbDRcQgY3R0
    yWuQ1ove0enNdWTgast0POr1wGIjmQAvsdgvwsCVTdEQrURlq3i>
X-ME-Received: <xmr:PG-5ak9x0Kdk_oKvQhWH5vx-Ah9ZKxRhTBpwXmuR1ID5sPpgoXha9NJgT5FmHr581u7sF4vtWPQdqU9VOCUCCNLae90U2dS2_0dP>
X-ME-Proxy-Cause: dmFkZTFxz6XKZyUK1TDxe2sgH/3/zoU+9deTO8jyW1oD0NiqGg7v4gmKZi/5eL43AeVDdE
    FrqZzOeyAwlp9hJaODeJc+FGO5aLE8IS9UcmiRHOOirQXCshwyQgtR7zCw/F/gy6zDWM9N
    lKAOQu3HBhBDCQw/zErd2MdwieBn1v3Z3886MUybcqhDFqkUZobW9Vbwwa+cKEVQATNJHL
    3RLDPEWoew0DiZdpksZu+uzoaJRBcWtmeRLVIzXGyRrdjmFTjcqwr/c51A0+Jv7OhjLmU9
    NNYym0dDEFJqBrdCTzOemTqQh4wZNWUqvTORVXKxnpvYYYYHIzBqyRI6Y6jAp9refhqFpz
    0neAhI7rOLDzdxbxo5va/wcK7OWsT7co1exjkk9/LyFTHyJITRJVLmUU9XOjnwOsOCw+Lu
    mEX5eEPQTjCpRj/R3snpft7mF7aACF+Ub6aDZQY8e2dKy+a7kkut/UasDcVoM9HHJynQa+
    sFB6ZNHhYKOQLnonr41vOIF2RHQfcPMf2l+AHaoAy4Vcs1+QJpPi0/Oq8wrmzJg6ZNYnBd
    p0LwKG+3tJOH92IQKXkTEXTNS1QAB2SNnKZyTnOK8xfBgWIEWkYnGJ2DYMn21GdZdVCGYI
    i/X6Yl9kSFXVF3Pho9vscw2ffijKkiutUPYLShuKqHEGf5Loj7Z+1AN1Vzjg
X-ME-Proxy: <xmx:PG-5ahru7b27pCR2SYpK2RNKIkFwQpywfefRio2Nq5wbMf_eMcFoDQ>
    <xmx:PG-5auTssS_X0mjsld6pzUTHtpw0Z90-6xXnCw6prQOBVGRWmbhuLA>
    <xmx:PG-5akNraFWxV8gnzdXT5xsK6noxMhtl561OxAme0wKpqzAJtOA0nQ>
    <xmx:PG-5asjZnvJ4TELWck_AzJZZOK9M0Py5bhjZMYx86B5hDiHeYqChOA>
    <xmx:PG-5apUjblKFuopBGWgs1m80ijpievZdPJ-SeRlVjnlZI1LK0zq2Fheb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 15:32:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  sandals@crustytoothpaste.net,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Emily Shaffer
 <emilyshaffer@google.com>,  Jeff King <peff@peff.net>
Subject: Re: Changing default config values (was Re: What will come after
 Git 2.56?)
In-Reply-To: <7ccc822a-6bd0-44e2-8d6b-ca525d729207@gmail.com> (Phillip Wood's
	message of "Sun, 27 Sep 2026 14:48:31 +0100")
References: <ap50kgyenpRrsqln@pks.im>
	<20260924183523.53201-1-haraldnordgren@gmail.com>
	<xmqqpky21mh6.fsf@gitster.g>
	<7ccc822a-6bd0-44e2-8d6b-ca525d729207@gmail.com>
Date: Sun, 27 Sep 2026 12:32:10 -0700
Message-ID: <xmqqfqyuqymd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> A couple of thoughts about changing the default values for config variables:
>
> For ui related config values such as diff.algorithm, diff.colorWords, 
> commit.verbose, merge.conflictStyle etc. where their effect is largely 
> cosmetic and the potential negative impact of the value changing is 
> limited, I wonder if we should be more willing to take a 
> consequentialist approach and allow changes where the net benefit 
> outweighs any potential downside.

I think we are already doing that (We've already changed the default
merge strategy at least twice, for example), but the thing is, "net
benefit" and "potential downside" are both mere speculations until
you actually release such a change and wait for months to see
distros deliver the change to their users.

> One way we could change the default values of a set of config variables 
> is to have a config variable, say "core.defaults", that determines the 
> default values of the config variables we'd like to change.

You'd need a way to poll the value of core.defaults to see the
population distribution to see how beneficial the proposed update
is, but then wouldn't it be easier to measure on the target
configuration itself?  How big a population cares enough to bother
setting diff.algorithm to value X?  Multiply it by 3 and you may get
a rough approximation of how much of your entire population would
love to live in a hypothetical world where algorithm X were the
default.
