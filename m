Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C714B1CE0
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721956; cv=none; b=Z+P4DYpZnlLIgdZU8AS9am44e2E8/PpL7Q6DO9LUMHP5/nGyyfzLthmxa+ysH0VtbPai/MkcKSE3mPTRk+LkQzjHYpvNKn3CZAe4IeKClBJeSjXzQ3NTagfsE440VUDaX32ybbo5mZmqOjgFO9w0t+cq/dHLpFXF/zgo2TrZFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721956; c=relaxed/simple;
	bh=ZNxZWPSyNFn9A6jPmudGiL9dogjwdyGcSY1yjtlB+To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a5bNVPLc6rBlg/AhrvU4apH5tqHrT8WEuIhjVXLS5XuRT0fBco4t3jWT1LPggykitLA+CRnyEEn9AT6sKltuMuHnJ7UqRsI5XSSQRaxgBs8MaB2UouSHQPYhdX0Da8t59Jca3oT1fxtT4dQb2ZyxtHWP+G6F99pGma+6R6VQP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wJN6DpUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RK+7IwqG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wJN6DpUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RK+7IwqG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 69C291D00110;
	Fri, 18 Sep 2026 04:59:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 18 Sep 2026 04:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789721953; x=1789808353; bh=IODy3F50+y
	3sLzZ6iB48u42NmmGP/b9FYu7Sbii/qZs=; b=wJN6DpUEK6AhZxc3BdkpGSWxpc
	HTBRhFGgaTx5GNEsTXrcTRPXViUd4SfeUMquulBuAVEhxnfWxvRqU26JOMQrC9tN
	owMRqMoYnb3JbQw3gMh1hji05erFtmj2DaFRcqybvSjZopIhn/6W/WdzYfqdXZeR
	OE/zEpISRuJnDGzmLgD/s9pbtt9Jey9fx7J5ESU/fO/THjJrIJeJ9k+LdRxlyrvw
	ACM08b+6H++Oaz/EraEULxb6XrDH82HPjGRuxDc+EbQRCzUd/n0duyFnPEOtNn9j
	vwsHIdw/ATJwOBCCyfx31wanzxP3KTw7xzuX73Dn85Gae877DxhSrXNQgkWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789721953; x=1789808353; bh=IODy3F50+y3sLzZ6iB48u42NmmGP/b9FYu7
	Sbii/qZs=; b=RK+7IwqGxGcX0yKOJ5wRvGypgE+9CQrnjOgJ1DUmNdDmLBit8fX
	+tWoGVvy34Qy+DhQ732b7E9dPOHsosUOk2FkvjsqW/wfYRbWF2cxdU2oKyZ7LyTS
	2vnDO4jY3pbuwIQsqhhB1PxJXVqkbcJuRTmLEgbgV4hvvaORqTzP8JWGUls5uXq3
	lMRSWDDE3x/ki9CBqQ2owDJ6ybGZyR75sGTMcFFt316m2j8XeztMqFHkUnhC9P+G
	ZAlv8aG6Rsx6kuKjT/VH0iHMAxXehif+kYMMDSop1RzoEUbbkhmIus2ieNSqwZX4
	NW9THiSnw24mbsATS8jl1IILXARDnqpB/pA==
X-ME-Sender: <xms:Yf2samLL4wFY0hqCr7xMSk1PFUqDuRcW-57loXvaoLiCwumfQ5ASLA>
    <xme:Yf2salJlPlSenPZqy7wkVW8yGdtOlABYIKdUZgfLCunGsEI0QSeOME9YU02zipcEV
    -EW1TYxaWACPW7nMdSNDDONM36hXWddz8Mg4wTGqOZVFK-u_huQ3NI>
X-ME-Received: <xmr:Yf2sarvdGt_oaeW-0q3Q53rzunQUY4QbYfUprzuKEf-hz-SurtVA3Wze1ELsMPzA2PfQtVvYgd_Y9Zt3N-cwupx90ZdrvElLzEkU>
X-ME-Proxy-Cause: dmFkZTFcsHK0F0aCHxN4q3RFrsTJYAloDXoPIc43uyitYYtrNv1CSkOR+0CpOecsXuHwy3
    J4yeWmxtyCComfyc+Fb5zyYkirGY9oc5j2P7jClQMpfOF8l+LuUWNBwUNZhQrZt21sVadC
    0xSybpNzz3bttsziZ2C2OGQxBvRwk7I07UgTCxC5wyRdYcyjEaaFo0psUY+DHiOhlKmSGZ
    Jn3veOPvaDBr5oi91YvHSDXmnW2I/tl0Hb+/88faLgnUNBx9wEVUbpV7GtViCV3TuQKEbO
    +qfTOSCYfS7oqfvPpj2yk9qQla9AwXNZYgvgy8/SP1qLP2SBLNobOT0fdl81Id1u7p0pTJ
    zs5/B36M9C7OTlE0VyeSAHuY1ZfaWOboqAcaIkVvDjQcr7li9O364PeNxnVgOs2n+WT2Y5
    mpsB8Lj7FsHjlp0SdJZFa32BsUgb4WOitdwanhSn3guOVNmzOEKUqqBwQT/Mq2n/xgmOho
    7H2o7HOBNqXiuSxiRDZlzSzjBtbZWkhHNKclZK6L7mGLx9+pziHkAMiZlY2xmT0kDyGnJk
    G+Iqa7ur8/7OhdoEysnuk3U5wuJzNSuk8/+JpfQDLk6A2qByl/HlsCV9jzLWHApOkSeILH
    DexXU0oYif9fSaSMh5IeUxCXYszQYWJZGdXl/4UULNA4of/FFaE17Q4FYRCA
X-ME-Proxy: <xmx:Yf2saqR4Ko2TVBbf7w9mzmhO3vc-2fmrUIxS5EKD3vm4i2Bl_PeJsw>
    <xmx:Yf2sapPr6V-L48KIL-flBCHdRvM9hd4tqubXVmfyoE3s6tYOTyphnA>
    <xmx:Yf2sanatWfTo3M7ALKKbyCyLS8hDD5sp2iiBUf5o69Qfm9QQW62iHw>
    <xmx:Yf2sarzyuWCX7C00IjHG0E_E5lYGPk_xn3_7xz64zOIDBokupjOb-Q>
    <xmx:Yf2sahFJrkpHNN9R2HbzIawWB_45Px-kyOHaQpBSCxhiAo03mu3Q4QLh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 04:59:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/7] gpg-interface: make signature-prefix matching
 length-aware
In-Reply-To: <e20a33ef-181c-6dae-ce9a-8dfbc5d560b0@gmx.de> (Johannes
	Schindelin's message of "Fri, 18 Sep 2026 09:12:32 +0200 (CEST)")
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
	<3fc7774ba867a10f35f7a74424baa4527f038232.1789667556.git.gitgitgadget@gmail.com>
	<xmqqa4pfu11i.fsf@gitster.g>
	<e20a33ef-181c-6dae-ce9a-8dfbc5d560b0@gmx.de>
Date: Fri, 18 Sep 2026 01:59:11 -0700
Message-ID: <xmqq1parorz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That holds for six of the seven call sites: `commit.c`, `tag.c`,
> `builtin/fast-import.c`, `fmt-merge-msg.c`, and `log-tree.c` (twice).
> `builtin/receive-pack.c` is a minor wrinkle worth flagging: it passes
> `push_cert.buf + bogs` ("bogs" = "beginning_of_gpg_sig") and
> `push_cert.len - bogs`, an offset sub-buffer of `push_cert`, not that
> strbuf's own buf/len pair verbatim. It still ends on `push_cert`'s own
> terminating NUL, so the observation holds in spirit, but strictly the
> pattern is "ends at some strbuf's own NUL", which is more a matter of
> code-review convention across call sites than something
> `check_signature()`'s own signature guarantees.

Yes but the audit was "is slen our callers pass redundant?", and not
"does everybody pass strbuf and we are better off passing a pionter
to a strbuf?".  And the answer to the former question is "yes".

And I do not quite understand or agree with the logic here.

> ... Applying the same "audit
> today's callers and assume it holds" reasoning to `check_signature()` now
> risks reproducing that failure mode a second time.

What I was saying was to force all current *and* *future* callers to
pass NUL-terminated string by removing slen.

Having said all that, I think this falls into "once the code is
written (and more importantly, once it is reviewed, as that is a lot
more costly part of the development process for machine written
code), it is not worth going back and change it, as the difference
is not large enough either way."
