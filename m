Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4549285C8D
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137501; cv=none; b=kTZ4vQqZ93LqbkX57EzlRYCVJMR46fHjwa5ZttMzVJOjl8g7LfquObEr4C+RCqlruSLZgBjblCrg/vvxt2wBqUDkACA7KXT8cz3q3k9sN63NIh61NE6thoBCz0HGXzk1lN8VgaqJbuNwOdV/3ahZY+rX+sjklumvfDA+wCTUIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137501; c=relaxed/simple;
	bh=aNhRrgFZ9hUGf9xZVXO9h1ARL2BJ42cbFaPsoKrlyrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMgaxhgnPtg8hb+UIgIVfhHFBZrAHyex6ZsAGCibX2MqkQOCcce98YFHvIs9X1qnqpL5YcrMyKiOzRyQWF8WcK7eUMesri6zvQdsqK/dVoZvgXLJJa+6LNvK67cZw1qA47oO8XYPDaG6BIjXoIkZRRQ8cD1+LoRzQ3l6BKBmjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT0CeKNr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT0CeKNr"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78619d34979so35213547b3.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 18:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762137499; x=1762742299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNhRrgFZ9hUGf9xZVXO9h1ARL2BJ42cbFaPsoKrlyrw=;
        b=DT0CeKNrp/CtudoNqIynkR6iF4ks4iW8nNdrcYWUXYXPPNqlFJGtNSiXua6/9b1FmO
         pHimxPDI4mU2VH2pwatJVSjK2Z8lXL5dxeF/YlzBTJySafl0G1jRIVNH1q+XggXqUVkR
         1Vz6C67/hdX8nwFiSCPUc2TFEkCnB8BpL8Z6O4rMB4EXJ+uBxaBoOaRWEh4LIpMHfyYV
         WZqZKzUZD/8ecAeSHXC+KB98UUNaqMT/gowL2xTzM66p7c6CV7Ox9F54DlFWMiT6j+hD
         YtP3/qFyK+0YkxQUi/k28TnTDvmKoUv1vTFQGCPVh2TF7rtU8hZY8j0B0wpH8hPyotHP
         ZBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762137499; x=1762742299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNhRrgFZ9hUGf9xZVXO9h1ARL2BJ42cbFaPsoKrlyrw=;
        b=oFtuSeALBlVJ7kJnK7vs0IZAJgU0o7+nIxi11QYSo0EjIdBxaD/snCeXDyhyk1rrPz
         aO2SXp2ODe1mX7q1EWo/3dPfUAFKNqXWrQf/gvCOb+Zg+y1XhzvHw9OQ/M65Y36iIM2B
         C++wBQQAcT2ejQQCs8uOSPlbq3vS+3xJ6u5NZgl2loWvYptfxk5N2Eav915XleB1qZkD
         FX2nJ0toB43PGWckZBf2zkhEXAJTw0SAl+46cYiXiqGgZQrkTjlAHhZ+drbDti7GaWmf
         1oZxvOdoOLyW5djt1zK2kP0daIytVMJ7LiFDClwmnr7gNCykCawXO/p6VLLiamha3tTm
         4Y3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgEhmLK14zeSkR4tQUu4FcPaL/foa7HT4LCXJczlXoBiFTSggah7fkq+V7PDQBozRLcRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlgK1vJ8Sij5weLXyMctyZ3VHvXCIHQuezzp93BbPRPmjdLVm
	eIJJcyJO469xs4qtLsV9+2FjyAL3+Mr/nZhJ7HpWBJZiyvKwmmWlEQ2YAPE4B2a7g1dOLe/oByt
	RAh7yVItRx5ueLlCLhl4Eus2uq3WUc6U=
X-Gm-Gg: ASbGncvafq78EVbfBM6kYXQJr0FkUkEJBTOdJozMdIipd5DbV8ehDR9amFnNRxcbwAN
	+mwIWAhBi7YBW6Y56t0m9x/vzCSFRmb4GrF1l7Kimbv94LScdDV/8KKoChRQkQ53VW05c3wpLm6
	TnTUBd14vMlgo43qXBBRLZldMzYXtTqTN2u2B6CO17lUu0u25z3/SUWHE0pcjHl0CVckpCQfqux
	RT2VrH77V2wL3DI5iBGakezOlziQhlQ9e9tovkEflA3x3L5M77utgHtLLjmPYxKeTLQUHKIqOc3
	I66JRYqR3CqwXzmnpbiFFaJXdjegLeZwM/4=
X-Google-Smtp-Source: AGHT+IE6O66EONkZagQ1Yz/246aebIXQnXC8/e4uHaIkfd48DhkMs4TfyjyMn0qsuHzOP6ogg10EVj9gVMb59TKB5oU=
X-Received: by 2002:a05:690c:b94:b0:785:c0a9:9dc3 with SMTP id
 00721157ae682-7864852faa4mr100923457b3.52.1762137498859; Sun, 02 Nov 2025
 18:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
 <01b001dc4c62$04943500$0dbc9f00$@nexbridge.com> <CAB9xhmMzqDUXk4K=p4EW+OybH68WTGBLVW+tPwjO1nTeAtiPZA@mail.gmail.com>
 <CAPx1GvfYyEKNepKWhjr66i0vPm4VVz=J0f=aym7P2uPKueSFhw@mail.gmail.com>
In-Reply-To: <CAPx1GvfYyEKNepKWhjr66i0vPm4VVz=J0f=aym7P2uPKueSFhw@mail.gmail.com>
From: David Bohman <debohman@gmail.com>
Date: Sun, 2 Nov 2025 18:38:08 -0800
X-Gm-Features: AWmQ_bnw7nhZdVwQQ2Oxuu_XCJkDkjXrxk0nB1uXI2R-bwrovy7T1mflC94UFbo
Message-ID: <CAB9xhmNiYv-9UezPguKzY3Q2Cq=ngeNaEi6Dr-B-Ds+s4BuEeA@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: Chris Torek <chris.torek@gmail.com>
Cc: rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 5:53=E2=80=AFPM Chris Torek <chris.torek@gmail.com> =
wrote:
>
> > Okay, but before 2.51, it would fail to move the existing tag but
> > still insert the new tags.
>
> This is a change in behavior, and no doubt due to the new
> reference transaction system: now either all tags get updated,
> or none do.
>
> Which behavior is the buggy one is the real question. :-)
>
> Chris

I believe that this is a risky change for a mature tool like git. It
has the potential to break all sorts of stuff once it starts to be
adopted out into the wild. Also note that the diagnostic messages are
misleading. It flags the moved tag as an error, but reports the new
tags without error and then fails to insert them.

David
