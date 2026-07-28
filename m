Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D0233936
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200436; cv=none; b=BIIyRI6NIrmEsbtIq1Lk+cbZ61Ptj6pLcDoF0CIDCEPm8sYDgaTemJjIusAyU1NARtUNt+GRYaaEpg0eY6USs34lk8SPDSjf2ztFiGrzSAdB9tcOtT4Ji09EOZrYsoQyWOJHTUemYW49BaCKOAYwsJuNJqdJbBCkYzEax3uvilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200436; c=relaxed/simple;
	bh=Q7k2+qrqI9FjJ8tmdnc/bxXSd0VKdO0N7Bv8RwzgFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oviky7t12jhYI7An6pcSAmXEE5llDuKJNi4mkbE2uDMdmIuBqmipGmPRURiT3kuhZQeZuoJx0w0l6cQfxaGwJVeRt1MOxKFG1HNoI48VYYgOMLtS215cH4ZVsjudWTRDaw/rfpQA7yMZ2BxlOCBVGUfG38vdoikY4D2oCY8JLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=weAMQ1P5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htcPHR9l; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="weAMQ1P5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htcPHR9l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D241EC022F;
	Mon, 27 Jul 2026 21:00:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 21:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785200433; x=1785286833; bh=+PqSHTxVLq
	Kl4Yz1Vy2bgEG8FWLTTAl5VIcFN1/+oAA=; b=weAMQ1P5NQV2wY5FXfxcg9lrhT
	MmHaQlEuYeX+vxzx3KGfSt+TZts5ughHjUitbOoJ+d7GM8uoxo/2DeTkSeOF6VLa
	PnLEZJ6aGCgbWMbL6S3QnlfyalKtT1nqEXe/A2VBdTkwCNdt/gB2aAv4uXAaOIja
	T+BrNAjTjCLaFOcRwf/SFWnBicz9EFw7acYMsgT/advR5nE88c20EsSHjH5nRCk0
	pXdcQplL//qlmcFTVGAoQYda0Md3XjV3BoAc96ITCTW9gE7tLCF9AEFO8LSiPsgA
	TWgHlNaiuyplqLtERH0HkGlwSlHGSm9cYRGrGHC8RHC122/9Q778RB0x1yOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785200433; x=1785286833; bh=+PqSHTxVLqKl4Yz1Vy2bgEG8FWLTTAl5VIc
	FN1/+oAA=; b=htcPHR9lhz9RDZ9NgKZOgFWGRDvy/eWPTPCXtOxIWCykXo1iYKw
	6ghKQFvibqJx0V9cs5G4KkuEdiCH6UWkrD9/vf/LPShz6WPBVJjrfRFQGYpERiKF
	pPWAAkzP7Z/igqY21mXyilzYTMGfkgBFARM9h6wByRsXWYYGHcU/rDTmOoqwwuuX
	X/xUjS9O6YBjrfLYjtK8GATYlFYFe9kG8sTk291949RgsHZkNd2AffBmZy/AcjWN
	mVzQjBRPgfPB0gr3LjXTBttO2HxRhaIjK5n+NZcdExJ4SBh5qQ9xKURb2uC+Id5m
	1eRxw63NvXpe3Lw11hQ+rxb+ATEgq2R5zUQ==
X-ME-Sender: <xms:Mf9nagG43Cpnjgap08aRimqgVsPPBcbuw6xFi0o6wxVqx4Tuyeq4KQ>
    <xme:Mf9nagw2Cb6gmhH8Xm0VA3aqQnYysnXSch4p9E6mM3llofssl0JxyqOAioEe_6Q8H
    xg-dBzNUm6kyim1dmmw8dAZisjPSwvHCWxolhhmfPM2G52AGnTi2E0>
X-ME-Received: <xmr:Mf9nanjTCKAqb9ubBHVGUNF8qiWitLvHEIO8AI33tGwfdH68XqG9Fn1P9R2AGCxgtW8eCA1cEtweuh-ff6qWKB7KMArGIiZIAA>
X-ME-Proxy-Cause: dmFkZTF7bloQaxG2rEVWoIrBvv2vKzau8BbPJ7r8im/I4MLH96BNTyzPeAJNVw+Pmfi5MQ
    5Ef15dUsCmoCpokfPI9uoUN+mU0qFputuYJJ9vaFS+0S9W5t3sZKLpiCEk9svFQIjmazNE
    rCwwOYLxrAAvvB3202+LlLvYf9dfp0fk3jgdJwdGcLoPoDB5lstTcql0j0d0ei1A2AYO81
    J4HxgnAOCGhYIeXp1aIyvzDHnB1FiGJ6DGjKSgAuX28P2Dc7q17PHxijDKT1GU7AGvyLKh
    TnMhktnmpbgWuPjx25V+aHAQ8I95pxZ0mGzafyorpHVuitsq9N3wPopwxWaIN1m0OF/MVQ
    y3V0oAdufqj051HZXe0AdCq/Jc6OP4KxVo9uglXh6t7li1UxfEGJcuryfZYkneeU2lOu1H
    rTUIY8E72c+LVZZWdC45lpgEppXtBJnZKnKF6YapVjd3Z5E5FrVqya6FhLvEMyRUKRI40T
    s2H3A8VcmphHZpCngvgQCwqj3kQLDq0mt7bwv7uRUDEV48bH0JgIgSPY/IpM7Qs58Hg5/0
    E9p8H7YkQV5/dLyMLyg6ion54XMhE9q40QUpeBm0hanUOEq3rTSgOC406rEUxukrG+vVXN
    vqrwONZxzV6IjeYQ1rb2sE0uwQL7wPk4p3TUB+aKnNjU616Dzst1SFLgpmyA
X-ME-Proxy: <xmx:Mf9narxdKv3-_OLuMwmvZ9R2WYU-K6TGVpqWF_Rgs5SWHVE0jU1W1g>
    <xmx:Mf9naqJM8rb0iq3TKnWLl3OqZsBY7waaKKy1pNwcvgUERNIppsBCTw>
    <xmx:Mf9naiSu7cEDTc0_X3sEavjKN_ILoyQWinxXiB0Ch4TJptUmTJJFdQ>
    <xmx:Mf9naiqHqkuhT0VcW40ZlOYz_27P75eSXB65927zyKRIacMy7QLPPA>
    <xmx:Mf9namf7N0Th9FHbN-a-YMkZEVBYPZEe_Lf-pFnXXnZkhc-ami_4Jtcg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 21:00:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Failing tests with WITH_BREAKING_CHANGES
In-Reply-To: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 28 Jul 2026 00:46:33 +0000")
References: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
Date: Mon, 27 Jul 2026 18:00:32 -0700
Message-ID: <xmqqwlugexn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I have the following in `config.mak`:
>
> ----
> DEVELOPER=1
> CC=clang
> GENERATE_COMPILATION_DATABASE=yes
> WITH_RUST=1
> USE_ASCIIDOCTOR=1
> WITH_BREAKING_CHANGES=1
> ----
>
> In this configuration, I've noticed some tests failing:
>
> ----
> t0014-alias.sh                                   (Wstat: 256 (exited 1) Tests: 23 Failed: 2)
>   Failed tests:  4, 8
>   Non-zero exit status: 1
> t1517-outside-repo.sh                            (Wstat: 256 (exited 1) Tests: 404 Failed: 2)
>   Failed tests:  248-249
>   Non-zero exit status: 1
> ----
>
> These don't occur if I remove `WITH_BREAKING_CHANGES=1`, so they appear
> to be related to that option.  However, I know we have a CI job for that
> case, so it's unclear to me why these tests are failing; perhaps the CI
> job is not testing what we think it's testing.

Does not immediately ring a bell for me.  All four integration
branches are OK in my builds.

> I noticed this because I plan to send out a series soon based on that
> option and obviously I want to run the testsuite first.
