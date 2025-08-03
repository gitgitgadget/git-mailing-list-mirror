Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9625A341
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219550; cv=none; b=ieAl+/xgb1AK7f2rSLOtdyo/ovFECJuO8/fOvXIMYxST9QSRNTeMU8LoOt3hHroEnc1KD7RWGhV7WC9Vx0gxC8nbc62dVslluwkS/q+BYyXI0tKW3C4Q5dL6JyJ7XA4OkE1KcpbB2VcLDPvU6sf3V9Z/U/15TPrz/AoiP8O9P1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219550; c=relaxed/simple;
	bh=VfFemjNzrdhZm1Q6bqWuLzrKTThZwnl3HtkJ7AENzXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KsQhz481XMbR3axv8/auiyZNyANCfO1es3s2XAE9RhvcehKLWrOIlS2c/VYCY9XXKBMqmsdsGg+oP3XVqG/5pZqRkD+zdGrBGdzMyFsqchDv5oimBLRk7mNyvRY3cSdO/pyF2iNCD0x/UnPJt9vbmGkemsf3Ynfnp0TimrUic9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=RSA8+jto; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="RSA8+jto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754219538; x=1754824338;
	i=johannes.schindelin@gmx.de;
	bh=+77X6usejgWmYBu2+Jp7s5LuMnx3whtlnXjbZdK2LVw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RSA8+jtoLLsd0PHQDq/Z/F1C+Sw/9VJ53LYWDeEHeThdwuzAvRaTn6bh2T/y2m00
	 d0wKDdedSPZ8BS1j+u2ra8KGxSwVaqRRLXWda3P55g/PpiWbfeiz6eBFz2ULclvht
	 LrMkAEL4mqaQTFyQjN1DMup30NSJ6KajNyFJYxPIq5bXIMYHGFFq9IomdBIHyTfCf
	 roPloTIlZyPg6z7OHHVti8O7wHpYDWgFT9mR3NnrfO1dVtkhR7V1mvla61lwOaIVp
	 3a13p4GLCu5FmW4YPLTOw+E9ngMe058xokh1NmAe0HiG5Rclpe6den96aTnbzquyo
	 C3z32tNljiGCLM12xQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([87.140.57.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1uoLXN0lxb-005Uh0; Sun, 03
 Aug 2025 13:12:18 +0200
Date: Sun, 3 Aug 2025 13:12:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>, 
    Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit(),MIME-Version: 1.0
In-Reply-To: <494e9686-e014-45f8-86d2-8dfcd6630f46@web.de>
Message-ID: <0d3ddfcc-485e-45cb-28e6-62108e6d5a4d@gmx.de>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de> <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de> <494e9686-e014-45f8-86d2-8dfcd6630f46@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-455158330-1754219538=:3405"
X-Provags-ID: V03:K1:M7LRZQcjQYuEv85QAd+ez4BvZAP/jdyqMu35ko4cuRfCg3LV7fD
 EUsAhZ1qoaWW6pu/CiIiTHbLPWO2tVHb9KyoLLJZHo/9No7jxKxKkIpI+tlcd9IdxpRB0qi
 a7ZygJ5tiPcpvbaPE4Ej2ajxLlMGjgDUrLGHrYo2dAT9+nuQBBvX4SpA1L+ysH9cRaB9zC6
 VYbkqyoesjydky9ZYz05w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yS56umMaIaI=;GYVdN/AP8EETOr2LWHFTw0AgixT
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-455158330-1754219538=:3405
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Fri, 18 Jul 2025, Ren=C3=A9 Scharfe wrote:

> Optimize pop_most_recent_commit() by adding the first parent using the
> more efficient prio_queue_peek() and prio_queue_replace() instead of
> prio_queue_get() and prio_queue_put().
>=20
> [... clipped ...]

I noticed that v2 of this patch not only made it into `next`, but it also
introduced a commit subject suffix (likely unintended?):

  [PATCH v2 3/3] commit: use prio_queue_replace() in pop_most_recent_commi=
t(),MIME-Version: 1.0

Maybe that is something you want to look into?

Ciao,
Johannes

--8323328-455158330-1754219538=:3405--
