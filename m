Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76811D6193
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763818200; cv=none; b=DmT0vcqRcWF7iHtiOqKbFxOQPWEai2dllegmZ7+dHoMjYsSA4NT0StBsgAj7AhWqHwGQOwJZBCi+HSg1U4ZKU7K9p+wgXmrr2Oniu+XEVoBJeKOOVEI1Q6U9nH/KC6AaDTQhLWOYYXH/b+Y+e4qzr+4aecYlAKiPFxL30JhsNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763818200; c=relaxed/simple;
	bh=q0UaSEGDu61wcVSidBgdRMXGtuZB8Mx+nHnB7WcVyL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOhG6c4zbIQLWf+KYwleUiN72ueZAIw4LDmyNGT65H9dLetEIQ3ZbyXlRV9oF3/qVg2EMVe8od7rdv6Sa2ft7K5vWcZZRAb+dBpMOoQ0UQ815wud43l2GMI1ASz8++22KKx2CLVmQrfIZOtkgxacIfpRq5pykbYj5kiErVz2Vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ctFV9xcM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ctFV9xcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763818190; x=1764422990; i=l.s.r@web.de;
	bh=weqAE1TRZjRpQJZcJ2U49aVt57JZYkgWCPD/jmMQrs8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ctFV9xcMmny4zXXLsrIW1tqgiYQC4IBWi17nAXHVuo5mk3hPkt71FSzPzT1lei4p
	 gvnMEWxs5GHqpFavE9J7iwy3y4/7pUGNOZJykC3LZs0BDmjCuU5DnlESdh2pDYAbK
	 +nqAkM1LxCuvUBAtwKnaPP1mQc9Ip0tGrfkByzqv/DS5KuPObLz/kMSpzAgZ29CRb
	 c2tqu5zQiCETgh7yFfUxTJC0fWyBRS4Q6gFdYK2vZLj6fI98Mhr6L8akg9LNsPWxL
	 Tt72Z0NMzWZ+k8qRJKmluwhrYtRpMhiJez9Tha3tcY05WkksLlarEorp3u5/7q/zu
	 LFo45DKEuQKOFmMdOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1vILiY1lZ2-00AqQK; Sat, 22
 Nov 2025 14:29:50 +0100
Message-ID: <18a0a729-d77c-4f4d-9581-b102bd66816c@web.de>
Date: Sat, 22 Nov 2025 14:29:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
 <xmqqbjl0iax6.fsf@gitster.g>
 <20251118094621.GB530545@coredump.intra.peff.net>
 <3b1cb53a-6427-4626-a768-1961e25514f8@web.de> <xmqqqztvc51s.fsf@gitster.g>
 <20251120082328.GD1283645@coredump.intra.peff.net>
 <xmqqbjkwahu1.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbjkwahu1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0H3B8KPAUMXb5Tg+PVT1oC9UIvxddPU/4WezKn0kmNAABTbFCkV
 /mViS+86MijwKwPnf6JXulESjcrsuopejaaQRnqE8n5/sHZjDgP1eE1HTSknj7BERi/5Huh
 4DXTNs4Ebq5Y88u2KWm3eCN/VLO/VSgyCDiXVirpy54TH80gCPuAxZnpm6Aw12n92TlAvFy
 FSmdz/QovtE6+xUsK6G0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GYt+Hv+u3vE=;EVAbRLWQ59tO7G0StPhejVQo6gM
 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
 pb8hngqXQGl0iFwSN0J2yCJ4ig=

On 11/20/25 3:39 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
>>>> +#define mkstemp(template) git_mkstemp_mode((template), 0600)
>>
>> So this patch implements what I was thinking, though I probably would
>> have made it more explicit: add mkstemp() to the banned list (not
>> because it's evil but because it's unportable) and force callers to use
>> git_mkstemp_mode() explicitly.
>=20
> Because only a very small number (one?)  of callers call mkstemp()
> in the current code, the above is probably a good thing to do.

True, banning mkstemp(3) instead of overriding it would simplify the
code by removing one layer of indirection, and the hassle of no longer
being able to use that standard function would be low.

Ren=C3=A9

