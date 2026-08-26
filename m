Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E73839A9
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765697; cv=none; b=O69KJKTAhACR5fURAU3bBKfYFjXFSTnZhoLQxx8DbJVWkcAMoGDM/UAIC6Y0pDxyRswSkvRv6GmKY2r4C6MeG5MloUtLs9UOGYw1D+PeWi54bJ21hGnrMQgHzFpkc5H9JfW6RfuhwEZZX+cn3UGNjJYQB48nG19mJgdRp3YWdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765697; c=relaxed/simple;
	bh=OQ89Y8euQmWRexS7H6SmJ8m10DYtEhqzEuvNOQl8mf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1GWzCAnCH2zgkTrPJFojYLwGiWCY8wwQZvffxvRAen6aoKxipw6x6LxwrS+1XjSZ6R0KhSz0nos139Pflk4F7ltRneGMauDQA66f8c5IQvYYoe9FOTzT7Gbo6xQ1FmH/y3Uxrp9mxnPUaMWm3zGmJz7GGu7JGVlQT32oLIK34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nzcoxGII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0kCdyo3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzcoxGII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0kCdyo3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 03B0F1D00085;
	Wed, 26 Aug 2026 13:34:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 26 Aug 2026 13:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787765677;
	 x=1787852077; bh=OIW51k9iiTR8sY4bGn9gUkVMLpKqdeKbd8Zu4Bfcokk=; b=
	nzcoxGIIhuMoAePUtBsJsgoRV1bRys3EX6b+X7yHjHKLtQRkfd2grTYCNDYN7+cW
	qfo908mjdmOz7ITd5fNxrAJPQ67dbg5RIyEUiyBpdAXbEGe5qEeg4NEwjKcZiTNY
	Bk1982bvK7AmIqQtSMZuoHMi9HCXZqXcBhMPXfmh6CRM7FrDTpiP9Qvxwn9pCY43
	usEIbFEQkcsI5M43vRNEBNh5HVjULTMZDp62J0dNezy114bwPYnGYwGTw7bfdtJW
	f1GEC/DM/kUzlG9vzvxcKXAGz+KzhXKaGyOuxeEkEOLDE27F0153zwKb+9JbPyqx
	o2+1OG+/LmYJa5qw2NNfMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787765677; x=
	1787852077; bh=OIW51k9iiTR8sY4bGn9gUkVMLpKqdeKbd8Zu4Bfcokk=; b=O
	0kCdyo34xoP9ze4nzj0IedL/NTTbzjdnGmF4CdY42wsEoB1fNGKM7S55dAK5i5ec
	mrUmZlsVatGss/LKEzpJseK5dNMi/Zy0l+k1G9CUIFfOZL9DEWiZP4zeEuw7cVGs
	3Kw6y9MMFS8edpx++mvUH8TvBUFWm1isTJTh5Y/S142d/TtRBuDrd47cWzqHzl4w
	hT4XExXZru1FZluF3gZ6KIkIdwfP1kZ5YQPQqi04MBhHojoK86FBzFYI4TYceqR6
	zwCJ2yK/3nnqHzvMptR9EsoJ8Ix1LNZC2B0FyrJnXaAbTFdDbct9UrPMBU6yYeAp
	Ruhy55EW4wlYo54mSDnIA==
X-ME-Sender: <xms:rSOPapsZSNEI_5sGPdJOfoMrT-sKLtcf3ruuexFMb3rnx_YkLjtO_Q>
    <xme:rSOPasdGgVwEdSoSipnvzrohqArsm-WQIR3WlNgBI49nYwV_jaA4MWQmaXPlqxH3s
    K9agVZJZKg_KqQCRgqFW0Mq2MufuYNLK-RoUYtQxWUVjG_lpuc0yw>
X-ME-Received: <xmr:rSOPajZ7VILATLGZvNdYZbBfFTYEl9WRvBvCBd8AEpI9lAw6WbvFV7D9SqXWeTSsDW87E7SaP9pPttY5q8stRm26FtAOaRdmTQ>
X-ME-Proxy-Cause: dmFkZTEOlw+7BUr62MI4RLKcNSyUxL6jk8v7f1SzsGiGj1BahTz0EariptgYk9QQkXAJFe
    0RL1hC8JzmkY17JHBfH0ED4yzsRePKGXXFGk7xGyC4QlGrL7fjafRluUplvli6NxnfOD7j
    XoHGzM0V+8mydh+Hu68FUOo+zsQs7yKyZTf/QVyUn++rwfvypbUQfeLkVC6+K7CPFdw7J8
    +w0839AI8ykfhIlVTJcaeUBjLv+1OPs4ULQIeQUgGM400jrf3ErM9IkEClUJTnYbn6aLwy
    M9ctCy9kpL6KyiBGurmYTpdx8X6PpzYoeHTAObYOZ/8t+ikxO2kh6AHgwAnMmMjZshMdkj
    17P6ojuNlOJ0WNyQ+cT1UyqDdBdI1/a5f0G/byWzXCRq0yPQK8fgmkjZ+MLmwvvEBQEDCJ
    JQfqVCxBnwnhbnl9xXbPduwU7RB/+ivqU56LNjGI7BG7YCEbyLKjysPvP6e3+js87ncDqt
    rYGr/2HAbJqWJw8OdEkBWgaHxueixmWJzTJhjlD0ZuJcQzT0KMQ682c/vqrtAgDkd5imew
    LjQRZuKX2RvnXmU8ndKcU9Z3JFyejicAYoIUjXlGp7W36M7BAy648NeFFCYTpca6O3i3iD
    NCjfxRQDqiaaW6hSSe+Cf2YKtHvGEzGvSlEmxnLI8kzDY5mwJVaxRVo0Ii0A
X-ME-Proxy: <xmx:rSOPaub3Kq8ibquRQ2DhL3CnXMXEt1rxPAUIph0Yh3qu42O6rSvGOQ>
    <xmx:rSOPaoKBz66yPnqKo9zMNHdRKIpYiYW3YiNdhFhc2OL3KmsbjLyTGw>
    <xmx:rSOPaqvQQC-UjsFYkBVPSAVRMl6AYnMWkpmr0q7Jx9erC1ne7nwFzg>
    <xmx:rSOPasVP1Ih6iwKUGEPALQkea0omRCbW2oPTKNuUoavbK-Ynxxn1yg>
    <xmx:rSOPauNIqHKYZuboSsGsWXVNLCrZSq_x7XvjCA1OiCqrrvfbuRRHw92h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:34:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Glen Choo <glencbz@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/2] fetch: make submodule fetch errors configurable
In-Reply-To: <20260810150844.4003918-1-paulius.zaleckas@gmail.com> (Paulius
	Zaleckas's message of "Mon, 10 Aug 2026 18:08:44 +0300")
References: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
	<20260810150844.4003918-1-paulius.zaleckas@gmail.com>
Date: Wed, 26 Aug 2026 10:34:35 -0700
Message-ID: <xmqq1pbkiy50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:

> Gentle ping.  This has been marked "Needs review" in What's cooking
> for a few weeks.  Ramsay, Jean-Noël: you already looked at earlier
> rounds -- would one of you have time to review the series?
>
> Thanks.

It has been more than a few weeks now.  I read the topic back then
and pointed out a few obvious issues in earlier rounds, which the
author seems to have addressed.  However, I was not aiming to be
exhaustive, so I cannot say I gave it a thorough review.

Any takers?

Thanks.
