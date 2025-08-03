Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C28156C79
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754220825; cv=none; b=PTR5HXfpPZ2EDr+Yt91rCx9BZlHntzDabdvkNGzt17UbgvkHfTwJ/KXBkavyTl1IERPDQWQ+lil0jPevWuoJw/ZtUV9iEa+2MOOUJo7/SpUxGxg/k2K/YxfwTw/fhKAFL6mnCUY64F3Cj58nYACjRu+CekhyEG1+cJMODU8Kqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754220825; c=relaxed/simple;
	bh=1fnWUuUv0nO826LkM8tZkqenXHt3kBUsyl12muOu1NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ+gHUF4P69nSLFYTT/3IH9DOwUZlUuc/J5EuTWHuHyuVt6jPN3Rb7jgZpKMIr+n8sD7/N0HFhKl12AhkVYGALsrKN+noT7yHpNUW+2DWhBkWVJqZuaECM6q0B8g/2rHkYB7bzpLz3Si+JtnFt2m4PchEx/p+6UOr9+gESK8gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Pbxoh7fM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Pbxoh7fM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754220809; x=1754825609; i=l.s.r@web.de;
	bh=4Klb3iYfjROjZsEulOxZfQuSMPE3XW3mwRgzBbdJmXE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pbxoh7fMU4v1uAmKXAKVgMToet7mx9FLjRH6YxJiODC4kLvOrRWHKrzFNgNs2WgM
	 BBQss14wsMVjXnJ8TVmXy1Kj96HkZ1fVzvTGbyD4OD4cn2RW35wdbQPa7tJgDu3sh
	 Mkcr5iDKoAcaHsRPoHdZ3eSSdZK9AodcPJY3cpjAWYMhDGwNxF8+pnli5oreWt/Zx
	 Ai4/VJgtO+lWsKx08YGUsFArkpH8ehgxiIKDTw2XNJdLJe/fo8W8ibz6dV5z5iE/N
	 Bx2XFcaJAPVLD9FvamqmLsU89FsDPopnyNgsqwHyBD+CtEYtTtRQE4p5/ZJnR8DTi
	 lvYc7iTVoE/az7wHcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1uIat42PxX-00g21f; Sun, 03
 Aug 2025 13:33:29 +0200
Message-ID: <90d4a2c7-70a1-4bf2-85e4-9821b55cdde7@web.de>
Date: Sun, 3 Aug 2025 13:33:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit(),MIME-Version: 1.0
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
 <494e9686-e014-45f8-86d2-8dfcd6630f46@web.de>
 <0d3ddfcc-485e-45cb-28e6-62108e6d5a4d@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0d3ddfcc-485e-45cb-28e6-62108e6d5a4d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Cbj57c0KJX4aS4XoRZzUiP37fNhhqgnbfwghb96yV2lMpWQDmM
 KdsTCBqzRTIPkPk+PmnWo4vmuRTD3tAFFCQkkTX5j8OMjqimGXriNbxgrk59QRAlOoEw1Ig
 O1jAPUSuwwt1RwdauS7vezP8ZeDMArgTPV+EwSL9T2eF1Mb8cWV1EVlzebttzhIKb7WMVdt
 USg6FVH58vErDR/W7Ix2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5y24Hhe518U=;JJ6ru5AjFEuxzhxVcOoApNwTCOs
 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
 bZGa8cN7lVME8ACiGvHo9J0=

On 8/3/25 1:12 PM, Johannes Schindelin wrote:
> Hi Ren=C3=A9,
>=20
> On Fri, 18 Jul 2025, Ren=C3=A9 Scharfe wrote:
>=20
>> Optimize pop_most_recent_commit() by adding the first parent using the
>> more efficient prio_queue_peek() and prio_queue_replace() instead of
>> prio_queue_get() and prio_queue_put().
>>
>> [... clipped ...]
>=20
> I noticed that v2 of this patch not only made it into `next`, but it als=
o
> introduced a commit subject suffix (likely unintended?):
>=20
>   [PATCH v2 3/3] commit: use prio_queue_replace() in pop_most_recent_com=
mit(),MIME-Version: 1.0
>=20
> Maybe that is something you want to look into?

My bad, copy+paste error.  A fixed version made it into master in the
meantime.  Sorry about that, and thanks a lot for correcting it, Junio!

Ren=C3=A9

