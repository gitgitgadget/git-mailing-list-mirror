Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A634BA42
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972428; cv=none; b=BNHNMJg0JYA9KJPunE0hr2re8xGG+idrMKAPtVaejYDbCzZ4rDazRIumuusEOjh5zSOKX0LKB2PJ3kcb2UWg9nMQCdQB4oRcRz3qC9EeWeVdDY7ZA6GKmMENpOOLjjTeEvDw27GR4b0Ga9RRxtqScCuWH4dHu8GSIyax8dLWEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972428; c=relaxed/simple;
	bh=gRqzL/nnWIYfaXKzOtnLeNPXTee7nWOURYyDtiz+ZIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f2FGQm16teh1QaEtYv8REY4IKqJhzM5XpqWaIlSq8q+5tSErAYiowDn64DM7bjNdit7flzkoc29O39u3jBUgwXOQvjz0UcrnH979a2XmKcBZf8WQIt47HasUkuC4J/pwGnh1NyB0YvObrg19vd7VwEAUSNUMC1B6jSvyXeMN7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TttGuGA3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TttGuGA3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso412392b3a.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 18:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759972426; x=1760577226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf2jSM0UA419PPHBx0vrRG0JoenBGTu8xG8fsTYx9Os=;
        b=TttGuGA30lftVZvxJNofEM//DMDEoOxjq66wYYmpZ+w6O2/yf/TRonyjBAJaQRHUsy
         9Cegh5OpM2rmy6vRzlZDaiNQcuHcttJ4toO9hl8eIDk+ig9o2QavUauQIRKDwnVqJOgX
         +X0OqZ1PQNOMhiQv/dg3Rgu/N1fUksnEnVKitbv9f5NQCTz84xmABOZbQaGeDoYnQa7Z
         IRZz0tcE7VB6gqLOana9C0C4CaF4ugoiPjGZ5cUQB7oi8KkfyFxcZbQN6DmOqxWxPlpN
         TW76SuUMSveyJaQUKCyuzaggEoWkq7LvAB/kGdD+t4ZBl67ffpOAPbemRnEl4b+QO9fJ
         TYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759972426; x=1760577226;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vf2jSM0UA419PPHBx0vrRG0JoenBGTu8xG8fsTYx9Os=;
        b=fluvYPpa9xfiMLlDPmlFkJDXy6H483vE9V7jt0ezwOavwjwpN9PEnAaiq0O2ppq9Md
         gHGe7nhNTGoa4zRc7uxlq1rONJm0cOFx9GnZ3Y5o2YYxBwlpsyJf8QpBhAR+MTGsMrvx
         +T4/CZi/zdXMcwCNDHX//kgCt13OnnqFzXoI3hKzKBye36MuH6oeQ25FcMeGDj80nZW3
         ZMnsXeGpsWd0eqpp/UMpDG0u2G9pVWb+gmaL55iFmD1miE+emtM5vpEbWxiOc2g5mEEE
         MW0Oj9Udc5aewJsqLQPTxTVkaE9/8tfnrYTgi5NWJu+Q15oc37maGOuk4WL89LjnD2ZK
         rfsA==
X-Forwarded-Encrypted: i=1; AJvYcCUedvNcWDM6yVpENJ9ZMAlddVce7M3NiZEjBZ/fVqAMm4OPprONiQjbwfyeLP4aZqUPz+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0DXgc8t2QxzyzqQH9Qd08DXMe6U6P5GUVMS5SOv7fDnPU0GH
	u8zEejmQCzoHb6QFTIwtmYB0H3oul8IOVjQjH2ER6BK5qrCZTHilHJaV
X-Gm-Gg: ASbGncsie6Ceu4H5ERm1nfasdEyex6CDRYDcDHQhjBDwkIyMOHmnaJS2NA/ad4cB3Jf
	GUCHlNkFWIdH6sOwDM8wLAJR1e2Fc7LpvkmrW+Wcmp+TItdWBR4KyI8GNqLC4GMuj6QH8+mEWpB
	Orkn0kY7oYVsck1XahEzjo18BmNImv4NxYAH1s4u9EKhXCPbTEPEeL/qtjm9bIyupVlzSYr26+k
	FzOjRR2qorKXPr1LMU7tG7D+rGkgFequk4rG2AiF2244lbDlds6nLVZg5J9FCN65WwRGTm+4RWH
	o7AbbzmjDwFbW5YQ9jdS1Jz/xF1BnCFoyAv8hp832Za3z0h3jvn9sce4Jbu+r+8+Tf0Wb7nKSsk
	Z6Q3r/Lc8K88iOB/+w5b35/UFt0bZ2kWL0DdoNvc=
X-Google-Smtp-Source: AGHT+IFhB9qq9gj7R5FqFm2YGBVKlbmA5oUj+VlizhH1e/Fg8AHzKRlOUIdYoEewmQ4Unw/rTd58ow==
X-Received: by 2002:a05:6a00:4b01:b0:77f:1550:f3c9 with SMTP id d2e1a72fcca58-793859f34b3mr6725352b3a.12.1759972425618;
        Wed, 08 Oct 2025 18:13:45 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e735])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e1fc9c97sm1017057b3a.62.2025.10.08.18.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:13:45 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren
 <newren@gmail.com>,  git@vger.kernel.org,  Junio C Hamano
 <gitster@pobox.com>,  Taylor Blau <me@ttaylorr.com>,  Rick Sanders
 <rick@sfconservancy.org>,  Git at SFC <git@sfconservancy.org>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
	<CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
	<aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
	<CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
Date: Wed, 08 Oct 2025 18:13:43 -0700
Message-ID: <87cy6wdghk.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Oct 4, 2025 at 12:20=E2=80=AFAM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On 2025-10-03 at 20:48:40, Elijah Newren wrote:
>> > Would this mean that you wanted to ban contributions like d12166d3c8bb
>> > (Merge branch 'en/docfixes', 2023-10-23), available on the list over
>> > at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@g=
mail.com/
>> > ?   We don't need to go theoretical, I've already contributed such a
>> > patch series before -- 2 years ago -- and it was merged.  Granted,
>> > that was entirely documentation, and I called out the usage of AI in
>> > the cover letter, and I manually checked every change (discarding many
>> > of them) and split it into commits on my own, could easily explain any
>> > change and why it was good, etc.  And I was upfront about all of it.
>>
>> I think the main problem here is that we don't know the copyright
>> status of LLM outputs.
>
> It's very unlikely that whatever is decided about the copyright status
> of LLM outputs will fundamentally change copyright law. So for example
> small changes, or changes where a human has been involved a lot, or
> changes that are very specific, and so on, are very likely acceptable.

The issue is lack of law, from my understanding. There has been zero
political will in the US for copyright legislation with respect to the
output of AI. Therefore, we are left with case law that is still
ongoing, that is, no precedent.

>> I remember the SCO situation with Linux and how it really created a lot
>> of uncertainty with Linux because SCO created FUD around Linux licensing
>> and how that led to the DCO being created.  I am aware of the fact that
>> many open source contributors are very unhappy that their code has been
>> used to train LLMs without retaining credits and copyright notices or
>> honouring the license terms[2].
>
> I don't think it's very relevant for your position on this. On the
> contrary, if LLMs have been trained mostly with open source code, then
> if they produce copyrighted output, that output is more likely to be
> compatible with the GPL. It has even been suggested (and discussed in
> this thread) that some AIs should be trained only with open source
> material (for example MIT licensed material?) so that we could stop
> worrying about including it. If that happens, there would be no reason
> to outright ban AI generated content, right?

Not all open source code is compatible with other open source code. If
you use the output of a model trained on GPLv3+ code in a GPLv2-only
project, then the creator of the GPLv3+ code could claim that you
violated the license since they are not compatible. Whether they would
win in court or not, I have no clue, but it is probably best to avoid
that situation.

Collin
