Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9B221FC6
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780755806; cv=none; b=TM8Af5LKN908S7IyzJkKgn5SM017ou7OHKDai0joTiG1Fqk04s6sgKCJDDvSd+mGV58VUVxvIF3wKsYXELjiE5u6Kkwrs3inHDD1OrjJhiPDfTw/DkP7kT3XF6qJlJZh6GpoyZ/D2rN8IKcxHsz01EFTRqtL9M/21+IWn37QXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780755806; c=relaxed/simple;
	bh=gQIRsE1R76j0sZnmHOCJwCVBvUgNDHXW85IgFxN8Qro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tY/dKn2FdlF8weQZjtYdu7HmAYvJPl56vW6iEtvKIz6PrMlWT9nIkd476YGtI53yejwtL1RvlHN35ZcPzbI/S6oPVoEyPaI7f/NHRvNMLZg3noNqA1zFnteIMaEoE64IOcw8pqCOgV7FXtC3zo4nUGeZSITjIySm+P3jPZci1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QZDXGH0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGKnzkWp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZDXGH0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGKnzkWp"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 259AF1D000DC;
	Sat,  6 Jun 2026 10:23:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 06 Jun 2026 10:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780755802; x=1780842202; bh=Bzd/xLmWaj
	vAaqzITOqFIA7dU7tAtql9B6lCJlsTu3k=; b=QZDXGH0HJU/iyLqO0iS8Kd9GsM
	6E80LbvwvKHwvkNGlwAjkZq1FZtVsUv9O9lb6US0zS7qgBbKF6sxsR7DyUbsMUiV
	/B53Uq+WBh8F/VUU588BKcWx1KH3525W7A1xthGme+kZya+Vv7Ge1xmTN6s7ue6y
	yz8mJwpK6hySWvpjlPx0vI1pD+A8i5DqcuHpEf5ryt/whCvUn4QntHMEI05U47C8
	Py6I/R3GfcIgr7sHzA/qyFI3mKAEXqurf/n111fKkmDzwaivbvujvyjg65YRJpEs
	SsuR38uAu96+3sibzTGFJ8u5myTqhTtWci+b6Y3HAX+VVkFLCIWXxujjLHeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780755802; x=1780842202; bh=Bzd/xLmWajvAaqzITOqFIA7dU7tAtql9B6l
	CJlsTu3k=; b=UGKnzkWps3ve0hXFmqyVHDlotQ8s8M5jHcpHij5quUVKdHe69/C
	bld+3stdGOwcUhrVIeLN8Y5a8lan+gZV9qW5EQL2wmOCHaD3DOA8+BQ4Lx0mPqiW
	ydIge3vnZaXtO6UvUdvq07UTI8ywafa/ZwkrOejUlEltTeKMSHstfgFiqHMvzkN/
	SUk35wbPopLk9ggDjy9P1hZbIBirhmvg5TVT2gmzpzxVzaw9cCaSFFL2kr4j11Nk
	TGYd6fV0CY9yMz0aZ+a9oYsBindppDR9QL73iC014oWrnBA9WLKKWr820WLvKdv8
	dT/2CFsHI86McAJCRlLoXeRDtQcOBsiHzsg==
X-ME-Sender: <xms:Wi0kana4T7EDr_UtdtPfWw-B7KRfGT96xE33aPObVKIyo8LbwxHXrw>
    <xme:Wi0katR0oJp7EunELQX15KKr5JbVvDrrxXE-2IdrNGLinLqEipPMp-aQ02d3Y28pY
    r180IfL-LfD4kYtkIiOeooZXBPl5dXvghNjwb3rMUmsAYkdRWFJSQ>
X-ME-Received: <xmr:Wi0kaiTJyi3N5ZSUY7Mau2H-1AD5oVZDsRsul4UXrXKtSNi6VQM5riuIiI7ew7Z9hm-giGhoLFSM55zuTpzuTdyOwKRp_Iuk24Fb>
X-ME-Proxy-Cause: dmFkZTGhsteR0gB937EKXj8hBPVHjwoY5eZW3ynQ4sqHlw6f3je4Hjdd+VkuAAbUzr9892
    VojFucJTRyZHk1jkNFr7inJt8AehDK32i8qfFN1SkyBz+M96Z/8aV9JnktlnFhfSlmdp26
    azChKlHfIeay1d4ndfUbdf9HTUxAnWabBe/626feQBOw3bxtIqoKnCoRZAub8F65dEP5Dv
    f+GepZmwvhEz6ctOc/TMahejZ3f7NUosPKNoCJgxp6ofGEc4usYBKQFPA2RYtxvYJIhzdv
    H6YSLmvMGmEhHxM7HT19UIpXVuJ4KVRvTKj1YZq8fyGDvt/wk2EZqcYSr1wZS51xS8/Jpu
    UJ/blMkLHO3FEE/AbNWgsOZuF9RCFBTzvuxR3UbYcAug47oKk3bPhCSLsrbkJTnaeP5SvZ
    uVFyq0J0cQOar8wSqMLkamwyGcTLZ7/YONlMivXocgTlSKgfJYDG0UfdnmWIKhEOPBNple
    h2IzPZgMIMapnCIbNLvaTu7LQ09SPLMWMb8E/p5wT6Z49zboTKZ+yuh5nwPSFa2QMU0dzA
    Xay9swLQKiQLLlT2wPvlllWYSc6uKYhFLqZv6caCg9hoLa5vJ8raJcr8ymJOD4P/eAFlKA
    A++l6LgiN0KS8uUpUfpG9pLg779Mp/qp102PHb3ftugzteDGDWXNtyEEmKVw
X-ME-Proxy: <xmx:Wi0kapQm39rgxRBjQuW1DgsTLo-OvHzQY8jYd1tiyTwLj_F_0YSWLw>
    <xmx:Wi0kav4hMsuZDHVSFwb59AWxyIZajbc_tXEn40E7_aois3E7e-400g>
    <xmx:Wi0kat0GBy2Xbmia5wtK3KbD3tYU27cmWiKOD3q0m3bDbFgEkKJmug>
    <xmx:Wi0kaiDCHcxoCexgXK7fdp3gYT6ceohe146uOBczALIvGqxl1WxLCw>
    <xmx:Wi0kakWRabV_i8nEFr7AsjS9VT4G9fyOMteSetA3KRWgOMlApvjxmAkY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 10:23:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/10] parseopt: add subcommand autocorrection
In-Reply-To: <SY0P300MB0801E50FCB7EB2F45CD15208CE042@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Fri, 15 May 2026 23:34:22 +0900")
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<xmqqcxz2tzpr.fsf@gitster.g>
	<SY0P300MB0801E50FCB7EB2F45CD15208CE042@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Importance: high
Date: Sat, 06 Jun 2026 07:23:20 -0700
Message-ID: <xmqq33yzd9yf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> On Mon, May 11, 2026 at 12:03:12PM +0900, Junio C Hamano wrote:
>> I've been carrying the following fix on top of these series since
>> Apr 23 when the topic was merged to 'seen'.  Can you fix these up at
>> the source, so that we can move forward with this topic?
>> 
>> Thanks.
>
> Sorry for the delay. This email didn't reach my inbox.
>
> By the time I saw this fix, I had already sent v6. Should I resend v6
> with this fix squashed in, or bump to v7?

Sorry for the delay; this exchange fell through the cracks, and then
I no longer recall exactly what the "fix" was.  If your v6 still
lacks the "fix" I gave (sorry but I do not remember what it was, and
I am away from my desk), then please do incorporate and send an
updated one as v7.  Hopefully it would be the final edition, unless
there are other issues outstanding.

Thanks.
