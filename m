Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4A403E8B
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537254; cv=none; b=j59oAKqyWWgvz3mpleHufkrB8GEq1Min9UZIU0NOBuC0t8ohGtlY4E2F1F8sO39IPMctC5PvhmFChCi1E2DNpJK/apoOa11SYO8NJlECaI8yAPzaNgipizftBF6r9bk6STJTY6wEnw+oBzZGet2AMaELM23uPRZnIyKX2DR3dXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537254; c=relaxed/simple;
	bh=htZCU8gKO/nZbjlGy3GFSD7LOICSGUT2YMBJ2y3NVSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6d3T9RPwJfGKNUJpTiL1Hpooz0XmDq81EB7n7eUetha35imcfSPp3WRUfBj5Zj5T0QCheY3Ls1RUhxO05Y5cI9+frhLUSGmDnW2KH2DF7F7EpfjwQCa/qcWNIKvSeKkicakcMQWxzvS9XAFAAlhr9BUYQusYEdPrdyT97Ogmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DlMKV6T2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcWo6Edy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DlMKV6T2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcWo6Edy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18C9A1400073;
	Mon, 15 Jun 2026 11:27:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 15 Jun 2026 11:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781537252; x=1781623652; bh=htZCU8gKO/
	nZbjlGy3GFSD7LOICSGUT2YMBJ2y3NVSQ=; b=DlMKV6T2Y/umyyEpyX/PTer9kN
	mPjpV3NB9yY3BycIZMid9XCBewlfDxVmpuoBpDK/frO/PyKat+C3KQOhwUlyI5K7
	83+IkJKsWLReSCrfQUduf7Bi79YsAbIMIwoKbRUTP8I25z6dchhGQPteJhkhPWag
	2avO1VcH9v9dFVtEqtyH2UQx0lg9C0NrlI6LEMALA8PopRQmry0cwb/Nky53tDyJ
	EAiKhcMBuC/wVWf2MNfKveaVJ4/qKX7nyaqnee+qV599n+1xeIUW6l03EkWXFYxP
	Toho4mRscIMR/70BynO3T40ASwyX7AmZYKWO6GoJPhMJDoSbcKiIC76USaKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781537252; x=1781623652; bh=htZCU8gKO/nZbjlGy3GFSD7LOICSGUT2YMB
	J2y3NVSQ=; b=bcWo6EdyMqIqc1q7dj5uPaaaz245zPf8UDIFzkwz9OdKhvY6lCn
	M+iOHuYoYkwmyD+KPsS11HKK6Agfe6e++TVuwo5tpYjR8hhMmSrL6qYrofquUEkZ
	x1IWd4C+JbrBYnzfX5rqBPZ2S7CUHToBb7z63srbXXYUDxHharoR0QkqVI8TpDIB
	zhLQYjZ8mqumcrPgrWtannm73ba5MKfirgbjpxn6iQvjFvuVqTx0FejFCTNbUgzN
	BDaioaiCIncrlkrm4drCAlzYPJwNVoXCg2CEXN9+9gsLQVkY9hdJQrZtLFyrEx/g
	0OrFshF6vuLUdsnzSaZBOTzGuljRp3JAHBA==
X-ME-Sender: <xms:4xkwaojWP6eqkHv20TCtkNGj0BJ94Svn0EPPtFm1KFnbNKTKoomPHA>
    <xme:4xkwakvJvT31IfjzN8AsCrwJYEQjZC4zOQQSEiM3wpEafzfbNS1hEb-pcRLfemxu0
    wADVkqYb1kGGXpV4_7zk3HUNVK1-D4L66rufu9hpCJqPuVEsWgS3Q>
X-ME-Received: <xmr:4xkwap5xj7BLs8oqmgifuya2TIwxYBUQi6WE-5_6q9NXEI-7zpHycm3I3db_7oW5WOto6g8zfhOsrdOzvJWgphbMcNqIP1c3j8k_>
X-ME-Proxy-Cause: dmFkZTEvSyOJf5oDoRO6Cenko4TbmCOoCI0YTO7nawYm8fq55t+frhmg9UFOPomZzd+Pmh
    zDcdTJSQs5E0HV/BfsP+M1HN8o/sHqviFUYnXAr7we45tfXB6ngC28I7KUSR1TniNuj4E5
    9NRONq1mfOF1LFnG6G2r0S0/rv1D1FnydCJDwGh5m8EcF3D+yTAc8tLU4RjzjhdIzKU6TF
    cmWFxifgso1tWFKdof4vOlYT2f7cytUTtgWPqAejYbA0VtAtcur9KshDeT0T83u6uYU82Z
    kvRc9u6RA4QXhl+WlPcGFgKePrygTq3wwFFZqzx5WgbTFvh4xONvbQk3Z4yZBrqnQl1yqR
    3b3p4Jit3flvv04Stq+pO2c/GG0hSqeNUdJOoOIqFK27i8TG+4WkK1Pz2xlCiGmplrHPQf
    fM2kCHl/CCzLOc777RsgiS0Qq1M8rDLK8yrx/WCerInLQA8f19ROZJqYmD59qcrO1U5JWf
    4dB8eIOP/PG3XA5koGi/xA+uxXenh1TDbLQbxMuIQqBYelq9t9YpRXPw6iJy9KI/+ZMWx+
    2klALrf9TZovu6WdfOa8Ct9fH7Y47hh1X80E5uKQs+rrE+f8FzjBcjHUrKS4A0J7TVEAMQ
    uD36oGUJzPCWiAJ0KOOoxHBMrU9iGeH8KVw/gRPZQ6z2FRHmRYJ8Jzyea/EQ
X-ME-Proxy: <xmx:4xkwagPEvLIUWPq_iJfpQwzl7qddyNZFGV0auBJ1r-nI4vUCdaQZsw>
    <xmx:4xkwanv2s2WRFVifSiJNGKD755Zr4wgcx9QCo-YwsJsvLsOtPPjNkA>
    <xmx:4xkwajaTpm_2XZSPfmPyXJSM3kL_-mRPOvmxTUIg1-O7y9sd5LZCEA>
    <xmx:4xkwapyo_8nyFgaN1dizN2vittGDbA8B38COfAFs6rfEtAmQY1F8Bg>
    <xmx:5BkwardefAXtLAstHPPgxq2et4ictD7xAK4yY377avvH9gTHVBk-ECyA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 11:27:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] ls-files: filter pathspec before lstat
In-Reply-To: <20260611-ls-files-pathspec-lstat-v3-1-f967e1a00c13@gmail.com>
	(Tamir Duberstein's message of "Thu, 11 Jun 2026 21:31:51 -0700")
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
	<20260611-ls-files-pathspec-lstat-v3-1-f967e1a00c13@gmail.com>
Date: Mon, 15 Jun 2026 08:27:30 -0700
Message-ID: <xmqq4ij3ddst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Prefilter only a single pathspec item, bounding the added work for each
> index entry. Applying match_pathspec() to multiple arguments can cost
> more than the lstat() calls it avoids. In a synthetic repository with
> 10,000 clean files, passing every path to ls-files --modified increased
> runtime from 112.5 ms to 494.1 ms when the prefilter was unconditional.

I still think the choice of special casing a pathspec with a single
element is a lot harder to justify and invite people to start
complaining "why one and not three?" than not special casing any
(which makes the code simpler as well), as long as it is documented
clearly, like the above paragraph, why the performance
characteristics are so much different when pathspec has more than
one elments, the users and future developers can take it from there.

So let me mark the topic for 'next' now.

Thanks.

