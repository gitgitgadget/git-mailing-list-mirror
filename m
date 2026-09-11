Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BA5678ED
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157803; cv=none; b=Lv5xIcrCrCFSOiNm7gRWbtKwrCpySSZDM+NN5HLLhCOaYu/UNQ1OqZJqFzDU8W3/2GNHWl6GeXTXBPQLEV+cJk2u1JM5OHFt2MpSIdYDtf3yBvT2hqFI7XU3OCxHpM44soBpPVLlsu72jq/CYz5OYcqtsJtuKe9U7Tlh/f25pAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157803; c=relaxed/simple;
	bh=oQ+vM0LAHCflYVKdUco9jQSaHvflaBzkT0WhbHvsaJM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iPK/6pOupY3SYgxajQ6Pmt5JiPBafsH8Zpf0UOJ5Rs8sBP3lvRxK6cSN+mtpa9wYjj6EtTaUoL/D5UhLzbaDGBmLgExcdfVJ+BLFkwCzU2yv3JaSae9a6HqkB8IMDLkus5FG+Mz7gZKw6CNAoGriLApemrFsmtKmTNxKQtyJ7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k02++fVy; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k02++fVy"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aaf2ecfso18043d50.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789157801; x=1789762601; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKcK33lXaSy9/MKnfiiN1VkM15461bsCIb4wnbseTL4=;
        b=k02++fVye/Uju4i9VL4vazhG2b3WHHrYkcC5S3UiBflTDmkMOfVi6uBn3Nt1jFZtUw
         lAyIrVTjAeaboGdNj0WmHiadS8b2aagkcLUv0mLCSZOHdllbKufi8m22sO6v0zW9QBc0
         423uyaWlCDEuGYlmycpO8WFEStjwnVFW/otXsWGixniVxM/u/UA0cCAgQKI1mPqvrfWU
         mG3H6sOVUHvVDBqvQTNkMaw7l0SLqdKbgen8t4RcxwgUbvb+mq3smC7BXlJ6+PHD07NF
         P/H1edMIsbtvRx6D6BeKfOSHGWyMoeFJWAYZd7Dsj8xON2Vl/5HHbHCjMqtuTl5qIh3s
         dqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157801; x=1789762601;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKcK33lXaSy9/MKnfiiN1VkM15461bsCIb4wnbseTL4=;
        b=kcz5svej+rgZeOKNVkouw/z/j23AaARfh0zYnFcnFbCYtgoQ4kLeWqHhmNhkDm/0nM
         ycb7GAVYEgHZfncAJksIbYL9s5wPWL5+MuUBdLvgyW6krdgqXvKcgAh0BJ0mMrH9ZucN
         jS4QmafhV44U9G8KaKCOCrSjO3E9quyh361HRcmOxuX9+nQqFCKTY+yxmi/LCGCtP8Xr
         OKVfpgBMuJgf42Tr38E/Txto/KWkU10TUdPhFL+wr51geabySeFB8dN3yC89DBKy2PVf
         Kh/fzboJTIqotEZIuvlsBn5vaJ2jiHjGZhDxmHFVbSdjond3R30Nmj1bz37Dbbh9z1dg
         FImw==
X-Gm-Message-State: AFuF++majxJ3/RvC40mti0fZfXwSwyl5MjtqTpyu2mvqf9HNYxXE8qOX
	tFN8mKu4oX5LOV2RYpxmAuQPXX+sbsejyFeLdoe+SDmdHj/mhMpvQKJLe1GswA==
X-Gm-Gg: AYBFou3z7KeHRHfScFy9NCmcQvlfp5y1nCy962ggldLVjH+b4e58YPlV56nGXi5fBtB
	ftxDupWw5Cr6nTYdwMC1UzNSblea2SeVkd+sEJTP3tSbeD4YYC27vp9+3+yOc62mLILpEwiBNcU
	EJ7vj2cJXplGmZ9R8PIWXC49Nd+dcwYGWqr2E2/sZa3y89UE7bH1yB9Z7FaKMSKbOaCUE8MlduD
	buZ7K3DeOvdAQnsMz/3Sa8G1WBOtmZutGdAzjwCsQTpH6CK2f/1hrArJM9mmSOHrSZXMbncOncN
	CTXSkDRnKSHeRV+VZDz8BDtW4HkHjmbBWOPda73aEysBUietLV2gPUTeUfTmN4zjfQgRxfVXEji
	CB6nD2PDq3M4VSnvO7SigfGziVf2FIkOkjg7gg0NJNDN1rVJDFbuJdI0tqpaInBFIBzt8q4wVHH
	OEY1s7OIheL9SEmjNLwX7XDqcQlQ/k7RIbZnqcnIcgNupFMJV29+84YY2y3oq2rUm9hKnQZiLuy
	P7jaqPdm2FIsAkuGYnpYOCpIuO/BUb6VSyLHDhKyjI3+AC/n7V0xqKrQ6ytbnyR2icNd4GxWq/D
	TT9t8UXMYbcePYsiRkAs4uvjSjmUjIyfKVtG60hfgdah8r+h
X-Received: by 2002:a05:690c:309:b0:882:1d1e:88ca with SMTP id 00721157ae682-887a8d99c79mr466967b3.10.1789157800630;
        Fri, 11 Sep 2026 13:16:40 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:e421:a9cc:a915:2479])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db40f58sm15639437b3.2.2026.09.11.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:16:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 0/3] Convert USE_NSEC to runtime config
Date: Fri, 11 Sep 2026 16:16:28 -0400
Message-Id: <88372951-1938-43D2-88E9-E3E9A2FA2A85@gmail.com>
References: <xmqqwlsrab5f.fsf@gitster.g>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqwlsrab5f.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 11 sept. 2026 =C3=A0 14:35, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> Topic name: dk/use-nsec-runtime (applied)
>>=20
>> Topic summary: Expose USE_NSEC as a runtime configuration, since
>> build-time is too early for distributing Git [1]. As a result, common
>> index-related options, like git-diff, are less likely to hit "racy git"
>> problems on supported filesystems.
>>=20
>> [1]: https://git.github.io/rev_news/2026/07/31/edition-137/
>>=20
>> Built on master (2c78326f81 (The 11th batch, 2026-08-05)).
>>=20
>> Changes in v7:
>>=20
>> =E2=80=A2 documentation typofix
>> =E2=80=A2 I opted not to finagle #ifdefs more [2] nor to add a "safe defa=
ult
>>  when istate->repo is different from the_repository" (replies to [2])
>=20
> These three match exactly what I had when I queued v6, which
> confused me quite a lot.  It turns out that I have already locally
> reworded the log message of [v6 3/3] "comparisions" ;-).
>=20
> Queued.  Thanks.

Right, I should have mentioned you already had this as far as
I knew. This was primarily a nudge for the (in my view?) stale
What=E2=80=99s Cooking status :)=
