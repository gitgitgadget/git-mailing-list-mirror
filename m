Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526C2264B5
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754337400; cv=none; b=DZ52+pb41oCgffAO543u9kdqh/8mnnfC1350kJXKZ/nvHjq19GeiEZnhBcK41vfOSXIaTn6PtlyAddicZl6LR/+gnt4Xyk1ctaPt1WoElhPNZrcvDcFPhXZ8RYGFfOgVZRShtG1kZo2QtNeftD/5VwxSOPxR+NkRUR2BG42vNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754337400; c=relaxed/simple;
	bh=u1AFFNVr0cvqzLfCwW3j1mPuh32xk9r8qv6e6I4ZAPA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qh6X+1y/1ndMevPkr/FU2shLBJPrNJCffU7nB5kEDLYDMGYNOT3AptQrsQTOIKgTR73j+gjcSum0XTbvKWbWa1mev4oW9lmKImFn0je3zwzf9vyCTmh9XmxUTFbG/kjRzxURgbWK1RwQjWy9Ry/4j0/7u0bZSYw3IXUEw+zRsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BxeRgBjV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BxeRgBjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754337388; x=1754942188; i=l.s.r@web.de;
	bh=5pIV/T8CTzOlJP4uXH9jrUfvhO0I9kP561Gwl4zTFW0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BxeRgBjVaGHNFj/Fvg5lGvuHkj0SAcNyY4oOX6175jMQUN0RTEFavjIbSjIFe6oj
	 wqgTaYUTu9s0eM9nqDS5JyXHPwSQ4GhbFZ/meN0C9d3wEQxWQFERaANhXsoYq3S8z
	 xzWAMGyZQnCtZamOkFjcfMw8YkTwCtTiq2wpiF76IEkTOS6LNfy1FZjQ6SNe1ZwrG
	 3223x6ORJpnBATiDlvuntGANWzn1FcueyDEONfFnZZbpmYO3gIulM1GkD1dvf0i3K
	 T0zU85CWrLEi5UU7gQQqSz9eIhMGI5Evn3PRpa4CsrYnUFD/V6NB8EjVyse3lSZ9g
	 WzAqzkV8saW537D94w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1uJ4Wt1oix-00a3Mg; Mon, 04
 Aug 2025 21:56:28 +0200
Message-ID: <a35aae22-da05-4098-88d0-f8dcb50a9a0f@web.de>
Date: Mon, 4 Aug 2025 21:56:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>, Git List <git@vger.kernel.org>,
 Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
 <5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
 <148541F5-DC9F-4A3A-B1B1-0FED8AA5A101@gmail.com>
 <c5d91cec-3fec-422e-86d4-78767d95f208@web.de> <xmqqtt2oe4gi.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtt2oe4gi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kJzCSmlpIAPSpVb+JgKfjUtvOhZH8rvaPN3cfk1aVDGOGLtE03Z
 DRTW1bCHPwYRv+npB+d00XAbD0H6aOvwBD3YEf9G0lembwbgGPOA8xxnDe9q8k04rotAyFk
 F0oGs//EWP7WDg89nbPYJdHVsHv92rGz3OHeewUEBAmoaMSgKtdU1CUMgRiArr6NIZf/zCQ
 qPEs+8I1ifg3xrpxOc43w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tymgbjHQIuY=;b6Z/Vs5zkFF+nC1kNag9LaU8kCS
 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
 7uM/KHZ7Wg/Y/CVyvPCEMhY=

On 8/3/25 6:48 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> We add and retrieve each commit in the (relevant part of) history.  Tha=
t
>> takes O(N) and O(1) for the sorted list, and O(log N) and O(log N) for
>> the prio_queue, where N is the length of the list.
>>
>> So the best-case history is a string of single-parent commits, keeping
>> only a single item on the list/queue throughout.  That requires no
>> sorting or heaping, making the additions and retrievals O(1).  The
>> overall complexity is then O(N) for both variants, N being the number
>> of commits in the history.
>>
>> Worst-case history might be a single merge of all commits -- a
>> centipede or myriapod?  With all commits on the sorted list we get a
>> complexity of O(N=C2=B2) for the traversal, and O(N log N) with a prio_=
queue.
>=20
> In other words, for a typical two-parent merge, we peek the current
> one, "replace" it with its first parent and then do the usual "put
> and sift it down into place" for the second one. =20
>=20
> I am wondering if there is a more optimization opportunity if we
> allowed "put more than one, and then sift all of them down into
> place".  In other words, if I told the machinery:
>=20
>     I am doing this put.  I promise I won't do get until I say "now
>     I'll start doing get's, so you are free to delay your internal
>     state maintenance and do so immediately before my next 'get'".
>=20
> and did such put's a few times before I do a 'get', would there be a
> way to teach the machinery to take advantage of the promise?

Well, we could reestablish the heap at a cost of O(N), which only pays
off if it's less than the O(P log N) needed for regular puts of P
parents, with N being the number of queue elements.  This starts to
lose once queues become too long -- just when an optimization would be
most welcome.  So it seems impractical.

We could replace our binary heap with an algorithm that has O(1)
inserts, like a pairing heap, though.

Ren=C3=A9

