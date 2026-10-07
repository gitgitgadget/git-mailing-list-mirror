Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9723C8705
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408766; cv=none; b=GrPSK8dgOSGK4zX4ROgFDHnRYceDNI8m2JofWB8kGm6BfRDLihBV8/KfVp/Jf3A6UpfN0gf94d0IeTwu66MsbVZvowMKsFMaOmRGoIjVnstevGnjxbP1Nm6QrAWXmLQ7rvYK2cXmVoSs86oGWrL4gM95sqRzYz5PYLelb+HSa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408766; c=relaxed/simple;
	bh=SWwdc4eTg2LdyFX3jHmFPZwJTrDv3j/geKbmTrZjbko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2u2uTEirdUIHuT07hUdD6g24gRd38t1W19P0W6iIWYMjxIP+lmNj2Z96DwuOuOMjvgQzs25AkAf6mefb9VCGy7NBXxbE1mFb/j+dvS+Dn+uS0ZNrj/djggBDlBYvKU8ekBUNjT3jo2LQMNiYUz+xVmv+h+9BQSYqBZS0aAiVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TVY7Bz2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORwKxpsW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TVY7Bz2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORwKxpsW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B01327A013A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:32:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 07 Oct 2026 17:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791408764; x=1791495164; bh=j19AkidUZ9
	HO1qoV5+JvUQQ5Zpwrat8+wRcCAofGCnI=; b=TVY7Bz2pj3kCivCytEpGDIej4Q
	ROXAnArRoLzlfwqTJdH/NYIceOdWZlJyPHGglZkQREN0BQDujXpu76/YOk4mXu5u
	L8G0bJvXwGLkmjmj97PV7Ujc42q+vCRrYteI9AA6LFlSG5XZYl4asIIbGf16Yj5N
	pORgL8pVE6ZKuoWrx73S/DlbCFpakHrKIZzh81u1gjJgjdMGYUYo9ydB1kvL5F9z
	sR40O+SKI7Q3KbPGtYIanB8gASZbV/w/bZ6B9BWfHLo4qyDOSdt+yAYf4eK/VuLY
	3pPvhTLUBar7WDftyjIuKEd9oDIx368xA/EKeuP8Lpbpwa7dnfnBulWpHTeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791408764; x=1791495164; bh=j19AkidUZ9HO1qoV5+JvUQQ5Zpwrat8+wRc
	CAofGCnI=; b=ORwKxpsW9/pC1NAQqKfBUfVHweCi11NVFeMEi67hGr87QUGzIUx
	vesijDlSGStbHA1qLzbUgC5VvBGR8cBgiUH2mM7KAxfftYgGT/VmGZzE1esX51SI
	Mzzb0GsE9VK/eFfcJjDE4FHX5kGyX1ZWzh3Idv/QafYig3yBbzkK5jkeKAFlgDOj
	FQtqsIHeZQ7Ymucld4d1IFCikARNlqYPb+bEqOFfXjLx3G0BOKgCPcyPIBJzkdBz
	q9NjU98vBBb0BHY8j8exQykPP4ka799WWVAfKRGWMXG6qcV+BaqjyHVAh8wKczxb
	r6c4zHLY4Esl5rZ7jiLB6vZX/Hp8TFW7ilA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791408764; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NQ9RzHS0cv3TIGKZDbHJX900TfGeqg+lmZLiB2ivmPc2Au+
	ab1FYkflY9UERoNlHin/RaOo636IxE+PTqg22c1E1cHP8wUc4T+EUAH3IyEAPoNA
	lYcsEqJPdSQ0CmTf75fnfg/DVl85aMiNwxcCZ458DCb4s//hnqP4IrpgPyePSW4x
	EF42oF1PkYod3RjKQ2fCK5InwcO40pROp2TuJfM4zwqCk6RQGggTH/M3bkQ87JH9
	bZeSfYUPXTpintzKCLt/t7st5xHE1TwD3x1+GXjVSplYd4T901cmW6y3ff3STY89
	yu1RfjawlunLb/WtgHuMAuhYnThY3a8TSg+CZIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2ZiARkKGZav/D6UuokeaUKueROV6uOqNIHxOCaXuHsI=:SWwdc4eTg2LdyFX3jHmFPZwJTrDv3j/geKbmTrZjbko=;
X-ME-Sender: <xms:fLrGaqei3YMzIYHLPkZ8BUjrPT-__csMcD0vW6Xl2ipHoK5aaWx_xA>
    <xme:fLrGarMLo2wVs0QK_ncQ1nnrGTLgjXT7LIUl0B8WonsZj5xFaiSEQjCiOK-noGEfX
    W6ZatJyLbkS4cZZ9zpERT7JcTuurwyVfBSa44uTqDejkVo1A4CyO3U>
X-ME-Received: <xmr:fLrGagjb3C61StY7jmZQ2k4XA6wYb4iww9yH17aM3zyFgoXz2itER0fso9q9cYnJbz9kPPKLQS0ZDa6TJ6ZDJ3NyHlMWFJ0XFi_8>
X-ME-Proxy-Cause: dmFkZTGGZKcSCAYWU0jNafQKKscqGQuqbmD+6M4FHM9pUt9UbR8sLoY4B1G5+Ev5cXaOr8
    GJ99qiUlKHqCra+GcOu0qLqhwk+trBbGHp8rbGyzRNIVXPiqevtWVESeF/i7GKSV16OPUW
    r4GMA5aDlEwqJ5D6hLZw/X5NOKy9FvlOq07pSpMrzRXROWgGjXchny38yiazkVhBrSQAlD
    6MtQMp3InkA5+GeLYo+50x5Y1/o85ajBJ9QTGBzFtZxu2GGzMOEhWsJRrEWk8/sJpLhVW7
    L6xR7hC4ThrYyXjHGLu5YlIzwGAOQ3yNRv2ewUFdUFx5/D9HmpA4AN++IiLsM8LkMbDhSJ
    QZkHg46nEH01EVM4hBiwK/ODD88obGuKoEDjHgbCsAAfNVedwCvHFdVJ1vKS/TaxCLsnFr
    jFx95M+CfnScgsTcnFy8jQDqjbehgP90Uri1qHeRJrajKt3jGv/6gHdhtTqo/ExW4rt9Ab
    pq8YbSSqcapT8MaTOwZUhcFYse8RlUZaBXxNnG8qXBGxxs1nVrjrXi3XB0cek8l8KpKW7l
    Z+jzbMVfH0eP907Yk9UuFhNciUdaOCMDyndmJPCyzBpd6RtxAV6iqMrZw5oxrSqNJMQl7N
    W4JrqzJfUF3lLdzl15Ujcy+ijdXmzdRgJ0nVpzKLM5SMvj5vIuZZXYnDxY2Q
X-ME-Proxy: <xmx:fLrGam2AUhUSP4YPCOsSPIwmsjUFEgD-Jrfgy7Z6M9kx3jYDZJDbEw>
    <xmx:fLrGaijSP8vLR2tmaUDLaQv9U0eeFU7D5ZG0T40299gsTf0Sa7keEw>
    <xmx:fLrGaue4cpxpHX37yVs5_gF7Zj8MfoiohLWbtnVci1uY2-4YTi7DXg>
    <xmx:fLrGatlX1_3oFR_9sdkLy-3OZHTBsIerVf77WwbAjtJjcAgvJcP-1Q>
    <xmx:fLrGau1hDZb5mE0zfBkjCGY_y6NG9y3QQauHD4aVxsMDsd3Y4wql8rxK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 17:32:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Scott Chacon <scott@gitbutler.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] sha1dc-accel: vectorize the
 unavoidable-bitconditions check
In-Reply-To: <3d640489-5db4-5527-0ec1-c2abac7a2de3@gmx.de> (Johannes
	Schindelin's message of "Wed, 7 Oct 2026 14:17:41 +0200 (CEST)")
References: <20260929112544.86511-1-scott@gitbutler.net>
	<20260929112544.86511-3-scott@gitbutler.net>
	<3d640489-5db4-5527-0ec1-c2abac7a2de3@gmx.de>
Date: Wed, 07 Oct 2026 14:32:42 -0700
Message-ID: <xmqqh5ix5h8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This Perl script reproduces the tables (although with different
> formatting, and without the inline comments, I verified it with
> `--patience --color-words="[A-Za-z0-9_]+|."`).
> ...
> With all that out of the way, I would like to ask to include this script
> in the patch (or in a follow-up patch) so that the lengthy `ubc_check.c`
> file's tables can be validated/regenerated independently.
> ...
> While this code is correct, I think it is slightly misleading: depending
> on `want`, it either subtracts `set` from `dvs`, or takes the minimum. But
> that only happens to be what is desired because each lane of `set` is all
> ones or all zero. What we actually want is to mask either those lanes or
> everything but those lanes, i.e. `dvs & ~set` or `dvs & set`,
> respectively. That would be:
>
> 		fail = g->want ? vbicq_u32(dvs, set) : vandq_u32(dvs, set);
>
> This has no speed impact nor does it produce a "more correct" result, but
> it might improve readability a bit.
>
> I haven't looked very closely whether there are similar issues elsewhere
> (it is relatively tedious for me to learn all this NEON stuff on the go,
> this is all new to me). If you're familiar with NEON, it might be
> worthwhile looking for similarly "correct but misleading" statements.

Thanks for offering a very thoughtful help and offering to work well
together.
