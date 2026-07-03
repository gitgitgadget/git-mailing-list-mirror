Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B5352C52
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111002; cv=none; b=VkxL0KQXagCOpUfxG4Ir0EKYq0Vnz4NicvOykYoeCtCtjA43kntOTmukQKBW/ERPEMpp1IE25zqKAoS4+MGfqJIHgWG5Od4lmiR0xvVr2iO739lt7XOYTFrStLmiosPmL+MV8slOJkMTXRqBXFjbjP1IdjeuQjRw6oBEpkVRJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111002; c=relaxed/simple;
	bh=3Elcndvklty+7YuNZAhkxeFzGyDCzgO0Ut9SXuTF98s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CY687w6j668bnwDNhm8KX2KVzdoEVQND1juBuF2gHPZHmU+7dtfHkD4ufpSeQtlRHTYmt7Sqm5uBCEZBRv/DSc5Zl5+ix56Ai2UG1X4FYukeKMzaJzPtK8vA9ZJ4OlfW0eGw57+LE4HM1yOZ8ReP+6QC0Rq9TZXjiRYwAh7MSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXIdnOlk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agjjVQ8j; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXIdnOlk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agjjVQ8j"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 398D21D0001D;
	Fri,  3 Jul 2026 16:36:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 16:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783110999; x=1783197399; bh=m4Gq5RHpFV
	EVKY97dY4G/wfxARHnFVf4D2sd/34VUSY=; b=iXIdnOlkar1z4f7UrNm7rFOVYS
	6JzkujB6OQSzd9BdP+aVow9dfFvXzepfYMnLlav+ZyFTxiVlQ6aucDbfWeWKg3q4
	LL+tQ/liGimhxXGcqomTtA+PRB4EsJ1aod6oqhw2fSaJsdme9mJQYCyDMcW/bIYL
	PQjBLyauAx2pRon+yLKF7LRJ0WhVRb06wD85FVP/Wua98DQuxkldM2NY03v3U+Xe
	uBDSzeA8C4DYEBLRx3u2Pvd0oMw6jmiMumZ4jzHwEZUIhQlwo7HatMZCLylkbsVA
	UUVEZHjg7njBqb3VjBTHmt5dfQ1/MqYAQH37RMFp8+DCIAcekx8nDXHDInYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783110999; x=1783197399; bh=m4Gq5RHpFVEVKY97dY4G/wfxARHnFVf4D2s
	d/34VUSY=; b=agjjVQ8jkKm4S3M2hkXe8Vw3CpLgCRM5tOwuilaVgdSM716+DJ4
	mnpl2tGvL4KrXo6F6TFuIoxWoVEaUtMrj42sN/RNUShi2oDe45U+AyBgK9IKD+jk
	UNVoK806WQ4Qy0SO4sI1umXNi/lXXMSEWj1ubvvEQVBh/HARBR5ZLDjq57SODbZn
	CkCWfFACbjWezhmBa+yLIDHuTWAcw/7vkUGnvAvvlif+hgwTInqfD+Yhvae+JI5i
	KNKOXqy7tkexjfKHpeKqyygJw312Nb03UCzthlvAIzDKdlYX5LoboXrmBJ62d9DE
	/B0mTaMk8MfM8WA7t3I5zD5p7y+Jn3OBEQQ==
X-ME-Sender: <xms:Vh1IaiHV4b-TaMaal8o7jUIuvLLP4HvlczRfJBvn6fqX10BiolL7dQ>
    <xme:Vh1IaqUlPhQ5h4ampq2mSmck7P08z8_hmJq-xE9iVPpaymimu5xwE0LSDnerupADj
    G_Wtqnf6-Pu2WWlIINLGTZWL1fkJldITwsBZ5Vzv8wsHqDcet2UonI>
X-ME-Received: <xmr:Vh1IahJTTqyzlBsN2kqVpNcMPopS-s_NKv_Id-MzL8oIFgDirrQMksuZNtfYDuF-5BJJLfXzHtj8YgF1Fa7ptMnTu-3KgreGEdvgF3E>
X-ME-Proxy-Cause: dmFkZTGJKxXHP9aRnahfrF65MP+sB6Td5iLTyTMmfSx1Pb8ytd5CrQmr1iWrS8RREGrP2X
    z4R6sr2vU1abfpA3KI1+zaHkI+8oziOELR6ig1iRnhXJIagkWnyuJDS5Jic5AWTdfWb4AE
    b0m+rUBNMtolmYOr7dmzgoGhT9brwdK/xHpOwO9VQBlaa0qPhIG3mF1P1m3sIfxYoXg11k
    wJ2G57naQ4SeA2t4vhnHVPH98jnbpoz1dJHEG1r8gOhsJJ/VM1MdMT6TYojJWl68wG+Qe0
    9O0tGp1nbg0vCeUD/geDR5xxd9/d/i8kTmHDOQyD4RzIXEY+5KoZNLIQPizEdlul+Ma2dd
    +0RjHAS68g4nwcIaxmJ0JDx50h+TAs0qB7tdwgSxhgMJEN6g/fbpC3EovlValBchgNzBg8
    /lKfQE5b7RiIzlZvUDKqkOd4qMjiAjz0WKN57QlU6PODaihYqybz+g/B8I5zVfhqZS9nPx
    k/fyKrOC/b2P6FD9E0ha56cBjQV6TFSZxC6B+l0FmuQ7v/tXICocSB9cYhFJp9ucJQl8HE
    qJDrGdtaG+GAWyzkZy1WXwwfN6IX++qOGuDw00rylN4Sl7Yb46sPEBxJ2YoJfIsbFchESR
    wk5tStJxKYOXYtaUrm6uJB+6Yj550xHJ1YBUZvMj1GiWLrUeWqzPac4tp1Aw
X-ME-Proxy: <xmx:Vh1Iaq-Ys8WnWP0YkB3o1apwyBuXQB-g-5ZOQO30IfuUjm-4iJLjxw>
    <xmx:Vh1IakJyOrkZxsk4zvXS-IcaLgba88w9H3ml4Xd7IKtaaRiS1h0i_Q>
    <xmx:Vh1Iavk_-D9qqCHEqyqHSVBQiSKz7t4-s0KlaUlqMg00rurYr_bpuQ>
    <xmx:Vh1IaoMGpLWDRqJXYpMIA6p-kkEP1QBxw2Vx1m5tN5C5xQER3qZAtA>
    <xmx:Vx1IajIdqUmmWpK82W3R7ga1D5LgA7JqB0h4eaejlrHV2-_UX_mZi_w8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:36:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
In-Reply-To: <20260702053724.GA3437623@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jul 2026 01:37:24 -0400")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-2-sandals@crustytoothpaste.net>
	<20260702053724.GA3437623@coredump.intra.peff.net>
Date: Fri, 03 Jul 2026 13:36:37 -0700
Message-ID: <xmqq33xzize2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> fed to perl (no quotes around 1.1.0). We sometimes catch these cases
> automatically it results in an extra argument to test_expect_success,
> etc. But here you are unlucky enough that it does not (and anyway, we do
> not seem to have the same safety check for test_lazy_prereq; we'd just
> ignore the extra arguments).
>
> And of course being perl, it doesn't complain. I'm not sure how it is
> interpreted,

I happen to know ;-).

When you have more than two sequences of digits separated by dot,
like IP address 192.168.1.1, you are telling Perl to interpret the
sequence as a string, each byte of it is the number denoted by these
digits.  I believe this was invented primarily for IP addresses, but
it does not have to be just four digits.  To wit:

    $ perl -e 'print 65.66.67;'
    ABC
    $ perl -e 'print 65.66.67.68.69;'
    ABCDE

Of course, 65.66 is not AB, but a floating-point number that is
between integers 65 and 66:

    $ perl -e 'print 65.66;'
    65.66

> but I doubt the use of "gt" is right.

True.
