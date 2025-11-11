Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563233D6C7
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892343; cv=none; b=WxEm/xBfb6vZXSMUtkfoNL+vFH3i2CkUtUN8nrw5u61RkTLEDOgd4hPl0ho25MJeCbDhJtAfO3nEFsHhVVOn38pQYSAoTcMXgsZf4J6iH6OTBzVfLqbG349ZeQzSls3vWkQeCxFiUC/7GmzCrlPwh2z35i8DRLDEoVE2cnTAZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892343; c=relaxed/simple;
	bh=7rA1/PdHULJHn8yi3aGs/nR5FxYexOKyAy2Tjy53M9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RhayxRoSVw7J2D+jD8J0M/jrYb7iNnEd0IZ4JZF82aeLR6jSvNRWdJXHrq95tJ5HwcMMh19J0FYETa1Oa2Tx7SuqDlLQ+T84jOJWz0y6hNThhKb4ym7KqLziw92pNfiZhEZbEaABq/6Io4EvSgFD8IFe5nNGbQV7UzuIJGhAStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bkqs4jPC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1G3zTqh; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bkqs4jPC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1G3zTqh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B6C27A00E2;
	Tue, 11 Nov 2025 15:19:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 11 Nov 2025 15:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762892340;
	 x=1762978740; bh=7rA1/PdHULJHn8yi3aGs/nR5FxYexOKyAy2Tjy53M9A=; b=
	Bkqs4jPC5+LbNMl66amAHrscvmobc5bcj/7k/Hen322Bc0/Fle3lt+Vl5TpTJkGc
	w1jg04F6lua7YjAfVj6agTtoLr/5yzsQDe6Bs0/ApP9EojzSkELT00wP2N/kyhhw
	y7IVJs/Qksp8IDe5geWrU/5ivbsNhMTpMQpSPG9JmdbyUlX2fRgF5XBU+kqy1CdX
	NNhmcgt6pqfwwTYIRxWqxZ2nOGxyCmfVtFgjeiHWzmo5HPK1txperNzTquIRE3O/
	pbeyN7ptDUE00zclOyvT7BmylBzJInMmQncNHaJGbOIlKiAomg7AxXxhlAhzsDqn
	4H+pQYaqSaVogxi9nRO+xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762892340; x=
	1762978740; bh=7rA1/PdHULJHn8yi3aGs/nR5FxYexOKyAy2Tjy53M9A=; b=Q
	1G3zTqhEMb+9rhXucBsjLdb7U+RL95zZSrsUG/IKjqxqXkL3o6kD+CFciAHMtLkp
	wGJqihkc2spy20oMJEuUe74xOhyokN6gzhKkVQJzlpfRzv7GI1iv45vmt6WGKwXI
	M7WS/4Yw6iviVwVMMnCXBpGwj40Fn9fVGecHg0d1ZCeGMb+hwmLyWKuXnfhSgcWI
	u2JhtworHcUuuxhxhKA+TvamGb/70B+xY0AqY6xE1vkpKmFeNSFvFERRBR8Dn/Rs
	OdZhg/DkYiiGoVOAxR4XT568xD+QpnT7K+uLRLJXSiBsbAqHvfwqByD36sGqzptP
	hX6fLZ+lU0f+bqpo+yVfw==
X-ME-Sender: <xms:M5oTadk5dr1KDr-V61-u0eA1n-vierucDjsYWEwwj3Qxj_Lo2kHLUQ>
    <xme:M5oTaf1XisgP-y4CVhsyQE-TXrp4QI_8Qg5Zlwu06RqTMdV7GhxQcqunIiyornNry
    EyZIfizjrpiOmJsbbvhYdjQ_epjKCj4Z_8KPny5FrEAZABhpiDm_w>
X-ME-Received: <xmr:M5oTaYrSGp-tu53QZl4Kp9W70Xfc-G_QBzxLePLm__87ntycXqTFlE_PgJG7ml2fPFL-Q-BvrXg13jiWxh27tYxnKdKOc25c1xLa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M5oTaceu63Mw3jy0nIEleWtvDMfa3fOFEZXY3F9P22Hj2i5p359ZFg>
    <xmx:M5oTaXpqFXmt9LGCjyHmKuB5_KIVHkIEIRIayOwb5VW4hWurBXdX1g>
    <xmx:M5oTadE_1g7vLhb-0UO5FnfAZOygyXy13Afm-kkMLzekzKWxUDlgrQ>
    <xmx:M5oTaXsFJml0NdH09x4ZzVibY6YdPD72Ogi-TKLBhFy2LNBLWlvQSg>
    <xmx:NJoTaULJwJt_lY-_GDvD5z0iS6DF8g_K4TeX4MqrRSo0Ew0OVPUizKIu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 15:18:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] perl: also mark git-contacts executable
In-Reply-To: <CALnO6CA2uLjWg_kwbaEGd+TZP4qQEBMus6HRVbo7Bz9oHdoYxA@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 11 Nov 2025 14:00:00 -0500")
References: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
	<15f07afcb66a900e5391e6b07e0701ce84236f04.1762820188.git.ben.knoble+github@gmail.com>
	<xmqqqzu4wg3u.fsf@gitster.g>
	<CALnO6CA2uLjWg_kwbaEGd+TZP4qQEBMus6HRVbo7Bz9oHdoYxA@mail.gmail.com>
Date: Tue, 11 Nov 2025 12:18:58 -0800
Message-ID: <xmqqcy5owcel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> On Tue, Nov 11, 2025 at 1:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>>
>> > When installing git-contacts with Meson via -Dcontrib=contacts, the
>> > default Perl generation fails to mark it executable. As a result, "git
>> > contacts" reports "'contacts' is not a git command."
>> >
>> > Unlike generate-script.sh, we aren't testing the basename here; so, glob
>> > the script name in the case arm to match wherever the input comes from.
>> >
>> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> > ---
>> >
>> > A small typo fix for the commit message, thanks to Patrick.
>> >
>> > v1: https://lore.kernel.org/git/7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com/
>>
>> Together with the html one, these patches match what I have already
>> queued with local tweaks, so I won't replace them (they are in
>> 'next' now).
>>
>> Thanks.
>
> Ah, sounds good. That was one of the things I wanted to ask by "shall
> I send v2 or does Junio mind the trivial fix," and I should have been
> more direct.

No, your question did reach me loud and clear.
