Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68C331A78
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359984; cv=none; b=ZDIyExFaQmwJ/EPWRCQdkaz2YnqK6Hq4Bf4e/Fo7F8+JPFaQMxMtd1Tha8rul6CHpa1WU6ggC9SzmFo05D/SydFcXQu8KQTyMkprfWsz3ZsfOJA/LZdjR6nHMZQihms8/zZkpccLtFVJETvV1RQ96+mpxwMTO97luAWEwCXjd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359984; c=relaxed/simple;
	bh=GCiy92yigKfHfsrZi9LaF5BlRw83SUlZAZKLY2Uh6JQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X+Flg2N7tINlKe1fHH9wxs0YM3fMTRqfhD3rY0zrYSPKPmI8UMMwR8aUBzdZyPzYor6H/TW+NTvkKx5Kv/jcPM8B6HJYcPuIRokW9a2JNj28ol8G7pqqI8aD6SypikFsHkn4+BT9bUc3UPojMFbsIvbGUtdOFKSQuzBFmZEBrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/bgnwbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3NV0u4h; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/bgnwbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3NV0u4h"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0020CEC05DC;
	Wed, 29 Jul 2026 17:19:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 17:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785359981; x=1785446381; bh=IKmXltW/ap
	BMSBaAsi2UvfWxwBf7vohETDhUQ+U227M=; b=W/bgnwbvlSmItMIor1yxzZ31mg
	qbzKPIOCdnSDq0H1C03XobTwVKYoTdTeDCYcy2ShWuh1ARIa3VmgJ/VlUKGrXp/q
	JBoaucBP8M4XXWMzrKpE7RbYVG4GkCGoqvuxQUvRPDFUrHoiQ3jWRxjYG39i4nGu
	yptMVuNgyBBC5hoHjqlMfEYn+kaxQZXhEEjHTx537jdsEwkep7v0SvXgLYvBjTXk
	a/SIvuw4Ja8exIY+YE56e5T74/5lWjI9VI8QGfM3ZrpiKMIrC7G3nzhwoUcSTiRK
	D7wI6pnChaBUBjklAO35lvdiDWkqz67Zv6Uuy5A6jyD7oedO/tMhu6J0zLgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785359981; x=1785446381; bh=IKmXltW/apBMSBaAsi2UvfWxwBf7vohETDh
	UQ+U227M=; b=g3NV0u4h/8ob7Ou4C4YXiS4XRqFQDyQqvGOJiGKLvf8xKkVsDZd
	1BVu6DCF9pbmVpFSYW/nEjSL3L5Uu3S1DgUil8sODE+KNMJaSMMivF1LRyzL6lLT
	DkdfzYE6+naPg+AKUXXVASwgtAr2F5Kg9vRHUCeo4Cgyn1TDSm13AKWlptKbeDkQ
	hNIh1aIuOY/NpDJytKj1otuAgfH06Rg67RD3uU/VsI2fI9visH4ZPzpTH/796V5Y
	NSAt8PPxkTfUnckwHIUVoGVnVUkveZKQL8rLVVKI5p7Dp1EK76lcVjlVEXngC4Ar
	3GBnYi7cWgXn7+4z7ZnylKdsG5GnI7cJwBw==
X-ME-Sender: <xms:bW5qatlGUjShZFOB7Pp_Nr18nRIqr_lYg7knv4dqQctnUkalD1aILA>
    <xme:bW5qagQYjWIMfxN-nJuuN1NPPuqYkpJwRBWasBhBIkWm7V6ZPuDBjy8URoDcdtFRk
    olbVrXKj7JsGIoVgDYGgf8v9zB5AztweHjp12GIC-anpzQ7GxjpMg>
X-ME-Received: <xmr:bW5qahDa1IlqTolymovfk3Z_ge8DazrRALl0LfyTJdSerT5LMhMzXGkr6zPZDzKMjWGnxZ9ya3dOzeHmFgHOg1UP_Jdd5QCHIA>
X-ME-Proxy-Cause: dmFkZTEltRc1LI/+DVZRXnS+mRPoAzJ0l1C1F/0WjBPXC0xQGJak0JDAfU2J2Z3aQqydK1
    ++wJHzBeY0hG0wHPI9LN1OhNWmqsRUEf0FVwA6py04N9+m3rEaZqO1m/r3k08StLvil8hZ
    ZECToj6nKXxjUCubOK+/oqBwSi9dOy70HdzOiDpApR+L4wGc7yTSzNGa+4e4xIulqiTfFg
    2WBVbOK0QMfGtJXG5muzgNvYjB0XqwU+W1akXJkE7AmwToTNk/sPCkj6EOBL6lPrHtk83p
    QyIBKMzMT8N+si4+nJvrZL3PRbqQSSIt1YB0Q5y8xsg+3L+sjFzGaQ0YvN0RT71DAr7Ngl
    aZpgS5PEwasN8TsOJW4hbOSRfuqehSipekJU5FNv99Tx/ahyuLdB9AbT4chSfyClSUBhSW
    Evlsx/hKbvYNdVVccrORlEeUS0R83P1v/YiFQnWo6En9pmDPViO5d5SU5HV9M1jAZYoVMw
    8KTX9Psm5KTreTQ4IEM35NDM6GFGglYN2LJmz65poHWW4PiPAmGIIe1Vj07CPAN2Ve3sDL
    MDYF7vcJmUX6q6JbJh07LaV/riHWHwjHCBT6hA1aSUf1qjlpZwhJGIuxFBtUJ7kIrl/hJd
    eZmgRG2JzRo/SBFIwzE4Uf4qnt72NdkW7LPhcZ6U6S5MKtaaL9C1THKvBHWw
X-ME-Proxy: <xmx:bW5qanS8FbtrXYixSuaWNMbeI0nfQw59HvuVxJVwBQk1suxeLTtZag>
    <xmx:bW5qavrw4uwzW5fqIQwoCcYNdw-KSzaKnSPzu4iqETgRh653lu9-8g>
    <xmx:bW5qapy3Kr6VFzQ_3KS_auJ6ZGSOyB8PAdISOdzoSDg60wQB0ca3wA>
    <xmx:bW5qakJfyVKTv4Lrb3uE_jCyb8aejbH0Ux2yfLahFWJCEMyCH3C4_Q>
    <xmx:bW5qakRvg1wN4MmWhHUqynMJbQKw3V0kjjbAUeMAsaoQ3bsrBJyMg89Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:19:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t: use commit_body to extract commit message bodies
In-Reply-To: <20260727095656.75496-3-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Mon, 27 Jul 2026 15:26:56 +0530")
References: <20260726224803.45131-1-diy2903@gmail.com>
	<xmqqldawq24y.fsf@gitster.g>
	<20260727095656.75496-1-diy2903@gmail.com>
	<20260727095656.75496-3-diy2903@gmail.com>
Date: Wed, 29 Jul 2026 14:19:40 -0700
Message-ID: <xmqqpl05o5n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

>  t/t3404-rebase-interactive.sh             |  2 +-
>  t/t3405-rebase-malformed.sh               |  8 +--
>  t/t3408-rebase-multi-line.sh              |  4 +-
>  t/t3434-rebase-i18n.sh                    |  3 +-
>  t/t3900-i18n-commit.sh                    |  4 +-
>  t/t4150-am.sh                             |  8 +--
>  t/t7500-commit-template-squash-signoff.sh |  4 +-
>  t/t7501-commit-basic-functionality.sh     | 21 +++----
>  t/t7502-commit-porcelain.sh               | 77 ++++++++---------------
>  t/t7509-commit-authorship.sh              | 23 +++----
>  t/t7600-merge.sh                          | 14 ++---
>  t/t7604-merge-custom-message.sh           | 18 ++----
>  t/t7614-merge-signoff.sh                  |  9 +--
>  13 files changed, 72 insertions(+), 123 deletions(-)

I would not claim to have checked all of these changes, but I did
spot check a handful and they all looked reasonable.

Shall we mark the topic for 'next'?

Thanks.
