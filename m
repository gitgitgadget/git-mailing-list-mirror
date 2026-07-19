Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24518B0A
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440130; cv=none; b=fHaWewdUONeW4e2JIc0HfdLFMzunoQCAlIQ6K+a771Gtz6qJjHqMy0f9laaZ0BXZLPR0cWe64+P0CX5Fdh8TLNlwFtOK0hlNXrIcmDs6sP+xwip9pH+u1O1KONRMK5BADKtkrxd2wfAAo7GrdLoxr5DVU681oFndOG9kj4WH1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440130; c=relaxed/simple;
	bh=I6bD2JGpm5sN+LXjGz42Zr+JqfyFX3SatNr1om9OEpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oc/TPWe2VqQPSk+r5Ec1npzHESTrT72Ev7rUXxEs+aBBS0cyhZ+QHpPmduRnhASanl2AhWADba23xr6u3QRMShKaTN+AxJ8FiEJM5B3xWX6dP8D8Lbod61kNFnzgsnleQ7bWcvYqqw9e0sPioR8XbOf3DqOlx2r4aIEv3x8gq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TVuCwi0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjF/hYgs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TVuCwi0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjF/hYgs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 04B1AEC01B0;
	Sun, 19 Jul 2026 01:48:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 19 Jul 2026 01:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784440127;
	 x=1784526527; bh=h5kEsHmjv2iNpv/cP8Ro9KhLN9I/DjY4knC1lOpCp24=; b=
	TVuCwi0/U+LVABven1Cz5ad2JTvefZkCxTML3erf43nfURkRLZkUtRr5WZt4Xqha
	uOM7zE417YPJyXhjiDFZM9i8bcSEXhxGOFgsk4dpsi4pNZQ8F2xn4abGD070RJSK
	LD7t2KRloXHZ2Tbr6cSqo2RjL8v77cNZzxq9zlWRmubuocs6tVdImeHfpq4JYquU
	rH7tPXdvgXfzC6G/hzGNM2H2AwRWuS1aFwisavbH3prtMCB2TRie+0R97WAeTbQL
	dnymmzYoTwTdFxYGm0ZcAis0htnsL2gUxneJRA2t0Wi8IOS1sCc/7/x4uBlx4o+4
	/34MmWcawREQ3MdAfUb2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784440127; x=
	1784526527; bh=h5kEsHmjv2iNpv/cP8Ro9KhLN9I/DjY4knC1lOpCp24=; b=F
	jF/hYgsOVTUXR5wEGR8textkxya0PcXXqDWXbImadcz5oUNzY2L2qlMrC6YQDTFT
	EbiEX97Jpg3Rp+efiKSO9KYIncC64L4eujuh50+j6AmpTm7i5jj0PLgPAJeUXT+v
	75nCbn7JQuGPp2SWI4q7CghaX1YrRCeI2DnFqfSTl5zrXu2M+5D5tKXPSoJtHxYz
	lqPRG3rF+tjd8Zejs4f2UyzxvUx/q7sRBCrONlTQ7tnA3tM0jnibQ3LvGTDjg5kw
	U/61rOsSqZXBvWLN9kFUmOFbDPNOgqBd3ipqWRPW5owiCWuu6ERpoU2ZJBYe4yt2
	H+dz3dnuZNIl8MKFahKAw==
X-ME-Sender: <xms:PmVcarOlB2u3YfKW4UKau9wZ72nQUVsMHM5qHVWIOkgQE4vjN7g2Og>
    <xme:PmVcas1FUYfWguYy5aBgv81XgeYi3dMoiTfdPqEqzLanl7XqiyJSXW0gDeRYqJrM8
    pzag4SdaHjKzYfcOobPX8-oqcD2fOScOp69u_w1mESUJpOqx7_lag>
X-ME-Received: <xmr:PmVcail5X2QCe0nh01ZN6VyVa67j-LY-vHJ3NWW9TQ65K4NfP_FKDq3GvdPUqVeN8gAo3T43STHeDS6IbLCf_KqVCvHndAHmOQ>
X-ME-Proxy-Cause: dmFkZTGYAAqDiFOFH72SGs7ikJ4JRHltyMRu8Q8vJW8MBP51UqOKeh43/OkvGDp+gWEbnC
    99dxj9KUowk/HSB0jEZA2XMyjikuGtQZ3e0at1PuHpVsRDys8RwU6oGiAfONeuRz5baDlQ
    EofODDpNZgGlqpbnxqWKZRIdirQuMt9zINYA/7cZtH0L3+wCn3GP9wasivgqhLJ6MH6WWG
    HMhe9Ojb+ppCQBrp1mYTu9MPJq1VC9Tfz4pm4F2+8SS+eQmHnpkm4SO7mK+dM8AUf8TT16
    YOTjn06FXs1hgnbZ2NuUf8Zd3b0liAkY+ZvVHKEse8p1B+1VxYs1qjp4R4fEFQTAa5iCcs
    oieIkmXZ9D8Qbptrd+UpRrVPYztp7U30t993fZMJrNTLpG2Tp+93fGhYpJuyUHB5VKvkDc
    F7x6HpNorMm9cqj4VtGZOnZLoXO/h3xcmUMF/GCSmKPS5vFNEeg0xLNp65fpc0hadbWgpw
    CJFe6Y0CB3djkVeKT/0wQOxElXeJcvwcXCHJ5fha7AeuKX3q6YhCp4VgenJOOQFvg9X0bT
    G8E8ziO9dbzxV+wanNxejP79AEkPwEBpbtheYuTtuWBI0MMaeeO7tYSuWdfxpxiQuH4Bo3
    sFXV0PY75G/UW0+nfhKOJnyTisoD4WpuzPye4trN72PGgJKc9FFxE24BxPBQ
X-ME-Proxy: <xmx:PmVcarWW7kisdsrGQdvS00wmnUkrWi5a5kku_6nkfOVuR5BdaGQoBw>
    <xmx:PmVcaguG7oJSWXiJ2w03uTjF-UIDVQQ9gE9ng5ZrA9Z8s1d5jrMCHA>
    <xmx:PmVcamZOHSxNnBG95KZaLeQPT2_4WRrQ34c_c9v9DlVrqfz0lEULYA>
    <xmx:PmVcanVNKy0hy-5LYgdgRMFytyLXKCkLyFA9Hk2pFhCQnvBefzzz8A>
    <xmx:P2VcaimN0_VD9bAfC9f4VVYzCv-_Fw8M5ykZzmKYfMAkppBHN1wyGId0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 01:48:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH 0/9] object-file: move writing of loose objects into
 "loose" source
In-Reply-To: <xmqq5x2brdqj.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	18 Jul 2026 18:04:52 -0700")
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
	<alvWfOJb6vAsusai@szeder.dev> <xmqq5x2brdqj.fsf@gitster.g>
Date: Sat, 18 Jul 2026 22:48:45 -0700
Message-ID: <xmqqecgzpm0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> It seems that you performed this evil merge when merging the topic
>> jt/receive-pack-use-odb-transaction into jch as 9727bd8447 (Merge
>> branch 'jt/receive-pack-use-odb-transactions' into jch, 2026-07-17),
>> but forgot to do so when creating the base for this patch series as
>> 1d64e64326 (Merge branch 'jt/receive-pack-use-odb-transactions' into
>> ps/odb-move-loose-object-writing, 2026-07-17).  Consequently, neither
>> 1d64e64326 nor any of the the commits of this patch series can be
>> built because of the mismatching function signature:
>
> Thanks for noticing.
> Very much appreciated.
>
> Will fix-up.

I've rebuilt the topic in question and pushed the results out.  I
also added some more automation to catch this kind of mistakes early
to make it less likely to happen again.

Thanks.
